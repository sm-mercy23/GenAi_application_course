import os;
import base64;
import from byllm.types {Image, Video, Text}
import from mcp_client {list_mcp_tools, call_mcp_tool as use_mcp_tool}

with infer {
    has response: str;
}

with infer entry {
    take init_router;
    take route;
    take chat;
    report {"response": self.response};
}

with ImageChat {
    can chat {
        if self.file_path {
            with open(self.file_path, "rb") as f {
                img_data = base64.b64encode(f.read()).decode('utf-8');
            img = Image(data=img_data);
            self.response = here.respond_with_image(img=img, text=Text(self.message), chat_history=self.chat_history);
        } else {
            self.response = "No image file uploaded. Please upload an image.";
        }
    }
}

with VideoChat {
    can chat {
        if self.file_path {
            with open(self.file_path, "rb") as f {
                video_data = base64.b64encode(f.read()).decode('utf-8');
            video = Video(data=video_data);
            self.response = here.respond_with_video(video=video, text=Text(self.message), chat_history=self.chat_history);
        } else {
            self.response = "No video file uploaded. Please upload a video.";
        }
    }
}

with RagChat {
    can chat {
        self.response = here.respond(message=self.message, chat_history=self.chat_history);
    }
}

with QAChat {
    can chat {
        self.response = here.respond(message=self.message, chat_history=self.chat_history);
    }
}

with upload_file {
    can save_doc {
        file_path = f"uploads/{self.session_id}/{self.file_name}";
        os.makedirs(os.path.dirname(file_path), exist_ok=True);
        with open(file_path, "wb") as f {
            f.write(base64.b64decode(self.file_data));
        rag_engine.add_file(file_path);
        report {"file_path": file_path};
    }
}
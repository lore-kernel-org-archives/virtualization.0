Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F6377A93
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852722; cv=none; b=bwo4hLfEALy1bLejQctLP0To36t1272uJIqOtqjFHZyjn85R6k6W84NxJyaOkFZJM+TBBDsLwwssh7VR8pjzv/3Frkpi91F6RRULradduCBUIQY7riZYlPMzO6N1UxjA0DTaRsOgWwvHOaWH9Ewx1nppLWwcRi5yjInu2u8TNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852722; c=relaxed/simple;
	bh=lqdZGDTB4L0Ao1dxI8JkrdZ9qxvRDQT85KWSJ1iE+pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LmBvFb2lNqeVfs0+1t/eM8PBbNvjAGO2s3LuKPsc9gxdCVwA0uPwzcs+KtZBXJ6AuRrIZmDWWKSf3nyIuM5KgzdvzMZRnFb4/eIH+3q3+dDN7Rkw93hG3pmGxOCKnXUZX+1tdfZvlhBW6s/PQnByLXzseTRGWjxNdXF5oSeZTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhmim3Vx; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhmim3Vx"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so3470075a91.2
        for <virtualization@lists.linux.dev>; Tue, 08 Sep 2026 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788852720; x=1789457520; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/czle5egijXcWYNpVpE/ZR2lQD0b3NyL5+H5JuNtgXU=;
        b=bhmim3VxQtt8G+Ud91WToF5+GGM7kFSlrulDPChSfXhWuJJiWgOpilq77bpwlLLGlc
         1ftNoBwHhk/M4xP7meL0ih7vdPf/sdNM/uYBy7brliRXmNQHGFtLn1NBUwSBRe4PXapy
         8P9rkWolAS8UnpUNfvSRLds9SC6nLra3theTkq6xKi2rkcrDQizcCXWH6g0qlNaE6VCW
         Y09adpK/bDZRX4XhvADjVcqLV3pa8T5Ps824i+f00V0AqXpSk69e5Iu2PdMKZBSubWfn
         17XFV0qxi0l2H8woJWrpkPwJ671cZaHYyafkRNN+eE1W7fj8SDJDduwb2j9F7wGawGOo
         soSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788852720; x=1789457520;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/czle5egijXcWYNpVpE/ZR2lQD0b3NyL5+H5JuNtgXU=;
        b=XmgsSQwaGj9vqG+oU42s0LIi62qn5vawvLceyW4POVBxawlb4bL/FtLmgvWSpD0WMh
         Xvu6p1Ud2SLQ2BTZ1jKRBa+VskAM5gFRBu/rfo39ez847N+uuCkEpTFZj+aQ2fTgBddE
         BL6yKWFRb6D5hy2lXro3Qw/l3l/xa1DEUAcOkvhK/YqI4falgBg2WOBGwZZvvYoEzCA+
         00FzFhCIdyw2cM4YZGjxjThnctDr4cbLs3zSavy9g1IT2DcNxFKSYxx7Qa7jsEmVLMHv
         loSSft/O1CKpemnrbt6He2RUL66FPbJ2x3vlc9u752W+cA5PIQJ9cE/B/dFF3v7Tmf05
         bSvg==
X-Gm-Message-State: AFuF++mUjW2G+hJzrrnBeKYF0Qkngv/oProkKdIggjpiMw6T20xL3wGw
	5V+OSRPxy9kBSmyKUBG8KrGUuvJI9KrfB9RpYCw7kkUiFEXCxaMp4S7vEQgtoENW
X-Gm-Gg: AYBFou30LTDQzTyFPFtwYz2MF7LJtyrJ6L1VCnudtE9kFRLW2GKCR67hYegCFkhfqVi
	oabL03dkGTq85pQuFzBrVMdUXw/n82Bjh5g2fkk7w6IrsURzIUSNK6ufGQqx4caXKrdnZRGuUmv
	HuX30Mi04pSh3Qw1XEoLshojNDmztIOzfECi8JWAITc6fs9MwUbb8upr/AFq+2DI6tOZMt6Df+F
	EnroUR1hTcxcC0ZM0Hx2uDJPSyq2DtJKn+iuTar5RbEwke7FHnVNQZP9xoO7c7aM7zBT3zOZlCi
	9qYUi/T396JhgnYiuFajW2PkHxt1rjveR/xcAUJRbeH+LlpSnyspTGw76bAF0nz/wOFNHsgF2x2
	W27oaFCyUuYF4ouvV4rMCEp5TsZpJ/cdNprMMeXC5oCV/K6rfpMIu784dPkUFkMr/RQktjh51em
	fqRXeU42X36rbkNZIFCdg00wjqdVhNDArcgKO695sOBP9fBde0qplQfmjRLOZq8kP9GAW2EG76
X-Received: by 2002:a17:90b:1b05:b0:398:9bd1:3210 with SMTP id 98e67ed59e1d1-39b262a89d4mr37624902a91.17.1788852719900;
        Tue, 08 Sep 2026 00:31:59 -0700 (PDT)
Received: from [192.168.66.6] ([218.108.80.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae62bd7acsm10916555a91.1.2026.09.08.00.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 00:31:59 -0700 (PDT)
From: Linfeng Sun <linfeng.sun.dev@gmail.com>
Date: Tue, 08 Sep 2026 15:31:51 +0800
Subject: [PATCH] vduse: return compat ioctl results directly
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fix-vduse_dev_compat_ioctl-v1-1-62264d9bfb8d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMBBF0a2U+TYQg63WrUgJTfLUEW1KJg1C6
 d6N+nngclcSJIbQuVkpobBwnCr2u4b8fZxuUByqyWjT6V6f1JXfqoRFYAOK9fE1j9ly9PmpOhM
 Oum2PzqGnOpgTav2bX4a/ZXEP+Pw90rZ9AEwv5tB+AAAA
X-Change-ID: 20260908-fix-vduse_dev_compat_ioctl-62d40557bbe9
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Linfeng Sun <linfeng.sun.dev@gmail.com>
X-Mailer: b4 0.16.0

The compat handler handles VDUSE_IOTLB_GET_FD and VDUSE_VQ_GET_INFO, but
then calls the native handler. Their different command sizes make native
dispatch return -ENOIOCTLCMD.

For GET_FD, this overwrites receive_fd()'s return value after the
descriptor is installed, leaking one fd per call. Return handled compat
results directly and use native dispatch only for other commands.

Fixes: 455a2a1af926 ("vduse: fix compat handling for VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO")
Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 4dea4d6a3855..49a231bdf948 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1882,11 +1882,11 @@ static long vduse_dev_compat_ioctl(struct file *file, unsigned int cmd,
 		break;
 	}
 	default:
-		ret = -ENOIOCTLCMD;
-		break;
+		return vduse_dev_ioctl(file, cmd,
+				       (unsigned long)compat_ptr(arg));
 	}
 
-	return vduse_dev_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
+	return ret;
 }
 #else
 #define vduse_dev_compat_ioctl compat_ptr_ioctl

---
base-commit: d7808b37da0a619cf1fa541c2384e783fecc2480

Best regards,
-- 
Linfeng Sun <linfeng.sun.dev@gmail.com>


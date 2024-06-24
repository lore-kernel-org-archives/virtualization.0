Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640512FB2D
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219918; cv=none; b=BLygJOvATsK+WaUa+LSevNpDTqDjwxNXB2f3cTcru3p2Ayqs13ZvNyyMEnxsHUJUQJVKXnaWjQhdsgMrEKPZxTtFJggDaszKsm9ik3KJhPkEbfFMiIo+D18FYIEMm84KnmQH3Z+7CWoxc8k3M3lIlOYToc/T7T+jsOOlxaUBLt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219918; c=relaxed/simple;
	bh=xFIbcGBM81RayCAY8ByT6/C2V2OBiobl5QMcWCpjG8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dN7l1YDIX+fTd1CCqlQ7AHVzxZdWBr5a7bikYsV9vWszzS67kCkK95q6CjGoO15zPeYHcBg1ggTfAUUXL9LYO7UV6l7p9HdlSMaMOSy18nq8uw+fQrUtNdcVDpwm31VAvFT4ClL7a5GTV2bn8YsluK1YIIFbrM0zpwOdMVCj270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=c3AzEXNU; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="c3AzEXNU"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso23860021fa.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219915; x=1719824715; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMfWapA/eVt/cHgSxWLP2bikTqlCVy2iq5rnnyYeCLk=;
        b=c3AzEXNUwjQ8TPpIPbfedvJ9g5PIohd8pXdM/Pq201uSPjGKI6UR0uLJbC4jbL/V4B
         uQoGQGvB+3/Oh3yWaSMlB9Zdti9XPN2TMycOzk72ZU0+r7SWxbp6L70horVH5X0CiRE6
         gTNBaS73t1BYKAtItomFl0CBj1jIYAVkz+ZzP62PqYgvhsbHzmadqFGRCKOvIKh9WQGp
         3jl87hfqOtv/pmIE2rrww8yHVajQsC4hSRp0GSyvFlns1uKk1+LhPeFO+EQB/E24TXma
         WKi61B8emM/z5pALiiI48Mfevc7/7SW4UMQZNkFY6FVdqzD1njVgCJ/B6bQO3PjbLwKD
         0T4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219915; x=1719824715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMfWapA/eVt/cHgSxWLP2bikTqlCVy2iq5rnnyYeCLk=;
        b=irt5EC8BXTZNqk7kosfzUfMkZz0Vr3ZyA732Vj5RXr9mMiRVyAB5raUi8TMIZXITt7
         mwLuxyLsUPPP2duidjFrvIjBs/p1YojUWeA3pb1G3i07x4TBoSRBQXSJ2mcVPh5eXOaf
         E7uhCkQSNnc+QFQlv1r2ulS8ZMdUU9O1K+v/u/qLwgEfJMh90vreGQ2iq0qWikVI7Vaa
         b2D3VXCLB1bbvhVbPXhMzT3mAK8BqSYpEiuRDOwUoajxDinodTsQYFc5NIl7Zibf6MOW
         0Gk1OXNM4b5k/0sQaYRGCw4FVNOCLQ44/PPSA9zplc6nExKopI/OQhj+pUknU3JWnJEu
         LpJw==
X-Gm-Message-State: AOJu0YxzjG6s3v40d/3dceTg2oWdr8lM8Ub68hc+HRfT8+7z92m0Xn+e
	LkfBAjIJLAiDhG+d2oGh2Miqus4ACI95BGFvIvgc4zKvAhbnhxiXAahplTWK+Jwx65r1KQIdxDP
	N/cc=
X-Google-Smtp-Source: AGHT+IGHoivxCirFrEXq8wSx3eXnwhDi9SynY7Z5ehX8jwF1hGV+hkJHJhStfrtgUwQCQVbVOPL8fg==
X-Received: by 2002:a2e:7805:0:b0:2ec:5073:5814 with SMTP id 38308e7fff4ca-2ec5b2fd2f3mr32142141fa.8.1719219915240;
        Mon, 24 Jun 2024 02:05:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b62basm168955135e9.8.2024.06.24.02.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:14 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 6/8] virtio_pci_modern: pass cmd as an identification token
Date: Mon, 24 Jun 2024 11:04:49 +0200
Message-ID: <20240624090451.2683976-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In preparation to asynchronous admin queue processing, pass cmd pointer
as a data arg to virtqueue_add_sgs().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_modern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 41aa97e338ac..b4041e541fc3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -59,7 +59,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
 				    struct scatterlist **sgs,
 				    unsigned int out_num,
 				    unsigned int in_num,
-				    void *data)
+				    struct virtio_admin_cmd *cmd)
 {
 	struct virtqueue *vq;
 	int ret, len;
@@ -73,7 +73,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
 	    !((1ULL << opcode) & admin_vq->supported_cmds))
 		return -EOPNOTSUPP;
 
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, data, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
 	if (ret < 0)
 		return -EIO;
 
@@ -141,7 +141,7 @@ int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 	mutex_lock(&vp_dev->admin_vq.cmd_lock);
 	ret = virtqueue_exec_admin_cmd(vp_dev, &vp_dev->admin_vq,
 				       le16_to_cpu(cmd->opcode),
-				       sgs, out_num, in_num, sgs);
+				       sgs, out_num, in_num, cmd);
 	mutex_unlock(&vp_dev->admin_vq.cmd_lock);
 
 	if (ret) {
-- 
2.45.1


Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9F18C330
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376648; cv=none; b=obwwzG0Z3etvOxP1q1uG6fpDiuoTZ+OKmuZHOffcaC3D09zIqgVWxSuxVZRQiqxFYGA+FhIyTwXzx+vgGlIaTFqpl543V3xit15MSW8ZTEczYWA3sBqWRih+pclvRV9oCXDuThcbLETp6KkCnl4yu3CUmY941NyBjLledUTS/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376648; c=relaxed/simple;
	bh=I5Ej9tXxsELnQaLpNn7Un8jHm6ABGkNJE4SsL33oa8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBA8jySjhKdcp+X0apqciCw0dPKbztBQeH2p0/16q/BAABnFWyi2S2atniA9pTk80bPpd2pvJKP1WDowzDV9V5Pk/eXAx4J6NcIBZc0wU3Yz8lHk3PPyvtzc/+5pixe2DLWAgifN1Z1T2AjZV8J84lbpg2yOF+TMv51+TrAI9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HG7/5GNb; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HG7/5GNb"
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 642613FE20
	for <virtualization@lists.linux.dev>; Tue,  3 Sep 2024 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725376645;
	bh=8g+CuHEOVaIi/oyMU4FT/dyfPKPOx4hjrvyEeKrnVIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HG7/5GNbDUmiyyRzW2SN6AoT/es/4rYyz5X5EnTFZbEKGbXE6o7QbjoFhx125lB8r
	 bJsVya2OF0F4hwMChufY16gRclm3zOaXYpRmg6Em/X7ATKCHIqbVYQxC/e1dOIRc87
	 zt3YFd6ehlrwNeLWa6kHprL3rMFkTDUKaQR48lKT80pwYWhBGikdTkElEjMK7NHjKY
	 uwuNKdDbFkuM3JAgG0d3JpMovM0bB+AwzOu3WmslxdEVapAILanKsdbRdoEnBBFejj
	 PPA2NuWszzgnbIyegRVTxdysUUoxeOQQLlP7eh0/NqvwNYPDM+fvBDUCBkNRDNeiw5
	 q0EltV9i7ORTA==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5334824e68dso1126395e87.3
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 08:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725376644; x=1725981444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8g+CuHEOVaIi/oyMU4FT/dyfPKPOx4hjrvyEeKrnVIU=;
        b=XR+b4pMsZ+59AYA5YGzX8nxz1dMII4UAKbFljIIur7qaQeXj1cwMGh/Jz5VcEYNPPV
         x7fbhJ3io1mzUCOeY79n5CVqzypX2CH/NtcggxWwJ/pZTPBSHlP/PfsW4ap36oVu2kcU
         dTa3homehywRgoAqcjzmtCMs/MhymE7bjYQ3/K5O3xFBKXgKAHGbDa9YE4XMS+2oYA2C
         fYA6+JF/SjZhOBmQbXKuXLRFgwAhh2BkW1GCkf6SempUVZxGr/iK3WTcbQAk6PYe04ZQ
         CcnhsrWTDmOzwyoe5/pe5XqGSQiziiaS6pZHffQOxmQaauzoAF80KW4HcM7eS19h9VEC
         rXcA==
X-Forwarded-Encrypted: i=1; AJvYcCVKPaRAwvQ1lNu7nrbnguiAhQTzuv3t9R5Ex801Zf9FFCyK0u8IT/URwpoq4dl+IlHVOfXd666fOBFamVo+OQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0va0zR8/SAC+CZc/tiBZd9jj/WmCmtyaOv8WQRrUFOMqzF6nH
	PfWIkdRqBzK/0WZEdPFcmz/e8wLqg2FqQvZJczaXtp8Sy3dAXBnHmiBKZnCeoGu88KR4UEieQIP
	88GkO7x+mrgbTxGNJVTn2hdKgUGlFXO2875oONiVA42pZZ1l/b4K81tRkCb4iIWGSY4AWxR6D4W
	54ksKg
X-Received: by 2002:a05:6512:3ca3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-53546b2b5e7mr8720714e87.31.1725376643662;
        Tue, 03 Sep 2024 08:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+bq1GZV9X9d7kfysJWIp+YqAiYHgnriynd3aEYFL4ojAqTYw0oKyoeFn1hFPXtYAGSanyXw==
X-Received: by 2002:a05:6512:3ca3:b0:52c:def3:44b with SMTP id 2adb3069b0e04-53546b2b5e7mr8720683e87.31.1725376643137;
        Tue, 03 Sep 2024 08:17:23 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a19afb108sm156377166b.223.2024.09.03.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:17:22 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	stgraber@stgraber.org,
	linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 15/15] fs/fuse/virtio_fs: allow idmapped mounts
Date: Tue,  3 Sep 2024 17:16:26 +0200
Message-Id: <20240903151626.264609-16-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow idmapped mounts for virtiofs.
It's absolutely safe as for virtiofs we have the same
feature negotiation mechanism as for classical fuse
filesystems. This does not affect any existing
setups anyhow.

virtiofsd support:
https://gitlab.com/virtio-fs/virtiofsd/-/merge_requests/245

Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
	- this commit added
---
 fs/fuse/virtio_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dd5260141615..7e5bbaef6f76 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1628,6 +1628,7 @@ static struct file_system_type virtio_fs_type = {
 	.name		= "virtiofs",
 	.init_fs_context = virtio_fs_init_fs_context,
 	.kill_sb	= virtio_kill_sb,
+	.fs_flags	= FS_ALLOW_IDMAP,
 };
 
 static int virtio_fs_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
-- 
2.34.1


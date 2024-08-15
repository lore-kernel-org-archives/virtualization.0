Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293602139D3
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723713915; cv=none; b=eos+b/cYXeUnZEA2iAaEp/oq2kdMDttdiqKks8VPNW9cpKLqbeskoDqiSx/CGNUxkcJ4jWPXrR5xAq9tVM4qCIxDiuuvL3RIPZ8mdAJBOr1V8HD7IJW8udecTkQuT3mComerwDLOlecJPm3pjeYJI1N6+B2dwjV3KSrsI2DfAQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723713915; c=relaxed/simple;
	bh=ymy9AdLU4FnRhhiUnMjD0ZbEgyL+Q2k8uHDQ8UA+HNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdzEqN2tjqZ4Rd83ppMkIxAvPFLltu84WcbqtL6J7hZHsfGE1qKRHX1tbdoU5i43bczASw8MjGalk7SiFK7rxokrt6SWO6mQv26Y0P9odCRDeGVYJBHrl9Dhyveo4/aqwnw+sYG9wTV0tIJYCmUp7i8aOZTgsOs0Cw/sCf2Q63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ORm2gGoD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ORm2gGoD"
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89B23400B0
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723713912;
	bh=mjFOlrsdA+rODkwJYHT/kVKlqhDJvVibiu+JqNMSC1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=ORm2gGoDL4V40CyxZRLO/AO48sGW16oz+oWNDdjw8iC/FvkJZsYU3eLZRNUOPUcoX
	 mNB5dXFMwjDWEb6Wkp7Nkb4cn+CkkExSjoZ5iOkNN/oApNI9B1EhxiKX5EjVGdrUCm
	 j4ON28VAam68el/G82rUir6fYK6RX6IgVTVz24W0LF5tg7Ntgkt6WLkWR42uu+2xyF
	 5rgbpd6YQwdk3x4ZZKQsf1XgOTxvyfv0l+20wMNx+8nS7IHg4KpqhQrpXFtd7d/ZQW
	 HhG/KGYLy42ia5VluUyPnWnbo1492Wo48Nw6+UsQ2ddNYxID26CMXauBcZpeenRwvZ
	 Z/OZIvz+/0G3w==
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52eff5a4faaso738547e87.3
        for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 02:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723713912; x=1724318712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjFOlrsdA+rODkwJYHT/kVKlqhDJvVibiu+JqNMSC1g=;
        b=TPQzck5d6MoIpAWXDQWWm7vaR081S3aZxKzaBiDQZQ614XBqMkVVumMp4IN68AQcGr
         4n/Bi3a7CXLmVX0J0Fz7wi/gTLSysDF/i8OJsh3ZfsM9De/DtOsZvI6hiQbUy9x0SWpy
         +PKiNNwM86bDTNAo9EXYBSzf+QlTuCSCoXnEa3gTerZwLvdLofs2rQVLG8MmNqeNIlTe
         ERNVvjRcB2wqXkYE9T0aOXSIXZyegw58qRni4iAKUMvjUUQ0pbhVmQWTrLRzU2i7Gxjt
         rLrPi/chgYp1YKdoJJPNMGT8Inz+bf/XOr/ePRHdAjn1UZKaNGO5n6sXmQNkqk3hspmE
         nOHA==
X-Forwarded-Encrypted: i=1; AJvYcCWWfUsMNgRPp9aHmX+k95EoKYN60jJ0P4gOYHlx9Mt8e6imfwOT7xSz2raM9QF9HmtuDjfvSrEYf2zjptd9CabrFb+6YrIX0549sCooj/c=
X-Gm-Message-State: AOJu0YwEKVgHF44hNfy/KyZO0VsKslBT3jqAlfW/5lDh0b5JFxSpIrYc
	QtZ8VOQCaf8RZdw44X6D4nsOojV88jSb3t9BGhhJ5lgFtEvtCDa32fvBNSkfMQHNamT491nLS/a
	FsRQ1qCVKHizxfs6Do7bBPzFcOM0hMKAY6i9IVw7D00lyn0rhe3RcTzUCLsCiYdTp1bz9URASBv
	5fPTFM
X-Received: by 2002:a05:6512:3c8a:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-532edbade41mr3498332e87.41.1723713911625;
        Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXVHcom9bqqi9GSeZiOw88lrHGMwV+yLO4NjQtn8iMbKuCv4yuzR2v2cJk7x7ywlGr+9KTSQ==
X-Received: by 2002:a05:6512:3c8a:b0:52f:2adf:d445 with SMTP id 2adb3069b0e04-532edbade41mr3498304e87.41.1723713911159;
        Thu, 15 Aug 2024 02:25:11 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934585sm72142866b.107.2024.08.15.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 02:25:10 -0700 (PDT)
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
Subject: [PATCH v3 11/11] fs/fuse/virtio_fs: allow idmapped mounts
Date: Thu, 15 Aug 2024 11:24:28 +0200
Message-Id: <20240815092429.103356-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240815092429.103356-1-aleksandr.mikhalitsyn@canonical.com>
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


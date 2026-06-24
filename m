Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15A43BADAA
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310137; cv=none; b=Zg2MAZKdGs1oIm4yrdG8h5+CGUDgkFKNc7OBU4h+/7HzoLlidUnWbw1orB+uCkuahbz9O0FTq2KVnHr8gT6viJj/pfFk1kmWvH6BImDQ/S0iiVEipznMvqLiGQq3+jrRLzltjZWkzBcYUXWLs/CPYroaqWY7+vQDHqekAZn3TRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310137; c=relaxed/simple;
	bh=iJ0nXXEBO/MOSBmfVwMD5Gb1+SrNTM5Q603UKVWvAcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDSo6G/1TVksKsCfp5ueWu5qlFaEE4z0SxsN2nv8VM6jp2MJi10EZ56a/bXmBx4cZ79V0hAzvPl8L7QOYP+F8lzSRcC0Agwg5fXmeyueEgfLa3iSM4kaeD4V0o2mf5BwBMECkZIphnVNt+tJPnNoiI3fCpfqJLFECcWqnlGLnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=oWQ5W+62; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="oWQ5W+62"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso11963135e9.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 07:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1782310133; x=1782914933; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzlXEJV0FcXuNIk6GbdUEWcGLXrLvl7ADJNJs6ZuJv0=;
        b=oWQ5W+626zmoFlmDwPSr5/Ly9NX0tSWSefAcITye5d/EKPGguayDgs6wwVULx0redU
         JSYe+Q98EfvJ8Xxp2DbZ5F7zZe+U2RvavYWKkcPAKcbj7vbgs2kKoNyvM997Ta5FDUtP
         Ru3msT7ebtbgUtvEUtEy3+D1HYi/+v39XcJrpFGywefC4XbICD4wHxCohOtpdfQsAyH/
         VvRN4BHG1f2mPzTpIvVSr7YoNW4j4E3zzLm9u0JIdlg+L9AZiP0BgvpH6y15KQo2scL5
         irUkT5CD0oTXp144Ls7Sto8WfD3zgRJAIr9+g0agtwNQMmFMhd5+Pe0a7FsOZpUk6jh3
         HxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310133; x=1782914933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IzlXEJV0FcXuNIk6GbdUEWcGLXrLvl7ADJNJs6ZuJv0=;
        b=SDfMCBstAVY1+TdSQSiaa69XIIjB0nrYgJMSJpz/XwuQbz6fLGHxAhXS8/0K2pgJ45
         VTWzu8C/ftN3ufb3XRSRM883/ddQMbg512Eu8klaR+TsdRJ2OElO/oQ1Hb9IzQPIy7qs
         h+uvJ0DGrP3hkV2kAozV5uo8DSyIwVpy/uRRwBG/4UmEp/f91y3pbg5lp3dPOzkRqg7n
         Ff8I6J82mkjE8X/p17i2i2YL1NMtiIu16pWZBoE88B5NrJkkHJh1rqdCcAdNn3AWZ1XG
         987AStYb8Bq/N/31wTSRtGnFJ17Dq3DthJfeNV1m9t//UTBWkRwX9CYzHXNaDPfw5vuY
         Kj4Q==
X-Gm-Message-State: AOJu0YzAbcO5eoQenvUIYfw2lYqanez8h3lJ4GLlfVXJ4b3F15Kcpqgc
	n9ybwQ/8Bg0zq+wkKyUj/+JPXe3Z2rPPkBf5yFTmR7tDr309h9E7nxCwRl3JnMZ7ZrI=
X-Gm-Gg: AfdE7cmxZTKy4viGqKB0wDu/0HoR/CalSXbw8JKtixKvgggw+vIb4ogRnagCJrlPIZH
	nYNd8mhyEHs2PUgxSwSXJLd9XiInAtNrC7VSZMnn+QJDxgPG+yvEY/IGWn4DNKlR1Gkb42StAZe
	67spSbUsnGXUInPpdpOhIhalq9D7AjmdfXu0Cpcyeu3uPc9QU9JfgIECXKMQN+XYqPKqGIuDA0A
	cG88glF38KnV43SWhOxQdsc2DwiuMWfDP8OJEj7xLUIyDlPfrl1BdNdnrMyoz2S8VRc+nMF70JT
	JIAsT7W4crTw4HxTPjBYEI/3Mf6sEdlJ7mM8FocIeF41cazzKBhGnJHlbEmf954LMWDnv/h2wvj
	5sfi+NGEJ1h7W02uGGDO0zavkeIY0cB1P9D9cJ+Sy3GeDM/ipn0qd3ajwEAQMQ73wTZrHlw==
X-Received: by 2002:a05:600c:83c8:b0:492:3763:aeb9 with SMTP id 5b1f17b1804b1-49260873614mr51941975e9.21.1782310133083;
        Wed, 24 Jun 2026 07:08:53 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:306c:c2d:85d5:28d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm519680275e9.5.2026.06.24.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:08:52 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 3/4] virtio_balloon: quiesce balloon work before device shutdown
Date: Wed, 24 Jun 2026 16:08:45 +0200
Message-ID: <20260624140846.2616797-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624140846.2616797-1-den@openvz.org>
References: <20260624140846.2616797-1-den@openvz.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8bd2fa086a04 ("virtio: break and reset virtio devices on
device_shutdown()") added a generic virtio bus .shutdown handler that
breaks and resets every virtio device during device_shutdown(), i.e. on
reboot and kexec.

virtio_balloon provides no .shutdown of its own, so that generic path
runs while the balloon's asynchronous work is still armed. Once the
device has been broken, virtqueue_add_inbuf() in
virtballoon_free_page_report() returns -EIO and trips its
WARN_ON_ONCE(). On a kernel booted with panic_on_warn that turns an
ordinary reboot, for example a kexec based upgrade, into a fatal panic
in the middle of device_shutdown(), so the machine never reaches the
new kernel.

Relaxing that single WARN_ON_ONCE() would only hide the symptom: the
inflate/deflate and OOM paths do not warn, they call
wait_event(vb->acked, ...) and would instead block forever on a broken
queue that can no longer complete. The device has to be quiesced, not
just kept quiet.

Add a .shutdown handler that quiesces the balloon via the shared
virtballoon_quiesce() helper while the device is still alive, and only
then breaks and resets it via virtio_device_shutdown(). Unlike
virtballoon_remove() the balloon workqueue is not destroyed, as shutdown
does not free the device and cancel_work_sync() together with stop_update
already prevent any further work from being queued.

Fixes: 8bd2fa086a04 ("virtio: break and reset virtio devices on device_shutdown()")
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/virtio/virtio_balloon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5b02d9191ac6..26fc3c40d5b2 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1137,6 +1137,12 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	kfree(vb);
 }
 
+static void virtballoon_shutdown(struct virtio_device *vdev)
+{
+	virtballoon_quiesce(vdev->priv);
+	virtio_device_shutdown(vdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int virtballoon_freeze(struct virtio_device *vdev)
 {
@@ -1202,6 +1208,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.validate =	virtballoon_validate,
 	.probe =	virtballoon_probe,
 	.remove =	virtballoon_remove,
+	.shutdown =	virtballoon_shutdown,
 	.config_changed = virtballoon_changed,
 #ifdef CONFIG_PM_SLEEP
 	.freeze	=	virtballoon_freeze,
-- 
2.53.0


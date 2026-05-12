Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFD839D6E9
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576384; cv=none; b=ae77mhubYAjXluhV54y8Lzo3SGNjq8IG4XYmWB36T6LIQjNhbMfNYDutTA6J8GTo/YXNGHNkRsJ8Pn4y74l0Jts6qpLrL4DGbIHkozb9uGX7B1zm9A36XMokGQUWuCJZ9KduGf1z2nae8eVHtlMo/0rZUXQRcWCC00ixiFGt8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576384; c=relaxed/simple;
	bh=4Ns0rcqJLws3CedY6H5JU+m8wsp4D7xwSnXKuCiXQjw=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=mYGwdKOYbJJmb1Kf7r7syQwOxZuTOubeCUk2vAUnEYagjZStzmxpwSqLHaExSPbNd1Yg8YwzCr0f5GKNsQ2+IfnIXObXLMZgYw55tEzZcVLC1Uxkm6QSq5xfTPvnQfaJDNufxKBXCwBH5/d/fWl137yxLnqAuoVcvrX4R5bupyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byLuxiws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byLuxiws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778576376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E8x/nB6+eHD5O3AzeJFXB6I/hH3gbVO1zz0k4nECC2U=;
	b=byLuxiws1j8OxKXMJgguhGJZqoAg/DHOcrl8mYmqR2oO5QTTa/+qLmWEk9RfwrrS7j4SZZ
	TijOy6DbtQc8jNt/GjraCsrxMb16O+KZ2JJPSKCi7mQpdoBpXArXf1uvlEjyV1PMiAKxrK
	7Ck072Wk17u3QRny3J5mtS/DcqVdf0s=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-4x1lWhDyNeqdoKCCxS-a2w-1; Tue, 12 May 2026 04:59:35 -0400
X-MC-Unique: 4x1lWhDyNeqdoKCCxS-a2w-1
X-Mimecast-MFC-AGG-ID: 4x1lWhDyNeqdoKCCxS-a2w_1778576374
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f85179263so5884882b3a.3
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 01:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576374; x=1779181174;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8x/nB6+eHD5O3AzeJFXB6I/hH3gbVO1zz0k4nECC2U=;
        b=afjxxvMsuxUCheFHeM5hNKVzluICd8Xk0mSeogqfMhUOoY4FOnLf1DlQV97fUegXnV
         MAOvdotyNqBbh8TclRQpcDqi+qU1C934dnO7uM89dpJ9fgidJnqxoeDqCaQAsfn6S8OP
         Z0cQ+hhBSugtkjS52vq7+HOqGjPnkTfttGo7CS/qwFs+6eaY4uE5NiQFG9wfNdOtqzrk
         7tKcoCNM/6sVZCEt/+HZkn88r2BVhkGibWkZ9m39uVD15+8YJf1pL0pqlitDxg3yqny8
         L1DEYcX7Eif54dGVQAFRXFi6XIfofQm5XZM3FXsr3RltWzlP2s0JhExGRjd6+Jwn75Ao
         aRTg==
X-Forwarded-Encrypted: i=1; AFNElJ91hDuIUF3JYldsXrh0Fh+zX/XawLjcL21NdbkCQAGuAO5O2xNcUJPvKqT86szDYw0hLVUT7NkrlSwjSdWIQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzXGxzjWNZpCxZVEur3D/M2QJc8DZyvswS94JZo+Pu5AJ+VQhv
	gCXcmJi9EtdQwd15fpJhbexdV4UZXut0IDWoMvYRrajpJbLoX2qdWRJKX4Rj9jgFJIQJqnqjB3O
	3rGC+bjpFFTvMWPnGGuRFIOLZDixLQ63Xs6IqQuT36QfzoCx4ffzPf3LbLz+x0/BncPkn
X-Gm-Gg: Acq92OHtySUjj95g8xeRKTT/7XLtUHvFzFDRc8vP4zJIwrc4rdVBHk4wm+zhMaxwLS6
	jAVHDYPlEtHYzWTbw/aJ1Jo5Htb+7cnT7m9Uts8NewXLASEYX9AP2FRh4Bdiw+l0EOTuu//MjPA
	U/9PUlfIhXuBcOrcvHkiVfghopyJuV5wpW1JYowTSuqujlFVX1Q9Vuv/NzlFWbn9pqYqqKeswET
	cUEhsrb12wpeaiEvtcSjjLscSbRDcYIGRvVYlk671cPJoUkzfnHIUerEj/qDTPqox8ymyxaBUS0
	kwH3dpLW2fJLMqblxyLd2E97nNzdXeRozridQoO7BdRrxJzck1JKDTWR4WLZQ9DWbHUTJ/lKMZo
	3MiMauYqIdzfc0BTDRY7sQjwX59p8aGLkIpBT122Yg33ie0x4zi1+PLaXDjg=
X-Received: by 2002:a05:6a00:2446:b0:835:405a:7e69 with SMTP id d2e1a72fcca58-83eebb5e9e1mr2301792b3a.16.1778576374228;
        Tue, 12 May 2026 01:59:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:2446:b0:835:405a:7e69 with SMTP id d2e1a72fcca58-83eebb5e9e1mr2301758b3a.16.1778576373655;
        Tue, 12 May 2026 01:59:33 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm21336715b3a.43.2026.05.12.01.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:59:32 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 12 May 2026 04:59:02 -0400
Subject: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung
 task
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNM0KKrRITZWLNRUbMgunvS8
 i3+fyBhJEwwNg9ELJTIu4qubcAc2u3IaKsGwYXishOsUMzk2R7O5dKUFyzoMkNuNjuoXq69gdq
 GiJbu/zvN7/sBdmCa/2cAAAA=
X-Change-ID: 20260512-virtio-gpu_wait_event-e0cdf8675b7c
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com, 
 syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com, 
 Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _UsPJuwn_kLXaVG5npYQUmNGhy_BXmOELGIuecHV9Tk_1778576374
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
wait_event() without timeout when waiting for virtqueue space. If the
host device stops processing commands, these waits block indefinitely.
Since callers may hold DRM locks, this can make the entire system
unresponsive.

Replace wait_event() with wait_event_timeout() using a 5-second timeout,
consistent with the existing timeout pattern in the driver. On timeout,
clean up and return -ENODEV, following the same error path as
drm_dev_enter() failure.

Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..05e816a0ae0b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -396,7 +396,16 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		virtio_gpu_notify(vgdev);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
+		if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
+					vq->num_free >= elemcnt,
+					5 * HZ)) {
+			/* The device did not respond */
+			if (fence && vbuf->objs)
+				virtio_gpu_array_unlock_resv(vbuf->objs);
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return -ENODEV;
+		}
 		goto again;
 	}
 
@@ -566,7 +575,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
+		if (!wait_event_timeout(vgdev->cursorq.ack_queue,
+					vq->num_free >= outcnt,
+					5 * HZ)) {
+			/* The device did not respond */
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return;
+		}
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260512-virtio-gpu_wait_event-e0cdf8675b7c

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>


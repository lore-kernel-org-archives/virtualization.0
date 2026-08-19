Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF519D8AC
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787105579; cv=none; b=Ymb+aeCsbafO4nh76TmaXIdcWR5zeSzH/mXktWddzQRX8AC8AQ8FjPjxEMo4QudMWewXyiwwPkT7et3U0BqZZThEP4kfVjfyIL9qmIk/qsZHwreEs3yt5cwmwOCrgVL2+XyAtNbdGkogJC9yL22ID09Uuhx77A2hdogkifsJ0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787105579; c=relaxed/simple;
	bh=zgZ+NWH3Ef2boD3X4eDacciQipSXRUijxxoMm6Rufck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIn2/0SLMM+24xMjJ4xttt7YURAOeyyjXub3ziTTwYxOLQH2+ZmHspxzWrtgoqenzS/6WNdcsHyxT3mx2NiIrOUL+b5qJqVtzFtj0eYDD8QVkQLhOGZYUnOsVmE2AX4Dj3U3LlBeb45XyLC/yGDhnsukrwwuZ7ERtw3D/Qgb5XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEW9H7oY; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEW9H7oY"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8485b358552so247775b3a.2
        for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 19:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787105577; x=1787710377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N5aUxzsQa7l0WgZdZkURgYqVBeOUKovRtQ1XVOxVzFk=;
        b=AEW9H7oY2jzMFlRn1cGu0l4RIfc+fvWaghz6uRDIIURTcVQt1M6LNg5IGYjmgLiXLk
         pi8dQUWjTacCoFkPeu3XRoDRUt6ZOhTnNF+qtw8RCbnzj/eye97wg1lF1uKgetBM7ecK
         qegv+4iKCJYQvx5H/0Mbd4nINbyEC1UcUEpIS9K6MsmB5/6HxSS+qbzRZt9dihqeTT8T
         ubSC6sklDl0LTK6wFgQLP1fhDLkCvac9QL6+rH3kX1Oo+5aSTS/9oUv11TcxX3joNHGI
         AHkjdXgKP6hEGKNeFEgAeo+qo/MmDLFI4L3Z+iyXAvj7rCWylQS9voiik/EvRpfqljD0
         Y18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787105577; x=1787710377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N5aUxzsQa7l0WgZdZkURgYqVBeOUKovRtQ1XVOxVzFk=;
        b=Me98DvCv+BtjJcNov5FWZc+mccrmRG9v2dV7J67DziHqOpUW0f5YjldF3IQas0lvtz
         GMuhYpFWSdGjAtpswmShu9q8dhRPW88zQU2QqF09D7uYOR9bWtdhSgh7SaVoKk4UxRsf
         Kez49mk7VrJXrvbj4tfvrDYefMFJp7OuAfZMTEVNgAd5eyPblnkXuRgEMnoEAvWsszT1
         sTRj6RqYKKI1NfbUbdF3B2bvoJdQxBUbo5XA1WB4JXPewb/Oeu/6VVBOSPgXGDZBcgY1
         tw5pYhCuOW87ChhKbRgz8q6yovSsxuh2frZWi0r+DzDPoGUCev7iitFqayS7lA/5rZdB
         lpyg==
X-Forwarded-Encrypted: i=1; AHgh+RpwKYOFS6Jv3QJNb7y1bTuEV1S/5KAxqcb2hO/OglZfPs2FikT1elKBYCl0B28nt6rDCf2gAFHbK+6SLkI3zA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUjAxnG2smoGBpyExCFkin8UQq6BsCC7OKwEjs0ZdvOjSCkx1P
	NYJqagOdhjqH46wmJdBVY4rSdn15zC5shtTpT7iIVDxzEM0AY1kg+4aX
X-Gm-Gg: AR+sD12CvRoClP2c7fJ9Q6Ah1s7Wk/FpHwrALcY2zpYDLDy0gPl9B5TkP7RoEuhKgO5
	E8GcWe6nQCj9DYW+ebOUg81R3cBfA8GNWrhuYaDA/MJKlikzol5Inyrz5mZlyTqEHVnTWRdBBKS
	rsnp6bZxQT4CaFbjKXjflYwUxNyewN3ZnUE27wPw50p+gEmW3upDlbhbHCwOp7I3IS1T7urMd63
	EFgM+Tv2KEaRv1AmNyh28Bb0qGzQX0flyrw4CgHxRW1Nuako9ykRFsRlx1C6MEoYB3i1ZYIiJVZ
	ouWo5clXNs9mzZ7Tnwbg26KxuffoeX4F9XIR+B3+QuhKUEzo93ht9GoFNAfADIPTtu3vuaOulpY
	8qdxukX0DT+1FimtfytXypj3iMiQHZ9VqB6L0AtaYRpxY7CwA+7r5TANNoqmmSR0F1H/3Ut/Sh4
	4RKECHjX8QOHJTzLT4nwB5ZSK+67o3Fp4jG7N7JzJ+ZRr5z7MozYyaoNAmg5kvckw+
X-Received: by 2002:a05:6a00:188b:b0:84e:d5e6:a085 with SMTP id d2e1a72fcca58-851d34d7b76mr1889481b3a.0.1787105576895;
        Tue, 18 Aug 2026 19:12:56 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.126.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15545da49sm96199a12.13.2026.08.18.19.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 19:12:56 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: amit@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_console: do not free control-out buffers on remove
Date: Wed, 19 Aug 2026 10:12:30 +0800
Message-Id: <20260819021230.292696-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__send_control_msg() publishes &portdev->cpkt as the control-out
virtqueue cookie. remove_vqs() walks every virtqueue and passes leftover
cookies to free_buf(), which treats them as struct port_buffer and
reads sgpages.

If a control message is still on c_ovq when the device is unbound,
free_buf() reads past the ports_device object.

KASAN reported slab-out-of-bounds in free_buf():

	free_buf
	remove_vqs
	virtcons_remove
	unbind_store

The object was the ports_device allocated in virtcons_probe().

Drain c_ovq without freeing. The packet lives in portdev and is released
with it.

Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes in v2:
- Guard c_ovq handling with use_multiport() because c_ovq and
  c_ovq_lock are only initialized for multiport devices.

 drivers/char/virtio_console.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..8e0d10d91763 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1884,12 +1884,27 @@ static const struct file_operations portdev_fops = {
 static void remove_vqs(struct ports_device *portdev)
 {
 	struct virtqueue *vq;
+	bool multiport = use_multiport(portdev);
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
 		struct port_buffer *buf;
+		unsigned int len;
 
-		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
+		/*
+		 * c_ovq cookies are &portdev->cpkt, not port_buffer.
+		 * Detach them but do not free_buf().
+		 */
+		if (multiport && vq == portdev->c_ovq) {
+			spin_lock(&portdev->c_ovq_lock);
+			while (virtqueue_get_buf(vq, &len))
+				;
+			while (virtqueue_detach_unused_buf(vq))
+				;
+			spin_unlock(&portdev->c_ovq_lock);
+		} else {
+			flush_bufs(vq, true);
+			while ((buf = virtqueue_detach_unused_buf(vq)))
+				free_buf(buf, true);
+		}
 		cond_resched();
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
-- 
2.34.1

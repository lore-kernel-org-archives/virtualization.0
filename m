Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29784AF69C
	for <virtualization@lists.linux.dev>; Sat,  5 Sep 2026 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788621687; cv=none; b=QxfJKDP35jAKFbxYUN12oz3/nb1x4PDUmMwYFHyQQpDZ7oKJqEfjAbzwWjsDyA7I4EHumul88H21XQdhOkkISJOLj2H/DbHA1dpj9GfNAlX8FOaeR3mSfq7ekp/9DQUqeaJBa9H/2mKN0j0lt74PSmBWekhet7vWEf+yZC54gJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788621687; c=relaxed/simple;
	bh=eXG5r4mV6mtliuq56rwsHZv1ZiQbQWPta1t7fNcCzjM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rgifYNxbLFjDMM+UWIDqetTCMFhFV4OWjBbZ4glQtnpMCRLBx30t6TgX1NwR83PzgHqa+xHSFvKJTldLad1P586MHS4vaZi/PnM0JDB2yZWORs+uO6t2QxhcPGDvHYvIP8zxdj0gtOYv8l1vzxO5eNcXhMA+gZPtSBYvr8wCRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktQLrx91; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktQLrx91"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495590dde14so28351405e9.0
        for <virtualization@lists.linux.dev>; Sat, 05 Sep 2026 08:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788621679; x=1789226479; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=ktQLrx91x1DJOo4dgGC5HIcgqSgDqi+i0gxvYGf0qZtdF+XxN/yX4zX3VL7fwIS/qH
         UjneDbaFxxMCc3HkiOlmmv1P5juPgF78mXJ5NWWuh4M2WbG3HJRXFKEUbOX+4PLFT6fP
         8dvrz7IjP858Qb0E9spkiffl9HcGhRnPtnCARIsTLUQx9S04jfDHv7RezK7d2Jq1FKRS
         pzwnyEw2CA9O4d15MeRgQFdJaP4GjDG954ygBjBRivobjA1SHOnCztUIeUtqpj5IBg7W
         J2lmM8FaZoE2I8ES1ayY7edJ9+j2WaYRZc7f/SUqRJ36JMFS+MhEAYvz/gpHj+c/eGnn
         JvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788621679; x=1789226479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z2bLrkBK78EZ1kRlLHpZelHwP/1fERAUtU0NobzNbNE=;
        b=IPSbt+B3V78q7v0JsgJi1HbrXJ9tlDS5iq4dOTpa5nM8POuu46Oh69FON/ZrjxTSSs
         xRgzyZVM+TA+2R0OAEB2HeVFxMnjUcosqmSqqrO0tSLb9PTPfrNa0cMEhRb7YRFPIxxq
         +/FGDsjzcjCpxe2klWh06M38EmH1Kc+K1QoYS6iQz8GahqPLcrQMs8Hn0XQ5wFiY/jEt
         A5/NIusPrZ+RBS7IqhlyC74qyMzF+9dhcEvXRfWrLaCi+ulmQLsUwBXubIT2DRd2bek9
         7FyZSPrkOYPV5QX0XLdd3WYH6eiqj2a/77vMRCB/HhgXbpbMPuOqtd4Ejxsd0WsXUk3C
         HYPA==
X-Forwarded-Encrypted: i=1; AKwUvBxxFknCZrbXK2ZahT8AaphmDMUsXmbIPpCWyD3xCLA+x6tYw8lZ7apDtXIJ/8ZTBGN3+sWFTyc9ZJCvaJTohg==@lists.linux.dev
X-Gm-Message-State: AFuF++k9/l1wmZGP5bBkbgovUiRY3j2QpMkNfDfpePaEPIWt7RmlPxRi
	2LJdp0+KK01QM7eBaAc0su3+1YvyHLSyAp60+2ntb2a8IaHW/SBaa+ut
X-Gm-Gg: AYBFou3uyN3EXfC6HXvHnhhQDUX8oiHV84B+BRWs1NqbYr4b9WN6b6JEUyiMtgpnXNF
	ex/VsN8LiQz/c+89m/ogBYB0qaM4pmaOymNCZiJbDHlEMGsALPkIpdbJWiE5JXDYjrILzXMOFaf
	w2Nn3338n6l45DYThKBiE1bxW3tGCDAFObNsksrLUk7P2NQpSKBqBJS/uWqsermhG5BFwyo5PoI
	i/VJpiMo1950OdtzQk9zdFrXtJVxFwfoPhf09H+AZks9SftbtmadSPENZPqnzFL+Q+vGsiE0XWF
	VpkpZILs6dpYaDmdufjZQtaOBqUd2k1h/JdhnSZkM40Y/k3v8IzZM29GX4+QMk8drSE0mqXWLJW
	1GlB7RdLJMQa7PnK4PERVdYNeFVlGfwalYKg/WJ7ZHRKPRXXqluYqG0oDEig3QDdXQc/VFHbPm+
	7fq809qguw8QFxtTDMkcaFInPCSabao6XrPFfItDb8YA/s2knMaMLHYcsXJDLT01VdMdj0iI0l/
	tviZQwQUXK4rAazeblioN2LeULdw0/7sG0ecAcadXjbI25sP0NrdN29GrGSJdcxHZjv/wYbML/b
	JMJLpt1K/SZvATPrqlN7jzPTNFF8AoJkKO/1UnEO+irF6KVnbS3wPVqn1ALVkwr2GKk=
X-Received: by 2002:a05:600c:64c8:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49cf81f692bmr245105885e9.7.1788621678914;
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm267779515e9.1.2026.09.05.08.21.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 08:21:18 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] virtio_input: stop callbacks before unregistering input device
Date: Sat,  5 Sep 2026 17:20:58 +0200
Message-Id: <20260905152059.89560-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260905152059.89560-1-kmehltretter@gmail.com>
References: <20260905152059.89560-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtinput_remove() unregisters the input device before resetting the
virtio device. virtinput_recv_events() drops vi->lock around input_event(),
so clearing vi->ready does not stop a callback that passed the entry check.
It can still use vi->idev, requeue buffers and kick the queue.

Reset first, as virtinput_freeze() already does. With the preceding core
change, reset waits for callbacks before input_unregister_device() can
free vi->idev. Recheck vi->ready after taking the lock again: keep draining
completed events so an input packet is not truncated, but stop requeueing
buffers and kicking the queue.

With evdev attached, input_unregister_handle() currently waits for an RCU
grace period, which also waits out IRQ callbacks. This masks the lifetime
bug on PCI and MMIO, but does not protect sleepable callbacks on other
transports.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e682..7b654af0a42c 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
 				    le16_to_cpu(event->code),
 				    le32_to_cpu(event->value));
 			spin_lock_irqsave(&vi->lock, flags);
+			if (!vi->ready)
+				continue;
 			virtinput_queue_evtbuf(vi, event);
 		}
-		virtqueue_kick(vq);
+		if (vi->ready)
+			virtqueue_kick(vq);
 	}
 	spin_unlock_irqrestore(&vi->lock, flags);
 }
@@ -350,8 +353,9 @@ static void virtinput_remove(struct virtio_device *vdev)
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
-	input_unregister_device(vi->idev);
+	/* Callbacks use vi->idev. */
 	virtio_reset_device(vdev);
+	input_unregister_device(vi->idev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
-- 
2.39.5 (Apple Git-154)

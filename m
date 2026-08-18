Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30B37F30A
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025892; cv=none; b=jpeR5jDNbPuq+SloJCmJFBnrAhyfyRI4uChRyVEJuOwO1x1ssaVRYgvemUX54o9HG5ib+0nrxz5MQcJgcffDQqSDPTIsShIdMkn0VjhPHQ/zsdR34Pqb7KrnfOoLzWALxNz/hsQ5QqM6LkvF2poCRoOOBUq580j/cvxZ0lw5oAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025892; c=relaxed/simple;
	bh=D2qVT+5UgHXVKH/NVw1rp7Vf6w0Pz6v0HdW0WWpLAVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kR7z5EwFwIle3fAWgBrQ5ixQYtOehvqzfQEvLHgDES/n9hmb3FUE3CcQiIkLjguG2bmF0i7hFZDWLO53HsR4GOqm0+X/AhflKzGlmnYiwwF4p/CNl47ubdlZ+p76UuaM9MVP+TllxezSEA2GCUkFM8rFpjsx1v04IlQASltpG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+o7Ssth; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+o7Ssth"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso1302879f8f.0
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 21:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787025889; x=1787630689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Qe7iwTkU+6tPG7UhIEK+QFhp1l5M2wR4Ju/kRuD8cY=;
        b=m+o7SsthECIYlRsIGB0y6OR3vpUSS4cPXgwb8FiMORgKShoXRnrE1aY1eakS7ACXnk
         C0S+8i0DnE6mt3gF5Z7TwrufVGP6+BomUrdIDTvO1hSIj//7cDWXSnxWahm5RN1rhx4H
         p8dKnnmAkLfKxDoa7uhGb9p3cTanabcBWHYtwplyUZI2vtTtVbQxgUg534SOEnURh5Fn
         FJCFYfEAadlOKn5rW4UDmT2RUf1bN7o1fIZlNLwV+TDzqNr0TcL7dQ69vJ3j+7sRIqzL
         5cb7V80/1JLYbIb2Pfwh1JbLulODlxaMr5lEhR3YiWpnff14Yw7NvQuktCApsP4AEEfr
         khYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787025889; x=1787630689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Qe7iwTkU+6tPG7UhIEK+QFhp1l5M2wR4Ju/kRuD8cY=;
        b=UnBgGt00l4X9cqoLzsFAk5Xn5xjZlN658Hnd5ZuHkle1VpX97liAe5ScG2dbenD1A9
         bPwOL0H84cDIFwqXT3SfAXXimBDDDKtQoVKmi3/b9QNVsxt2Cc8Vii1DG2h/Qrx/r6oq
         Pc8X4hwUJqkXlg+Dk24cVsBKgfp6Mu9MaZJnOA1FWokmx58BuhDLpCUcb7QKX+dhp4lu
         NJhIruNJYhWhVMYu/akiAfGbjr0W6i7ilxK17qiW0WXXgnqNQbFiBDQa2EGYKxKdCpFZ
         bSHcwUwdIlloh/n5Qym38EFRbzcVtuecTHar5BC7Q9dzpUbTlR3sT69XE8mqFNxjYzm7
         nG4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrFUpUMqCLpx46Mo2b5ByqRHHK7arVelUId7nS0IpR+f69EOFOb/wX69PsxI4iMRnZsIt48EcY74Wl2mgYgMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyIBw684/RTq2MuAmhdHP2IyMh+9JEhNt4JoFICQ2k2ICjAadS
	lPUhCVb8fhreQH6TvoWKyG7niTBZ/J8hkpQUEuM7mJrAFjCU75goU9x+
X-Gm-Gg: AR+sD10mWt/BTrh8n8XIjP9uRdThRDkEI1h3iU9GXAdSb2hruEy52TKjj5e4x90Z4vl
	IhdBCNC7nEVGj4F0Qe88Eao6tO+OF0Io1ZdiddZAmAXZ3otBclaLurhKOvrv27P34ldbrlPhYcM
	ucfvnteJvf7ECDNd3AQ193ghlnSSpnzxlaWUfo3jjaHOMkcuFKnzbMvJcFHjBt5ruWR+bCG4j89
	iQcFU8iZbZq2wWz/OrdO6AnqVsqIkvZCrYjXOI5fz1pq/rUHbS8J94NPwFn3X3xg1nsH7Vfq+Oi
	l7WIUVcscW0Rjq4HDJfIILSghPY9fFE6DNuFXFtpok1V+N35OL2qFRaaiIziNSWpTraEjWOj20S
	RA+DlzA/T0iy0t0rsJf57Px/b8fdqGcuR1Cw1m5MJHD7FyDEv/99Giy1BoPUztq7mfrhnVTAh48
	pK67tYU6O+hf467/CduAyenHU22O87vejk2r/sCw2XTgIMlvTj/yOYv38nO7fh8VGms7i8YOaII
	4AE9LebJ6VTQPwTfnyJ0mL67BV6Vtjon6vAdMu1JwOauy/KE5nFy7u3h66SUfsT3k2DBinY9/Ym
	DHXd/3qQ0jr+XrY6GP6LN96OpaRf2OXwuOTrlUlorJl4BqJJyEjPmPLSYPun9vqcvREtT1S3Gxw
	Ga0Z2OxU=
X-Received: by 2002:a05:6000:46d4:b0:482:a9d2:6afa with SMTP id ffacd0b85a97d-482a9d26b3emr4382292f8f.22.1787025889280;
        Mon, 17 Aug 2026 21:04:49 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a88f-5701-94a8-6746-801e-fa61.310.pool.telefonica.de. [2a02:3100:a88f:5701:94a8:6746:801e:fa61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b7cd38sm9030108f8f.32.2026.08.17.21.04.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Aug 2026 21:04:48 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] virtio_input: stop callbacks before unregistering input device
Date: Tue, 18 Aug 2026 06:04:33 +0200
Message-Id: <20260818040433.66986-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260818040433.66986-1-kmehltretter@gmail.com>
References: <20260818040433.66986-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtinput_remove() unregisters the input device, which can free it,
before resetting the virtio device that can still deliver events.

virtinput_recv_events() drops vi->lock around input_event() and samples
vi->ready only on loop entry. A callback that has passed that check can
therefore use the freed device, requeue a buffer, and kick the queue
after reset has begun.

A KASAN run with the race window widened reproduced the use-after-free.

Reset the device first, as virtinput_freeze() already does. Recheck
vi->ready after reacquiring the lock so the callback does not requeue or
kick once teardown starts.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/virtio/virtio_input.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e6828..12ff33b178ea3 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -49,9 +49,12 @@ static void virtinput_recv_events(struct virtqueue *vq)
 				    le16_to_cpu(event->code),
 				    le32_to_cpu(event->value));
 			spin_lock_irqsave(&vi->lock, flags);
+			if (!vi->ready)
+				break;
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
+	/* Stop callbacks before unregistering the input device. */
 	virtio_reset_device(vdev);
+	input_unregister_device(vi->idev);
 	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
 		kfree(buf);
 	vdev->config->del_vqs(vdev);
-- 
2.53.0


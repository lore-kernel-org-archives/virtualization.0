Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793412560;
	b=t+yZqZ21qBteqeQ1N6yHin/VgaDjf6o1cDpgV1n5Ujeft4KZ5gdr3mdf1Oi6IwiwDXWn
	 KauX/upQryP4nIDDq8hzcR4cW1V8cxYtAXIWXIiuNhw+/GILZlvTxddlvBqXJiks3Rp3D
	 jdEHJMupOpfy3Zl0GG3xW30UxjI5VuQENgPZ3qcY4I8c352ApMbeX5GPZPiXa/JICY4Eb
	 UkWJP3TRipoB5m4CihwySWa3/URqhDao3nHL8xtte2HUeIdkziPTVIaDhFYrimVDxJk6d
	 7/NguNT4s1/ek5hVbdz+QEzARz8LoxqXUhPTIpZVLfAcv84xZ3uqOJQ6CIRgHcwbVfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793412560;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
	b=kxKuZJPpim7+sjxb0ckUQUgJ+SutAx/UDRmzxo6JowsX98e/JR9aSqXbnHBeGux1HJZb
	 wdGjpF6hdARzLW6UCp9Z53MtsBARG5AogRCeK4fsiMMXBBrNM/o+80f4yU+n8vIWvwtJ/
	 JPyG2yPRkmp9n5mHJQXxg8GN0zGsttDaF439HOWV3pjYSmZLwzXn8WcCeD3TlNCbjCH/l
	 7eXTQ3H9cceeawwpmAPu7DrsFm/vM86CU1X5iQJGvI+nPzkgdvRT2BHPZn3+4xRn0wmXI
	 8fnr7U/QGQuKcTWXtePGxoI4WB18/uxOiiCyhQ5d20kMelGhpEmrmoXD4DX1BEUMDHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0tF9zQE;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA9606A330
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AA9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U0tF9zQE
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3550c917fd3so1778109eec.0
        for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793412559; x=1794017359; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=U0tF9zQE3bdvHpDDYGH5xISYTyrJNP/rlQaDeva+ScrypXLi0I1Z0WryGtVSeK+ktG
         07/fWjafVUxrAUtm6rp5/ow6p2ViMzKoQjn62v7VTasVie9jcwrW32LDsbHCRGNq9QYb
         gOMYz1fa9CTF6S1A7MAJUWjypIOwtAlY1nrQ+fmAw57CBgLjBya9urQujbJXfmZ0RDIw
         TgiOYduTifhKOQDHcynHHbhjpry/ptiSe7KGErrsFDNGXJNhvdMQezCkKR9iDyITcNMc
         HkLzBpvRWuUN0DJ/ZCyZvYuHLldd+Ji4AydvYrm50bK3fa7t8XHGCikZbE0lAxM+XICt
         hlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793412559; x=1794017359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xyRi7XDKpXV1gU6ovNhxbTiviMkA7YCbmNrm8NAAe74=;
        b=21f+4I1neYw4eJn36gYeljohznm7a67NUiBHMD1EYAtgZGzykdXZPRvjrBlEitUZpa
         jt5eY13eriErbgEvcvjaDO2g2mVFwR3T8PQVeVpDIlHUeYf5KC3OrmEH+WY6PpSuJeGF
         RZhX0qTQbvCAPf4IOIXkNlzclpCvq1FDG5A4DSRKWflrGclaYnbrGlcdlKE4RVvla87s
         ShamTuKRJoNEsf3d68MGOg+of6OZKVx809ddojRmVCYodqVz8pEToR5XjKk6Z0AZUb42
         3+eZXoRgKgrzIntCX5cW8IWSCbBdnWc0e/7euQYCQkusdcSsd7oKkSWpvkFsjC0+5dIH
         fKGw==
X-Forwarded-Encrypted: i=1; AKwUvBw8VR6/jsi1SeQKy7yKrLOtR3A4kIPcWk0G4VwX7FoKfd6eGLC/l05Ffo531IX+A0Nlgk94egAOHWVxO93iZQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJgC/DrVoLxq9F4QnsYMlVetUBMEbcUtE3fVTPRnrYIGhWvNr5H
	eT73wbAqMuCLbc6CtD29HMlmeiIz01pr/9ocaG2osUvpfTm5BbaJA7cs
X-Gm-Gg: AYBFou3hwP1RkL/TYUqic/zFYdhp2K3fVni+nmuV4Of+73ZbMUr6r1SVLyTeVx++nIT
	WBbjgjiLOEYkQIcGHi7Sc7TcNx5tJW4Z1kgnwgjJI84/F11gmtca+eCsOROybwHXOIIf91fgUKy
	hU6Xp30n1JYqcByUspjjSfpalrKN9ROIe5txrbbjIfviwtd7LlLjr/71M3wPHjIlxPtdAhRBjGM
	0ZmbZoOBCelI3jlUR95ykMS1dQU/UY+MJHtWZo8EeESwL7NximABNQB0u6Sxw++qeuIIf3N2Fgc
	vKSxI9U0hjcxLU49NftYsGpClN6NLXH+l0bjLqxx1taALPjImMamQGUzR0IteGvj3AZVWAycx9C
	Fh16nZLNJGBBn+YYUIaU4Za0OMYrcU6zQk1kLz/uvn1Ff9EqhVpH4xWnAQ9Qx1ESUg2jmKmdC0W
	i4VHPApfa4qJwKn1F6oMksqcaLuOh6sX5Xj5ApOM9uR8M60ETZ1FXSB+R1EhYPoz4QDuPtoMkVl
	CCTOtbGZ5mfsRgPwitTbWDFKQclHw3jn6B0UNzga6ncnBAI2X00j60ywI399qoukbxmMGgZgm19
	Wmg3OY5blk5g9Bxx9GDSL1kEBAMPJIeBkW710eZhBkRdpMFzAKeD/fhiEJYzDHE+EfW3twzayTD
	z2/Ld+4d7wN1ANkyn5F3Q2F+7dhc0nl614uFBCgk8EKEI8w==
X-Received: by 2002:a05:7300:6d22:b0:36a:13e1:c889 with SMTP id 5a478bee46e88-36a425e10f8mr8691655eec.36.1793412558707;
        Fri, 30 Oct 2026 19:09:18 -0700 (PDT)
Received: from localhost.localdomain ([180.182.24.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm13214096eec.26.2026.10.30.19.09.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 19:09:18 -0700 (PDT)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v11 06/14] ALSA: virtio: wait through signals for PCM teardown
Date: Sat, 31 Oct 2026 11:08:47 +0900
Message-ID: <20261031020855.2402-7-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261031020855.2402-1-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A signal can end the interruptible wait while a STOP or RELEASE request is
still pending. A later teardown may then submit another RELEASE before the
first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels the
pending request and wakes the waiter.

Assisted-by: LLM
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -314,7 +314,20 @@
 		 */
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
-		rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+		/*
+		 * Teardown must observe completion even with a pending signal.
+		 * Otherwise a subsequent open can retry RELEASE while the device
+		 * is still processing the previous teardown request.
+		 */
+		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_STOP:
+		case VIRTIO_SND_R_PCM_RELEASE:
+			rc = wait_for_completion_timeout(&msg->notify, js);
+			break;
+		default:
+			rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+			break;
+		}
 		if (!rc) {
 			dev_err(&vdev->dev,
 				"control message (0x%08x) timeout\n",
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
+ * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * Other requests remain interruptible. Device reset cancels and wakes either
+ * kind of waiter.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.

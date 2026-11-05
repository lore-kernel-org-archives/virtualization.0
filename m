Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837395;
	b=KUAfoLKMfEV2G40g2zXJugRTFJ3xTG0bvyFhUZq50nDrqmg8yVJ3/E1oYqRKGAXgZ+9S
	 jhCzP2+bcbbIQtalxoKxbDOvmvPnBRroEbI5zyDsBjqtFY53ipudg+RL1UXywSgHIuSY6
	 mzLikdC5VYyRKnTWIiBWUemUQSLrvmCAdFQYbOOShdqWG4Qb0jIYFvPGi+B89d/Yh/wMy
	 Mvbzyx2/ZYZT+o7jqmHpRufCPiRsc6ri36wCGhWoaFNiyicGaUQJLIqR3SpQ1o+CYym1e
	 VyQJop7OqDVwpsSHsVfBs3f0jaur2styPsqyjscBTrkRJJWO53BKLDevguDn0OkOl5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Hy/84DnLRHSkLYr0y43NMukCMjMkWuzO7+IZ4PjZ4VU=;
	b=t9gDE9AHGExWNXrRrFYRnAyl1fTMapRuiP2q1xJh4Ex2IFz6naFu0Fhu8minESBCZ82X
	 qSr3ahFBFTmrRZYSzuN85oZtL3INZNSfyV0RZuL2i6utds/pLYNsTxn1WMB1HpjRKrFCg
	 ne0G0yK+kUfkk8wMBvVno72cvg5eU3fRbwAES1PzwIuGEn0WO5w4s8Mzua9nWfVRcZjt/
	 3UDHKMVB3xEmovna/6jje+RxLBpdwyMTsCACbA7UsMLI3Gyxy/IkMz6C1/zRLOgkBg0sG
	 qxG8SHbwNtMNgT6+vL/vQK4XhEegP4zbhV1Vgrh34ljGXuhxV/eXPPN9demQRrrD/Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QORtk+3n;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FD6082BDD
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 230FD6082BDD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QORtk+3n
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so917402a91.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 16:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793837394; x=1794442194; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hy/84DnLRHSkLYr0y43NMukCMjMkWuzO7+IZ4PjZ4VU=;
        b=QORtk+3n6STTiUT7e5R+gbce5O3k0yGArMCpJwAycNFLHCX1qJqURgChL0JfFfhy+0
         XdYm6OXLUpSZBsEX9v1XRIvnbLqsAMc6mn9BMfW0PO9KacY25pw2/bgQMPUeZRpDDCbu
         03NEzsAhc/RDjjX7BxhR2eymiI31gjVNQ7R6pblFxS05VLXJUKNDzC2KEcjS6O+7LY3T
         AkUPojpcnGHRgDl7A8HwBsZug7s6J72M/1pDNuZUIrSFKWLs9TJqVCQ7oD6zOwDOM/+O
         aZe7bzKPQnjnE0/wC5wt7vaMXwoKk9ahzjXvJcktcfN1weNwCI/Abh54IHVc+NLmDih/
         E7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837394; x=1794442194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hy/84DnLRHSkLYr0y43NMukCMjMkWuzO7+IZ4PjZ4VU=;
        b=gOAA01TfGrCbDY7UhoBs14fP7klGI2fAm5plkwaRaJsu/s6yajmUc4ewKWJlxN2+0p
         VYMHy+a9jHKT/RCwXSPdVFPv8fbXZdAbg/F3LlHR0nvNkTIAPpBRyofSws7ZXNcC2iWb
         v4jRxMiyWt6vqX0kXGQiMXi6dIne3hD5Irp35jshOX6qsEzLe+BdF7qcQDs9wNAv442v
         ENQfxUN5hlWfyuydzWD6nf/M3XXAmSEY6m+jLrvE32RrJRSZp6ePmwhYqMS8ELiPFO1x
         zX0BWL5GiskGyKMP/aEobJCSvCb3VE1fs9AHJeE2sC22j5ifbTBjFF/FVhnnA8GJa2l4
         m4DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxl4WKMQks2YCVtFGsClnNcGHIywsiO+XXF/QXgwHj55loBjW9fEATpC+NafA4FU/+pi0rTLn6Mt9PslKEIEg==@lists.linux.dev
X-Gm-Message-State: APuU4Z++PHGUsIVpinQQ5xxMW66DrzOJqq9OgA3c5jwjZKsaP+70Mkrf
	kfBFTyRyj0eAL/Xle9MdCZQY0ZmZ9WYW/gefeWDpdSlLNaV9urObkkwTCsXXSQ==
X-Gm-Gg: AYBFou20g+IhZL/CobiyeRDC83vYGo8HbPrML0iyu/O9U+27m1SlPVsqZUPMF6jJyuH
	TeEAWDVklOXH5jSfwm++JDWBoXp5AaGlTp88HcGcBadQtZiTpyDWTsfo1/4wBPHmy5g2PbEX42+
	YGVauhsJjUHhmHu9wvlV8k7dAZbl1kOA43TY3P3eu/3vN2t3ACm0FaT3ON+hGekB6EbY2/FyKpf
	taZ7deVZZ8McK93fORfKXPiQ0+k7HzJVPJjSsCeC19T5Vy4QpcvbKuDOy3RjXgXFhd6pdCf0lNI
	FgGQn5RFkCd3YLg3rpKdBe6PVZRU2oc54nd20XS/wVoK6b4vBhJy96sGtrwhdX/aVAWoav3UoJl
	0oFUROqjnDirMRsOCFIfRpEkcjhaD7Q4oL5LD+59HGALFXuAKcQ9HkgLmk12voJ8CKoUtBnXCaA
	+cKeXFpY/lgSBEviZsRD2049CyBDMmN7NpsnpNspeZVZH90AmkQDR87S91o3sIUG3c/WZ/m7oLz
	yN/dRnF9jyrghSuHj4eBtS/hDP/dnpqOkoy3GF8pLmHGPteQV51DPPKSnZ3lgLqqhjzMd8YHdCD
	O/CcpV4MwprjpDjPFsz2oWtrc7PAC8CkhFKOPUWnM5Ym3iOs8d7iulJWVYmO1u5L3EF/3oD6x/I
	1xaZkghB377nCp4jhpSTkJTE4y6mA7CM1eiAhPNGrqrIHIYjh71sYdp0ey5FgwYjEHot4
X-Received: by 2002:a17:90b:2751:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3ae8984ec60mr14592568a91.51.1793837394483;
        Wed, 04 Nov 2026 16:09:54 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b323c18fsm897208a91.4.2026.11.04.16.09.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 16:09:53 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
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
Subject: [PATCH v15 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Thu,  5 Nov 2026 09:09:12 +0900
Message-ID: <20261105000915.15177-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105000915.15177-1-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
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
sound/virtio/virtio_ctl_msg.c |   15 ++++++++++++++-
 sound/virtio/virtio_ctl_msg.h |    3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

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

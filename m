Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794383529;
	b=PSsGozZ6hwzSQkTCDI11wGun7FSIWrBtxVSlW8YD6LLyLHCTI441uzc0QmNPR5Qx726f
	 h2DiliL4O6GaxNxEtYyL4GQureb7HMU1pn2pvFfIRnDYOvjd3Vww60gyw1dsUiNfFKePc
	 KSm8URiD7idX7ncjwUescBwp2ArIi1Zi4CpxSKvGWUpwt7rpk5963m+r5YNe2dO5BxnXH
	 FRXyTBJ3hNt+5NB82x17i36VJG4hSbsXAqXAE8Mn9LyX2Y3RwWC3pKpWEXX4SR2oz6/gM
	 ryukaRdjm/sN13dYQafB3UIevAMShchhww6iFZKE63w3Eo3n6tZSpda+Tpgms1325hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794383529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uZIN4D7jbH1Urh+LOeQa3/6TVd5EZ4/PM32bHYfTJqU=;
	b=pQBhc/kd310I+KTPl9/CnngN6F63aqtjWnmzSqQIOLb+BWSRPMnmiGHa9/6nSkmXTKBM
	 ZFeiaEZMjQVrEKTKj4rtyaN78IvzosAnDTH6dCblFue7aPFbzIsH+dBXAryXC9ShOyJkj
	 uunGhGHsluaJxmY9VYBmnmtw5uvzSXIPT9/YxoaNhY5oun1GFNgPF3V5lLdf5sLoUcAZI
	 GwjcrNdIsrNLIpA4zZYDVVhxoQm0BG64dJ7Rh/erup/NYBQvzodQ5itcKc6zaxK198I86
	 Xp54pRohTvBB0ezRM+tb/SyKqDls+uh9SFf3ZIeeUlXL/ecQvwFhrgddGSDmUPtXNRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxM7FAEj;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8FA60A2604
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA8FA60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxM7FAEj
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3acec6677so4519110c88.1
        for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794383528; x=1794988328; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZIN4D7jbH1Urh+LOeQa3/6TVd5EZ4/PM32bHYfTJqU=;
        b=kxM7FAEjeZmOwUw9MIZOU/EVsSU2nZnUnTVGYorClKhpjHfwz1cg32YB1y7l4CiXvO
         ARZGgy410K9Bir2mP94sirwqw8k97wdmZ2FNJrzSmhPaEFRuKU71JKh+RVa7raoK8Ayc
         UlurJ/qeG2XBRThQvAxytHIEI7DTgqf6tN/F/aicXrPAQ1HWTl4VwS5hfoACiIxIVTd2
         nb4WMtf7cFW11iAcIKtT14oIIFZ/4JsSm02sOVf3F0NUzpiNst66/DoIDKTCEHVBWnLS
         5lIPKeQm9TTGnNewDoa3Kl2E8ZZldBiPJ4c6au7arbt2jMj+AFLPZBjjWCSE8A2HwwoB
         6tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383528; x=1794988328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZIN4D7jbH1Urh+LOeQa3/6TVd5EZ4/PM32bHYfTJqU=;
        b=aAdF4XvCY0DMo1NN00VQQscufbgqKj9zEaWZisWz2F6GT1PljbU1+qWxEx92r/33Fp
         GaLvZS69GnWW97Cs6C2hr0SlnCTjzqniGsjizFqrXBBefG+rFNdrWPgtj+s3DUy7NIcl
         ZQUYH/MSE5BgLyCS3ZLuY9qywc9slhQWUoAJACooxIMYptrbfCaXK61YUYBDrhi3LHHQ
         0yazfChMy+hql1dPEQPLrpEtC5reYLwGYpE1w2hBUhvougZO4/VXou48vIcRuqloVMx2
         Ab/u3T/xXgNeR3mhP1QEzS9dxHG6aku5d3aWCzpMT2HnS1+Qza5UhwuY5N2usdqXnX1k
         jbVA==
X-Forwarded-Encrypted: i=1; AL+hErGvxNkQMTzgRRHPmnac/iHq5HEAjZaT2qa6jAIrbRln/SIvkpAvMzFANawAY33rbw1UX/XLQoFZQw7Rp3kcIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/xFWHWpIMz4vdv8/WOji0pxsXSgFmsjQYTAG3FdyifIgECXl/2
	DQ1TcATnR0CzajxUmbFdQmQH260qwasOqA6zQTlKeGGDjdJRGlHAPgWx
X-Gm-Gg: AYBFou0OG+RtM3W6XNPVh2uLb2Zs+ONO8AbxoalWrXvqyEcodPi54j2znFeO3EFzw+p
	w/fN5uRw6UfEMas2KJ6rz+QuxIP7AA9ROHT2fPKO6tFFxTdoU8a73uQnU8TQJ+WstVj4JNM1Jw3
	5uu4XA9weOntyEw9jZpSqCJCqSGJ2Zqno2UhKQd3I4cdLijykPkoXpfXdrceoNVBHA8UFpmKINE
	tqC1GTnexjPlbW/R3F/o1rGknf49jI/ZzJcXEgrUj6Ek2iSpM8v6gVsGG0b089XqOSh9eariPlh
	mZSCncqnlMAML/ANPQJ8GFUDgLlGD43i0uv/M+vIFTBFOFVNPgrqbFPxmjuErw+FZJvKWK6Ppje
	ZwnMRZ0Ma091HIMPaeNUzotr306XI1+by2YfwZPGCDH5wkPPvncMFvVp1B/iAO6bY3Nhf3aDFt2
	tdVgYF3gF67f4YppHrEnaNOZ1kuJKTk6sF8xXoMUfxJdnS1nk6JBsoFfeWRDBq7jOQJoG7t9nPv
	ItzXNJDLgM7OwPw2gMDzX3daJxZsYKOUNAlLkmZp/FMRWaojBpM86s6rkCl/iv99p5qB9vwNl6x
	a1t6t/5bdBbHMh8YvVxD8v8gcHhWWp+vy5VOmsTZyyuv7CII
X-Received: by 2002:a05:701b:2302:b0:1b3:a26b:8b97 with SMTP id a92af1059eb24-1b3c0353171mr1674179c88.41.1794383527293;
        Tue, 10 Nov 2026 23:52:07 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm11284950c88.13.2026.11.10.23.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:52:06 -0800 (PST)
From: Hyunjung Ko <hj351016@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jiri Pirko <jiri@resnulli.us>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio_pci_modern: don't sleep in atomic context in admin cmd submission
Date: Wed, 11 Nov 2026 16:51:54 +0900
Message-ID: <20261111075154.3017978-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

virtqueue_exec_admin_cmd() calls virtqueue_add_sgs() with GFP_KERNEL while
holding admin_vq->lock, which is taken with spin_lock_irqsave(). The admin
virtqueue is created with ctx=false, so when the device has negotiated
VIRTIO_RING_F_INDIRECT_DESC it uses indirect descriptors and
virtqueue_add() allocates the indirect descriptor table with the passed
gfp. Admin commands always have more than one sg (header plus status), so
the indirect path is taken and a GFP_KERNEL allocation may sleep while
interrupts are disabled under the spinlock, triggering a "BUG: sleeping
function called from invalid context" splat with CONFIG_DEBUG_ATOMIC_SLEEP.

Use GFP_ATOMIC for the descriptor allocation that runs under the lock; the
table is small and the -ENOMEM path is already handled.

Fixes: 4c3b54af907e ("virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 922e2df027de..ef96140118ec 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -101,7 +101,7 @@ again:
 		return -EIO;
 
 	spin_lock_irqsave(&admin_vq->lock, flags);
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			spin_unlock_irqrestore(&admin_vq->lock, flags);
-- 
2.43.0

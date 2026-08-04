Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3817332635
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817151; cv=none; b=HZAgbGHw2hfgEI7WcpE8c4AVUzd+F5ZjSiDAIgTU4Ownp+iAR8brrny1Aw0J8owNAviHt17Fqt7bTpsR0LHFjT1b9aND/lYAev5jXwKnycEyxb3+tEWbZ+f/0Vx1+hhjPkTu/LGDcfTi6Ekl76ftj25Zuc3PS8PouF+pYAYQCRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817151; c=relaxed/simple;
	bh=Ehv6ZpiwwQTVEJVQYx8VsZm6ew9x8gEVlTBOFfynDtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwEwjREYdQvi6DHf9VAHJcN08fA6pFD/F9Cv2m2T14WD9buOVydfwzKZUbxnSJ4giYgPv/oNE3WjLcNdnSX1jjwcABGOeSmdkskJUxwDByLIcTXqMNgkRS/NcGimFlwfmt7veHI0Me7ilBJpsd7Fir9T+aECbmZlC3IX8/vOsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw8sZCFg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw8sZCFg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cab973140bso51639155ad.3
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 21:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785817149; x=1786421949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=osDb3QU8E2plb1DNFxL1j8vSW/KoqghbaQXI4jZIOlw=;
        b=Dw8sZCFgaPCM8oZom7/XEDaWYLMpVuxYbLLH3m4+7ktQ6IaHG34LYXDqHXrY3XubiT
         OB31AJD7sL366tCC1FnJs8Ii8Nn0A90ElrM0WWK0XHsbrz9DYJwGHR7SDrYGubnNxoq3
         /ILSm6pm7XbQgEPgiIrYKSEJokbVXx/jqB2nBQjFMfyKQ4miRjdrJLlSnJ0EJg43/0uT
         G5foxfa84mpyK5u4nM3WhiGscnaLMNg/Bsk+/nogJQSL/ybbBx6j9DKEjcsBq9NIT4Hw
         lpdZvJek0nS6Bm6m3LSDHi/fkSR2kTYBK+rko4qaAmITtw1EbG3S9rhno79Z+Iaiciii
         hu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785817149; x=1786421949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=osDb3QU8E2plb1DNFxL1j8vSW/KoqghbaQXI4jZIOlw=;
        b=ibLMuiGebmqoAaPwQ539DKf8QCaHPTNIz8AOYf7RekLpIGNXvKukPshlwXpKyQTmlr
         LwZXh5iHFwqrnuFAusVqYOa9whNfJCpGu2BZl5kMzKSMigfidmcwuG013PNfHfBVDA3V
         b7jh+w+o5Zpzxr4oFeer4kAyWiNGemwq4EWiMC4AygsALnCbTw3lOA0AUGtd+7ONSYk/
         pHEbUjOokGKBRRAfUesI+w6ENRMBqIlZZspkAcHEW2VL6YcTR2kPom8X4hv1f71EHqvw
         nJWTke6PJDgZEHe6AmIkEZboOPpOlT5AgDGc6ndWrX1ftoHC+W9oSBfZQDFZdNxlf0C/
         X8JQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPHEM07d+c7u6NJE1uYtgg0vTrISf1PR5/MxdrNXhxrEqXY1o/N2ipz96Mof60wN0L4KO71b10mgh6AfvHgg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtZDMXQneI08QRVztU41HdujkAAc+b/D9+vKbd9cHYGBjqNQo/
	ioAKKnielAKttdhRwlTYH0NgRXZm8SXgsKWDXiTnhXik8az/nZ5JL2vR
X-Gm-Gg: AR+sD11ou372bqD+MxkFVsqPfMT7CiJ562vzWkPJU3tw6S7jdp1b8MNuTxo/x74km6N
	HFTJyv366FNFUjVpaBKN2Hc9SNmqvG+xaWVTmE0k1ZUA6sA0XkRVVrJW+KYR6kdwjn5eIj/sPqV
	WtF/svi+yTZy+e2z8cIbLVJ6jrTYxGMajbdM35qkQHWleVggNR9BQJel+sgB2RwmlxBXxPPGKWh
	aHqWZSa+2s9RPX8ZsA3Vjis8Em9tytneGxy8UyOfu1OOs4P54rfUNiIZAS2vbOOHW0Z3yH+NMIS
	ykqk072rLuQu3PwS6MPt33ARS9V+Fk3OYl+oeNT6HCIRHlivnN8Y9Fxp0I0yoNFpFg2c+OCEwH+
	Kl8BB+cB7J9lVCHn7H/kuUvEyMXs1fPZyiN8HLdfXCPna1//XHsowj3GAO8aqevXuKstyJzi8MK
	subXbh04t+j0qwbrq/dHpaIA70x1T97br7l03jPieJa9VLoaRh9Q/UZO9j+rPNoII=
X-Received: by 2002:a17:902:d2c9:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2d0521bb7cbmr117871245ad.14.1785817148639;
        Mon, 03 Aug 2026 21:19:08 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea84asm46012645ad.43.2026.08.03.21.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 21:19:08 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com
Cc: stefanha@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
Date: Tue,  4 Aug 2026 12:18:50 +0800
Message-Id: <20260804041850.5922-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803231405-mutt-send-email-mst@kernel.org>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-2-physicalmtea@gmail.com>
 <20260803231405-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 03, 2026 at 11:18:50PM -0400, Michael S. Tsirkin wrote:
> Why lock down all vqs like this?  Would this work just as well instead?
>
> 	iotlb = vsock->dev.iotlb;
> 	vsock->dev.iotlb = NULL;
>
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> 		mutex_lock(&vsock->vqs[i].mutex);
> 		vq = &vsock->vqs[i];
> 		vq->iotlb = NULL;
> 		memset(vq->meta_iotlb, 0, sizeof(vq->meta_iotlb));
> 		vq->acked_features = features;
> 		mutex_unlock(&vsock->vqs[i].mutex);
> 	}
>
> and if no why not?

Thanks for the review.

My understanding is as follows. The proposed sequence protects the
lifetime of the old IOTLB, but it does not keep the translation state
consistent during the transition.

dev->iotlb is shared by all VQs, while vq->iotlb, meta_iotlb, and
acked_features are per-VQ state. A kick handler only holds its own VQ
mutex. If dev->iotlb is cleared first, a handler that already holds a VQ
mutex can continue using the old vq->iotlb and metadata cache, while
translate_desc() sees dev->iotlb == NULL and falls back to dev->umem. The
same handler could therefore observe both the IOVA/IOTLB and GPA/umem
views.

Locking each VQ in turn before freeing the old IOTLB prevents a lifetime
issue, but it does not remove this mixed-state window. Taking all VQ
mutexes before changing dev->iotlb lets active handlers finish and
prevents new handlers from running until the shared and per-VQ state has
been updated consistently.

If VHOST_SET_FEATURES is guaranteed to run only while all VQs are stopped
or otherwise quiesced, then the shorter sequence should be sufficient.
Since the ioctl itself does not enforce that, I thought this transition
also needed to be safe while a VQ may still be active.

Please correct me if I have misunderstood anything. Thank you very much.

Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79662494827
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455232; cv=none; b=NSKP7zMntJX2p5Mw3yubyWsxqSpjORhIKnYcEOdY7WId0CPSAplExaBBqVxw1LDPAU4cuYya2LdC3/g29B4xdG3RjCQ6e3uLq13KpYNXHiZxqlWUCdqk39QAYzjRKMy7CgyGlY1IzBCAUN03IgS5wgdpUrqyeeuzGh8AFErzg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455232; c=relaxed/simple;
	bh=QhCEJCWFqwrvmCjcqkWNZlTEDRjVdZZGuz074t6eMjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLjLtOtQNZutOLoPNN/TGGQzcx4/Xy5CQQxLFgMSvDEYM8S7VoE3bK4zX+KvceSQ17uBD9lRFEtiOaKAiPeKU/B3gV9GGg4FHsBw8EyMePJAgQpHWXiNlK0YXIEydDuam+GGm5MYnjKt6whE3kySiChoxVyvRPgZKtl/LKCJE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=SGfcgKO6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="SGfcgKO6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e812e2b31bso3062385ad.3
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791455231; x=1792060031; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYFMzSsUO1/6oY0m9yqtR64F8Xqv2JTUxrApkdvIlak=;
        b=SGfcgKO6rSEdfjAJPBfae+8fL2h2389M+B1ZOeUWxAInCIe4JjHRhtTADkv1uSkNJ9
         FWsPLnPeNNeJTrEPCRUlcoNNpklYb6+/Gnut3jMDd92D0prQVrQZzpcmdTNNVsu68ECR
         xGOiDw/8rwwu4oXyfxaBIQ6UI7Sb+IyVI9YsHsZC5MLve/knqML+A2Zxz0JL8JlsmJBa
         1isYJA1C7J5hqAzkE5aLa14u/5Wkoaa9kjKt3rb4Cie2FOB5qXId9fYUL+diAia6hTlJ
         4nXfmp1zbjrJGANKZovWhz4T79QlYGyScfx7cRd0L9QYGkQTiav/9txBnIkspSjgKG7/
         aw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455231; x=1792060031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYFMzSsUO1/6oY0m9yqtR64F8Xqv2JTUxrApkdvIlak=;
        b=cUidcd0LALERuuvtzEPEwTCQ1JK8MJs6NEezMOeYdJIUSajTzRyuEeB7YhN4XFgnGM
         XL58DjedcY/oGUQwdq1tO0C5BeTcaEa283u2pO+grzbqAOuTuFbjdAqnQQsgIsx+sz2F
         1oVmvvZOKdr5UHF77IstaATyiCt84uQgkaq2jFmkvQ4Qm8zWXVUcZw2ko/3wsMcFT7k6
         /mtjMkYUxRsJ0lVzwHeFXk5cilVgf83Q27pHYwvdcWdNn4HD7IpMRqYUp3ASdX02c29I
         TvQAvFmV54LCAjj6kfbpnmLotwtjFZTplVfHirBHzu7Icc4vSFLrWJ6o5CRJDcogYJxc
         ZZ3A==
X-Forwarded-Encrypted: i=1; AKwUvByediIbcczk4xlHA6/VP4AyYjQPCIV09VjKjbDbWx8hJSEB5iKEM+TViVTwZPKnEzqx529SSbrvzapSWyehtg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ11riojVJmlaLFYsSH9A3jhgRKEExPbc6G9c1SxlCO4obd6N31
	XndA3PxW/rgt+ozIsgXZiNF6dYVjow0dzivGAq2Sq6YX6emA5y+ym74HgIz7bBzw+JI=
X-Gm-Gg: AYBFou1AaZghFfHUOJo5mQE6srhLGu3r94EUvCHPCffF9lCH6gCje5RkIKwO0LyfFwV
	8Cf5ugyrn0h7jVfYxcaLz3k6dOsGOemLPJoKgU9GMIZPNcZa3bGiPc2W2hbKOMnb8cYfJHaGTBJ
	kYDXdxTezpISlr4q5S49IGCIFjVMC5laFWPEgxf9aife97lzOpfgxJCVviU2TsGW/hw9cHha8em
	5KSnNQ0VisEjBtYD/OmLPb3k62ziQ7Fa0Z6D89mBW/LbSggfuPtXPHalikZ6+sdtab9HZ/AcHGh
	he2fYUT8DUHtRcdT4P+HltSsqOo+u6ALMvDr7Rjx7RKLWIkg8EakMjx/B1RyEFXhIleXGaW9Bi0
	yt1DLyTtAMQ/uYlY1v+/7kXCsUpy+O4JXwxDrRqvtoxYeK08qghCZg8F/ot9e8i+wwuKsc5FIPi
	/IucRhseTkantzrYMeQHJmJojgVNA6hHOUDmKdZiGr7j2yswsPscVJh1tDxoqbD2hCBsCTFq3OT
	g3luA==
X-Received: by 2002:a17:902:f707:b0:2e2:ed2b:87f8 with SMTP id d9443c01a7336-2e600509214mr44172725ad.41.1791455230764;
        Thu, 08 Oct 2026 03:27:10 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e6046fdbcasm22578185ad.13.2026.10.08.03.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:27:10 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jpb@kernel.org,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	eric.auger@redhat.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH] iommu/virtio: bound the probe-property walk to the probe buffer
Date: Thu,  8 Oct 2026 19:26:53 +0900
Message-ID: <20261008102653.1084996-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-163970@kernel.org>
References: <sashiko-outbox-163970@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review.  Both points are the same concern: an unaligned property
making mem->start and mem->end unaligned.

This is pre-existing.  viommu_add_resv_mem() already performed the le64_to_cpu()
reads of mem->start and mem->end before this patch; the patch only adds the
bounds check in the walk and moves the existing length check ahead of those
reads, so it neither introduces nor widens the unaligned access.

And it does not fault on the architectures that build this driver.  VIRTIO_IOMMU
depends on (ARM64 || X86) (drivers/iommu/Kconfig), and both select
HAVE_EFFICIENT_UNALIGNED_ACCESS and read unaligned normal memory without
trapping.  I tested this on x86-64: with the RESV_MEM property forced to an odd
offset so mem->start and mem->end are misaligned, the values are read back
correctly with no alignment fault, both with and without this patch (I have not
run the same on arm64).  The 8-byte property alignment is a device-side
requirement; the driver does not need to rely on it, since an unaligned property
is still read correctly here.

If you would prefer the parser to be alignment-safe regardless, for instance for
a UBSAN_ALIGNMENT build, I can convert the device-provided reads to
get_unaligned_le64() as a follow-up.

Thanks,
Yehyeong

Received: from mail-yx2-f34.google.com (mail-yx2-f34.google.com [74.125.224.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB83EB7F4
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055866; cv=pass; b=MAt51VMxGOJePHqiA99bwDtCz2tIPJIUW8XcIabBKWCcRMVw27ustkkCEJzSGf/2G1YbZhjBPAAW5R2D72GVAcFUL6WQGPQ1OPQTkWg/SPUbQwH0FqhTBUZCPG9gcB2+vkbHAbS3uWNz/3cKwoD/6eeGaTo/PS2xLYQ74Lbva+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055866; c=relaxed/simple;
	bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=li5jOSp3dw7QAMxkPzxdsqUJ1qSYrUeDhSEyQKz6lwDTfWaPgFVLrM0RRDkLg59k/0Z0KcyCkY0jKySo+eNd4JdeLKYMnPw3/qTiBqp9fgG4SNqeoN2GBEwFGjH+nWB3SnR9PXpOyzBgTGGOXkIZvh8MP4Q9fy9SMn8jFAXTkAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKfKvwbb; arc=pass smtp.client-ip=74.125.224.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKfKvwbb"
Received: by mail-yx2-f34.google.com with SMTP id 00721157ae682-8961cca9193so49831907b3.3
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 22:44:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790055863; cv=none;
        d=google.com; s=arc-20260327;
        b=TBzDwLwEZwSP0Ptrbr0/ziDxwyDvU5grgaRPTjhqHxtnjmKw3zfSgVDsI5Z6LAW01t
         cgOnlH/GtDLMeSW54hqFZd/diEMaqeBP2m+8lJXOvEuq1+4cKYqLQsiNo/1/aSxShCVb
         Lk+yMG75QGTH8ijOljdgZpvMt7TzaFuqu8rgCypjYSpY+pN2yY7/RSoiL4ex1e/fl7OY
         OG1lgEDoOugXRpmbX8max84iBdMVRiKv0ZUIYGt7aNwZcLyaGashEZ9lt5jhY3fzMDg2
         NB4AE5+HIGmY8UtzZaNf6kRMqjmI/tNzgZC5Z4IfML8RTVbqkt5foJ6XCmoAtJafsyfT
         Y+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        fh=en1Ypb6i3dzCDMqu9F1KlPpjCwRtJyxuoetwtC1R18Q=;
        b=LDUJaWCK2+BjUGrgcJAMxEaqrLXn33qpvB1xSFzBLsuQQjFww6EAUCAxhbx+/YWcQH
         0vG8mJeN6MtBAO2VDqIjIUq7Lcs9FUOkF6hWOvdtJ/c0UgMCIKc3z75XRcPqMOTZjzjK
         oYai8UlVRPmPwS5f1HwLNJJZCI2MpAL4dsemGaQoIJ5PImGl5RrDrq8R9B+15ChJANQS
         C4lGRSxHMbojRvkQJVJ4uKVwEUuergRUYKn3/ffXLSzGFeNUTPYdNAcJBQ8KNJKbKJc/
         wWoVUWo6Y2ovdxVmfIr868qpBqMR+yKIsk5iQ2yKhCBUGvMVbrCm6Mzio44kz8MAo9JB
         ueog==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055863; x=1790660663; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        b=SKfKvwbbceLpa2n1GU2mADy3FcNlZ1e6L1WYfSWXphPmLulWU79JUG3ycJxUb0EANs
         GjFILB6JpcFaEZMVmmPd/Ha4zcwb4SSi9IN7b0euRBoq9ftbTXM398cXELt5kdmVSpbU
         hOsR6IKGFFPWKL804muIds+8xh9amKAT/ShAcJRDmO75UTHkOIyAcRuwseIOEevnRiSE
         Z8amWrDR0dXctUirUk8E/5heAZgTQklUYvF6sbNTKlJPqaozBm8bwMoyG/o27X7wXcmO
         HzShNuS3P+c13glyz8Rwnmh5TnjRmPvz+6VdMly+ox8nvoY5aFDOjQJlEmXassbAhqEI
         wGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055863; x=1790660663;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mVQSIA+KZumLgnewVGIvAtxnjvVRKy38ae4smjKb/as=;
        b=yzM5rgURYauvU7NepJgj61HNtH7KuqHk40x3F/Ft1RbQfMNtfxP12Ai1gJo7Bu9lnL
         FuQ08N2ica3t/T0Pj15pV3T8KRP8o+yWzcw9O1RFwfgunMhvPjzV63VBqX0gJ0P0xfDj
         vPEbUydawu9YMqMvov5ojns8hSRA91hTugXb2it5XK87S4t+9qYty2W/wZIKlEv3/JfL
         VvnxkMW1QFfoMXQ4nx/0zObv1KQ02poPHt94uKREH4pgI4q3lbbk+Mi2eXI1zb0lNYQ5
         CKfEGL/k3h7QiigVy2syF5zWpJcQC+BVB0dIdc0opUjbECVzrCMihObZPyaX9568M19u
         XD8g==
X-Forwarded-Encrypted: i=1; AKwUvBwzASrXWjRKIrJA/xbgcH6Ai84x6Fxfm1qskIZUv2yBHAcZs/ElZnywyHO0G1n2PUAYPIP4ES0MM8pYz+W/ng==@lists.linux.dev
X-Gm-Message-State: AFuF++mt6NBDDyH5baFfPcseu3P9hMHzGbSO2faAej6ewtAdpDqXJQp3
	2g08OhwHREYSgX6m++ImmRWhY+Pl2aeXtiOlnIrcPESau7tbGcT/IyyvP5AjdFFbv1rjrR/9Fg/
	5hfsRwsNlLUATkhFcllzgXCgNZjSVz7R2H//xZne5cw==
X-Gm-Gg: AYBFou3IvGUrvh87vbV4dD6uBICvvDogasya50d2sTtjXKFB8ze9zqn/eK3dyEwbsEB
	sXaUTKDd68In+Wgt71a/ISKdonZyqpPxkTYRpDA0jfoy2mQSo94Fqy3Y+52UPqwoFbIIgkiAe7O
	q/Sh+pQW+zHozYWjp+1egR41PQRBJXH6uFj4tmp6YSNnpSGigqRyV6kvFqbLNQl5fGcHYph2S+b
	YhcwmigVz3W4PBMpE8pzLKa1WM9av9uGEz8lmGjbQGvn7Vux3Ld4t1tcPsEtepfB/yGTeC+dLJL
	pnIcmCpaHgpO5JJ2bvuWxMgkIkS4vzsQVeNtjeGFcXRFkXP28EwjiBM=
X-Received: by 2002:a05:690e:140a:b0:671:70d1:d6e9 with SMTP id
 956f58d0204a3-6717fe6484amr3963390d50.91.1790055863048; Mon, 21 Sep 2026
 22:44:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260922054116.416333-1-oss.patchbox@gmail.com>
In-Reply-To: <20260922054116.416333-1-oss.patchbox@gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 22 Sep 2026 01:44:11 -0400
X-Gm-Features: AcwNN1X4U-FOuecLC7XSWshGXMtdfg5aLnegDD7bITFGtDrk_TB67QveNxFm1nE
Message-ID: <CAGG=RgCA4kAbx39LuSRiKu1sx2CbTEAhZH1bKNCxPn5i1m=x+Q@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues
 on probe failure
To: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, virtualization@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 01:41, Yuho Choi <oss.patchbox@gmail.com> wrote:
> 2.43.0

Please disregard this patch/thread. It was sent inadvertently due to a
duplicate submission.
I apologize for the noise.

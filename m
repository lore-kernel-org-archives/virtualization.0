Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484C6270EC3
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 02:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296693; cv=none; b=kAv9zH31ghaa7+ScH4FAwhqS8FyRC6SVcTxLBJfBFAy1mIDBUyuuI/zYkd8y1+tW1GcSTE25R8C1Qxv77T7XaH8AkVR/IsXDGG/4Ji6FZF1Bzu0dsopJBLXOM2cuGFJBfoimeH4CpF67IoIn0X2bferQ17U/96sZQ6v4sYqfTV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296693; c=relaxed/simple;
	bh=SeI+TVyebkKn9n6WshCVjn01YGmtEiWhnNDz2vgPXWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+fjcZoiPOYehhrKENmwVvv3rgs1F+fe0EnBLMnN/4n+8109XbsN7hsEX/61+kgYmbBtHlSN0UT1zGd3t8bNdOhpSCchPEYLl3Zm9PrcLOUCMq0POWU/szvmjddCfXVnH+pkH9DBHUwiST1rg2BRMtQKAKQxVVcgn73YKH/8RiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGnjuN8B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGnjuN8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764296690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SeI+TVyebkKn9n6WshCVjn01YGmtEiWhnNDz2vgPXWE=;
	b=eGnjuN8BGqQcM4zTAGKZwloaHW/ze5WqsZYCHIGScQtpCpE52wqqaY2kiYyN1Fd1jL40kQ
	50W9DDZ8xHwBjulhKhNkh2Ij+QM2MHIiPhCb4eaE8/DapRQQVgJqy8EwR5Fh7gdfrYf4xO
	rJFQTZuht7FZ5qy0LbPpY0rAznA7QQU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-GZ_u-pSWMiqgSfSQ-ENQng-1; Thu, 27 Nov 2025 21:24:48 -0500
X-MC-Unique: GZ_u-pSWMiqgSfSQ-ENQng-1
X-Mimecast-MFC-AGG-ID: GZ_u-pSWMiqgSfSQ-ENQng_1764296688
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so1373413a91.0
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 18:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764296688; x=1764901488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SeI+TVyebkKn9n6WshCVjn01YGmtEiWhnNDz2vgPXWE=;
        b=B9x2Iguw13hEdzD5eV57yxJQF45uREBx+AyjuU71C5rRJh9yFbbM/Qg3SIjq+71605
         dCNYEwM5jFATol49ojotxSWPZX7nAc1lU6hemA9mii3s5Ntyg8ODuxBH374JyNlbosr4
         8MmrXa0yZrG40dbGtme5NmYrf8zm0yOnrEpp8oS+SMPY/Obf7wq3ui7UYtcKJ8pdpCZH
         CxSNDOh6DxJb72AdzYD6/GSp4jgpaBR0NvZJvKP+5S+Lu4SpYxVPQeRag2cRDdeesebG
         aLBh9cjVKuUZUy2qNETzdpUXtpl7S3Z9RZtuqYDi0fUlCNOTA98ssMUrgWioL2vDtEms
         +1jA==
X-Forwarded-Encrypted: i=1; AJvYcCV3NjQSRUe2z2uywWLrb9rncVqJQR9o40PT5G4Zeli0d1SW12qjf2Ldwb9SuOaGDjCrUwiuEfmCrWXROn6sow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxhcmk1edyl0Z/eWcF83XvaZGaWJozPQ2e5Wqv1vSDghx1qZyrC
	/sZ2t1JmcNLejksGi4uG1C9X1Pej7rQIsNoIF/oYj4vj+g8JgMmhBwYWTEZZBvaF7hvCU/EkK9k
	xEGmKKFrT3CXrSUp+1Tng86M/tFQfw2DFkQswH9sWZzTS2K+YsXApEdSuRsI/FC5dgnj6UJbQEo
	qfF6RyL4wbhS28gpHdmbhFsYRly75baASljCKL7nHbDrk=
X-Gm-Gg: ASbGncvlYVwW0yubYT4m4LsW/g9emGtEJKYMcZ+uOKAFQOV5rAMxU0dIBAk8xSaqvBb
	rKp/SOXeil5p5vRHiz0QKpOKpiuE/F+8VEEr1Be5UBppddJW1D9+OINcruk/Fg7CWybRvfhfiNC
	Er7ZKiPesmnMjuHkLsiYapZaItUnHtu/7RTFIutgzyGDl/V/ZEnL0f6avI3BgzlSUI
X-Received: by 2002:a17:90b:1d52:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-34733e74e73mr27360935a91.15.1764296687737;
        Thu, 27 Nov 2025 18:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj9BEk0Ik6EoWAHuc3RrSAi2PrSP5YAgIrIdyDejUFxc4KO7rgGy4L/1piTb4aGQSaudHJFOxdC+ivaQN6JYU=
X-Received: by 2002:a17:90b:1d52:b0:32e:64ca:e84e with SMTP id
 98e67ed59e1d1-34733e74e73mr27360923a91.15.1764296687345; Thu, 27 Nov 2025
 18:24:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <202511261140162936986@eswincomputing.com>
In-Reply-To: <202511261140162936986@eswincomputing.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 10:24:34 +0800
X-Gm-Features: AWmQ_bnQhWhOtM96WFtmcGNa3pKqKxHo3QthVqjbCPquSgFUbPbwAkW5AEQRrwc
Message-ID: <CACGkMEs4r6Ovd-HPSLOt4xkTFya16usmQh0ti407bYiQrQnn_A@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: code cleanup in detach_buf_split
To: "zhangdongchuan@eswincomputing.com" <zhangdongchuan@eswincomputing.com>
Cc: mst <mst@redhat.com>, xuanzhuo <xuanzhuo@linux.alibaba.com>, 
	eperezma <eperezma@redhat.com>, virtualization <virtualization@lists.linux.dev>, 
	linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gLbCwFX34SiHX4T4alWHoH_k7-V6nty3249fAxG1r5I_1764296688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:41=E2=80=AFAM zhangdongchuan@eswincomputing.com
<zhangdongchuan@eswincomputing.com> wrote:
>
> Since the return value of vring_unmap_one_split() is exactly
> vq->split.desc_extra[i].next, 'i =3D vq->split.desc_extra[i].next' is
> redundant. Assign vring_unmap_one_split() to i instead.
>
> Since vq->split.desc_extra is assigned to extra, use extra[i].next
> instead of vq->split.desc_extra[i].next to improve readability.
>
> No change in functionality.
>
> Signed-off-by: zhangdongchuan <zhangdongchuan@eswincomputing.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1E4A33E6
	for <virtualization@lists.linux.dev>; Fri,  5 Jun 2026 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650001; cv=pass; b=YvITxO0l83HKjPUpZq4SdfFfBnWpAIfj+EAWj6TxELY4VuyaoFj3X5sbw3ZeNYuWUnE8m9rcc3HLoTz1gZ0bHYulBlnluPxBwLGJKzxGSe5PVv/hSNwk7kjp8duXgIIEJeZFQS1bPNn5vNfN/xnZtH39hWrzs9k4b4p3DeJi4Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650001; c=relaxed/simple;
	bh=+69jET3sPzTIRLxYRfEka88w0addzfcukjBS7PxpxGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbtEMcKyvXf7iE2n+jdTQ8rFIEB4xug4dtJGjm33IxJnu0v6I61arKS47R78d5VUiBxuyBurIekLQz+GPJ/gQj1F+Nu87/55/+AWWp8faKKRpljI+qZlZhlf9K2MHtrEEvinhLnXxPbaVh0yLkdSxZABt69kumE+tiAL++2fchw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9BTBM3C; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9BTBM3C"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b64c8311so19412855e9.3
        for <virtualization@lists.linux.dev>; Fri, 05 Jun 2026 02:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780649999; cv=none;
        d=google.com; s=arc-20240605;
        b=RoVx4tpW5Hn1aPmwekk/IRBlJB/dU6Azn9xf7uvdPm1U7yBLY5NFnd1b2bQLqCP4Kw
         NUZ4E+RVPG4WPhO/GBr2kJGYNoDY1WREu5yMUXqtSyU791SSxeQeuB5Vkm++WIUzDe8r
         pqNvkHm5+9PPOB3orTI143a4WzRjMedvvO+IPCtCZw5dtb9nOn3NO9zEtcZaftlzPICz
         nfPU6Gv63Er+VxXc2PW6SA5zCA8IWiTdJ8dsRUCMNhk0V4hwvUQe9tyaPxjUPvS/oB9w
         +y2rIGT1AAdSbZGAsRqRcLQzNx1RPqxfj7xhaF6XzRsGPvHXtAU8fFAXfY4RMu1gk0x+
         t1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+9j4C7TDzwMV8RmNmd9sGvuEeJG/67BcTV/Vmljr8lY=;
        fh=Su1C3n2lMUrQiX2a1V+IEXtx3YrBKltkd5Rh/9/idh4=;
        b=HflO9aOGicL6EMejb4ezKv/tVqFrEfftccSEzXZuN4e3ptcA9bB/nOMnnYTrZhCG62
         EPN2Z/mKKzpr93qSkHVdjC2Jb6WkW375NbVc1O7y7rBYdPS7d/ikeBgkzQnDYCdFIzEZ
         b5D4RIRU/Tp1wntQ+i+L/GQpUK3N65eAC5pk666wGoR7JDMpNwBotcnI1/lL7JRvVkYs
         770qpXeuFLDu4Ud1EzfQnFEHq8caWhHfwCnrDt7uIjq+53PceKtKAF4MIJ4SZQs96/sq
         UsKkv4kYvNjWRY+T/GFak0hEW8so0xmrbR8Lhx4FtUHiZyHsttWD/F89VerUlLz2s3Lm
         kyRA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780649999; x=1781254799; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9j4C7TDzwMV8RmNmd9sGvuEeJG/67BcTV/Vmljr8lY=;
        b=m9BTBM3CwhmxUXrSMmhmmT8/PMAPvYy9hGdxd3K5lnaKMiaPfgwD08L8ZixbY1++zK
         r/e075BReav2tBUPk3AB18VawEsu/VmBUUavWnr6aadbfP2UL/xFfv8NECKKLc2J0cB0
         rQIDabPWlsRXlf650JCfFhp48ikkoNlz5blH/LR/oN4kC2OerW4ay2TNwNeGV5Rteo3R
         fojV1UMw/hGgmTXyUL1/BMXf0ixq9QpduYpFxcsPxAtDHiZhTBqehLwUojbrToZw+J3C
         GAe3FP6ZGW4Wrqid5vOGPgY1w0OyVbfOlYFJK1vZIh0Lk4ZcnJZIvQobdm0xy+215dEV
         KaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780649999; x=1781254799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9j4C7TDzwMV8RmNmd9sGvuEeJG/67BcTV/Vmljr8lY=;
        b=k3+DKkrolJrwazoSq/9pc/2r8hcA6GHZM9YEh+ci9MIMUNjRp8jZNi9qjchhqLgOJh
         3ySz8yghOxlMZ3BkkpR8/5oq2ngFfITiG9QIlUMk1y7mKG2MNYm+2rzwbnvp9lvr7dcI
         WEyrAsEJZH47Deop3pX7Ar5tEUygt4Dhr5hFNx1oVC5UPL4khy9/Fu+RFppK1tXE+wZ4
         Xaqz40vMNY9PXCptiQpqWV+JPjTYmcanj2N9HupvMoE1ER2mys+P2iWnVPAmppX64Wcd
         a9HUzYV1LXCB7PRibT5kc9W1Y1xRdwnqAPE38rv8KQujb53hcnsf82rxsCIwu5JGNQwU
         2qCw==
X-Forwarded-Encrypted: i=1; AFNElJ8unkMIZulYJvM7niPE9YPeLjog85CCJyqsG+I+Yp5iBXBhJMqzicVgbapCsm0+58eeISFD/eWLaiz7A1ga6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpHQMCHlZ5eB7KNp9ZjTJZd+oiywTyTyiTTVhmSV5XQU3BYpcG
	RCoPtPvkQNHaMrTtH2ShuYUw6sLTS1jNbhEgoaWla6IaVYsb3VNmRNN1bSR1UbRdgT6xibDenCV
	AYbWMoa9Wl8bBUxV/ZvFnnQ63yzTZHmI=
X-Gm-Gg: Acq92OFQnMZXaTI/B7PS00BckeBuJBo4vUSDC7+KRD+SZTZuq+bIvaO921Eq6hDEjru
	ol2QcbxWQpt/IKFNPWeNDKOheA26UBjRogFgQB6c9kpDBSPoo1jwRASJNHS3DS6y/lfB7xjsVA0
	zpfRRXGjQ4VWIuQ4XFg/HEm6wTBI93HynGtAVirwHEt+uBxdepy2p3J+1Gmem4rEVLiILv2/HOn
	5XQaSd8io516ATmbQvLTfK2IHZ9E70Bx7IoHUND2yD5XwqTKN+coV6YD172z+/p3O3XmCNUMn6j
	XOA3zEypEylG75hpDQ==
X-Received: by 2002:a05:600c:83c3:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-490c25a5970mr42347545e9.11.1780649998773; Fri, 05 Jun 2026
 01:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com> <20260604051816.2976221-3-maoyixie.tju@gmail.com>
 <20260604160449.GA1619938@myrica>
In-Reply-To: <20260604160449.GA1619938@myrica>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Fri, 5 Jun 2026 16:59:47 +0800
X-Gm-Features: AVVi8CdK0JDSYbPv2SXFkVYgx-B7FQNtdCi4lej63CZ72gfzcG0R9dwk7SuQPw4
Message-ID: <CAHPEe=HV+wpgg3YMQcOxN5M7c+ew6MQRgY0YgW-3KgB91gn_sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the
 loop in viommu_add_resv_mem()
To: Jean-Philippe Brucker <jpb@kernel.org>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Jean-Philippe,

On Fri, Jun 5, 2026 at 12:04 AM Jean-Philippe Brucker <jpb@kernel.org> wrote:
> Thank you for removing this hack, though I don't find a contract in the
> list_for_each_entry() doc, and the fix still accesses a cursor outside the
> loop. Since you mentioned C11 UB in another email, do you have more info
> on the precise operation which is undefined in the kernel (container_of
> into an invalid object or the &next->list addition)?  Just so I can avoid
> it in the future.

> Anyway, thanks for the patch. If this is just general cleanup that's fine
> too.

Thanks for the review. You're right.

There is no such contract in the docs. I overstated it. And no undefined
pointer arithmetic happens here either.

iommu_resv_region has list as its first member, so offsetof is 0. That
makes container_of(&vdev->resv_regions, struct iommu_resv_region, list)
just (char *)&vdev->resv_regions - 0, i.e. the head with a different
type. &next->list is the head again. Nothing reads next as an
iommu_resv_region, so no pointer leaves its object.

The container_of would be undefined only if list was not the first
member. Then the subtraction lands before the real object (C11 6.5.6).
That is not the case here.

So this is cleanup, not a UB fix. The typed cursor points at the head but
reads like an entry. That becomes a real bug the day someone reorders the
struct or touches another field. The new pos stays a struct list_head *,
which is just the head, so it avoids all of that. I should have said that
in the message.

If you or Joerg prefer, I can resend the series with the wording fixed.

Thanks,
Maoyi

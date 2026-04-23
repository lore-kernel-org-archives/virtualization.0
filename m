Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C536495E
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931924; cv=pass; b=Lt2GHYIJRrgJ6xZTd8YIZfjNRxUkwXker8k1nyv1dITs9W8CG99JWS2vxNgo6JXccoG8Olkhj1RDhRTQJIJFE9GqYkCCafvgAzklqv+JZ4AtmRIBqCozE6qxPRpO4wKCp0FTg2k0bksRw3Rbr8g02v52jppcfT9pfSfliR9i8mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931924; c=relaxed/simple;
	bh=FBFY+j9O1ezwGMt8wjE4G7Wepfqjb6qbKfE3J0CWqXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQLtaynPkgtFzVPGEeZD+kEZHGNJc3c/3xpYR8dnQxSA4T1FENrlu7hKwSxmOd5987QBWPsVv3/EnRHBLabAq8DhXkT+LkDGJhiiKYfmiHYaqyjZ3tL0BlKn3LISO0AXYjp6Zof7xQlsuO+dS/z66VTUmE5w2JfJUD0OqSBVxyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DCe/AKkA; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DCe/AKkA"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a40b2d26a1so4972587e87.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 01:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776931919; cv=none;
        d=google.com; s=arc-20240605;
        b=TQoRaZPrUxMsh7CT+yfvP+XPRYnnpnxyyYe2yyrv0YuZmJBVst7KUlG3TPzYsru58b
         TZEfHnIyFI4x74sFgPQDnGK15SwLU50jvDd4x6VsojoiyrgBz7CqRZOfWiTMNqTNLhsQ
         rt0fUUoos3gufP6vIo2ShlGki0IaUr7ul8FevR50tZ4o5e6RNvXNrSVkmrV9Oaa2sN2n
         6nDdS+MskNq9dcJeH2UNvCCpwbfQ0DtTbBDhEmbV0v9IHkMQ5Ddg65SM6i5tpPBXtJlf
         h5GOx3sS178OgUWMptlAjBicIj1x1S26qMPe8LbMOlFsgMEwVLiSwMNjuOVKBVwu5w7S
         ecag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        fh=fsHDdsLV4PGdNuCXLs2Cug6BkDsJiQnzXLrG36zAAwM=;
        b=lYi1vTD5T4LHXHuaRou3O7MJsc3rPn1Mq47Aq6cdjhoRFbI1zyOmkUsrq5nNYx1Mfe
         OLCLj3T4TTtN5B/bMuOioDSp24og6OFje5mnQYpBzr9AnLkFEvj4QdznSVjeiglSEiVF
         8OYyq6xyZqq7apJUnT4e0NgNAGRx099k/ppbtJb6mgayM+ZWpjpS/PltgFKighdL3WH/
         3mA157izIZHar4LAf7C5GataLpLeX6sR6vZNSWX60ni7VFZnq9Pal7/C4XTzcXCiyaPX
         KP4ZI1vTXT/38tXHcANUx4l8GJyhDiYQZOvog1TzIMAH9iK6EtnRV+jP+rDemjHt3Mdn
         CwKg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776931919; x=1777536719; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        b=DCe/AKkAClcaSoPqr6sEnn/9FIi0b8TyVi4FGE5slWfGf0F4Dy7hgy6mswFA9XHNM7
         yo1c7026u3HCDzlnpb2V3Hm8UFZMgUjgPmDoP3tYrbYwGTTkNt8irdoMQH+N6ZTxQ4kq
         OcsDBMRhhKnuxgT/CzIIbR7qdTSE31yIyXWRHXuWnuwXeT7ldQEaZrg7EA1MjV5yUBz/
         ebUEwy5Dk+IYr8f9bS+WHR7jSJC6EY9NJ3XxHXYOOw4/CcH+cMT83GAS072m52M2BvTM
         vY9QIpQ9ba3ugXQU5hKpUf7ilScEQXUaBCyhx6WQd86Z4u1xGz0zDVnH22EmpI1MfO1x
         6XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776931919; x=1777536719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1TJ69eD3+dlZgtU6Q/SGAaN/1k6mZejMgKlXmY0+Uw=;
        b=GdgyaeLuFgmSm1RSKb2g1L/tr1O9nD6f9jSkCMAwnuSiBeBN1JKee2LYTJ5IElOq0Q
         0e0nEzDzLk5u7SmR+xKFffDR49fQo5wAeKbOJagMmOWOt6RJCCh9MIu71B2XKMgKrtNW
         7hgdKdUV3O3dW+GOOYlMRzJ3kpjq833PTmtFa+/V76qMzn2ROpO6JzS2km4yNNRrZyMC
         mmSA6Htrs68UAkgfsyJahm1R/6echw7EJzU5Zv/FOogpuiH5XMsYIFrvLCALLR+tnXlU
         AUtHPYRABzlk/VjFded9EZZaFptohk2MZblOsJzKn6v8EbPSndDA7rpb3OBLYzCmHgSU
         m3zQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WaW2zIeBo6s0UFn23sk7ToEhFdrxUpKq1zmrUQ7dSrOWHa3hEeLaDhd9V4selc/O0t/ChjFUPh3KR2VFrhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtLnvA6aSSsPHuVw9aQ9iAgaSaMIqy4H+fmJUjHCBEaj6ziwWO
	midJVUIEzFts3t/FoTXbzfSf1IRhAdoBM7Fe8iRhUuwcvl2LYoQ2IHLJkoQwLojg2BSnEfyvmBJ
	L11WUNUoiVF8zhCdzNM4bwGbXj+/jc3shYC9xmdU3/A==
X-Gm-Gg: AeBDietU35scWV+Au8+caU2uiYqPX2C/YaqvTChXxYIzEAO8teWqHEgnkYGlD1g8sph
	pqwT+PYr8SlxrRi/kFfN9yZE+jhtA8GVl1PC09yZJTDdHhsutL7jM9stmagJ0Hm/w4f36+W5abS
	gQXSRncjZK8wrLGzbtBtYfRYZPsepix7VncAlJVc0X3ueLFILPNmbAsilqg+SxqrHg4RyF+yRdd
	lwGQDfBEEqn9WM6IzP54JzuH+Q4WiROfnFM93vKw9Lhq5NITtPuMbGORgrzyDg4vZzWazZhbKAv
	Mtq0yKVFTHk3bwhgGBBnUZ+lYrBlJv2hitY6zIBboDML5TEpM6I=
X-Received: by 2002:a05:6512:3ba6:b0:5a3:ff60:b72e with SMTP id
 2adb3069b0e04-5a4172eac66mr8218916e87.39.1776931918554; Thu, 23 Apr 2026
 01:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260416192942.1243421-4-atomlin@atomlin.com> <20260420131152.243488-1-marco.crivellari@suse.com>
 <tfkr5mlsdzbhdzv46ookoy2e7ed2wcozuxanv4wagjf6hqb4sa@7i753lpqkxvp>
In-Reply-To: <tfkr5mlsdzbhdzv46ookoy2e7ed2wcozuxanv4wagjf6hqb4sa@7i753lpqkxvp>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 23 Apr 2026 10:11:47 +0200
X-Gm-Features: AQROBzAAJimGp24FdJwHT7vl8MEKvFnP60qRLQ-HOdwRzLvk1TNgQokO0fGWBCw
Message-ID: <CAAofZF5+igiyR8vne9We5tnfouuWNO2H=BdwWbFCN+gnpUXoVw@mail.gmail.com>
Subject: Re: [PATCH v11 03/13] lib/group_cpus: Add group_mask_cpus_evenly()
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: James.Bottomley@hansenpartnership.com, MPT-FusionLinux.pdl@broadcom.com, 
	aacraid@microsemi.com, akpm@linux-foundation.org, axboe@kernel.dk, 
	bigeasy@linutronix.de, chandrakanth.patil@broadcom.com, chenridong@huawei.com, 
	chjohnst@gmail.com, frederic@kernel.org, hare@suse.de, hch@lst.de, 
	jinpu.wang@cloud.ionos.com, juri.lelli@redhat.com, kashyap.desai@broadcom.com, 
	kbusch@kernel.org, kch@nvidia.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, liyihang9@h-partners.com, longman@redhat.com, 
	martin.petersen@oracle.com, maz@kernel.org, megaraidlinux.pdl@broadcom.com, 
	ming.lei@redhat.com, mingo@redhat.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	mproche@gmail.com, mst@redhat.com, neelx@suse.com, nick.lange@gmail.com, 
	peterz@infradead.org, ranjan.kumar@broadcom.com, ruanjinjie@huawei.com, 
	sagi@grimberg.me, sathya.prakash@broadcom.com, sean@ashe.io, 
	shivasharan.srikanteshwara@broadcom.com, sreekanth.reddy@broadcom.com, 
	steve@abita.co, suganath-prabu.subramani@broadcom.com, 
	sumit.saxena@broadcom.com, tglx@kernel.org, tom.leiming@gmail.com, 
	vincent.guittot@linaro.org, virtualization@lists.linux.dev, wagi@kernel.org, 
	yphbchou0911@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 7:47=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> On Mon, Apr 20, 2026 at 03:11:52PM +0200, Marco Crivellari wrote:
> > Without it, I guess the kmalloc() in `group_mask_cpus_evenly()` will
> > return ZERO_SIZE_PTR:
>
> Hi Marco,
>
> Thank you for reviewing the patch.
>
> You are correct. If numgrps is 0, __do_kmalloc_node() will
> return ZERO_SIZE_PTR.
>
> > Should this check be added or it is not needed? Or maybe rely on `ZERO_=
OR_NULL_PTR()` ?
>
>  - File: mm/slub.c
>
>     5275 static __always_inline
>     5276 void *__do_kmalloc_node(size_t size, kmem_buckets *b, gfp_t flag=
s, int node,
>     5277                         unsigned long caller)
>     5278 {
>     5279         struct kmem_cache *s;
>     5280         void *ret;
>      :
>     5289         if (unlikely(!size))
>     5290                 return ZERO_SIZE_PTR;
>      :
>     5298 }
>
> Regarding your suggestion: rather than relying on ZERO_OR_NULL_PTR() afte=
r
> the fact, I think it is much cleaner to just add the early exit at the ve=
ry
> beginning of the function, exactly as group_cpus_evenly() does. It avoids
> the allocator path entirely.

Hi,

Cool, I think that's the right thing indeed.

Thanks!

--=20

Marco Crivellari

SUSE Labs

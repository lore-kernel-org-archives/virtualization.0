Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AF3CF976
	for <virtualization@lists.linux.dev>; Wed,  5 Aug 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951975; cv=pass; b=WG3rC6Gb7ynuARrPqJlqiAaE+NHqY/FwV3Ga+5Ylchx506VCtdvupQLFsz42XYPKLkYf2UBBN+5Tyy9knXLuvTDquWANlRF5IK5YUNxneFoglV9qDMB5TafAdqWsUeQCvoqOcc2NaubNEPsaLDFzR0METpVgJB9NfVXMsQSVHjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951975; c=relaxed/simple;
	bh=Q8tCfALbF5G8yrnXE2kTrpygCvYojp+VnLyrKYqOvPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYeRZJvTH84YauuELGAcJxdfg/bAQDE8XXRJG+ZgUCdd9BMzycD4y2N398cexkfhImVBafxAwz3QzwlhxtzRoeYsXRv0HRJFU0mV5/Aj07KKJG8+oqS3vMf0AM8Vi6GcO2ME34iJ+J/6GwAuTrr3m0ylCM9I8hioLGX7qh/Vmdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfsj0Lat; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfsj0Lat"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a10b20634fso2235174a12.3
        for <virtualization@lists.linux.dev>; Wed, 05 Aug 2026 10:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785951972; cv=none;
        d=google.com; s=arc-20260327;
        b=KkY7rNwPEht4Qg8cF7ADzL5JiUSEP0atA/D7SlLSVoflgQsHoMWHDa9UhQWEwUtl7r
         985OFToxNCaLaOnr8CFOBPRcqnGBina3Oe8KEuE77qLJ5PVy6dNWhghEkktjE22KkdqB
         DzMMYmWfFtrwhkXmjLcU32ryBAY8wqYNYaNIRoy2FPCDpcbYxvnwiAiYzdVp4B+cG1gE
         J3o9VqddaypH7kTIDIkQlaMwVhcuZlWrqcLHF00Kr/CjYS099Y6EUyYcpaZIP1DqI32m
         uEwbOtyKuTSArcogvWWtBJimbmf8d5MHMD3SXJK3zXzq9h92rl4yrI6NPm/2zZdPzAXa
         iuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8Wl/efK7JZ+Giu9f6qAvq/D3h7y+eNbtsicK6kfncc=;
        fh=+aIzL7kTXvAa4aLW9jiNX8fhxxG9pPq+J2kuQzmIyOE=;
        b=s2mc4rpSh94E9Gy8EN0l74UwORqz7Jz4ZSkAQ1m/0OjR+LDI5n+HCr79jzrgxZ9xIs
         ziP0qcYfib+2kVPBU8K5WqxWkqd2FENJfDSciAMuHjSJv1fPvZZL59rSYop0BKv9gzQd
         GlgvFMVk/1ejy6Ec9JcI5AJ299WIXpxIZffMkwVAWJdOczYB2fYWEIKHJVMECUNnl2f1
         M1HPjpOPQMfFl8GyjFEMCN3gKw/L3DQOaSD6spCiIHWcakszLRB8d2JSXAX7sOuXKzVT
         Mx6jT/hhrs1rYnuoNpJnw9XjWDcp/umKQmrb1suf1zbD9Zf+sH7TlonChKG/SIP5q5ac
         g7Cg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951972; x=1786556772; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X8Wl/efK7JZ+Giu9f6qAvq/D3h7y+eNbtsicK6kfncc=;
        b=rfsj0LatxYkqmngwzJhQa+DN0ShJsOPob/C2dPG1/lIsWdj5361jMq5HAw8YQhap+2
         zI/ix13PKONtG+aoX5Gm9leWqqERM8ysMZ5hkVYrv+v7tcrQoK8ww2xFITIH8OM8M/3m
         kKyTb+5mLi3Pg8Dx0New432FbrxH1nyNgqyj8cAFHXWgu2h614aa13Niu4JJI0pSiIQO
         M3QZ+PLWLkgtmc6PyaalRyu+dn5bfMLdLDjaV1pZ6LE7re55JD8oCEyYWU8zVdZDVY1G
         ratCTsvQFC/QjMnCUetBJht4R08IhzB0NrrgDLMHAuW5isA29EOOixpsW2ugio6YD5nV
         zJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951972; x=1786556772;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X8Wl/efK7JZ+Giu9f6qAvq/D3h7y+eNbtsicK6kfncc=;
        b=JAYGFypRDEHQCITODNtT3kWUANzgjk824MIbwnlcVsN6tgjl86cDItgTll6x9x4KzN
         vu0rUrR26RLMITPKiyypv8aTCRo7BFy2FX1KdUBHaNUqy+9vp/ztvMpcKysAoPcFl7Nl
         GbK53mNU2NupxnPCxfWrUxlqtz6lVL//Bg1VbxQ29dXvSNST+oznT3PLuhi30Ueu/D+l
         VPh4k06z3vN5L2VWcywaTmJBCfYhCrd7yQVK8OUpi/C9T4wEJYAkS7OhhWZRjMfWMkUD
         z8c6gT/6qv7pOnLib4cvrrt7pd9B02GHq3n/NnJ/xAycImqjvrC+IXRR2n2m1bCWjABD
         gqlw==
X-Forwarded-Encrypted: i=1; AHgh+Ro48V/gyCbH5qhxkJEYPKc5tGaFuY72zWgZq75dR5gthxZF1UtwmhjvfuJzhKbHz3H0YbqRiTEMuoNQhWcPAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTtCj14c08q8WENvJga1qBC/MBXHjk0WJmS18Hc1YHkTRsEcvy
	RKsHnnCNIY6FNwdk0fVT2ZZ/3URI0RWeat4DB4B3Y929PYEbjcsF9Q+maJp5KMXnlGBoNY7sQeg
	nwv1mg49dSqvPqsEtEUT60WuTYS/VoQM=
X-Gm-Gg: AR+sD1005gJ7ddbGMu79cdh8unl9R6ll4h7Ac/E5IptUy3JEOoCRlSJmomR9cfJrc+P
	iCoXyAVmontMi506kWM57/bPukg8K2DO2M3etEafBp+X4lkYJ8lrR+AKZGaFnewHQ7lIiCcbk4R
	ZQCeif3vfRh/TX9pQFhxV7FoBRrlKwxWH8rXxFjJ0Nl50CACfHU1OTVV2MiBcKPG4ejKJZlVkwy
	b+hDvasto2AphKLBEB6KJIGchGJvvQEB4ynX08yNLI9Jw9D9g6EjnxYuZAZ1T8CHDfE2UzB7fg0
	5rsqXZnKUEjL9cX9/nO4vvBBdY+ZPwXvOeHUh8N7eLujsbZxvV9ac1dqnn3mPvUnxDZY/ERvK2J
	tcQ==
X-Received: by 2002:a05:6402:190a:b0:6a1:2863:ad74 with SMTP id
 4fb4d7f45d1cf-6a14f14c013mr4248984a12.16.1785951971642; Wed, 05 Aug 2026
 10:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com>
In-Reply-To: <am2QeS/lS+Cova+I@yokbvdiprd370.nvidia.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 5 Aug 2026 13:45:58 -0400
X-Gm-Features: AUfX_mxaQ4QsMMCnx01DLxTc-If0eVI8Hja4hw7pleDzHhZ5Yt_Htr4wrkge_oI
Message-ID: <CAJSP0QVSBsg0_pCaxy8Sar3=G+sdj5Z8R5yNmUomGy+C5YrHJQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add use_irq_affinity module parameter
To: "Liu, Changcheng" <jerrliu@nvidia.com>
Cc: pbonzini@redhat.com, stefanha@redhat.com, virtualization@lists.linux.dev, 
	changcheng.liu@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 2:21=E2=80=AFAM Liu, Changcheng <jerrliu@nvidia.com>=
 wrote:
>
> When creating many virtio-blk devices, probe starts failing with
> -ENOSPC (-28) because the system runs out of interrupt vectors:
>
>   virtio_blk virtioNNN: probe with driver virtio_blk failed with error -2=
8
>
> By default virtio-blk uses managed IRQ affinity, which reserves an
> interrupt vector on every CPU for each device (about nr_cpus vectors per
> device). On a host with many CPUs and many devices this exhausts the
> vectors long before all devices are probed.
>
> Add use_irq_affinity (default true, no behaviour change). Set it to 0 to
> use unmanaged interrupts, so each device only uses a couple of vectors
> instead of one per CPU, allowing far more devices to probe.
>
> Signed-off-by: Liu, Changcheng <jerrliu@nvidia.com>

There is already a num_request_queues module parameter for cases where
the user wishes to reduce the number of virtqueues. Did you benchmark
that and decide the performance of many queues sharing a single irq
makes it worth adding another module parameter?

Stefan

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..184f1c1f4485 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -41,6 +41,11 @@ static unsigned int poll_queues;
>  module_param(poll_queues, uint, 0644);
>  MODULE_PARM_DESC(poll_queues, "The number of dedicated virtqueues for po=
lling I/O");
>
> +static bool use_irq_affinity =3D true;
> +module_param(use_irq_affinity, bool, 0644);
> +MODULE_PARM_DESC(use_irq_affinity,
> +                "Use managed IRQ affinity for virtqueues (default: true)=
");
> +
>  static int major;
>  static DEFINE_IDA(vd_index_ida);
>
> @@ -1016,7 +1021,8 @@ static int init_vq(struct virtio_blk *vblk)
>         }
>
>         /* Discover virtqueues and write information to configuration.  *=
/
> -       err =3D virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
> +       err =3D virtio_find_vqs(vdev, num_vqs, vqs, vqs_info,
> +                             use_irq_affinity ? &desc : NULL);
>         if (err)
>                 goto out;
>
> --
> 2.43.7
>
>

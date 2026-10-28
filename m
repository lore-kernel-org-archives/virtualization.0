Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201943;
	b=E23j1CO04pgVMgEk1rgZcdE+9Fx3vDUABMEA1zZ77KyFLJaCQjJu63//Skc5yT2iMki7
	 obPG7uWV3d2fRnGJyugBDzaSjfUdWD1hv5wsyWjn+5ho5qoEIX8JiUCS8LZBFVaxmFv1z
	 NKiGX3D5r39UoO6wMHOjX3CGS3TeAdxIUHaOwNpszcvfYv9s8EHtdGCOMdgS1IiRmKMVX
	 tnmaxaNhaCLrwjz4X2nApxSvcsAYmeD6KyVJGLGnzMcOIszky69jRkAwKZJU0iCoFQFsV
	 un/BYX+r3grdJ+2l5bgGlqdeQQXc2zFcdx8bc30QvxeT4Fuobit06SwrB6DKJ7KGUVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y7xxxnWLJ3cqzVXeSgOYrxm108qFnX6tdnhI16mhQOo=;
	b=IYgzjyxzkIlTkRRvvO4i847WpihoA/hA0qza7atJskwAOS8yLB+J4CBF95RYBOr5MAqO
	 n/o+F+rufBHFSvjUaeMHgzFgFYm+tM06upWr6/kW6z0jx+bydbQNnmckGSiq0/TmE/+Im
	 lzyBO5yM4gHuyAECxoPK2/jS2b44mbQO9qCHdiJR+vgql1Uf/KqFT+t3580EmRgM0d5R8
	 wfh37W4/gDmhQd60VhPGjOH+gsfoHdldEJ5/wIC5EAVTroo5aZwvsZpoDSL4Ogd1C4w7X
	 nCbVRBOpCg4OCwQr6UScnnmKjTe95f4yNk25F5S4ZAoQZmOzvbd240OrnS98tpQIRFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="mm2UsPy/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B7606A322
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 15:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D3B7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mm2UsPy/
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c423b145922so156941566b.3
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 08:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201942; cv=none;
        d=google.com; s=arc-20260327;
        b=kR/UBZcDCAKVOKsCJMIxtbZ2nLe+haZRCZ3A/6L0Y6MskwWPgznw0c+BjnPHlTuWLS
         XUDzQ+PcqIo8AHxNmMWmL84XL+wF4tYsMVEVczVOn2JQ2+O7KXgdZFpjbSFkNnyQKLQF
         e8oWzJn76IHq6YK9Jfk3Hvvy/z9FbEw5+HdgVmPk/Sdrz9iJtg6UzKgREyrEtsxOkE1j
         Y8cfXJui9pLwMjg/oX9esXJcz3m60hN1hk7fr/i0+JyPDfLaJqmQRJGKgA6hAavV9zkT
         sPjzYrv1LlPgxk+UdgEqiVmqTPbgZEZU5D+f+7pwhILsDqy4Ab5V0+cM/dn0YEmOImFp
         T1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7xxxnWLJ3cqzVXeSgOYrxm108qFnX6tdnhI16mhQOo=;
        fh=/sZpQwejFN1wnz7zUC1kBH9OgvPkj7geMlDTppovAME=;
        b=pB2q16uGRCnbJGiXEMSXhuOBYIxkz+bQ3/hgQ7CEaMrGqfDtqAtYvwQSDInzpdhIlL
         pgd/gk75QSY+zxPnXdDaIwy+dMFflyjkMpUfdx/PsELPqAHUQPVuu279cbTa1KjudBFY
         AqgSeWAm4PVWwvmMsIL31Nmu+/+ZyfUjjA0zhBRD+1BqQCDDnrx1P0eIP/r98pOaHRsE
         coyuqekf6KBw3bxGyYaIhOZesVYly3BJcXrF3v3juNXznrwGRP1xXNzR6dLv3NlJsqMz
         lhVZ3MsMPRvmEUM8mZMx8TjxbJMz9GxaxYuYB/Kyfh/aZ0RxcxCMb2PAM8EGykX/bVDW
         LSZA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201942; x=1793806742; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y7xxxnWLJ3cqzVXeSgOYrxm108qFnX6tdnhI16mhQOo=;
        b=mm2UsPy/mJZlIQL3sSkrRr+szECnLzXTTLxGjgzqwmprXWZk3NV0T5K2RHzBa5m8TW
         6qlUGaHLLpZ5DVcy4lJJ7UNo5eCFd1q0a/SNvtMwdEV9yck6SmEXsrWy2geG2KdX7ukw
         U/yZ+KfKBoHIaS8knH/ky8LN0YI3ORv0CU0dN8Pi1crxM3XexOGjbWderpU1EbHz84eK
         u3pr93D0L3pQ2el/5M9bHbEIAMJmKIu7Ik2+vl3GwveJwdQMPZqHqOSjd26glq9sijRH
         tfu2RhwsJg4ePYsIRxqpGUzvAlEejvSlyKAoIezSDCWv10YiOlyt/b3XbB7/47RsVyyP
         qVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201942; x=1793806742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y7xxxnWLJ3cqzVXeSgOYrxm108qFnX6tdnhI16mhQOo=;
        b=uCgMTjmwQ6y4AOtp9ZVwgBiKssDXzhFGmJpRdDJWuE7C7262LosPRBVZQUVEnmdA4I
         LGK7Wm0QdWfEZtj138VUCS6NKM8OT1U/YGnlzTXT+nagkPKrcopcoxMhRzMQ2M++wSp5
         CQz2q/VqxBwgcXQTMpRsJnDXZ6aVSqdFUfqv6X+vVigusb3l0QcBE6eG9ICfSeHs0BX4
         is/6ZahYLXsxnT9kGa76AkRZJiCaebur/LAJDzz9IWVNRnwaH8MghVg6Q6AeXeclcwdX
         GW0SKz9Ws1s+e4ZW8pCHyBzOLCeqDaauQpHVJ3dCi29e7Mpo2D/fO4JV5NatGMlepJLg
         vxPg==
X-Forwarded-Encrypted: i=1; AKwUvByjJbCmu8QKwoIxayBpLfMIsOXVL6/SOH8Nih8oCa5asZgvtvzNF/Yo58pFnK6bIi29j+JgUUnIg1nCLjPMCA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ7Z/b2eZsOhqAwqKiWf/sn+WUTlNfS8E32YH+ggVIphisQ2XqP
	VNQp/rOQ91QsmeChGPHoW9XaQ00cnVzNPb2KqbaYkT7nLLfFoO6EAPyoOkElFvqeS2EJO/rQs9V
	ZY8+O6gBonBQh46B6KzUh3tgRNSAltD9LIJP9GrA6
X-Gm-Gg: AYBFou1iFqEdK5/nMQCwYnHU+6epSCslT2CEgPt7wzfb4XV1eSYqQEh6hp78o+fJI3N
	+AoBkRhX3z/tF4rZVgsm+r11qXmGWPU/AiT12QW5n1xJMFrvzd4wjVHPIFbxEgpePwpfCiAMzWT
	zeTSmxNl4dT6dGfZM+Uh7+ishS67EOIm0DTBWMQV/DPegIqxYc9k1tA4kFkL7ppJN5f7vRiDr/a
	2wh8Q6PPUcg4VYywcVLhH+jch/XqCFuC+Jp69CTV6MF8EnQkD0kKQT4LQb3PjF75he2h5BcUHvL
	hVRSmuKHx7BWzeQZoW1Ek9S6+6ZNeRcUc+f8zh+rQVFbxQl2jpBAXh0K70kCoMFUqkONcLSeQxt
	6dXTpcBu75wxjaNWyA9fo9wx3O2dQp7DMtIRqsgfT76wj17++lsqDQ+NjuGNlav7HtsxYpIOY3Y
	Fyai+WiBy+z3A=
X-Received: by 2002:a17:907:d308:b0:c3f:7ab8:bef1 with SMTP id
 a640c23a62f3a-c49bdf2f80cmr259829766b.34.1793201941132; Wed, 28 Oct 2026
 08:39:01 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
 <20261027025616.1632690-2-kevinloughlin@google.com> <20261027053843-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261027053843-mutt-send-email-mst@kernel.org>
From: Kevin Loughlin <kevinloughlin@google.com>
Date: Wed, 28 Oct 2026 08:38:46 -0700
X-Gm-Features: AclHuK-vBr-9NFy3pcmA7HqGTQSybdCjlTCvxPcN7DJFBT-excWUi_DEsSkfHKE
Message-ID: <CAGdbjmK_vbmxX5Dti9+RwEiWkxQDHz+Dg9ToNnyEd_z-2ncdPQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] virtio_ring: support per-virtqueue DMA mapping ops
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, virtualization@lists.linux.dev, 
	linux-coco@lists.linux.dev, linux-efi@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidharth Telang <sidtelang@google.com>, 
	Punit Salian <psalian@google.com>, Peter Gonda <pgonda@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Jacky Li <jackyli@google.com>, 
	Steve Rutherford <srutherford@google.com>, David Skidmore <davidskidmore@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:42=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 02:56:04AM +0000, Kevin Loughlin wrote:
> > Allow individual virtqueues to override the device-wide DMA mapping
> > operations via virtqueue_set_map_ops(). When custom per-virtqueue
> > mapping operations are configured, vring_map_one_sg(), vring_unmap_one(=
),
> > vring_mapping_error(), and the DMA sync helpers dispatch through
> > vq->map_ops instead of the parent virtio_device DMA API path.
> >
> > Replace vring_map_single() with vring_map_indirect() and
> > vring_unmap_indirect() using the device-level mapping path (vdev->map
> > or dma_map_page_attrs()) so that indirect descriptor tables continue to
> > be DMA-mapped for host VMM access even when a virtqueue overrides buffe=
r
> > mapping via vq->map_ops.
> >
> > Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
>
> Please, don't. The automatic mappings inside virtio core are there
> to keep simple things, simple.
>
> Everyone doing something funky with mappings should use the premapped API=
.

Thanks for suggesting. I will use the premapped API if I end up sending a v=
2.

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769A22DFA6
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524823; cv=none; b=Ez5HTDU9x5qSGP8yoSfek9rTQkmuEyMVyTUzjWVpG6oCdYS3wlknaJkPRDEJyQiCIlvpgOAQ8S/qy2E3Q83/pKl4y7hBP/Qa0wVLgWdpx4NAp4NZqj/5ukWPNRiprOiYcB8WGqX9EgAv6bKKMyQbXN+r0CLTviCjJBGQGIhxo+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524823; c=relaxed/simple;
	bh=ZR/58w+1L+EYFW6tjt18wTp/81X9JhLePAFSHTKPVMs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQQoTmD6n4+GopAjHJgQmBCdbsmVVC4v1h1FyAjRhfmSX5yOozkLGsgUxj9eO7CEa/maCOnYw7VuyPG+JdrPQlBY4S72gCSdh6LdaBdu9Fx2RzfOKdKk8cqlR6LNT/xSTR8vG9Kg5vFNKEwTVZ0gNLjoJDLjTCyIvU/9DOpmGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CryCj59+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CryCj59+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739524820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR/58w+1L+EYFW6tjt18wTp/81X9JhLePAFSHTKPVMs=;
	b=CryCj59+PpLj5mgNzCGDcZoyv/nf5nx9maqXC3pEssCc29CfooB83jhHR9095zZExJnR9q
	z9wY0DpHinsgVFNP2JW0wUWk38T4pS/kwuc8MeuSFXOrRiBfGT5Gp72YcZFWSjepLhUrmT
	Vw7ZDbnfnsDcnBz0SSK9AQ4LFO1ygzw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-CHAdC09rMrSJf-gUgZqokg-1; Fri, 14 Feb 2025 04:20:17 -0500
X-MC-Unique: CHAdC09rMrSJf-gUgZqokg-1
X-Mimecast-MFC-AGG-ID: CHAdC09rMrSJf-gUgZqokg_1739524816
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc17c3eeb5so3180195a91.1
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 01:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524816; x=1740129616;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR/58w+1L+EYFW6tjt18wTp/81X9JhLePAFSHTKPVMs=;
        b=dlHL7+wa3Lo2t075TbOWq57+osRctG921zSY8XcNxjH/Z0U+31C/2nYtJMS3+8e1eO
         ilnReG4+tAU+8oO3qPU09zPNtLOERiaswYoMRQk5S8zbSXfR26ESuizPqKpjMRutrpyx
         ucT6fSAFwonFEF1st/camROa6H/RX+zIVWHD9sS5volud8tiXYBJeSLnRGDMgKLtdht4
         fhezXme+568pMQaZav1cqeY80y/Iyg98HfkaxbKSQfQfUebtaEebOGrjnEH3gEH+yUZy
         ACOQMee6GiQY1j0u8vcs+CUrbhz5CQD9d1yG/hFofvd6S0TTkj3P70Yi5pbu16000PW4
         yh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6yA0kchSf52IjrEev6ZveXQmxOnIiBhRthTO0tBvMLNw+71L+06E21hAGZjZoR3stNJvQ9O2Xifi7YIpnfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCLAs27eLbr6mHg7QhZvhApry/thR1440sKeXHH8bPSAJoYvOF
	SusgHfZ+dQ/EdupWSMV73C6zKxZKqQLIHaRkNnLtDxeN/hPDzU8cZboGaNV8x3vQmMcMXdTan5B
	jPkgZLbVFzV1C+CCu5/4RbopXeQ065b63g4+SF6oUeTV04/pqPahgJKydFrSFJrlHbL08RIoZLM
	6YzzlWctCNeFJ4jV22ZNVVR/4eObjLClL/MWOlPlU=
X-Gm-Gg: ASbGncsWmoQyTqm0ZjEKuwcYP6LTpMfxGxrm04jpRSV1hUNBGzd5vOlI6PbZbyhBd8m
	8Ctsb/EnSok4ThaJl8gYAusBUts+aB+uTR1tQgYHiichxVCEAIVbsERhBvw==
X-Received: by 2002:a17:90a:c88e:b0:2fa:20f4:d277 with SMTP id 98e67ed59e1d1-2fbf5c59edamr17083872a91.24.1739524815980;
        Fri, 14 Feb 2025 01:20:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV70tYKaoD72ZWgJewS3S3Ws/yTe5Co7t1AkVMiygQbOPGvw6IrjqyLyAEgiPWE34Qlyn+BspH/JPNCc6Sah8=
X-Received: by 2002:a17:90a:c88e:b0:2fa:20f4:d277 with SMTP id
 98e67ed59e1d1-2fbf5c59edamr17083840a91.24.1739524815700; Fri, 14 Feb 2025
 01:20:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:20:15 -0800
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <20250213105231-mutt-send-email-mst@kernel.org>
References: <20250213-virtio-shm-page-size-v1-0-5ee1f9984350@redhat.com> <20250213105231-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:20:15 -0800
X-Gm-Features: AWEUYZkLDCiAVkg75a5t11ITS9fRDi5xZ4oLEnr_uyiN6ZHVdlUxn8cPTzWG8SU
Message-ID: <CAAiTLFViXr7gVPd3oRhfHSnUxxexPDEJ-MJJOuFrctrr+XvTfQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] virtio: obtain SHM page size from device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, fnkl.kernel@gmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ScbhGXc9HYWRztMdFxlX3N4DRghGDirZGViE-BENaKg_1739524816
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Feb 13, 2025 at 04:49:14PM +0100, Sergio Lopez wrote:
>> There's an incresing number of machines supporting multiple page sizes
>> and, on these machines, the host and a guest can be running with
>> different pages sizes.
>>
>> In addition to this, there might be devices that have a required and/or
>> preferred page size for mapping memory.
>>
>> In this series, we extend virtio_shm_region with a field to hold the
>> page size. This field has a 16-bit size to accommodate into the existing
>> padding virtio_pci_cap, simplifying the introduction of this additional
>> data into the structure. The device will provide the page size in format
>> PAGE_SIZE >> 12.
>>
>> The series also extends the PCI and MMIO transports to obtain the
>> corresponding value from the device. For the PCI one, it should be safe
>> since we're using an existing 16-bit padding in the virtio_pci_cap
>> struct. For MMIO, we need to access a new register, so there's a risk
>> the VMM may overreact and crash the VM. I've checked libkrun,
>> firecracker, cloud-hypervisor and crosvm, and all of them should deal
>> with the unexpected MMIO read gracefully. QEMU doesn't support SHM for
>> the MMIO transport, so that isn't a concern either.
>>
>> How the SHM page size information is used depends on each device. Some
>> may silently round up allocations, some may expose this information to
>> userspace. This series includes a patch that extends virtio-gpu to
>> expose the information via the VIRTGPU_GETPARAM ioctl, as an example of
>> the second approach.
>>
>> This patch series is an RFC because it requires changes to the VIRTIO
>> specifications. This patch series will be used as a reference to
>> propose such changes.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>
>
> don't you want to negotiate the page size with the
> driver then?

It's not really a negotiation. If the device presents the feature, the
driver must honor the page size, either directly by rejecting or
rounding up allocations, indirectly by informing userspace, or both.

If the driver can't accomodate to the page size, it must refrain from
using the Shared Memory Region.

Thanks,
Sergio.


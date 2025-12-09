Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19AD217704
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285796; cv=none; b=OdCofkREfmBdimb2RHpBtV2OIVJ26FrvWbsr8n1K/dFost94S9U6BSoN1FxA2pRdwoDEdnzzmEc6Le6IjGYjbCcFIq5w0HnVTE/TAnmiG999GLJ0uDytNmARck+XTSzHvRJdOZwDnQh0z78ppxYmu9P3NoAiZ4aySJkVa2gd/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285796; c=relaxed/simple;
	bh=Touvqf8WHt04tp99eC4EM9XyIpIcTPJtbic0gP2X3FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iWBj5sVpeXdAFtD6GMhw0pFsPlMqs8RdviGCeZRX1UuzrZ0dTfYH2nfDUTEv0clWLvEa7UxwsjYQCK6WsLALcUiRI+qPzFO5+YzpYhjqbxXeZRlhzAh7KsQrUPr1bu1ccPZBT9Lp0vOCv5DcRff1583w33rP9Pd1LI2rbqutBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1bgiP6L; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1bgiP6L"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4860E4007A
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 13:09:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xyj4oMF7Yk2E for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Dec 2025 13:09:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 349A740059
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 349A740059
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J1bgiP6L
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 349A740059
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Dec 2025 13:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765285791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5P38QWOVcSU59TQGZzDoAFjcxq1O9ed/yD/2cqZSQI=;
	b=J1bgiP6LZJqUE+b70OSMTz0WWJnaBEEh0I3z5bFe0pxYiL2R/TWZ2aKhPHAHvckzXCaIYZ
	HICBljToRpbzo6WBupudcCM145NsxuxSxoMKnohRy/GtHhN8bg4oKpZhPGIlFh2+UFPwHb
	IllVewzalkOFM75zerEqsOdC0CNreAQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-hMaW61K4O8SgZ2n7o3bMsg-1; Tue, 09 Dec 2025 08:09:50 -0500
X-MC-Unique: hMaW61K4O8SgZ2n7o3bMsg-1
X-Mimecast-MFC-AGG-ID: hMaW61K4O8SgZ2n7o3bMsg_1765285789
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-37cf6af42c6so25473551fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 09 Dec 2025 05:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765285789; x=1765890589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5P38QWOVcSU59TQGZzDoAFjcxq1O9ed/yD/2cqZSQI=;
        b=ZxPeSk8cetiaG9VCYt2dQiMKU5rf4UIQcOPw5ha1JGhsDNTNb7rW08vdnLc76S9Aiy
         d35cZvor6pR3erAH9LZTeEEzw9xdZzv6GzqR96Hr1xxnlBy1t+aV5PF34A3bbSrddT1H
         b3ze4RdTMfb+TSU/3ySAA3uc9KjunCCEVJl2WrqNt6DEgjyW8lrJmH97viNCdvDxABcr
         +hbmJwT8C7x5Wu/MN6/IXXqc1GgMAc4/0jLBNY7xLuq+1v3dh8GP84Qtq13jDQ+RvbGD
         LIcJzfT8u+Uhq/dVWNM+P+f+9VmaN1kp9996LE8aKQBfT1G1LtlxlyCYuTsHUhMk0xaG
         ayxA==
X-Forwarded-Encrypted: i=1; AJvYcCW/vlM/RNVfYb19+K4qS+pSmOwmUKA6kI8P3QtBm6C0s+NCh/gyzKX5G109LzfPyuih/C17lLqVviZkOnxurQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzq7PBnEvnxx6hZuRUtDHaq6ixffYjK2chAneqWxXP2ZD4LDx8f
	IA9sWbsdN9O3XTIGOIN7mvxP/cJnYW8fFtEjbp2N9oL2vrXFgKWX9618eb5bMgzhOvodK4+5P4X
	paDtoUnMw/qoeTV6GyljtqJbclb80vaKzBQVBtBPP8Mgu7MmnRzcN/wdzHBAiKyTnAPY+d1D/1p
	GbzPEiGBE=
X-Gm-Gg: ASbGncs3gU38eeUotqI1cmCFBU0+arFtyqutqGy0a4F0J1ILMYYotfMDsehEfVXldOx
	Sf9kcNwakiKEure2KeM0v8lvvTeU19v0HiT+L3d1rRdsWbzb8ZTebsUo5jOu0DHy7cOAGQXsXqT
	FwJIdqEHjsoaF/suKr9NizC7t/eHt9ampw5jcFny2VE0UXyCBf9KIcpNPf74TrcVnBMQXMBF65K
	yy9CDH/I8iNEOC8DFUHlTr+MeX1dTBi0wQse7UCITBC0oDrat6njaN1pe5fI/uuLAO0FRlDsm0Z
	8uSH2rlzDO3xeqJppddOmoiAoijHDMAqVf00PHiEBXuNgcZlJ3mqAIbyp8DJlNmbcjI5tXlqv2Y
	JCayvoMv2ABUk1owtaaV2L1oZpMefUPmk+A==
X-Received: by 2002:a2e:bc2a:0:b0:37b:9e0b:e0d8 with SMTP id 38308e7fff4ca-37ed1feec4cmr27411671fa.14.1765285788963;
        Tue, 09 Dec 2025 05:09:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6qF6On+XjEQa7Vpebeq/+5jUjnAJbF/ap+lr+2JnwmaX++R35vbR7XHiCdci98pl68Pm6CQ==
X-Received: by 2002:a2e:bc2a:0:b0:37b:9e0b:e0d8 with SMTP id 38308e7fff4ca-37ed1feec4cmr27411621fa.14.1765285788446;
        Tue, 09 Dec 2025 05:09:48 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37e705e8292sm49532871fa.37.2025.12.09.05.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 05:09:47 -0800 (PST)
Date: Tue, 9 Dec 2025 08:09:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 00/14] tools/virtio: cleanups, fixes
Message-ID: <20251209080926-mutt-send-email-mst@kernel.org>
References: <cover.1764873799.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1764873799.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDHo-WqpgChi1QWGf4mVeTFNRD0_MAsX_JYemw3t5ro_1765285789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 01:46:01PM -0500, Michael S. Tsirkin wrote:
> Recent virtio changes brought about build errors for tools/virtio,
> as usual. I did some refactoring to hopefully reduce maintainance
> load going forward.
> 
> Adding stubs is tedious and seemed a perfect fit for cursor -
> so I used it for that, then rewrote some commits and accepted
> others.  commit logs I've rewritten.
> 
> Found and fixed a couple of minor bugs while doing this - that
> part's all mine.


Jason, any feedback?

> Michael S. Tsirkin (14):
>   tools/virtio: fix up compiler.h stub
>   virtio: make it self-contained
>   tools/virtio: use kernel's virtio.h
>   tools/virtio: add struct module forward declaration
>   tools/virtio: stub DMA mapping functions
>   tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr stubs
>   tools/virtio: add ucopysize.h stub
>   tools/virtio: pass KCFLAGS to module build
>   tools/virtio: add struct cpumask to cpumask.h
>   tools/virtio: stub might_sleep and synchronize_rcu
>   tools/virtio: switch to kernel's virtio_config.h
>   virtio_features: make it self-contained
>   tools/virtio: fix up oot build
>   tools/virtio: add device, device_driver stubs
> 
>  include/linux/virtio.h             |   2 +
>  include/linux/virtio_features.h    |   2 +
>  tools/virtio/Makefile              |   8 ++-
>  tools/virtio/linux/compiler.h      |   6 ++
>  tools/virtio/linux/cpumask.h       |   4 ++
>  tools/virtio/linux/device.h        |   8 +++
>  tools/virtio/linux/dma-mapping.h   |   4 ++
>  tools/virtio/linux/kernel.h        |  16 +++++
>  tools/virtio/linux/module.h        |   2 +
>  tools/virtio/linux/ucopysize.h     |  21 ++++++
>  tools/virtio/linux/virtio.h        |  73 +--------------------
>  tools/virtio/linux/virtio_config.h | 102 +----------------------------
>  tools/virtio/oot-stubs.h           |  10 +++
>  13 files changed, 82 insertions(+), 176 deletions(-)
>  create mode 100644 tools/virtio/linux/ucopysize.h
>  create mode 100644 tools/virtio/oot-stubs.h
> 
> -- 
> MST
> 


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C36D171B1
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 17:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692836; cv=none; b=eR1GXVdKUDv9tml12oV//0B4gWB9Ky0fyvIxxZKUdmifTQb62qENVKUHP3USQlwRSOT9vpdXmVFyEZhB/4nDtfR7gRkGf0NEA4LBx8m0y1G4y12tSIHuQNlBEWhWoCxg5Jr3nvBjfBi2Hb7O8X+7kUneULynQ4Ms9wd4UOJeqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692836; c=relaxed/simple;
	bh=DlyweINH+GvftD3lzjrMXVxM0P1aIDv+GXcUBeZjlkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HSO6auhgbL/+QBYq6wKCj/GNhKmE6WYV9JYYZ00urO41+P358WHvr+W4/nQzluqHiqTaVHCOCvmHDiiGknQD1PezbcLaFypSEodbJsEnjrMpKA2Op0ykECZCNLxqvLB/NT0N/UKV2XsbBAuIgXkWH79vvGxWZjsliyva2Nx/Lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+1IuhyQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+1IuhyQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785692833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/zJ7SZsSD5kcxXbfEJ/DIJOA2s+11oRTsQm/YI6m+A=;
	b=A+1IuhyQbm1Ik9em1nile6g1Htba5jv/njDumJ+zBaljzPqU/fnjcajzYlBA3Ai8MQU3nK
	bk9bUhYc/AliKLUk098g55wytAm0wBtGMULJJLZXYRBPCdhdE3jngvhcqSk5Kpdz9bY89r
	BVsZI2pO884ROilq1Rh87MUhYS6LvFo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-JfuayzBdPPO25IyngAL7pw-1; Sun, 02 Aug 2026 13:47:06 -0400
X-MC-Unique: JfuayzBdPPO25IyngAL7pw-1
X-Mimecast-MFC-AGG-ID: JfuayzBdPPO25IyngAL7pw_1785692826
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47485fde05aso1893264f8f.0
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 10:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785692825; x=1786297625;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/zJ7SZsSD5kcxXbfEJ/DIJOA2s+11oRTsQm/YI6m+A=;
        b=mz6cAdXC/CZygLPN3CgK2pyrNFdsA/MXaRTIvOsiGzoEiWWFDmp20W5aF1VS/GIawi
         vRGbmsZaJ/AV4F0V5psC8gBPZV5ue53Fs+9t9SjOrf3ZhTAnDKeCvUlTx1dpbQxYB+2I
         96YifzcUDKH2KexHBRezca37+6rIQQfb18x1995OCYNAY5XKc45F4ZZ0xJbgt6yu/yWC
         RdZ7v9MoefrZ45jjpjGguiCxXLvN9clXu0SEQXrkAqwmZZBINtPKc6rIlS7uaEcJ13XC
         59UirRDDRAJFZjVvk3pgRaBTorL+GTMVKA1kqHalqadxl8PcKpjsmG5p6RHDfDEbX6ZN
         thPw==
X-Forwarded-Encrypted: i=1; AHgh+Rr8j6vk9uJmAuiUwGGFkJESkIvvDKr+KO+ipZCcCDpYj5Ou+3TjZe+hR0LcHkAbEmpvvn0G+sYr/JIvspi83A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP4qTyAedhhY7HM+xcJ/AAV0TgA3CLrZ5x3YKn5FCQBHvdKWAa
	/oukztE9T48i/ywce0/AHq22HERHbdIwO9dQVR67ELcAQlwFEQwHk/MJjhhC0qYJEuk5q7Pukne
	KFBM2HLdiuioRKyasUimxJ/MZ9xaEsbyHigroVTrOGskoEasHlY37z3anaePJ6yZG6M8DLzAl/W
	lX
X-Gm-Gg: AR+sD12LGPmvgkH/cJP87onMbIMlrYTjlz8MScx4UHtQUojbG+HiS6hN3yVxUI0e/VU
	iLldYLO+ROZHmlPkMegfMQpciqx0fx6/PWuOzGcXp9lRFX7JUEVRTacgDyRdlFNbZfwOMl0lZcx
	uc/TJ6ao0MGRREPOYc/D/KorqM9cbpFXM3wP8C4pn8s6IKtnQxtN/w7zdgl5XGpV1A+u2eaxOJQ
	bbrpZhQ1so4TGOxLUBs1+c1omjBBhwnGaDkj72+Pez1zFnVrLo/ifwT/fX5eZ7//UP2VbhLU6u2
	D55pMX/njZZEhwkABxWK8tmL+jRgCaZR/pFhfx1qgHq/t+1bfkRCPoYGXTpVzgCgbsO0MM8x4jC
	Jbv24IxUarcTjyGqrCwPDhA==
X-Received: by 2002:a05:6000:2887:b0:47f:89cd:b48 with SMTP id ffacd0b85a97d-47fd72a5d23mr19183832f8f.5.1785692825394;
        Sun, 02 Aug 2026 10:47:05 -0700 (PDT)
X-Received: by 2002:a05:6000:2887:b0:47f:89cd:b48 with SMTP id ffacd0b85a97d-47fd72a5d23mr19183778f8f.5.1785692824939;
        Sun, 02 Aug 2026 10:47:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d1956sm25898382f8f.6.2026.08.02.10.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 10:47:04 -0700 (PDT)
Date: Sun, 2 Aug 2026 13:47:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] virtio_pci_modern: fix vp_reset() hang on
 unresponsive device
Message-ID: <20260802134443-mutt-send-email-mst@kernel.org>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260802174059.4082-1-abhinjoses@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EbqWeWvYQv9Hcq60T4oMfl4zHiReQdzUw68x9r2AsW0_1785692826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 02, 2026 at 05:40:57PM +0000, Abhin Parekadan Jose wrote:
> While investigating a syzbot report of a WARN_ON_ONCE firing in
> virtio_dev_remove() [1],


And I responded to that syzbot report, and I quote:

So it writes 0 into pci command, effectively killing the device,
and then is unhappy that the driver prints warnings?
Who thought it's a good idea? Why?


> I found a related but more serious issue:
> vp_reset() in the modern virtio-pci transport can hang indefinitely
> if PCI_COMMAND memory-space decode is disabled while the device is
> bound (e.g. surprise removal, hardware fault, or -- as reproduced
> here -- a direct write to the PCI_COMMAND register). The status
> register poll loop has no way to distinguish "device still resetting"
> from "device unreachable," so it never terminates.
> 
> Patch 1 adds a VIRTIO_STATUS_ERROR() check that recognizes an
> all-ones status read as invalid (per spec, bits 4-5 are reserved and
> can never legitimately be set) and warns once at the point the bad
> read actually happens.
> 
> Patch 2 uses that check to break out of vp_reset()'s poll loop
> instead of spinning forever.

Was all this including the cover letter written with ai assistance?
if yes pls disclose this.

> Reproduced on a modern-transport virtio-blk-pci device:
> 
>   # printf '\x00\x00' | dd of=/sys/bus/pci/devices/0000:01:00.0/config \
>     bs=1 seek=4 count=2 conv=notrunc
>   # echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> 
> The second command hangs indefinitely without this series; gdb
> confirms the CPU is stuck in vp_reset()'s status-polling loop, with
> vp_modern_get_status() consistently returning 0xff.
> 
> [1] https://syzbot.org/bug?extid=a1c8effc62c569d4bd25
> 
> Abhin Parekadan Jose (2):
>   virtio_pci_modern_dev: warn once on invalid status
>   virtio_pci_modern: avoid infinite loop in vp_reset() on invalid status
> 
>  drivers/virtio/virtio_pci_modern.c     |  6 +++++-
>  drivers/virtio/virtio_pci_modern_dev.c |  8 +++++++-
>  include/uapi/linux/virtio_config.h     | 16 ++++++++++++++++
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 
> --
> 2.51.1


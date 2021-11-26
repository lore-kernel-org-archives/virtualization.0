Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9CC433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 08:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FE084014B;
	Fri, 26 Nov 2021 08:51:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GlixbsaSl98a; Fri, 26 Nov 2021 08:51:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 96CAD40012;
	Fri, 26 Nov 2021 08:51:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F3EFC001E;
	Fri, 26 Nov 2021 08:51:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E84AC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FC29824E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rME5x6gpw7-V
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51952823EB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637916687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=buxrUV+g6E7RgVJ5J84jnki/Cx5fv7dc0O2MOtNji5E=;
 b=WGzQH/BzAFcveQFiX4iYUNaELgpUcqefBRVGfYWjwLQwBjDdMID5B3zGudzmagV7GwnDwG
 W6XtniruGTiG70aSHA4DEQYmfWx7noEiOgrv1oaiHa5nUzbO1/YKDTfoQDhwwHiitG97b7
 xnIaOTrjH03Yszt6Cp0m7tmkx5eEpEQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-440-7FmSKAwuOoiWT8smvYq6tA-1; Fri, 26 Nov 2021 03:51:26 -0500
X-MC-Unique: 7FmSKAwuOoiWT8smvYq6tA-1
Received: by mail-wr1-f70.google.com with SMTP id
 d18-20020adfe852000000b001985d36817cso1541116wrn.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 00:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=buxrUV+g6E7RgVJ5J84jnki/Cx5fv7dc0O2MOtNji5E=;
 b=xkdChSpO43Yo8xWjUn3V2t9fOwDoY4UlnyMUiFYBjKXjT2uQ22tBMS9RvGEkC8+NDb
 5kckJR9u5vTGhDmk5bKtgxNmAJeLtUqoEQqsKMt/uGFOAAZMCHU7LizIQ+FcNXLBda0x
 QEkapaURrsRO1OByJwfPjn2fLnF8EB5T5R7A3BStsdZIJvgv8oKHz0Hfc1iB41f/TDkf
 u7OOpoyAj409w15VdyBoeFBH1CudA2t/r63pxMQ2MoQu9YrIeNLzIlMIANc3nOz4wLTZ
 HjIas6VMYWby/Tv5Pdytd+drLtMOVW6Wjw9Z/LJb4UU1lwKVxBWLtvxOCSV6tR0jqB+u
 CMZw==
X-Gm-Message-State: AOAM5310XCNucC98ypWwOMWeYOR7+ozbJ15JI5WYzXqOQtxmZpCXjPjW
 8eScAMRVrwvisgpmhIxOUMNwA/78Qwv1W5z9I8450XtRqaPFJ24NE5YSbUONVrFs7ndkyEC2M9z
 EbD5G/pnizQj7YAnQKKxdKZlXvfZOFE55aHbuj1ylQA==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr12555718wre.561.1637916684810; 
 Fri, 26 Nov 2021 00:51:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz+zRTh3M3Te7Zo+O1GLnjMROjijj+1i34zEBnuPKXwHZMOgzY2YMCX6RlCP4Doiy0fPswqhw==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr12555706wre.561.1637916684638; 
 Fri, 26 Nov 2021 00:51:24 -0800 (PST)
Received: from [192.168.3.132] (p5b0c69e1.dip0.t-ipconnect.de. [91.12.105.225])
 by smtp.gmail.com with ESMTPSA id f7sm12695103wmg.6.2021.11.26.00.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 00:51:24 -0800 (PST)
Message-ID: <74c1d756-3f7c-7085-0ae9-2c082dce63b2@redhat.com>
Date: Fri, 26 Nov 2021 09:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH AUTOSEL 5.15 7/7] virtio-mem: support
 VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20211126023006.440839-1-sashal@kernel.org>
 <20211126023006.440839-7-sashal@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211126023006.440839-7-sashal@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Sebastien Boeuf <sebastien.boeuf@intel.com>,
 Marek Kedzierski <mkedzier@redhat.com>, Hui Zhu <teawater@gmail.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 26.11.21 03:30, Sasha Levin wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> [ Upstream commit 61082ad6a6e1f999eef7e7e90046486c87933b1e ]
> 
> The initial virtio-mem spec states that while unplugged memory should not
> be read, the device still has to allow for reading unplugged memory inside
> the usable region. The primary motivation for this default handling was
> to simplify bringup of virtio-mem, because there were corner cases where
> Linux might have accidentially read unplugged memory inside added Linux
> memory blocks.
> 
> In the meantime, we:
> 1. Removed /dev/kmem in commit bbcd53c96071 ("drivers/char: remove
>    /dev/kmem for good")
> 2. Disallowed access to virtio-mem device memory via /dev/mem in
>    commit 2128f4e21aa2 ("virtio-mem: disallow mapping virtio-mem memory via
>    /dev/mem")
> 3. Sanitized access to virtio-mem device memory via /proc/kcore in
>    commit 0daa322b8ff9 ("fs/proc/kcore: don't read offline sections,
>    logically offline pages and hwpoisoned pages")
> 4. Sanitized access to virtio-mem device memory via /proc/vmcore in
>    commit ce2814622e84 ("virtio-mem: kdump mode to sanitize /proc/vmcore
>    access")
> 
> "Accidential" access to unplugged memory is no longer possible; we can
> support the new VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE feature that will be
> required by some hypervisors implementing virtio-mem in the near future.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Marek Kedzierski <mkedzier@redhat.com>
> Cc: Hui Zhu <teawater@gmail.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/virtio/virtio_mem.c     | 1 +
>  include/uapi/linux/virtio_mem.h | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index bef8ad6bf4661..78dfdc9c98a1c 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -2758,6 +2758,7 @@ static unsigned int virtio_mem_features[] = {
>  #if defined(CONFIG_NUMA) && defined(CONFIG_ACPI_NUMA)
>  	VIRTIO_MEM_F_ACPI_PXM,
>  #endif
> +	VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE,
>  };
>  
>  static const struct virtio_device_id virtio_mem_id_table[] = {
> diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
> index 70e01c687d5eb..e9122f1d0e0cb 100644
> --- a/include/uapi/linux/virtio_mem.h
> +++ b/include/uapi/linux/virtio_mem.h
> @@ -68,9 +68,10 @@
>   * explicitly triggered (VIRTIO_MEM_REQ_UNPLUG).
>   *
>   * There are no guarantees what will happen if unplugged memory is
> - * read/written. Such memory should, in general, not be touched. E.g.,
> - * even writing might succeed, but the values will simply be discarded at
> - * random points in time.
> + * read/written. In general, unplugged memory should not be touched, because
> + * the resulting action is undefined. There is one exception: without
> + * VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE, unplugged memory inside the usable
> + * region can be read, to simplify creation of memory dumps.
>   *
>   * It can happen that the device cannot process a request, because it is
>   * busy. The device driver has to retry later.
> @@ -87,6 +88,8 @@
>  
>  /* node_id is an ACPI PXM and is valid */
>  #define VIRTIO_MEM_F_ACPI_PXM		0
> +/* unplugged memory must not be accessed */
> +#define VIRTIO_MEM_F_UNPLUGGED_INACCESSIBLE	1
>  
>  
>  /* --- virtio-mem: guest -> host requests --- */
> 

As 2. and 4. are part of v5.16-rc1 but not v5.15-stable

Nacked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

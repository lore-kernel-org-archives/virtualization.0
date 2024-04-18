Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B515F30B
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441072; cv=none; b=cGgeg0icgyYE0A8W5F4Bip3v3vrKK22xfjOkY2dPtkRo/1Ou/WLT9k7ms/HivV6ZZzmtvw6P2FPHfengb8QEETOPeUqqXdiY5CZmd6LG68Klc6qaG93cZNbIO3BmRvmueWu/JD/JQ6nE/NUTNR/NinITvbCWt7XLQQLtdJcatw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441072; c=relaxed/simple;
	bh=JS0kzCmD7aA8NGeTfVSN0Gd45DM7woq9UMMkh0gpGO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcGCeappZUsiLkokcy3xo+UBKF8GYQcMcVS8XcqQ1p9TBeE4NkiuzdJ1smdQ3/XUhhZuw9vavqASoFblTOQpD5tzZYPJBaJUhw0rp9uh8gd2LiUQ8Cv0VLNZSHDMTrBMuQ5OU0gpUEUyFQ2spr1zBHFWBwDhMnbkjKzuWqb9kXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bV4H/JD0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV4H/JD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ktXB9sdpCF0ise1DnbHSX9lWqJQuA6LP+4XJQHm3iis=;
	b=bV4H/JD0EsiUnzAHf7h6QnobxUnEEgeP+9JnHuWCLTRnamQrtt/HH/V7+wOqtvN0vtE7XP
	dI6laW18a9co5qxjTEcoSp0bJPxezLBqzMS2eGvU8novynmXrzaKyXh6sU/uclufv3rkCD
	PWmVZHolL0hi0cZ5CZsZHxjwAri2U7s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-y8R1VieFOZORdUiTpJs32w-1; Thu, 18 Apr 2024 07:51:07 -0400
X-MC-Unique: y8R1VieFOZORdUiTpJs32w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d02b62ddso516123f8f.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 04:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441066; x=1714045866;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ktXB9sdpCF0ise1DnbHSX9lWqJQuA6LP+4XJQHm3iis=;
        b=hRE/Dw579FeVigIdAScbtMJhd4lXLUrA3kxCFYuAFky3gkRjJgqtCOpXr4uCurhccx
         Rz6NYyyBTY8eByJ7H1yjsJBzkbiTM/4UtaivVP8XOawOP7j1IaXMQoUNTQRlMATuii7D
         Y8tFNXF58usUPwS/+TrDAiOBGs5nQuXBZqgpAEIyymSHPgS3/DJAHMpPBLy9oq9O5jYc
         JJmjlEvS125gE2t/dHANG7d4M5ugETGmcvTyXq+tvzX0DQGM5hqwrjFPqVonQjYT6XWT
         TNuvAkCGZJyRrkCkyDtKRecKpJaL2kYWpBYgdPrDQfwDvVjNmjT9GC4jAQ+ka94o0OeY
         2P9w==
X-Forwarded-Encrypted: i=1; AJvYcCWwL/fVt+1aaDQMTro7+M5/U1VaW2mW5yeq/2PhUEv1PQ9UEOZ+RYjtWITm4Y3ZoJukKDNoq7PTs+H5d3r8vUEVKTlJHvmi6MpL51tO+PY=
X-Gm-Message-State: AOJu0YwB+a/3G4f/D/lFuWt5btxuMhzLhzeGJ12ws7SjCdauokfTbxZl
	zZBCaTyTZDqh9RNKkyQKZX84aJVMMlsYdDpoHuu4hmt8e+Feb4gbKAAwSDepJwXRZAFa9yqzc3j
	llSOWODxyjvfZ69aOwlcKCth/cv04W5X/4lrJYFf9QnaiIvIfjhLez7oylmipI2wI
X-Received: by 2002:adf:ce87:0:b0:347:a81c:dadb with SMTP id r7-20020adfce87000000b00347a81cdadbmr1420414wrn.57.1713441066180;
        Thu, 18 Apr 2024 04:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+wHF08OvBHW1MlGtVqfPMPEfV+zn9dIEALMgr3T/5Ax2CRZQfLIvvamwPKZJnsD0HbqTZTA==
X-Received: by 2002:adf:ce87:0:b0:347:a81c:dadb with SMTP id r7-20020adfce87000000b00347a81cdadbmr1420389wrn.57.1713441065654;
        Thu, 18 Apr 2024 04:51:05 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id u9-20020adfb209000000b0034330c9eccasm1667910wra.79.2024.04.18.04.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 04:51:05 -0700 (PDT)
Message-ID: <7a3b2c45-187d-4f77-8832-02dc0237dea4@redhat.com>
Date: Thu, 18 Apr 2024 13:51:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] virtio_balloon: introduce memory scan/reclaim info
To: zhenwei pi <pizhenwei@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, virtualization@lists.linux.dev
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 akpm@linux-foundation.org
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
 <20240418062602.1291391-4-pizhenwei@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240418062602.1291391-4-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.04.24 08:26, zhenwei pi wrote:
> Expose memory scan/reclaim information to the host side via virtio
> balloon device.
> 
> Now we have a metric to analyze the memory performance:
> 
> y: counter increases
> n: counter does not changes
> h: the rate of counter change is high
> l: the rate of counter change is low
> 
> OOM: VIRTIO_BALLOON_S_OOM_KILL
> STALL: VIRTIO_BALLOON_S_ALLOC_STALL
> ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
> DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
> ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
> DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT
> 
> - OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
>    the guest runs under really critial memory pressure
> 
> - OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
>    the memory allocation stalls due to cgroup, not the global memory
>    pressure.
> 
> - OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
>    the memory allocation stalls due to global memory pressure. The
>    performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
>    quite effective memory reclaiming.
> 
> - OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
>    the memory allocation stalls due to global memory pressure.
>    the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
>    heavily, the serious case leads poor performance and difficult
>    trouble shooting. Ex, sshd may block on memory allocation when
>    accepting new connections, a user can't login a VM by ssh command.
> 
> - OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
>    the low ratio between ARCLM/ASCAN shows that the guest tries to
>    reclaim more memory, but it can't. Once more memory is required in
>    future, it will struggle to reclaim memory.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/virtio/virtio_balloon.c     |  9 +++++++++
>   include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index e88e6573afa5..bc9332c1ae85 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -356,6 +356,15 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>   	stall += events[ALLOCSTALL_MOVABLE];
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
>   
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
> +			pages_to_bytes(events[PGSCAN_KSWAPD]));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
> +			pages_to_bytes(events[PGSCAN_DIRECT]));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
> +			pages_to_bytes(events[PGSTEAL_KSWAPD]));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
> +			pages_to_bytes(events[PGSTEAL_DIRECT]));
> +
>   #ifdef CONFIG_HUGETLB_PAGE
>   	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
>   		    events[HTLB_BUDDY_PGALLOC]);
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 487b893a160e..ee35a372805d 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -73,7 +73,11 @@ struct virtio_balloon_config {
>   #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
>   #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
>   #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
> -#define VIRTIO_BALLOON_S_NR       12
> +#define VIRTIO_BALLOON_S_ASYNC_SCAN    12 /* Amount of memory scanned asynchronously */
> +#define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
> +#define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
> +#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
> +#define VIRTIO_BALLOON_S_NR       16
>   
>   #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
>   	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
> @@ -87,7 +91,11 @@ struct virtio_balloon_config {
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
>   	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
> -	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
> +	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
> +	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
>   }
>   
>   #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")

Not an expert on these counters/events, but LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1C564CF7
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838473; cv=none; b=G1Ytv6Pcbffz8fV6LGUE159sgeeetVeogvlMAzsGzzdpqW4AxC9he6uXnpdnVhZWzzsAMIAV50MIJgt5hScpIGCOQlUIqY4jr/NN/dQT2QDHpm+4hlrP22bADdy7uirp8OQ1UAWvW3qTEnMVtmSl0T205In4OmlB684EChcX6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838473; c=relaxed/simple;
	bh=cPXdOCWg2Zm0aGBLPKptpjIpUx0cYGjdrLj7S7fZN74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBnTrKOG/09GoU65ubsfpbGgzeVeVqkjJxxJYd9M4f8phlt3nZZBh87rrO7aO3D13v/xxBsxEJlVHiwj9lUeeD8Urs5kyyGAXd80VpXmN9u984dm9Cz80mAm1eU3nUZfDNrkElMtAZqyR+0Iv38zctq73C/gDGC0q3ulLWuj5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVFt023F; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVFt023F"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B9D340664
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 08:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HLmEB_Wtd61N
	for <virtualization@lists.linux-foundation.org>;
	Tue, 19 Mar 2024 08:54:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6C1D240654
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C1D240654
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NVFt023F
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C1D240654
	for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710838469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cHI9Ej3Lf04bJjgoXi156s83uuxxw+VhvThPFcOejXM=;
	b=NVFt023FHgc3c+P47L5GGa3DMsJYGcVqILEPbkHqUfCEb2rr6F7FRSAxE20vaQlfo6lcea
	1WTLCCSOsKKAvq4h8+L8XBoGwLYAH5ej8zxrPJYm1kBZtiBHTRoCs6qGEkajRcaoRW7NWD
	YnGyU0iFQkQmoyK0VPKvIQQ1udjcfEI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-rLesTq3sNzOuTLE49gdf_Q-1; Tue, 19 Mar 2024 04:54:27 -0400
X-MC-Unique: rLesTq3sNzOuTLE49gdf_Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d4af32be9fso16005951fa.2
        for <virtualization@lists.linux-foundation.org>; Tue, 19 Mar 2024 01:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710838466; x=1711443266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHI9Ej3Lf04bJjgoXi156s83uuxxw+VhvThPFcOejXM=;
        b=oqpBNd/2j8pUzWpPc+pac+H+CLxwxt4wj1golRmTfDQMz2AaSP6vAiDqUc9ygX/hac
         PWrev7tQU0zRf9wYxIlDzEwdM/CDbRQfHTiv9rMKiO4Xf0TwvvHlWsEIAZASfUmlWbTq
         CcWVVe2YsL2yzCexOLkHBrIgWznpK5XYm8SbDXrsuB+Cybh069vHkqfVx3WfHGLQJ5eV
         8vxV6P6JgI4IsyPeQUJ+WrPXGXp+nwWrOI5Rl/3Bjjq3Uiktc7f1BdoWZuT1EbhdWg+8
         +yngktIG8H3W/3+fwrOBovMW6V7WPa6xErxPj747fUIovJHT4jJ+s+uMy/FT4vI/tBi5
         R3sQ==
X-Gm-Message-State: AOJu0YzH9FtpgI4DvLQOJH1R75eMhZ8iQYyKLm21SLhMFjjJfA3QGeDP
	EIp4DXvMtEtbYKHiTTiErMfP/wZ5LK0z9+sg0pKYlr9ApNBeb7n/cyfvs0P+etqVjDILrMJTjx9
	MHhllSTstfpyevgYMk1nOszob3OiSHsrbqtNXT8rlQyYObVgCpAd8xSkvElPbuI202SmSxo2IS4
	9GVPY=
X-Received: by 2002:a2e:904e:0:b0:2d4:3635:b52d with SMTP id n14-20020a2e904e000000b002d43635b52dmr1454993ljg.0.1710838466074;
        Tue, 19 Mar 2024 01:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyy3N2ZSSt3LGibqHW1RyMjjZxPlzdtcW+fik0j1Phb6wcTPnPrRqceSWT+ghux7roZii0w==
X-Received: by 2002:a2e:904e:0:b0:2d4:3635:b52d with SMTP id n14-20020a2e904e000000b002d43635b52dmr1454958ljg.0.1710838465600;
        Tue, 19 Mar 2024 01:54:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:2200:2adc:9a8d:ae91:2e9f? (p200300cbc74122002adc9a8dae912e9f.dip0.t-ipconnect.de. [2003:cb:c741:2200:2adc:9a8d:ae91:2e9f])
        by smtp.gmail.com with ESMTPSA id u14-20020a056000038e00b0033e34c53354sm7407373wrf.56.2024.03.19.01.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:54:25 -0700 (PDT)
Message-ID: <659fc57f-0c02-4bf2-9938-976200262145@redhat.com>
Date: Tue, 19 Mar 2024 09:54:24 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio_balloon: Treat stats requests as wakeup events
To: David Stevens <stevensd@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20240318091034.535573-1-stevensd@google.com>
 <20240318091034.535573-3-stevensd@google.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240318091034.535573-3-stevensd@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.24 10:10, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Treat stats requests as wakeup events to ensure that the driver responds
> to device requests in a timely manner.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>   drivers/virtio/virtio_balloon.c | 75 ++++++++++++++++++++-------------
>   1 file changed, 46 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7fe7ef5f1c77..402dec98e08c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -121,11 +121,14 @@ struct virtio_balloon {
>   	struct page_reporting_dev_info pr_dev_info;
>   
>   	/* State for keeping the wakeup_source active while adjusting the balloon */
> -	spinlock_t adjustment_lock;
> -	bool adjustment_signal_pending;
> -	bool adjustment_in_progress;
> +	spinlock_t wakeup_lock;
> +	bool processing_wakeup_event;
> +	u32 wakeup_signal_mask;
>   };
>   
> +#define ADJUSTMENT_WAKEUP_SIGNAL (1 << 0)
> +#define STATS_WAKEUP_SIGNAL (1 << 1)

I'd suggest a different naming like:

VIRTIO_BALLOON_WAKEUP_SIGNAL_ADJUST
VIRTIO_BALLOON_WAKEUP_SIGNAL_STATS


Apart from that, nothing jumped at me.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


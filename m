Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F7B24A069
	for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229301; cv=none; b=ZOuvNNg3jFXQSeCMXVSZVTe9PQeMI1H1sH5dKfgLyVorqRCR7zfSBlaIX33P0WfWGy/n3jjl6jnb98DKy6P7Bkxo7WzAuKfNwamppT8EOAXk6uTJQOYTnw1HayD+ntodTjiIa/lHpQubB2KSwpFDxlXVxpTsMDg+J5EmvVKrNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229301; c=relaxed/simple;
	bh=unu+z7fUfKJmL/eHLl0giWFWnZl9lhh73IswOVtZOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ORn8a0UrfUccRxQTJxyS43FioonuY5QLG5NroWCdibsi5zT/3EyirTyAErnCx+a177IHfDEexCaJCNx9vv/JhO8Dmb3Avdwbb8iDdZ0WRz+LRlvTvcAQAwob3mqIutl65zkqnwsMfSU52pkn7idzQ7EigXgnf8Eb4KTzqJToIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ld3QigNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld3QigNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+4uY6QtcEAOdroKyjwSP1zoQ56MLnzMwcJEHXal3TGs=;
	b=Ld3QigNwd3vrrBBohigK3opYRaesqO8WkwovrmMX1RqHOLSLuwzbr6YX9NRnV20Rt7xjy4
	dKJCTjaUPl4b37X+uEdimTiT9iFqgKzXu0mMLh2ET9sG1O4PgwK1uD4weUSk8/p2Wx1Iln
	diNCPRjp74Z2Y8aVdVozKN84QLnEQf4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-2MlKD52YMEuuTtSKUjpxyA-1; Mon, 12 Jan 2026 09:48:17 -0500
X-MC-Unique: 2MlKD52YMEuuTtSKUjpxyA-1
X-Mimecast-MFC-AGG-ID: 2MlKD52YMEuuTtSKUjpxyA_1768229297
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so4834638f8f.3
        for <virtualization@lists.linux.dev>; Mon, 12 Jan 2026 06:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229297; x=1768834097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4uY6QtcEAOdroKyjwSP1zoQ56MLnzMwcJEHXal3TGs=;
        b=sBipkuDEpRqkHwNYdh/O6Z6FhQRnuVBitBhsw46aQ+odIe64WOnVdzfsqbBBnOuLs4
         6oTeN/j39c+VnilQsd7Lm3ew2z7H/4vxkyMAGFq6pbTxKwgf3nOOT9l9YDad6wF0hkVT
         4DPjZF566iaWHu6d8U5iDEQAwkj9DELkdI/Jf/4HlA8Q0OUcg9KrqMyshR63xJRueXHC
         41lGnN1vTH81XBXaJ1Gnqb/3P6sJ7XzUUrghpQT1NL+thN6WToQkrJx2xCfc+/I8TkWB
         N01VclhUgwDJdp1jXoVtRFcKvmWTC6NajR319kL6BiR5gsARfeJkkzJ2YvzH/5U+7Na+
         vqcw==
X-Forwarded-Encrypted: i=1; AJvYcCVh4fiCHtJM7EQ2SXus4PKEhO0VRmXSojQmeXQGRsEc7lGhBj6ouw0Ysm4YKYdqZo83W+uBgfIrvl8LjDlo1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeJZ2Ty410r10GpmHpdxDnOzJBKpebCBbfBEBwAPXTJ8pY/hYn
	3jEpBNp4k98vg6iGmszeOTkrptoLb46E+FBW/3iQxemxH3e9P5eaEgm0VKCu+IA0DvVlXFN8A+G
	H3rMTwp7e8fOAJE7mmtTtfLmM6XFaBRaXVU3vxc1OnlQ6JZ+3ZHIJfyVhCoXxQTA60LNl
X-Gm-Gg: AY/fxX4m6dh75s5BOozftYCZMUz+n85U1cu5WrAwOKoFASejYud/Tsi4pX96yPwspQu
	fcRUMiLasAUaTdlAN5reXe9cgk7De9QAbaG3uozhllibfihMgOQ5CWck5ud7Fj48nfGNyEVCYFn
	9yDVN1grPjaaPr+QJKnRnZcHoojsdduhHvvG+3rwPr+GgYtOlTnUTpgkQQatRwr2ly+AeYfXvd2
	GgUxq1C42lf0+Ck7OH1XJ+KlBdaAnBcji15MilXkYxXmuaKQaIvqhJHTZHnxIR0MoN7ptOxwoU6
	I6mb3R3hq4vZs5ZtVgiT/ITNo13g4grOj485SA/SUiYpEbJY44sqb6qu6eobcX9B91OgAu+/aXD
	uvUHbQvphEX+piLVgMKK1z+TxO8r+aPc1itf1vOWxR1YFSEYgY02RdAXSvnkzJA==
X-Received: by 2002:a05:600c:8b82:b0:477:7b9a:bb07 with SMTP id 5b1f17b1804b1-47d84b5405amr219660125e9.35.1768229296682;
        Mon, 12 Jan 2026 06:48:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJzr4Y2fS6XgBSkiJLd05rWsmzsrdXz2PkPaLKrPstYswApqBsGl7lyU7UX/8hluUAjZao2w==
X-Received: by 2002:a05:600c:8b82:b0:477:7b9a:bb07 with SMTP id 5b1f17b1804b1-47d84b5405amr219659855e9.35.1768229296265;
        Mon, 12 Jan 2026 06:48:16 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432dd78f5a8sm19136662f8f.27.2026.01.12.06.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:48:15 -0800 (PST)
Date: Mon, 12 Jan 2026 15:48:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, 
	Keir Fraser <keirf@google.com>, Steven Moreland <smoreland@google.com>, 
	Frederick Mayle <fmayle@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 4/9] vsock/virtio: Resize receive buffers so that each
 SKB fits in a 4K page
Message-ID: <aWUFnZTkdOrZAest@sgarzare-redhat>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-5-will@kernel.org>
 <fa3cd687961e63dd2b79780eb84c243c8d35532a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <fa3cd687961e63dd2b79780eb84c243c8d35532a.camel@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YlJncaw1Gmqm1oZm8MZWOWoqlvifMWb_WY1kQGRHzkE_1768229297
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jan 08, 2026 at 05:33:42PM +0100, David Woodhouse wrote:
>On Thu, 2025-07-17 at 10:01 +0100, Will Deacon wrote:
>>
>> -#define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
>> +/* Dimension the RX SKB so that the entire thing fits exactly into
>> + * a single 4KiB page. This avoids wasting memory due to alloc_skb()
>> + * rounding up to the next page order and also means that we
>> + * don't leave higher-order pages sitting around in the RX queue.
>> + */
>> +#define
>> VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	SKB_WITH_OVERHEAD(1024 * 4)
>
>Should this be SKB_WITH_OVERHEAD()?

ehm, is what the patch is doing, no?

>
>Or should it subtract VIRTIO_VSOCK_SKB_HEADROOM instead?

Why?

IIRC the goal of the patch was to have an SKB that fit entirely on one 
page, to avoid wasting memory, so yes, we are reducing the payload a 
little bit (4K vs 4K - VIRTIO_VSOCK_SKB_HEADROOM - SKB_OVERHEAD), but we 
are also reducing segmentation.

>
>(And also, I have use cases where I want to expand this to 64KiB. Can I
>make it controllable with a sockopt? module param?)

I'm not sure about sockopt, because this is really device specific and 
can't be linked to a specific socket, since the device will pre-fill the 
queue with buffers that can be assigned to different sockets.

But yeah, perhaps a module parameter would suffice, provided that it can 
only be modified at load time, otherwise we would have to do something 
similar to NIC and ethtool, but I feel that would be too complicated for 
this use case.

Thanks,
Stefano


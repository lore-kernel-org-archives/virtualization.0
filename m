Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BCC35972
	for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766935252; cv=none; b=li6U3LK/hRZcK3oWGXQw+1lniKuyZkHoVsLt5S2DPMklkCTQRiDSWpk5TPJWTT6WIq+bRF9YpRlyJas+Xr2CxmIWA/TwE2oA79w7UFiMQJQnmz0SV31j3k+cKwOjPdRS6lgJyt9SbRfdq6RF6n5vI9N/NNq0vXwwl+VMDtwcq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766935252; c=relaxed/simple;
	bh=fpXtmAA+RNriJg/+1iSarUAoS4iS6sPSHSP+qgbePRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMZo1cQrpWbqTQg/41LabWrSpPJLjJGKvEUd1D98UCXUukVhdMcW6eCHgPAmV0pLUeylyB2i6/Y/A1HVg/gSmIB/ZoJSCMXDi4NnWZuXaCUTbPURLfRGdX7I+tOKDD9sir2IGtslY03YHpqQQwYZDelNJx8D6TCeL4NvoQGz7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mcj7gXF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mcj7gXF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766935249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5j0rnxqRbvo50owZYjxe/Uz4dKBVSBK5opK+mrnaIhE=;
	b=Mcj7gXF0dP/VtkYNgLI9qTq522ZHZpETtEYk5tEyWOQV99uhPUPJtO0jCMfKKDBjrBZNwK
	+isJ+cwCNxQd7vPE68q5PGiaEyKRWonWKYysL6nfQCLsnflicEUTGPC+wd0FrCRCaVC3md
	UkiRdQcCokKtXSw/S8CVJX5plqvSusU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-jDv_kmXfNIqY5RrRDRuszA-1; Sun, 28 Dec 2025 10:20:48 -0500
X-MC-Unique: jDv_kmXfNIqY5RrRDRuszA-1
X-Mimecast-MFC-AGG-ID: jDv_kmXfNIqY5RrRDRuszA_1766935247
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcf10280so6220415f8f.0
        for <virtualization@lists.linux.dev>; Sun, 28 Dec 2025 07:20:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766935247; x=1767540047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5j0rnxqRbvo50owZYjxe/Uz4dKBVSBK5opK+mrnaIhE=;
        b=bjEp7iCJGq7IIif3Q1erXev5Sn6rV1Abeb64mB6eakoNp8s10W++vbMjrEKno4O1n/
         eVOjDXKTqlmQ356pFmYPlgLwUqX9UODcyaMOm5ew1nEAINPUvfH2VnZyaklwOuptgrSI
         BIRbquDZCyEwnL1Fn6tIYPUYzDC5yStfcunzKc3qzpB7qNxZ/yMXbI9W9Zl6H8OSPXoV
         5ZWXtVXp300Ls0v/zCj9Pmjp3zzcMiFFQlM9XYq69C7i6/SC4k79UmVc765/GxgJcArp
         zONTpV+hvTe07V5DKvTB2gv3ywlPDlgVJYp4KLdN6AH/FFuKY7JzxhFyaWBxGXYr6uAK
         gm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmQK72EvJq6nnt2JpjXs+wJmIDwYkW1XYWkVdoTmKInY4YtezaCJBnHlbuPiKpYIE36LjWiOgwpqWN5MiEdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeF7FvYtkwZppq99ipwNtwWh5HADJWdr7IrDqcchRcxeg2SN2E
	jdkIethpjI1oQZjZcUmH42zSQ//VSt0PzzRnmyaf0lLylfSnHgbluaTMbVxSYInRaCMvNE5r91H
	O+gfI05kihT3ZZIScfgaqhGkvn2D1r6ci+MwV8JKR4g93V5Vb2kuc5z7DLPL/kxPOSHnw
X-Gm-Gg: AY/fxX5pEmwLQd5mWCYgy5cWNNzF0B3fI4UW5Vaz6Lsph5oevREnVPQrGT44obdN+SE
	Fqw1fs6Her8+kimj3XVezCiWitoxmtRs4vz50mDYG3aL8n8Ml36kizLfjACPiFiJd4oai2lcymt
	QpM3e3tId/GqN2STQetxASKdZ7gdSYv5sOGI5kJOLLdxdCbQEEa4MY72tBI6WMsjamB+9hY78/l
	ERmLduedOKAQ8rwBj9Lbe3N4xDSEYgw/mDwq3C8YSpFRZgSl9uM+IAv2Tor5jiqwltI1UuWhtJW
	zDZG7jg6I9G9GfAN1RqSR/R6qGnq+Y/s6RLJjUYb8e1YnAQuHeFkP0kL5Sx148jCSnDEirSbQ45
	bVm6iaMM7Xcu4pw==
X-Received: by 2002:a5d:5f85:0:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4324e709a92mr31050428f8f.55.1766935247083;
        Sun, 28 Dec 2025 07:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzGqpYSD5SPgjtty0cT7dVYSX5Xz87ZnK537PCOjzNyd2NsHpM7223xNB/jGgJBHjaA2uWlQ==
X-Received: by 2002:a5d:5f85:0:b0:430:feb3:f5ae with SMTP id ffacd0b85a97d-4324e709a92mr31050402f8f.55.1766935246640;
        Sun, 28 Dec 2025 07:20:46 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324e9ba877sm56716343f8f.0.2025.12.28.07.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 07:20:46 -0800 (PST)
Message-ID: <f7840b22-38b5-4252-9663-4aefb993b211@redhat.com>
Date: Sun, 28 Dec 2025 16:20:44 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: Split ndo_set_rx_mode into snapshot
 and deferred write
To: I Viswanath <viswanathiyyappan@gmail.com>, kuba@kernel.org,
 horms@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com,
 xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com,
 eperezma@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev
References: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251227174225.699975-1-viswanathiyyappan@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _0tans09cRNRmsLqk9b5oAr_acOsMTo8eNwNl23m6ZE_1766935247
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/25 6:42 PM, I Viswanath wrote:
> This is an implementation of the idea provided by Jakub here
> 
> https://lore.kernel.org/netdev/20250923163727.5e97abdb@kernel.org/
> 
> ndo_set_rx_mode is problematic because it cannot sleep. 
> 
> To address this, this series proposes dividing the concept of setting
> rx_mode into 2 stages: snapshot and deferred I/O. To achieve this, we
> reinterpret set_rx_mode and add create a new ndo write_rx_mode as
> explained below:
> 
> The new set_rx_mode will be responsible for customizing the rx_mode
> snapshot which will be used by write_rx_mode to update the hardware
> 
> In brief, the new flow looks something like:
> 
> prepare_rx_mode():
>     ndo_set_rx_mode();
>     prepare_snapshot();
> 
> write_rx_mode():
>     use_ready_snapshot();
>     ndo_write_rx_mode();
> 
> write_rx_mode() is called from a work item and doesn't hold the 
> netif_addr_lock lock during ndo_write_rx_mode() making it sleepable
> in that section.
> 
> This model should work correctly if the following conditions hold:
> 
> 1. write_rx_mode should use the rx_mode set by the most recent
>     call to make_snapshot_ready before its execution.
> 
> 2. If a make_snapshot_ready call happens during execution of write_rx_mode,
>     write_rx_mode should be rescheduled.
> 
> 3. All calls to modify rx_mode should pass through the prepare_rx_mode +
> 	schedule write_rx_mode execution flow. netif_rx_mode_schedule_work 
>     has been implemented in core for this purpose.
> 
> 1 and 2 are implemented in core
> 
> Drivers need to ensure 3 using netif_rx_mode_schedule_work
> 
> To use this model, a driver needs to implement the
> ndo_write_rx_mode callback, change the set_rx_mode callback
> appropriately and replace all calls to modify rx mode with
> netif_rx_mode_schedule_work
> 
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


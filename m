Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20443DA7CA
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596364; cv=none; b=nmS4Z79WEXFDasICPeGBbDctyGMg8ufjVBNYUHP7X/uaYUKQb8Ti7/RLPOWm8vsV7VWMzuYIogWvV7RASBXhC1g+l+h8+xOHl/LAf7syHy29w271bP7aj+/wKZDuOnCu+hqw40uxEEGGiPig3SPP+4lnVnwCM+Q02aMF3hItlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596364; c=relaxed/simple;
	bh=roAbmkmF2Ua744ApOcxkj0ppmjvG0gQMyEjsgkuHtJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=K1j6MCeltM+V39NvfWqv9lCmb0rGY/Ew1yR4h6jHs76rZZ6Q83IjJ71U1SNLaTZbt1P/XJCmL5kd7c4UVjaPm6K66kuLkANSuWV+C4u0aaEdHywWKrT4qyvfuc3xAy9MVzabfYBbEhg/wrmGVfkyd8Mnwxzg3mkJXJo1lOX+iSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izHDFmDj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izHDFmDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781596362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9C1tt1ScGlutsIGtKWOVOCVDGyzg8ZLvaEJnUvjWVXY=;
	b=izHDFmDjTDxrpT/adPSxgexFkLn71QX5+tRBuo7nRxZ3H4MJj2d9HzFZZ1Eabgq9D9/8wY
	WnkYw1Yyx1BPwoG9KTh6Jg0nLD6e/HeJG7wuqofJD/2cI3qwIH3D7g2bIGa+3IY1O47LKT
	QgVxaodmPYmOt4eaQvp/zM/v2/6wSnc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-bBg9b0ItMWOrHG8Zs46iiA-1; Tue, 16 Jun 2026 03:52:41 -0400
X-MC-Unique: bBg9b0ItMWOrHG8Zs46iiA-1
X-Mimecast-MFC-AGG-ID: bBg9b0ItMWOrHG8Zs46iiA_1781596360
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45efb6e60e4so3700343f8f.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 00:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781596360; x=1782201160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C1tt1ScGlutsIGtKWOVOCVDGyzg8ZLvaEJnUvjWVXY=;
        b=WZuRC9MJgNuV6iAhjT8Bcjd8KIUrgctZ16uAWgIwk+eNQL0mrASUcTZSYSn7MsCt6X
         GwpP/xb2lug1515gv5v/urbT6Kl5jDxltc5anpKzPBVanrFbKXaBAxyqychdfi+AM6QF
         PyURG7m6fkHPHSifeG4f6mEwpVThaAE3SYto6qjGzmyPhc8XefAzp2VqpvwWB626YGYe
         q17HOsTDjjxMNhz0y8+QZCSNHvZhkxytIV+l+mjiJ5p/6HSPKSWLKFnBJYvKAG8ssRFU
         xAij64U7P2IGMT52Kv0jfWiHnWKL92ZVqj0g1Ys002R8bt5UTgBOjPzcZ7/vEjHn+EFi
         RvDg==
X-Forwarded-Encrypted: i=1; AFNElJ/CSJmduJJHcjHvRwafu9BOsmfDK1ln0bDFhAbDrRO4N3pB5cVFBWg7k429OjR+70rVLcuhn+8l7Pbl7LJ/yA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh9PO6jw2WoaNwxasV7YiP8b7gF7zcuTB5A1nLsicvyKtRIIx6
	0IR8FwRBIqYtc2HsQ9Sqq1h4SFwNUapLa0py2nh9La4FCdawPPfW0lDD3GBbf3c8iQmselAiD6d
	bk8SDDr/C6ODiRMUyCCt6gVrma+lm2aBr5eq/cJ+4/iu/yIWYuqSoKBTtyiWKyIpNxVj0
X-Gm-Gg: Acq92OHWWR7ERsZw6S/XCQTOZ4zAZnjvLlgFqBeC3HNFMhAy0eA33uWXu0HC6lNsvRn
	K2NOKby6HD0+78cxGWPgEC0QYc0W8mmPZpjnOMQddMi7sIJ88qnCmwbPZOkseAI8iFDZm1LemhV
	V3WhINqSaRa9jOATfEm+bH3tiO3NP0vXg987H+PeUI6itCLwTAndU0FjXD+pS5rmgwWgjvuoi/j
	fqfMBHQp0mxO9QjE1Fp7EiGL/hGlPidZv6B/ZR7QsaNqekASWMez3HVvClTJBghjEKsgFQMBuMR
	tfSiRL3ifp6CygooQeCFKqF+ApWNuMj0ImwNYw+QCuJGhFRrBnajJEcEVW/xn1nxH6/0GV1wULq
	kMaWAViD1qPBjHv66iMF8LtOgvev7g+zH5vfqN8v9pAx6Inf6bBKzOIy7CUPn8b3wPZMf6kY=
X-Received: by 2002:a05:6000:2082:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46074b82278mr19488745f8f.14.1781596359940;
        Tue, 16 Jun 2026 00:52:39 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46074b82278mr19488703f8f.14.1781596359500;
        Tue, 16 Jun 2026 00:52:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d9becsm39985553f8f.34.2026.06.16.00.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:52:38 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:52:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com, jasowang@redhat.com, 
	kuba@kernel.org, leonardi@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com, stable-commits@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <ajD_FBEak8hKNdIK@sgarzare-redhat>
References: <2026051553-santa-unretired-a417@gregkh>
 <20260515113503-mutt-send-email-mst@kernel.org>
 <2026051526-banish-strife-6dba@gregkh>
 <20260515114521-mutt-send-email-mst@kernel.org>
 <20260516170159.vsock-virtio-unbounded-drop@kernel.org>
 <ag8EvTp29B-Q3nCq@sgarzare-redhat>
 <2026061624-harbor-capture-a5bf@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026061624-harbor-capture-a5bf@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZE3fU7-OK6kB6GQGnyWr1DwRRl3HkyY9LoUYMBRZNKk_1781596360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 16, 2026 at 10:17:31AM +0530, Greg KH wrote:
>On Thu, May 21, 2026 at 03:15:54PM +0200, Stefano Garzarella wrote:
>> On Sun, May 17, 2026 at 09:33:06AM -0400, Sasha Levin wrote:
>> > > > What's the status of that fix?
>> > >
>> > > Stefano posted v3 and is working on v4.
>> > >
>> > > >  Should it be reverted elsewhere?
>> > >
>> > > Donnu. With the change we have no DoS but the socket gets silently
>> > > broken.  Eric felt given the brokenness is upstream already it's better
>> > > to work on a fix on top, not revert.
>> >
>> > Dropped from the 6.6, 6.12, 6.18, and 7.0 queues. We'll pick up Stefano's
>> > follow-up once it lands upstream.
>>
>> FYI v4 is now merged in the net tree, so I guess they will land upstream
>> soon. I CCed stable on both patches:
>>
>> a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
>> c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full
>> buf_alloc")
>>
>> Both are related, but the second is the main fix of this patch.
>
>THe second one doesn't apply at all :(
>

The second one is the fix of the patch originally added to stable queue 
by this thread, so should be applied on top of it (commit 059b7dbd20a6 
("vsock/virtio: fix potential unbounded skb queue")).

I'm working on improving memory management, but for now I think it makes 
sense to backport all three to the stable branches.

So, in summary:
059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
c6087c5aaad6 ("vsock/virtio: fix skb overhead accounting to preserve full buf_alloc")


Thanks,
Stefano


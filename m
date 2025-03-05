Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E124BC02
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194847; cv=none; b=A81oqH+IHrRsvN0gvJcw5KWwoeqrqoZuLPoMWN0B4pQCSQTZsdx+4tpHmRfzw50JrcHz04jbV/UL34ZGCWDS6QrXeYJy1MFPROl6AYa5Pn2O6YXMOnaGWJAmOTmfiS9llnlxMTDPik6+oeflkkAzUQ+zw02/ywpi+wYpSuJ8uPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194847; c=relaxed/simple;
	bh=JG3bEgryVkD89ivJEHDvKdoz5pX+G5di1bV0ReHD08c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJqjDjv734jABtia6PYAvC4ufjUqifnyZT+JjuJ4di1bJ3kUu1FK231ukG23kCyROzYDSRJPZh0IPPv0lK2lPsd+KSz1qDYNJo1W95y2fcV5vZVG2aLv674gh3foN3BFc7Td67LFH9+MDFyjlNDSfWNr+QQS40+SNn5pfCMxr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWizGQkz; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWizGQkz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7143483EDE
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 17:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dZCKw7Nxt0RN for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Mar 2025 17:14:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=bobbyeshleman@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8BF5C83EDD
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BF5C83EDD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VWizGQkz
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BF5C83EDD
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Mar 2025 17:14:03 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-22334203781so21834015ad.0
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Mar 2025 09:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741194843; x=1741799643; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDY4vgETAYK/Bcf1CBHzUdesUL3jSm/FcT00+a6QmGo=;
        b=VWizGQkzNpGfdJiSUu9xknJ+N+ICFvkwhPK3bu/yLBdLsELOQwJNvsoyo+GEjUKI0T
         srQPmdVb/VNOfkqtKXS4ETv0+J3SNw0ad08w6mGBtW0lpZiJJ4c1Q1kCCzNpE1tGD/SW
         dkHDvvvAmdmdIo9im0RyyJ5UoPwwXV4uNs98RIyMxdMAJR/ZljcvpI+z5inUge3sQGUi
         3zC2/aSglOewgcTbyyCSfsj65ELtPt49d3PwnYb1BvDYo6Us8MKucUXLZTjF2eWcbzPD
         SdqOG2Mjp4LULI7/MePs59uJf5IePYfHAfxjfxlGekUqwfhWGhoEkH+gKo0wsAxsaz5L
         KCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194843; x=1741799643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDY4vgETAYK/Bcf1CBHzUdesUL3jSm/FcT00+a6QmGo=;
        b=i0uygTpjkhJGvTv9M6m4t1ywV+azy4113K7dJfssyl4NdYM4CDKmWyYwhgvu7+XZik
         I39Qs5rTV7+C58uJrelaE2qQAC+S1AcGkTDYpsOuZ8fH31QtlbxtFOkwxj726AkXEuW1
         XFnUHCu3TLMhBGXk64qUsQCAZcS2hDPFKflaaas/+FEEzQ4boL3XaxiJom5xMf8ni5W/
         KBFPdq2wh4UusT/5vZfy918PcWEh9qC69tXbZ7k65y//b4F8F2JXTcyhtI+CLgJIX3On
         b38snZOIsLBvDpdIt4w0yKNYI9uun4qlsysbHVDDYa6OeTk1VsUCzeT7qRaXasnEJcx6
         Blhg==
X-Forwarded-Encrypted: i=1; AJvYcCXk2hGbayYbyHGpEXQyaDt6Kt9+3xXhjK1+iSsKsgclfM+ra9EROigw7bzvkaeCGd9U+96qPmrq4oPRSOvqSw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyNdH1dSHLjyy7zK1cUOWoK25UgVW4ccK1ppy4znzfxvjKZ6VX7
	hAT4ButVwoY6mLUW22fX0f+yOoSbBXSpeL5IwIe6NiBctpYJACOf
X-Gm-Gg: ASbGncvX6FHP4MamiYuBq2X0oW6QKIu3hWf6sEtyFqY4hkdi/58g9+ue61//v6BAnPa
	gTfdvI+cjA+oXbyqiX3Tu4CZQTbxSQw/Gv2bzgenwlOmzcFJSjCmOSWksAKyJ1xtDvnpjajvB0S
	eUka1FN7ZWiNihvsfW/pgeierr7Jp3BPcRqyXAS63PZB479XT66xkmiKcKAEEqV9k3L3pxkVV1p
	j0ILSEI6bkdTB8Z1GHM7fp6Y1sl+uLXCiSbojAck7K5zGjk91UdIMZG/COjyg8XV7ngvqgJItj5
	wmbMuU9VIxa8s4UH/BBN2xMqzO7qzyXjkCJt/WPajgXXsX7cH/1eGV73dHnbZcO/Ng==
X-Google-Smtp-Source: AGHT+IEdZkMPD62CNO9btal/a+oXLs3ROwPZYX/AQSk8n+IbCHpG0Z2D91NOXzOmsZW9ggc8Myd3iw==
X-Received: by 2002:a05:6a00:26f8:b0:732:6276:b46c with SMTP id d2e1a72fcca58-73693cfa00emr165967b3a.0.1741194842711;
        Wed, 05 Mar 2025 09:14:02 -0800 (PST)
Received: from devvm6277.cco0.facebook.com ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ba1371asm7133443b3a.5.2025.03.05.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:14:02 -0800 (PST)
Date: Wed, 5 Mar 2025 09:14:00 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Dexuan Cui <decui@microsoft.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <Z8iGWLsQGdTv47je@devvm6277.cco0.facebook.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <Z8eVanBR7r90FK7m@devvm6277.cco0.facebook.com>
 <cmkkkyzyo34pspkewbuthotojte4fcjrzqivjxxgi4agpw7bck@ddofpz3g77z7>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cmkkkyzyo34pspkewbuthotojte4fcjrzqivjxxgi4agpw7bck@ddofpz3g77z7>

On Wed, Mar 05, 2025 at 10:42:58AM +0100, Stefano Garzarella wrote:
> On Tue, Mar 04, 2025 at 04:06:02PM -0800, Bobby Eshleman wrote:
> > On Thu, Jan 16, 2020 at 06:24:25PM +0100, Stefano Garzarella wrote:
> > 
> > One question: what is the behavior we expect from guest namespaces?  In
> > v2, you mentioned prototyping a /dev/vsock ioctl() to define the
> > namespace for the virtio-vsock device. This would mean only one
> > namespace could use vsock in the guest? Do we want to make sure that our
> > design makes it possible to support multiple namespaces in the future if
> > the use case arrives?
> 
> Yes, I guess it makes sense that multiple namespaces can communicate with
> the host and then use the virtio-vsock device!
> 
> IIRC, the main use case here was also nested VMs. So a netns could be used
> to isolate a nested VM in L1 and it may not need to talk to L0, so the
> software in the L1 netns can use vsock, but only to talk to L2.
> 

Oh I see. The ioctl(IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS) makes sense here
and seems like the simplest approach. Maybe we don't want multiple
namespaces for virtio-vsocka then? The problem I see is that then users
might expect non-colliding port spaces, which means there needs to be
some kind of port-mapping, which would then require vsock users to pass
around their port mappings out-of-band...

It sounds like none of our known use cases requires non-colliding ports?

> > 
> > More questions/comments in other parts of this thread.
> 
> Sure, I'm happy to help with this effort with discussions/reviews!
> 

Awesome, thank you!

Best,
Bobby

Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42850285
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015271; cv=none; b=mE38KmBZPrjdtWAKfoF9O1JGpO7hTrYcaD4nlUPnVXvk6sVWm7Ihj81rrj0Mniu5Sx2wBen5BLU1hRehOG5bOslB7PAUDRzkwxDZVAIO3Mefqyd4NDz6kOcX9lHRypF/23+J4JHzM7V9ce5Ajl7qWRsSiKYJA0Zyal0roN5hXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015271; c=relaxed/simple;
	bh=fort1JpzFCk9aJtnmJGBE2dcNxsiha4izVe2Fx5p3d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lZ5ytePgiu7tW7R7Wie3FZCbilqlKzLYNvC6A9lX2wkJdx4Yc8I7D7YXD4lwx4zoqUKo4mz9gHf8dB9NC2MFMJPdAhGnzkaPaAZrmn52QQ1PQCDqna4J6Bx1lc9vosyyUMLtHgZUJcpXyUYLwDeZmzRKFgL8fYeraM7R7l9tgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTRgc7kE; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTRgc7kE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 863AC41423
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P37nlmTPu482 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Jan 2025 08:14:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1B02F413EE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1B02F413EE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fTRgc7kE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1B02F413EE
	for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 08:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737015266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERbJSuqsAOXaaj6eB/CkwpIU16l9eEjJ8jUx0oPfO3Y=;
	b=fTRgc7kE8hh4l7jRuyDI5GItj6qh5RMHvzOX+QXmPgNF98xK0daWm6wjHWrgPH3FuqW7Q/
	N9j8NJ9fEVzuPTjcpKNCe2c/1Oa2CA5umSGwRTcctsDSR6SfenPb1oyQsi/s65tlk5BeBr
	g24vsliaYeVF5OYMqlwW688Ow1pFYz8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-AeTDGG7VPj663pRscXyIeA-1; Thu, 16 Jan 2025 03:14:25 -0500
X-MC-Unique: AeTDGG7VPj663pRscXyIeA-1
X-Mimecast-MFC-AGG-ID: AeTDGG7VPj663pRscXyIeA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e49efd59so287509f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 16 Jan 2025 00:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737015264; x=1737620064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERbJSuqsAOXaaj6eB/CkwpIU16l9eEjJ8jUx0oPfO3Y=;
        b=HDrUzcqXBNcNi1fkSZ6itwkLE+h/gno5u2Qtokvbln3R9QWFX/lTI1f3i/i730IW2C
         Kv9emkrv9Uuv7wOcCDHWci9wzgupexGFYF+/tbe9pxARIU5tdTcnSUY9jgrB2jyyvpfk
         IAzFgcB+uqsOy1iJuW11A1AVX+0zRj0p4DV0O5EPYzyrZc/8IaKjeQeWDJlzk1woyTn5
         Z2UMxlq1Oo2J+OHuRBQkyV2mkGqCWTMavDnOqdWuC7cZEZ4jyGLDyagKsLyeGaQGcWEg
         ALVas25oEP1zdpPtXQLvjBDqb7pz3QhW692g11bKYq1G7kBhCP9rmCGJ3FTkDew9IuHj
         sFow==
X-Forwarded-Encrypted: i=1; AJvYcCVwencf/Zh7lYqKyCyrV3ThvbF65HvxPrPzLSYLttG0rvvwyvGJALWl99idmcq3Ck/Y53tYdh9F1QGIZQBnkw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz2ovgzNWJImUttf8K/8PJkZXfaxnGcP+l/Rn6AJ5izFgPdHjS2
	FkbZ3m8iHqJMbqJ8iF4J2f81HEZ0xLvGH8nZmehw1VWA/35CXBJiAQefHdmqMr4V3pz1WEHfdfy
	9j1qBzo8EF/2s3vZJaksWzEQkT7HhYuq843Oo9AyyHzzco0zk4HjWhf6JkedkKuK/ttyu/UsxhI
	Ys4dw=
X-Gm-Gg: ASbGncucyj9FAtfx7Sls7Dyo0UJhSEyhNC3NINcIB26lpXPTtE2bzsmT9ZNuuPOWWF8
	LJ6/SWOaCT7gmE1jSZe7wunkU7QrlkRx9hEGV7Hkbv7656rluZx7wi779Pu8m9+Xye8CjO/pPY4
	FUR5kQcikKXZkHx/wC7GyiDrZXF586jWjtWXGbhCZVBCv/Dhm/Zq3AiuxFkFUONjtaDo9UNN/0o
	LNMdBNfLR5M85lauTkLh3+VZcs3Yc9FohfGmGJZLEfmYGrsdXro
X-Received: by 2002:a05:6000:2ad:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a8730dd17mr7142031f8f.39.1737015263727;
        Thu, 16 Jan 2025 00:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVuBvar1zeSUO961UzYaw/R6lkjncjPewk3IhqyjOPRMXTTO5yWHL+JU+PeFfMlECdyG2zMA==
X-Received: by 2002:a05:6000:2ad:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a8730dd17mr7141999f8f.39.1737015263364;
        Thu, 16 Jan 2025 00:14:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm19629001f8f.3.2025.01.16.00.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:14:22 -0800 (PST)
Date: Thu, 16 Jan 2025 03:14:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
Message-ID: <20250116031331-mutt-send-email-mst@kernel.org>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qhCa_t-ucEh07McgrjqkSPcwHuf7oTDekCrJ2McOEAc_1737015264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> The change to virtio header is preceded by another change that refactors
> tun and tap to unify their virtio-related code.
> 
> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Will review. But this does not look like net material to me.
Not really a bugfix. More like net-next.

> ---
> Changes in v3:
> - Dropped changes to fill the vnet header.
> - Splitted patch "tun: Unify vnet implementation".
> - Reverted spurious changes in patch "tun: Unify vnet implementation".
> - Merged tun_vnet.c into TAP.
> - Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
> 
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (9):
>       tun: Refactor CONFIG_TUN_VNET_CROSS_LE
>       tun: Avoid double-tracking iov_iter length changes
>       tun: Keep hdr_len in tun_get_user()
>       tun: Decouple vnet from tun_struct
>       tun: Decouple vnet handling
>       tun: Extract the vnet handling code
>       tap: Avoid double-tracking iov_iter length changes
>       tap: Keep hdr_len in tap_get_user()
>       tap: Use tun's vnet-related code
> 
>  MAINTAINERS            |   2 +-
>  drivers/net/Kconfig    |   1 +
>  drivers/net/Makefile   |   3 +-
>  drivers/net/tap.c      | 172 ++++++------------------------------------
>  drivers/net/tun.c      | 200 +++++++------------------------------------------
>  drivers/net/tun_vnet.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  7 files changed, 260 insertions(+), 323 deletions(-)
> ---
> base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
> change-id: 20241230-tun-66e10a49b0c7
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A23225A2DE
	for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315203; cv=none; b=AVtlb1pjvFIb6ooAudUQ1CzA72mhT7O8GZUkvL5lVVcoypI9G9TL9bQQ3kjJe5DxTBF2w+6E3cMlIhmNiz+6A/xrg2aLIbc5RKnG7vLDfLOnU/NWw4QXpXz98M5RPMlEnJjeh+CHIOTTsq8KF4W0iGkGsIyDsZntYciTrUpAzW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315203; c=relaxed/simple;
	bh=2hZQd5ccuxCC0AQonBSE9AjAhDyO99yxUSsTxYrB3Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HxKJl5gbbPcK4uq/QwMNl74HNahspaDkdiFmV/6PhrLZh8oje45MyAi8C6W5LzpuTqoTSEh1KC9lGFQ4Dhqh3mZmrTCHe8U8CoFJHsej7R34k8xlyAVbYSspMh82lHiQG7yoE1Ni1NJoTEFv8SRdfSEmv72sU/x4Gl3/3SLPmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxSfx36p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxSfx36p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768315201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vI5WiD76L9Ehd6Z/1lg+/ZLNpd63ZuSYDf1K66rRYIM=;
	b=XxSfx36pt58PzoTc7hYyrmE0HyWJnaT6ng0XY2+tvtsiJ3wpBgfbWSM5A/BiZAQ8cPqUFd
	lfBQ/l7i8P8V709pB8V4mWKb25pNz4aVfK48tCdf3LjOOywf5YBdpXqYWHcl+EAqGFcdZ1
	NbTWm36JFlvp1sDARwVbuhIllieDHw4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-x9N0K8LJODONEn8UMyAtKQ-1; Tue, 13 Jan 2026 09:39:59 -0500
X-MC-Unique: x9N0K8LJODONEn8UMyAtKQ-1
X-Mimecast-MFC-AGG-ID: x9N0K8LJODONEn8UMyAtKQ_1768315199
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so79398375e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 Jan 2026 06:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315199; x=1768919999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vI5WiD76L9Ehd6Z/1lg+/ZLNpd63ZuSYDf1K66rRYIM=;
        b=SzG56DwflpRHQrrltWvSL+sx8dYW8XevVywapDcChb4eRgRznuXklU4Tg8v1gfk95Q
         94SmXpOkuuZSAmBfwkWO6TOZuWAjQR8eCjrhKISBZG8Iggjk3X4nYtTjdz3TJH3f+vNy
         fDZQJ9K1irPrNm+8APf0r8BpkUNSSWdE2HgxN5/40onHCgSl50cjDVrSjCM9Or+BtN0i
         NT+vQZqD9tcF1X9HkwbuQuHDpyB1VgWuYXppty9ahXxZxQGaL+XK23mJcMtk01FlbKxS
         GTgjs69hvuvYrfECS0MLYqgVQ6GnpY7PMKtvbz+UriUngCWr2KsXa7zdi5kzC1UsUFP7
         iyxg==
X-Forwarded-Encrypted: i=1; AJvYcCUPwBYLR/77znraLE0oFtSQs2iMiGesjTd8DjXe7K2g17fLMeRY9EmHgHYcMZoL9tDgcxdci8aYUE7D3PDYmQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFPp+S/YgF3JNxpWXPjcBLqBeeocdYH1j6Dd4RfyEF7qGTod44
	rQMeXdqgFIafWqBwDi1jK3UoBglB/2v7fSsiMo7slMIB+gcNpX//mE402uuRyroWc13jGfrupFd
	ZXB1OWodTYfrGERtjmqOgXHUqLP1GRyHGpGj6UoybotEZrOHWNNOpMNiWAzE6hGjHoBbu
X-Gm-Gg: AY/fxX6hA6vELW9U3XdiozRSFvXTeUI+3G5QCjno4I0SLJFqN6D2MeJ5Dwrli57uISb
	udw4Gk4SKW9DITgF7RzSz2APiOb1qXtfO1Au9dsewAFINRK6zuVmhXzTpiyGcCHcOQS/5Jj0Yik
	aMWaaGtGPWZZJyd2MkkPsyCBmGZahcuTSTzdjGLwKUZi2fmwqlNmjDQmp/OVo4xfMSdauYk8SNA
	XWom43Mc56cs02uk68LZPNT33Ku+PpQSUJXq9BfboHJGopNrsAKuT0wcgy7g2MtYxbyaBp2S+q4
	ZMQ433fKGbMHOVKUhqV+X5IhKlspiZA51VobmHf9eOA7a3sodQ8I9xuIQ09I6q0aW5x0+YOVSus
	Jm78QkBr5Ew+KdcDOml6V/cPRR622lRE=
X-Received: by 2002:a05:600c:c493:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-47d84b0aaaemr221925385e9.4.1768315198610;
        Tue, 13 Jan 2026 06:39:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEegKDUfwO8TWm5wKSLnhblYGT24MNgG1NnbHZguDqFhvW2s+7iCnFk9O9XcmwAVqNDE6f4XA==
X-Received: by 2002:a05:600c:c493:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-47d84b0aaaemr221925125e9.4.1768315198204;
        Tue, 13 Jan 2026 06:39:58 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm398836085e9.5.2026.01.13.06.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:39:57 -0800 (PST)
Date: Tue, 13 Jan 2026 09:39:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260113093839-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
 <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S-2K09p2TDlFuy5CL7U1SK6LS2n64jMJlALJR23vKLw_1768315199
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2026 at 03:30:00PM +0100, Paolo Abeni wrote:
> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> > Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> > along with the following warning:
> > 
> > drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > This helper creates a union between a flexible-array member (FAM)
> > and a set of members that would otherwise follow it (in this case
> > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > overlays the trailing members (rss_hash_key_data) onto the FAM
> > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > The static_assert() ensures this alignment remains.
> > 
> > Notice that due to tail padding in flexible `struct
> > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > below:
> > 
> > struct virtio_net_rss_config_trailer {
> >         __le16                     max_tx_vq;            /*     0     2 */
> >         __u8                       hash_key_length;      /*     2     1 */
> >         __u8                       hash_key_data[];      /*     3     0 */
> > 
> >         /* size: 4, cachelines: 1, members: 3 */
> >         /* padding: 1 */
> >         /* last cacheline: 4 bytes */
> > };
> > 
> > struct virtnet_info {
> > ...
> >         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> > 
> >         /* XXX last struct has 1 byte of padding */
> > 
> >         u8                         rss_hash_key_data[40]; /*    84    40 */
> > ...
> >         /* size: 832, cachelines: 13, members: 48 */
> >         /* sum members: 801, holes: 8, sum holes: 31 */
> >         /* paddings: 2, sum paddings: 5 */
> > };
> > 
> > After changes, those members are correctly aligned at offset 795:
> > 
> > struct virtnet_info {
> > ...
> >         union {
> >                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
> >                 struct {
> >                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
> >                         u8         rss_hash_key_data[40]; /*   795    40 */
> >                 };                                       /*   792    43 */
> >         };                                               /*   792    44 */
> > ...
> >         /* size: 840, cachelines: 14, members: 47 */
> >         /* sum members: 801, holes: 8, sum holes: 35 */
> >         /* padding: 4 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* last cacheline: 8 bytes */
> > };
> > 
> > As a result, the RSS key passed to the device is shifted by 1
> > byte: the last byte is cut off, and instead a (possibly
> > uninitialized) byte is added at the beginning.
> > 
> > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > moved to the end, since it seems those three members should stick
> > around together. :)
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Update subject and changelog text (include feedback from Simon and
> >    Michael --thanks folks)
> >  - Add Fixes tag and CC -stable.
> 
> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> think it should land in the 'net' tree, right?
> 
> /P

Probably but I'm yet to properly review it. The thing that puzzles me at
a first glance is how are things working right now then?

-- 
MST


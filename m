Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538442;
	b=5m5TaR7cQueL0amvQn6krC4/wh2RnRawKhgKL4E/T4yP75YHRfM2hkO4WLGZ2P3NBwvr
	 zi08o+SDCOfGuBhALqLFJPuCjJTP+WYw/bvqEK6kvYM0JX7PCsLBlTw42YMIhniKF3lcX
	 xMW+GLbgfskiqr6PLQFMzbZX9iNy6Ro8W5dwX3itKY4EZe2h91s6v1nOsZgmxjC4HYIcr
	 sDfbqI5QMDCNVPMk+w423Yc7T4XZrP2qwg5RxVs7CDtICox1WolcRcw0JIffq03k/oCm1
	 39CeEY0q//oZNiVjLAGBsqI3ZfTLBvSCrICm/TaFQ8rsWRR091oBGRHowltjGO7wQ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538442;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
	b=BHtaVLK8dDuQlKDc4LiNEbnX9WrxAIRVi2WIGrhgE7XCmqyjieJ2bZ95BBPg/3u1jat7
	 duHDkZi59HDR3LCN58EyOi50F3antHOLKzFHUglHmlPtcg8tgpmWu3jHbxlq23mm+Lhu0
	 jwQnRi/Cn9ESSjPdnKMsf5yyveS84mmUg48552RPGthgDB2UyNc2D/AWDHkiiLE1b3yIl
	 FNEF5/zjP3emfh9ZJTVzrsIY2rvIIGFw2/KpvLg+NntJnUcbw8Yfe5zrx/eisFvB/OpOX
	 9TZcEfnJ5aMlqAacbbq0+1POLfVFPdkmcg9wbTOvmKt/NZtmcejkIy6F6mjEzghEofg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOO3im+7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD118606A31C
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 23:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD118606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOO3im+7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792538440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
	b=gOO3im+7T0jHqNyBUA7byCUMNLOYstoaaEcnNT9tJ5RX/w3lur5T9o0cVKvOMiq6xtO0vv
	De2cBvJ7zHO58oMxNKQaLBWOgLmJoz36/avKeZQCTVIxOdLgc4vtY/2gUnQOq/DGuWXIIA
	JVpkuwnqduv9V6jVOVtEj6XDxYuBcNM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-yyzWmNOaNjaFC_BKNa751Q-1; Tue, 20 Oct 2026 23:20:39 +0000
X-MC-Unique: yyzWmNOaNjaFC_BKNa751Q-1
X-Mimecast-MFC-AGG-ID: yyzWmNOaNjaFC_BKNa751Q_1792538437
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48dfa054f26so73897f8f.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 16:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538437; x=1793143237;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5fko3A9W0gmx80fHOluIXSlmSb91oJTUY13Ek4gCSw=;
        b=ycicj0oxxZNsmU+pPBHM4gqfY5ZfdLmJcf6mxqtv37yR8GIkbXdm/CRappdcGN+7Cl
         vVvsQQFfu3BziYgL8EVSttwPdGf/gYZTBbd4xqVv28ZEVeVDRPEX4PQw0LCVSksmYXq0
         k7ZpC9z72SWyRdWg+pQE62+/fWzXdez+uENzGA2h+4OXFeYmlYT6AAFtlAaoO9FC/tMr
         GZJILJPAVjLDjYSQv/H5wAxs2NPI2usp47VkxGrc0xIkF1zGVqDUDH9ElkOM4kDdhZq/
         fVZFAO31jX/rhX6DUgBBgtVrx83a/5eiGjQz8awtgyCvgD9xH7eDTARhiJ7nqj4Ul4KV
         ZB9w==
X-Forwarded-Encrypted: i=1; AKwUvBxWM2I7abl69UGiyXAbLigQvnY8XaBaML4HjwZ1UPChfUP2LrqCKJSLA0q5SWh53P43HPbeT8wtKQB8mPnLGw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLOQbXrmPjxdtuYwvuY07g7UKfI4Nv07fiPMMwxODL1sGtaxhVN
	fzbmUsJfIBnqGbht0hQ/ERTDz/Ii4YKPm1ECYVj5EiZ4U9oGe69C0SKCR/y8KGkEUM5Dc1dk46M
	JeCg02wd/EOGVOuxf6FEECVA6czcPLDqLHjaLv2KHCAv7vxSb8D9AOJCOW78A96WCbZ6b
X-Gm-Gg: AYBFou2nP0IiudgItbHZvQx5/KiGQZ9qXobcJaqrRfU4omYEEvXIhQOQ6AK3RAwjzkf
	/HxMDGvjesAoMLLEzX7Gm71B3l/rnzHooxVWfTgyfbKkjF3Un7dPen9Am3Kwf4J/LjPDTr+0fcL
	Fzw6Cjqu32LV6WL5OILGtzVwMowsS3+aKEksSgIxmFZwx+7VUEerS3iXfwetGdYbJTirsdb43Aq
	asjhAjfTw4udWma/vwrFAju3RETkutwfdeifigc9zDPfV5k+OJxfCvkB2R/I5dgPIpgKL5aW298
	5bjsVwYrJiISGRueR1uJxC0GLbXPNDnWtEcqNBJV4dYHOAZ/ekKWYQBWH057fcXCMiy45w==
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id ffacd0b85a97d-48e2642ce22mr436283f8f.2.1792538437157;
        Tue, 20 Oct 2026 16:20:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id ffacd0b85a97d-48e2642ce22mr436239f8f.2.1792538436673;
        Tue, 20 Oct 2026 16:20:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f0a2sm1544348f8f.10.2026.10.20.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:20:35 -0700 (PDT)
Date: Tue, 20 Oct 2026 19:20:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020191918-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
 <20261020165610-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.34b42ddc625c5@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.34b42ddc625c5@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ruwV2hPQoXDGwJvcjDXYYZSq5Ub9n_SqnaHeir4m7LQ_1792538437
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 07:13:42PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:54:23PM -0400, Willem de Bruijn wrote:
> > > > +/*
> > > > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > > > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > > 
> > > it appears that they take the mutex_lock below
> > 
> > Some of them? But
> > virtio_net_hdr_csum_check_disabled doesn't, that's the point, right?
> > 
> Yes, but the statement is then too absolute:
> _some_ (or most) readers don't use a lock.

don't use->don't need?


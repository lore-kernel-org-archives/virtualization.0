Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5AA2F6561
	for <virtualization@lists.linux.dev>; Wed,  3 Dec 2025 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768843; cv=none; b=VFjiCbCMl673KTpn+ccbkwFFvK4W5nglOrbKrAexMF7ZwaZd94Y+hpSHNHDlc1SQeMfp/G4qZLpJPR7IYjKob7v2e9c56iNKk3MUGdSwOi0fglmf+FOHslbNDC9m6bOycYmPFEBm1ILiXjgnWF5vkjwIDp1aM0fwZVHYNSge5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768843; c=relaxed/simple;
	bh=Dne/Ve4P+xeZREEkkpT7miAIMUs8CpeyyxsD+TSDMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rJdR7tC/tUQgLwmjYaGCx1mNSqQ3kdjAqrsKTZIxaMzIVXieUTCLAuwqY+wl7BCIzkRb+pn7a5via1Au/+M49R82+6XovMChcBox2mlP3fbWf50Vhnz9V8GGS5bavxR3Uu9jqzkaHsJzmVa7iecqEPZ2tozqhqH3svCkwf6yt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0Zqoqk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0Zqoqk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764768840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v5HapGAETBejFtPtETjP5Yr93HQBxIGVef1x+VaGO9I=;
	b=i0Zqoqk1Lj9E6ngpDrUelEeUpXCT00NHpqO6+v0qweiTRBkBFNsC+Q5u/iJkypK+cnB/gV
	y2dzFFulWkBuGvEGsipZxVRsEuC1dD6a75ytVEhSGIDbJXReVrniOeBX5qMYogrLQVETtc
	mpEA/h7ImW4hGLP1G6XpIsGBvdPspy4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-iasbHpLAOAea1FW3tBUPqw-1; Wed, 03 Dec 2025 08:33:59 -0500
X-MC-Unique: iasbHpLAOAea1FW3tBUPqw-1
X-Mimecast-MFC-AGG-ID: iasbHpLAOAea1FW3tBUPqw_1764768838
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72a95dc6d9so326308766b.0
        for <virtualization@lists.linux.dev>; Wed, 03 Dec 2025 05:33:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764768838; x=1765373638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5HapGAETBejFtPtETjP5Yr93HQBxIGVef1x+VaGO9I=;
        b=cxwr52RvQKzCvlxDwFCAE6eyh7IYbjROBflrxbzPZRBEDcShmBwHsvmi5pxct8UBPL
         LKEs9U11faGvl7LzXj5j9xT2WybExbLGtMXJET+BFyDI6NrtMVNm+xt1eRcuTG6kMkDN
         qJG3vf8gyCpgplWKY6l3NgHmxcmA5Akqoufs4UJbjaZjQpIUC04JXfF8QqP0wPHK6VfO
         EcNmFBZY/vcYyV4uUyg44Wf4jeEiKu28NQBk6aRtK3qc6MpUiLKvW8OIYe13RMbb+v8Z
         ha9SR2XrLgtu401EAG69jahTZA8blc25bVTZguIBXUupB/YVc+WDIoywCjekm387xcxk
         hYUw==
X-Forwarded-Encrypted: i=1; AJvYcCXEkW7TUWVe+JryIDqHdRsIAYxHDnmE3R1UG1aq6bE6NkcS2lpwal0t27tQxiXQhnogrNZtKtaqU/Y98cYg5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw15sqL4tcDw/mgbbegMqfaiiE50EDN64VjybTxZ7apeUDmMKSu
	qaFdn1tm7MV9wYBDHbe5gtD9dzXpAx85qCfHkPZbDGlWXgWyogcRTgatgWcnlfc+Vk/Ob9KUOJ0
	XV4/DqlUWwH77e4apWoeo8oDn7e2CRH9qPUgwB1zhsF3W6thmcnnztzH1tKz/8yMTn+7F
X-Gm-Gg: ASbGncu7D9FCaQ0zXNDC63/mUxtgXaNwy2ASFIynQUPCuHtc2y+wDf+kCvqti48Swvv
	Nn0rYS56Tm/tePiGzc2NMOYpNYVuF/L1PJdQeLGcYrmCCFSUkYcvuVNZ7kRaTAZ52tPFtwNtaHv
	7+wOye8RvPUZu6g90adxRcUag/oh9jpLJT73cNDXMK+dJTtp+sbzMoz5tC8Llijl09wXCqejRmS
	OCFQDNU4l4Bfkh9m//oIlm9ukZgEnZXvgNVC6RK4B/DmlHK7HKAvkdFGtjrxoyvs++fQDkPP5bR
	dk1MjsU/DWiXbDxbX9jWnUh4hbgIQFfe9L+BoE830kL+at+K8b3/KV6RWuOw4ZKWZjmaPMONgug
	=
X-Received: by 2002:a17:907:3f9b:b0:b72:a899:169f with SMTP id a640c23a62f3a-b79dbe487cfmr252935866b.4.1764768838223;
        Wed, 03 Dec 2025 05:33:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRkbakFynEx+xbWrRzIqBtwAstWd7O3+OSlCU8/PG1Zhj8xJARmcIDiai4geXLID71H0TAfQ==
X-Received: by 2002:a17:907:3f9b:b0:b72:a899:169f with SMTP id a640c23a62f3a-b79dbe487cfmr252931666b.4.1764768837661;
        Wed, 03 Dec 2025 05:33:57 -0800 (PST)
Received: from redhat.com ([31.187.78.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f4d533f2sm1797209166b.0.2025.12.03.05.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 05:33:57 -0800 (PST)
Date: Wed, 3 Dec 2025 08:33:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
	jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251203083305-mutt-send-email-mst@kernel.org>
References: <20251126193539.7791-1-danielj@nvidia.com>
 <20251126193539.7791-12-danielj@nvidia.com>
 <aS8L--z0ezhkywT_@horms.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aS8L--z0ezhkywT_@horms.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OWl5tgsFmJw-cSPqWmjOq-MAeol6MrcnPg7lhwHj0jo_1764768838
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
> On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> 
> ...
> 
> > @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >  		mask->tos = l3_mask->tos;
> >  		key->tos = l3_val->tos;
> >  	}
> > +
> > +	if (l3_mask->proto) {
> > +		mask->protocol = l3_mask->proto;
> > +		key->protocol = l3_val->proto;
> > +	}
> >  }
> 
> Hi Daniel,
> 
> Claude Code with review-prompts flags an issue here,
> which I can't convince myself is not the case.
> 
> If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> as does this function, then all is well.
> 
> However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> flows, in which case accessing .proto will overrun the mask and key which
> are actually struct ethtool_tcpip4_spec.
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10


Oh I didn't know about this one. Is there any data on how does it work?
Which model/prompt/etc?


> >  
> >  static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> > @@ -6022,16 +6107,35 @@ static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> >  		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> >  		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> >  	}
> > +
> > +	if (l3_mask->l4_proto) {
> > +		mask->nexthdr = l3_mask->l4_proto;
> > +		key->nexthdr = l3_val->l4_proto;
> > +	}
> 
> Likewise here.
> 
> >  }
> 
> ...


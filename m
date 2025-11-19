Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94F31ED99
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763536027; cv=none; b=pT9zm+77KdTEv7iWURGCyzHvn5z8zbO9x8c3o0FYMHH2z+XCgo2htXYcQ5jmPneoXchsg/nsWDuCk+cGAMdEgi6MWzuxXF4J4v3PGnTE9sqUt86UWxi3/EhbX0BoSJm29//GGsq1SaX0PGd7/ab70DYIKwO44z1ijh2PMJ781Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763536027; c=relaxed/simple;
	bh=qC5kJxM9wR/6LND7jvsyFwaiNM4eVfH035BJk7NQwJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jtqlMYsL7YK0IeyrM1mLESPC1B+UP32RpQL2uTGtjSYMViIitUG8ID1KNYxfmQVbrgMQW/ICDG0TgGlSaitAUPVIORRI/LPHS4+rFkFQEg2xhgV+cEwL4QVPabARbppADmoIHHsPej4Bjlf1M5/hnhuD4b0YGflre9jWJ6d6dqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nnz+FPg1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nnz+FPg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763536023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJGx7+wTnT+9NZOuM1iW51UnHTE1oWUSxxWBxIO6mxU=;
	b=Nnz+FPg1jOBFIRcfVELAsgKIZgw//EZ3AjtUftz53sG3d84X8DROfA92jQTNZuyQBw9Otc
	FsXsT+2uZSSA9sSQ0cJ52HEL6sWX/uUDtTOBJaQTlV2l33lzDU45xK+SAImsdEPcqufSBH
	rPDC2ntqVAqMFmFK5tN3Ot7RxlhvgJM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-5H2Yh-_2P7epUCP1axjVIQ-1; Wed, 19 Nov 2025 02:06:40 -0500
X-MC-Unique: 5H2Yh-_2P7epUCP1axjVIQ-1
X-Mimecast-MFC-AGG-ID: 5H2Yh-_2P7epUCP1axjVIQ_1763535999
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3339cab7so4739920f8f.0
        for <virtualization@lists.linux.dev>; Tue, 18 Nov 2025 23:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535999; x=1764140799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJGx7+wTnT+9NZOuM1iW51UnHTE1oWUSxxWBxIO6mxU=;
        b=gzOJF8MlDgdCC1uIVurk1xcuZNjxpqup6BihqoQQWNdbeomqemaOG9LQG1XbXXfY8m
         QBXv/j+YgR0a6KO5PSzy/ChmbwtxPqmXD1Jz6x8C1QJP9a4svMchAA1dbgQXZMGlNIpt
         IDV4I1ux45QR0TmyDRjXTcXdPiqEmBGPKOgOa54/aL4LNY9bSNzbOa7UIU/HWjo8kza8
         1/SLgLW/VWN9wSFg/Iq+Twp/vDO8sSNpUUXxxPwvMOQqmbK/31qkeClXR+g28N2+h4W7
         AHNG20yrNByU5fxDI/unP2dRFHBcTKPXm3jPjMAa/3uNDhct7/1rLbddsuImM/DeHgTE
         u9+g==
X-Forwarded-Encrypted: i=1; AJvYcCXBOzREEUTN0g3QJxqvBM3fFSb1n8p0ghyVWcJra2kINV6d4+a4gcnW39nvGi09ML+5AA6HvJ4zMURwJhTEfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc9SZpETT5iQ6FvUVWdGnmfrfDOb2Zz20q6EZwn1bZKZyOlyIY
	Pn5GYyTNUNQKE+ybXZdF8MmTnFWzKN29TYxmfFERsCOmmFviMjbZirSgIPOXB6oNArWD461ZP/H
	FSIPFNrwV+V6cFMokHFDQ5JvfCTlSISlzpvhJibaY658ZGSKAxSWybjxh9IqS2+Vkm0/H
X-Gm-Gg: ASbGnctUdilWnvDbVucmVpRuZILBMrhQgPHOj6xRX6zJ2dyH93j7K2iUIaDKxJklFVr
	vOut1hjd11kHoZC9aih1MrGJjU8oHmw8VVoQReRqcKtsfwCnJun/kFaduH5v/DmlNups/3K0Kn6
	k+K7hrfvXUTU4rYu33xPasiht+Q6xXIlF57Xzss9OiqwSfHOYFhGD2dOC1ysJ+NZbU1ZuOE66uo
	1iweNWcnuECtuA7/T2eERZpZoDQgI0WFDRdhRG56ROOZtGd2+4517RGxb6bOXrNhOHC97pW9CJS
	LStNX4+Yl+GFaqlfah/wjHjFLloIWO9x12jxQdfn9OkHK8mbOiNQqE8jbHrGH+/NHAyEI8ltECU
	DyJW9qHVzQBbq7m5JoTQCTiABEyUJjw==
X-Received: by 2002:a05:6000:4210:b0:425:73c9:7159 with SMTP id ffacd0b85a97d-42b59381bf0mr17637646f8f.33.1763535998917;
        Tue, 18 Nov 2025 23:06:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRUIIc6RK9F4rAyngAl3z3aoaf8Mdkc38zKW0SHUpdZcH4dc5Sfm+4K04fSD8lBSrGft/7xw==
X-Received: by 2002:a05:6000:4210:b0:425:73c9:7159 with SMTP id ffacd0b85a97d-42b59381bf0mr17637595f8f.33.1763535998357;
        Tue, 18 Nov 2025 23:06:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae16sm36662236f8f.3.2025.11.18.23.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:06:37 -0800 (PST)
Date: Wed, 19 Nov 2025 02:06:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 09/12] virtio_net: Implement IPv4 ethtool
 flow rules
Message-ID: <20251119020521-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-10-danielj@nvidia.com>
 <20251118161734-mutt-send-email-mst@kernel.org>
 <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d2b57943-0991-4823-9997-2bd6044c7abc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ypa4wc3kUwDMskF_QLWsm7rt94ypK-GC02SxAm0JpVI_1763535999
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:03:36AM -0600, Dan Jurgens wrote:
> On 11/18/25 3:31 PM, Michael S. Tsirkin wrote:
> > On Tue, Nov 18, 2025 at 08:38:59AM -0600, Daniel Jurgens wrote:
> >> Add support for IP_USER type rules from ethtool.
> >>
> >> +static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >> +		      const struct ethtool_rx_flow_spec *fs)
> >> +{
> >> +	const struct ethtool_usrip4_spec *l3_mask = &fs->m_u.usr_ip4_spec;
> >> +	const struct ethtool_usrip4_spec *l3_val  = &fs->h_u.usr_ip4_spec;
> >> +
> >> +	mask->saddr = l3_mask->ip4src;
> >> +	mask->daddr = l3_mask->ip4dst;
> >> +	key->saddr = l3_val->ip4src;
> >> +	key->daddr = l3_val->ip4dst;
> >> +
> >> +	if (l3_mask->proto) {
> > 
> > you seem to check mask for proto here but the ethtool_usrip4_spec doc
> > seems to say the mask for proto must be 0. 
> > 
> > 
> > what gives?
> > 
> 
> Then for user_ip flows ethtool should provide 0 as the mask, and based
> on your comment below I'm verifying that.

but if it does then how did this patch work in your testing?

> I can move this hunk to the TCP/UDP patch if you prefer.


not sure what you mean so I can't comment on that.
generally it's best to add code in the same patch where
it's used - easier to review.

-- 
MST


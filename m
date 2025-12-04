Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7561990A7
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764832598; cv=none; b=sV/fAWuhcmsHiojCJVktP2OVXwjVEpLIqyomGv36+8ER8gXMYOHGVTXtxz+S3WHonnhsUZU3sCPLmPp3ONVc12HApbj3pn3BlIFOGNWjL2igP7ciSph43DqaXXHmiTK+NGCejgf6Zb2tqmti5/gXflp8uOpBzGYQX9nou76BY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764832598; c=relaxed/simple;
	bh=CLc6rRrt5rpx3bjRc4ujzBdnkytoR5fSzVNCRnnUBQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zu6pRzna9jtF1vJB0o+lJ5NefrLlb6VgLV5ldv7heSUukyfiFjBuoF+XgoK5w7t30r2866j/M/7/7fxteDTq5vF4G6mmHjw7FqQNjxjJ/ni2W0y1XjtkHpeHs2Ifdxg6YapOWAyIS0AK97/IvLbElAk6aUDEQLyhUbbJnrwJ2YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASXnd7WE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASXnd7WE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764832595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3qXdsgNNXtCkS4bI00gjPKx1mZmExrwrEj4Ky8EfxE=;
	b=ASXnd7WEW786rQ0QU+WhoQ+jy41zWobDDEBN/NQrY1J2YjAXopz8ti9ZKdDwpSNdyERMYy
	OROQwJNksuiVgO0HNwwfVx4b3bnGpQ/Lu1jb85yqoFoP5riUJMAnRewA4ta20TG5s0m/HD
	DP6bNqG421n2UI5bH3fyh1ehabYDTJI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-mDwSs7DINMGVNy-wruuqBw-1; Thu, 04 Dec 2025 02:16:33 -0500
X-MC-Unique: mDwSs7DINMGVNy-wruuqBw-1
X-Mimecast-MFC-AGG-ID: mDwSs7DINMGVNy-wruuqBw_1764832592
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e2e447e86so295829f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Dec 2025 23:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764832592; x=1765437392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3qXdsgNNXtCkS4bI00gjPKx1mZmExrwrEj4Ky8EfxE=;
        b=crOnoJ/LTtqTQimm1exv6G/bwv9VbcVABtqIGL28ZmLx6LujhPq4NUIax0mgcR21Lz
         i5cK64CaF8YQkYSyP4jRCKDK4QJ20U40XtvdyIqY7rWnrJbDumI32I1Oc3DLAajkISW1
         14K1IabzPpeyNGgrp1H+Pl+FvUksna3VW9/KuXnoSo+hqUQPNyc581M8rYKG8d4wi91Y
         DClhFA59VEeSPjqpwRAO0zSpiX5ra5cVzxXa0qm+dxt2V74b0f1fHRd5tMppUNMvlUDv
         y+14ai1OBgubHjJO8ZiaH27SdhYrctx8gQs8QN8miGj5zzpWSqjK7ML2nwZ61pYU4OvD
         1Eng==
X-Forwarded-Encrypted: i=1; AJvYcCX1PbMmtG9NrrWHJnth5BpAY3lZSoW7lHCQhr79wNow2OmXWdKLMZO64BtWCBT/YwnVGezx91awk60/gAwMqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNxv8k5BVaXyh8c+XgVCQ1sNDMD88IHYr6xNU6oC1ZAGsLF63J
	un29lCLCWTwV6+0g/bx5XG1Pc83Be/EnJeUdPmCLD6o2zDyTNe6EDyman22EXDg8yS3S3VHzI0B
	CT+9dkKRk1LXKHnEhsu4hzXGeGg8qgQhrxh02sq09ZovL3+lfwmQsJeWFwonRiWZq+FTb
X-Gm-Gg: ASbGnctoKYMFKJBQX1Q/Zcs6oGEa2w8cL9QYj0TooyGs9rhz5hy9aD472yIE7q+hgJf
	NjXsz/ebq/crKHcWh6ydTPD7sKM8WdBXjgHcZEcirfA95skq+UjuD/iQgzhJp2Ivy6BZbGfTHVd
	UF+DRrYH5xyWCwf5dNkUnBiCPJiB1O9ij38ZkC3EuTrLuSWTSkDXWEAEa7qzaUl4CFkOsNJKFDH
	F+pc3UP6lSttgsS/w83ZmJLnYMaqwRHUtx349dBbfTlyEjh9HjgU33zpbzqfsI2k7wzB1WFU7Av
	CAICd8Ip1WItBRF3CJ8bQv5fgqBQcxz/5WWpjnU5oV0efEi+gdRiygDU70iEMGO41Y/4Fju10D7
	tY4GH7X6bN8HYnCv1Zdl/Oms/q3RjMVThfA==
X-Received: by 2002:a05:6000:1845:b0:42b:3455:e490 with SMTP id ffacd0b85a97d-42f73178df8mr4931948f8f.14.1764832592284;
        Wed, 03 Dec 2025 23:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFO8y+eQr/B4UQTRlReyGmp60+FiL6uBEAkHCWcMo7Pe6ShugffTLjbf4mgxbHGRS9v9LpugQ==
X-Received: by 2002:a05:6000:1845:b0:42b:3455:e490 with SMTP id ffacd0b85a97d-42f73178df8mr4931913f8f.14.1764832591837;
        Wed, 03 Dec 2025 23:16:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222491sm1468677f8f.22.2025.12.03.23.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 23:16:31 -0800 (PST)
Date: Thu, 4 Dec 2025 02:16:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chris Mason <clm@meta.com>
Cc: Simon Horman <horms@kernel.org>, Daniel Jurgens <danielj@nvidia.com>,
	netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v13 11/12] virtio_net: Add support for TCP and
 UDP ethtool rules
Message-ID: <20251204021540-mutt-send-email-mst@kernel.org>
References: <20251203083305-mutt-send-email-mst@kernel.org>
 <20251203160252.516141-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251203160252.516141-1-clm@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xZp0cHTJnEHNw2u3aWMd3UEjVeA-PcF_1uT0lmhYbRs_1764832592
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2025 at 08:02:48AM -0800, Chris Mason wrote:
> On Wed, 3 Dec 2025 08:33:53 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Dec 02, 2025 at 03:55:39PM +0000, Simon Horman wrote:
> > > On Wed, Nov 26, 2025 at 01:35:38PM -0600, Daniel Jurgens wrote:
> > > 
> > > ...
> > > 
> > > > @@ -6005,6 +6085,11 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> > > >  		mask->tos = l3_mask->tos;
> > > >  		key->tos = l3_val->tos;
> > > >  	}
> > > > +
> > > > +	if (l3_mask->proto) {
> > > > +		mask->protocol = l3_mask->proto;
> > > > +		key->protocol = l3_val->proto;
> > > > +	}
> > > >  }
> > > 
> > > Hi Daniel,
> > > 
> > > Claude Code with review-prompts flags an issue here,
> > > which I can't convince myself is not the case.
> > > 
> > > If parse_ip4() is called for a IP_USER_FLOW, which use ethtool_usrip4_spec,
> > > as does this function, then all is well.
> > > 
> > > However, it seems that it may also be called for TCP_V4_FLOW and UDP_V4_FLOW
> > > flows, in which case accessing .proto will overrun the mask and key which
> > > are actually struct ethtool_tcpip4_spec.
> > > 
> > > https://netdev-ai.bots.linux.dev/ai-review.html?id=51d97b85-5ca3-4cb8-a96a-0d6eab5e7196#patch-10
> > 
> > 
> > Oh I didn't know about this one. Is there any data on how does it work?
> > Which model/prompt/etc?
> 
> I'm not actually sure if the netdev usage is written up somewhere?
> 
> The automation is running claude, but (hopefully) there's nothing specific to
> claude in the prompts, it's just what I've been developing against.
> 
> The prompts are:
> 
> https://github.com/masoncl/review-prompts
> 
> Jakub also wired up semcode indexing, which isn't required but does
> make it easier for claude to find code:
> 
> https://github.com/facebookexperimental/semcode
> 
> I'm still working on docs and easy setup for semcode and the review prompts,
> but please feel free to send questions.
> 
> -chris

Thanks, interesting! And the bot at https://netdev-ai.bots.linux.dev -
what does it review?  how do I find it's review of specific patches?


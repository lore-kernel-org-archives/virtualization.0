Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF212FB3E
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714578514; cv=none; b=USEQ5VLX+2gL23H5AaREER+08DA6/oxzbcu5MQ2FdMpyiCy1uPFwtuRtIja30nxEQKgJ015x5Y6fh+G6gJ+6eADC9mc3bDD5WWiP2/M+E3xG4xJURtdez6pM8LU6bhM96bLAL4hT1H3rDfZ1uJ4L70e76FH/9T0VSPE58LyNHks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714578514; c=relaxed/simple;
	bh=ep9gRD8mGOXCtjRdooKCCClREdkKGq/7TcmThE40S2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=L6wv1Reqp7lZZztbQf0Zd3LThE4za1LnmmnRuaR8BqTkBFSXwsjuOGZwlLxijHyJsKOMZLtiPEssnV0uwLT5xWJ3mHX4AJhNpfJtu5TLmvwAu9iEJbsiCie2Aa2HUa8CGdPZVugEuian84CnrO6jJGILSvZdIR+U2YWZZYp1TFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ii/rOyYx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ii/rOyYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714578512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9vXPnuPC4TTKf1aPUT/9gMUEiWKzRf5rqJKHhBZKq84=;
	b=ii/rOyYx/PXPv/8uFsVS8N4KfOoBSyJQD+1xY6oywdabS/RBrh9ngROXqEjLzd41bovZfc
	7DvOGjJAY86ZqTo8QYygpgZnkdlLS4mzZLs/Ym/+KEXwa1sZCwQ2ydq49ttS5UZG2RSTi6
	9+k8lK4M4kUG/nk8jPMnTcFZQVPNOhA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-jY2yMj5bNXm6rp3rDgPCPA-1; Wed, 01 May 2024 11:48:31 -0400
X-MC-Unique: jY2yMj5bNXm6rp3rDgPCPA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a58f874ca11so243681066b.1
        for <virtualization@lists.linux.dev>; Wed, 01 May 2024 08:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714578510; x=1715183310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vXPnuPC4TTKf1aPUT/9gMUEiWKzRf5rqJKHhBZKq84=;
        b=NTvrh+av3BrtgfEfvcqYBInYWun0wDquqvxTeaNLeqjC+j+TPX8zR4Vzm3LRWs6Vmd
         nIDjWzLuxhpopzMNYvtrcgGphWIAUUtxymYqu5R+GsecX3my+M26lNXZM69OJNedIiFe
         m+eKexJaem4MDsaMTVeP23iWWnTfaJf79BSwJEDkZlRW2/0/5w0pPczzuEwLiuKNOBKg
         TqI4JaKz2QROW7WIkOX4gzK+x3SnbeAdwuZTN119QkR/x1pCBbtuDFS1KlZN7eVZbSPv
         stgk4TDz8Y9GGo/ppP6dHNKItrRbd9xYxRG83+1l19dyn7FfBMEeg63aGumkPUDRUsFB
         JbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHEq1vrtdS3hbsSGjel7RvhJt0LYdWxPuVQJENOgzzGnVBvDhJ42FzO8VkBbamKYmZlzBD6NKrOCe6/oMFx1xT2IyWShSpSskzFs7zx50=
X-Gm-Message-State: AOJu0Yw/UL/3xJIAXnsWLErEJvKwHHybySJZTcaCdeV1eqTNzEBXjnE5
	n4usTeJDO5BEo4JoTy8l36cT5kYBFmppOibGDZi5yjiftOq/wXksgnj4+ezm9hzM+N+GvOsX/OH
	Y1H3v1/HMVhxVXskDtRal9mMo02zXmwnbKa9icfT4U9grWPTu1J6RO0st2uCvxosd
X-Received: by 2002:a17:906:5d2:b0:a58:e4dc:ad99 with SMTP id t18-20020a17090605d200b00a58e4dcad99mr1916533ejt.2.1714578509559;
        Wed, 01 May 2024 08:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPkX5jNP9njQFhCTsNr5Jxg9lBydsGfLtvu6aP6rVyCQCFHRXL0OAvf21MC7R4anBI/wEV3Q==
X-Received: by 2002:a17:906:5d2:b0:a58:e4dc:ad99 with SMTP id t18-20020a17090605d200b00a58e4dcad99mr1916493ejt.2.1714578508989;
        Wed, 01 May 2024 08:48:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906090900b00a55b05c4598sm12447242ejd.133.2024.05.01.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:48:28 -0700 (PDT)
Date: Wed, 1 May 2024 11:48:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Wang <jasowang@redhat.com>, Brett Creeley <bcreeley@amd.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Tal Gilboa <talgi@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, justinstitt@google.com,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile
 management
Message-ID: <20240501114754-mutt-send-email-mst@kernel.org>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <202405011004.Rkw6IrSl-lkp@intel.com>
 <1714538736.2472136-1-hengqi@linux.alibaba.com>
 <20240501074420.1b5e5e69@kernel.org>
 <1714576307.2126026-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1714576307.2126026-2-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2024 at 11:11:47PM +0800, Heng Qi wrote:
> On Wed, 1 May 2024 07:44:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 1 May 2024 12:45:36 +0800 Heng Qi wrote:
> > > >    net/ethtool/coalesce.c: At top level:  
> > >  [...]  
> > > >      446 | static int ethnl_update_profile(struct net_device *dev,
> > > >          |            ^~~~~~~~~~~~~~~~~~~~  
> > >  [...]  
> > > >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> > > >          |            ^~~~~~~~~~~~~~~~~~~~
> > > >   
> > > 
> > > This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> > > mentioned in v10. Since the calls of ethnl_update_profile() and
> > > coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> > > true, the robot's warning can be ignored the code is safe.
> > > 
> > > All NIPA test cases running on my local pass successfully on V11.
> > > 
> > > Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> > > up to Kuba (and others). :)
> > 
> > You should remove the ifdef around the member in struct net_device.
> > It's too much code complication to save one pointer in the struct.
> 
> Makes sense.
> 
> Thanks.

if you really want to you can add a comment
 /* only used if IS_ENABLED(CONFIG_DIMLIB) */


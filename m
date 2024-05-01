Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA143130ADA;
	Wed,  1 May 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576416; cv=none; b=L9Fwo9VXRFFFbsbiBY3qj/MrAo93hR9CSI4Pxi/wzBubPXs5eIC70ZDaMlBpO5ols11VyJAlBJNbP+VyzWSd80wPyddWP8EdrsB04Gz7clgnP5A3XFq3WAP14fwkj88wAg5dyFAMGgyLcMoA39c3xKjcHqHFDKqfUGhomPaN21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576416; c=relaxed/simple;
	bh=IhW6CILoVD5OQfZzI5w7otUMItBVOSdHMl/84FmuSy4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EGPA+KDQjT/TZ+eE6pF8DnwjjLZIhccDIvonxxz1uHK4EYAAU+HJHVzTYmHHl3XeHPPp8Z485MsMawhS/nX3cCMC2foWa5zeAGL4y6E+i+p93naWOEMjTShHBH/Fd62MPCW7Rd71sOo0HRI0dX925jT/nsxtJOX0C2fC7vOLxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xft31i/q; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xft31i/q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714576406; h=Message-ID:Subject:Date:From:To;
	bh=lBclA3zJaNSyXNr4Q/nKzIomxbyIyt9xMFyfv7GftGc=;
	b=Xft31i/qZ1UkB81L9bdxyckTgpcZZHAB6zDnCvJvNzdLr5F+ncuJeF7Re1ijKI/Tej6JhbmUO7Sc7R+7rEMDhxUR8lRwslJTrY87zOLkEBLRVRG95Az+bTJ3B47Mil2x9ISCLCNZ10EFoCxr8w7NAZZu1/z52tuzjP2AXehXH2c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W5f1kY1_1714576404;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W5f1kY1_1714576404)
          by smtp.aliyun-inc.com;
          Wed, 01 May 2024 23:13:25 +0800
Message-ID: <1714576307.2126026-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
Date: Wed, 1 May 2024 23:11:47 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev,
 "David  S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric  Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S  . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh  Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal  Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul  Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <202405011004.Rkw6IrSl-lkp@intel.com>
 <1714538736.2472136-1-hengqi@linux.alibaba.com>
 <20240501074420.1b5e5e69@kernel.org>
In-Reply-To: <20240501074420.1b5e5e69@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 1 May 2024 07:44:20 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 1 May 2024 12:45:36 +0800 Heng Qi wrote:
> > >    net/ethtool/coalesce.c: At top level:  
> >  [...]  
> > >      446 | static int ethnl_update_profile(struct net_device *dev,
> > >          |            ^~~~~~~~~~~~~~~~~~~~  
> >  [...]  
> > >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> > >          |            ^~~~~~~~~~~~~~~~~~~~
> > >   
> > 
> > This is a known minor issue, to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> > mentioned in v10. Since the calls of ethnl_update_profile() and
> > coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> > true, the robot's warning can be ignored the code is safe.
> > 
> > All NIPA test cases running on my local pass successfully on V11.
> > 
> > Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> > up to Kuba (and others). :)
> 
> You should remove the ifdef around the member in struct net_device.
> It's too much code complication to save one pointer in the struct.

Makes sense.

Thanks.

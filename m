Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4710C4AEC6
	for <virtualization@lists.linux.dev>; Wed,  1 May 2024 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542961; cv=none; b=Me77t3/iBWA+kIndq7rLJUUmI2PydNr4yM+0C7FT3jaTvQdM80ngaOvNaXiIUDCg1Ft3LszjZYYPk2gmU97j3w7AnvDgrfQNHd284x5sBsOQq5djI4KQWiQXAzYaP16sqZxEGCRZTT9aKeVYPl2j6kvKLihCmUWgnWuh5Wgq5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542961; c=relaxed/simple;
	bh=aadMEr8ariBi8eE4O8hPmKJnX3oge4KGG35B7N3ApoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uzezMla4ETP5uneoFMfv1YZha2deW8H8VpWtaaPz4vNpntY/L5uhblXnaZdSURDmjjoDHlvDe1PGD6NjoP+BSe+Ew77rR28wI6ZgwWQCBZT8r8X8v7kALvZKlNAKm1hZj5M7IV2nn41mDSZb45MoDJtygQYia8UYOlWoZRYmf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BmgMcEwZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmgMcEwZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714542959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcKow0zmruCffk3bO4H/bFhUq98xWg7lQzKYw8TpCpk=;
	b=BmgMcEwZwTfIxPGkX7vuPuC9qe7Bx1lInvNsBx9IfDuNwKCvib0MCw42Phhp4r1yyDBMlQ
	4fGGSiKfWxeIZoD6ngN8YlZRAAsM3HVWrM2l4IpyuF87hOL7RcYcVLQMJoZYKbRrLO3DqV
	YAJcEMMbPdBHHahV/6VxvyWuMRhokMI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-lNg3frEPPlarGcV-Vz-9jA-1; Wed, 01 May 2024 01:55:57 -0400
X-MC-Unique: lNg3frEPPlarGcV-Vz-9jA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a55709e5254so316637866b.3
        for <virtualization@lists.linux.dev>; Tue, 30 Apr 2024 22:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714542956; x=1715147756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcKow0zmruCffk3bO4H/bFhUq98xWg7lQzKYw8TpCpk=;
        b=VIpkQsLFgARwyTg3AtZIHAObi/5mcSJx/wnZThNHh8IhzHK0J3BIaxB2cODBk2mIIm
         HqOR5HlTJgwgvkV8aum03aAlGBDk1nBUFytTYzKGidieI1/uFw6yFr10gnipzdmSY4hr
         F39Sk8PBEKOJ1x79YgUB7wulx6FMq5wTho7Lm7aBhpC+ZxPkqe4JwTmtfWXDpabQMMYu
         X/AicTfUBFF5jNf7DgIBI1tKr0ZBXV4V5vC3hwCyxZQLaJa5ipyCqK4d3iDZ3NSv3AIM
         ZyY7DA/eMZQ8BV15Oi/rJ25yB01OqWkjbQHU5Ym7UOqCzwD0p3smvJp3PsZkiCZpG2E5
         F7sg==
X-Forwarded-Encrypted: i=1; AJvYcCVnETP0wMX1TJ1ixWmIbQPLIQHrWORKSwMIlsNIf9pA9MJkIo0+kPyjUL93BnZCHDMDNrrz4jBlcNJP3YQK5irRuzBquXaUo5l5gEYi+Jg=
X-Gm-Message-State: AOJu0Yy5uraz3lAGoBCrOJHX5tE41Jp+qNKgWr3EC6QvGIXnkfMxNCWb
	jNJt0IVWG27kN5ypqDOgCEz0QCnqsTTgcpMdF+aHmj4r+9gKooHkhOlsBfnNMtQ4MmsQx1U0AMO
	a1pd/H55zQwSAVA7ZgZBJ5FnkiFfrl/ZXXIjS0t6+tSFn+bnWp4aqRS6DoTcq0oAo
X-Received: by 2002:a17:906:e4d:b0:a55:9a35:5e9d with SMTP id q13-20020a1709060e4d00b00a559a355e9dmr977262eji.42.1714542956237;
        Tue, 30 Apr 2024 22:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC1QkCHaw0iBBvM1x7ORwvPKI+KKZASL1NToTNqfz++XpK/I5PdrIKLQ0RzET8wTmc4DTiIQ==
X-Received: by 2002:a17:906:e4d:b0:a55:9a35:5e9d with SMTP id q13-20020a1709060e4d00b00a559a355e9dmr977237eji.42.1714542955599;
        Tue, 30 Apr 2024 22:55:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a58864c88aesm9121150ejb.225.2024.04.30.22.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:55:54 -0700 (PDT)
Date: Wed, 1 May 2024 01:55:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <20240501015303-mutt-send-email-mst@kernel.org>
References: <20240430173136.15807-1-hengqi@linux.alibaba.com>
 <20240430173136.15807-3-hengqi@linux.alibaba.com>
 <202405011004.Rkw6IrSl-lkp@intel.com>
 <1714538736.2472136-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1714538736.2472136-1-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 01, 2024 at 12:45:36PM +0800, Heng Qi wrote:
> On Wed, 1 May 2024 10:36:03 +0800, kernel test robot <lkp@intel.com> wrote:
> > Hi Heng,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on net-next/main]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Heng-Qi/linux-dim-move-useful-macros-to-h-file/20240501-013413
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20240430173136.15807-3-hengqi%40linux.alibaba.com
> > patch subject: [PATCH net-next v11 2/4] ethtool: provide customized dim profile management
> > config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240501/202405011004.Rkw6IrSl-lkp@intel.com/config)
> > compiler: or1k-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405011004.Rkw6IrSl-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405011004.Rkw6IrSl-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    net/ethtool/coalesce.c: In function 'ethnl_update_profile':
> >    net/ethtool/coalesce.c:453:46: error: 'struct net_device' has no member named 'irq_moder'
> >      453 |         struct dim_irq_moder *irq_moder = dev->irq_moder;
> >          |                                              ^~
> >    net/ethtool/coalesce.c: At top level:
> > >> net/ethtool/coalesce.c:446:12: warning: 'ethnl_update_profile' defined but not used [-Wunused-function]
> >      446 | static int ethnl_update_profile(struct net_device *dev,
> >          |            ^~~~~~~~~~~~~~~~~~~~
> > >> net/ethtool/coalesce.c:151:12: warning: 'coalesce_put_profile' defined but not used [-Wunused-function]
> >      151 | static int coalesce_put_profile(struct sk_buff *skb, u16 attr_type,
> >          |            ^~~~~~~~~~~~~~~~~~~~
> > 
> 
> This is a known minor issue,
> to reduce the use of 'IS_ENABLED(CONFIG_DIMLIB)'
> mentioned in v10. Since the calls of ethnl_update_profile() and
> coalesce_put_profile() will only occur when IS_ENABLED(CONFIG_DIMLIB) returns
> true, the robot's warning can be ignored the code is safe.

I don't get it. The build seems to fail. How is this a minor issue?


> All NIPA test cases running on my local pass successfully on V11.
> 
> Alternatively, I remake the series to have IS_ENABLED(CONFIG_DIMLIB) back,
> up to Kuba (and others). :)
> 
> Thanks.
> 
> > 
> > vim +/ethnl_update_profile +446 net/ethtool/coalesce.c
> > 
> >    424	
> >    425	/**
> >    426	 * ethnl_update_profile - get a profile nest with child nests from userspace.
> >    427	 * @dev: netdevice to update the profile
> >    428	 * @dst: profile get from the driver and modified by ethnl_update_profile.
> >    429	 * @nests: nest attr ETHTOOL_A_COALESCE_*X_PROFILE to set profile.
> >    430	 * @extack: Netlink extended ack
> >    431	 *
> >    432	 * Layout of nests:
> >    433	 *   Nested ETHTOOL_A_COALESCE_*X_PROFILE attr
> >    434	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
> >    435	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
> >    436	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
> >    437	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
> >    438	 *     ...
> >    439	 *     Nested ETHTOOL_A_PROFILE_IRQ_MODERATION attr
> >    440	 *       ETHTOOL_A_IRQ_MODERATION_USEC attr
> >    441	 *       ETHTOOL_A_IRQ_MODERATION_PKTS attr
> >    442	 *       ETHTOOL_A_IRQ_MODERATION_COMPS attr
> >    443	 *
> >    444	 * Return: 0 on success or a negative error code.
> >    445	 */
> >  > 446	static int ethnl_update_profile(struct net_device *dev,
> >    447					struct dim_cq_moder __rcu **dst,
> >    448					const struct nlattr *nests,
> >    449					struct netlink_ext_ack *extack)
> >    450	{
> >    451		int len_irq_moder = ARRAY_SIZE(coalesce_irq_moderation_policy);
> >    452		struct nlattr *tb[ARRAY_SIZE(coalesce_irq_moderation_policy)];
> >  > 453		struct dim_irq_moder *irq_moder = dev->irq_moder;
> >    454		struct dim_cq_moder *new_profile, *old_profile;
> >    455		int ret, rem, i = 0, len;
> >    456		struct nlattr *nest;
> >    457	
> >    458		if (!nests)
> >    459			return 0;
> >    460	
> >    461		if (!*dst)
> >    462			return -EOPNOTSUPP;
> >    463	
> >    464		old_profile = rtnl_dereference(*dst);
> >    465		len = NET_DIM_PARAMS_NUM_PROFILES * sizeof(*old_profile);
> >    466		new_profile = kmemdup(old_profile, len, GFP_KERNEL);
> >    467		if (!new_profile)
> >    468			return -ENOMEM;
> >    469	
> >    470		nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
> >    471					 nests, rem) {
> >    472			ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
> >    473					       coalesce_irq_moderation_policy,
> >    474					       extack);
> >    475			if (ret)
> >    476				goto err_out;
> >    477	
> >    478			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].usec,
> >    479						     ETHTOOL_A_IRQ_MODERATION_USEC,
> >    480						     tb, DIM_COALESCE_USEC,
> >    481						     extack);
> >    482			if (ret)
> >    483				goto err_out;
> >    484	
> >    485			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].pkts,
> >    486						     ETHTOOL_A_IRQ_MODERATION_PKTS,
> >    487						     tb, DIM_COALESCE_PKTS,
> >    488						     extack);
> >    489			if (ret)
> >    490				goto err_out;
> >    491	
> >    492			ret = ethnl_update_irq_moder(irq_moder, &new_profile[i].comps,
> >    493						     ETHTOOL_A_IRQ_MODERATION_COMPS,
> >    494						     tb, DIM_COALESCE_COMPS,
> >    495						     extack);
> >    496			if (ret)
> >    497				goto err_out;
> >    498	
> >    499			i++;
> >    500		}
> >    501	
> >    502		rcu_assign_pointer(*dst, new_profile);
> >    503		kfree_rcu(old_profile, rcu);
> >    504	
> >    505		return 0;
> >    506	
> >    507	err_out:
> >    508		kfree(new_profile);
> >    509		return ret;
> >    510	}
> >    511	
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki


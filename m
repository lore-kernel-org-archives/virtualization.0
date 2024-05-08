Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C16E5FE
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176365; cv=none; b=c90XyqfO+gWHXl8VavqfyilAhnrRIEdRlxAClQsNuC6CFaoQvbNduV6jm87tuXc62RNG9ob7CPDBwyhsKUXkWWfFlAHD3MIj+oNY9SH+cfhsVmDZSdi224l7llZyK18KMYBx9T251mtEHHCbMd9DVc1wAqVT3DkT0M+WGWs1eF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176365; c=relaxed/simple;
	bh=Ml4MH7OyY97yD/03Zsb3r7jzo7NavHhSvPLXa331+VU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=asomwkLg7x3F/rFgT/Y3oBPJGf260Zu8xIfIbVtXaxow6i50IkBCip7NEvRCFfi1JHej99r7wnAXVDACibssWlZucmzJ5A7oMvhcvAi7kFCJagpFu/coBc0sXdBXJh8InnTwzfsQy1Pt58gxRfKng0WpK5YJ3ZHh2+qRiCWvIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fC4YGzbc; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fC4YGzbc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715176361; h=Message-ID:Subject:Date:From:To;
	bh=UoFkCzf53phjWeqxsZI7jlTBll/ysjzs9Qwt22TwZNI=;
	b=fC4YGzbcMygRg8Zg/CFoa26tflu/eEr69koi5FqfMG39a16Zb77O0lhD9SQlFti7+1OZcddMUIb1pJkoyxewG8L0JG7ISawN6ZHCT4taM7OgUo/l/bfPpw60qWLsAVj4g56r/VPYomxNC5pXdTuZNWOBYFTraRYPWD8rV0QJf1Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W63uNyB_1715176358;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W63uNyB_1715176358)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 21:52:39 +0800
Message-ID: <1715174806.2456756-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v12 2/4] ethtool: provide customized dim profile management
Date: Wed, 8 May 2024 21:26:46 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S .  Miller" <davem@davemloft.net>,
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
 Simon Horman <horms@kernel.org>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
 <20240504064447.129622-3-hengqi@linux.alibaba.com>
 <20240507195752.7275cb63@kernel.org>
In-Reply-To: <20240507195752.7275cb63@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 7 May 2024 19:57:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Sat,  4 May 2024 14:44:45 +0800 Heng Qi wrote:
> > @@ -1325,6 +1354,8 @@ operations:
> >              - tx-aggr-max-bytes
> >              - tx-aggr-max-frames
> >              - tx-aggr-time-usecs
> > +            - rx-profile
> > +            - tx-profil
> >        dump: *coalesce-get-op
> >      -
> >        name: coalesce-set
> 
> set probably needs to get the new attributes, too?

I looked at other similar use cases (such as wol, debug) and it doesn't
seem to be needed?

> 
> > +static int ethnl_update_profile(struct net_device *dev,
> > +				struct dim_cq_moder __rcu **dst,
> > +				const struct nlattr *nests,
> > +				struct netlink_ext_ack *extack)
> 
> > +	rcu_assign_pointer(*dst, new_profile);
> > +	kfree_rcu(old_profile, rcu);
> > +
> > +	return 0;
> 
> Don't we need to inform DIM somehow that profile has switched
> and it should restart itself?

When the profile is modified, dim itself is a dynamic adjustment mechanism
and will quickly adjust to the appropriate value according to the new profile.
This is also seen in practice.

Thanks!

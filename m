Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5D31A2C05
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183606; cv=none; b=OVgE+54l73TmDy/zqnwav+asKFDedTPAl7chO2SsPhFlS6B41nEsRjSHROFXnWXjqiaXNGrhRgZykQ+cTyjrlGgzPzx6Ljd5Y81aEhrQecAbVGkLLqI7eAUj5ZqDABbw1cQFS8uQqDhLdhWGaxK50pi96GoysZ9tan5BswrmiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183606; c=relaxed/simple;
	bh=blXBDFniuX+5PbDGWWQnYwb4VIxupmq1l9wrvD6U1+A=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=YEl7l4tL2Cxi8VfHv3J+5248vG/CQGz0IKhqmdNYUU6VQAqiERJU1cQETMFqhvfQbGmNxUlQH7YNn2NIt8KxhROGLSWWppGa+MKviV7nNfoIhaeqRPQPSRvD8fkdGTGQTagudcbZsd+CY8Cn9O2RQ8kAiWRM9AhU24eaigi+5pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OXeIhA6C; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OXeIhA6C"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715183600; h=Message-ID:Subject:Date:From:To;
	bh=4Hv1i7knTXV0jVDzONFoH620SU1ZuBVwrX2QxekucVk=;
	b=OXeIhA6CRMfloJ7ee3ZAAIwchpagyVHpt9l5AUUFih+Q6+4YiXhILnC9iWOUJbxtXj6FZ3GE7HTq31uL05kvSa7cpfQnUtuCvm5VRxjQ7Kz+HIadHSqZjbbHZWSFFa66gN2nqT3HhQI8y/RSakjS26CnFuuKdDI/5oCGACGMbgI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W64-EyS_1715183596;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W64-EyS_1715183596)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 23:53:17 +0800
Message-ID: <1715183551.9560893-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next v12 2/4] ethtool: provide customized dim profile management
Date: Wed, 8 May 2024 23:52:31 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S .   Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric   Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S   . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh   Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal   Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul   Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 Simon Horman <horms@kernel.org>
References: <20240504064447.129622-1-hengqi@linux.alibaba.com>
 <20240504064447.129622-3-hengqi@linux.alibaba.com>
 <20240507195752.7275cb63@kernel.org>
 <1715174806.2456756-1-hengqi@linux.alibaba.com>
 <20240508081139.0a620321@kernel.org>
In-Reply-To: <20240508081139.0a620321@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 8 May 2024 08:11:39 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 8 May 2024 21:26:46 +0800 Heng Qi wrote:
> > On Tue, 7 May 2024 19:57:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Sat,  4 May 2024 14:44:45 +0800 Heng Qi wrote:  
> > > > @@ -1325,6 +1354,8 @@ operations:
> > > >              - tx-aggr-max-bytes
> > > >              - tx-aggr-max-frames
> > > >              - tx-aggr-time-usecs
> > > > +            - rx-profile
> > > > +            - tx-profil
> > > >        dump: *coalesce-get-op
> > > >      -
> > > >        name: coalesce-set  
> > > 
> > > set probably needs to get the new attributes, too?  
> > 
> > I looked at other similar use cases (such as wol, debug) and it doesn't
> > seem to be needed?
> 
> Sorry, you're right, they are propagated using a YAML alias.
> 
> > > > +static int ethnl_update_profile(struct net_device *dev,
> > > > +				struct dim_cq_moder __rcu **dst,
> > > > +				const struct nlattr *nests,
> > > > +				struct netlink_ext_ack *extack)  
> > >   
> > > > +	rcu_assign_pointer(*dst, new_profile);
> > > > +	kfree_rcu(old_profile, rcu);
> > > > +
> > > > +	return 0;  
> > > 
> > > Don't we need to inform DIM somehow that profile has switched
> > > and it should restart itself?  
> > 
> > When the profile is modified, dim itself is a dynamic adjustment mechanism
> > and will quickly adjust to the appropriate value according to the new profile.
> > This is also seen in practice.
> 
> Okay, perhaps add a comment to that effect?

Ok. Will add in the next version.

Thanks.

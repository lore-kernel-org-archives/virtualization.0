Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2E12D76F
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951613; cv=none; b=ncXfeZs33oZZ7D717PKS2Ihj06KbXxEQNzFAGIMFS8KHmRhNfe52wFvJaBTAQS6WyKkxfr4+woQmTj4+drndC/K/zHvf6Fj/ONKvca5tkzlJpkCZzE/pJfo6vLiL//D8DjKwc7dsNsVpsCtdQTtk2k1M/TW6JRUVE+3it/ZH2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951613; c=relaxed/simple;
	bh=pfKWFBb7zDxCQi7BvfVsF6Ioi73jz575cHTCkheV/vw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=NDkTlB3My/9U35OaKNRaFoBzD57pvbuSPAPZeuFNc8mg4d59U2nlZni+7gCTLWX7Lc92ui0O8PmDMoP4J0VFsSrKTtr7s8+BWeSBdoyTi3/MCCwOJ7UbGQpHDprvOgeN0HhfgVMR8cdB3urb7mVNBXAZ0bSKxoVH+rORzExdFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m9yeXz+x; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m9yeXz+x"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718951607; h=Message-ID:Subject:Date:From:To;
	bh=jguX9efGrTByDGtu7eOLceR5dbAAeAKLWv5lG9X/b2k=;
	b=m9yeXz+xG33rzOqDd82nxP7HDtqgIQW3eoLH1IhHsF11l6zBALFwchwGBU8+QU63AmNW3FEBN16XEb6Z+cp5Cgq22nVcVIzCLeCPAfpdtbBEADOJ0jK4yh46uMLBT7LN3yNoUfBcWudfrm5GzsXjd16JC9Piggmr8H49yPksW0c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8vIC3b_1718951605;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8vIC3b_1718951605)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 14:33:26 +0800
Message-ID: <1718951589.6499782-16-hengqi@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next v14 3/5] ethtool: provide customized dim profile management
Date: Fri, 21 Jun 2024 14:33:09 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "David S . Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Brett Creeley <bcreeley@amd.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Tal Gilboa <talgi@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>,
 justinstitt@google.com,
 donald.hunter@gmail.com,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 awel Dembicki <paweldembicki@gmail.com>
References: <20240618025644.25754-1-hengqi@linux.alibaba.com>
 <20240618025644.25754-4-hengqi@linux.alibaba.com>
 <20240620204445.2d589788@kernel.org>
In-Reply-To: <20240620204445.2d589788@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 20:44:45 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 18 Jun 2024 10:56:42 +0800 Heng Qi wrote:
> > --- a/Documentation/networking/ethtool-netlink.rst
> > +++ b/Documentation/networking/ethtool-netlink.rst
> > @@ -1033,6 +1033,8 @@ Kernel response contents:
> >    ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES``     u32     max aggr size, Tx
> >    ``ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES``    u32     max aggr packets, Tx
> >    ``ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS``    u32     time (us), aggr, Tx
> > +  ``ETHTOOL_A_COALESCE_RX_PROFILE``            nested  profile of DIM, Rx
> > +  ``ETHTOOL_A_COALESCE_TX_PROFILE``            nested  profile of DIM, Tx
> >    ===========================================  ======  =======================
> >  
> >  Attributes are only included in reply if their value is not zero or the
> 
> Maybe add a short line in the section for COALESCE_GET linking to dim?
> Something like:
> 
> ``ETHTOOL_A_COALESCE_RX_PROFILE`` and ``ETHTOOL_A_COALESCE_TX_PROFILE``
> refer to DIM parameters, see ... <- add ReST link to net_dim.rst here.

Will add.

Thanks.


Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312EBA22
	for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993481; cv=none; b=YXj7D3lzjbOc5wqlFDEmAHwpEGui94KTheXmO0bbzpALuPAR8zFHKexCaVEvbe+YJXWNjjWdqHlwlV8pL3slxj4Hm/crpVSTP6sr3Y9C1CSRLkAC1ngimIfBl91N6wgYWHqodEXN7jEh4dD04+qxo0WCqfsj9pixc5C4IO42GVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993481; c=relaxed/simple;
	bh=LsJ5UmrAQ2kaskkhM7rR3Y898px0nwRGcdzfCbvbn4k=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=JsDU71OPgzt3qlXI7BhjzxbXr593Cem+u/33gsI00JowBUKwXraS9HOug/3r0GmsWTmxKrJtB1ZXzB7iCKkgh8HOM5nExAnvow9/zkN5odwd5XMTpYyscU5eZ4juM1y/i+O74nXrV5vyxYnog8mTt81j+hAsYe3o/+E0BxWBLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SbXySFWc; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SbXySFWc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710993476; h=Message-ID:Subject:Date:From:To;
	bh=LsJ5UmrAQ2kaskkhM7rR3Y898px0nwRGcdzfCbvbn4k=;
	b=SbXySFWc8kUKj2QArAfgMsIACu5YV2sxghEJlGQquwlZFGCmRCNCDn8mCRfkXWI4T1x6Cm60Bnb+kd4n/iTGE0+XoQa2d8+gPcHHMqbL/J2LEobGFEqEevH8wJMsaszWhYzrybpKz357UC+jS4C5rzFQZtc8+Wm8VJ+9yAYRTwk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2zNK5s_1710993474;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2zNK5s_1710993474)
          by smtp.aliyun-inc.com;
          Thu, 21 Mar 2024 11:57:55 +0800
Message-ID: <1710993274.7038217-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Thu, 21 Mar 2024 11:54:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "David S.  Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 "Michael  S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John  Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha  Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
 <ZfgxSug4sekWGyNd@nanopsycho>
 <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
 <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
 <20240320203801.5950fb1d@kernel.org>
In-Reply-To: <20240320203801.5950fb1d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 20 Mar 2024 20:38:01 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 20 Mar 2024 16:04:21 +0800 Xuan Zhuo wrote:
> > I have a question regarding the workflow for feature discussions. If we
> > consistently engage in discussions about a particular feature, this may result
> > in the submission of multiple patch sets. In light of this, should we modify the
> > usage of "PATCH" or "RFC" in our submissions depending on whether the merge
> > window is open or closed? This causes the title of our patch sets to keep
> > changing.
>
> Is switching between RFC and PATCH causing issues?

You know someone may ignore the RFC patches.
And for me, that the pathsets for the particular feture have differ
prefix "PATCH" or "RFC" is odd.

> Should be a simple modification to the git format-patch argument.

That is ok.


> But perhaps your workload is different than mine.
>
> The merge window is only 2 weeks every 10 weeks, it's not changing
> often, I don't think.

YES. I'm ok, if that is a rule.

Thanks.

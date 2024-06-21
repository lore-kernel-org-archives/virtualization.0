Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CD39FD0
	for <virtualization@lists.linux.dev>; Fri, 21 Jun 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951636; cv=none; b=lhb4QHA50NKaJ1uACZNentT0MQGu3rsnqNLZhqHQYYYvb3GuKqsNpMPLUMDeyoWH99xo0SZR93cnsh4RecMZ4lmDORpml6GjExWCVBbk8HoxPXJ3AkAyJ5fRS2JibnP8p43TFEOITgSmjlvxhr6MMZ7I+W/xI0jNsxsQ5NOL1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951636; c=relaxed/simple;
	bh=Xb0mUtM8oiE38+41F9AbNF/z9ky5fLWOK4MWw6xBhLg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=XmQ3jashK3epxm0xiE6H42M4D1neOeNrAcIQAu1pzkRYQTvwbomlWOrBqednnd64+8+DmEYQuhDAWireUvAybG2nIgaLCMMM617sc1AN+CwTjE+7K6o+0eDYDAYXof+ewQjGE5KfPw5ANigEr350xeP7EVOAHFGG4VszDqCoWv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HLM2Sk02; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HLM2Sk02"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718951630; h=Message-ID:Subject:Date:From:To;
	bh=fGizkInIzi8S2Z/Q1zqQQM8kbuz37uBRTVg3F8UQ+QY=;
	b=HLM2Sk02iDYq+MXsulsJtBvnM9rgb+nv7o4jXB72ReolD57cxqe03bASshcpEcWthLSK42uPNhGoksVMkbmcDI/iyl1FGStqHfMCOEz0eojdRhNfO0+x8ZU31YPnV2uxJRmPz0W8eM8V5+FoxsBQo/lVFszdtkcAqw9JTxvJR2E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0W8vG-Z4_1718951629;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8vG-Z4_1718951629)
          by smtp.aliyun-inc.com;
          Fri, 21 Jun 2024 14:33:50 +0800
Message-ID: <1718941478.823058-14-hengqi@linux.alibaba.com>
Subject: Re: [PATCH RESEND net-next v14 0/5] ethtool: provide the dim profile fine-tuning channel
Date: Fri, 21 Jun 2024 11:44:38 +0800
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
 <20240620204025.625f759c@kernel.org>
In-Reply-To: <20240620204025.625f759c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 20:40:25 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 18 Jun 2024 10:56:39 +0800 Heng Qi wrote:
> > The NetDIM library provides excellent acceleration for many modern
> > network cards. However, the default profiles of DIM limits its maximum
> > capabilities for different NICs, so providing a way which the NIC can
> > be custom configured is necessary.
> 
> Could you give an example in the cover letter of a type of workload and
> how much a new set of DIM values helped?

Sure.

Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335833C5
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717038664; cv=none; b=OSQDamO+cczE5RF8wyTL4G0DZVDJE4NaEMDMDcFqpWY+vho/59IKs/TOHJgBoyJVLKqzbkFFnRk3RhvRtlFnOPxn+0pbh4qX/3UL94PHwqzLubmM6MiOxa/Ztee7h7f8Jgh4c7b4LclOAWVj/PjpT2hFDpLleQZj6z0xwkfbTSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717038664; c=relaxed/simple;
	bh=7sNUcNSmqNPsQTDr6e/iLs21QkaLHkuaxWMxfWhXeW4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=CqwqBbk/ZVW23FAlnW+khosJE4SUgN3vMkhjd37vKM3sKgnY+5JmBNELj9FBlDmXSsuBWFSWGLWvpn0hN6KnQxb/ItEgm3iQnWfPkxln8uEMRHsYBK+vw+nIwusQf34BLL+GGsb5MKILUu5c0ktychmmtxNf5yQdONERcE9glW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eXvMuQNl; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eXvMuQNl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717038654; h=Message-ID:Subject:Date:From:To;
	bh=TAMGz5OlUaCO7hHm1pRgBuMGTSA1Xh++eGteDd5wnhw=;
	b=eXvMuQNlc+CY0NqAmmJbWTNV2CR6em+J5kMMOGh6aq/wMAWi80/v38r541nh6DoKHjd6idMyLCw3WDqUzWrris7K4fnHuxS+2N0qsTmmv7KPrH2K+QAp2McqIqucR0v+gdSAm1qefUDmrYh83EK0cZ2QjCoZ2HjhrbDsi1CW91E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W7VW4jL_1717038653;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7VW4jL_1717038653)
          by smtp.aliyun-inc.com;
          Thu, 30 May 2024 11:10:53 +0800
Message-ID: <1717038610.151065-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net 1/2] virtio_net: rename ret to err
Date: Thu, 30 May 2024 11:10:10 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Daniel Jurgens <danielj@nvidia.com>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
 <20240528075226.94255-2-hengqi@linux.alibaba.com>
 <20240529171053.132ae776@kernel.org>
In-Reply-To: <20240529171053.132ae776@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 29 May 2024 17:10:53 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 28 May 2024 15:52:25 +0800 Heng Qi wrote:
> > The integer variable 'ret', denoting the return code, is mismatched with
> > the boolean return type of virtnet_send_command_reply(); hence, it is
> > renamed to 'err'.
> > 
> > The usage of 'ret' is deferred to the next patch.
> 
> That seems a bit much. Can you call the variable in patch 2 "ok"
> instead?

Sure.

Thanks.

> -- 
> pw-bot: cr

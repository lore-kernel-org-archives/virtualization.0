Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A638F82
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPus4F3F"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6D6141A37
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 15:35:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C6D6141A37
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HPus4F3F
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xi7GA56Z4qZZ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 15:35:36 +0000 (UTC)
X-Greylist: delayed 376 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 29 Nov 2023 15:35:36 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CEFB4091C
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CEFB4091C
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 15:35:36 +0000 (UTC)
Message-ID: <0c2efe49-03db-4616-a4e5-26ff0434e323@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701271757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oj8NqBU6PvsJkrw0mP5/tdKRY1iPOIpTDWPs7tNcdE=;
	b=HPus4F3FMmbIqNJQzFTIAo9HB0eWDFdXdKvnw6QL5Rp5aEV8A4LNIKR2WOvqID06ZbwgEv
	mtwS8FO0s2eJHn/JUmKoqtcZtUM57btzOL1xXjLE0y/Ih8Vjh43dXSx90tMspRNGT/nMhI
	GzstSrHYhJLRYv47ExNn+CguKXmc+BU=
Date: Wed, 29 Nov 2023 23:29:10 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/5] virtio_net: Add page_pool support to improve
 performance
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 alexander.duyck@gmail.com
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
 <20230526054621.18371-2-liangchen.linux@gmail.com>
 <c745f67e-91e6-4a32-93f2-dc715056eb51@linux.dev>
 <20231129095825-mutt-send-email-mst@kernel.org>
 <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
In-Reply-To: <b699fbc8-260a-48e9-b6cc-8bfecd09afed@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2023/11/29 23:22, Zhu Yanjun 写道:
>
> 在 2023/11/29 22:59, Michael S. Tsirkin 写道:
>> On Wed, Nov 29, 2023 at 10:50:57PM +0800, Zhu Yanjun wrote:
>>> 在 2023/5/26 13:46, Liang Chen 写道:
>>
>> what made you respond to a patch from May, now?
>
> I want to apply page_pool to our virtio_net. This virtio_net works on 
> our device.
>
> I want to verify whether page_pool on virtio_net with our device can 
> improve the performance or not.
>
> And I found that ethtool is wrong.
>
> I use virtio_net on our device. I found that page member variable in 
> rq is not used in recv path.
>
> When virtio_net is modprobe, I checked page member variable in rq with 
> kprobe or crash tool.  page member variable in rq is always NULL.
>
> But sg in recv path is used.
>
> So how to use page member variable in rq? If page member variable in 
> rq is always NULL, can we remove it?
>
> BTW, I use ping and iperf tool to make tests with virtio_net. In the 
> tests, page member variable in rq is always NULL.


And I replaced page member variable in rq with page_pool, but the 
statistics of page_pool are always 0.

It is interesting that page_pool member variable in rq is not used in 
ping and iperf tests.

I am not sure what tests can make page member variable not NULL. ^_^

Best Regards,

Zhu Yanjun


>
> It is interesting.
>
> Zhu Yanjun
>
>>

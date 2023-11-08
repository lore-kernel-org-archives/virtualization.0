Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59BCA4C
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 030AB405E2
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 05:50:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 030AB405E2
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WTFyAR9CrzRv
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 05:50:41 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1363F405CD
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 05:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1363F405CD
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VvweDUc_1699422633;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VvweDUc_1699422633)
          by smtp.aliyun-inc.com;
          Wed, 08 Nov 2023 13:50:34 +0800
Message-ID: <1699422583.92944-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/21] virtio-net: support AF_XDP zero copy
Date: Wed, 8 Nov 2023 13:49:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
 <20231107100148.560d764a@kernel.org>
In-Reply-To: <20231107100148.560d764a@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 7 Nov 2023 10:01:48 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue,  7 Nov 2023 11:12:06 +0800 Xuan Zhuo wrote:
> > Please review.
>
> ## Form letter - net-next-closed
>
> The merge window for v6.7 has begun and we have already posted our pull
> request. Therefore net-next is closed for new drivers, features, code
> refactoring and optimizations. We are currently accepting bug fixes only.
>
> Please repost when net-next reopens after Nov 12th.
>
> RFC patches sent for review only are obviously welcome at any time.


Yes. This is for review.

Thanks.

>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> --
> pw-bot: defer

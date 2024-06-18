Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC408C8F3
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 01:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674104; cv=none; b=cWLy59xWrTWh+e7hVUUuTMGoAcIuXKuVD5YAIupGdRw5LHqiDDIUqHqFSJEUmokwt2svEl8Is3pxlT+0ebffdtwJ0kal74s4Kz4lptEr5oS6ELICb/a+/mEoV6BTyk5hl9Z6o8LA1AaKygEvtTQXe2a137iKqNAJe98kbo8Cn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674104; c=relaxed/simple;
	bh=NWWIyOvvwEm8OqF1u2GbyLpt/eCbcYgMTuV8ijj0Sso=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oplbvezcvQlHqKIXg0li0JF79mmThCnblQju9soYotmVTzYCd3Cah2vSwUwltc4GCqPnhtf89QtoKqCNYR/1tHt/RzTdQlrH4SSCrSTTxmKyxh8iPZxOmD5zGX/G6RL3eGpZTww/bXY87tbAXvGdAZqpBTHjO8aukPknX8ko9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XmthzBcD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XmthzBcD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718674099; h=Message-ID:Subject:Date:From:To;
	bh=gC4s7CnM7P3cGUsD+zh1/ZpFsTnWxtbKTh5j1NrbJfY=;
	b=XmthzBcDn29iy3D9FmBMDOJwz7DXxpluxH56E/PV/9IoYYzzTh1lztgJFsmZQAecx9kxf5RfuryBuYkSexfTdnR9b+KPao20xZnWA3TBtFZkMgYsaxUu/dMosZmvxqxotE8sLEwwhRUWzKM78n61vZxQkbs0qdocTwP3tJdvigg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W8hwW80_1718674097;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8hwW80_1718674097)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 09:28:18 +0800
Message-ID: <1718674059.0143738-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [syzbot] [net?] [virt?] upstream test error: KMSAN: uninit-value in receive_buf
Date: Tue, 18 Jun 2024 09:27:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com>,
 davem@davemloft.net,
 edumazet@google.com,
 eperezma@redhat.com,
 linux-kernel@vger.kernel.org,
 mst@redhat.com,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <000000000000d10c260619498c25@google.com>
 <4ffb1d55-acfd-4647-a4d7-f227a6ad21ea@I-love.SAKURA.ne.jp>
In-Reply-To: <4ffb1d55-acfd-4647-a4d7-f227a6ad21ea@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 17 Jun 2024 16:15:54 +0900, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> Bisection reached commit f9dac92ba908 ("virtio_ring: enable premapped mode
> whatever use_dma_api").
>
> On 2024/05/26 1:12, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=157a5462980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6c22bca89a3565
> > dashboard link: https://syzkaller.appspot.com/bug?extid=799fbb6d9e02a7a1d62b
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/39a256e13faa/disk-56fb6f92.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/d4ecc47a8198/vmlinux-56fb6f92.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/0d37bfdfb0ca/bzImage-56fb6f92.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com
>

Maybe this patch can fix this issue:

	 http://lore.kernel.org/all/20240606111345.93600-1-xuanzhuo@linux.alibaba.com

Thanks.

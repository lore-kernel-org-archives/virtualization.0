Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615E13B28A
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608590; cv=none; b=Jz//qvgyr0chGpmPH0XGXlSCUqnIka2Yz9+wVQgFLQMm9zeQ+71Vv8izDYvVB/Hz7/AOdI5DY5+fNhfQRzKiixLLlLk+snVlvzMNVZqrjr06LFY6OxdbBcj1XV4V/KRCvr8Yl/LSvKz1UEaf9g3vtmVOfdQPy727Ngi2B/XoEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608590; c=relaxed/simple;
	bh=H7AmQrMJP4s4L5v4AT7IMHIAdsrL5oe6gLYAaKub+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oCnZCe7a0SaNIznkQuVLFdttkpr5YANj7amQgFwVu3sTzk91E2rer1ynsiDBvXOwXLOLTAfoLRdkqQ82ppM+WXGHzPoO6ZKw6JsOy11n1EsCWTBtfUJu126ylBURT/t9jaXM7EJc8GXoyfX9/3CEhsKDKhNivVW6WohW6f4eO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45H7FwLU025803;
	Mon, 17 Jun 2024 16:15:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Mon, 17 Jun 2024 16:15:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45H7Fwki025800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Jun 2024 16:15:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4ffb1d55-acfd-4647-a4d7-f227a6ad21ea@I-love.SAKURA.ne.jp>
Date: Mon, 17 Jun 2024 16:15:54 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [virt?] upstream test error: KMSAN: uninit-value
 in receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <000000000000d10c260619498c25@google.com>
Content-Language: en-US
Cc: syzbot <syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux.dev
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d10c260619498c25@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Bisection reached commit f9dac92ba908 ("virtio_ring: enable premapped mode
whatever use_dma_api").

On 2024/05/26 1:12, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=157a5462980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b6c22bca89a3565
> dashboard link: https://syzkaller.appspot.com/bug?extid=799fbb6d9e02a7a1d62b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/39a256e13faa/disk-56fb6f92.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d4ecc47a8198/vmlinux-56fb6f92.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0d37bfdfb0ca/bzImage-56fb6f92.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com


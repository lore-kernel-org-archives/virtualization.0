Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EF19B3D6
	for <virtualization@lists.linux.dev>; Tue, 18 Jun 2024 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679430; cv=none; b=jQl0zYLNmEbVCaabiE4JyyGZ9vauPHWFEw7z/Bkse9SmfI5TvALl8l92jCRqe86sTutzl9l3PuhMEjWwM56z1bXSudFa/K2v8/Zbjh9Wjt0yB9qoPHUYn9BQQPdft34uhxn2HwtTK4bTkXL3A77+Bjk7YmZtpkQllBt8sHhhVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679430; c=relaxed/simple;
	bh=z4yyF+UmXxEc5mtHCyYsfU2zNwtL4Y+ZVskAsRua9T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5xKAZHWofVPXQ2L/r3nbF+xX5pDfaPpt9kkcUGeagDaFqA6FktUkSRuGwjHOjgK7/TPJ/XUhbkaY5ff+wZbFcorCSsbk5uPqTYLQ5b5YOuznpOPHpc6tKQCz+CdIKof3w06dPnTA9MAnlY/UKAet5XSrnlyJSuiNvxkbuAUIio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45I2ulH6041517;
	Tue, 18 Jun 2024 11:56:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Tue, 18 Jun 2024 11:56:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45I2ulke041514
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Jun 2024 11:56:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3b9e4f5a-3008-4480-9816-080f74179a23@I-love.SAKURA.ne.jp>
Date: Tue, 18 Jun 2024 11:56:46 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [virt?] upstream test error: KMSAN: uninit-value
 in receive_buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: syzbot <syzbot+799fbb6d9e02a7a1d62b@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
References: <000000000000d10c260619498c25@google.com>
 <4ffb1d55-acfd-4647-a4d7-f227a6ad21ea@I-love.SAKURA.ne.jp>
 <1718674059.0143738-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1718674059.0143738-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/18 10:27, Xuan Zhuo wrote:
> Maybe this patch can fix this issue:
> 
> 	 http://lore.kernel.org/all/20240606111345.93600-1-xuanzhuo@linux.alibaba.com

Yes, thank you.

#syz fix: virtio_ring: fix KMSAN error for premapped mode


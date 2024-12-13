Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E21DFDBB
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090188; cv=none; b=OqqZLxg8s3WUll9mQFfMHyBCnJqGEYIxLTt30EMRGPD/Wj8/YyUh0Rlp8PjdRkWI61oMLBkMYau3sLuCd9iRCpdWJkYLpTPcqcMAHaQkbPBIRX09TwIKwtat3f7sELEEZ6CWwb1JldGLIsQ4FhEeSz6T+NE6AnbBj6y9lU+wkh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090188; c=relaxed/simple;
	bh=estDcRIo9Ps/V70akpJUOEghJnsuWqhCaWrCUbyCJD8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dtCFFSwdLU6iY8WxB3RLauFOwzwhfzs0CsUM1RH0vzApllVeE5z5ifGaiyc0khSguyS9yTY2lWmuadM0nYCY5sOJdoZ+TIF97SV2F1NqVF3tY7wskGZqS/ayqxNguovhEAt008zGx4vJz2pCLE09g5glT6hvYvDFzfdDzKAUNGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C94E433A6
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 11:43:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.838
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OgIfVOu9Sg57 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Dec 2024 11:43:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.166.198; helo=mail-il1-f198.google.com; envelope-from=3xh1czwkbalmlrsdteexktiibw.zhhzexnlxkvhgmxgm.vhf@m3kw2wvrgufz5godrsrytgd7.apphosting.bounces.google.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7971543360
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=syzkaller.appspotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7971543360
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7971543360
	for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 11:43:03 +0000 (UTC)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a814bfb77bso26875885ab.0
        for <virtualization@lists.linux-foundation.org>; Fri, 13 Dec 2024 03:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734090182; x=1734694982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6njtYwuuhlt+oJFig9mpzBM61IwvHlJyPr4iUNckOYs=;
        b=ONBo89t5Ewse5kUNqpKVv3dP1bZunBkQqrs4OCBK8FoRlRQE0Hv0M083avs5FVSBiT
         iZr9iEZQnPRDVvCFhyOr5KjZqtQ2PV1z3Ot2sTa2M27fhjYxYGbuXkFUG4xCw5QdUZHq
         +HpYe1KuNGGBYomPABYl0zIcikWdD5Fcc0HbJBgzmaqK+/C3Lofq/t+Aiw7DDJwrbf2l
         819XPLTUyXyCrTXuClUmKyn70IunUJRSs5sZ0Z53+xmbftId0S+pFm7VeXZUunwtSVuW
         ZV9dqzNpI+w9dAh0qvMtL5/kxSZH8OkeK2BMIYcepLSF/QicesllUFK5Oe1zDE9zE3rZ
         4jrw==
X-Forwarded-Encrypted: i=1; AJvYcCUjDROFE6tjrYNrwmq48tvl8pwmGD7DRtfg1c6k4aG0gpcTg5Wgqnal/zL9DylUBdjk58G2t2XFqSGB+MVgew==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyyN/ahraechCtNMKedLUqsf1NOXaUr7S2kOR6v13j4xQ/CZpFu
	owvMEe5Lk2ahN6ShRxw49cPoCbINX9S8Ymza0wPD1mgD0Mg7MVjGAtYLWbPptId0ATbhnzzMEl4
	ll5qA+Bt4sFOL0+JqOLXSQ0SW/xZSXmOJ1sJvhllCx3KBiL7wmgcek/c=
X-Google-Smtp-Source: AGHT+IHDAFY/TJurokeAD58Ic6k8Gv/vDg0siFvYAkQ1NFVck19SuU1w02dmhAQMhWSSadJDht8QTW+J8baOcxgzM5T4zE7FxWYz
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c47:b0:3a7:c81e:825f with SMTP id
 e9e14a558f8ab-3b02d78812bmr23955515ab.9.1734090182295; Fri, 13 Dec 2024
 03:43:02 -0800 (PST)
Date: Fri, 13 Dec 2024 03:43:02 -0800
In-Reply-To: <675b61aa.050a0220.599f4.00bb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c1dc6.050a0220.17d782.000c.GAE@google.com>
Subject: Re: [syzbot] [tipc?] kernel BUG in __pskb_pull_tail
From: syzbot <syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com>
To: alsa-devel@alsa-project.org, asml.silence@gmail.com, axboe@kernel.dk, 
	clm@fb.com, davem@davemloft.net, dennis.dalessandro@cornelisnetworks.com, 
	dsterba@suse.com, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, io-uring@vger.kernel.org, jasowang@redhat.com, 
	jdamato@fastly.com, jgg@ziepe.ca, jmaloy@redhat.com, josef@toxicpanda.com, 
	kuba@kernel.org, kvm@vger.kernel.org, leon@kernel.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, miklos@szeredi.hu, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, pbonzini@redhat.com, 
	perex@perex.cz, stable@vger.kernel.org, stefanha@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net, 
	tiwai@suse.com, viro@zeniv.linux.org.uk, 
	virtualization@lists.linux-foundation.org, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de4f5fed3f231a8ff4790bf52975f847b95b85ea
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 29 14:52:15 2023 +0000

    iov_iter: add iter_iovec() helper

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17424730580000
start commit:   96b6fcc0ee41 Merge branch 'net-dsa-cleanup-eee-part-1'
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c24730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c24730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=4f66250f6663c0c1d67e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166944f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1287ecdf980000

Reported-by: syzbot+4f66250f6663c0c1d67e@syzkaller.appspotmail.com
Fixes: de4f5fed3f23 ("iov_iter: add iter_iovec() helper")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

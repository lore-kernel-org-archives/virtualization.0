Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41D205AAE
	for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869205; cv=none; b=eD8KuBlGQKkvuvTM3424oUmWyFjiAtgYJtK6vCeMUtH/2+CUvWCZ8PkVnufFqQoNZzrxt5x6nrAWhgZQUYOaTKAn+TG9q0HzAHHOAIvhSB4qd7mYpJ6rTeJrNr5cs2/JBStFlB4uhmMdfWdJGZNXtZeL8ym/P+qFFeJClzJHDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869205; c=relaxed/simple;
	bh=zB03Yo5a4TSm7+8uAwJffWydukNUQMholn/bwNbrDtI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m4q9k5sN3NZteVXFiBmFINNMVSUQB8rJsTbU4wiX67n7RqrHc94A/ZidACodv9cPfzxhzGUiJyj/rA7q2wlUXwjm+XrjTUre4hkYYFd2o/Ne9x9Or0ij5b3lBvh/CXwGVlv+BdFjIgarsoEcpo/pYQJsuz/yr7h752Y8BrRY/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso50319435ab.1
        for <virtualization@lists.linux.dev>; Tue, 14 Jan 2025 07:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869202; x=1737474002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0bWR7N4+h8vCSRDid3JssGaHiwFg+XTpVB6YEkMB/Q=;
        b=aEOMj3vrO1uL8oB0PZEkYQTwU04InlcizAQuSX13HYtISav3HszOwsLnVe9D2be3Vz
         AAcA9bnSIIWCWdLRGvuGIpTRGPEz8fqqCw+2xDwEujuppCgHGUuMRGkj9YCYKYnRmuIF
         iNw5xBbSHJaHEa2grALNTo/Lwqdz2Zx1i6MIpa47rEKTH+QHu9n3/sqov28KWsprIGYS
         hgvvcAPlF6du/DkW6XI2pCH0WPvl2L3ipAd0yo3jQtdQ3XTgfa54LIls1xRaWdylBO38
         DK6fQbG/CfFDnhJG3/dGasCHlC0DuMbI9dLzEFOfqzeb9uLmo2fUJ/nt4sNGc/NPSNzJ
         CltA==
X-Forwarded-Encrypted: i=1; AJvYcCXkyn3N1ygBjIOP4vzJri+jK4e8C+D3ORH60dpeXWvX4MlBjAWi59F244SmE0tUHGLwLa6HFTYoi/10+6XUmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLPCeA5DmnxmLZHC6ux+FjH3aJvjVz9iiuC0CvYFLV+LX1vs8O
	rGkmyzZRITKlMtlkZn7pGI44NDDKUiWxxvS8l+yukbmijgU+CtAZ/zrPEyqFRhLZM/IEov13vbH
	doAk8vcYR2BohQcDkexOF0HBBAIOxJYy2gqW/fNUvFP3ZyjezgQjAslU=
X-Google-Smtp-Source: AGHT+IGiyndoZey2535kRoagwEuVr7g7Uci1iK4DaPJhsEeErehD2LR/OVK5TYjFdc45HpMPVs9u7NwCXD7vvMMq1w1qWXDrspbm
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0a:b0:3a7:a553:72f with SMTP id
 e9e14a558f8ab-3ce3aa5b1ddmr200152395ab.18.1736869202240; Tue, 14 Jan 2025
 07:40:02 -0800 (PST)
Date: Tue, 14 Jan 2025 07:40:02 -0800
In-Reply-To: <g3mn4fcltag3c6l46s3rxqzpl6mo5hxbv7cnv4fxh2x234t34w@r4zh3zfql4s2>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67868552.050a0220.216c54.0080.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] general protection fault in vsock_stream_has_data
From: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux-foundation.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com
Tested-by: syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com

Tested on:

commit:         665bcfc9 Merge branch 'vsock-some-fixes-due-to-transpo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14e95bc4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ef22c4fce5135b4
dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA3D1D90AD
	for <virtualization@lists.linux.dev>; Tue, 11 Feb 2025 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237407; cv=none; b=QixsOGN3fJO4WpVEoaPk3zzhuZyCj0rOVFIrTmMXTYyXxVZjwOu57pmZMBH4VNlbUjmaMVpvdGsk7Ox1P4omiDYuvU931GzCO/sI8ONAxlMTmTuEaBP7MuIXHLbxiH5CrA+13BPux8EXzzSguZPgZj/nJll1PMUHNgJECEKI8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237407; c=relaxed/simple;
	bh=v/Nh6V3Squ6zTlqOd8JqUTRgJWgw0anyNQlDu2hHeM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IfNsx1ji0zBUxyjYF6UQHRAb2dBVvuafUdmnAFZ+RK/QkeyJfSo+i2pCtgpG12cQe06cqoeciBqyCUvk5mWnb8Xx10vVNMioOYoLizZT+kgXx+zdJmFsGUNSp2Xl/3t0aYTylOoV1LFzZlDTwrAy7v8tRDxda36QK0WaHTJu11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so107316285ab.0
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 17:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739237405; x=1739842205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6+FBchsBBeiNSoV+eW+VD+Rx2zp2Kr3ieu0cpfLjMM=;
        b=Arm7B5IiiGXGJLIWOog7RirxpeUwDWBRuGSGLh7U10mj8PG2SIdE9MPjQ/eGvcmqij
         CDG2gzTvp+/rhecTzDqMBv96MInS7fbKt72+59bKhq7rC7ibtzf6HlkPb+7dCS7/jxzZ
         wI6xUyqdJ0zDDAk8i9I45Gu9OI37F6QKmNg9BWWNs2mI8jSdwJiQMDPrM4fKck9bFPJB
         npPWZ1F1PPiWaX8dn1ToOq/xGME+0HgbmhyVWmX9LgcQgI4HooQVfpdhfZUI2zpN59LS
         tYQkU9M7vcUtJTDgSQ08oe0s285hzI9DDji9zCKoY/dOH39jqqwfkuHz7yQ5GgKJQwua
         p1rg==
X-Forwarded-Encrypted: i=1; AJvYcCXbidjjsA1l4xM5mIAHIpBofAaOYeR3HB2KMfORYqQPdrL0/ut0zty3EKMqaAIpphxcD/8yhOrj5hKsdy0IZw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz7iRJoL93JS9DENfVVzrYFrbkoyDcJ9UcE3rSsKwGfCMjWyd0P
	ZsA36fOo/zrXWd+HpSpbcV71eQ0cldWYjpVdGjehulaUGg55yYTKT7L0GdvFrVLT65H2rRRkmXA
	wtfWqcHZeip1wfQztLSyhZJVOgSWsv4vp5Z75QT/iCJ7HKrqj/ViaXHU=
X-Google-Smtp-Source: AGHT+IG7+XNeWPwTQyEuOSiBbyR17tnLyzZGxNLcT/H3Nag+ebW/Zo92Lj1QdCiNeeqakv6HPCbyQQayKdDo1wilBgT9j1TpzxFv
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c546:0:b0:3cf:ce7c:b8b1 with SMTP id
 e9e14a558f8ab-3d13df2c784mr118031675ab.18.1739237404979; Mon, 10 Feb 2025
 17:30:04 -0800 (PST)
Date: Mon, 10 Feb 2025 17:30:04 -0800
In-Reply-To: <67867937.050a0220.216c54.007c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67aaa81c.050a0220.3d72c.0059.GAE@google.com>
Subject: Re: [syzbot] [net?] [virt?] general protection fault in vsock_stream_has_data
From: syzbot <syzbot+71613b464c8ef17ab718@syzkaller.appspotmail.com>
To: bobby.eshleman@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sgarzare@redhat.com, syzkaller-bugs@googlegroups.com, v4bel@theori.io, 
	virtualization@lists.linux-foundation.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit df137da9d6d166e87e40980e36eb8e0bc90483ef
Author: Stefano Garzarella <sgarzare@redhat.com>
Date:   Fri Jan 10 08:35:09 2025 +0000

    vsock/virtio: cancel close work in the destructor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bb31b0580000
start commit:   25cc469d6d34 net: phy: micrel: use helper phy_disable_eee
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=d50f1d63eac02308
dashboard link: https://syzkaller.appspot.com/bug?extid=71613b464c8ef17ab718
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a3218580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147f11df980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: vsock/virtio: cancel close work in the destructor

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

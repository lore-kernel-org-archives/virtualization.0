Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AA1D0492
	for <virtualization@lists.linux.dev>; Sat, 14 Sep 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330324; cv=none; b=cP3o0++9wCQeG0A0aDihIgaR1OEl3yDRlxuJ7lPIXXsXrvirFOdrQ/K1tWW7gYljQuSY2mDF3EJ+/030mbtxVsKvVN+s3K6igoLE0awf+EvaSV8oMXzRVcHvnx7Kqhw0hmKdZV6wxYezHopbLi7S08De08ss2gzwSUdlA92+y5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330324; c=relaxed/simple;
	bh=3/RaIZT7WdvooM9BNOa0osJLBSkrxtxxgxDPh4ZRNTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DVx0eDqxUJ9HxsTGwuzPr9upAstGdx99df0RHspz65FTr8H/NnpvBW/RL4XKLDQF/uYAyVgSHbqxdB02eB+CSsM/ZnpYa0UXctnf4iwKozR5L96SYZlKA0c1YuvlGUM8tWJisB/n8OKzel7g9vi0nRHRoz8SzaZr9XyhrQT6tsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0539a446dso52804855ab.1
        for <virtualization@lists.linux.dev>; Sat, 14 Sep 2024 09:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330322; x=1726935122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elLGdhu/N7XTEKaqxHm49lH0bwEsUUVJ3oDAKjdaD5Q=;
        b=tj/Nw4/4eNsRPmpyJUycZCr2vOGMlpLrjB9zjh+A6NTdJwfyJQ6MHCr8TlSlv31FEw
         Tv1PzSnK5hZ684PiakgpxgPPvnkKEpfbtLUSFEyIfA/OxY/5E7wywKDDZ9HYC6Ov3CgU
         cPR9LiDhnSyJ3gB4gYU6mYG6s1UoQg8WVD648VwvpmmUdVybpgyYXcW0iHuG+dLD+id1
         NIT3suIxmlYxxDXFHoxzhTuivVu9FiDfGLn1PNJrZzWOlPIt7LE39C7m1UvcqnyhARr2
         /381NjZ1PW2l4VrI3r6X5EY/axhJHYdrNUPx4dY3SMEJqOWvvj/CG15m746vsqcdv7HH
         KIAg==
X-Forwarded-Encrypted: i=1; AJvYcCXPXBwwYluTEnQEBNNehu83e2UTIjA+9D4C5oCj5qgO4s9CmIH3nC9QAZWomzRpVsG6FgWKTbW1Ol0XR/hzPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMip65dA2Mb9iErBeEGCryNY26gdsffJO2iSN/emZceDuzQSL3
	SYt5c6xYehBmJ8EAX0gn1gCzx06ljVi7Eae9FK/eQ5SB8X36Xg2KOl8ak8ergSXNbzmFe7h3y7Q
	mtdldjJfYnKq0PFqHS+qP6BYEYrynK3ilMaFDLjnT1+x70YjSL0X3UDg=
X-Google-Smtp-Source: AGHT+IEc++CMyi6bkWbEuObVzejUUGoJZN+8Kp9MFs8scQOh5Rafy+cL57mjP3DXHmucVMmExu3iETWNncLa6nd6JZ8MiIDzZQDF
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a0:9d2c:b079 with SMTP id
 e9e14a558f8ab-3a09d2cb143mr92265ab.19.1726330321813; Sat, 14 Sep 2024
 09:12:01 -0700 (PDT)
Date: Sat, 14 Sep 2024 09:12:01 -0700
In-Reply-To: <0000000000005c8e95060babfa0e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e5b5d1.050a0220.115905.0008.GAE@google.com>
Subject: Re: [syzbot] [virt?] [netfilter?] INFO: rcu detected stall in
 ip_list_rcv (6)
From: syzbot <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, kuba@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, virtualization@lists.linux.dev, 
	vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e634134180885574d1fe7aa162777ba41e7fcd5b
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:54 2024 +0000

    net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17264407980000
start commit:   753c8608f3e5 Merge tag 'for-netdev' of https://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15abc0e2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b0c7c2e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793565214;
	b=H6UG0To6juujQvgi9ocQ7P3r5vO1XMhE4xu+8Vy/oc/EPzX1sv0ZiyvQw4P6NH0gwr6A
	 5VvirnN9FWl0Pt12ymaOeV9ggXbAm3Y/n8Afbz6h1m3v1Za3VmVAsQzW0Pm9r1h5T25xy
	 ssIOwNkOh94iT+hW1PKEGyhBKavtGCGp0d4GL5+M/hCiAamIOf9OqfCTUzILSFi3Kb9Wu
	 ObRLS6vCZg32zzGLOt5yy5PTNKpwgFdrr3bHyLJTdx4CjpK5tVpnnNpcpt+iB02fwIYw8
	 nAf3I6PXCkLgrJfOC9slFpYOA+GEsdvw2fBD8/RY4vA7wiamDuHmSCQYEw6/mblMNKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793565214;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=LW7OPyjwBJ2uOfyFmmXu2pAnbnSBBaS9xioKSKoFLno=;
	b=m14ulo4bhI460rxgWLbcnJp71r8M08YVERmtdJpsmHsH/nN79lWHpIPPWTjKlIax19zj
	 fd+z2kpPcZVLMqrcj+erIUJQwephnVECCW4cZGFMcNtzp2QIr1oniS2u89wC1tTy6yk6D
	 mEjMREyXjhtJs6nS2tY8WIFtCJFWokALSb2t2Y3I5QePP5V8fC5ff0lUIEhiubBsDMZxe
	 XEdxfNlf3XseYNzIBrkLeh+cGdy+p4hQELeBRoTzN2s3t5j50ArVt3+pA0mt+0rKz/2pw
	 AtfAICr1XhEJkpHrH40EVriO8BcuEco9Mbxz2QbnI3P9erIU8wLn7uVZR4JfAmQkeig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF825606A325
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 20:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF825606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4ab260600easo5077848b6e.1
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 12:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793565213; x=1794170013;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LW7OPyjwBJ2uOfyFmmXu2pAnbnSBBaS9xioKSKoFLno=;
        b=yGqimVmz9wo9IwTJodcrS2eUw0DAOz9g30TZd8Z1XyuPy8MWUQuZdxLijY6slOwNed
         BQd235f7tNyGJGd/R9R6C5YJ1W8Xxbq8NioiKL+9bruGEI5eJt0isAlTZbrLYlxL36wU
         ip7+n2fInrZ6XKw5dX8U9ubPawf8FJvy8k74DfeayutBgrY5eWr7NlpK4AQ56C+eoTet
         lC3FTmRyq9KXvy3NNa0s22Ie7iUtlj+JlgJx10LyKvvGdACT/7VLhxnQKLWMe5Wwwipw
         3UFcowhAEhwF9RuLHIEClR7u7dZJqfXB3L0ycywX4HhhBqcBogS3yD4TIqu7MNYUfllQ
         nHwg==
X-Forwarded-Encrypted: i=1; AKwUvBziNenlsWi0xKxUis/4RZMQ/bK6VxLfn5EUq33SgHKQV4Pcw5XqgWmTGAhVKt9g1qah/ecHGrpNXWJEoC42ow==@lists.linux.dev
X-Gm-Message-State: AFq9FYKmAL3jJ07IslcT+zMqGrs+H8gjczr+g+BFDTcyHfeF8j1irLDX
	eNNB2uyuy74370P2Uy0xy9ztfvKrisAH6QP67x3M2qF87GUzEzGVYp4hN62SVlOMaLlBniXx5uu
	/YmTGibTfUT6uuKIFkJlNCqTr7O4/6DxSxfD8/xGWwV1yRhSnojW3xFakafQ=
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6413:b0:540:8ca:36e3 with SMTP id
 5614622812f47-563ef9afc49mr5908539b6e.19.1793565212774; Sun, 01 Nov 2026
 12:33:32 -0800 (PST)
Date: Sun, 01 Nov 2026 12:33:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae7a21c.7fe51036.1ecf7.002c.GAE@google.com>
Subject: [syzbot] Monthly virt report (Nov 2026)
From: syzbot <syzbot+list1866aebaf3e7c04f9ac3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello virt maintainers/developers,

This is a 31-day syzbot report for the virt subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/virt

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 66 have already been fixed.
There are also 3 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 332     Yes   WARNING in virtio_gpu_alloc_vbufs
                  https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
<2> 109     Yes   WARNING in virtio_gpu_free_object
                  https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
<3> 4092    Yes   INFO: rcu detected stall in do_idle
                  https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
<4> 5       No    BUG: soft lockup in mac80211_hwsim_beacon (3)
                  https://syzkaller.appspot.com/bug?extid=a009aa73657fb9a84de5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

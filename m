Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715B184E
	for <virtualization@lists.linux.dev>; Sat, 25 May 2024 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716605784; cv=none; b=K/W4YRpGaaGtPJX3HMAXNb5BNL4r4BfiPsV6l1tmbNuLyb1Wo6a78e2PwEcSsn9z182GX+wFFAndhkUefw2uVkl/TijgLnMmUnvIkQyoA5fdcqUrftTcV8/50c7H7Cy4iEjxw+UDw1rzIxai+PS7tMeP0E/8KJhxY1H2KMTl1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716605784; c=relaxed/simple;
	bh=Ks3KmzwMbRsannbXAsBY5Mpb/8YYOiPHCfk/qKRpZZ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QoZNzchh01FU20bFHhbWJfOEv985dt0t+LJgfx4HxOEJ+tIlgX9SiJNWWY7hRF3dOqkunlwib2C7wuBy+9Bj+xc95Dhjzq8nRN1L7FtdRv05MAK68lXNhiqyBwCYRq3+LhbH/ZocJArrDdnYs+/BcARLL1yzs+bfcYpBrVRE+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3705289d46fso37992145ab.1
        for <virtualization@lists.linux.dev>; Fri, 24 May 2024 19:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716605783; x=1717210583;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExZtektDIQPH03325dsSn5zzOZ7zTFNhg8HxEcmp2pY=;
        b=hS+7nN86RT/1Zh2usckIX6p+/Bl/u7yJuFvPsdR7G7dZcTP9ZgoFONGmXA7vQk+KDr
         n/xZ0ULJgHlcRchzrT+i1mNDPre+6XwXLH9vVdiLcnMrvq+/yPrT1skinuqaqNvaltKU
         O42YY28tnLPi+7lYvgJFeg9scAJb9U2Idr6L0QvlpP0Z2EJ3zp4hGHdjE6kcKOwimKJm
         DxAjhqacwtfz62UcUJIbqdm0sDKAjca1TNtmd4o5A63nQgk8I62QBe0Dxo3TG1i4l6+f
         TA98JFK3ua0Ix0vvRaBna2nwOqAYzZIEXx/wE9ncxEaBVooTnk2lZbYKESxYgoU6UrAi
         udZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl2tQdcrrVfKX+zP5eygpGzzy7iFdThGCAJ8d/20+Lay/N7cmeqPU8Dey1qGj/Nzbs9Bila219eAkd8EwcfE2qrw3RX6FLUfOQk+c8OXI=
X-Gm-Message-State: AOJu0Yz5NOpQOdFY4QiYDxwlpPOb95StAiWZM2lA+i5hfRCwPZernTHD
	NPYUs7wbs9eaiVsu1jGpX774d+qbJurM9hwnsuGf4w5ghARTSZd5mSgJlyB6cO7Y7vhyPBdCXNV
	gI7sCHXhsy9nCGeRwJ+VBL/1qB43D26xfn7h/YFgSWfFbRCuWGd4OhM0=
X-Google-Smtp-Source: AGHT+IHSvRTiPokUE/70fZDTdslc+f038Gctibu7OR86v/OeWMvaJzlipA+ZcFINQ4y9b22ZNVZQjCUPPTqhv8pdYQnNEkbykyQr
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c743:0:b0:373:874e:93be with SMTP id
 e9e14a558f8ab-373874e977emr865105ab.3.1716605782818; Fri, 24 May 2024
 19:56:22 -0700 (PDT)
Date: Fri, 24 May 2024 19:56:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7924806193e6dcc@google.com>
Subject: [syzbot] [net?] [virt?] upstream boot error: KMSAN: uninit-value in corrupted
From: syzbot <syzbot+f8f2e9a62c70487ab828@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jasowang@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=119aa5cc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d66c5ffb962c9d5b
dashboard link: https://syzkaller.appspot.com/bug?extid=f8f2e9a62c70487ab828
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a053ab9d75b/disk-8f6a15f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1cac58c3541/vmlinux-8f6a15f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/180b83fc69a9/bzImage-8f6a15f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8f2e9a62c70487ab828@syzkaller.appspotmail.com

Starting dhcpcd...
dhcpcd-9.4.1 starting
dev: loaded udev
DUID 00:04:19:0b:4d:1d:24:6b:9f:8b:bf:f7:85:18:31:02:d0:f0
forked to background, child pid 4697
Starting sshd: [  113.935289][    C0] BUG: KMSAN: uninit-value in receive_mergeable drivers/net/virtio_net.c:1839 [inline]
Starting sshd: [  113.935289][    C0] BUG: KMSAN: uninit-value in receive_buf+0x25e3/0x5fd0 drivers/net/virtio_net.c:1955


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

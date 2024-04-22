Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CB1514C7
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795534; cv=none; b=J/avJbuLjmTaDA0pTkekGJmY0/LbPWqxEzN9dGRbH/ijNIRh1ZoMvj4DkI9rmlDxniZjhrMifjkU0axlcvDiS95fFINIX6L2XvFLmRm3yMM+Q4KxOiwPfh4PVcZOinbBIgqj0i5TvUvkAi/u5p/l7B8pjrcTbnGHexjA0zudIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795534; c=relaxed/simple;
	bh=5NebA/A3MQ0RArecgWlr/xbum8+gfgz73lLHgMGOtBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ag61MTMPEug3DjFcqq+5rmgMiyG88t4UfWxMLv/ZWVsGG9pm9VxD5fXExjddYFwuKm7rsbP+aVuL3JKaDUOq5ezlghTKPLbvqFFD4FlyUUmYXyddX6E0pl61Fa6YMB8cFG+16z+7H7sKK/jPa8XvqLUZZHsiIVsJH0pS9jviU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OR3fmfvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR3fmfvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713795532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RuEWgRbov+iY+KqOCft+xN2s/HWnJOwqATFyKi7m/SE=;
	b=OR3fmfvERacI/lSmv7ufApwIwWVk1MbYeei6qT15IR2Il48nIxT3Mh+oKIv8uRwzOd06Tz
	elWQ9ukZWMdG7hZvBRgb5KN3gjMzm6bscGWTCH6Eymi/YBZGJVSBNfIqhcilZTDJX0nVx+
	P5l4N10LM8uF21nwrIk2y8UJPhf5TTc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-pVYG2WNuPq2QNkiewT1CnA-1; Mon, 22 Apr 2024 10:18:48 -0400
X-MC-Unique: pVYG2WNuPq2QNkiewT1CnA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34b40e8482aso454071f8f.0
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795527; x=1714400327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuEWgRbov+iY+KqOCft+xN2s/HWnJOwqATFyKi7m/SE=;
        b=Dog57wh0cnizVCxokopqrDIAHfL6YYbnWTh/6t1Tqcitz0UeYK3x5nPJYjy1JZB4NO
         M8xSVpyr9LLClCuLOvhQfM/1ML9JfoaUd8fiTzWySLJgX4e8JmIMeufRk04Q2RQl4wmq
         yuVKK7ne8WNTaDUFS3TNsY1meBkk+T9aJBz905q2Cz6VdkpHUYFypNdX+G3/dsj9/weD
         Nutv/94eTKjAj6kweLFNfBZ1MunlzpX0CqP9/4nP4emqvd7Noi1Azh7xuZ2FDJlZ93LJ
         8zREHWF5I0r51qdbWePSAnan+HGTxRiZdfm0CyIoIu/NZa5pdMfdVki4HxoB9MbhXkOq
         aedg==
X-Forwarded-Encrypted: i=1; AJvYcCXihuEjVvWTzDzsPDX1kyl5QDxfDciPvtCBC8D5ony9aKp9a4ZI+2vbo31aOrTJs5QUga3L3YEGRKkKiUjFGgUXYIWhl/gWXBB3Q+5SNHs=
X-Gm-Message-State: AOJu0YxCTuYUpp9ppPeLYmdR+yNQEVQMYrK3q8/zbyQPMaSuzfsk4EyP
	TacADawPu4k86eKy70gsfaUofN8T9AN9F9TbrWOKy/9cD9VQsQDeQyENgT6cGt6t/nNuYG1WzHh
	OhLrPsZyy/jns+gxvJsaFVlkm8Bndvs0lR72MoZt2wnGVlherNVXgUZm9L/UaOgNN
X-Received: by 2002:adf:ce91:0:b0:34b:58a2:dead with SMTP id r17-20020adfce91000000b0034b58a2deadmr209867wrn.33.1713795527116;
        Mon, 22 Apr 2024 07:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr5x0koTy4iow6GLkNZgdwaMcdEjJgD3/LWvrvM95SfAaGPPm7kmwZu+TuEABqDb/EvhKg4Q==
X-Received: by 2002:adf:ce91:0:b0:34b:58a2:dead with SMTP id r17-20020adfce91000000b0034b58a2deadmr209834wrn.33.1713795526513;
        Mon, 22 Apr 2024 07:18:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id d4-20020a5d6dc4000000b00341ce80ea66sm12114246wrz.82.2024.04.22.07.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 07:18:46 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:18:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, sgarzare@redhat.com,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in
 vsock_assign_transport (2)
Message-ID: <20240422101622-mutt-send-email-mst@kernel.org>
References: <000000000000be4e1c06166fdc85@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <000000000000be4e1c06166fdc85@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2024 at 02:39:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8cd26fd90c1a Merge tag 'for-6.9-rc4-tag' of git://git.kern..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=102d27cd180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
> dashboard link: https://syzkaller.appspot.com/bug?extid=6c21aeb59d0e82eb2782
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e38c3b180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e62fed180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/488822aee24a/disk-8cd26fd9.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ba40e322ba00/vmlinux-8cd26fd9.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f30af1dfbc30/bzImage-8cd26fd9.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in vsock_assign_transport+0xb2a/0xb90 net/vmw_vsock/af_vsock.c:500
>  vsock_assign_transport+0xb2a/0xb90 net/vmw_vsock/af_vsock.c:500
>  vsock_connect+0x544/0x1560 net/vmw_vsock/af_vsock.c:1393
>  __sys_connect_file net/socket.c:2048 [inline]
>  __sys_connect+0x606/0x690 net/socket.c:2065
>  __do_sys_connect net/socket.c:2075 [inline]
>  __se_sys_connect net/socket.c:2072 [inline]
>  __x64_sys_connect+0x91/0xe0 net/socket.c:2072
>  x64_sys_call+0x3356/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:43
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
>  __do_kmalloc_node mm/slub.c:3954 [inline]
>  __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
>  kmalloc_node include/linux/slab.h:648 [inline]
>  kvmalloc_node+0xc0/0x2d0 mm/util.c:634
>  kvmalloc include/linux/slab.h:766 [inline]
>  vhost_vsock_dev_open+0x44/0x510 drivers/vhost/vsock.c:659
>  misc_open+0x66b/0x760 drivers/char/misc.c:165
>  chrdev_open+0xa5f/0xb80 fs/char_dev.c:414
>  do_dentry_open+0x11f1/0x2120 fs/open.c:955
>  vfs_open+0x7e/0xa0 fs/open.c:1089
>  do_open fs/namei.c:3642 [inline]
>  path_openat+0x4a3c/0x5b00 fs/namei.c:3799
>  do_filp_open+0x20e/0x590 fs/namei.c:3826
>  do_sys_openat2+0x1bf/0x2f0 fs/open.c:1406
>  do_sys_open fs/open.c:1421 [inline]
>  __do_sys_openat fs/open.c:1437 [inline]
>  __se_sys_openat fs/open.c:1432 [inline]
>  __x64_sys_openat+0x2a1/0x310 fs/open.c:1432
>  x64_sys_call+0x3a64/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:258
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> CPU: 1 PID: 5021 Comm: syz-executor390 Not tainted 6.9.0-rc4-syzkaller-00038-g8cd26fd90c1a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git bcc17a060d93b198d8a17a9b87b593f41337ee28




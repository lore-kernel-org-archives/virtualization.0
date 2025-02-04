Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F332080C3
	for <virtualization@lists.linux.dev>; Tue,  4 Feb 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663461; cv=none; b=LfPCzjyY5Urg7CKB/PlsM1M6ImKik1SLOdOVIUMZN6IrG6/MGTP4nGeGna60aXkFcM/fVqACwTLBYSHkJA+58attuNEWMWXmYaM+8uqI68+3PjzZv5Rot7D2N85CNMLYuKR9XAJ5gAmBxzPhJPO6PmARTs7vOE1TmlH41t96SEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663461; c=relaxed/simple;
	bh=mUDPToLx4m1t4OQh7RaNx1yOyqPbXSxV/uwU5GCkTBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0Z1EFMoLOjqsxdN8aB3/dkpgK0MFN4CoY6ZlTPnCFUhhKMdBFW9HpHUaSrgKSfHY42QWr4aa/OLc7ojgCHDKt4swVTYbyYD0cSstEPPgY5w5SVQbvx7SCcILEJhExbAvSXvlEO5amKk/ee0cHgZ8LYhh3lWXDOA07rz7a09I+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2AIqTi7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2AIqTi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738663458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7QifqPZ9eDjVzOXnGpRwU072WD973YhoUOHzvFP/XY=;
	b=Z2AIqTi7o1UcLFvVpjzXXwhP+5A0kStJNcmcUm4ly7MqhC4BIeghdtw66pIp8aU8CecT7M
	LIkd6a53hfLCMRSLRJ1uLbrLOAEbqw70+k5VGSEIHQV+DUfHGcSsgkJzTmzTC+mRSihg2z
	tXPZXyaNsdKCE55o/Y00g7IAm2F+/Rk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-PYfLHwo9NI-wLpVJUpKyBQ-1; Tue, 04 Feb 2025 05:04:17 -0500
X-MC-Unique: PYfLHwo9NI-wLpVJUpKyBQ-1
X-Mimecast-MFC-AGG-ID: PYfLHwo9NI-wLpVJUpKyBQ
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f27dd44f86so62187807b3.0
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 02:04:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663457; x=1739268257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7QifqPZ9eDjVzOXnGpRwU072WD973YhoUOHzvFP/XY=;
        b=Nm0dAdy5a9L3XEUfVNVPK3eBBbNo/A68b3a9L6tl7EE/Xbs4puPVoZH07wx8P6cpn0
         0ygquL0UWaegHnnP2TjIyq+9jxFhpoZINvoIlHKeMgVR1MSBcJ9EYg5yR4haYYAccMjE
         Qyqm3ilXeJJhddq+sgpPpIcxoTwV+bDws4bq7AIjMZ9d8WzoQOk10SHbBpCmvYAcj4Xo
         QhURoloUPSY0fLFRYK0ar8204WGZjHU04YB2mQHOnd0d5CCNqU59uON2mFJVcEy6ZSiV
         nBuGdkfXrSIf29TeMvIUBSwIJYtx0axn3HTuPZ323jV5861tN+aMUMIW2DAxmVBSlEn9
         8EcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX803uudlN+BRmJcXv2H/+jnr4D+SVrGZWyQb+91UXgRu0K2Ox099orqeTy2ESnhNWprdJvFBk1yo1+1/0Cyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZu8rF8gyS3f8DH+F0Mrpi0pGJkGvYt5/j5VPd6wX6fk5SwTz9
	Bg3DG3LYxHwIekwsON8AHIYRDFT67fdOB6+s7bdgm0v7q1RwIlVIcR9Xdc7LMHs5X4Tn0ncHq9J
	5+LrBAsQI1gYuHkwiO9Umoo428mh+O8eJIUafkHw0Em00CMTjEkZ3ROgxDnSYmGOA1WV1V7xySw
	8Jk2/jyH7sDUNhWDS+7lhhGFixxakidcIr9q87098=
X-Gm-Gg: ASbGncu812LH0jwuwqUTuR0PoyGrRsu0QFkMTnjLmYfN/6S860Qcce4w042pT4ifwHG
	fEVA7gsXDKK9fObmfadc37lEzIjPmEXUibN4WjQBYYKMc+w3WG290U1Lc/YgqtFc=
X-Received: by 2002:a05:690c:c99:b0:6f6:7ef2:fe74 with SMTP id 00721157ae682-6f7a8426a5dmr187992867b3.32.1738663457131;
        Tue, 04 Feb 2025 02:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGObxnJlWUNYcPLXX3gTTHlz8ygcPRSBCSw4ZNWGPq56uQbjLmdeK3NSXxsGvATRJ7AZmu/F90tI28ywSsg0b4=
X-Received: by 2002:a05:690c:c99:b0:6f6:7ef2:fe74 with SMTP id
 00721157ae682-6f7a8426a5dmr187992617b3.32.1738663456785; Tue, 04 Feb 2025
 02:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67a09300.050a0220.d7c5a.008b.GAE@google.com> <2483d8c1-961e-4a7f-9ce7-ffd21a380c70@rbox.co>
 <6fonjxxkozzmv7huzavck5nsfivx3nsyyicthulg5aiyrmjpql@o7pexllumdxt>
In-Reply-To: <6fonjxxkozzmv7huzavck5nsfivx3nsyyicthulg5aiyrmjpql@o7pexllumdxt>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 4 Feb 2025 11:04:04 +0100
X-Gm-Features: AWEUYZkRpQsQ3lL4HaavFbVzIcqyxyzO3RF8AiDQcOZb6x_hIpX856jwrL1eacs
Message-ID: <CAGxU2F7CgVHUuPPATBzXw20fR1Z+MVpsJvgRO=kMFV1nis49SQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in add_wait_queue
To: Michal Luczaj <mhal@rbox.co>
Cc: syzbot <syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: NqeHtiJlbOkRMc6vStVopHmL3x3S9o1PZQBfEqlbxyg_1738663457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 10:59, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Feb 04, 2025 at 01:38:50AM +0100, Michal Luczaj wrote:
> >On 2/3/25 10:57, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel...
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16f676b0580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13300b24580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12418518580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/c7667ae12603/disk-c2933b2b.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/944ca63002c1/vmlinux-c2933b2b.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/30748115bf0b/bzImage-c2933b2b.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit fcdd2242c0231032fc84e1404315c245ae56322a
> >> Author: Michal Luczaj <mhal@rbox.co>
> >> Date:   Tue Jan 28 13:15:27 2025 +0000
> >>
> >>     vsock: Keep the binding until socket destruction
> >
> >syzbot is correct (thanks), bisected commit introduced a regression.
> >
> >sock_orphan(sk) is being called without taking into consideration that it
> >does `sk->sk_wq = NULL`. Later, if SO_LINGER is set, sk->sk_wq gets
> >dereferenced in virtio_transport_wait_close().
> >
> >Repro, as shown by syzbot, is simply
> >from socket import *
> >lis = socket(AF_VSOCK, SOCK_STREAM)
> >lis.bind((1, 1234)) # VMADDR_CID_LOCAL
> >lis.listen()
> >s = socket(AF_VSOCK, SOCK_STREAM)
> >s.setsockopt(SOL_SOCKET, SO_LINGER, (1<<32) | 1)
> >s.connect(lis.getsockname())
> >s.close()
> >
> >A way of fixing this is to put sock_orphan(sk) back where it was before the
> >breaking patch and instead explicitly flip just the SOCK_DEAD bit, i.e.
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 075695173648..06250bb9afe2 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -824,13 +824,14 @@ static void __vsock_release(struct sock *sk, int level)
> >        */
> >       lock_sock_nested(sk, level);
> >
> >-      sock_orphan(sk);
> >+      sock_set_flag(sk, SOCK_DEAD);
> >
> >       if (vsk->transport)
> >               vsk->transport->release(vsk);
> >       else if (sock_type_connectible(sk->sk_type))
> >               vsock_remove_sock(vsk);
> >
> >+      sock_orphan(sk);
> >       sk->sk_shutdown = SHUTDOWN_MASK;
> >
> >       skb_queue_purge(&sk->sk_receive_queue);
> >
> >I'm not sure this is the most elegant code (sock_orphan(sk) sets SOCK_DEAD
> >on a socket that is already SOCK_DEAD), but here it goes:
> >https://lore.kernel.org/netdev/20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co/
>
> What about the fix proposed here:
> https://lore.kernel.org/lkml/20250203124959.114591-1-aha310510@gmail.com/

mmm, nope, that one will completely bypass the lingering, right?

Stefano

>
> >
> >One more note: man socket(7) says lingering also happens on shutdown().
> >Should vsock follow that?
>
> Good point, I think so.
> IMHO we should handle both of them in af_vsock.c if it's possible, but
> maybe we need a bit of refactoring.
>
> Anyway, net-next material, right?
>
> Stefano


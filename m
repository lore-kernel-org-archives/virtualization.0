Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13941275B13
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568823; cv=none; b=Dcvvme3IK5a0epNfaA9T7EUquMrL+A1XHDkTbKOCtuP5gIE1necyOoe9lEI0DVDHEDiisE++tm6VUwIBaQ7tSij6odZc8k4B9oB0dYMlz2v1YX/a14CDZEt5yD0mUMTEK9FE33e8GVSqga3qNZlIa3oNOBe8VDERhXmL4S8uLpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568823; c=relaxed/simple;
	bh=P0sHJjFfGC5bNj/gGFqw8qYiSCQ4xXA9OJDApx5eguA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q652JQfSh6++1EM2yW3UbFhMUTAA/l+yRdYcnKBongCm9TsfCqLRdcatf/6U9Uc1YkMxpAuLS8OirOfuTwG5sLgwtoD3GEcOF2kDJo1Uh+EKCQydgkmN1BT4+yNRbRCGFOMga4AL+g7uDUlg8b/R/0uqofrMI5DdN0nTKJRXdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVi+i895; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVi+i895"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752568819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Gl9+pDatxJuichDzbCaXPJdOmvYtSIfyGLs9QTzgcI=;
	b=jVi+i8958dt70Dpl0vNU4MprUCJHb1cWeXV4KJt0eNbMt6PDg41Kqg7b7K/1ize7ED+2fJ
	0R/LyLBv+GmOZEuAUqsbZAP4A3LWxALKRCRaEWKaxP2ywrj0yZY9YkEjSYGuhcuVINEHwi
	s+ys7D/GmvK3epeDXsu/Z+69hM2Vkdo=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ozkZsaIeNGaZdLmT2x2Fkw-1; Tue, 15 Jul 2025 04:40:18 -0400
X-MC-Unique: ozkZsaIeNGaZdLmT2x2Fkw-1
X-Mimecast-MFC-AGG-ID: ozkZsaIeNGaZdLmT2x2Fkw_1752568818
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-532f90a1cadso6433844e0c.1
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 01:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752568818; x=1753173618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gl9+pDatxJuichDzbCaXPJdOmvYtSIfyGLs9QTzgcI=;
        b=F2kZShNUb7P+M+2iRnzAAcZ7nZr5qC8M3JmBu26YSj6Ro05qTbdviG2BLSvPTNTllD
         4dvx85Vmt0VYtv5bdajD0S/6vI3BDWyNRCUGqqxTir68OxGiEOhG6v+mpN1rDk+s/jn1
         8e9nQvDNo5g4U5BZQHzmsk79AkzAbvbYuFf7SuVEJyHP6FTO+IvlXa5+hH+NuqVOOZc6
         ZjkYjb+EkK2rnQsSnth28/+ipa3U2GYS2+KEzFTt3twVHPr6OEO06rFvJYtZB0TjhNRU
         ez563OQ9NPTQ7cAfrQKonDNWiO1I/98Vus84y2kG9/teZkeRBtTS3R53H2rlie6DrgY9
         I28w==
X-Forwarded-Encrypted: i=1; AJvYcCXdXQBxeW47uCp1guAsYCzr13htCc0Mxn5l5FG338QCKHcLzaSm+tES/upM1uSdt+2jBnSqKJ12MCazAVZP3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdBwlKtZTaaeNeRhF6tHsA6auipm90IB0aEbX8mZfR4gl+/mdG
	+A466aNqi8/42AAt8D4b8P2HBYs+RiwjGn5SiVS748UT0z70SaqVJwKK2D2OrBPUgc9l8kqEmhr
	qkdilXnblBGcKpZ7mH2xPNs6AjKombplwgxgs7ltGw4tHFij8LFLcafTLIJNQGGvMuSSd2KKdav
	GthI43nJ48fPCeqBHHdUj+xUC29wMIl6Jr3o1zBdemOEs=
X-Gm-Gg: ASbGncsyRTT6SgVnGAOgYo24IKMsHNL9edBYG6VxckLxRSFSgu6ZFhm5huhw2Qmn9AU
	xRDLzPP8FH1LMuWirPvNFdcKYlpPyYaxe55Pi6XH0ySlv2XLmZezjs7Hxx3oqMt9gRnwemOi5of
	/7AlnXZ00gbbUVT5xsOSOyYQ==
X-Received: by 2002:a05:6122:889a:b0:535:dd55:b6e with SMTP id 71dfb90a1353d-5372ef69b35mr831546e0c.4.1752568818087;
        Tue, 15 Jul 2025 01:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlxd2wmXGdo/wP+JhFssW9FryXQD4J7oYbo7D4FkAdq2sXcp6dwqK3sCMPidEYnu3rJEtRlCoV19EcpKU1HqY=
X-Received: by 2002:a05:6122:889a:b0:535:dd55:b6e with SMTP id
 71dfb90a1353d-5372ef69b35mr831544e0c.4.1752568817637; Tue, 15 Jul 2025
 01:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADZSLS3WYUHJFhQx786Fbxz=8JredK+XxtZAeLzp3XWaOGnZRw@mail.gmail.com>
 <CACGkMEtza2ey3JJhFcq4p6cJ-O4CPA9sC8mK0Twv25F-6eWGNQ@mail.gmail.com>
 <CACLfguXzJM+TB_fm=BmK9kphsg_OdRpmmreeyFuo62Bjp4wQFg@mail.gmail.com> <CADZSLS3Wm08UZuScuJ1Pa4vLQ+6bzk73NQaVt-ALjen1pvSJtQ@mail.gmail.com>
In-Reply-To: <CADZSLS3Wm08UZuScuJ1Pa4vLQ+6bzk73NQaVt-ALjen1pvSJtQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Jul 2025 16:39:40 +0800
X-Gm-Features: Ac12FXxnqEU1vfIX5ZY1pRD2iSvktDrb8rbgAKI-rcn9IOaxXW23KP0rKlRrZY8
Message-ID: <CACLfguXypcPC50yhcXGjYLj+JagXxtkdK4_P35x__QqwqkO3-A@mail.gmail.com>
Subject: Re: Failure to create vp_vdpa device with enabled feature provisioning
To: Wenli Quan <wquan@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "S. Tsirkin, Michael" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ENjm3uJjhXDsKdXu8HIbaLrwQhk6tDbdIAlgYwL41t8_1752568818
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Wenli Quan <wquan@redhat.com> wrote=
:
>
> On Tue, Jul 15, 2025 at 9:35=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
> >
> > Hi Wenli,
> >
> > Could you please provide more details regarding the following:
> >
> > > \[ 84.703574\] vp-vdpa 0000:01:00.0: Failed to register to vdpa bus
> > >
> > > kernel answers: File exists
> > >
> > > # vdpa dev del vdpa0
> >
> > I suspect the device wasn't created successfully. Could it be that a
> > vdpa0 already existed before you tried to create one?
>
> It existed vdpa0 before being removed. btw, to reproduce it, it's
> needed to operate twice for creating the vdpa0 device, then to remove
> it.
>
> # vdpa -jp dev config show vdpa0
> {
> Error: vdpa: device not found.
> kernel answers: No such device
>     "config": {}
> }
>
> After first creating the vdpa0.
> #  vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features
> 0x1
> #  vdpa -jp dev config show vdpa0
> {
>     "config": {
>         "vdpa0": {}
>     }
> }
> # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features 0x1
> [  188.690040] vp-vdpa 0000:01:00.0: Failed to register to vdpa bus
> kernel answers: File exists
> # vdpa dev del vdpa0
>
> Then Call Trace happened.
>
> Best Regards, wenli
>
thanks Wenli. I will check this
thanks
cindy

> > Thanks,
> > Cindy
> >
> > On Tue, Jul 15, 2025 at 9:19=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > Adding Cindy for help here.
> > >
> > > On Mon, Jul 14, 2025 at 9:18=E2=80=AFPM Wenli Quan <wquan@redhat.com>=
 wrote:
> > > >
> > > > Hello all:
> > > >
> > > > I am encountering an issue when creating a vp_vdpa device with feat=
ure provisioning enabled.
> > > >
> > > > In the vm:
> > > >
> > > > # uname -r
> > > > 6.16.0-rc2+
> > > >
> > > > # cd /sys/bus/pci/drivers/virtio-pci/
> > > >
> > > > # echo 0000:01:00.0 > unbind
> > > >
> > > > # modprobe vp_vdpa
> > > >
> > > > # cd ../vp-vdpa/
> > > >
> > > > # echo "1af4 1041" > new_id
> > > >
> > > > # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features =
0x1
> > > >
> > > > # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features =
0x1
> > > >
> > > > [   84.703574] vp-vdpa 0000:01:00.0: Failed to register to vdpa bus
> > > >
> > > > kernel answers: File exists
> > > >
> > > > # vdpa dev del vdpa0
> > > >
> > > >
> > > > [  194.055148] BUG: kernel NULL pointer dereference, address: 00000=
000000000d0
> > > >
> > > > [  194.055698] #PF: supervisor read access in kernel mode
> > > >
> > > > [  194.056100] #PF: error_code(0x0000) - not-present page
> > > >
> > > > [  194.056497] PGD 7c7e067 P4D 0
> > > >
> > > > [  194.056739] Oops: Oops: 0000 [#1] SMP
> > > >
> > > > [  194.057040] CPU: 0 UID: 0 PID: 13582 Comm: vdpa Not tainted 6.16=
.0-rc2+ #6 PREEMPT(voluntary)
> > > >
> > > > [  194.057697] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-=
2.el9_6.1 11/17/2024
> > > >
> > > > [  194.058299] RIP: 0010:device_del+0x40/0x480
> > > >
> > > > [  194.058623] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f 40 4=
c 89 e7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48 8b 5=
5 48 <0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00 4c 89
> > > >
> > > > [  194.060031] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
> > > >
> > > > [  194.060436] RAX: 0000000000000000 RBX: ff110000089f1720 RCX: fff=
fffffa05f2200
> > > >
> > > > [  194.060976] RDX: 0000000000000000 RSI: ff11000018296800 RDI: ff1=
1000018297080
> > > >
> > > > [  194.061510] RBP: ff11000018297000 R08: ff1100000a3ea048 R09: ffa=
00000004dbc50
> > > >
> > > > [  194.062051] R10: ff11000006abae00 R11: 0000000000000026 R12: ff1=
1000018297080
> > > >
> > > > [  194.062586] R13: ff1100000571c300 R14: ffa00000004dbc50 R15: 000=
0000000000000
> > > >
> > > > [  194.063132] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(0000=
) knlGS:0000000000000000
> > > >
> > > > [  194.063748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >
> > > > [  194.064189] CR2: 00000000000000d0 CR3: 0000000007830004 CR4: 000=
0000000773ef0
> > > >
> > > > [  194.064722] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > >
> > > > [  194.065258] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000=
0000000000400
> > > >
> > > > [  194.065813] PKRU: 55555554
> > > >
> > > > [  194.066022] Call Trace:
> > > >
> > > > [  194.066240]  <TASK>
> > > >
> > > > [  194.066418]  device_unregister+0x12/0x30
> > > >
> > > > [  194.066724]  vp_vdpa_dev_del+0x16/0x20 [vp_vdpa]
> > > >
> > > > [  194.067078]  vdpa_nl_cmd_dev_del_set_doit+0x67/0xe0 [vdpa]
> > > >
> > > > [  194.067497]  genl_family_rcv_msg_doit+0xd2/0x120
> > > >
> > > > [  194.067863]  genl_rcv_msg+0x182/0x2b0
> > > >
> > > > [  194.068160]  ? vdpa_nl_cmd_dev_get_dumpit+0xa0/0xa0 [vdpa]
> > > >
> > > > [  194.068594]  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
> > > >
> > > > [  194.068971]  netlink_rcv_skb+0x57/0x100
> > > >
> > > > [  194.069270]  genl_rcv+0x28/0x40
> > > >
> > > > [  194.069515]  netlink_unicast+0x278/0x3a0
> > > >
> > > > [  194.069828]  netlink_sendmsg+0x1e7/0x420
> > > >
> > > > [  194.070134]  __sock_sendmsg+0x38/0x60
> > > >
> > > > [  194.070414]  ? move_addr_to_kernel.part.0+0x1b/0x60
> > > >
> > > > [  194.070794]  __sys_sendto+0x115/0x170
> > > >
> > > > [  194.071086]  ? __sys_recvmsg+0x6a/0xc0
> > > >
> > > > [  194.071378]  __x64_sys_sendto+0x24/0x30
> > > >
> > > > [  194.071674]  do_syscall_64+0x59/0x1f0
> > > >
> > > > [  194.071963]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > >
> > > > [  194.072347] RIP: 0033:0x7f03a6ba7dea
> > > >
> > > > [  194.072625] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 0=
0 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> > > >
> > > > [  194.074021] RSP: 002b:00007ffceb0ebeb8 EFLAGS: 00000246 ORIG_RAX=
: 000000000000002c
> > > >
> > > > [  194.074610] RAX: ffffffffffffffda RBX: 00005646e0680350 RCX: 000=
07f03a6ba7dea
> > > >
> > > > [  194.075154] RDX: 0000000000000020 RSI: 00005646e0680350 RDI: 000=
0000000000003
> > > >
> > > > [  194.075699] RBP: 00005646e06802a0 R08: 00007f03a6cae200 R09: 000=
000000000000c
> > > >
> > > > [  194.076455] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
> > > >
> > > > [  194.077197] R13: 0000000000000000 R14: 00007ffceb0ec75d R15: 000=
0000000000064
> > > >
> > > > [  194.077944]  </TASK>
> > > >
> > > > [  194.078321] Modules linked in: vp_vdpa vdpa kvm_intel kvm irqbyp=
ass fuse configfs xfs virtio_net net_failover failover virtio_pci virtio_pc=
i_legacy_dev virtio_pci_modern_dev be2iscsi cxgb3i cxgb3 mdio libcxgbi libc=
xgb iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4
> > > >
> > > > [  194.080556] CR2: 00000000000000d0
> > > >
> > > > [  194.081040] ---[ end trace 0000000000000000 ]---
> > > >
> > > > [  194.660537] RIP: 0010:device_del+0x40/0x480
> > > >
> > > > [  194.662514] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f 40 4=
c 89 e7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48 8b 5=
5 48 <0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00 4c 89
> > > >
> > > > [  194.664367] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
> > > >
> > > > [  194.664996] RAX: 0000000000000000 RBX: ff110000089f1720 RCX: fff=
fffffa05f2200
> > > >
> > > > [  194.665760] RDX: 0000000000000000 RSI: ff11000018296800 RDI: ff1=
1000018297080
> > > >
> > > > [  194.666527] RBP: ff11000018297000 R08: ff1100000a3ea048 R09: ffa=
00000004dbc50
> > > >
> > > > [  194.667300] R10: ff11000006abae00 R11: 0000000000000026 R12: ff1=
1000018297080
> > > >
> > > > [  194.668066] R13: ff1100000571c300 R14: ffa00000004dbc50 R15: 000=
0000000000000
> > > >
> > > > [  194.668823] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(0000=
) knlGS:0000000000000000
> > > >
> > > > [  194.669653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >
> > > > [  194.670322] CR2: 00000000000000d0 CR3: 0000000007830004 CR4: 000=
0000000773ef0
> > > >
> > > > [  194.671083] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
> > > >
> > > > [  194.671845] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000=
0000000000400
> > > >
> > > > [  194.672607] PKRU: 55555554
> > > >
> > > > [  194.673042] note: vdpa[13582] exited with irqs disabled
> > > >
> > > > Killed
> > > >
> > > >
> > > > Best Regards,
> > > >
> > > >
> > > > wenli
> > >
> > > Thanks
> > >
> >
>


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5119D09C
	for <virtualization@lists.linux.dev>; Wed, 16 Jul 2025 02:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752634025; cv=none; b=kDLX0iAvy7S9FjYg6pu3zxEM/PeYbFC214DJbImzWsULKXp6FtE8e/QcOKW89KzcZhHs8eSxp368j4Tt66TAdq+UyckfEpo6t5GjZi4JYYUdBCT12BHaSwpHwMPTCEhjBVN0pc0iNSg/5qHOIRr+wNV97r/blSnt8EOQaFpjZDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752634025; c=relaxed/simple;
	bh=k2NFFFwBjAOf5EKIJ+8wy9UTf0Qcxqn2XW7ABzZoEfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oogDzUAnifn5JoTgDWEgpt5oYUmYDGcY3OwE29TIjDH4G6ylT10sLDaSmhYEgMMcKslBCjCZlp4J34To24LLHc4jpQBF2sKOjhp2iAHfo1Xs1ZWDY0hYf+gu4yknE8xuq7dFY2o5tqLTzc4ITfiBloKbmRyPhUaTH6TfP6dMttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U42guR9M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U42guR9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752634020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8/iQTIPbU0FNMAJkvvQmaYYlrpxp/sYu4IodaBeK2c=;
	b=U42guR9Mx9Xz1u8F9LF9hfz6ym5gXWTnNFTxqFNmyUsayGlLe+HPlw8ThseryBvnLsBy0+
	FrV4mHIzBdoCcmBjJG3DJOKZ661AhsdS7tzMj8627vr3+AzCFRtgFIw6nIqTOzHXFoBG4V
	xztuRyy6j2/B5JyThlnsnbF8zU+O7dE=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-1LmVhnRPMjeZzNx1APy_cg-1; Tue, 15 Jul 2025 22:46:57 -0400
X-MC-Unique: 1LmVhnRPMjeZzNx1APy_cg-1
X-Mimecast-MFC-AGG-ID: 1LmVhnRPMjeZzNx1APy_cg_1752634017
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-87ece544f24so475376241.0
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 19:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752634017; x=1753238817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8/iQTIPbU0FNMAJkvvQmaYYlrpxp/sYu4IodaBeK2c=;
        b=V+/S2HPqzxOZ02Uu8hu0TLCpk2uvQqtZKrDAuNtqgz0BvRL+SrZhAnYwRGS7Gxkj+H
         +Jj5p4rsf4TvC5+2XaFkE1gnQEUjLd3QV8gTysXOP6XKqO8fE1do0LZaJmV/b16QLoD/
         Ls4EO/DwjyufN5d8wdRlFrQzUoWgiqVhQOX8453ZGI9T3isguNprrSBeUO+M8FQEAFd5
         kN7PKehUTjZ+A0atI+0tr3uKxxyclEum8jlFm+DT1BQtPx0P82kf3THvFhkPLHwZ7mP3
         vDnlOtsO0vYlZHDfamkbqF5zrFUF0dyx4h6uzS3lOEcIsQP9cL3W2w/KlQciDc8m4nDs
         yIaw==
X-Forwarded-Encrypted: i=1; AJvYcCVqtSNcvzf69N7xc1w66ExuAi0go6KQs2ytXiGE6LuT1DlTWi2T/4AqxbnOQ4xNxyXnYLhbkMVBgU8NzjwINA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6YZDUPnp9F12NJPrPlpDrz/3IgrxhADGL2doDJ3ioRYmKi6y/
	HQ849pTeYdI6+FO250wfTGcFb9y0mx0STn9nQ2X9AGZR9UiRvlP33VnzV6LUYqjUxd6hNcgrnpH
	KoPuahZ22V7Zo0fdUUB2QKPRHT6fNhVU65IdTlN3SSDekDDWTEZajt2mQu8VaAWnVNoIkJz/G73
	r6fguGOAtNxSA/Zr+j0ZJTJ9oAbBoqHXvKIHsUA4S0BhU=
X-Gm-Gg: ASbGncs9CIlEkWcgxxtjZ0jDdvEDaVMvlVoj8ssUBEkz+mCINcChX5NgAHMIf5sdEu9
	vARlUdmdk76uow5k48emXTB/OZXBSgSEXlpyyu1M8YkkY8sPyVw49IYzBRUVIJqRPkq2O4RW7ZK
	V1WQzNsh6eBahayfb5kE4kIg==
X-Received: by 2002:a05:6102:2d0c:b0:4ec:e1fa:ed7b with SMTP id ada2fe7eead31-4f8900ae907mr847831137.9.1752634016684;
        Tue, 15 Jul 2025 19:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdq2DCZWvufO3kU5vO4MXGf8+qfZ4VtirElLMCH31v0yrleW4EVWo4pTXTA2Z9HwIUFt6W4sY3xmmko7u7F74=
X-Received: by 2002:a05:6102:2d0c:b0:4ec:e1fa:ed7b with SMTP id
 ada2fe7eead31-4f8900ae907mr847822137.9.1752634016202; Tue, 15 Jul 2025
 19:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADZSLS3WYUHJFhQx786Fbxz=8JredK+XxtZAeLzp3XWaOGnZRw@mail.gmail.com>
 <CACGkMEtza2ey3JJhFcq4p6cJ-O4CPA9sC8mK0Twv25F-6eWGNQ@mail.gmail.com>
 <CACLfguXzJM+TB_fm=BmK9kphsg_OdRpmmreeyFuo62Bjp4wQFg@mail.gmail.com>
 <CADZSLS3Wm08UZuScuJ1Pa4vLQ+6bzk73NQaVt-ALjen1pvSJtQ@mail.gmail.com>
 <CACLfguXypcPC50yhcXGjYLj+JagXxtkdK4_P35x__QqwqkO3-A@mail.gmail.com> <CACLfguW4ByjHuaeXYygj2_n7yd82rhk8w63_k3gDXmO6WYzajg@mail.gmail.com>
In-Reply-To: <CACLfguW4ByjHuaeXYygj2_n7yd82rhk8w63_k3gDXmO6WYzajg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 16 Jul 2025 10:46:17 +0800
X-Gm-Features: Ac12FXwVfAu3SpwPii5V1TbrJwxOd1kQWgGibrrfUCEh-zWA2p5uOizrTplqR9c
Message-ID: <CACLfguVOuvfwNHyx8oh4jN-dr4LCvgnYVK1b3=F2DZMKqXKNZQ@mail.gmail.com>
Subject: Re: Failure to create vp_vdpa device with enabled feature provisioning
To: Wenli Quan <wquan@redhat.com>, Yanhui Ma <yama@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "S. Tsirkin, Michael" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8dFVNl6HQ9CNhJzU2VzZ9KJkDy_gYy8y7iTfisdq4N4_1752634017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 also include PO Yanhui Ma in the loop to track this issue.

On Wed, Jul 16, 2025 at 10:41=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> Hi   Wenli
>
> I'm able to reproduce this issue on the latest kernel. Could you
> please filing a Jira ticket for it?
>
> thanks
> cindy
>
> On Tue, Jul 15, 2025 at 4:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 3:17=E2=80=AFPM Wenli Quan <wquan@redhat.com> w=
rote:
> > >
> > > On Tue, Jul 15, 2025 at 9:35=E2=80=AFAM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > Hi Wenli,
> > > >
> > > > Could you please provide more details regarding the following:
> > > >
> > > > > \[ 84.703574\] vp-vdpa 0000:01:00.0: Failed to register to vdpa b=
us
> > > > >
> > > > > kernel answers: File exists
> > > > >
> > > > > # vdpa dev del vdpa0
> > > >
> > > > I suspect the device wasn't created successfully. Could it be that =
a
> > > > vdpa0 already existed before you tried to create one?
> > >
> > > It existed vdpa0 before being removed. btw, to reproduce it, it's
> > > needed to operate twice for creating the vdpa0 device, then to remove
> > > it.
> > >
> > > # vdpa -jp dev config show vdpa0
> > > {
> > > Error: vdpa: device not found.
> > > kernel answers: No such device
> > >     "config": {}
> > > }
> > >
> > > After first creating the vdpa0.
> > > #  vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features
> > > 0x1
> > > #  vdpa -jp dev config show vdpa0
> > > {
> > >     "config": {
> > >         "vdpa0": {}
> > >     }
> > > }
> > > # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features 0x=
1
> > > [  188.690040] vp-vdpa 0000:01:00.0: Failed to register to vdpa bus
> > > kernel answers: File exists
> > > # vdpa dev del vdpa0
> > >
> > > Then Call Trace happened.
> > >
> > > Best Regards, wenli
> > >
> > thanks Wenli. I will check this
> > thanks
> > cindy
> >
> > > > Thanks,
> > > > Cindy
> > > >
> > > > On Tue, Jul 15, 2025 at 9:19=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > Adding Cindy for help here.
> > > > >
> > > > > On Mon, Jul 14, 2025 at 9:18=E2=80=AFPM Wenli Quan <wquan@redhat.=
com> wrote:
> > > > > >
> > > > > > Hello all:
> > > > > >
> > > > > > I am encountering an issue when creating a vp_vdpa device with =
feature provisioning enabled.
> > > > > >
> > > > > > In the vm:
> > > > > >
> > > > > > # uname -r
> > > > > > 6.16.0-rc2+
> > > > > >
> > > > > > # cd /sys/bus/pci/drivers/virtio-pci/
> > > > > >
> > > > > > # echo 0000:01:00.0 > unbind
> > > > > >
> > > > > > # modprobe vp_vdpa
> > > > > >
> > > > > > # cd ../vp-vdpa/
> > > > > >
> > > > > > # echo "1af4 1041" > new_id
> > > > > >
> > > > > > # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_featu=
res 0x1
> > > > > >
> > > > > > # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_featu=
res 0x1
> > > > > >
> > > > > > [   84.703574] vp-vdpa 0000:01:00.0: Failed to register to vdpa=
 bus
> > > > > >
> > > > > > kernel answers: File exists
> > > > > >
> > > > > > # vdpa dev del vdpa0
> > > > > >
> > > > > >
> > > > > > [  194.055148] BUG: kernel NULL pointer dereference, address: 0=
0000000000000d0
> > > > > >
> > > > > > [  194.055698] #PF: supervisor read access in kernel mode
> > > > > >
> > > > > > [  194.056100] #PF: error_code(0x0000) - not-present page
> > > > > >
> > > > > > [  194.056497] PGD 7c7e067 P4D 0
> > > > > >
> > > > > > [  194.056739] Oops: Oops: 0000 [#1] SMP
> > > > > >
> > > > > > [  194.057040] CPU: 0 UID: 0 PID: 13582 Comm: vdpa Not tainted =
6.16.0-rc2+ #6 PREEMPT(voluntary)
> > > > > >
> > > > > > [  194.057697] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241=
117-2.el9_6.1 11/17/2024
> > > > > >
> > > > > > [  194.058299] RIP: 0010:device_del+0x40/0x480
> > > > > >
> > > > > > [  194.058623] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f =
40 4c 89 e7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48 =
8b 55 48 <0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00 4c 8=
9
> > > > > >
> > > > > > [  194.060031] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
> > > > > >
> > > > > > [  194.060436] RAX: 0000000000000000 RBX: ff110000089f1720 RCX:=
 ffffffffa05f2200
> > > > > >
> > > > > > [  194.060976] RDX: 0000000000000000 RSI: ff11000018296800 RDI:=
 ff11000018297080
> > > > > >
> > > > > > [  194.061510] RBP: ff11000018297000 R08: ff1100000a3ea048 R09:=
 ffa00000004dbc50
> > > > > >
> > > > > > [  194.062051] R10: ff11000006abae00 R11: 0000000000000026 R12:=
 ff11000018297080
> > > > > >
> > > > > > [  194.062586] R13: ff1100000571c300 R14: ffa00000004dbc50 R15:=
 0000000000000000
> > > > > >
> > > > > > [  194.063132] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(=
0000) knlGS:0000000000000000
> > > > > >
> > > > > > [  194.063748] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > > > > >
> > > > > > [  194.064189] CR2: 00000000000000d0 CR3: 0000000007830004 CR4:=
 0000000000773ef0
> > > > > >
> > > > > > [  194.064722] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> > > > > >
> > > > > > [  194.065258] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:=
 0000000000000400
> > > > > >
> > > > > > [  194.065813] PKRU: 55555554
> > > > > >
> > > > > > [  194.066022] Call Trace:
> > > > > >
> > > > > > [  194.066240]  <TASK>
> > > > > >
> > > > > > [  194.066418]  device_unregister+0x12/0x30
> > > > > >
> > > > > > [  194.066724]  vp_vdpa_dev_del+0x16/0x20 [vp_vdpa]
> > > > > >
> > > > > > [  194.067078]  vdpa_nl_cmd_dev_del_set_doit+0x67/0xe0 [vdpa]
> > > > > >
> > > > > > [  194.067497]  genl_family_rcv_msg_doit+0xd2/0x120
> > > > > >
> > > > > > [  194.067863]  genl_rcv_msg+0x182/0x2b0
> > > > > >
> > > > > > [  194.068160]  ? vdpa_nl_cmd_dev_get_dumpit+0xa0/0xa0 [vdpa]
> > > > > >
> > > > > > [  194.068594]  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
> > > > > >
> > > > > > [  194.068971]  netlink_rcv_skb+0x57/0x100
> > > > > >
> > > > > > [  194.069270]  genl_rcv+0x28/0x40
> > > > > >
> > > > > > [  194.069515]  netlink_unicast+0x278/0x3a0
> > > > > >
> > > > > > [  194.069828]  netlink_sendmsg+0x1e7/0x420
> > > > > >
> > > > > > [  194.070134]  __sock_sendmsg+0x38/0x60
> > > > > >
> > > > > > [  194.070414]  ? move_addr_to_kernel.part.0+0x1b/0x60
> > > > > >
> > > > > > [  194.070794]  __sys_sendto+0x115/0x170
> > > > > >
> > > > > > [  194.071086]  ? __sys_recvmsg+0x6a/0xc0
> > > > > >
> > > > > > [  194.071378]  __x64_sys_sendto+0x24/0x30
> > > > > >
> > > > > > [  194.071674]  do_syscall_64+0x59/0x1f0
> > > > > >
> > > > > > [  194.071963]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> > > > > >
> > > > > > [  194.072347] RIP: 0033:0x7f03a6ba7dea
> > > > > >
> > > > > > [  194.072625] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f =
1f 00 f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 =
00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 8=
9
> > > > > >
> > > > > > [  194.074021] RSP: 002b:00007ffceb0ebeb8 EFLAGS: 00000246 ORIG=
_RAX: 000000000000002c
> > > > > >
> > > > > > [  194.074610] RAX: ffffffffffffffda RBX: 00005646e0680350 RCX:=
 00007f03a6ba7dea
> > > > > >
> > > > > > [  194.075154] RDX: 0000000000000020 RSI: 00005646e0680350 RDI:=
 0000000000000003
> > > > > >
> > > > > > [  194.075699] RBP: 00005646e06802a0 R08: 00007f03a6cae200 R09:=
 000000000000000c
> > > > > >
> > > > > > [  194.076455] R10: 0000000000000000 R11: 0000000000000246 R12:=
 0000000000000000
> > > > > >
> > > > > > [  194.077197] R13: 0000000000000000 R14: 00007ffceb0ec75d R15:=
 0000000000000064
> > > > > >
> > > > > > [  194.077944]  </TASK>
> > > > > >
> > > > > > [  194.078321] Modules linked in: vp_vdpa vdpa kvm_intel kvm ir=
qbypass fuse configfs xfs virtio_net net_failover failover virtio_pci virti=
o_pci_legacy_dev virtio_pci_modern_dev be2iscsi cxgb3i cxgb3 mdio libcxgbi =
libcxgb iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4
> > > > > >
> > > > > > [  194.080556] CR2: 00000000000000d0
> > > > > >
> > > > > > [  194.081040] ---[ end trace 0000000000000000 ]---
> > > > > >
> > > > > > [  194.660537] RIP: 0010:device_del+0x40/0x480
> > > > > >
> > > > > > [  194.662514] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f =
40 4c 89 e7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48 =
8b 55 48 <0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00 4c 8=
9
> > > > > >
> > > > > > [  194.664367] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
> > > > > >
> > > > > > [  194.664996] RAX: 0000000000000000 RBX: ff110000089f1720 RCX:=
 ffffffffa05f2200
> > > > > >
> > > > > > [  194.665760] RDX: 0000000000000000 RSI: ff11000018296800 RDI:=
 ff11000018297080
> > > > > >
> > > > > > [  194.666527] RBP: ff11000018297000 R08: ff1100000a3ea048 R09:=
 ffa00000004dbc50
> > > > > >
> > > > > > [  194.667300] R10: ff11000006abae00 R11: 0000000000000026 R12:=
 ff11000018297080
> > > > > >
> > > > > > [  194.668066] R13: ff1100000571c300 R14: ffa00000004dbc50 R15:=
 0000000000000000
> > > > > >
> > > > > > [  194.668823] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(=
0000) knlGS:0000000000000000
> > > > > >
> > > > > > [  194.669653] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3
> > > > > >
> > > > > > [  194.670322] CR2: 00000000000000d0 CR3: 0000000007830004 CR4:=
 0000000000773ef0
> > > > > >
> > > > > > [  194.671083] DR0: 0000000000000000 DR1: 0000000000000000 DR2:=
 0000000000000000
> > > > > >
> > > > > > [  194.671845] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:=
 0000000000000400
> > > > > >
> > > > > > [  194.672607] PKRU: 55555554
> > > > > >
> > > > > > [  194.673042] note: vdpa[13582] exited with irqs disabled
> > > > > >
> > > > > > Killed
> > > > > >
> > > > > >
> > > > > > Best Regards,
> > > > > >
> > > > > >
> > > > > > wenli
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > >


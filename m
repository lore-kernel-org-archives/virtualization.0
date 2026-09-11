Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAFF377EB2
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789140301; cv=pass; b=CgOv0xfpoZPf2ng5mHQ2nI4rIrrpwijPVngYcO/2w0daACbOzB4e5RwMB2UtXfy/uRH9W44YYODroF2prLGF5243gGDHkKjXiCY+UbVlnEAtVJaC5/l3LegQNjzxkki4qBNi5NI+D35oCAK8YApgWXOTMAucXk++NfiFGgfHuLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789140301; c=relaxed/simple;
	bh=xDWi/RZi/GTWLczs7whmwRvdWiTG44QFNeXa2IJ/bfU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a9jk0R/wJVbMNpzjYJKl+EFKeUXJERWFbK+Ui8HSGNcURt28pL6YnLk0p6QpawfiU8VN7zGa6mMwV4pERHhX0iIickmmqaSo4hOrIDXG/w1tlMJILOErvvcY6ysoS5DHgnMoeDfRBQUPoVMJshqnGlGlngpbV5Fs9PvHPRL9hXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=I+Itr9/d; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="I+Itr9/d"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso10742375ad.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789140298; cv=none;
        d=google.com; s=arc-20260327;
        b=gZ88wTbpC6JXrDRAPbqlbsOvopjmhUxFwCiDs87zcr9KfuOZKknMF0omyjp0p0KOSC
         3yKFgSn3lEox0qiebmwH8agzHKuDoaiwsDx1XA/cWWkWjm+avgVqLp/U+KzO+0sr/xba
         SjpQk9lkz0XQv3TzMPGwdXAYQ8hfB5egFRA3HMWR30kYyFOEaZFih8OgYsstp1T79XdA
         3PmI88c29pyomXclnBwIssHtsk/McXinziYYc4W8UtndjzZMdTEQHNP93B/EircrKgGN
         nQvPIgt/NUkq6eXwy0V6jlu87CWB6BJs7CzOMj0NVdumFHS79mc8JHlOQaJ9YJFZuEE5
         k9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=skCAfLufen5Yw1JfeofNgsochbiKsowFvCVmjb6lwQ8=;
        fh=B7BhmleNdDcAjzuM495eD2hurSqav68Rx6j9hSeh/m0=;
        b=K7Mm7xm9dEVUOPotXg6p6QoK3RQ5InWRT40oSUMxy/LAQxBf20ZlBwCeqrYm0kAjEC
         IXH0lkJ0G2deU8QN63M5oOWosTTcEHqsv3kyYv6XLSiYLNvry1uftljs1qwqhXi26Wpr
         9fgAGh+jL6VVyXCFkgwMnIn13rx9flUAy8iXR3ONZ45+ncbDDMJcd9P6u0DFr54h42xO
         GjS1+2Sg3GShzv0QpgVIL+QYfowa4QdyvHorWvHx8aPQpok+louYyxoJCng85Jzr4zni
         ZumlvzBHXnupe072WuuF5ONsIhBsotTwefF6Dzi7++bu6riVHPl0VYi+Hm6d3ZpL1LNu
         IY3A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1789140298; x=1789745098; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=skCAfLufen5Yw1JfeofNgsochbiKsowFvCVmjb6lwQ8=;
        b=I+Itr9/dZs86welvRzhQoF3iBPESB762k+uWew5O6KwuY8VHpfOxVZ3Y28eCWjcBeJ
         7MxZFSuE30/TcJ3AvF6Jsy+1m4PTDqZvwZ2MBu70CGsXNaLCFisftuwiE1XAtyUvIAg0
         n6GVGRtv838ZlqSp5z2ddFK8/E4+GuowBVATWYFx3vdvsTSuwpd0Z4R/WcUoSetr51m0
         dBkw7Uu5uP0sm805m/VjM/4Xu8on3Crw1neMe6wkfeDUF/diyNLxWdA88lywsX2V/YCd
         UEhQ9ptSWJygtYK0wX6zCGqgPkX36LTmq3NkYbxMfZJOfJ/Jt+OkdPrjzlW7HFPCm/2V
         //FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789140298; x=1789745098;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=skCAfLufen5Yw1JfeofNgsochbiKsowFvCVmjb6lwQ8=;
        b=Em/rqejxi56c04/GXXDb3BVF6ScRZzzSTfX2iDrv3/SnV9g1XSDu36+6Ynm4wMtLi4
         dCqdgVqp9WFYnp8hX7KKwZhMA+jWWVH6ty7t+fNrzrzUWMshZfIH8JDiaqNfm6uTLFkL
         TmGAM4f7RGxZDIRtFBvIJA3Jpvxz1cfri3+lIwOHkaAMa9vLr1UpGSbp2E+Kwb6tCYv2
         NpsUsw99LjgnNd72uzOfC45CggEeGS9yhOzkZdgIamAwmpQM5bM7Y78eNA7I6dH5p6nL
         9VEKSJfc3fnrhu9J5dlXD0A9ec2KmV1P5UfcqCV3334zCZeqnencV7s6oYCPIzMGOiJ9
         tz1A==
X-Forwarded-Encrypted: i=1; AKwUvBxqtsj9Z3/PBrGkh3QMBCdijqVBpsgkVc9j0bupNIUY8A++Mlo3R/WC8h7zMSRemNmLHTMHCpsNe0sz34b9Gw==@lists.linux.dev
X-Gm-Message-State: AFuF++k/cWhWDlNPKTyQ3LRkd2bFzt223OXSyMyPhRkwvkKpl+YOe/77
	hPdRkRDyojfNBCyEjd0G3vP7t9EV5T8ttgf5aXFJu3xYQLWbLiytqW/xvd4PjpQb4Nxs3Rz7fRc
	DpDVc3xkBBMoUgzOec6dXF2OLEtgRXVGFgma4sF0Imi3Nnmkq4JrTf7+kgbTMzg==
X-Gm-Gg: AYBFou0oUvz+vaOTMQByKE9kkayQp27uFIGNqU568gwanBgr4rJM+S7aVr4ktO60gJY
	ty61nhHEY7qvoDLltjx0bQzM2TyNJ6AY/+GDJwLMRt2dGsHL8sN2a7ZIxRKgVbT1FrMAimFPLcv
	mKs4/1cmIhxtltun1qMQKWrhvZNUY0sQo29qxXIbXMBYxr12DMsFB3r1qgIRRL+J/2V890IxRY1
	eRxrgJJIZ0FTpGKYMbnCZv4qHoUrf8k9oCJXeWEf4BOilhIvAHtbw/Y4nbxhIUK66jpEZXgnP3z
	hpjeqwqXSnF6zCBnqXWswFMhCzbSQjH3x+iQO9G9+3Steqo1PdydDXMSr31yzV13UkMGTkax26y
	PXzEgK2Nn8ikiTCZgDpq08j+Lv3U94uI51EaYJNfwxw3HFN09yARnrMm6wC3sAZv09+aeE0U0F/
	Vc
X-Received: by 2002:a17:902:f610:b0:2dd:64:12ac with SMTP id
 d9443c01a7336-2dd2a343053mr116475975ad.11.1789140297100; Fri, 11 Sep 2026
 08:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Fri, 11 Sep 2026 08:24:46 -0700
X-Gm-Features: AcwNN1WEuOS6_nIy1rDr4mHZyww6oNpastWs-YYUC5X4s3ZAAzBxQ-mS_RmPVbc
Message-ID: <CA+0ovCj59CKcTA1DPfA0GhrPphVktjHWkKwQXnXzsdCcxkMc_A@mail.gmail.com>
Subject: [BUG] WARNING: kobject bug in vdpasim_blk_dev_add
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000dd466a065b36af32"

--000000000000dd466a065b36af32
Content-Type: text/plain; charset="UTF-8"

Hello,

Reporting the following crash:
Linux version 7.3.0-rc2 50d05c7c76c96b90462f24debacca971d2e86713
Build Config: UpstreamAppArmorKASAN (KASAN + UBSAN, panic_on_warn=1)

[   43.937539][ T9492] kobject: (ffff888107e94000): attempted to be
registered with empty name!
[   43.937548][ T9492] WARNING: lib/kobject.c:221 at
kobject_add_internal+0x13e/0xd00, CPU#1: repro/9492
[   43.939713][ T9492] Modules linked in:
[   43.940114][ T9492] CPU: 1 UID: 0 PID: 9492 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   43.941058][ T9492] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   43.942114][ T9492] RIP: 0010:kobject_add_internal+0x141/0xd00
[   43.942670][ T9492] Code: e9 da 00 00 00 e8 ff 0f 03 f6 b8 fe ff ff
ff e9 0a 07 00 00 e8 f0 0f 03 f6 eb 05 e8 e9 0f 03 f6 48 8d 3d 72 80
a4 04 48 89 de <67> 48 0f b9 3a b8 ea ff ff ff e9 e5 06 00 00 4c 8d 73
20 4d 89 f5
[   43.945337][ T9492] RSP: 0018:ffffc90007b5f2d8 EFLAGS: 00010293
[   43.945976][ T9492] RAX: ffffffff8bc48c97 RBX: ffff888107e94000
RCX: ffff88802e21a640
[   43.946731][ T9492] RDX: 0000000000000000 RSI: ffff888107e94000
RDI: ffffffff90690d10
[   43.947516][ T9492] RBP: 0000000000000000 R08: ffffc90007b5f3b7
R09: 0000000000000000
[   43.948287][ T9492] R10: ffffc90007b5f3a0 R11: fffff52000f6be77
R12: 1ffff11020fd2800
[   43.949058][ T9492] R13: dffffc0000000000 R14: ffff8881054a19e0
R15: dffffc0000000000
[   43.949825][ T9492] FS:  000000002a38d400(0000)
GS:ffff8881da588000(0000) knlGS:0000000000000000
[   43.950684][ T9492] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.951309][ T9492] CR2: 00000000004b9200 CR3: 000000010a760000
CR4: 0000000000752ef0
[   43.952087][ T9492] PKRU: 55555554
[   43.952441][ T9492] Call Trace:
[   43.952753][ T9492]  <TASK>
[   43.953035][ T9492]  kobject_add+0x163/0x240
[   43.953453][ T9492]  ? __pfx_kobject_add+0x10/0x10
[   43.953907][ T9492]  ? bus_get_dev_root+0x127/0x160
[   43.954415][ T9492]  ? get_device_parent+0x38c/0x3a0
[   43.954916][ T9492]  ? __pfx_klist_children_get+0x10/0x10
[   43.955491][ T9492]  device_add+0x408/0xb90
[   43.955890][ T9492]  vdpasim_blk_dev_add+0x1e2/0x2a0
[   43.956363][ T9492]  ? __pfx_vdpasim_blk_dev_add+0x10/0x10
[   43.956874][ T9492]  ? __pfx_vdpasim_blk_work+0x10/0x10
[   43.957364][ T9492]  ? __pfx_vdpasim_blk_get_config+0x10/0x10
[   43.957899][ T9492]  ? __pfx_vdpasim_blk_free+0x10/0x10
[   43.958391][ T9492]  ? vdpa_mgmtdev_get_from_attr+0x2bb/0x2d0
[   43.958928][ T9492]  vdpa_nl_cmd_dev_add_set_doit+0xa75/0xbc0
[   43.959469][ T9492]  ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10
[   43.960049][ T9492]  ? __nla_parse+0x40/0x60
[   43.960461][ T9492]  ? genl_family_rcv_msg_attrs_parse+0x20b/0x2f0
[   43.961047][ T9492]  ? genl_family_rcv_msg_attrs_parse+0x265/0x2f0
[   43.961643][ T9492]  genl_family_rcv_msg_doit+0x22a/0x330
[   43.962175][ T9492]  ? __asan_memcpy+0x40/0x70
[   43.962625][ T9492]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[   43.963212][ T9492]  ? bpf_lsm_capable+0x9/0x20
[   43.963664][ T9492]  ? security_capable+0x7e/0x2c0
[   43.964157][ T9492]  genl_rcv_msg+0x61c/0x7a0
[   43.964598][ T9492]  ? __pfx_genl_rcv_msg+0x10/0x10
[   43.965086][ T9492]  ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10
[   43.966175][ T9492]  netlink_rcv_skb+0x232/0x4b0
[   43.966616][ T9492]  ? __pfx_genl_rcv_msg+0x10/0x10
[   43.967080][ T9492]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   43.967568][ T9492]  ? down_read+0x2be/0x330
[   43.967979][ T9492]  genl_rcv+0x28/0x40
[   43.968351][ T9492]  netlink_unicast+0x75e/0x8e0
[   43.968797][ T9492]  netlink_sendmsg+0x813/0xb40
[   43.969239][ T9492]  ? __pfx_netlink_sendmsg+0x10/0x10
[   43.969721][ T9492]  ? apparmor_socket_sendmsg+0x95/0x390
[   43.970229][ T9492]  ? __pfx_netlink_sendmsg+0x10/0x10
[   43.970710][ T9492]  sock_sendmsg_nosec+0x13a/0x180
[   43.971174][ T9492]  __sys_sendto+0x408/0x5a0
[   43.971622][ T9492]  ? __pfx___sys_sendto+0x10/0x10
[   43.972114][ T9492]  ? fd_install+0x94/0x3d0
[   43.972543][ T9492]  ? fd_install+0x309/0x3d0
[   43.972982][ T9492]  __x64_sys_sendto+0xde/0x100
[   43.973455][ T9492]  do_syscall_64+0x155/0x510
[   43.973925][ T9492]  ? trace_irq_disable+0x3b/0x140
[   43.974437][ T9492]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.975034][ T9492]  ? clear_bhb_loop+0x30/0x80
[   43.975572][ T9492]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.976138][ T9492] RIP: 0033:0x42ce46
[   43.976516][ T9492] Code: 47 ba 04 00 00 00 48 c7 c0 f0 ff ff ff 64
89 10 48 c7 c2 ff ff ff ff c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48
8b 45 10 0f 05 <48> 89 c2 48 3d 00 f0 ff ff 77 0f c9 48 89 d0 c3 66 2e
0f 1f 84 00
[   43.978228][ T9492] RSP: 002b:00007ffc31f8bd20 EFLAGS: 00000202
ORIG_RAX: 000000000000002c
[   43.978979][ T9492] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 000000000042ce46
[   43.979689][ T9492] RDX: 000000000000002c RSI: 00007ffc31f8bda0
RDI: 0000000000000003
[   43.980398][ T9492] RBP: 00007ffc31f8bd30 R08: 00007ffc31f8bd94
R09: 000000000000000c
[   43.981108][ T9492] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffc31f8c208
[   43.981845][ T9492] R13: 00007ffc31f8c218 R14: 0000000000000002
R15: 00000000004ad140
[   43.982610][ T9492]  </TASK>
[   43.982915][ T9492] Kernel panic - not syncing: kernel: panic_on_warn set ...
[   43.983606][ T9492] CPU: 1 UID: 0 PID: 9492 Comm: repro Not tainted
7.3.0-rc2-00099-g50d05c7c76c9 #1 PREEMPT(full)
[   43.984545][ T9492] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   43.985557][ T9492] Call Trace:
[   43.985863][ T9492]  <TASK>
[   43.986163][ T9492]  vpanic+0x56d/0xa60
[   43.986557][ T9492]  ? __pfx__printk+0x10/0x10
[   43.987007][ T9492]  ? __pfx_vpanic+0x10/0x10
[   43.987444][ T9492]  ? is_bpf_text_address+0x292/0x2b0
[   43.987947][ T9492]  ? is_bpf_text_address+0x26/0x2b0
[   43.988428][ T9492]  panic+0xc5/0xd0
[   43.988774][ T9492]  ? __pfx_panic+0x10/0x10
[   43.989189][ T9492]  __warn+0x315/0x4c0
[   43.989557][ T9492]  ? kobject_add_internal+0x13e/0xd00
[   43.990048][ T9492]  ? kobject_add_internal+0x13e/0xd00
[   43.990534][ T9492]  __report_bug+0x273/0x580
[   43.990955][ T9492]  ? kobject_add_internal+0x13e/0xd00
[   43.991446][ T9492]  ? __pfx___report_bug+0x10/0x10
[   43.991908][ T9492]  ? kasan_save_track+0x4f/0x80
[   43.992360][ T9492]  ? __kasan_kmalloc+0x93/0xb0
[   43.992834][ T9492]  ? __kmalloc_cache_noprof+0x325/0x610
[   43.993388][ T9492]  ? device_add+0xbe/0xb90
[   43.993817][ T9492]  report_bug_entry+0x19b/0x290
[   43.994293][ T9492]  ? kobject_add_internal+0x141/0xd00
[   43.994778][ T9492]  ? kobject_add_internal+0x146/0xd00
[   43.995266][ T9492]  handle_bug+0xce/0x200
[   43.995757][ T9492]  exc_invalid_op+0x1a/0x50
[   43.996197][ T9492]  asm_exc_invalid_op+0x1a/0x20
[   43.996669][ T9492] RIP: 0010:kobject_add_internal+0x141/0xd00
[   43.997212][ T9492] Code: e9 da 00 00 00 e8 ff 0f 03 f6 b8 fe ff ff
ff e9 0a 07 00 00 e8 f0 0f 03 f6 eb 05 e8 e9 0f 03 f6 48 8d 3d 72 80
a4 04 48 89 de <67> 48 0f b9 3a b8 ea ff ff ff e9 e5 06 00 00 4c 8d 73
20 4d 89 f5
[   43.998921][ T9492] RSP: 0018:ffffc90007b5f2d8 EFLAGS: 00010293
[   43.999474][ T9492] RAX: ffffffff8bc48c97 RBX: ffff888107e94000
RCX: ffff88802e21a640
[   44.000182][ T9492] RDX: 0000000000000000 RSI: ffff888107e94000
RDI: ffffffff90690d10
[   44.000887][ T9492] RBP: 0000000000000000 R08: ffffc90007b5f3b7
R09: 0000000000000000
[   44.001595][ T9492] R10: ffffc90007b5f3a0 R11: fffff52000f6be77
R12: 1ffff11020fd2800
[   44.002304][ T9492] R13: dffffc0000000000 R14: ffff8881054a19e0
R15: dffffc0000000000
[   44.003015][ T9492]  ? kobject_add_internal+0x137/0xd00
[   44.003502][ T9492]  ? kobject_add_internal+0x137/0xd00
[   44.004008][ T9492]  kobject_add+0x163/0x240
[   44.004418][ T9492]  ? __pfx_kobject_add+0x10/0x10
[   44.004870][ T9492]  ? bus_get_dev_root+0x127/0x160
[   44.005335][ T9492]  ? get_device_parent+0x38c/0x3a0
[   44.005847][ T9492]  ? __pfx_klist_children_get+0x10/0x10
[   44.006414][ T9492]  device_add+0x408/0xb90
[   44.006842][ T9492]  vdpasim_blk_dev_add+0x1e2/0x2a0
[   44.007371][ T9492]  ? __pfx_vdpasim_blk_dev_add+0x10/0x10
[   44.007884][ T9492]  ? __pfx_vdpasim_blk_work+0x10/0x10
[   44.008372][ T9492]  ? __pfx_vdpasim_blk_get_config+0x10/0x10
[   44.008908][ T9492]  ? __pfx_vdpasim_blk_free+0x10/0x10
[   44.009429][ T9492]  ? vdpa_mgmtdev_get_from_attr+0x2bb/0x2d0
[   44.009995][ T9492]  vdpa_nl_cmd_dev_add_set_doit+0xa75/0xbc0
[   44.010576][ T9492]  ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10
[   44.011154][ T9492]  ? __nla_parse+0x40/0x60
[   44.011566][ T9492]  ? genl_family_rcv_msg_attrs_parse+0x20b/0x2f0
[   44.012144][ T9492]  ? genl_family_rcv_msg_attrs_parse+0x265/0x2f0
[   44.012717][ T9492]  genl_family_rcv_msg_doit+0x22a/0x330
[   44.013221][ T9492]  ? __asan_memcpy+0x40/0x70
[   44.013647][ T9492]  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[   44.014204][ T9492]  ? bpf_lsm_capable+0x9/0x20
[   44.014634][ T9492]  ? security_capable+0x7e/0x2c0
[   44.015096][ T9492]  genl_rcv_msg+0x61c/0x7a0
[   44.015582][ T9492]  ? __pfx_genl_rcv_msg+0x10/0x10
[   44.016045][ T9492]  ? __pfx_vdpa_nl_cmd_dev_add_set_doit+0x10/0x10
[   44.016625][ T9492]  netlink_rcv_skb+0x232/0x4b0
[   44.017069][ T9492]  ? __pfx_genl_rcv_msg+0x10/0x10
[   44.017527][ T9492]  ? __pfx_netlink_rcv_skb+0x10/0x10
[   44.018015][ T9492]  ? down_read+0x2be/0x330
[   44.018423][ T9492]  genl_rcv+0x28/0x40
[   44.018791][ T9492]  netlink_unicast+0x75e/0x8e0
[   44.019235][ T9492]  netlink_sendmsg+0x813/0xb40
[   44.019675][ T9492]  ? __pfx_netlink_sendmsg+0x10/0x10
[   44.020177][ T9492]  ? apparmor_socket_sendmsg+0x95/0x390
[   44.020695][ T9492]  ? __pfx_netlink_sendmsg+0x10/0x10
[   44.021176][ T9492]  sock_sendmsg_nosec+0x13a/0x180
[   44.021635][ T9492]  __sys_sendto+0x408/0x5a0
[   44.022059][ T9492]  ? __pfx___sys_sendto+0x10/0x10
[   44.022525][ T9492]  ? fd_install+0x94/0x3d0
[   44.022934][ T9492]  ? fd_install+0x309/0x3d0
[   44.023352][ T9492]  __x64_sys_sendto+0xde/0x100
[   44.023791][ T9492]  do_syscall_64+0x155/0x510
[   44.024218][ T9492]  ? trace_irq_disable+0x3b/0x140
[   44.024676][ T9492]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   44.025227][ T9492]  ? clear_bhb_loop+0x30/0x80
[   44.025725][ T9492]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   44.026262][ T9492] RIP: 0033:0x42ce46
[   44.026621][ T9492] Code: 47 ba 04 00 00 00 48 c7 c0 f0 ff ff ff 64
89 10 48 c7 c2 ff ff ff ff c9 48 89 d0 c3 0f 1f 84 00 00 00 00 00 48
8b 45 10 0f 05 <48> 89 c2 48 3d 00 f0 ff ff 77 0f c9 48 89 d0 c3 66 2e
0f 1f 84 00
[   44.028412][ T9492] RSP: 002b:00007ffc31f8bd20 EFLAGS: 00000202
ORIG_RAX: 000000000000002c
[   44.029158][ T9492] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 000000000042ce46
[   44.029866][ T9492] RDX: 000000000000002c RSI: 00007ffc31f8bda0
RDI: 0000000000000003
[   44.030576][ T9492] RBP: 00007ffc31f8bd30 R08: 00007ffc31f8bd94
R09: 000000000000000c
[   44.031283][ T9492] R10: 0000000000000000 R11: 0000000000000202
R12: 00007ffc31f8c208
[   44.031993][ T9492] R13: 00007ffc31f8c218 R14: 0000000000000002
R15: 00000000004ad140
[   44.032708][ T9492]  </TASK>
[   44.033595][ T9492] Kernel Offset: disabled
[   44.034143][ T9492] Rebooting in 86400 seconds..

Regards,

--000000000000dd466a065b36af32
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtx3xh4o0>
X-Attachment-Id: f_mtx3xh4o0

LyoKICogMjMwLXdhcm5pbmcta29iamVjdC1idWctaW4tdmRwYXNpbS1ibGstZGV2LWFkZAogKi8K
CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPGxp
bnV4L25ldGxpbmsuaD4KCiNkZWZpbmUgR0VOTF9JRF9DVFJMCQkJMTYKI2RlZmluZSBDVFJMX0NN
RF9HRVRGQU1JTFkJCTMKI2RlZmluZSBDVFJMX0FUVFJfRkFNSUxZX0lECQkxCiNkZWZpbmUgQ1RS
TF9BVFRSX0ZBTUlMWV9OQU1FCQkyCgojZGVmaW5lIFZEUEFfQ01EX0RFVl9ORVcJCTMKI2RlZmlu
ZSBWRFBBX0FUVFJfTUdNVERFVl9ERVZfTkFNRQkyCiNkZWZpbmUgVkRQQV9BVFRSX0RFVl9OQU1F
CQk0CgojZGVmaW5lIE5MQV9BTElHTl9VUChsZW5ndGgpCQkoKChsZW5ndGgpICsgMykgJiB+MykK
Ci8qIHN0cnVjdCBnZW5sbXNnaGRyLCByZXBsaWNhdGVkIHNvIHRoaXMgZmlsZSBuZWVkcyBubyBs
aWJubCBoZWFkZXJzLiAqLwpzdHJ1Y3QgZ2VuZXJpY19uZXRsaW5rX2hlYWRlciB7Cgl1bnNpZ25l
ZCBjaGFyIGNvbW1hbmQ7Cgl1bnNpZ25lZCBjaGFyIHZlcnNpb247Cgl1bnNpZ25lZCBzaG9ydCBy
ZXNlcnZlZDsKfTsKCnN0YXRpYyBjaGFyIG5ldGxpbmtfcmVwbHlfYnVmZmVyWzQwOTZdOwoKc3Rh
dGljIGludCBhcHBlbmRfbmV0bGlua19hdHRyaWJ1dGUoY2hhciAqYXR0cmlidXRlX3Nsb3QsIGlu
dCBhdHRyaWJ1dGVfdHlwZSwKCQkJCSAgICBjb25zdCB2b2lkICpwYXlsb2FkLCBpbnQgcGF5bG9h
ZF9sZW5ndGgpCnsKCXN0cnVjdCBubGF0dHIgKmF0dHJpYnV0ZSA9IChzdHJ1Y3QgbmxhdHRyICop
YXR0cmlidXRlX3Nsb3Q7CgoJYXR0cmlidXRlLT5ubGFfdHlwZSA9IGF0dHJpYnV0ZV90eXBlOwoJ
YXR0cmlidXRlLT5ubGFfbGVuID0gc2l6ZW9mKCphdHRyaWJ1dGUpICsgcGF5bG9hZF9sZW5ndGg7
CgltZW1jcHkoYXR0cmlidXRlX3Nsb3QgKyBzaXplb2YoKmF0dHJpYnV0ZSksIHBheWxvYWQsIHBh
eWxvYWRfbGVuZ3RoKTsKCS8qIFplcm8gdGhlIGFsaWdubWVudCBwYWRkaW5nOiB0aGUga2VybmVs
IHNlZXMgdGhlIHdob2xlIGFsaWduZWQgc3Bhbi4gKi8KCW1lbXNldChhdHRyaWJ1dGVfc2xvdCAr
IHNpemVvZigqYXR0cmlidXRlKSArIHBheWxvYWRfbGVuZ3RoLCAwLAoJICAgICAgIE5MQV9BTElH
Tl9VUChhdHRyaWJ1dGUtPm5sYV9sZW4pIC0gYXR0cmlidXRlLT5ubGFfbGVuKTsKCXJldHVybiBO
TEFfQUxJR05fVVAoYXR0cmlidXRlLT5ubGFfbGVuKTsKfQoKc3RhdGljIGludCBzZW5kX2dlbmVy
aWNfbmV0bGlua19yZXF1ZXN0KGludCBuZXRsaW5rX2ZkLCBpbnQgZmFtaWx5X2lkLCBpbnQgY29t
bWFuZCwKCQkJCQljb25zdCBjaGFyICphdHRyaWJ1dGVzLCBpbnQgYXR0cmlidXRlc19sZW5ndGgp
CnsKCWNoYXIgcmVxdWVzdFs1MTJdOwoJc3RydWN0IG5sbXNnaGRyICpyZXF1ZXN0X2hlYWRlciA9
IChzdHJ1Y3Qgbmxtc2doZHIgKilyZXF1ZXN0OwoJc3RydWN0IGdlbmVyaWNfbmV0bGlua19oZWFk
ZXIgKmdlbmVyaWNfaGVhZGVyID0KCQkoc3RydWN0IGdlbmVyaWNfbmV0bGlua19oZWFkZXIgKiko
cmVxdWVzdCArIE5MTVNHX0hEUkxFTik7CglzdHJ1Y3Qgc29ja2FkZHJfbmwga2VybmVsX2FkZHJl
c3M7CgoJbWVtc2V0KHJlcXVlc3QsIDAsIHNpemVvZihyZXF1ZXN0KSk7CglyZXF1ZXN0X2hlYWRl
ci0+bmxtc2dfbGVuID0gTkxNU0dfSERSTEVOICsgc2l6ZW9mKCpnZW5lcmljX2hlYWRlcikgKyBh
dHRyaWJ1dGVzX2xlbmd0aDsKCXJlcXVlc3RfaGVhZGVyLT5ubG1zZ190eXBlID0gZmFtaWx5X2lk
OwoJcmVxdWVzdF9oZWFkZXItPm5sbXNnX2ZsYWdzID0gTkxNX0ZfUkVRVUVTVCB8IE5MTV9GX0FD
SzsKCXJlcXVlc3RfaGVhZGVyLT5ubG1zZ19zZXEgPSAxOwoJZ2VuZXJpY19oZWFkZXItPmNvbW1h
bmQgPSBjb21tYW5kOwoJZ2VuZXJpY19oZWFkZXItPnZlcnNpb24gPSAxOwoJbWVtY3B5KHJlcXVl
c3QgKyBOTE1TR19IRFJMRU4gKyBzaXplb2YoKmdlbmVyaWNfaGVhZGVyKSwgYXR0cmlidXRlcywg
YXR0cmlidXRlc19sZW5ndGgpOwoKCW1lbXNldCgma2VybmVsX2FkZHJlc3MsIDAsIHNpemVvZihr
ZXJuZWxfYWRkcmVzcykpOwoJa2VybmVsX2FkZHJlc3MubmxfZmFtaWx5ID0gQUZfTkVUTElOSzsK
CXJldHVybiBzZW5kdG8obmV0bGlua19mZCwgcmVxdWVzdCwgcmVxdWVzdF9oZWFkZXItPm5sbXNn
X2xlbiwgMCwKCQkgICAgICAoc3RydWN0IHNvY2thZGRyICopJmtlcm5lbF9hZGRyZXNzLCBzaXpl
b2Yoa2VybmVsX2FkZHJlc3MpKTsKfQoKc3RhdGljIGludCByZXNvbHZlX3ZkcGFfZ2VuZXJpY19u
ZXRsaW5rX2ZhbWlseV9pZChpbnQgbmV0bGlua19mZCkKewoJY2hhciBhdHRyaWJ1dGVzWzI1Nl07
CglpbnQgYXR0cmlidXRlc19sZW5ndGg7CglpbnQgcmVwbHlfbGVuZ3RoOwoJc3RydWN0IG5sbXNn
aGRyICpyZXBseV9oZWFkZXIgPSAoc3RydWN0IG5sbXNnaGRyICopbmV0bGlua19yZXBseV9idWZm
ZXI7CgljaGFyICphdHRyaWJ1dGVfY3Vyc29yLCAqcmVwbHlfZW5kOwoKCWF0dHJpYnV0ZXNfbGVu
Z3RoID0gYXBwZW5kX25ldGxpbmtfYXR0cmlidXRlKGF0dHJpYnV0ZXMsIENUUkxfQVRUUl9GQU1J
TFlfTkFNRSwKCQkJCQkJICAgICAidmRwYSIsIHNpemVvZigidmRwYSIpKTsKCWlmIChzZW5kX2dl
bmVyaWNfbmV0bGlua19yZXF1ZXN0KG5ldGxpbmtfZmQsIEdFTkxfSURfQ1RSTCwgQ1RSTF9DTURf
R0VURkFNSUxZLAoJCQkJCSBhdHRyaWJ1dGVzLCBhdHRyaWJ1dGVzX2xlbmd0aCkgPCAwKQoJCXJl
dHVybiAtMTsKCglyZXBseV9sZW5ndGggPSByZWN2KG5ldGxpbmtfZmQsIG5ldGxpbmtfcmVwbHlf
YnVmZmVyLCBzaXplb2YobmV0bGlua19yZXBseV9idWZmZXIpLCAwKTsKCWlmIChyZXBseV9sZW5n
dGggPD0gMCB8fCByZXBseV9oZWFkZXItPm5sbXNnX3R5cGUgIT0gR0VOTF9JRF9DVFJMKQoJCXJl
dHVybiAtMTsKCglhdHRyaWJ1dGVfY3Vyc29yID0gKGNoYXIgKilOTE1TR19EQVRBKHJlcGx5X2hl
YWRlcikgKyBzaXplb2Yoc3RydWN0IGdlbmVyaWNfbmV0bGlua19oZWFkZXIpOwoJcmVwbHlfZW5k
ID0gbmV0bGlua19yZXBseV9idWZmZXIgKyByZXBseV9oZWFkZXItPm5sbXNnX2xlbjsKCXdoaWxl
IChhdHRyaWJ1dGVfY3Vyc29yICsgc2l6ZW9mKHN0cnVjdCBubGF0dHIpIDw9IHJlcGx5X2VuZCkg
ewoJCXN0cnVjdCBubGF0dHIgKmF0dHJpYnV0ZSA9IChzdHJ1Y3QgbmxhdHRyICopYXR0cmlidXRl
X2N1cnNvcjsKCgkJaWYgKGF0dHJpYnV0ZS0+bmxhX2xlbiA8IHNpemVvZigqYXR0cmlidXRlKSkK
CQkJcmV0dXJuIC0xOwoJCWlmIChhdHRyaWJ1dGUtPm5sYV90eXBlID09IENUUkxfQVRUUl9GQU1J
TFlfSUQpCgkJCXJldHVybiAqKHVuc2lnbmVkIHNob3J0ICopKGF0dHJpYnV0ZV9jdXJzb3IgKyBz
aXplb2YoKmF0dHJpYnV0ZSkpOwoJCWF0dHJpYnV0ZV9jdXJzb3IgKz0gTkxBX0FMSUdOX1VQKGF0
dHJpYnV0ZS0+bmxhX2xlbik7Cgl9CglyZXR1cm4gLTE7Cn0KCmludCBtYWluKHZvaWQpCnsKCWNo
YXIgYXR0cmlidXRlc1syNTZdOwoJaW50IGF0dHJpYnV0ZXNfbGVuZ3RoID0gMDsKCWludCBuZXRs
aW5rX2ZkLCB2ZHBhX2ZhbWlseV9pZDsKCgluZXRsaW5rX2ZkID0gc29ja2V0KEFGX05FVExJTkss
IFNPQ0tfUkFXLCBORVRMSU5LX0dFTkVSSUMpOwoJaWYgKG5ldGxpbmtfZmQgPCAwKQoJCXJldHVy
biAxOwoKCXZkcGFfZmFtaWx5X2lkID0gcmVzb2x2ZV92ZHBhX2dlbmVyaWNfbmV0bGlua19mYW1p
bHlfaWQobmV0bGlua19mZCk7CglpZiAodmRwYV9mYW1pbHlfaWQgPD0gMCkKCQlyZXR1cm4gMTsK
CglhdHRyaWJ1dGVzX2xlbmd0aCArPSBhcHBlbmRfbmV0bGlua19hdHRyaWJ1dGUoYXR0cmlidXRl
cyArIGF0dHJpYnV0ZXNfbGVuZ3RoLAoJCQkJCQkgICAgICBWRFBBX0FUVFJfTUdNVERFVl9ERVZf
TkFNRSwKCQkJCQkJICAgICAgInZkcGFzaW1fYmxrIiwgc2l6ZW9mKCJ2ZHBhc2ltX2JsayIpKTsK
CWF0dHJpYnV0ZXNfbGVuZ3RoICs9IGFwcGVuZF9uZXRsaW5rX2F0dHJpYnV0ZShhdHRyaWJ1dGVz
ICsgYXR0cmlidXRlc19sZW5ndGgsCgkJCQkJCSAgICAgIFZEUEFfQVRUUl9ERVZfTkFNRSwgIiIs
IDEpOwoKCXNlbmRfZ2VuZXJpY19uZXRsaW5rX3JlcXVlc3QobmV0bGlua19mZCwgdmRwYV9mYW1p
bHlfaWQsIFZEUEFfQ01EX0RFVl9ORVcsCgkJCQkgICAgIGF0dHJpYnV0ZXMsIGF0dHJpYnV0ZXNf
bGVuZ3RoKTsKCXJldHVybiAwOwp9Cg==
--000000000000dd466a065b36af32--

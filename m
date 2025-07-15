Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0032219B5A7
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 01:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752542368; cv=none; b=YrENVx11s1f4HbyIwLeBrP9ti9uH9YfcrgYDoBGpQKcw2RbxqT6UZMly+I3RG2ui4+KE+EVqpzLU7bb2Mvfbxb4gg5jShpsMF4GJMOG2MZ+jda/75hU6W++qBoV0woXqMiA+LT2HRTdPWxjeNJ7ASVMENp60/vTUislsX2nZThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752542368; c=relaxed/simple;
	bh=H7nXBPrRGOP+J4NoaHFROP/9vshTUnCWWgSpAKnGKlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugr1ZAvjEW05Lld7EjcRGSIi0imI+/Q24XbqUkCQc4mDpRKQDwH0Wk43BdhkDQPBnag90rmJ1kcx+RJSxaKhiL/icW/dyY36UVbrdInmE/8OS07ecupn+f90e2g1CiWHy/M4PY7pYqDlGJ1sb2vN03FosiSBjQrn05zR7Q8/uLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLVhZlup; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLVhZlup"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752542364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dADrM6UfGPqGtSa2Lobxnx7iNbQpsPFYNf3aRK0Ft0=;
	b=DLVhZlupPQgTItTiaoZhtQf+ONkx+6jEuL1UTAXqd8WO/nWzb1C2aaqv7czfA0FL3bUPRB
	HzoABcECWuW4KekGlaw3gfX8uY9URmBSgtP4RxQoG9Tro+3XcX68p64dcVouBVRn9qWb45
	ypL+f0fpAFgEsmtR1OMpnfEQP+Un7cA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-Cne8mKwNOiCPWiY6DexlKw-1; Mon, 14 Jul 2025 21:19:22 -0400
X-MC-Unique: Cne8mKwNOiCPWiY6DexlKw-1
X-Mimecast-MFC-AGG-ID: Cne8mKwNOiCPWiY6DexlKw_1752542362
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so5397836a91.3
        for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 18:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752542362; x=1753147162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dADrM6UfGPqGtSa2Lobxnx7iNbQpsPFYNf3aRK0Ft0=;
        b=wxYhnaDDfRsgk1RmY3zYEc3Au5IXLUz2cyZwWVWSqloIiPpm6K3abCszjCXy6F+6v1
         D2nmsWpZ8lTO63IspQeLoyhkk434RRk5RDi08luXqbDJdFuwC43F8kBi7BvwCMwnZQ5I
         3hoCtTlxDg7aBhab6aif9oF8Zt/mrXvKUPjDNZl8qZQW/kgjx3qM7SC19kQ4Jm45m90O
         /y+2e5P1hjPO7MGYvmCIu8ktWnstBJPe4C2ZAg/n8YDY4ux6h0WrqyKflwE12izcsOt5
         mn529HPoGTJlpBNE3L7F473c3b8Y3KfbauvmzNgm0V52T7Ssn5xmSB/7JFGWbBClaNr/
         ajOw==
X-Forwarded-Encrypted: i=1; AJvYcCVzBxOwjcwSry7BtbXeOmGVyUaZsiZKLGUBx+3mgoF+mqwCE/EtscPKrp2r9A+I1ItwuepQDaw/0rRor3d8bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxp4qLHZBRxDjFijPY4fewp7+NQfZwwqW2hsDnX3KsWfyJJzQJg
	uGScirz7/uX8vbbTpnT8eu5W2/8PCwylN0B9PR6nhY61sxpZIC+S+tqzF/pjt4IeF9PuHZMlcEo
	lGFF1+dE9d/XU9jGFcCj8884xbvafz2WjWB8zfjHuwBluADJH+x1837qEn1Bgv1QCm+G8QptvK1
	8d0jjbmpKWX4J/Vf0LkZa3nCul6jNZRDP1N8gvL1hTwh4=
X-Gm-Gg: ASbGncv1C0yvcGT4ljC1i8kF020Uy/zjyEOQdcBp+5Vp2BE89Z9NmbXyhW+45cJAwyz
	T9nvD+WB6K3TdlRuq0AgDwCmMCvcCUiDEbRv4ZgkKvygJPEMWmLdJMg1o3HtzHYJ3qSINW1/olb
	z2jAQkXZJBtK+5aUHrV33F
X-Received: by 2002:a17:90b:1b50:b0:318:f0cb:5a50 with SMTP id 98e67ed59e1d1-31c4ccf3240mr21738696a91.26.1752542361747;
        Mon, 14 Jul 2025 18:19:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDNaig/wNtAqD45U4QwC1Xt1m0m+LUej2l14YCJqwHcBKUHvCBXy7lUl9TYQCsHcYeguII8xvL5MWmFfPZ9a4=
X-Received: by 2002:a17:90b:1b50:b0:318:f0cb:5a50 with SMTP id
 98e67ed59e1d1-31c4ccf3240mr21738669a91.26.1752542361327; Mon, 14 Jul 2025
 18:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADZSLS3WYUHJFhQx786Fbxz=8JredK+XxtZAeLzp3XWaOGnZRw@mail.gmail.com>
In-Reply-To: <CADZSLS3WYUHJFhQx786Fbxz=8JredK+XxtZAeLzp3XWaOGnZRw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Jul 2025 09:19:10 +0800
X-Gm-Features: Ac12FXxYmzPKQVaAj3Il-zJUV2b5uKLw0Yd7BKAiyv5uVj_ejhQlfTgned6A2yQ
Message-ID: <CACGkMEtza2ey3JJhFcq4p6cJ-O4CPA9sC8mK0Twv25F-6eWGNQ@mail.gmail.com>
Subject: Re: Failure to create vp_vdpa device with enabled feature provisioning
To: Wenli Quan <wquan@redhat.com>
Cc: "S. Tsirkin, Michael" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	Dragos Tatulea <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _uiqzvXETd9CuCCsbUWhqCUXq9-b2FZsGHUBeYVvx7U_1752542362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Cindy for help here.

On Mon, Jul 14, 2025 at 9:18=E2=80=AFPM Wenli Quan <wquan@redhat.com> wrote=
:
>
> Hello all:
>
> I am encountering an issue when creating a vp_vdpa device with feature pr=
ovisioning enabled.
>
> In the vm:
>
> # uname -r
> 6.16.0-rc2+
>
> # cd /sys/bus/pci/drivers/virtio-pci/
>
> # echo 0000:01:00.0 > unbind
>
> # modprobe vp_vdpa
>
> # cd ../vp-vdpa/
>
> # echo "1af4 1041" > new_id
>
> # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features 0x1
>
> # vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features 0x1
>
> [   84.703574] vp-vdpa 0000:01:00.0: Failed to register to vdpa bus
>
> kernel answers: File exists
>
> # vdpa dev del vdpa0
>
>
> [  194.055148] BUG: kernel NULL pointer dereference, address: 00000000000=
000d0
>
> [  194.055698] #PF: supervisor read access in kernel mode
>
> [  194.056100] #PF: error_code(0x0000) - not-present page
>
> [  194.056497] PGD 7c7e067 P4D 0
>
> [  194.056739] Oops: Oops: 0000 [#1] SMP
>
> [  194.057040] CPU: 0 UID: 0 PID: 13582 Comm: vdpa Not tainted 6.16.0-rc2=
+ #6 PREEMPT(voluntary)
>
> [  194.057697] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20241117-2.el9_=
6.1 11/17/2024
>
> [  194.058299] RIP: 0010:device_del+0x40/0x480
>
> [  194.058623] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f 40 4c 89 e=
7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48 8b 55 48 <=
0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00 4c 89
>
> [  194.060031] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
>
> [  194.060436] RAX: 0000000000000000 RBX: ff110000089f1720 RCX: ffffffffa=
05f2200
>
> [  194.060976] RDX: 0000000000000000 RSI: ff11000018296800 RDI: ff1100001=
8297080
>
> [  194.061510] RBP: ff11000018297000 R08: ff1100000a3ea048 R09: ffa000000=
04dbc50
>
> [  194.062051] R10: ff11000006abae00 R11: 0000000000000026 R12: ff1100001=
8297080
>
> [  194.062586] R13: ff1100000571c300 R14: ffa00000004dbc50 R15: 000000000=
0000000
>
> [  194.063132] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(0000) knlG=
S:0000000000000000
>
> [  194.063748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>
> [  194.064189] CR2: 00000000000000d0 CR3: 0000000007830004 CR4: 000000000=
0773ef0
>
> [  194.064722] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
>
> [  194.065258] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000=
0000400
>
> [  194.065813] PKRU: 55555554
>
> [  194.066022] Call Trace:
>
> [  194.066240]  <TASK>
>
> [  194.066418]  device_unregister+0x12/0x30
>
> [  194.066724]  vp_vdpa_dev_del+0x16/0x20 [vp_vdpa]
>
> [  194.067078]  vdpa_nl_cmd_dev_del_set_doit+0x67/0xe0 [vdpa]
>
> [  194.067497]  genl_family_rcv_msg_doit+0xd2/0x120
>
> [  194.067863]  genl_rcv_msg+0x182/0x2b0
>
> [  194.068160]  ? vdpa_nl_cmd_dev_get_dumpit+0xa0/0xa0 [vdpa]
>
> [  194.068594]  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
>
> [  194.068971]  netlink_rcv_skb+0x57/0x100
>
> [  194.069270]  genl_rcv+0x28/0x40
>
> [  194.069515]  netlink_unicast+0x278/0x3a0
>
> [  194.069828]  netlink_sendmsg+0x1e7/0x420
>
> [  194.070134]  __sock_sendmsg+0x38/0x60
>
> [  194.070414]  ? move_addr_to_kernel.part.0+0x1b/0x60
>
> [  194.070794]  __sys_sendto+0x115/0x170
>
> [  194.071086]  ? __sys_recvmsg+0x6a/0xc0
>
> [  194.071378]  __x64_sys_sendto+0x24/0x30
>
> [  194.071674]  do_syscall_64+0x59/0x1f0
>
> [  194.071963]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
> [  194.072347] RIP: 0033:0x7f03a6ba7dea
>
> [  194.072625] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0=
f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
>
> [  194.074021] RSP: 002b:00007ffceb0ebeb8 EFLAGS: 00000246 ORIG_RAX: 0000=
00000000002c
>
> [  194.074610] RAX: ffffffffffffffda RBX: 00005646e0680350 RCX: 00007f03a=
6ba7dea
>
> [  194.075154] RDX: 0000000000000020 RSI: 00005646e0680350 RDI: 000000000=
0000003
>
> [  194.075699] RBP: 00005646e06802a0 R08: 00007f03a6cae200 R09: 000000000=
000000c
>
> [  194.076455] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
>
> [  194.077197] R13: 0000000000000000 R14: 00007ffceb0ec75d R15: 000000000=
0000064
>
> [  194.077944]  </TASK>
>
> [  194.078321] Modules linked in: vp_vdpa vdpa kvm_intel kvm irqbypass fu=
se configfs xfs virtio_net net_failover failover virtio_pci virtio_pci_lega=
cy_dev virtio_pci_modern_dev be2iscsi cxgb3i cxgb3 mdio libcxgbi libcxgb is=
csi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4
>
> [  194.080556] CR2: 00000000000000d0
>
> [  194.081040] ---[ end trace 0000000000000000 ]---
>
> [  194.660537] RIP: 0010:device_del+0x40/0x480
>
> [  194.662514] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f 40 4c 89 e=
7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48 8b 55 48 <=
0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00 4c 89
>
> [  194.664367] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
>
> [  194.664996] RAX: 0000000000000000 RBX: ff110000089f1720 RCX: ffffffffa=
05f2200
>
> [  194.665760] RDX: 0000000000000000 RSI: ff11000018296800 RDI: ff1100001=
8297080
>
> [  194.666527] RBP: ff11000018297000 R08: ff1100000a3ea048 R09: ffa000000=
04dbc50
>
> [  194.667300] R10: ff11000006abae00 R11: 0000000000000026 R12: ff1100001=
8297080
>
> [  194.668066] R13: ff1100000571c300 R14: ffa00000004dbc50 R15: 000000000=
0000000
>
> [  194.668823] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(0000) knlG=
S:0000000000000000
>
> [  194.669653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>
> [  194.670322] CR2: 00000000000000d0 CR3: 0000000007830004 CR4: 000000000=
0773ef0
>
> [  194.671083] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
>
> [  194.671845] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000=
0000400
>
> [  194.672607] PKRU: 55555554
>
> [  194.673042] note: vdpa[13582] exited with irqs disabled
>
> Killed
>
>
> Best Regards,
>
>
> wenli

Thanks


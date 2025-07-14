Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258A258CDC
	for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499393; cv=none; b=bu+cVhZDgAaZP0hTkv8SthJUjBperk+yNRwKmJ0CcOrpDxZ2Ca+KwaF8psDkR6rWKcSKYDj9DqQFrYZxW9xLDfYzARJEf8eqkMaEq1Sw63Ud6pub9AhsuynIUkwo2jDEJY7gQcVwJKpRQ1zwGUxzQsnsKswuC32RoKhMoQEb7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499393; c=relaxed/simple;
	bh=a8/xsC6mybZt9lZchjd6nbOAuYqZy7eGYt0EeCE0nTk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iyM6xOkvjrTT5PLtdcNXWq5ieAgVH82cAYK36fM3s9S7SWdlh6SBlXpYeB6pZ8rC263/OEmYSBmEsgs5CxgNQoDVwYNOPvTG7BkONS/ds79QQRi3R/4cwj1kKgaAP0z5WtwVqofLkDgeE+ahff9X1V2ZU2xInLwOtKlYtGMoFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgPE123F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgPE123F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=NCYr71ahohnpSoVhlVAFgsHRMUY1fBwIYUV/xKwnHTg=;
	b=SgPE123FA4oeX4iF0dxKh9uCX2mJIghYV6ldPj1gUTwlbHVh5nK7s80zOT09NFBuLDDU73
	JCo3S6WgtydJZ/ogQPmLw0XbPSgB5VU2Ag5pKMvsypCrdIWI0HX8mXyRt4ifvAXTuH27yz
	c7S8+HHDIJpNkDUIdyDusmPV8ma3ZDc=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ottw947xNsO7cPfvf10krA-1; Mon, 14 Jul 2025 09:23:09 -0400
X-MC-Unique: ottw947xNsO7cPfvf10krA-1
X-Mimecast-MFC-AGG-ID: ottw947xNsO7cPfvf10krA_1752499389
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-87ec96a458eso610719241.3
        for <virtualization@lists.linux.dev>; Mon, 14 Jul 2025 06:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499389; x=1753104189;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCYr71ahohnpSoVhlVAFgsHRMUY1fBwIYUV/xKwnHTg=;
        b=U+bBBGRHj9e3VhjBxdeWEPMDEgxCsjyKAnlctOHUuesOGJKL92GLT22s5qW8VyiAtC
         w7FB6uFFvRnmiq2DTIH7vXKYigGrWU18vURDi1Pq3KPqSCqWRq9/bIMxAmpEKY51WH8M
         r/5DA2018DZajjGxMJb2SZTJnCeajNI3ORIpaOO/I7zFDU6zv3cKFuEcKXhxqQCQBuZn
         T02BnRyxvLiMlV2qOBqwvP6nOhrLQmdx405vwvt04D5/g1GgmXLv+niHHUDyzaV3Sdzg
         k/Fk+uO03+0MO9NU6IccNShdx7rpY7M4+O1Qpcgb5JT69eZJcC+YMBGH5XdTIKRDnqG+
         iWfA==
X-Forwarded-Encrypted: i=1; AJvYcCUXns9FdpijMI7THcmzf/jYTM6XWZdyBNzvvmXsn5lH2YwLdXsera2plwwTg7HblAMtKiE5AG0Cs2e3Gyj58A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBxgiIvW0Ui0WGY44zqdTIl/3FI0tnJ+/cVs21dzgXeDC6vsfK
	W/yzaaUrl1ZhmKfoN5H1J4Q0vbsDtNloCFrevn7VoRyUgDlhXLDzYi6lGgGmPIKgRcoEn7yshG9
	QOVE1hLsz+C/82f/VoGwePM3QzRx2H9xqYNSOI3459BTwCbEl0SFAinQedWOSQgEoT5lpPHl7TB
	yO0x/actwoJmzKKIFOJDA7bnYWvdajp+jLWmh+O5BFSS0=
X-Gm-Gg: ASbGncsdbiY0zAv5bKBrz4gKWC7K7r04iYFnV4Zj+RPj0dDsHz21Dl3w0o/VlOyKa37
	ts1ia8NR0I2e11xBSYXJDdprwVLnYVVaLlcF/Z6vA1CidPvRm8qwIrT74NwOb+hT1GiITa7d2PN
	kHCUaaLDqUKGtlx7xq3sU=
X-Received: by 2002:a05:6102:2924:b0:4e9:b793:1977 with SMTP id ada2fe7eead31-4f6420f0c4dmr7997298137.0.1752499388635;
        Mon, 14 Jul 2025 06:23:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQidnLQONjf1IOe3Ge2frirl9HGBS5OMTjCMDDqPuMoiABZ/sGSOfGo96g5pwEOPhtWzKgfCC6mqmgAuPGpZM=
X-Received: by 2002:a05:6102:2924:b0:4e9:b793:1977 with SMTP id
 ada2fe7eead31-4f6420f0c4dmr7997280137.0.1752499388181; Mon, 14 Jul 2025
 06:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Wenli Quan <wquan@redhat.com>
Date: Mon, 14 Jul 2025 21:22:57 +0800
X-Gm-Features: Ac12FXyFNA_xfOcr6bp6JjAEppm6oTdUdzkRs_2mwPoKlZx6dgE7rTjDvaexrk0
Message-ID: <CADZSLS14TOsP9X5Mh7QKsPrgJt-6_S0OTtns5Mft=Zxxyw+8mQ@mail.gmail.com>
Subject: Failure to create vp_vdpa device with enabled feature provisioning
To: "S. Tsirkin, Michael" <mst@redhat.com>, jasonwang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio Perez Martin <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RGUMdtu5yVXcaoFGdwWslynJ7qSNByrBlAk-EmcidRE_1752499389
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hello all:

I am encountering an issue when creating a vp_vdpa device with feature
provisioning enabled.

In the vm:

# uname -r
6.16.0-rc2+
# cd /sys/bus/pci/drivers/virtio-pci/
# echo 0000:01:00.0 > unbind
# modprobe vp_vdpa
# cd ../vp-vdpa/
# echo "1af4 1041" > new_id
# vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features 0x1
# vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.0 device_features 0x1
[   84.703574] vp-vdpa 0000:01:00.0: Failed to register to vdpa bus
kernel answers: File exists

# vdpa dev del vdpa0

[  194.055148] BUG: kernel NULL pointer dereference, address: 00000000000000d0
[  194.055698] #PF: supervisor read access in kernel mode
[  194.056100] #PF: error_code(0x0000) - not-present page
[  194.056497] PGD 7c7e067 P4D 0
[  194.056739] Oops: Oops: 0000 [#1] SMP
[  194.057040] CPU: 0 UID: 0 PID: 13582 Comm: vdpa Not tainted
6.16.0-rc2+ #6 PREEMPT(voluntary)
[  194.057697] Hardware name: Red Hat KVM/RHEL, BIOS
edk2-20241117-2.el9_6.1 11/17/2024
[  194.058299] RIP: 0010:device_del+0x40/0x480
[  194.058623] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f 40 4c
89 e7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48
8b 55 48 <0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00
4c 89
[  194.060031] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
[  194.060436] RAX: 0000000000000000 RBX: ff110000089f1720 RCX: ffffffffa05f2200
[  194.060976] RDX: 0000000000000000 RSI: ff11000018296800 RDI: ff11000018297080
[  194.061510] RBP: ff11000018297000 R08: ff1100000a3ea048 R09: ffa00000004dbc50
[  194.062051] R10: ff11000006abae00 R11: 0000000000000026 R12: ff11000018297080
[  194.062586] R13: ff1100000571c300 R14: ffa00000004dbc50 R15: 0000000000000000
[  194.063132] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(0000)
knlGS:0000000000000000
[  194.063748] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  194.064189] CR2: 00000000000000d0 CR3: 0000000007830004 CR4: 0000000000773ef0
[  194.064722] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  194.065258] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  194.065813] PKRU: 55555554
[  194.066022] Call Trace:
[  194.066240]  <TASK>
[  194.066418]  device_unregister+0x12/0x30
[  194.066724]  vp_vdpa_dev_del+0x16/0x20 [vp_vdpa]
[  194.067078]  vdpa_nl_cmd_dev_del_set_doit+0x67/0xe0 [vdpa]
[  194.067497]  genl_family_rcv_msg_doit+0xd2/0x120
[  194.067863]  genl_rcv_msg+0x182/0x2b0
[  194.068160]  ? vdpa_nl_cmd_dev_get_dumpit+0xa0/0xa0 [vdpa]
[  194.068594]  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
[  194.068971]  netlink_rcv_skb+0x57/0x100
[  194.069270]  genl_rcv+0x28/0x40
[  194.069515]  netlink_unicast+0x278/0x3a0
[  194.069828]  netlink_sendmsg+0x1e7/0x420
[  194.070134]  __sock_sendmsg+0x38/0x60
[  194.070414]  ? move_addr_to_kernel.part.0+0x1b/0x60
[  194.070794]  __sys_sendto+0x115/0x170
[  194.071086]  ? __sys_recvmsg+0x6a/0xc0
[  194.071378]  __x64_sys_sendto+0x24/0x30
[  194.071674]  do_syscall_64+0x59/0x1f0
[  194.071963]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  194.072347] RIP: 0033:0x7f03a6ba7dea
[  194.072625] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00
f3 0f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30
44 89
[  194.074021] RSP: 002b:00007ffceb0ebeb8 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[  194.074610] RAX: ffffffffffffffda RBX: 00005646e0680350 RCX: 00007f03a6ba7dea
[  194.075154] RDX: 0000000000000020 RSI: 00005646e0680350 RDI: 0000000000000003
[  194.075699] RBP: 00005646e06802a0 R08: 00007f03a6cae200 R09: 000000000000000c
[  194.076455] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  194.077197] R13: 0000000000000000 R14: 00007ffceb0ec75d R15: 0000000000000064
[  194.077944]  </TASK>
[  194.078321] Modules linked in: vp_vdpa vdpa kvm_intel kvm irqbypass
fuse configfs xfs virtio_net net_failover failover virtio_pci
virtio_pci_legacy_dev virtio_pci_modern_dev be2iscsi cxgb3i cxgb3 mdio
libcxgbi libcxgb iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi
autofs4
[  194.080556] CR2: 00000000000000d0
[  194.081040] ---[ end trace 0000000000000000 ]---
[  194.660537] RIP: 0010:device_del+0x40/0x480
[  194.662514] Code: 00 00 55 48 89 fd 53 48 83 ec 20 4c 8b 7f 40 4c
89 e7 65 48 8b 05 10 bf 73 01 48 89 44 24 18 31 c0 e8 b4 2f 63 00 48
8b 55 48 <0f> b6 82 d0 00 00 00 a8 01 75 09 83 c8 01 88 82 d0 00 00 00
4c 89
[  194.664367] RSP: 0018:ffa00000004dba90 EFLAGS: 00010246
[  194.664996] RAX: 0000000000000000 RBX: ff110000089f1720 RCX: ffffffffa05f2200
[  194.665760] RDX: 0000000000000000 RSI: ff11000018296800 RDI: ff11000018297080
[  194.666527] RBP: ff11000018297000 R08: ff1100000a3ea048 R09: ffa00000004dbc50
[  194.667300] R10: ff11000006abae00 R11: 0000000000000026 R12: ff11000018297080
[  194.668066] R13: ff1100000571c300 R14: ffa00000004dbc50 R15: 0000000000000000
[  194.668823] FS:  00007f03a6a95740(0000) GS:ff110000d8597000(0000)
knlGS:0000000000000000
[  194.669653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  194.670322] CR2: 00000000000000d0 CR3: 0000000007830004 CR4: 0000000000773ef0
[  194.671083] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  194.671845] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[  194.672607] PKRU: 55555554
[  194.673042] note: vdpa[13582] exited with irqs disabled
Killed


Best Regards,


wenli


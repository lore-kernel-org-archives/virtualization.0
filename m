Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D172623
	for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046243; cv=none; b=GvPDCTMcoao7Xzim7S6IP08LUQIuZLSEv6NuY/8fabW3bwpBJ1x/l/Jh/dEmDblvqIFNxCI6hRx4EfFsXhmd0NliTOROwxjBRSjLkIhHiuBkdFXNFoJvbhKFY2z6LjCVUe62RZT48SM3TiaL9g2u3kykVS5Bb9yAa6IcpSyUbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046243; c=relaxed/simple;
	bh=cM1d6D8bUry5V9rPSk6JmiSspgU/ma4i0sPDO9WuIWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qlj+fQzgc5g8i32r3ttByI7Y1iwaZ4DzI4ADMdC3fY/FwV8NRgK9uMGmxDLtzjGgPR38YHy+4XD6AMIE38IutPaIqDu9a6J4NXvnf0dAsXbANyz910mlsk8Sia2VA8iszVvTGKXIKyATcf/xp1tBrZnq99nKSrtooMB7YkbeJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXq3g62s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXq3g62s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774046241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZwvqN2mJDJhEGuMzzf10cm+/tKAa5syM+gE8rratps=;
	b=LXq3g62siwSTKG5oGjlAzP04Yuq1JzcEujkL7FiHpDmp7C+M9lTDiFufbVqY8kgTGcgUbu
	rwG45ytFUG+SZCUZf52a9sUxrc7C1UI8pik/mOx5pVaMXT8aSGQ8G7NutQZJIH+kkL/Rx4
	4tAflPIlPPBKR/n/oo0LLPW9sVi6WQE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-JuBdS-1WMO6qAsbr5bWP_A-1; Fri, 20 Mar 2026 18:37:19 -0400
X-MC-Unique: JuBdS-1WMO6qAsbr5bWP_A-1
X-Mimecast-MFC-AGG-ID: JuBdS-1WMO6qAsbr5bWP_A_1774046239
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48534941525so9394165e9.2
        for <virtualization@lists.linux.dev>; Fri, 20 Mar 2026 15:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046238; x=1774651038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZwvqN2mJDJhEGuMzzf10cm+/tKAa5syM+gE8rratps=;
        b=mObGi20nZKNgzCiNDNEotw4PPCPEGw+3qCNjDeJblOP0jGVwPBbJXD/j08rvy1dvgu
         IKc0SoMquWfFpVylVIAp0A4vJnD88sf7YwB8dbKsJYKwY8zIgTLaio1nhOZ3/E5d/Eqx
         Pc9Ur7OdBr34SgbY4i5IR69hDYR4kF7gcCfMFGzQ6I7sXUrgfceIt8qnsTmckDjb4WAh
         DMt2Q0VwGSnX3DPIy5z6kaAIuOkZ0xHG6mKlwGS/fn8Q3OBlDDVm/kWBgHtcoECfyMtz
         6vAkU113gpwy8+NuAHIAQ3HXmsYbgh8S9xiBM297Eik8ZPuf8raheWpYcKukibMNeHQK
         lCTg==
X-Forwarded-Encrypted: i=1; AJvYcCWZG3jGpFRMpz0hEFmEeQDv/k7c9vIg93YFNMXQCP5xa98wOJ6vK93QO5aCPgQPYVexXTkKhvzeFZRxqfvrNg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYdINoqEoF1FawqfBSFPU5FfJY/eDow8zltoHhEhju89qEaF65
	DqMVKi/1xU78sV/z8SLkMbyT+pi1XyAS5L/4tiNGPw79JLy+ZZxC31bdUu1jae/79GnnYJhY/iG
	CKMTOcnMqFTMMMaAdSD6aFKQjteAh16BLb0gi5SaCLCVRkcs3ruNs4FK/SposHPAVdEAD
X-Gm-Gg: ATEYQzx07TDmplKDpZDtsx4GUVNtO9xFuIU5X9KaUF8hAR/NXwd8t6FzzbElUzZ5IFT
	9YK8MiOgd/O/RhY7Py1W91FMClqeDFhfBMULn4bVHP7AjMTmtY3OZOo9r0CQVSdUaMFRTdDZC8R
	3JdkH0l51IGaehp6+vOJCZfIk0X1dLIy2YUeEgawyYbNpGMcxBa1RnopMJSH0ARAnZOX0c+NpRd
	iC1OAilwBYBxUtRl82R6stLpRq8Fqxy+UJDW9/IWxmj8hDVOSbjfOsN1C5Dwg+6QhJI3qK7evNN
	lhjNXBlsvQh1752+1EEH57X6utn6wwKgxKDEUntgZaRroGR1XNEYT6/P9jd+310b7utQcN1jBGB
	qtHwfXXl+lhsvEba7
X-Received: by 2002:a05:600c:1d15:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-486fedf9061mr65454805e9.10.1774046238493;
        Fri, 20 Mar 2026 15:37:18 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-486fedf9061mr65454455e9.10.1774046237968;
        Fri, 20 Mar 2026 15:37:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1525:da00:3ac2:1a22:72ff:4256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe68ec05sm153927905e9.0.2026.03.20.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:37:17 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:37:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paul Moses <p@1g4.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eli Cohen <elic@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] vdpa: don't free reply skb after genlmsg_reply()
Message-ID: <20260320183654-mutt-send-email-mst@kernel.org>
References: <20260312110421.2880401-1-p@1g4.org>
 <lPMoA-jSSWoNN42ejMYoDHQJVt5KGYsPsJez_Luu8zmwUWQectet-GVqS2EF89-I3k2PddYnY-ZD6z7yCQvK_AF8naIatQV1mD5Xq2671EY=@1g4.org>
 <sxJbzuV6ZQr_GHbWZNHgX7A0nnmxWSlZMO2MeJWofb8ECzmsO626OUn1izRuKxD-wqJl3LjliGPuenrLKEo8ZLpxuPimgqBjDD8ihhdd6Rg=@1g4.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <sxJbzuV6ZQr_GHbWZNHgX7A0nnmxWSlZMO2MeJWofb8ECzmsO626OUn1izRuKxD-wqJl3LjliGPuenrLKEo8ZLpxuPimgqBjDD8ihhdd6Rg=@1g4.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PesxN88Ja2-dL6GdQQRZYcm_rKQiQRcUQflqLG49Ebc_1774046239
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2026 at 09:11:18PM +0000, Paul Moses wrote:
> FYI, I'm finished with this:
> 
> preconditions:
> - local unprivileged user
> - initial network namespace only
> - existing vdpa device
> 
> impact:
> - DoS only
> - immediate netlink_ack() deref of the request skb makes controlled corruption practically unworkable
> 
> Feel free to modify patch and only give me "reported by". 
> 
> Thanks,
> Paul
> 

As I said I will apply yours and a simplification on top.

> 
> On Monday, March 16th, 2026 at 8:22 PM, Paul Moses <p@1g4.org> wrote:
> 
> > Now that I've wrapped up elsewhere, I can focus on this. Let me
> > know if there's any questions.
> > 
> > Thanks,
> > Paul
> > 
> > [    0.716942] ------------[ cut here ]------------
> > [    0.717160] refcount_t: underflow; use-after-free.
> > [    0.717356] WARNING: CPU: 2 PID: 138 at lib/refcount.c:28 refcount_warn_saturate+0x118/0x180
> > [    0.717661] Modules linked in:
> > [    0.717816] CPU: 2 UID: 1000 PID: 138 Comm: poc9 Not tainted 6.18.13 #3 PREEMPT(full)
> > [    0.718138] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [    0.718591] RIP: 0010:refcount_warn_saturate+0x118/0x180
> > [    0.718805] Code: 0f b6 05 aa bf 05 02 3c 01 0f 87 d7 db 5d ff a8 01 0f 85 39 ff ff ff 48 c7 c7 78 71 ec 82 c6 05 8c bf 05 02 01 e8 78 f0 78 ff <0f> 0b c9 31 c0 31 f6 31 ff e9 55 4c 45 ff 0f b6 05 73 bf 05 02 3c
> > [    0.719521] RSP: 0018:ffffc9000048b790 EFLAGS: 00010246
> > [    0.719722] RAX: 0000000000000000 RBX: ffff888006c74200 RCX: 0000000000000000
> > [    0.719985] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > [poc9-vdpa] port[    0.720257] RBP: ffffc9000048b798 R08: 0000000000000000 R09: 0000000000000000
> > id=135 rcvbuf=23[    0.720580] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880075ea000
> > 04 soerr=105 dro[    0.720869] R13: ffff888006c74200 R14: 00000000fffffff5 R15: ffffc9000048b920
> > ps=0 get 2/0 sen[    0.721165] FS:  000076880ed826c0(0000) GS:ffff88809a460000(0000) knlGS:0000000000000000
> > d_eagain=0
> > [    0.721534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.721768] CR2: 000076880ed801c8 CR3: 0000000008a61000 CR4: 0000000000450ef0
> > [    0.722055] PKRU: 55555554
> > [    0.722159] Call Trace:
> > [    0.722253]  <TASK>
> > [    0.722339]  sk_skb_reason_drop+0x203/0x210
> > [    0.722512]  ? up_read+0x22/0x30
> > [    0.722638]  vdpa_nl_cmd_dev_config_get_doit+0xc7/0x1d0
> > [    0.722832]  genl_family_rcv_msg_doit+0xcf/0x120
> > [    0.723018]  genl_rcv_msg+0x161/0x290
> > [    0.723157]  ? __pfx_vdpa_nl_cmd_dev_config_get_doit+0x10/0x10
> > [    0.723381]  ? __pfx_genl_rcv_msg+0x10/0x10
> > [    0.727944]  netlink_rcv_skb+0x41/0xf0
> > [    0.728136]  genl_rcv+0x28/0x50
> > [    0.728281]  netlink_unicast+0x1d8/0x2b0
> > [    0.728483]  netlink_sendmsg+0x212/0x440
> > [    0.728673]  __sys_sendto+0x1f3/0x200
> > [    0.728859]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.729076]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.729287]  ? __lock_acquire+0x831/0x2980
> > [    0.729491]  __x64_sys_sendto+0x24/0x40
> > [    0.729665]  x64_sys_call+0x1d15/0x2350
> > [    0.729838]  do_syscall_64+0x90/0xc60
> > [    0.730010]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.730226]  ? lock_acquire+0xcc/0x2e0
> > [    0.730391]  ? __folio_batch_add_and_move+0x24b/0x370
> > [    0.730623]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.730835]  ? find_held_lock+0x31/0x90
> > [    0.731010]  ? __folio_batch_add_and_move+0x1ab/0x370
> > [    0.731238]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.731465]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.731677]  ? find_held_lock+0x31/0x90
> > [    0.731851]  ? rcu_read_unlock+0x1f/0x80
> > [    0.732029]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.732247]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.732474]  ? rcu_read_unlock+0x29/0x80
> > [    0.732652]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.732864]  ? do_anonymous_page+0x101/0x840
> > [    0.733055]  ? ___pte_offset_map+0x1d2/0x290
> > [    0.733255]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.733482]  ? __handle_mm_fault+0xa8e/0xf40
> > [    0.733693]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.733904]  ? find_held_lock+0x31/0x90
> > [    0.734079]  ? exc_page_fault+0x98/0x2c0
> > [    0.734257]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.734490]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.734709]  ? do_user_addr_fault+0x37b/0x6e0
> > [    0.734905]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.735118]  ? irqentry_exit_to_user_mode+0xf4/0x300
> > [    0.735340]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.735566]  ? irqentry_exit+0x77/0xb0
> > [    0.735737]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.735949]  ? exc_page_fault+0xbf/0x2c0
> > [    0.736124]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    0.736340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [    0.736576] RIP: 0033:0x434e6c
> > [    0.736720] Code: fa 6e 03 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 40 6f 03 00 48 8b
> > [    0.737513] RSP: 002b:000076880ed80190 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> > [    0.737841] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000434e6c
> > [    0.738154] RDX: 0000000000000020 RSI: 000076880ed801d0 RDI: 0000000000000003
> > [    0.738473] RBP: 0000000069b8ab57 R08: 00000000004b3cf0 R09: 000000000000000c
> > [    0.738767] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000f71e860
> > [    0.739075] R13: 0000000000000013 R14: 000076880ed82cdc R15: 00007fff0dab68e7
> > [    0.739415]  </TASK>
> > [    0.739526] irq event stamp: 785
> > [    0.739675] hardirqs last  enabled at (793): [<ffffffff815153f0>] __up_console_sem+0x90/0xa0
> > [    0.740039] hardirqs last disabled at (800): [<ffffffff815153d5>] __up_console_sem+0x75/0xa0
> > [    0.740410] softirqs last  enabled at (362): [<ffffffff81449bcd>] __irq_exit_rcu+0x12d/0x150
> > [    0.740782] softirqs last disabled at (357): [<ffffffff81449bcd>] __irq_exit_rcu+0x12d/0x150
> > [    0.741145] ---[ end trace 0000000000000000 ]---
> > [poc9-vdpa] portid=135 rcvbuf=2304 soerr=0 drops=0 get 98859/0 send_eagain=0
> > [poc9-vdpa] portid=135 rcvbuf=2304 soerr=0 drops=0 get 204383/0 send_eagain=0
> > [poc9-vdpa] portid=135 rcvbuf=2304 soerr=0 drops=0 get 319574/0 send_eagain=0
> > [    4.037387] BUG: kernel NULL pointer dereference, address: 0000000000000060
> > [    4.037612] #PF: supervisor read access in kernel mode
> > [    4.037761] #PF: error_code(0x0000) - not-present page
> > [    4.037914] PGD 994c067 P4D 994c067 PUD 994d067 PMD 0
> > [    4.038066] Oops: Oops: 0000 [#1] SMP NOPTI
> > [    4.038191] CPU: 4 UID: 1000 PID: 140 Comm: poc9 Tainted: G        W           6.18.13 #3 PREEMPT(full)
> > [    4.038463] Tainted: [W]=WARN
> > [    4.038557] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [    4.038869] RIP: 0010:sock_wfree+0x1d/0x3f0
> > [    4.038994] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 83 ec 10 48 8b 5f 18 44 8b 97 d8 00 00 00 <48> 8b 43 60 f6 c4 02 74 51 44 89 d0 44 89 d2 48 8d 8b 94 02 00 00
> > [    4.039511] RSP: 0018:ffffc9000049b8f0 EFLAGS: 00010286
> > [    4.039665] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [    4.039874] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801f8aa100
> > [    4.040076] RBP: ffffc9000049b918 R08: 0000000000000000 R09: 0000000000000000
> > [    4.040278] R10: 00000000000003c0 R11: 0000000000000000 R12: ffff8880075ea000
> > [    4.040482] R13: ffff88801f8aa100 R14: 00000000fffffff5 R15: ffffc9000049baf0
> > [    4.040685] FS:  000076880dd806c0(0000) GS:ffff88809a560000(0000) knlGS:0000000000000000
> > [    4.040908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.041071] CR2: 0000000000000060 CR3: 0000000008a61000 CR4: 0000000000450ef0
> > [    4.041275] PKRU: 55555554
> > [    4.041356] Call Trace:
> > [    4.041434]  <TASK>
> > [    4.041502]  unix_destruct_scm+0x77/0x90
> > [    4.041620]  skb_release_head_state+0x27/0xb0
> > [    4.041750]  sk_skb_reason_drop+0x55/0x210
> > [    4.041868]  ? up_read+0x22/0x30
> > [    4.041976]  vdpa_nl_cmd_dev_config_get_doit+0xc7/0x1d0
> > [    4.042140]  genl_family_rcv_msg_doit+0xcf/0x120
> > [    4.042280]  genl_rcv_msg+0x161/0x290
> > [    4.042387]  ? __pfx_vdpa_nl_cmd_dev_config_get_doit+0x10/0x10
> > [    4.042558]  ? __pfx_genl_rcv_msg+0x10/0x10
> > [    4.042679]  netlink_rcv_skb+0x41/0xf0
> > [    4.042798]  genl_rcv+0x28/0x50
> > [    4.042892]  netlink_unicast+0x1d8/0x2b0
> > [    4.043009]  netlink_sendmsg+0x212/0x440
> > [    4.043127]  __sys_sendto+0x1f3/0x200
> > [    4.043238]  ? __sys_sendto+0x1aa/0x200
> > [    4.043351]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.043493]  ? x64_sys_call+0x1d15/0x2350
> > [    4.043610]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.043747]  ? do_syscall_64+0x1b5/0xc60
> > [    4.043867]  __x64_sys_sendto+0x24/0x40
> > [    4.043979]  x64_sys_call+0x1d15/0x2350
> > [    4.044091]  do_syscall_64+0x90/0xc60
> > [    4.044200]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.044337]  ? x64_sys_call+0x1d15/0x2350
> > [    4.044456]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.044597]  ? do_syscall_64+0x1b5/0xc60
> > [    4.044712]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.044851]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.044990]  ? x64_sys_call+0x1d15/0x2350
> > [    4.045106]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.045243]  ? do_syscall_64+0x1b5/0xc60
> > [    4.045358]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.045498]  ? x64_sys_call+0x1d15/0x2350
> > [    4.045614]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.045750]  ? do_syscall_64+0x1b5/0xc60
> > [    4.045863]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.046007]  ? do_syscall_64+0x1b5/0xc60
> > [    4.046121]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [    4.046259]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [    4.046407] RIP: 0033:0x434e6c
> > [    4.046500] Code: fa 6e 03 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c3 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 df 48 89 44 24 08 e8 40 6f 03 00 48 8b
> > [    4.047008] RSP: 002b:000076880dd7e190 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> > [    4.047218] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000434e6c
> > [    4.047420] RDX: 0000000000000020 RSI: 000076880dd7e1d0 RDI: 0000000000000003
> > [    4.047618] RBP: 0000000069b93bd6 R08: 00000000004b3cf0 R09: 000000000000000c
> > [    4.047816] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000f71e860
> > [    4.048023] R13: 0000000000000013 R14: 000076880dd80cdc R15: 00007fff0dab68e7
> > [    4.048228]  </TASK>
> > [    4.048295] Modules linked in:
> > [    4.048387] CR2: 0000000000000060
> > [    4.048494] ---[ end trace 0000000000000000 ]---
> > [    4.059378] RIP: 0010:sock_wfree+0x1d/0x3f0
> > [    4.059511] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 53 48 83 ec 10 48 8b 5f 18 44 8b 97 d8 00 00 00 <48> 8b 43 60 f6 c4 02 74 51 44 89 d0 44 89 d2 48 8d 8b 94 02 00 00
> > [    4.060019] RSP: 0018:ffffc9000049b8f0 EFLAGS: 00010286
> > [    4.060168] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [    4.060367] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801f8aa100
> > [    4.060574] RBP: ffffc9000049b918 R08: 0000000000000000 R09: 0000000000000000
> > [    4.060776] R10: 00000000000003c0 R11: 0000000000000000 R12: ffff8880075ea000
> > [    4.060978] R13: ffff88801f8aa100 R14: 00000000fffffff5 R15: ffffc9000049baf0
> > [    4.061183] FS:  000076880dd806c0(0000) GS:ffff88809a560000(0000) knlGS:0000000000000000
> > [    4.061416] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.061579] CR2: 0000000000000060 CR3: 0000000008a61000 CR4: 0000000000450ef0
> > [    4.061782] PKRU: 55555554
> > [    4.061863] Kernel panic - not syncing: Fatal exception
> > [    4.062096] Kernel Offset: disabled
> > [    4.062204] Rebooting in 1 seconds..
> > 


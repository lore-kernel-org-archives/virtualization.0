Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A71C84D6
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 07:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775067; cv=none; b=ejwZ/EUho6ZShJFKLBlzpfyiLPvqVwphDPkX2eDAG7pQLk/4h7Ho7Yof1ErMQN01CEv5qXFgeb3lEn8Inf6RtpZZ8W7Atl4q+2foX0CZXHZZ/g8u/7LFxjq4l7niCUobfeM0po7fUxRHj855Qo55hhOWI1Ire1+67aCdiILRUlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775067; c=relaxed/simple;
	bh=dyiGK4DqNe7kPZ6VmMcv/MYNSURoRRN7GbgZVgXGWuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfuHMjgtAA8uW8vFRVhsTjgw0Hw3XlVNlBLjp8pR3qZ3fyHql24gLy+r587XYttL6oAUt0tOdAoe+WMEr3O5P+XxPay+z+hky6Vp6jKUkoQP0KywiuKh63k/x2UA8h9rpn2aF9j8mkka7yZSyhafaQai14VviEUm+ylSjPUOz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f989TDkf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f989TDkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753775064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88syDxS7vDDsk5BDyBeMg2TdAJ6UBls0dz/LG9t30Vo=;
	b=f989TDkfYJvYHZadL7i5gGs6is1zi9eZ3iKRgLvDnVT5qfC7Q3DxH5r74Nc+RP23UP6iun
	njRvFpfCUD3xlsGIYi3yB60AXf+Yfb4YFNH8KosWR/eNj0hQWCKmNKrOQz5W+ou+hVbh27
	UqtyGQoIU5TQjML0mQGQkL88VkYcAvU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-gPRamS18PWGo61mze8d4KA-1; Tue, 29 Jul 2025 03:44:22 -0400
X-MC-Unique: gPRamS18PWGo61mze8d4KA-1
X-Mimecast-MFC-AGG-ID: gPRamS18PWGo61mze8d4KA_1753775062
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23638e1605dso41716805ad.0
        for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 00:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775062; x=1754379862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88syDxS7vDDsk5BDyBeMg2TdAJ6UBls0dz/LG9t30Vo=;
        b=PvITlUm3SgtKilKJcev4MjWNhiQ7VraBrvbIS3zShniG5Tbw9yzG9wxSwh5+t9/V/K
         bWpo7VgZ6qJ4FUNlkf9Hwlb7W8gWE/AUg7EiUzyD82vkcC7AM3P3LPoeeEnVcUmzShMe
         UEkmViXL0FBzSFK4I9sdHO7f1GkojqRpjqDcr+sIpRwFaeG1jUvBRMUWKl7kzX6PaKqg
         UfcrvALQnPjg9KF3sDHEkRP7ei4CTMZDU/bA9D5dp+CbkPqT/kwMbCJwIhVUSGpa0ZXs
         rinwCG1hGwmK0OXip7k9t1jGhD0sTABLlR7ti9N7XKavD4KWSx0sazAuazfBdboG0ya+
         Mrlw==
X-Forwarded-Encrypted: i=1; AJvYcCVqPIL0yBbs3prUnm/NllBwG3VU81nuhH/Fi+ySlXgMx3G3jCycZLiKNoiK+Rt3PRunMYcexwQQlotel9vptQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxW/Rq3exZ/cKyZ1kk9NEVdLs357IW7DOlM0rBMIGZCCVX257IO
	lxe6Vef/SXpXTpzOU1rYwRPAz48UKEoi7eOGYkZNpxjUwt903B5/AG7zApmSzEsjzr5NpbVQqa7
	d9zAy9kk+YFJnPLVqTpLWnvzVNLb7mSzTedQkTcXFLnXH3Yc0YXa63qBrHbIBSO4ziW6yLhZ26I
	7TIKGZsm3PipTAEbqu0riJ1JFTarkqfy8SUZI0g2ZBKzQ=
X-Gm-Gg: ASbGncvwLpwGeQHV9DD8jFLTqvopLfjGRiJE0EkbnXrHhAOPG3zNxhicfRUQLY4SodD
	z4Csaih2y8gEfz9PhoGSwzUc6kbMYdtc/F0N2C3OfU6kSYhfREeW9bhkxxmNO5G4nJNqb4exB2T
	oCiZtdIYS8Mo1n3TOOs+m+UQ==
X-Received: by 2002:a17:903:fa3:b0:235:f298:cbbd with SMTP id d9443c01a7336-23fb30ac008mr247732555ad.21.1753775061585;
        Tue, 29 Jul 2025 00:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHuYlex1cEb8RIST85ReAXq2m5E1nNciybZWdJsmd2xRcAEtdMBLIiQb5jqnfhOKYl5YBz4BLsR3zB+0t6bG4=
X-Received: by 2002:a17:903:fa3:b0:235:f298:cbbd with SMTP id
 d9443c01a7336-23fb30ac008mr247732065ad.21.1753775061042; Tue, 29 Jul 2025
 00:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1b28a10e-0cff-405e-9106-0c20e70854f9@linux.ibm.com> <c2bba86f-d9d2-4bab-97e4-d983bffbb485@linux.ibm.com>
In-Reply-To: <c2bba86f-d9d2-4bab-97e4-d983bffbb485@linux.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 15:44:09 +0800
X-Gm-Features: Ac12FXwkw_WDh6m3kZRveRMBbGdfdy-TUoBAoEJlxUImf9DlXn6-BKy_ShBwr3A
Message-ID: <CACGkMEu+Qn06bmp6br699Gk6SxTbSDZCW8mQ0qFUfDZUpAx62A@mail.gmail.com>
Subject: Re: vhost: linux-next: kernel crash at vhost_dev_cleanup/kfree
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jonah.palmer@oracle.com, 
	Eric Farman <farman@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nS_yiuhZLuWDi396pyGZYNPA-5fMJQtMC5Lau_r5Txc_1753775062
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 5:25=E2=80=AFAM JAEHOON KIM <jhkim@linux.ibm.com> w=
rote:
>
>
> Dear Jason Wang,
>
> I would like to kindly report a kernel crash issue on our s390x server
> which seems to be related to the following patch.
> -------------------------------------------------------------------------=
-------------------------------------------------
>    commit 7918bb2d19c9 ("vhost: basic in order support")
> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/commit/?id=
=3D7918bb2d19c9
> -------------------------------------------------------------------------=
-------------------------------------------------
>
> This patch landed in linux-next between July 16th and 17th. Since then,
> kernel crash have been observed during stress testing.
> The issue can be confirmed using the following command:
> -------------------------------------------
>    stress-ng --dev 1 -t 10s
> -------------------------------------------

Right, I forgot to initialize vq->nheads in vhost_dev_init().

I've posted a fix here:

https://lore.kernel.org/virtualization/20250729073916.80647-1-jasowang@redh=
at.com/T/#u

Thanks

>
> Crash log and call stack are as follows.
> Additionally, this crash appears similar to the issue discussed in the
> following thread:
> https://lore.kernel.org/kvm/bvjomrplpsjklglped5pmwttzmljigasdafjiizt2sfmy=
tc5rr@ljpu455kx52j/
>
> [ 5413.029569] Unable to handle kernel pointer dereference in virtual
> kernel address space
> [ 5413.029573] Failing address: 00000328856e8000 TEID: 00000328856e8803
> [ 5413.029576] Fault in home space mode while using kernel ASCE.
> [ 5413.029580] AS:0000000371fdc007 R3:0000000000000024
> [ 5413.029607] Oops: 003b ilc:3 [#1]SMP
>    .......
> [ 5413.029655] CPU: 23 UID: 0 PID: 2339 Comm: stress-ng-dev Not tainted
> 6.16.0-rc6-10099-g60a66ed35d6b #63 NONE
> [ 5413.029659] Hardware name: IBM 3906 M05 780 (LPAR)
> [ 5413.029662] Krnl PSW : 0704e00180000000 0000032714b9f156
> (kfree+0x66/0x340)
> [ 5413.029673]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2
> PM:0 RI:0 EA:3
> [ 5413.029677] Krnl GPRS: 0000000000000002 0000008c056e8000
> 0000262500000000 0000000085bf4610
> [ 5413.029681]            0000000085bf4660 0000000085bf4618
> 0000032716402270 0000032694e0391a
> [ 5413.029683]            0000032716402290 0000032714720000
> 00000328856e8000 0000262500000000
> [ 5413.029685]            000003ff8312cfa8 0000000000000000
> 000023015ba00000 000002a71e8d3ba8
> [ 5413.029697] Krnl Code: 0000032714b9f146: e3e060080008 ag %r14,8(%r6)
> [ 5413.029697]            0000032714b9f14c: ec1e06b93a59 risbgn
> %r1,%r14,6,185,58
> [ 5413.029697]           #0000032714b9f152: b90800a1 agr %r10,%r1
> [ 5413.029697]           >0000032714b9f156: e320a0080004 lg      %r2,8(%r=
10)
> [ 5413.029697]            0000032714b9f15c: a7210001 tmll    %r2,1
> [ 5413.029697]            0000032714b9f160: a77400e0 brc 7,0000032714b9f3=
20
> [ 5413.029697]            0000032714b9f164: c004000000ca brcl
> 0,0000032714b9f2f8
> [ 5413.029697]            0000032714b9f16a: 95f5a030 cli 48(%r10),245
> [ 5413.029738] Call Trace:
> [ 5413.029741]  [<0000032714b9f156>] kfree+0x66/0x340
> [ 5413.029747]  [<0000032694e0391a>] vhost_dev_free_iovecs+0x9a/0xc0 [vho=
st]
> [ 5413.029757]  [<0000032694e05406>] vhost_dev_cleanup+0xb6/0x210 [vhost]
> [ 5413.029763]  [<000003269507000a>] vhost_vsock_dev_release+0x1aa/0x1e0
> [vhost_vsock]
> [ 5413.029768]  [<0000032714c16ece>] __fput+0xee/0x2e0
> [ 5413.029774]  [<00000327148c0488>] task_work_run+0x88/0xd0
> [ 5413.029783]  [<00000327148977aa>] do_exit+0x18a/0x4e0
> [ 5413.029786]  [<0000032714897cf0>] do_group_exit+0x40/0xc0
> [ 5413.029789]  [<0000032714897dce>] __s390x_sys_exit_group+0x2e/0x30
> [ 5413.029792]  [<00000327156519c6>] __do_syscall+0x136/0x340
> [ 5413.029797]  [<000003271565d5de>] system_call+0x6e/0x90
> [ 5413.029802] Last Breaking-Event-Address:
> [ 5413.029803]  [<0000032694e03914>] vhost_dev_free_iovecs+0x94/0xc0 [vho=
st]
> [ 5413.029811] Kernel panic - not syncing: Fatal exception: panic_on_oops
>
>
> Best regards,
> Jaehoon Kim
>


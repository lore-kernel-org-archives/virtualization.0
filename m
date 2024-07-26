Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCE9748A
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026928; cv=none; b=A6kEHZ3UpY1U/9qsisVvnYqZhL/CAYBRqn0rUToOuxuZ0HZTmHQq4QTx/f98LS1i1bQLZilf3w03+CpYFichqSAjAbQZSs9X3ovDRqUxfTWsS4bmM/MF9Udl5ubvrBW0HTqbDRbnETKsjgf/YhH44/Bx+8E4KUQcHBFuKaQwu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026928; c=relaxed/simple;
	bh=0ptgAo76sEALm0wWfTfRkIhC3WoPOl25PxfbjjWdvOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=scdnDlpSKI0wdYH+iETIm81MgNOzL5fIwVxLvyXVRtcEp8DJf/Dfi3eyM5fHz2rOkbFWzmCdkn777OZx4f/f6Foa9n76V4qCIi/ArEPpLkTho4IufwnelTj+4iagyrfy1JRcxPQ53Oyt/ngHNcuh9YR0fCQseKOjzR0G+6V40uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYc+4LEx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYc+4LEx"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so3408253a12.3
        for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026925; x=1722631725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=;
        b=NYc+4LExPTDOKGnsgKlL7FLw6MyOIYGCew3XwJ+z1FNUt3eUcYwDFyJT7JaCG0A6gt
         fAKGkWsf6E5ojEvdDtJDukCJPQpqdGdwMpVHwvsXWf+3hrCvjZNuFLSxUzwkoLY3qgxZ
         /ekS1eJmAeU601Y7aJToexiaIbvNjzyljv8hyFEdwlZLkRxL/x4Cvh4vW7e4zJvfATXf
         xHEqWTpB+KKEriLYptOqAyZppqS3uWoM6WVVyZfOQVx4gvUo0BfPd5f3HWPbSM9KLUl7
         PWpbxrV7giSJQvBxlsyUOhtki2xLBadNWhjIDfJyQnDO/HvA/sx2gHcUUBYltyLaoe50
         KYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026925; x=1722631725;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBMgfixy+x8J4chK+XEr8yM6u1+DycWp9/E02fNR+AA=;
        b=PXLdUcJtjCcEf+IV7Viq8UH5RQG0R6jvmEMacFQTqRL7WgyXAkoqL+dJ8VOclIX2z0
         uqXTHHPHNgxjYqHtNWt04r8TM0jNrattn7YlUHyNBaQknhsQ730gLz7KtBnE6tLrXk6+
         3tMYJmiINokAUSNMVXFsixmrOczosGKeft/pxzi2iYeUqBJztH4Ba7wVX7fuxMPk7SvB
         mnHPB1rxLuBaZOytHWi4kWi+u13c2VHNLcUNuk20a1i9NuVg9vKoRez/k63SVvqidKgm
         9RbJSW9JMQSCmaBFj907gnUca7/bGry27P0jl67GiYT4G1mxaIgXApc5fSS/t470iKQu
         siSw==
X-Forwarded-Encrypted: i=1; AJvYcCXo2CmMsMooYUjak2iw7JESR2rgHo6q+pPoOIvZ3nFZGOMjUJ1p/Z3lMtsYpNGiv4DzeuyVUVcA1Jk1I4R/5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YytPX+469kG4zstq4gPbuzufHveiyOsXfisrzbLPbASM55/mMc7
	rDaY9z8UgRO+2RXpVYiOaoV9d2F3KLJ2NfcB//tpJLa0khFcNmGd
X-Google-Smtp-Source: AGHT+IH/Wk3yKHVOGm6Q2V0uGvjeJYCJriHVdyxX3OVHO2TxkE0uWiwh2D6R3c+mhA8SO2IVFuazNQ==
X-Received: by 2002:a17:907:72cc:b0:a7a:9d74:21c3 with SMTP id a640c23a62f3a-a7d400a1a61mr52676966b.35.1722026924592;
        Fri, 26 Jul 2024 13:48:44 -0700 (PDT)
Received: from shift.daheim (p200300d5ff30930050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff30:9300:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2302dsm212952766b.39.2024.07.26.13.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:48:44 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=shift.localnet)
	by shift.daheim with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <chunkeey@gmail.com>)
	id 1sXSkR-00000000zGU-3SKI;
	Fri, 26 Jul 2024 22:48:43 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: hch@lst.de
Cc: axboe@kernel.dk, dlemoal@kernel.org, jasowang@redhat.com,
 kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, martin.petersen@oracle.com, mst@redhat.com,
 pbonzini@redhat.com, sagi@grimberg.me, stefanha@redhat.com,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/15] block: add an API to atomically update queue limits
Date: Fri, 26 Jul 2024 22:48:43 +0200
Message-ID: <2011786.tdWV9SEqCh@shift>
In-Reply-To: <20240213073425.1621680-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

got a WARNING splatch (=> boot harddrive is inaccessible - device fails to boot) 

------------[ cut here ]------------
WARNING: CPU: 0 PID: 29 at block/blk-settings.c:185 blk_validate_limits+0x154/0x294
Modules linked in:
CPU: 0 PID: 29 Comm: kworker/u4:2 Tainted: G        W          6.10.0+ #1
Hardware name: MyBook Live APM821XX 0x12c41c83 PowerPC 44x Platform
Workqueue: async async_run_entry_fn
NIP:  c02f1f00 LR: c02eef3c CTR: 00000000
REGS: c114bbc0 TRAP: 0700   Tainted: G        W           (6.10.0+)
MSR:  0002b000 <CE,EE,FP,ME>  CR: 84000008  XER: 00000000

GPR00: c02eef28 c114bcb0 c116cf40 c114bda8 00000082 ffffffff ffffffff 00000200
GPR08: 00000200 0000ffff 00001fff c114bc80 44000008 00000000 c00433f0 c119b440
GPR16: 00000000 00000000 00000000 00000000 c105d505 c1101880 c11b6250 00000001
GPR24: 00000000 c0ab0000 c114bda8 ffffffff c0a1eb68 00000000 00000014 c1b683d0
NIP [c02f1f00] blk_validate_limits+0x154/0x294
LR [c02eef3c] blk_alloc_queue+0x80/0x1f0
Call Trace:
[c114bcb0] [c02ffa54] blk_alloc_queue_stats+0x20/0x48 (unreliable)
[c114bcc0] [c02eef28] blk_alloc_queue+0x6c/0x1f0
[c114bcf0] [c02fde24] blk_mq_alloc_queue+0x50/0xa8
[c114bd90] [c04393b4] scsi_alloc_sdev+0x190/0x2b8
[c114be40] [c04395a8] scsi_probe_and_add_lun+0xcc/0x2a0
[c114bea0] [c043a008] __scsi_add_device+0xe4/0x134
[c114bee0] [c045296c] ata_scsi_scan_host+0x84/0x27c
[c114bf30] [c0048158] async_run_entry_fn+0x34/0xcc
[c114bf50] [c003c800] process_scheduled_works+0x170/0x244
[c114bf90] [c003cc48] worker_thread+0x184/0x1d4
[c114bfc0] [c00434bc] kthread+0xcc/0xd0
[c114bff0] [c000c210] start_kernel_thread+0x10/0x14
Code: 81430050 7c085040 40810008 91030050 81430004 2c0a0000 40820010 3940ffff 91430004 48000014 280a3ffe 41a1000c <0fe00000> 48000130 80c30008 81430020
---[ end trace 0000000000000000 ]---
scsi_alloc_sdev: Allocation failure during SCSI scanning, some SCSI devices might not be configured

---

This is due to this patch adds
| /*
|   * By default there is no limit on the segment boundary alignment,
|   * but if there is one it can't be smaller than the page size as
|   * that would break all the normal I/O patterns.
|   */
|   if (!lim->seg_boundary_mask)
|           lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
|   if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1)) <----- this warning gets triggered
|          return -EINVAL;

My guess is that this is caused by the kernel has a 16K page size.

CONFIG_HAVE_PAGE_SIZE_16KB=y
CONFIG_PAGE_SIZE_16KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=14

This worked fine (sata driver is sata_dwc_460ex.c) in the past (and using 16K pages was
slightly faster than 4k pages)... and yes: using a 4K page size works (as in: device boots again).

Regards,
Christian



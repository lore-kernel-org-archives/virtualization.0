Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC38EB64DA
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 17:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24CA042069;
	Thu, 22 Jun 2023 17:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24CA042069
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyaqYcpl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mt7stkO6qdXL; Thu, 22 Jun 2023 17:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6FB87423DD;
	Thu, 22 Jun 2023 17:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6FB87423DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17460C0037;
	Thu, 22 Jun 2023 17:52:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C278DC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 17:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 956134208A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 17:52:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 956134208A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dxc5x5ZgfqK3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 17:52:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B64D42069
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B64D42069
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 17:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687456359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=46vg04rCWqnBcEfjOgg6c4cwQ2Em/pBNIxUfI3u2wTo=;
 b=eyaqYcplzRGHLExkkuYd9Jrtz+FJHoZ97kRrpVuknZa5wXqrLfe7PyUD7iILot5q7okq4T
 8nvn8uuppWc9h2wa6GEoN4V91V0NaP0O5mFbF/8nZ1wO/rqHPiWjQtN2gy3syDw7IirHEm
 S8AFil5eCHiXWUrSVNBlvgJ0uuRyHlc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-_Xy6wuorM_K7i1pPar_Wbg-1; Thu, 22 Jun 2023 13:52:37 -0400
X-MC-Unique: _Xy6wuorM_K7i1pPar_Wbg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-987a0365f77so379401966b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 10:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687456356; x=1690048356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46vg04rCWqnBcEfjOgg6c4cwQ2Em/pBNIxUfI3u2wTo=;
 b=GPy0SrHoeU+JEz1sIG/eliwcf/XqcbevWlIFwsV9m5GdWKqFDL3BLKPAhE1GtRodRO
 89l2mac4/vKFuPK0m6kumfLUv7w2TZxinmZhDtoERAKzRwbL3B0iVGcwLL+Mx6tKoB5P
 bTDDGEIvg1QvyELD49nZRhXTD8yPMSZQDY+XcyJmEQXelZa5cS5WxTZC1Lzy7BmINMVT
 erXTqZBPbBULbE5i5YAcLQ0t8jkXYISRptn//soOQJP7PWdMUoB+SrYi6b/G+fTR81R2
 5Abgjj5aPtU5KLDrpmMGT7/eGE1uilr2kYe7wCBAd3UROdjBQsSelwCnjZqdZwGkRo8l
 bkhA==
X-Gm-Message-State: AC+VfDz+si5f9p86VxwYv+1CLfJY1Yl2LpoztWEXTEcSBim4xJZoG1/r
 00WGrOmP4lWQLs13/fxdHAmdM2ktN+nS45+d5En2OeTsr//6l/UxGl9serHLy11pC6bGyxy9cNr
 3Nc+C6s2KxdagtOcFbk//fGcgiWwo8OlLq2IwWxlmww==
X-Received: by 2002:a17:907:7e95:b0:987:350e:771a with SMTP id
 qb21-20020a1709077e9500b00987350e771amr15915299ejc.72.1687456356694; 
 Thu, 22 Jun 2023 10:52:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6exKxf71yvlJ+qFOwdh0qxw8LT5S9YrIKwORF8ZM/FRULuUP7x2/Rc12hOO4HPKl6m++Z+jg==
X-Received: by 2002:a17:907:7e95:b0:987:350e:771a with SMTP id
 qb21-20020a1709077e9500b00987350e771amr15915291ejc.72.1687456356347; 
 Thu, 22 Jun 2023 10:52:36 -0700 (PDT)
Received: from redhat.com ([2.52.149.110]) by smtp.gmail.com with ESMTPSA id
 s17-20020a170906bc5100b009889baa6a34sm4864089ejv.48.2023.06.22.10.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 10:52:35 -0700 (PDT)
Date: Thu, 22 Jun 2023 13:52:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Edward Liaw <edliaw@google.com>
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <20230622135204-mutt-send-email-mst@kernel.org>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
 <ZJIuG9hyTYIIDbF5@google.com>
MIME-Version: 1.0
In-Reply-To: <ZJIuG9hyTYIIDbF5@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 kernel test robot <lkp@intel.com>, "Roberts,
 Martin" <martin.roberts@intel.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Suwan Kim <suwan.kim027@gmail.com>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Jun 20, 2023 at 10:54:19PM +0000, Edward Liaw wrote:
> On Fri, Jun 09, 2023 at 03:27:24AM -0400, Michael S. Tsirkin wrote:
> > This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
> This commit was also breaking kernel tests on a virtual Android device
> (cuttlefish).  We were seeing hangups like:
> 
> [ 2889.910733] INFO: task kworker/u8:2:6312 blocked for more than 720 seconds.
> [ 2889.910967]       Tainted: G           OE      6.2.0-mainline-g5c05cafa8df7-ab9969617 #1
> [ 2889.911143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2889.911389] task:kworker/u8:2    state:D stack:12160 pid:6312  ppid:2      flags:0x00004000
> [ 2889.911567] Workqueue: writeback wb_workfn (flush-254:57)
> [ 2889.911771] Call Trace:
> [ 2889.911831]  <TASK>
> [ 2889.911893]  __schedule+0x55f/0x880
> [ 2889.912021]  schedule+0x6a/0xc0
> [ 2889.912110]  schedule_timeout+0x58/0x1a0
> [ 2889.912200]  wait_for_common+0xf7/0x1b0
> [ 2889.912289]  wait_for_completion+0x1c/0x40
> [ 2889.912377]  f2fs_issue_checkpoint+0x14c/0x210
> [ 2889.912504]  f2fs_sync_fs+0x4c/0xb0
> [ 2889.912597]  f2fs_balance_fs_bg+0x2f6/0x340
> [ 2889.912736]  ? can_migrate_task+0x39/0x2b0
> [ 2889.912872]  f2fs_write_node_pages+0x77/0x240
> [ 2889.912989]  do_writepages+0xde/0x240
> [ 2889.913094]  __writeback_single_inode+0x3f/0x360
> [ 2889.913231]  writeback_sb_inodes+0x320/0x5f0
> [ 2889.913349]  ? move_expired_inodes+0x58/0x210
> [ 2889.913470]  __writeback_inodes_wb+0x97/0x100
> [ 2889.913587]  wb_writeback+0x17e/0x390
> [ 2889.913682]  wb_workfn+0x35f/0x500
> [ 2889.913774]  process_one_work+0x1d9/0x3b0
> [ 2889.913870]  worker_thread+0x251/0x410
> [ 2889.913960]  kthread+0xeb/0x110
> [ 2889.914052]  ? __cfi_worker_thread+0x10/0x10
> [ 2889.914168]  ? __cfi_kthread+0x10/0x10
> [ 2889.914257]  ret_from_fork+0x29/0x50
> [ 2889.914364]  </TASK>
> [ 2889.914565] INFO: task mkdir09:6425 blocked for more than 720 seconds.
> [ 2889.916065]       Tainted: G           OE      6.2.0-mainline-g5c05cafa8df7-ab9969617 #1
> [ 2889.916255] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 2889.916450] task:mkdir09         state:D stack:13016 pid:6425  ppid:6423   flags:0x00004000
> [ 2889.916656] Call Trace:
> [ 2889.916900]  <TASK>
> [ 2889.917004]  __schedule+0x55f/0x880
> [ 2889.917129]  schedule+0x6a/0xc0
> [ 2889.917273]  schedule_timeout+0x58/0x1a0
> [ 2889.917425]  wait_for_common+0xf7/0x1b0
> [ 2889.917535]  wait_for_completion+0x1c/0x40
> [ 2889.917670]  f2fs_issue_checkpoint+0x14c/0x210
> [ 2889.917844]  f2fs_sync_fs+0x4c/0xb0
> [ 2889.917969]  f2fs_do_sync_file+0x3a8/0x8c0
> [ 2889.918090]  ? mt_find+0xa0/0x1a0
> [ 2889.918216]  f2fs_sync_file+0x2f/0x60
> [ 2889.918310]  vfs_fsync_range+0x74/0x90
> [ 2889.918567]  __se_sys_msync+0x176/0x270
> [ 2889.918730]  __x64_sys_msync+0x1c/0x40
> [ 2889.918873]  do_syscall_64+0x53/0xb0
> [ 2889.918996]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [ 2889.919178] RIP: 0033:0x7540b08bcf47
> [ 2889.919297] RSP: 002b:00007fff5fcbeea8 EFLAGS: 00000206 ORIG_RAX: 000000000000001a
> [ 2889.919496] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007540b08bcf47
> [ 2889.919828] RDX: 0000000000000004 RSI: 0000000000001000 RDI: 00007540b4ae7000
> [ 2889.920227] RBP: 0000000000000000 R08: 721e0000010b0016 R09: 0000000000000003
> [ 2889.920435] R10: 0000000000000100 R11: 0000000000000206 R12: 00005d2f95fd2f08
> [ 2889.920793] R13: 00005d2f95fbc310 R14: 00007540b08e1bb8 R15: 00005d2f95fbc310
> [ 2889.921072]  </TASK>
> 
> in random tests in the LTP (linux test project) test suite.
> 
> > ---
> > 
> > Since v1:
> > 	fix build error
> > 
> > Still completely untested as I'm traveling.
> > Martin, Suwan, could you please test and report?
> > Suwan if you have a better revert in mind pls post and
> > I will be happy to drop this.
> > 
> > Thanks!
> > 
> This revert appears to have resolved the test failures for me.
> 
> Tested-by: edliaw@google.com


Does Android have VIRTIO_BLK_F_ZONED ? Could you list the
features this device has please? Thanks!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

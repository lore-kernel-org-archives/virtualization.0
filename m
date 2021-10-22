Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37205C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:48:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD1E60F46
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 09:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCD1E60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F8C783AFD;
	Fri, 22 Oct 2021 09:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nMfGs1vQrhkP; Fri, 22 Oct 2021 09:48:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2890F83AEA;
	Fri, 22 Oct 2021 09:48:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF2EEC001F;
	Fri, 22 Oct 2021 09:48:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F589C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:48:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33B9C60675
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:48:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h8cipaeJ2PR6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:48:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6345D60665
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 09:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634896106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9T8B018h78tAIOUbGw7DY/sbBrHy3hSwuPRlF8fWKY=;
 b=hmednXfqlYx50/lvfqcblUswjvqnLBXHtGoF6n6I1DaMLMjUJ9qMYseosGrHBA37X4DXcn
 xLL0AtowL09cNU3Oq3N758gTgaqOEjL8QdgoV6ImdYq1wRRacr6/eVjxPEeilL68nxPPUD
 lmrBe8DKwUsDw25W71joEbC5vEyDYD4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-hcUuSE0hOg6CaYwcBHpvAA-1; Fri, 22 Oct 2021 05:48:24 -0400
X-MC-Unique: hcUuSE0hOg6CaYwcBHpvAA-1
Received: by mail-wr1-f72.google.com with SMTP id
 x1-20020adfffc1000000b001679fc9c018so777360wrs.18
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 02:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W9T8B018h78tAIOUbGw7DY/sbBrHy3hSwuPRlF8fWKY=;
 b=zBVxJGCPBAvUzWLltb3pr632oyjgpOjiZYFRNHpPFy4eTbyH5Xa36dChMrIHneutTi
 OxkMdlEhrYesf//GcA54mZwZ9pPKHI6S2h2Y2X9XXqEFUZW5RVNKr5HWrHw5bH4P8B7j
 u86ZV3liyskKqd0cZx3NyePPNRgvWjZB+CcYaJp5Z3YhNoyq+K2K21TUPocd9OCsgY52
 AUYjMwboKkZGxPs4fqaCBu/CCsl1WXL/caSdBUKpuZLl/FB9RYq5xAfv1Pq5fw3WNu18
 lruTx9BEREhkPxb7jdseaLzAgmJlxnc4WeU/IbZNz6M7KudLy8nNFO1CD7gdftV/c9KL
 Wo8Q==
X-Gm-Message-State: AOAM530lS/SFvoWuTgL3vbGTxV6VYB9iZMKs/dv55GWYsjoAdIrH/lVM
 3hzz5DaYrIkGUuVPTWyP5HrY4FzUX79imluv5AaTULzFPRI+ymzmI+eBizOsJNyma45h1OdUR0j
 LAwicDUN1+KwjwTZy5e597QqM99mCWZVm8jpfi+zx8A==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr13896849wrp.117.1634896103280; 
 Fri, 22 Oct 2021 02:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLnEzXyZnIH2I896CP+ucefqoe5BtlT1z2DOdAq4RH4UEuXUz/gmRg1JCXs+m4D8ZaqZDE3g==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr13896831wrp.117.1634896103097; 
 Fri, 22 Oct 2021 02:48:23 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id 186sm10973877wmc.20.2021.10.22.02.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Oct 2021 02:48:22 -0700 (PDT)
Date: Fri, 22 Oct 2021 05:48:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V3 00/11] vhost: multiple worker support
Message-ID: <20211022054625-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20211022051911.108383-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Fri, Oct 22, 2021 at 12:18:59AM -0500, Mike Christie wrote:
> The following patches apply over linus's tree and this patchset
> 
> https://lore.kernel.org/all/20211007214448.6282-1-michael.christie@oracle.com/
> 
> which allows us to check the vhost owner thread's RLIMITs:


Unfortunately that patchset in turn triggers kbuild warnings.
I was hoping you would address them, I don't think
merging that patchset before kbuild issues are addressed
is possible.

It also doesn't have lots of acks, I'm a bit apprehensive
of merging core changes like this through the vhost tree.
Try to CC more widely/ping people?

> It looks like that patchset has been ok'd by all the major parties
> and just needs a small cleanup to apply to Jens and Paul trees, so I
> wanted to post my threading patches based over it for review.
> 
> The following patches allow us to support multiple vhost workers per
> device. I ended up just doing Stefan's original idea where userspace has
> the kernel create a worker and we pass back the pid. This has the benefit
> over the workqueue and userspace thread approach where we only have
> one'ish code path in the kernel during setup to detect old tools. The
> main IO paths and device/vq setup/teardown paths all use common code.
> 
> I've also included a patch for qemu so you can get an idea of how it
> works. If we are ok with the kernel code then I'll break that up into
> a patchset and send to qemu-devel for review.
> 
> Results:
> --------
> 
> fio jobs        1       2       4       8       12      16
> ----------------------------------------------------------
> 1 worker        84k    492k    510k    -       -       -
> worker per vq   184k   380k    744k    1422k   2256k   2434k
> 
> Notes:
> 0. This used a simple fio command:
> 
> fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
> --ioengine=libaio --iodepth=128  --numjobs=$JOBS_ABOVE
> 
> and I used a VM with 16 vCPUs and 16 virtqueues.
> 
> 1. The patches were tested with emulate_pr=0 and these patches:
> 
> https://lore.kernel.org/all/yq1tuhge4bg.fsf@ca-mkp.ca.oracle.com/t/
> 
> which are in mkp's scsi branches for the next kernel. They fix the perf
> issues where IOPs dropped at 12 vqs/jobs.
> 
> 2. Because we have a hard limit of 1024 cmds, if the num jobs * iodepth
> was greater than 1024, I would decrease iodepth. So 12 jobs used 85 cmds,
> and 16 used 64.
> 
> 3. The perf issue above at 2 jobs is because when we only have 1 worker
> we execute more cmds per vhost_work due to all vqs funneling to one worker.
> This results in less context switches and better batching without having to
> tweak any settings. I'm working on patches to add back batching during lio
> completion and do polling on the submission side.
> 
> We will still want the threading patches, because if we batch at the fio
> level plus use the vhost theading patches, we can see a big boost like
> below. So hopefully doing it at the kernel will allow apps to just work
> without having to be smart like fio.
> 
> fio using io_uring and batching with the iodepth_batch* settings:
> 
> fio jobs        1       2       4       8       12      16
> -------------------------------------------------------------
> 1 worker        494k    520k    -       -       -       -
> worker per vq   496k    878k    1542k   2436k   2304k   2590k
> 
> V3:
> - fully convert vhost code to use vq based APIs instead of leaving it
> half per dev and half per vq.
> - rebase against kernel worker API.
> - Drop delayed worker creation. We always create the default worker at
> VHOST_SET_OWNER time. Userspace can create and bind workers after that.
> 
> v2:
> - change loop that we take a refcount to the worker in
> - replaced pid == -1 with define.
> - fixed tabbing/spacing coding style issue
> - use hash instead of list to lookup workers.
> - I dropped the patch that added an ioctl cmd to get a vq's worker's
> pid. I saw we might do a generic netlink interface instead.
> 
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

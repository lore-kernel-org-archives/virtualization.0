Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BEEC77B75
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 06:50:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C67C061100;
	Fri, 21 Apr 2023 06:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C67C061100
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RVytljLp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gdUvX8pCcHjr; Fri, 21 Apr 2023 06:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3AFA361361;
	Fri, 21 Apr 2023 06:50:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AFA361361
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 131C6C007A;
	Fri, 21 Apr 2023 06:50:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50B7FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 06:50:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 244A08217D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 06:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 244A08217D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RVytljLp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEMHpppFxinV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 06:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADC1E82178
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADC1E82178
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 06:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682059802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cEdyyBIY/UY9KBivia1By2disb1iNxnqC5mfB3hYQi0=;
 b=RVytljLpSOAksF5CHBFZIbojJ/r/jDciN1V9J3oVF1A8K6PGFpiVOi2E6sC+p02FtQn9oD
 I9eYOhjLnbAXwZdOkB8TyKrqHIMuaM/Y2+YVSOruMlpUQUkm1cQrTwZu+dWzYEDqok1AOO
 GmyBil/QhqTdJrn6Ql88skXaCbMEtio=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-HjYLc0_gMx26D2c4wirBuA-1; Fri, 21 Apr 2023 02:50:01 -0400
X-MC-Unique: HjYLc0_gMx26D2c4wirBuA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f16f50aeb5so5324455e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 23:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682059800; x=1684651800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEdyyBIY/UY9KBivia1By2disb1iNxnqC5mfB3hYQi0=;
 b=gZJD7s2C+cAdAk3oSGK3PirFuGoqpPhLcz7CChOLDlm0dTbn/m2gFdDbYdJFPDvKNE
 vD+qCDNTHLYt0kFOvyu9FAqpTpzPo6sYkZrTzmuJ2msDTcFW3U1ENznh9vzEegp6VDql
 bUYz4mS4MSVrSHGG+FZBPVx0T4OiuN45XKGtqF++LNDVtl9Q4jDhTcFkycbeT3cISFya
 pWTEBperNwr+Y37FQfbgMYrIt9DkILuWjLChwxWRCsTDWozrj2RTVpSF1vigPZwa/HlC
 ZrCIeAkT4/xc8Q6ONCUymPtB3sv7OQZxkcWyY0hmTfQUghhBpiGoShaklti9PG0u7puz
 /qZg==
X-Gm-Message-State: AAQBX9dGDYF/FGHKkiwoFvefSyCUVF3sCdSzgLnO4Budca2BOw8R2fDd
 C0rZGMv5BoXCzO6gOMIIBEiFkVbunJ8mkMjXSlbmEXBCPouSwL6HeqtRPjYbREV6nmO0S2pKA3F
 WsnEvIdUt6LPlvCfrytpZ3lRnzpINCWmhvy9c1ZlCSw==
X-Received: by 2002:a7b:c016:0:b0:3f1:8af9:55bd with SMTP id
 c22-20020a7bc016000000b003f18af955bdmr956304wmb.26.1682059800110; 
 Thu, 20 Apr 2023 23:50:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350aDV12eMZXoBQstvEtPrbLR6+5/nZZbV6cxWWfrpfK/6NO2TN0qHiIhyUW+jM/6YM8hK9EcVQ==
X-Received: by 2002:a7b:c016:0:b0:3f1:8af9:55bd with SMTP id
 c22-20020a7bc016000000b003f18af955bdmr956292wmb.26.1682059799743; 
 Thu, 20 Apr 2023 23:49:59 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 o10-20020a05600c510a00b003ee443bf0c7sm7381024wms.16.2023.04.20.23.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 23:49:59 -0700 (PDT)
Date: Fri, 21 Apr 2023 02:49:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v6 00/11] vhost: multiple worker support
Message-ID: <20230421024930-mutt-send-email-mst@kernel.org>
References: <20230328021717.42268-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230328021717.42268-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Mon, Mar 27, 2023 at 09:17:06PM -0500, Mike Christie wrote:
> The following patches were built over linux-next which contains various
> vhost patches in mst's tree and the vhost_task patchset in Christian
> Brauner's tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
> 
> kernel.user_worker branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.user_worker


Looks like it's going to miss this merge cycle. Hopefully in the next
one.


> The latter patchset handles the review comment for the patches in thread
> to make sure that worker threads we create are accounted for in the parent
> process's NPROC limit. The patches are scheduled to be sent to Linus for
> 6.4.
> 
> The patches in this patchset allow us to support multiple vhost workers
> per device. The design is a modified version of Stefan's original idea
> where userspace has the kernel create a worker and we pass back the pid.
> In this version instead of passing the pid between user/kernel space we
> use a worker_id which is just an integer managed by the vhost driver and
> we allow userspace to create and free workers and then attach them to
> virtqueues at setup time.
> 
> All review comments from the past reviews should be handled. If I didn't
> reply to a review comment, I agreed with the comment and should have
> handled it in this posting. Let me know if I missed one.
> 
> Results:
> --------
> 
> fio jobs        1       2       4       8       12      16
> ----------------------------------------------------------
> 1 worker        160k   488k     -       -       -       -
> worker per vq   160k   310k    620k    1300k   1836k   2326k
> 
> Notes:
> 0. This used a simple fio command:
> 
> fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
> --ioengine=libaio --iodepth=128  --numjobs=$JOBS_ABOVE
> 
> and I used a VM with 16 vCPUs and 16 virtqueues.
> 
> 1. The patches were tested with LIO's emulate_pr=0 which drops the
> LIO PR lock use. This was a bottleneck at around 12 vqs/jobs.
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
> 
> V6:
> - Rebase against vhost_task patchset.
> - Used xa instead of idr.
> V5:
> - Rebase against user_worker patchset.
> - Rebase against flush patchset.
> - Redo vhost-scsi tmf flush handling so it doesn't access vq->worker.
> V4:
> - fix vhost-sock VSOCK_VQ_RX use.
> - name functions called directly by ioctl cmd's to match the ioctl cmd.
> - break up VHOST_SET_VRING_WORKER into a new, free and attach cmd.
> - document worker lifetime, and cgroup, namespace, mm, rlimit
> inheritance, make it clear we currently only support sharing within the
> device.
> - add support to attach workers while IO is running.
> - instead of passing a pid_t of the kernel thread, pass a int allocated
> by the vhost layer with an idr.
> 
> V3:
> - fully convert vhost code to use vq based APIs instead of leaving it
> half per dev and half per vq.
> - rebase against kernel worker API.
> - Drop delayed worker creation. We always create the default worker at
> VHOST_SET_OWNER time. Userspace can create and bind workers after that.
> 
> V2:
> - change loop that we take a refcount to the worker in
> - replaced pid == -1 with define.
> - fixed tabbing/spacing coding style issue
> - use hash instead of list to lookup workers.
> - I dropped the patch that added an ioctl cmd to get a vq's worker's
> pid. I saw we might do a generic netlink interface instead.
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

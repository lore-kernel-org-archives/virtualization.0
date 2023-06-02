Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF16DC7EE2C
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 11:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71710423FF;
	Fri,  2 Jun 2023 11:50:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71710423FF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gfXwZVlS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MLCai3ypa9E; Fri,  2 Jun 2023 11:50:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8754342077;
	Fri,  2 Jun 2023 11:50:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8754342077
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50C93C0037;
	Fri,  2 Jun 2023 11:50:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6A15C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA3DA83FA3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA3DA83FA3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gfXwZVlS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHU5yqDMx73b
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:50:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8A1A683F94
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A1A683F94
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685706601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5JQX6VEGyToM61jJ4JZxmY5pOMA0WflkJTAsoKR7ls=;
 b=gfXwZVlSPRz2uZIjXiiP3RJe5Y4FDZllO9tp8tGH6aAJsXeMaXVAgvThfK0pUTvMhuzIJ/
 qQ4FAXRWpUAZ4SiXt4Itm9tW/hXByXyVjqGlEYuIWORbwBnCt2ruFkysGXzTplgHhFmWwV
 PReznACKcUG8xvi3RhPQSYxSh7yAVa8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-RI8S28ZGP5mR0R34V1jPxg-1; Fri, 02 Jun 2023 07:50:00 -0400
X-MC-Unique: RI8S28ZGP5mR0R34V1jPxg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso9670925e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jun 2023 04:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706599; x=1688298599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5JQX6VEGyToM61jJ4JZxmY5pOMA0WflkJTAsoKR7ls=;
 b=GdTGnGS5NooMvOe/x3OiLifKlrUEAyClRFJV/sfx7coqILKBhPWQ8pAEqR65n/yG4D
 yIp01luOcwNpJGkQDSih9dMIl8Y+HoujPBh7FvxYll4ya81fMibzak0Y6xDe2TsgqOP6
 x2HRmATogklSV7COppedqiolJ+Ie4dxoc666LQeT/2qCckRA448kkQJgSLMkngMZkNGa
 xcc9zGrQOymCNxlsrQSwdVs+J6LUOkavUtnzzhvfdtmlDqrGSA9Ogyr+UMsUJ7ndGbhw
 o0BTSfFyI8mMfhgxhpou37Odm29Qe/mX5dD3e53zRe8oChjTxk+kSjpeHLFGOfCqsK51
 L5rQ==
X-Gm-Message-State: AC+VfDysm7bE6gPu2AwsO7EHEN1cWnIra4jZb+pZO+sEBLrskV3K0G3V
 dPS2rYBYDoJ3F5uph21WKoKZwPUtr3z+JcJyEqQeOVQmNIz91Lu0GmhqpmbDodg+tO7fsZkDVXx
 SMaBq3ANxbPPgE5bNGtAxiqhPvjqiUx/YieJ6i15Yvg==
X-Received: by 2002:a1c:f305:0:b0:3f7:148b:c310 with SMTP id
 q5-20020a1cf305000000b003f7148bc310mr1707367wmq.13.1685706599076; 
 Fri, 02 Jun 2023 04:49:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XvfORAHebnspQEuA0s88DfsGM+r72FzwZx9bHVEwIqUHLrHV1bVrsI4RDJhiFUEahqn92mA==
X-Received: by 2002:a1c:f305:0:b0:3f7:148b:c310 with SMTP id
 q5-20020a1cf305000000b003f7148bc310mr1707357wmq.13.1685706598747; 
 Fri, 02 Jun 2023 04:49:58 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 r1-20020a5d52c1000000b0030ae69920c9sm1464843wrv.53.2023.06.02.04.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:49:57 -0700 (PDT)
Date: Fri, 2 Jun 2023 07:49:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH v7 00/14] vhost: multiple worker support
Message-ID: <20230602074855-mutt-send-email-mst@kernel.org>
References: <20230428163131.92777-1-michael.christie@oracle.com>
 <b7bc4a59-af42-bc4e-0bc8-05b5e6885750@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b7bc4a59-af42-bc4e-0bc8-05b5e6885750@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

Hi Mike,

On Fri, Apr 28, 2023 at 11:35:20AM -0500, michael.christie@oracle.com wrote:
> The following patches were built over Linux's tree. They allow us to
> support multiple vhost workers tasks per device. The design is a modified
> version of Stefan's original idea where userspace has the kernel create a
> worker and we pass back the pid. In this version instead of passing the
> pid between user/kernel space we use a worker_id which is just an integer
> managed by the vhost driver and we allow userspace to create and free
> workers and then attach them to virtqueues at setup time.
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
> I have 2 patches that fix this. One is just submit from the worker thread
> instead of kikcing off to a workqueue like how the vhost block patches do.
> I'll post this after the worker support is merged. I'm also working on
> patches to add back batching during lio completion and do polling on the
> submission side.
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


Could you rebase on latest rc and repost please?
Thanks!

> V7:
> - Add more comments about assumptions.
> - Drop refcounting and just use an attachment_cnt variable, so there
> is no confusion about when a worker is freed.
> - Do a opt-in model, because vsiock has an issue where it can queue works
> before it's running and it doesn't even need multiple workers, so there 
> is no point in chaning the driver or core code.
> - Add back get worker ioctl.
> - Broke up last patches to make it easier to read.
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

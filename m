Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8A6C001DB
	for <virtualization@archiver.kernel.org>; Sun, 13 Aug 2023 19:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CD4881489;
	Sun, 13 Aug 2023 19:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1CD4881489
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKtnZqiK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Ju09xYAC09I; Sun, 13 Aug 2023 19:01:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2289581463;
	Sun, 13 Aug 2023 19:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2289581463
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 007C2C0072;
	Sun, 13 Aug 2023 19:01:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1944C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 19:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BB788146B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 19:01:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BB788146B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3jObc9lkcLVR
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 19:01:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B14181463
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 19:01:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B14181463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691953293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEt9jygVzQcGJ/r1YIvshQV5vep7vwd+a/V9X6Fi/+I=;
 b=FKtnZqiKsLqcpxq/Cr/mHiMBHoaGzVXFiNI9gmit6mfpo0pCPXswoHjlCCsdtV6833LEy3
 T0cv8iIDBP4tfvYrvS7BuH96FF8ZbrzKh2pChmbW08L7+4jiMmgj1CZko1BdR0CiDtpqTP
 YrUC5X12ZT6L6+Eq+nOEuy1Ws3ESZAo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-8EniZWznMdWqKYyQ32hcKA-1; Sun, 13 Aug 2023 15:01:32 -0400
X-MC-Unique: 8EniZWznMdWqKYyQ32hcKA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bfe6a531bso222263266b.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Aug 2023 12:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691953291; x=1692558091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEt9jygVzQcGJ/r1YIvshQV5vep7vwd+a/V9X6Fi/+I=;
 b=knU2K5PBg2m1GVr6qfgH3dQtYz7U+fZZq1/0DOv8L7UB1LB/K0skik0WWvN8oAdgaN
 HuFYnbVT9Q35zqSXGHUHwkPm2DaFNCZegIhJcHZLdYcin6D5HdY8bDQbrRIboNChyis/
 Cxha54rN5oRsaYy/1glqYwAXDPOZVTys8d/8fouramZVZHCBi7yqJAPejh5Rlb2uI+Se
 R9CkmrHGNZZzAUTFk/QKTejHiYBvNgsSVdNNe2BXejADsTZM4/vyjcL9+ggz4ykfSm2u
 4iRFNz0digDFQ3a62KJb1AiUag3lukECYPPYOH9cQJqcGk6KzD9+vSw8QFQmDsy0Divy
 Dfmg==
X-Gm-Message-State: AOJu0YzTU6duj1pEgG3MWHYbop9kNhdT4pPyV/Af/13zw3GfkOtSuiu2
 R7FjS/8GlAIh3+qPiO7cXDneJPlaJNVFh2P3gD185vKrKYSntfoLQowx6HpfdwSOcC4IAsgJShY
 DUNdgtztpIZKEI3MwKt3YWWKRuwh8Puy6t2m2JeeiRQ==
X-Received: by 2002:a17:906:5db4:b0:99c:ac84:663a with SMTP id
 n20-20020a1709065db400b0099cac84663amr5775071ejv.65.1691953291059; 
 Sun, 13 Aug 2023 12:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhMaFdsuzYAw2yinsIysYJSim9+L86qb9TO9hQl2qrKJMg5+Y+NMBiUqcJJQ0Gh9hAZ/5lTA==
X-Received: by 2002:a17:906:5db4:b0:99c:ac84:663a with SMTP id
 n20-20020a1709065db400b0099cac84663amr5775055ejv.65.1691953290645; 
 Sun, 13 Aug 2023 12:01:30 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 q14-20020a17090622ce00b00992ca779f42sm4825074eja.97.2023.08.13.12.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:01:28 -0700 (PDT)
Date: Sun, 13 Aug 2023 15:01:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230813145936-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
 <20230810145528-mutt-send-email-mst@kernel.org>
 <b2b02526-913d-42a9-9d23-59badf5b96db@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b2b02526-913d-42a9-9d23-59badf5b96db@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, torvalds@linux-foundation.org
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

On Fri, Aug 11, 2023 at 01:51:36PM -0500, Mike Christie wrote:
> On 8/10/23 1:57 PM, Michael S. Tsirkin wrote:
> > On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
> >> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
> >>> On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> >>>> For vhost workers we use the kthread API which inherit's its values from
> >>>> and checks against the kthreadd thread. This results in the wrong RLIMITs
> >>>> being checked, so while tools like libvirt try to control the number of
> >>>> threads based on the nproc rlimit setting we can end up creating more
> >>>> threads than the user wanted.
> >>>>
> >>>> This patch has us use the vhost_task helpers which will inherit its
> >>>> values/checks from the thread that owns the device similar to if we did
> >>>> a clone in userspace. The vhost threads will now be counted in the nproc
> >>>> rlimits. And we get features like cgroups and mm sharing automatically,
> >>>> so we can remove those calls.
> >>>>
> >>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>
> >>>
> >>> Hi Mike,
> >>> So this seems to have caused a measureable regression in networking
> >>> performance (about 30%). Take a look here, and there's a zip file
> >>> with detailed measuraments attached:
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=2222603
> >>>
> >>>
> >>> Could you take a look please?
> >>> You can also ask reporter questions there assuming you
> >>> have or can create a (free) account.
> >>>
> >>
> >> Sorry for the late reply. I just got home from vacation.
> >>
> >> The account creation link seems to be down. I keep getting a
> >> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
> >>
> >> Can you give me Quan's email?
> >>
> >> I think I can replicate the problem. I just need some extra info from Quan:
> >>
> >> 1. Just double check that they are using RHEL 9 on the host running the VMs.
> >> 2. The kernel config
> >> 3. Any tuning that was done. Is tuned running in guest and/or host running the
> >> VMs and what profile is being used in each.
> >> 4. Number of vCPUs and virtqueues being used.
> >> 5. Can they dump the contents of:
> >>
> >> /sys/kernel/debug/sched
> >>
> >> and
> >>
> >> sysctl  -a
> >>
> >> on the host running the VMs.
> >>
> >> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
> >> the scheduler to batch:
> >>
> >> ps -T -o comm,pid,tid $QEMU_THREAD
> >>
> >> then for each vhost thread do:
> >>
> >> chrt -b -p 0 $VHOST_THREAD
> >>
> >> Does that end up increasing perf? When I do this I see throughput go up by
> >> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
> >> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
> >> It's just a difference I noticed when running some other tests.
> > 
> > 
> > Mike I'm unsure what to do at this point. Regressions are not nice
> > but if the kernel is released with the new userspace api we won't
> > be able to revert. So what's the plan?
> > 
> 
> I'm sort of stumped. I still can't replicate the problem out of the box. 6.3 and
> 6.4 perform the same for me. I've tried your setup and settings and with different
> combos of using things like tuned and irqbalance.
> 
> I can sort of force the issue. In 6.4, the vhost thread inherits it's settings
> from the parent thread. In 6.3, the vhost thread inherits from kthreadd and we
> would then reset the sched settings. So in 6.4 if I just tune the parent differently
> I can cause different performance. If we want the 6.3 behavior we can do the patch
> below.
> 
> However, I don't think you guys are hitting this because you are just running
> qemu from the normal shell and were not doing anything fancy with the sched
> settings.
> 
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index da35e5b7f047..f2c2638d1106 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2021 Oracle Corporation
>   */
> +#include <uapi/linux/sched/types.h>
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/sched/task.h>
> @@ -22,9 +23,16 @@ struct vhost_task {
>  
>  static int vhost_task_fn(void *data)
>  {
> +	static const struct sched_param param = { .sched_priority = 0 };
>  	struct vhost_task *vtsk = data;
>  	bool dead = false;
>  
> +	/*
> +	 * Don't inherit the parent's sched info, so we maintain compat from
> +	 * when we used kthreads and it reset this info.
> +	 */
> +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> +
>  	for (;;) {
>  		bool did_work;
>  
> 
> 

yes seems unlikely, still, attach this to bugzilla so it can be
tested?

and, what will help you debug? any traces to enable?

Also wasn't there another issue with a non standard config?
Maybe if we fix that it will by chance fix this one too?

> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

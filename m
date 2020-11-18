Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8197DC64E7A
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:54:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C37102168B
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUKigu6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37102168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4369783500;
	Wed, 18 Nov 2020 09:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x9NM4rnyeiWI; Wed, 18 Nov 2020 09:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9A6E832C6;
	Wed, 18 Nov 2020 09:54:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7974FC0891;
	Wed, 18 Nov 2020 09:54:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 893AAC07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 76C4C83500
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:54:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id um9_f14XIzvq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:54:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3CE9A832C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605693254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HkvlidDT7RuDykKbMhHuxkrrFtoJAiVcxN+jntjGpQI=;
 b=RUKigu6a6BcFBb+9KtUs2MQBtHwJr4KuXNmxYWe3NEWhjNXy9O9/VhIdeKsObMTn3qMaAs
 ANzZjrnCCDJcfAx8WLoaze2LR76rEnHJnnNrVhwJwGtLmsxTSqCv8XmkXZgJsmkR+vLtSF
 bU4wv05YcHcEz7UOZ5GdsmP2GI8hCFk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-5xFpsERMOterzDmnRFAfcg-1; Wed, 18 Nov 2020 04:54:12 -0500
X-MC-Unique: 5xFpsERMOterzDmnRFAfcg-1
Received: by mail-wr1-f70.google.com with SMTP id w6so713663wrk.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 01:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HkvlidDT7RuDykKbMhHuxkrrFtoJAiVcxN+jntjGpQI=;
 b=ZfNGseevgXXAzcZESnmct2mYLc8OOxqt/kbnUAs8yXOmrlea+ZT7ifzfdqDG9JSUwP
 uM3iVX3yK2eXH2+EAUG/luNQdoeS+hBEQ/pBpx0WVcHxScjC/Ad4DWze5MSyCLmGUiL3
 0tWAnBC4RGKF/WOlYOqpbHvgjfhwSSsUHZzdXIyv/U25jayaLaqhk2ziazhzJuB/mF8q
 vfdwkXjJ++p61vZwdQxtUgrr2VUljg6fWcoFSrXt3OJKhetBivMqlr5sc6SYfJ3Co8uG
 FutK2a3Hw4X+aTGX51KvrCAx64SXkaYAxcTutMDnQRkPQ12yXdaOdKxdyXxnKnNbMMAy
 yvMw==
X-Gm-Message-State: AOAM531YZIDUN/MJD/ATf12fpUoDq4J8O4HCl9Ii2q1aJcn+HJ/A2/4N
 1+/lEnte348pxbjQRLFK33PrR/ZwXdrMWpD3fKESZcquV60uJ2hEJV6tqJPLyoNoyQpmsTuP3Gg
 4u4o3/LrS3IZkVYZSswPx7BWxj1ACxqdeO8VenEURZA==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr3661686wmj.72.1605693251510; 
 Wed, 18 Nov 2020 01:54:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbXLTxAGOnZyxxbLSLJq6x1VIfry0wChmfEQrkgNC9lF4UHuYFsROS0Onu2BcX6Xl3sE+plg==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr3661670wmj.72.1605693251346; 
 Wed, 18 Nov 2020 01:54:11 -0800 (PST)
Received: from redhat.com (bzq-109-67-54-78.red.bezeqint.net. [109.67.54.78])
 by smtp.gmail.com with ESMTPSA id
 o13sm2811565wmc.44.2020.11.18.01.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 01:54:10 -0800 (PST)
Date: Wed, 18 Nov 2020 04:54:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
Message-ID: <20201118044620-mutt-send-email-mst@kernel.org>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com
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

On Tue, Nov 17, 2020 at 01:13:14PM -0600, Mike Christie wrote:
> On 11/17/20 10:40 AM, Stefan Hajnoczi wrote:
> > On Thu, Nov 12, 2020 at 05:18:59PM -0600, Mike Christie wrote:
> >> The following kernel patches were made over Michael's vhost branch:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git/log/?h=vhost
> >>
> >> and the vhost-scsi bug fix patchset:
> >>
> >> https://lore.kernel.org/linux-scsi/20201112170008.GB1555653@stefanha-x1.localdomain/T/#t
> >>
> >> And the qemu patch was made over the qemu master branch.
> >>
> >> vhost-scsi currently supports multiple queues with the num_queues
> >> setting, but we end up with a setup where the guest's scsi/block
> >> layer can do a queue per vCPU and the layers below vhost can do
> >> a queue per CPU. vhost-scsi will then do a num_queue virtqueues,
> >> but all IO gets set on and completed on a single vhost-scsi thread.
> >> After 2 - 4 vqs this becomes a bottleneck.
> >>
> >> This patchset allows us to create a worker thread per IO vq, so we
> >> can better utilize multiple CPUs with the multiple queues. It
> >> implments Jason's suggestion to create the initial worker like
> >> normal, then create the extra workers for IO vqs with the
> >> VHOST_SET_VRING_ENABLE ioctl command added in this patchset.
> > 
> > How does userspace find out the tids and set their CPU affinity?
> > 
> 
> When we create the worker thread we add it to the device owner's cgroup,
> so we end up inheriting those settings like affinity.
> 
> However, are you more asking about finer control like if the guest is
> doing mq, and the mq hw queue is bound to cpu0, it would perform
> better if we could bind vhost vq's worker thread to cpu0? I think the
> problem might is if you are in the cgroup then we can't set a specific
> threads CPU affinity to just one specific CPU. So you can either do
> cgroups or not.

Something we wanted to try for a while is to allow userspace
to create threads for us, then specify which vqs it processes.

That would address this set of concerns ...

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

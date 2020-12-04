Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95369C433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 16:07:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA1F2223E
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 16:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA1F2223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 821FF2E301;
	Fri,  4 Dec 2020 16:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wcUqLRQKAi0p; Fri,  4 Dec 2020 16:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 149662E2D9;
	Fri,  4 Dec 2020 16:07:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F36A7C0FA8;
	Fri,  4 Dec 2020 16:07:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B35BC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 16:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6093387D17
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 16:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aXUpYOo6SLkp
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 16:06:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EAE3687D0B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607098017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9eAbWgXkbv2eDi+txBHbhzeU9UsROTvRNfv5Pgs5m+M=;
 b=fxVQ7oJtBADuZolPKwcGemA9dq5Yk0KaQe94HiQzVU+N25InimNB+GE4SKAjKDWyrYjbVt
 en8KFDtRt97GyeCykgSG7OwFScZqQyRZAvcSDzzObCkQRiCfObam5/UaHQfv+3js9FJ6ym
 a9Z8S869pnJF4zBQRpuUNIYlRvg3xoA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-6rx_m0aVN6GbnUkk6dIkZQ-1; Fri, 04 Dec 2020 11:06:56 -0500
X-MC-Unique: 6rx_m0aVN6GbnUkk6dIkZQ-1
Received: by mail-wm1-f72.google.com with SMTP id a205so1995926wme.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Dec 2020 08:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9eAbWgXkbv2eDi+txBHbhzeU9UsROTvRNfv5Pgs5m+M=;
 b=Ju/zE4ECOXkg5bYjEHuQZc/wU2Q12Pbl1Ibf9Lvv5l67TEGiRGCPP6cAKzf8JbE4W2
 kiy3aqJRWnjDSCFC+iGj3DikWDvUr+1b1fpLLrtLcZM+7uIe7trt47puhUjETgtCS7At
 bt/gcgIhSgjGi0hFRrktSv6M0HhpmaDiZdKcNaYlAiskIcpfFQz07VDDOkoZhVjfrkL9
 Fhc9y4aJu7enBHegsdIBshAbRpoePuhpG4sJW5BhlkKgDHPoXDxGCUj+chLd9+pD5IUI
 2lGXP5IR8tNRJBMgcMPN4Wo6dvM0mZewBktEgWZ4b+e8/lBT2CeDY4e6WgxrTh8Nse8f
 Il6A==
X-Gm-Message-State: AOAM533yQlJe89QjGpz7C6snoMjv6vW0WVK6BwxF2Q+K5uPGXeVyuXEv
 uCsZktCeekRS/+iL4jAB0WktaVAbesi7G1sDWYhIe23jwDNWl807bUJ7fKiGxKz9sMTFpN2yLiZ
 7ZbNhZa3mNOMjTb4axbGESNdyN2xjQ0Ecf2cpIjhlFQ==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr5697087wrp.339.1607098014702; 
 Fri, 04 Dec 2020 08:06:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyh1gDOi04oyZ2v1FusnkNbGm/lSr5qmo45s0i41AvRQyKg5Lky0V7syJMDHqbbPfTgzo71XQ==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr5697059wrp.339.1607098014454; 
 Fri, 04 Dec 2020 08:06:54 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id b83sm3766348wmd.48.2020.12.04.08.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Dec 2020 08:06:53 -0800 (PST)
Date: Fri, 4 Dec 2020 17:06:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [RFC PATCH 0/8] vhost: allow userspace to control vq cpu affinity
Message-ID: <20201204160651.7wlselx4jm6k66mb@steredhat>
References: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1607068593-16932-1-git-send-email-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Mike,

On Fri, Dec 04, 2020 at 01:56:25AM -0600, Mike Christie wrote:
>These patches were made over mst's vhost branch.
>
>The following patches, made over mst's vhost branch, allow userspace
>to set each vq's cpu affinity. Currently, with cgroups the worker thread
>inherits the affinity settings, but we are at the mercy of the CPU
>scheduler for where the vq's IO will be executed on. This can result in
>the scheduler sometimes hammering a couple queues on the host instead of
>spreading it out like how the guest's app might have intended if it was
>mq aware.
>
>This version of the patches is not what you guys were talking about
>initially like with the interface that was similar to nbd's old
>(3.x kernel days) NBD_DO_IT ioctl where userspace calls down to the
>kernel and we run from that context. These patches instead just
>allow userspace to tell the kernel which CPU a vq should run on.
>We then use the kernel's workqueue code to handle the thread
>management.

I agree that reusing kernel's workqueue code would be a good strategy.

One concern is how easy it is to implement an adaptive polling strategy 
using workqueues. From what I've seen, adding some polling of both 
backend and virtqueue helps to eliminate interrupts and reduce latency.

Anyway, I'll take a closer look at your patches next week. :-)

Thanks,
Stefano

>
>I wanted to post this version first, because it is flexible
>in that userspace can set things up so devs/vqs share threads/CPUs
>and we don't have to worry about replicating a bunch of features
>that the workqueue code already has like dynamic thread creation,
>blocked work detection, idle thread detection and thread reaping,
>and it also has an interface to control how many threads can be
>created and which CPUs work can run on if we want to further restrict
>that from userspace.
>
>Note that these patches have been lightly tested. I more wanted
>to get comments on the overall approach, because I know it's
>not really what you were thinking about. But while I worked
>on being able to share threads with multiple devices, I kept
>coming back to the existing workqueue code and thinking I'll
>just copy and paste that.
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

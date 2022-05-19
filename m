Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73EBC433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 08:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E05B4091F;
	Thu, 19 May 2022 08:32:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lksercNNZm4D; Thu, 19 May 2022 08:32:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE403405EB;
	Thu, 19 May 2022 08:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93164C0039;
	Thu, 19 May 2022 08:32:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1410BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 02AB483051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X8QUkXc9NelN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:32:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 43FF68301F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652949142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zGkqLBS/TAgxZK9Jmx8vQw2RK+jMADwG0s4JnBJWNc=;
 b=EVFHclpekAS9EFXvigYeklIOBIBrAmUdLlz81UtHJlV94aDWJuuwsXoXh+QZPBam3iZ0xM
 QObl5CNnN06Zqbb8MNEMoSJIXmveGOLQ1Rgq9Atd4Ge45TYox+UMNVeLnXumW23L2sAGIE
 Rg0sTKcVI4XkBbBSbqmWr3EVm6f0Efk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-N7UCLlzANimOdJzLeQ_fPQ-1; Thu, 19 May 2022 04:32:20 -0400
X-MC-Unique: N7UCLlzANimOdJzLeQ_fPQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 bi5-20020a05600c3d8500b0039489e1d18dso4192082wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4zGkqLBS/TAgxZK9Jmx8vQw2RK+jMADwG0s4JnBJWNc=;
 b=zobefZ52VuUlQTc2okonJgFlwJt+08Cmcqq8zIMLK0nTcqELojShfng4rnbxMQmOgJ
 ND4x9ip7EGyISoiRd1374btqfxn/mAHNQFhDA/VTveTfRWl/CuZsXFw6cE6IYA8VeeiC
 ntFruLMPX5WqWiwbJbtob8p9Dj/lTWRPUQe+uWDz7Lm4LhCFM3+6qQFnBf75OdHnuJ4C
 UorMTlIX7MOyi3HCvJnTRAz+H0X1aU/OwYRQ/pkFF5e+eSaXkXqKqJFLLhCIbxFNrtHq
 9IE2BuXmmmxhC+/sP66XY0W1krNzObMX2GZXRumOX0am/wMjxbqH+hfb+lb+wtlZx+Zg
 PAiA==
X-Gm-Message-State: AOAM5336X1ZjDVEpvoC+4lIrr4BARNXQEHyPuZJkvNZ6d4F/VUAZPuKv
 6WXfGIS2pM5NcPJITBb9wYDIbYtR90yWSlchVuu7rdMXJbD4qhBbMjB4MoY08qtptmvt41BmdMA
 vElIlyglifNzqqMBQ2Lz26adzTgd8p0SKozTjQP0RzQ==
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id
 o2-20020a05600002c200b0020cc6e1e881mr2965139wry.333.1652949139812; 
 Thu, 19 May 2022 01:32:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyio4JEWQmgkioPkbNgTt2e70V8qT0vr7F8BBMxVMH/FsBBAQUG715vLlB3cyn0DlqD+bNL7Q==
X-Received: by 2002:a05:6000:2c2:b0:20c:c6e1:e881 with SMTP id
 o2-20020a05600002c200b0020cc6e1e881mr2965117wry.333.1652949139611; 
 Thu, 19 May 2022 01:32:19 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 l6-20020adfa386000000b0020cfed0bb7fsm4441801wrb.53.2022.05.19.01.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 01:32:18 -0700 (PDT)
Date: Thu, 19 May 2022 10:32:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 2/9] virtio: use virtio_reset_device() when possible
Message-ID: <20220519083213.jwzr272vvkh6ogq4@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220518035951.94220-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>,
 lulu@redhat.com, paulmck@kernel.org, mst@redhat.com, peterz@infradead.org,
 maz@kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eperezma@redhat.com, Vineeth Vijayan <vneethv@linux.ibm.com>,
 tglx@linutronix.de
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

On Wed, May 18, 2022 at 11:59:44AM +0800, Jason Wang wrote:
>This allows us to do common extension without duplicating code.
>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: Peter Zijlstra <peterz@infradead.org>
>Cc: "Paul E. McKenney" <paulmck@kernel.org>
>Cc: Marc Zyngier <maz@kernel.org>
>Cc: Halil Pasic <pasic@linux.ibm.com>
>Cc: Cornelia Huck <cohuck@redhat.com>
>Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
>Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>Cc: linux-s390@vger.kernel.org
>Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/virtio/virtio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

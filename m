Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BB3C4332F
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5C7B42619;
	Fri, 27 May 2022 10:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x7teuBnMf454; Fri, 27 May 2022 10:34:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5575542650;
	Fri, 27 May 2022 10:34:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 173D2C0032;
	Fri, 27 May 2022 10:34:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14482C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01DC04133F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:34:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKQBBG8l1z5v
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:34:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38FFD4056C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653647686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1xQ8OiQHH9ksLcm4a9s84IyD29bInrw0vUd6yz8xCk=;
 b=PhabCSooVFmE1kj8NLkF+5s2K2EkoadDbYDAM/iqrOBALsMdbqyDf1bVhONaHjFmSk5tC5
 jlgpnnt5z5gcZn+8uqrKoTaYuqnb3sGnf8Bk/WvyumRzvny5X9QbRX+exChkYUfnwS22M+
 d3NhSMkkTGPZ0fnI5irE7dQFmCCrKQI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-nZ8BE5cwOWyqqZVS7OxOQA-1; Fri, 27 May 2022 06:34:45 -0400
X-MC-Unique: nZ8BE5cwOWyqqZVS7OxOQA-1
Received: by mail-qk1-f198.google.com with SMTP id
 m26-20020a05620a13ba00b006a32a7adb78so3533420qki.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J1xQ8OiQHH9ksLcm4a9s84IyD29bInrw0vUd6yz8xCk=;
 b=BMgp0VO1bAGQ70rGYMwochl/IKpoDxpDX4QhGJj3rh1+hpwvKYkJ716TmjIjS/5heL
 BwTRpjyeszOwZIAyaVw0JxrvKJVFgzR6AMdoEHr/QXv6F3YZLpCVTbPrwEoLoRzyOf7T
 P6ACrFiD7plo57IHALD+omSOId+Gvq0I01Yaeplzfg27B/H+JQPb1nn9aAs6DJlqCleu
 phc50sx04R/k3LImJIv+z5YCDdhbxDAnAi7bNVUEsEx/TK7XgohciMhcU2iGWpFRY7IT
 rJrt+tOnmCum8H3M5jjwzjViFJvkO5dC7sdep353WGZMcpAa9olOF1Df05KmqZ2cgiE4
 EOPA==
X-Gm-Message-State: AOAM530aPRWaPcL2DJ2JTSd1H1INbGLrfjBnSBgvki4O6nqf6xLGfJP3
 //knm4b1/0fOsrsP6dL5S7dqMvBvCXuVlxm9k+gq0JZ6kdluOa2IHfcrXTRvYELS43ZyNhLO75+
 EmZqoltxpJn4jRa9KIBDrfL+gUFsgcR51AqCfkp39nA==
X-Received: by 2002:a05:620a:4042:b0:6a5:aded:fe52 with SMTP id
 i2-20020a05620a404200b006a5adedfe52mr5591550qko.365.1653647685388; 
 Fri, 27 May 2022 03:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqxv+VTwgq+LPdZICQyGqh24jAfcU1fwHBx1WzLpbtJcUIqfLL3McbVD+9ZVGHmS3yYq9xJg==
X-Received: by 2002:a05:620a:4042:b0:6a5:aded:fe52 with SMTP id
 i2-20020a05620a404200b006a5adedfe52mr5591538qko.365.1653647685166; 
 Fri, 27 May 2022 03:34:45 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 h19-20020a05620a401300b006a10c8d5d96sm2802962qko.3.2022.05.27.03.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:34:44 -0700 (PDT)
Date: Fri, 27 May 2022 12:34:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 2/9] virtio: use virtio_reset_device() when possible
Message-ID: <20220527103436.erqkgeh34prlvssh@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220527060120.20964-3-jasowang@redhat.com>
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

On Fri, May 27, 2022 at 02:01:13PM +0800, Jason Wang wrote:
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

Maybe I had already reviewed it :-), anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

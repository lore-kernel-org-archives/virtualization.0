Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D63C433EF
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 08:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 135B841C3E;
	Thu, 19 May 2022 08:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8ne_UZ3NRLH; Thu, 19 May 2022 08:34:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 632B941C41;
	Thu, 19 May 2022 08:34:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27751C0039;
	Thu, 19 May 2022 08:34:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59678C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4DEA541C41
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h0x752OzHXtX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6447E41C3E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652949248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e36VWZ5DWvtpQPTuTGZUg65mwhzA3Ro0bMqrlq/Fvz0=;
 b=RbB3h40sCWvVQm364D+zXUkG3O2p+LjeKQcbqGWMieSSkTDLi9q92Cs4lwiTEmMk+DHQG+
 Ho1Ll8ouQdqiq5s+GYFi+e9+R6CjEZpFnQ0HlyfaM8TLN57up3ttze6iZJ2W4w+SsZ0kQe
 zIEslzuCCjlX6abPV1CkpcWuNEsS47c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-sqQLW8cSMLyOcJCZoOy8Yg-1; Thu, 19 May 2022 04:34:06 -0400
X-MC-Unique: sqQLW8cSMLyOcJCZoOy8Yg-1
Received: by mail-wr1-f71.google.com with SMTP id
 t9-20020a5d5349000000b0020d02cd51fbso1288592wrv.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e36VWZ5DWvtpQPTuTGZUg65mwhzA3Ro0bMqrlq/Fvz0=;
 b=a2+sqVhAy2MEAENkpDK2BMXKW1UP8tThdS4eaZS5N/dFim/7eZQDDWvSvQI1dSzfaL
 Y1DUXKuy6HHqTcs0BwPNh95G8IfVoMWVg7TBaJlPhI4U1X0Hd5pVauh34yb0nMxl6xh4
 3kAw8K35SbA7ZMuQtmzl3jkS6nX6Mrf/0gN8OcQRryAn8X1Lp6LZmCWBOs6+0g/flaVw
 +ZkGbOJFvfKd0pOXzuRb8jfL1dqicItRnmmhMvpe+Yw3E4saDMnLKW1p9qGXY08IG0QE
 Zrud/cKuFVVU/InsvHOyHGErkZBxWL5tj/hGD4cZrTPTJjNiZmEEh+Nrcy8yCpvYv1lS
 mKVA==
X-Gm-Message-State: AOAM53381P8QWtoRM6WCBasC2iM3CLtFJpMySptlMrSZ7RhCRA3nFeTI
 acSgIKfYARt15SzIiq9p/DySSxwkCq1t3vaaQQALfOF/tKHx1FnTXEgrFw7a1U39VqCZx2l52Pz
 ta+Ri37381dOmsg2gFPEXxOEet4ZRBBB9Q2SqEU3ovA==
X-Received: by 2002:a5d:6a4e:0:b0:20d:83:f5bb with SMTP id
 t14-20020a5d6a4e000000b0020d0083f5bbmr2963261wrw.392.1652949245040; 
 Thu, 19 May 2022 01:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz05m0Do5MtdQDqPk7YxffOwGGKVjHy6V0eWXG2QT+lHKjiwAFQdDwNmmaqWWjoSwfqFAMZew==
X-Received: by 2002:a5d:6a4e:0:b0:20d:83:f5bb with SMTP id
 t14-20020a5d6a4e000000b0020d0083f5bbmr2963236wrw.392.1652949244809; 
 Thu, 19 May 2022 01:34:04 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 m26-20020a7bce1a000000b003942a244f3fsm6669865wmc.24.2022.05.19.01.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 01:34:04 -0700 (PDT)
Date: Thu, 19 May 2022 10:34:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 3/9] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220519083401.ynmjdihi4hnjahlg@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220518035951.94220-4-jasowang@redhat.com>
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

On Wed, May 18, 2022 at 11:59:45AM +0800, Jason Wang wrote:
>This patch introduces new virtio config op to vring
>callbacks. Transport specific method is required to make sure the
>write before this function is visible to the vring_interrupt() that is
>called after the return of this function. For the transport that
>doesn't provide synchronize_vqs(), use synchornize_rcu() which
>synchronize with IRQ implicitly as a fallback.
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
> include/linux/virtio_config.h | 25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

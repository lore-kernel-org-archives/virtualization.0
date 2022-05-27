Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3723AC433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8E1761666;
	Fri, 27 May 2022 10:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-ae6N8zZAxo; Fri, 27 May 2022 10:36:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 428BF615E1;
	Fri, 27 May 2022 10:36:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C4A6C0032;
	Fri, 27 May 2022 10:36:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE52C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E8B14133F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsPudFqtlGcF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:36:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF2964056C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653647800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2OTG3cehkDKC9XILcBu3L3NTinwiyGs3kvyt5+4+bQ=;
 b=i8vVymTQSWPNNujKpBa7HeUal+CA3HTWhIsmz2vBnemIV3DeFRqSZaZXsNoUhCkSzKxg2h
 OUUxVWn55besURdDNxlR3ncvDzjkkElM4vrDozDCQbH+qgu+3qaBG3dDTYUcyVCJisVgAn
 qZDaR8C/z9cn0B9ItaL24OHuflqPTTs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-bZ-SsCSWM3ygbJdLe0GlSw-1; Fri, 27 May 2022 06:36:39 -0400
X-MC-Unique: bZ-SsCSWM3ygbJdLe0GlSw-1
Received: by mail-qv1-f71.google.com with SMTP id
 dy10-20020ad44e8a000000b004625c7238edso3196122qvb.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=l2OTG3cehkDKC9XILcBu3L3NTinwiyGs3kvyt5+4+bQ=;
 b=H5dzNWxdPud7cVL62wEQZQC+x72T0PzsfRTT8x5MxDCmM7FoM/a4k8cmVaWde74yq0
 bt1RlcxXXmpDUdmlLuAm7hI013TW2e50HWspBvzNH34zNPL+yrIGRsdamYKISNcAiFCd
 Gr3HecSJDMqUIqo5uO0SDpxXGBQVP+qPFbwGUd2RhUt2XRjRX886Fr9FlqAO8LWPOEeB
 neCPyvLpJ0H1O7ycZGEqOtdc2dXT7nrhzBCQ+nJu7fNUc7jXUD8MecFlGbbFpIynLRN7
 ix7rsTXJMcN/399svJzINziojHg5+KbDXOgqkDHo1D28yC7XvBD+ijZiQ2M4DTLBuvqk
 Vgzw==
X-Gm-Message-State: AOAM531NHyPHaJR7prD1MHo0PfM0zF7gU4Okv3O8TfkJHpTwftDQe/CN
 1ezAi0OnEU2Tz3savhhEsnKVZ8qKuXDMwJKsxEvljlmTjtEYlclU1FqRS/sl2cZLj2flB/xLM1i
 qcjATsU9JlHcyxRQpdGRZuI1OMY8EY0WfoFr5OphEXA==
X-Received: by 2002:a05:622a:293:b0:2f9:3ab6:a462 with SMTP id
 z19-20020a05622a029300b002f93ab6a462mr18387282qtw.546.1653647799269; 
 Fri, 27 May 2022 03:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCj+m03onZL8ESQWhknID+ES7qStMFrkjNlklugGOQyZkMOqq0rGwzKUL4uYoaC7qHSvuTtQ==
X-Received: by 2002:a05:622a:293:b0:2f9:3ab6:a462 with SMTP id
 z19-20020a05622a029300b002f93ab6a462mr18387263qtw.546.1653647799063; 
 Fri, 27 May 2022 03:36:39 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 m184-20020a37bcc1000000b006a323e60e29sm2557931qkf.135.2022.05.27.03.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:36:38 -0700 (PDT)
Date: Fri, 27 May 2022 12:36:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 3/9] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220527103632.ujsefjwkddoaoxwi@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220527060120.20964-4-jasowang@redhat.com>
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

On Fri, May 27, 2022 at 02:01:14PM +0800, Jason Wang wrote:
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

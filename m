Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA0FC433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7A2724134D;
	Fri, 27 May 2022 10:35:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oh5UR03v1QVp; Fri, 27 May 2022 10:35:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C72734056C;
	Fri, 27 May 2022 10:35:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B1D1C0032;
	Fri, 27 May 2022 10:35:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70A74C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 50815425FF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:35:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n2ymbXBBNT5r
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:35:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 047F9426F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653647737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/zrleRNQCe5coayR0kaH9WedW9Vs8BA6BoXc0zZ1wCI=;
 b=Who4TcVQL6JQtcnUkDSNNz/PwVfyo5O1UgmznMkPmnjQrT5PZEBX2Rt6/IIge8rxZamBl4
 wf2n/uJUyfyb7yVMWjvjCD0fey69Kl77pS7CaqUW5NtPhdj2co+z/xCDbgot9E9jaN3EKh
 hqy+ResCfvS7eEX3alEGLCZLpgLwf5o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-tm2oafqGN6-HoTyOrp_JvQ-1; Fri, 27 May 2022 06:35:36 -0400
X-MC-Unique: tm2oafqGN6-HoTyOrp_JvQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 de12-20020ad4584c000000b0046266e975ddso3139872qvb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:35:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/zrleRNQCe5coayR0kaH9WedW9Vs8BA6BoXc0zZ1wCI=;
 b=O1gGgnZncniad8SHDP/zbmcAoET67Yg/yffzRFinkrnPyUtQ9RhB0GjUKCIVaHbciU
 z8k5NszSt60Sjtod2qoK0U0/9CIfAM52xtzj3vJiQhu5Wd6mdwLgwUW0kZRUJ74+67Me
 t5yI8NbNqCerHkD0gk9lJfgjNQQ/MrrSK6BKhIrofUwyWA0sLlw9YPbiG50qto3w4DgA
 W2LdNqvsq2e2NYBD7UrC5sGpEdXpI/Njabp8OPXmnbqrp8yWRiPh48OqIzSQVPDRgQcQ
 8mjgZjomA+QSKEyzFpc8mKh/VfFmL8bZjRnzol0PBDFGZrIN6pL30V8GbS20TZ3E/isJ
 QFeQ==
X-Gm-Message-State: AOAM532i/dzx066qg8cMC9HqAIkIc0uGchzDzpPwR9BHnbSVXkJZff7q
 7VM20IGVqUwTgIdC6MKrmPXnlEsAyFRVDo+Je4WkH08EqzwGLBlJOsTcI2NX4xhLlGSBffKC+QF
 i6myWk+I7dFq2/qFSN24Ce/Kft8lQoUsLtZzFg5N8XQ==
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id
 s15-20020a05622a178f00b002f3dd2e6054mr32734459qtk.554.1653647736324; 
 Fri, 27 May 2022 03:35:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/DdJ7C1pNGSuqERmPyGufmFDtkXuN7ZZ9wXEOlVJRq4YbuWRCxS9DqSNdvMaM0Tg+oETAlQ==
X-Received: by 2002:a05:622a:178f:b0:2f3:dd2e:6054 with SMTP id
 s15-20020a05622a178f00b002f3dd2e6054mr32734439qtk.554.1653647736086; 
 Fri, 27 May 2022 03:35:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 c142-20020ae9ed94000000b006a33fc1113csm2498024qkg.23.2022.05.27.03.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:35:35 -0700 (PDT)
Date: Fri, 27 May 2022 12:35:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V6 9/9] virtio: use WARN_ON() to warning illegal status
 value
Message-ID: <20220527103529.kc6tpon3lohceskm@sgarzare-redhat>
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-10-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220527060120.20964-10-jasowang@redhat.com>
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

On Fri, May 27, 2022 at 02:01:20PM +0800, Jason Wang wrote:
>We used to use BUG_ON() in virtio_device_ready() to detect illegal
>status value, this seems sub-optimal since the value is under the
>control of the device. Switch to use WARN_ON() instead.
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
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/linux/virtio_config.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

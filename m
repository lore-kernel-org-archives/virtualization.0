Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3D0C433F5
	for <virtualization@archiver.kernel.org>; Thu, 19 May 2022 08:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC9DF60DA5;
	Thu, 19 May 2022 08:34:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0a__hx1JZUgc; Thu, 19 May 2022 08:34:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A41DE60D95;
	Thu, 19 May 2022 08:34:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7D4BAC0039;
	Thu, 19 May 2022 08:34:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 107E6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4C90843EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5kHnrfQT2VkU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BA2B83E79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 08:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652949287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXQa/is57ndmeB4UOc268UZ9oUyQAZpGNBvHCtt4ZMQ=;
 b=XYEX3fcWt/be2EZlP1kdRbN/3G23998sXwwW8lUKYfyyGJe5+IAhW4OaC7YjVcwfPydArQ
 Bx4hsyB1CbS51dNiodDTaMuIajCbgt9t74+sei+iMQZ/LPWRA9qceFMRzO7B0uMKlAIx7C
 rVEPlqT+Qxf22LTq8oXVasr+MlpDIFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-X1sJVxHJPRuVlXQ13m-wcg-1; Thu, 19 May 2022 04:34:45 -0400
X-MC-Unique: X1sJVxHJPRuVlXQ13m-wcg-1
Received: by mail-wr1-f72.google.com with SMTP id
 m8-20020adfc588000000b0020c4edd8a57so1289730wrg.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 May 2022 01:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RXQa/is57ndmeB4UOc268UZ9oUyQAZpGNBvHCtt4ZMQ=;
 b=WVz0Uub/B+ZxODLR63/V0A0w40r0UUAB6wE+uNRAyVWwHExFeVExx67p7M/w2FqyZ+
 lZfeaZyNRvoz+f7bTPtHefS/C/l5tzPdNFvjaIOqUMlHxhbIrmn2kPP7yHlb7ybkqTJA
 OaADKWo/QWK1PdZ6UdeDtihj9X/jwOpH+s9FBTAQHH3siRTFesFkZ0XdOotP8Tbhnj9J
 Qzn7SUpFINUJMVqkI0rgwKiJ8Mn6rs0FLD2qMn4SiaJJjQe/LgGPUazFOvr6CY+pP0G2
 VSU8XVPP33Q1+IT7oWJDhvcd8stnO2zLxSp8sDIelO+R4/xPykU9FqZuhRKTtsfMdbFW
 uF7A==
X-Gm-Message-State: AOAM532SzzYUbbHvK70900FjuMC0dOs3lxSrSpefi83Ieq21/et9Nr/y
 Ajg3Zfnyv4w6J8CxrIdAiMBBfflnmIg9fUnUITy0Vd0jG6AMU/LOq7s3kq1Y7f2pdSzHDZVe7i5
 FBWJe550/mb2xfoXQ9dQOXtFkwjdl3CH2EcmEUsZzfw==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id
 l3-20020a05600c4f0300b00394649921c7mr2708655wmq.103.1652949284639; 
 Thu, 19 May 2022 01:34:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAkq9/tyayvfVCMywTQMNAHfHo8x/Yw3YYtWkfOqMxHBW6hbphrtHFbnw12lWB4vdPFEW1PA==
X-Received: by 2002:a05:600c:4f03:b0:394:6499:21c7 with SMTP id
 l3-20020a05600c4f0300b00394649921c7mr2708636wmq.103.1652949284410; 
 Thu, 19 May 2022 01:34:44 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 n4-20020a1c2704000000b003942a244f3asm6212873wmn.19.2022.05.19.01.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 01:34:43 -0700 (PDT)
Date: Thu, 19 May 2022 10:34:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 9/9] virtio: use WARN_ON() to warn illegal status value
Message-ID: <20220519083440.luyv6lzcq3fiw27e@sgarzare-redhat>
References: <20220518035951.94220-1-jasowang@redhat.com>
 <20220518035951.94220-10-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220518035951.94220-10-jasowang@redhat.com>
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

On Wed, May 18, 2022 at 11:59:51AM +0800, Jason Wang wrote:
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

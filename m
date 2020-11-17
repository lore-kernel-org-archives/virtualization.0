Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7ADC5519F
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 15:05:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7487024198
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 15:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCGYHLoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7487024198
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4EDCA8706F;
	Tue, 17 Nov 2020 15:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P5K37u9oFDIF; Tue, 17 Nov 2020 15:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 94A9886F8E;
	Tue, 17 Nov 2020 15:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65799C0891;
	Tue, 17 Nov 2020 15:05:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B23F1C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 15:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9C39E84948
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 15:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtQjxfSwB0h3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 15:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A8952848A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605625530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/nOqhucfZUlsIYVt0sm+AbfGVI1whVk4z8pbvaxmKA=;
 b=TCGYHLoN9sy/OeRcSOnWwNvpeYT5qUQNzni5dervMl/yUQVBVWgj3z3pq8jsUzHOm+fiaK
 4jW/hiuyGLkIkC8gfEh9ekZRmROXI/KHiqNHdehOPi/cEyeNEPJN7c6fvcyL1d8lLf0VYd
 NcuGnvMHm6O9jfvoqhwFEGaCPBmg7vE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-eXTdzrkmPVeIrSFDT4gF0Q-1; Tue, 17 Nov 2020 10:05:28 -0500
X-MC-Unique: eXTdzrkmPVeIrSFDT4gF0Q-1
Received: by mail-wm1-f69.google.com with SMTP id s3so1877423wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 07:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C/nOqhucfZUlsIYVt0sm+AbfGVI1whVk4z8pbvaxmKA=;
 b=UIkq7adPQYYVMpdKvhC0jZ0/FUwtQYxze44lXpolwO9k8N5+UT8/5fRFe+y1Lto0L6
 9Q4YhWeDIvZ15jlliE/m9QdxaHXwTYgPXL8+EBhdW9nrNQmBU2a/B4tBQp54KQAd6JBK
 wcUHfBiFBXXRTRhmPKIYrm2TI32Wgpu056ys8SMj/WXcyuXCQxNaQQvG36nkXQUo/bsQ
 frBWu61WFyO2AGDgM/Uxmiq9OtmJCF7vVlKm7m2vrsnWbwjZabKVHH/6aEKlK3D+vx5w
 O/APoR2/Lc0RyNhQ2d3134oIEinhfHu+d0V905zUWK9Tgs5HTxXfC8yaQcr6gndnSrUz
 v82g==
X-Gm-Message-State: AOAM5337ZvZyR527PDLxwNuqzuoo+38LX3okZSnhg6OPyiApfkqd4uxx
 SXcBdZ39kGyqx+HeOCwt5EfRVxfyAdUZW/KxWfynwFWd3/zehtA+WSKaG0efD4plzXLgR1KcSFZ
 1YF/2fItCgMY0dCoRnFKTD1k3M4VZ4/EfqhNBTvEXHA==
X-Received: by 2002:adf:e284:: with SMTP id v4mr27243144wri.271.1605625526852; 
 Tue, 17 Nov 2020 07:05:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXFMUC7GbvK+tcAatXhQQBJ4QIJaiqBrH3tZKm9AnxaGW5zb1KUr9XSbvepq2Td91tZd0S0w==
X-Received: by 2002:adf:e284:: with SMTP id v4mr27243126wri.271.1605625526652; 
 Tue, 17 Nov 2020 07:05:26 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id g23sm4050490wmh.21.2020.11.17.07.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 07:05:26 -0800 (PST)
Date: Tue, 17 Nov 2020 16:05:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 01/12] vhost-vdpa: add support for vDPA blk devices
Message-ID: <20201117150523.berhqwtgqjov3i63@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-2-sgarzare@redhat.com>
 <20201117105709.GC131917@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201117105709.GC131917@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eli Cohen <elic@nvidia.com>
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

On Tue, Nov 17, 2020 at 10:57:09AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:01PM +0100, Stefano Garzarella wrote:
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index 2754f3069738..fb0411594963 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/nospec.h>
>>  #include <linux/vhost.h>
>>  #include <linux/virtio_net.h>
>> +#include <linux/virtio_blk.h>
>>
>>  #include "vhost.h"
>>
>> @@ -194,6 +195,9 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
>>  	case VIRTIO_ID_NET:
>>  		size = sizeof(struct virtio_net_config);
>>  		break;
>> +	case VIRTIO_ID_BLOCK:
>> +		size = sizeof(struct virtio_blk_config);
>> +		break;
>>  	}
>>
>>  	if (c->len == 0)
>
>Can vdpa_config_ops->get/set_config() handle the size check instead of
>hardcoding device-specific knowledge into drivers/vhost/vdpa.c?

I agree that this should be better. For example we already check if the 
buffer is large enough in the simulator callbacks, we only need to 
return an error in case it is not true.

@Jason, do you think it's okay to add a return value to 
vdpa_config_ops->get/set_config() to handle the size check?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

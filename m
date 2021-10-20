Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FEC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:44:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E6B61361
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 08:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04E6B61361
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C316780EA9;
	Wed, 20 Oct 2021 08:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwxZ6ffbFedf; Wed, 20 Oct 2021 08:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B82480EB0;
	Wed, 20 Oct 2021 08:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 344BCC0011;
	Wed, 20 Oct 2021 08:44:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD7B9C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6D9B406F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9DZnmtQFtmJ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:44:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A73B04075D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634719450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvyTqgdf6ZEWMdPd4rQvCZfBzmf4LkWCdbjva2HVh0Y=;
 b=b6hZu1I58SJgoQEURRBDPzgKwAdKRle/5CxAQDeJvRLi8yg0SEVTR9H2bbebR8QRMwpICu
 7cGweLQJ0i1gSYHQdeS91Yh7QesRId5QazGl7az9LjkZQaXeQrki84BwwhsHbVakwCW+v4
 2e1JqiyJzDLLD7HNNO9141ZStiA4p7g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-q6zEVPWaONKZ5gtMwzz-lQ-1; Wed, 20 Oct 2021 04:44:09 -0400
X-MC-Unique: q6zEVPWaONKZ5gtMwzz-lQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 c25-20020a056402143900b003dc19782ea8so16826083edx.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MvyTqgdf6ZEWMdPd4rQvCZfBzmf4LkWCdbjva2HVh0Y=;
 b=4ezTuxSXKOMdUGZMIvVvgYe90+66ZCaibsLxooteUVb35hV26IawATy0Bd/bbz/Z/S
 d1nG3XytrD2fRXZDgiTdcmYimOsB1YPSvhlGTM29rc0Wk7hq+qcPhzril+AGZ64vAUXF
 7aJahPnKcahmb6cokt0zW1xy3S4xUFVD4O3xHrqSIfSwWg8OF5dq/+6JnvC9U471kd60
 vIiFnZZuFPOZXlw4u5SNGkv/l7Gy49pGC1uQR/7IBGFt8aqFPYZCCw8B8B2iroIpssM/
 udlDCFi0NEk0597oKbiZ73Gk6Tz+BfskD5VXvEa9jKemcXXopvnp28sGNdG8e/SimNGi
 O/ew==
X-Gm-Message-State: AOAM533B4gC6r/woPpN7rRUwARpCP1cAZLpXAN+tP2OUAzEkLSelRO7l
 nu9Ah/v9YC9+040VV+cHofIIGdzwVTVtTX3Ys517n6jbZwYbLyxkIiOKgDBEKQkqbjRQUKQ7eXJ
 yimhrHRCfSod98Y6MWSYn4PtCCEsQHROXv8zxddBzRg==
X-Received: by 2002:a50:becf:: with SMTP id e15mr62263627edk.114.1634719448248; 
 Wed, 20 Oct 2021 01:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziLPARPu3vpcjg9vV2//vlu9Wj1zslEGWBXZoVzlVWTah1TQHfmixIcHaGl8kIhAPyzr0PsA==
X-Received: by 2002:a50:becf:: with SMTP id e15mr62263605edk.114.1634719448084; 
 Wed, 20 Oct 2021 01:44:08 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it.
 [79.34.250.211])
 by smtp.gmail.com with ESMTPSA id b2sm802439edv.73.2021.10.20.01.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 01:44:07 -0700 (PDT)
Date: Wed, 20 Oct 2021 10:44:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <20211020084405.yrnbouwljqkoopsk@steredhat>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
 <20211020071817.pzyfploxlryvdf3p@steredhat>
 <20211020032849-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20211020032849-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Oct 20, 2021 at 03:37:31AM -0400, Michael S. Tsirkin wrote:
>On Wed, Oct 20, 2021 at 09:18:17AM +0200, Stefano Garzarella wrote:
>> On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
>> > If an untrusted device neogitates BLK_F_MQ but advertises a zero
>>
>> s/neogitates/negotiates
>>
>> > num_queues, the driver may end up trying to allocating zero size
>> > buffers where ZERO_SIZE_PTR is returned which may pass the checking
>> > against the NULL. This will lead unexpected results.
>> >
>> > Fixing this by failing the probe in this case.
>> >
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> > Cc: Stefano Garzarella <sgarzare@redhat.com>
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> > ---
>> > drivers/block/virtio_blk.c | 4 ++++
>> > 1 file changed, 4 insertions(+)
>>
>> Should we CC stable?
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>No IMO - I don't think we can reasonably expect stable to become
>protected against attacks on encrypted guests. That's
>a new feature, not a bugfix.

Yep, make sense.
I had only seen the single patch, not the entire series, and it seemed 
like a fix.

Viewed as a whole, it makes sense to consider it a new feature to 
improve audits in the guest.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

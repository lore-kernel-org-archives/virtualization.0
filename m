Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E80C4332F
	for <virtualization@archiver.kernel.org>; Sun,  4 Dec 2022 12:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8932C410D5;
	Sun,  4 Dec 2022 12:27:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8932C410D5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XYbyAu1g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u-WJpitO8g0c; Sun,  4 Dec 2022 12:27:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 10DAC415A9;
	Sun,  4 Dec 2022 12:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10DAC415A9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4A83C0033;
	Sun,  4 Dec 2022 12:27:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5D60C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D7A540354
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:27:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D7A540354
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XYbyAu1g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NF8gsWojbjkb
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:27:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A19AE401C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A19AE401C2
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670156864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NxiLSoMTq6DglN2UEDy7jGoO/q2kj6Qvv3OXjWFI4W0=;
 b=XYbyAu1gQ8BQOlIYfqzMqUpvCNOxDr810fS5w2exj73FK6Y/6wDoaMj2yJ71oofUjf61SX
 SUOvmfO3Un5YDRYVTI8wRhJgE6BbCTqxPS2p76z7nxrnR4TArMb23cH72s5/3HRGjVanUz
 6IV9TfjC0Z2M40Pb90a+1g7n6fkAqg0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637---44qKYZM9GxDvrqYrBNLQ-1; Sun, 04 Dec 2022 07:27:33 -0500
X-MC-Unique: --44qKYZM9GxDvrqYrBNLQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 s24-20020a7bc398000000b003d087485a9aso2195035wmj.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Dec 2022 04:27:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxiLSoMTq6DglN2UEDy7jGoO/q2kj6Qvv3OXjWFI4W0=;
 b=sPS2sgZnxLpzm7FWAdakZtGt4mTekkn8MpVwM8o7sJLDNlSU1sGR3JAXdkBbYEVFmg
 +rVKUjIC72GWJl5pDLtt1NheDqRIrab6xhiUofvaSo7AgUQfESqXt3fcFgNr+kSFEynw
 Y0loQ7uW3qUcqSyO2G4j2FpCdkmL27AEocuK/rmu9ScLC+3SfaUsLEV5h51n+0myJ57q
 panJj0uNo7wcRqmsdhK95BeqHldblLFbH+R8rswgKhV3IbPI82h90CmAtdqD7/Wy0RLM
 WH0h7pns554io7MNU+5/zDK/oFMf89bZT4j5WhWIQaPM+yGdKj4FIZz4aMzyq4Sap7c7
 xqag==
X-Gm-Message-State: ANoB5pnqw5b/ogo6t3KhSAVYplG5ofUUgIblksIcSZozaY831+06K1m1
 JjH3hPIjdXpMXQAo8NE707qAcexwk+4rhpg7YugXKVPIAio6GIY4xKlslQqRAnwAcvwRqMvVCdq
 cO3/YIHnwL8smNm4XtbCO27ZnHohoPX6F7VH+s/yfeg==
X-Received: by 2002:a05:600c:2241:b0:3cf:9ced:dce4 with SMTP id
 a1-20020a05600c224100b003cf9ceddce4mr56204074wmm.120.1670156852308; 
 Sun, 04 Dec 2022 04:27:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4xaZ2pnGmhnIqmC2VA2fnQvK0akf+ksQwU/2bNmZG1FBlm8U2IwUxDLH8QYpze+rNZ16+u5A==
X-Received: by 2002:a05:600c:2241:b0:3cf:9ced:dce4 with SMTP id
 a1-20020a05600c224100b003cf9ceddce4mr56204060wmm.120.1670156852086; 
 Sun, 04 Dec 2022 04:27:32 -0800 (PST)
Received: from redhat.com ([2.52.16.138]) by smtp.gmail.com with ESMTPSA id
 dn13-20020a05600c654d00b003c6bd12ac27sm14119505wmb.37.2022.12.04.04.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Dec 2022 04:27:31 -0800 (PST)
Date: Sun, 4 Dec 2022 07:27:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221204072703-mutt-send-email-mst@kernel.org>
References: <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora>
 <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
 <20221129001239-mutt-send-email-mst@kernel.org>
 <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
 <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
 <20221204055044-mutt-send-email-mst@kernel.org>
 <CAJs=3_D1nX3K4=PXiS_CoLHmq1TbYUhecM6CkWT6FCV1JV2PCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_D1nX3K4=PXiS_CoLHmq1TbYUhecM6CkWT6FCV1JV2PCA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Sun, Dec 04, 2022 at 02:00:25PM +0200, Alvaro Karsz wrote:
> > I don't see the connection. virtio would often pass through lifetime
> > info from the host. If other devices gain more info then it will make
> > sense to add that to virtio, too.
> 
> > Depends. If we expect more types, then I think we
> > can solve this by passing an array of values.
> 
> 
> Good idea!
> 
> We could pass something like virtio_blk_lifetime_ioctl struct to userspace:
> 
> enum blk_lifetime_type {
>          VIRTIO_BLK_LIFETIME_PRE_EOL_TYPE_A_B = 1,
> };
> 
> struct virtio_blk_lifetime_element {
>         void *data;
>         enum blk_lifetime_type;
> };
> 
> struct virtio_blk_lifetime_ioctl {
>         struct virtio_blk_lifetime_element elements[];
>         u32 elements_num;
> };
> 
> If just VIRTIO_BLK_F_LIFETIME is negotiated, the array size is 1, and
> the element type is VIRTIO_BLK_LIFETIME_PRE_EOL_TYPE_A_B, so the user
> will know that this is a virtio_blk_lifetime struct.
> This seems general enough to handle future additions and to handle out
> of order types (if for example VIRTIO_BLK_LIFETIME is not negotiated
> and VIRTIO_BLK_LIFETIME_FUTURE is).
> 
> The only downside I can think of is if we add new fields to the struct
> virtio_blk_lifetime struct, instead of creating a new, dedicated
> struct in the spec.
> For example:
> 
> struct virtio_blk_lifetime {
>   le16 pre_eol_info;
>   le16 device_lifetime_est_typ_a;
>   le16 device_lifetime_est_typ_b;
>   le16 device_lifetime_est_typ_c;  //only if
> VIRTIO_BLK_LIFETIME_FUTURE is negotiated
> };
> 
> In this case, we may need to split it into 2 different structs, and
> pass it as 2 elements to userspace.
> 
> What do you think?
> Should I go ahead and create a new version?
> 
> 
> Alvaro

And now is this generic enough to disconnect from virtio and
make it a generic blk thing?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A4C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:22:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CB76120C
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 53CB76120C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1B6BF403DC;
	Tue,  5 Oct 2021 11:22:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uhJnn_nKwQyH; Tue,  5 Oct 2021 11:22:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 696584033D;
	Tue,  5 Oct 2021 11:22:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 442D3C000F;
	Tue,  5 Oct 2021 11:22:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE29C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E46D54071B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hqq6QLvdBoiw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:22:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FB804062E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633432950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wE1bUrVOz4BYaLjUtGwWBCk3EXj9S4WYQ1RY/Lu9Ah8=;
 b=PC1OTrPDU6IhPOsUsRuwgeHkNIMUAIZC+8NwbOCX2sMs/Isf6rqEDi4eMrcDk+9nrPAo1n
 6tXKFk6LEAKkw0EyG0HnjFNBl04lDWDTSNtK70QyQC8LrJyeNdtBjP98z3uOV6bkB9kLwk
 owcj8aIZQ4tj9GD37tJZEHRw+uXxlzo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ptsKH3HkPzysjuNGD8E9Pg-1; Tue, 05 Oct 2021 07:22:29 -0400
X-MC-Unique: ptsKH3HkPzysjuNGD8E9Pg-1
Received: by mail-wm1-f70.google.com with SMTP id
 10-20020a05600c240a00b0030d403f24e2so1159315wmp.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 04:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wE1bUrVOz4BYaLjUtGwWBCk3EXj9S4WYQ1RY/Lu9Ah8=;
 b=1tcB95sIScAkf4yPVmZMsymbPbQ3SU1NcPrn/YAYBQQRIruVJf3DRhZjm9gIt4mMXu
 2bJO6qHqBBNO8glCoghkKYICL5JklEaNPCirDFxwHx+UN4UcUhp+uBPBTiirvzQMd9qc
 8UB/SgOgfO1lf1JM3z/aq18JU1mKRtcuXAN+xEv/gmscAu2qsAylxaeGwmhHVA/tI1F5
 caej4qnM/YoPL5bC0fyDD9CtWFEey88QTslSJbXuJd4AIIMHMSYJ4sxD3K6kvq0YjTnI
 kpou4+BtghweF4nAtpje6j08nDTrmqeCBMhNWNOg9pAKOejJUn/ceD9gK+tybHRw95BT
 7aTg==
X-Gm-Message-State: AOAM532nIIuKBq+GgsJHfom1HXe+4F/hhw+izs4d3TkHgJrL7j4Udzwp
 gbn18yfZg/KOMIPivHnsduVFkvRt0x6MBT4DTyZL90fpbWuBpD/okDEEe35/viD0yJ36AgKJePC
 68duejF4nuj6kYmEs7ymUxruS7jQmB4EQ9pwrdn5hqw==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr2708856wmh.188.1633432948049; 
 Tue, 05 Oct 2021 04:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaxSCZ8C9PBcz9/fRUGZM1W9zwisk/Hu/CflYvR2sGCyXuW4+G9Kdy4Fx2/9/mPdA14qVC6A==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr2708838wmh.188.1633432947907; 
 Tue, 05 Oct 2021 04:22:27 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id u5sm18156337wrg.57.2021.10.05.04.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 04:22:27 -0700 (PDT)
Date: Tue, 5 Oct 2021 07:22:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Message-ID: <20211005072110-mutt-send-email-mst@kernel.org>
References: <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
 <20211004160005-mutt-send-email-mst@kernel.org>
 <20211005131751.53175b10.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20211005131751.53175b10.pasic@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, markver@us.ibm.com,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, virtio-dev@lists.oasis-open.org
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

On Tue, Oct 05, 2021 at 01:17:51PM +0200, Halil Pasic wrote:
> On Mon, 4 Oct 2021 16:01:12 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > 
> > > Ok, so what about something like
> > > 
> > > "If FEATURES_OK is not set, the driver MAY change the set of features it
> > > accepts."
> > > 
> > > in the device initialization section?  
> > 
> > Maybe "as long as". However Halil implied that some features are not
> > turned off properly if that happens. Halil could you pls provide
> > some examples?
> 
> 
> 
> static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
> {
> ...
>     if (virtio_has_feature(features, VIRTIO_NET_F_STANDBY)) {
>         qapi_event_send_failover_negotiated(n->netclient_name);
>         qatomic_set(&n->failover_primary_hidden, false);
>         failover_add_primary(n, &err);
>         if (err) {
>             warn_report_err(err);
>         }
>     }
> }
> 
> This is probably the only one in QEMU. Back then I stopped looking
> after the first hit.
> 
> Regards,
> Halil

Hmm ok more failover issues :(
This stuff really should be moved to set_status.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

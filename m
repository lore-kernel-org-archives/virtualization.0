Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AFEC4332F
	for <virtualization@archiver.kernel.org>; Sun,  4 Dec 2022 10:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8D473415DD;
	Sun,  4 Dec 2022 10:59:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D473415DD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IOdcjtz2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tHcXb1__ftQS; Sun,  4 Dec 2022 10:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9748415D6;
	Sun,  4 Dec 2022 10:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9748415D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8912C0033;
	Sun,  4 Dec 2022 10:59:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CE16C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 10:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51561415D7
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 10:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51561415D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id urbd24a9ehlG
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 10:59:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DF61415D6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0DF61415D6
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Dec 2022 10:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670151558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n2vSwclUejqn3Ck5e8S1I73p9QiHd3aIc+DxCsE8wq8=;
 b=IOdcjtz2OMPM2hAyyok8sZDYD+nK7RD0RTOMe5odllzRmcuEPGYey1oaaPiM/IKGZZS2vZ
 hNy0G9ax/Gc2DoSYaSEZyTKEQIhn2gTtk6fcvNxkvkswtoctTr+EAkebQeJ0jioSS/WXsi
 JNKAJBTy0rLcIFYdc4qe2TTYA1G2zPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-oCbESuk7OaCcuDNETNrHMg-1; Sun, 04 Dec 2022 05:59:14 -0500
X-MC-Unique: oCbESuk7OaCcuDNETNrHMg-1
Received: by mail-wm1-f69.google.com with SMTP id
 j2-20020a05600c1c0200b003cf7397fc9bso5219107wms.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Dec 2022 02:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2vSwclUejqn3Ck5e8S1I73p9QiHd3aIc+DxCsE8wq8=;
 b=DrwExAHwAgEZAjgxvpoaWOfR15gCXOu5JKDRQ4/DCKOTj81GD2Abjod5kai7gx5FRz
 l2WvbKb1KtMM+6LAjXy+I/J+8vBW+uJUj9bBnqScXuBsEBcapnQ3bLzRWrdo8JauJszt
 i/aEOerYzYg6MH4zdAtk8ClLoBiDt78Qy5uRmOjp9E0HSqfnVj80/WmYwgP3tsrQZWYY
 YHlEBpE+s6cNgmGQbFS6rLa1H6seowUjErYeFVwrAXJ3PFPXl9RNwTVjE/DZ3oItCLhv
 2ImRK08i7l+o9z9I0cw/rvDeGUTr5O7cMaXY8Z8hXctKIodVlKFLrGq8UAN3rwCbh3Tk
 3KLA==
X-Gm-Message-State: ANoB5plQAaLlQf2gkt0wac+tAzsPsrY//Hy8wNlgvOmHtLAWKTL77976
 cLVRBuiu/idcqd1eC8JwyJ3OEYtCKblTUAqBilylfTU/gh0e3/TZoSgMlicStA3UHjj1seJm1NH
 nzdqKNFcdeCT1f1p+sLrRFuZHeYyCKSyb9fFhmDVfFA==
X-Received: by 2002:adf:fb91:0:b0:236:6de4:27b6 with SMTP id
 a17-20020adffb91000000b002366de427b6mr45567068wrr.601.1670151553358; 
 Sun, 04 Dec 2022 02:59:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YLUEOb56N9sVgTaeSEhjalvjla86PWhwuc+E4JyynlDNAqIA0YahYUSrrc7cTNomaXWgpGQ==
X-Received: by 2002:adf:fb91:0:b0:236:6de4:27b6 with SMTP id
 a17-20020adffb91000000b002366de427b6mr45567062wrr.601.1670151553095; 
 Sun, 04 Dec 2022 02:59:13 -0800 (PST)
Received: from redhat.com ([2.52.16.138]) by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b003cf54b77bfesm19953678wmq.28.2022.12.04.02.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Dec 2022 02:59:12 -0800 (PST)
Date: Sun, 4 Dec 2022 05:59:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221204055044-mutt-send-email-mst@kernel.org>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora>
 <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
 <20221129001239-mutt-send-email-mst@kernel.org>
 <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
 <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
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

On Sun, Dec 04, 2022 at 10:19:38AM +0200, Alvaro Karsz wrote:
> So, we could create a block-general lifetime ioctl with many reserved
> bytes, or create a virtio block specific ioctl without reserved bytes
> at all.


I don't see the connection. virtio would often pass through lifetime
info from the host. If other devices gain more info then it will make 
sense to add that to virtio, too.

> I think that we should keep it virtio specific, and if a new lifetime
> command is added to the spec with more fields, we could create a new
> ioctl.
> Does Everyone agree?

Depends. If we expect more types, then I think we
can solve this by passing an array of values.

> > I think if you are going to pass struct virtio_blk_lifetime to
> > userspace, better pass it as defined in the spec, in LE format.
> 
> > It's unusual for an ioctl to produce a struct that's not in CPU
> > endianness. I think the kernel should deal with endianness here.
> 
> I'm not sure how to proceed with the endianness matter..
> 
> Alvaro

If it's a generic ioctl then clearly it's native.
For a virtio specific one, we typically use LE and I would be
consistent.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE8AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 09:21:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A3AF40BF0;
	Wed, 23 Mar 2022 09:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XIRIxt4-H-ak; Wed, 23 Mar 2022 09:21:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69DB5401D2;
	Wed, 23 Mar 2022 09:21:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D1EAC001A;
	Wed, 23 Mar 2022 09:21:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CD6EC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F10A6417EF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FIhHElRKPg0y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60AD541823
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648027309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nAs1YHlMpNVeBM3NTvl8o2J8QfBxr1UoRYr/a2zNDSI=;
 b=ij7dzQ3R2joDIncWWMgbv+xMznz5aR2TVsdEZitMmFeGDdyEVysODeVWeAXgEm5rV3lnQF
 sMfKlTTsqqK5fnjZwaILFRtz0jk561g7ouqB6h+tuLkqP10TmFV1J8Qn6x8Yc8ArJBX5Fq
 Ku79LIPv14utAaFVhdZecg21W2a+FmY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-vJDCqlQvMumLZa8r7KsAlg-1; Wed, 23 Mar 2022 05:21:47 -0400
X-MC-Unique: vJDCqlQvMumLZa8r7KsAlg-1
Received: by mail-lf1-f69.google.com with SMTP id
 h14-20020a056512220e00b0044a1337e409so397762lfu.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 02:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nAs1YHlMpNVeBM3NTvl8o2J8QfBxr1UoRYr/a2zNDSI=;
 b=IqWF8IqeI04feGcKAD9w14TOaEBs73NJAOMlRtciKPK+rcmDoXgTMps3FNkdQJQ/CK
 6hZHBPknk16wQ3Du4ysjNt57h4ma0KLeoTKOZUkh+Rj3WAB4STvSmVY+gtMDPBmtwYqj
 KPZ26BpQALCGhsp3+D0ykfbDkLsJz64Vf6SlAID9EXmWMycRUQ6D6pH2KV++tXHq8BRs
 eH9EAqT4bX5vhHgf7eVU1/B1RzPue4GudScWd8M4pZXoWwFp4Gjy0uTA+SJlvCkivP4I
 2KA5c03awUzTVW9oFcQSafEgWC8a+jrPoiJ1fY5niiKLmDNMpc0jtQd/Xr9/vPxrwpM1
 fMVg==
X-Gm-Message-State: AOAM533hPdK4gwWiJUNBKOTn6nh0l97jYUZJj8XPpD5L4Cqy2k6h49+y
 n4U6q8p6NLy1Q1JVlRchiJwSG5Oj6xgXVobUkfUCciVJZluBU75GQVR/2sgi7U/udIbMHyFuYST
 6qYZyPHlnmTEaNfMfLQxncBce+i/vmyNaFGT5B8B2lmnf2XF0E0ps1JzgYQ==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr21038684lfa.210.1648027306109; 
 Wed, 23 Mar 2022 02:21:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGnDD++CkvJ3d1W9q5s2ajSbWe58qQkyPqIuKEuj5wAXh+7QvBP7wfNAtvIkw3xZn3czapRyuVl2X0us7jZRs=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr21038679lfa.210.1648027305935; Wed, 23
 Mar 2022 02:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220323031524.6555-1-jasowang@redhat.com>
 <20220323031524.6555-2-jasowang@redhat.com>
 <878rt1xcq2.wl-maz@kernel.org>
In-Reply-To: <878rt1xcq2.wl-maz@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Mar 2022 17:21:34 +0800
Message-ID: <CACGkMEu-sQZO6-LBsLAzw4bqQpua1DXYLcAukjCtd43P3Ei4Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "virtio_pci: harden MSI-X interrupts"
To: Marc Zyngier <maz@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Keir Fraser <keirf@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Mar 23, 2022 at 5:05 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 23 Mar 2022 03:15:24 +0000,
> Jason Wang <jasowang@redhat.com> wrote:
> >
> > This reverts commit 9e35276a5344f74d4a3600fc4100b3dd251d5c56. Issue
> > were reported for the drivers that are using affinity managed IRQ
> > where manually toggling IRQ status is not expected. And we forget to
> > enable the interrupts in the restore path as well.
> >
> > In the future, we will rework on the interrupt hardening.
> >
> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > Reported-by: Marc Zyngier <maz@kernel.org>
> > Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> For this patch and the INTx one:
>
> Acked-by: Marc Zyngier <maz@kernel.org>
>
> Please keep me in the loop when you decide to rework this.

Ok.

Thanks

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

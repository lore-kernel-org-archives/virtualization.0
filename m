Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A19C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 05:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D64E160AA3;
	Thu, 28 Apr 2022 05:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DbTSlpbFA36E; Thu, 28 Apr 2022 05:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 74F5F605E8;
	Thu, 28 Apr 2022 05:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A1EDC0032;
	Thu, 28 Apr 2022 05:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A601C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 510EE60A6C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LoPsnYMf0CHF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:55:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 415DD605E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651125319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zgRDxje8lznBc9+MD1tXV7m51++4qJtjj5+PFYkzgUw=;
 b=e1rm8HVAEEqUmgpdRC8pVcQ0Y7X3u4bvvgKVCIZ+AX++1TsqT4PlVUESRqEbelwbjk23hn
 2kLL1fN8zYEnZjD1f7BiT5JkbwTCh4u5HPV3AzikNI9WWZQ6bijlcnO349bOiSCvTrQIk+
 gJbW/MqPI+BBfur2cUM+Bpql9GrIqcs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-dR-ngkCeMcmNgy21QZWvJA-1; Thu, 28 Apr 2022 01:55:18 -0400
X-MC-Unique: dR-ngkCeMcmNgy21QZWvJA-1
Received: by mail-wm1-f70.google.com with SMTP id
 d13-20020a05600c3acd00b0038ff865c043so3887847wms.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 22:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zgRDxje8lznBc9+MD1tXV7m51++4qJtjj5+PFYkzgUw=;
 b=dmTd45BAKJvGx2QNdkWyTFq1oplDR8aOmOzlnv/L6JbJ4KMTWqoNN32E06qJn8+z0v
 3YRAp3VMM/wekVQ2c0ObOePt/zrzD8X081BO7EhX6Kt3S9yKL4Otz/+C7P6zn2rbooSV
 OwaHXnflGcs4i+v0gIwGXAKcFT71TzuV/HAU2F2BDGLQUmGSYX4kxpexbX3fVTiTBZaz
 Ib2xE+CCeIVXe+mhpnj0S5aycpOlZ4gyftTB40PqlfjE6+gvTdRXMpa6qWDi5MwU9XNr
 kRVMICV8ewcuH03hntpCQj2sdtGSUuQUP/VSjK6rwEsAZW+sMPVs0uEn2ALV3euLUkf3
 izAA==
X-Gm-Message-State: AOAM530MNFSCwoddBbid6cMsswhzqyY1L6IXsFvICAlx8YNl2vw3J5cN
 4mJtyT4gt9catkT2j51u0qsUvi4RCRDMrcUhe2jJcs4tzUp1awI4zC7vLzB83615m1q0UXE8ms8
 +VExTYKRGPSMH1yNCKle5EuG24BoiY+JosC0Gvp5QUQ==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id
 n16-20020a7bc5d0000000b00389fe853d79mr38726724wmk.77.1651125317366; 
 Wed, 27 Apr 2022 22:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQWgQ7NzqEU9cQw2Mx4ZanfKZ/GYh96JpvrJZ3jPrVl9wOjeb9azjXMZoITgzaDPdWoxaVSA==
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id
 n16-20020a7bc5d0000000b00389fe853d79mr38726696wmk.77.1651125317023; 
 Wed, 27 Apr 2022 22:55:17 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 f1-20020a1c6a01000000b0038c9f6a3634sm2997790wmc.7.2022.04.27.22.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 22:55:16 -0700 (PDT)
Date: Thu, 28 Apr 2022 01:55:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220428015318-mutt-send-email-mst@kernel.org>
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com>
 <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
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

On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
> On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
> > > > But my guess is that rwlock + some testing for the legacy indicator case
> > > > just to double check if there is a heavy regression despite of our
> > > > expectations to see none should do the trick.
> > >
> > > I suggest this, rwlock (for not airq) seems better than spinlock, but
> > > at worst case it will cause cache line bouncing. But I wonder if it's
> > > noticeable (anyhow it has been used for airq).
> > >
> > > Thanks
> >
> > Which existing rwlock does airq use right now? Can we take it to sync?
> 
> It's the rwlock in airq_info, it has already been used in this patch.
> 
>                 write_lock(&info->lock);
>                 write_unlock(&info->lock);
> 
> But the problem is, it looks to me there could be a case that airq is
> not used, (virtio_ccw_int_hander()). That's why the patch use a
> spinlock, it could be optimized with using a rwlock as well.
> 
> Thanks

Ah, right. So let's take that on the legacy path too and Halil promises
to test to make sure performance isn't impacted too badly?

> >
> > --
> > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608DFE7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 20:46:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 082CD822FE;
	Thu, 21 Sep 2023 20:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 082CD822FE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d4HRj1be
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRkbnEcIKJlU; Thu, 21 Sep 2023 20:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 475B5822F5;
	Thu, 21 Sep 2023 20:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 475B5822F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E96C0071;
	Thu, 21 Sep 2023 20:45:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A581CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:45:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D24660AC9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:45:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D24660AC9
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d4HRj1be
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c3_XRDjxWqyC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:45:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 331D76070A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:45:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 331D76070A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695329154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HXeE4TG44R23JcxBjDhXWMi0+WtDdxhkEq9BQKJjIy0=;
 b=d4HRj1be9UJr4Si9k9wtk+lizXpaslQlr3W/ULYDfsBXQMJ9DOhzHan/tO85HY4kQYfuAe
 IcaXjI9TQlWgylZq/GEIDR+aVg3DetozR9wQ3oWOJG5M6UVtUx5pAasst5b7udrRQTYI0L
 WSM7sNye13N77amb6OviUyxftLDqrcY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-eOMQybMsPuymYLz_xg7Wvw-1; Thu, 21 Sep 2023 16:45:52 -0400
X-MC-Unique: eOMQybMsPuymYLz_xg7Wvw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c012f7ca56so19353681fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695329151; x=1695933951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXeE4TG44R23JcxBjDhXWMi0+WtDdxhkEq9BQKJjIy0=;
 b=r6N3946ciqD1LlaIAXVfvbN89gCAIznoHxzZCqVCDFiTwq06Ra23GKV+JtrXSyFQy8
 keVRKjefVilKQ7D/VSUV1iZjim+A7j4pgdBWTSeYSPGOd3v6FqNhIFuY7xhV4H3cX3k0
 o7I38xcR9zIVFr2RTULh4B8iSmhmlEY8+zImwX55U+5UKyJnznCT+cvFIH6CYEEbi5+S
 CKp7wys1MzwJxwr6o1RQb7n2kC/NlBKXadc/U6Fi4KeJzK3EfQN09t/IaaVw1M0Dck6U
 r+4+MDyk86ckxOXZ1z6J16pgPid4L7PwiSklm7Vb24gDGFJJYjvAhF0xnpo49rMX1Js/
 y+6g==
X-Gm-Message-State: AOJu0YyV5dPvNOma7cDpflRI9yTG9S2d6VdvR5p4z+jnJFxBQX3KzzBn
 O0DOMLtNl/UGlMLqE8X5L8IHxITT9yAv+lMlD9tsMsD55YT+XSBThEN6QOunm/vIcI4ye+PUgck
 DKCbU64oGDCySTwXo9pOCzYyzgnrOZVqCn/t2hZzhbQ==
X-Received: by 2002:a19:a410:0:b0:503:3890:ca3a with SMTP id
 q16-20020a19a410000000b005033890ca3amr5181234lfc.66.1695329150807; 
 Thu, 21 Sep 2023 13:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUVyMjlZeXfqdaSOLrm1jlrnnaNg6HRSFnF4mEMeS4M7zyGlAp1B55TKazyR2yo53Y4zjmqQ==
X-Received: by 2002:a19:a410:0:b0:503:3890:ca3a with SMTP id
 q16-20020a19a410000000b005033890ca3amr5181222lfc.66.1695329150452; 
 Thu, 21 Sep 2023 13:45:50 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 ba26-20020a0564021ada00b005333c729654sm1304241edb.24.2023.09.21.13.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 13:45:49 -0700 (PDT)
Date: Thu, 21 Sep 2023 16:45:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921163421-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921194946.GX13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 04:49:46PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 03:13:10PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 03:39:26PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 21, 2023 at 12:53:04PM -0400, Michael S. Tsirkin wrote:
> > > > > vdpa is not vfio, I don't know how you can suggest vdpa is a
> > > > > replacement for a vfio driver. They are completely different
> > > > > things.
> > > > > Each side has its own strengths, and vfio especially is accelerating
> > > > > in its capability in way that vpda is not. eg if an iommufd conversion
> > > > > had been done by now for vdpa I might be more sympathetic.
> > > > 
> > > > Yea, I agree iommufd is a big problem with vdpa right now. Cindy was
> > > > sick and I didn't know and kept assuming she's working on this. I don't
> > > > think it's a huge amount of work though.  I'll take a look.
> > > > Is there anything else though? Do tell.
> > > 
> > > Confidential compute will never work with VDPA's approach.
> > 
> > I don't see how what this patchset is doing is different
> > wrt to Confidential compute - you trap IO accesses and emulate.
> > Care to elaborate?
> 
> This patch series isn't about confidential compute, you asked about
> the future. VFIO will support confidential compute in the future, VDPA
> will not.

Nonsense it already works.

But I did not ask about the future since I do not believe it
can be confidently predicted. I asked what is missing in VDPA
now for you to add this feature there and not in VFIO.


> > > > There are a bunch of things that I think are important for virtio
> > > > that are completely out of scope for vfio, such as migrating
> > > > cross-vendor. 
> > > 
> > > VFIO supports migration, if you want to have cross-vendor migration
> > > then make a standard that describes the VFIO migration data format for
> > > virtio devices.
> > 
> > This has nothing to do with data formats - you need two devices to
> > behave identically. Which is what VDPA is about really.
> 
> We've been looking at VFIO live migration extensively. Device
> mediation, like VDPA does, is one legitimate approach for live
> migration. It suites a certain type of heterogeneous environment well.
> 
> But, it is equally legitimate to make the devices behave the same and
> have them process a common migration data.
> 
> This can happen in public with standards, or it can happen in private
> within a cloud operator's "private-standard" environment.
> 
> To date, in most of my discussions, I have not seen a strong appetite
> for such public standards. In part due to the complexity.
> 
> Regardles, it is not the kernel communities job to insist on one
> approach or the other.
>
> > > You are asking us to invest in the complexity of VDPA through out
> > > (keep it working, keep it secure, invest time in deploying and
> > > debugging in the field)
> > > 
> > > When it doesn't provide *ANY* value to the solution.
> > 
> > There's no "the solution"
> 
> Nonsense.

what there's only one solution that you use the definite article?

> > this sounds like a vendor only caring about solutions that involve
> > that vendor's hardware exclusively, a little.
> 
> Not really.
> 
> Understand the DPU provider is not the vendor here. The DPU provider
> gives a cloud operator a SDK to build these things. The operator is
> the vendor from your perspective.
> 
> In many cases live migration never leaves the operator's confines in
> the first place.
> 
> Even when it does, there is no real use case to live migrate a
> virtio-net function from, say, AWS to GCP.
> 
> You are pushing for a lot of complexity and software that solves a
> problem people in this space don't actually have.
> 
> As I said, VDPA is fine for the scenarios it addresses. It is an
> alternative, not a replacement, for VFIO.
> 
> Jason

yea, VDPA does trap and emulate for config accesses.  which is exactly
what this patch does?  so why does it belong in vfio muddying up its
passthrough model is beyond me, except that apparently there's some
specific deployment that happens to use vfio so now whatever
that deployment needs has to go into vfio whether it belongs there or not.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

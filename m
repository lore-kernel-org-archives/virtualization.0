Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9A5CD54BE
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AD8861301;
	Mon, 25 Sep 2023 19:52:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AD8861301
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxXxQOaU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t9o4LU9Xd11J; Mon, 25 Sep 2023 19:52:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 325D2612FD;
	Mon, 25 Sep 2023 19:52:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 325D2612FD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07574C0039;
	Mon, 25 Sep 2023 19:52:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1B63C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9F2A41B77
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:52:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9F2A41B77
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QxXxQOaU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzYQXuYIIYdD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:52:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B518541511
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B518541511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695671535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vij2tAFDCy7t+kNBMMGWQ+6bzq78Otf5CwiIdMQN6h4=;
 b=QxXxQOaUUgrxXfFPSuzMTWiieLBMsyMEPOJqiGaidNnU1w5WNKSmInOKdksTVk+rv92YNb
 FEqC7Cr78Zl4ckSGnUGix6Bb5fXOXFyoLoPJ1oMOlldFTwC311kSrz66hgDDs4Bc8jw6Hl
 C/731xGOEoVw9yMB9AgHqpLH/dyDgKA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-cZhHkOHANnWmy2bZFq4RSA-1; Mon, 25 Sep 2023 15:52:14 -0400
X-MC-Unique: cZhHkOHANnWmy2bZFq4RSA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b23c40cefso1855656d6.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 12:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695671533; x=1696276333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vij2tAFDCy7t+kNBMMGWQ+6bzq78Otf5CwiIdMQN6h4=;
 b=u/8It9yWqQIauyuy9zOt8AgF2wfM1vS7HEzzI8m33uWMjlrPFPpIMJTYQcHrb6Zguo
 Tuja9HohHFUvr3ORReqsuWU0o5sakGFy06XSyqElZ31Gxgn4jC1CW7l259fbEr8Tig46
 nEW0ihht6Uhfe4zOYEgkJVg1AbwZIXCvYqjn9X2Uu+7M3gEnWHNGITQsnJvKC167JR5Y
 DOmXnLuYOHzkKTYmIZpHhmcy6ikUIqHXsGL2buR9eS12ly61dv7AL6yme9pBzgaARu5N
 HsBRzGqWae8VwY90MvGu7MF9mBDF/ApvQJbd8j9S+mqOiHFn4ZGZ9vVJcWRNNDbddfRz
 VFOA==
X-Gm-Message-State: AOJu0YyrkkefrTBmYr+h9tKiw1UceLHj+kC/n+JLpHZj1zT+PRm4vuXq
 TJt44m7TJRV4HFXhQ6sbilwSkqrs/NS/FvksIPqlxJw6kaNufc1zlhNXr9dlhb5vHxxNkCMPN33
 ARrzWFmfdRIWYOtPyhm5Mx4uHauLzoP4sNgSwwS2FCA==
X-Received: by 2002:a0c:f105:0:b0:658:41ee:faf2 with SMTP id
 i5-20020a0cf105000000b0065841eefaf2mr6908706qvl.23.1695671533513; 
 Mon, 25 Sep 2023 12:52:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv618qn7iMismssguJZY82mZhr3Q9ZZZ2hUqLv0J/ZFLY+49u4eqAMtzhN4277ayVB0TfUtw==
X-Received: by 2002:a0c:f105:0:b0:658:41ee:faf2 with SMTP id
 i5-20020a0cf105000000b0065841eefaf2mr6908694qvl.23.1695671533177; 
 Mon, 25 Sep 2023 12:52:13 -0700 (PDT)
Received: from redhat.com ([185.184.228.174]) by smtp.gmail.com with ESMTPSA id
 a13-20020a05620a16cd00b0076cbcf8ad3bsm1976635qkn.55.2023.09.25.12.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 12:52:12 -0700 (PDT)
Date: Mon, 25 Sep 2023 15:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230925154622-mutt-send-email-mst@kernel.org>
References: <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <CACGkMEt=dxhJP4mUUWh+x-TSxA5JQcvmhJbkLJMWdN8oXV6ojg@mail.gmail.com>
 <20230922122501.GP13733@nvidia.com>
 <20230922111342-mutt-send-email-mst@kernel.org>
 <20230922161928.GS13733@nvidia.com>
 <20230925133637-mutt-send-email-mst@kernel.org>
 <20230925185318.GK13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230925185318.GK13733@nvidia.com>
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

On Mon, Sep 25, 2023 at 03:53:18PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 02:16:30PM -0400, Michael S. Tsirkin wrote:
> 
> > I do want to understand if there's a use-case that vdpa does not address
> > simply because it might be worth while to extend it to do so, and a
> > bunch of people working on it are at Red Hat and I might have some input
> > into how that labor is allocated. But if the use-case is simply "has to
> > be vfio and not vdpa" then I guess not.
> 
> If you strip away all the philisophical arguing VDPA has no way to
> isolate the control and data virtqs to different IOMMU configurations
> with this single PCI function.

Aha, so address space/PASID support then?

> The existing HW VDPA drivers provided device specific ways to handle
> this.
> 
> Without DMA isolation you can't assign the high speed data virtq's to
> the VM without mediating them as well.
> 
> > It could be that we are using mediation differently - in my world it's
> > when there's some host software on the path between guest and hardware,
> > and this qualifies.  
> 
> That is pretty general. As I said to Jason, if you want to use it that
> way then you need to make up a new word to describe what VDPA does as
> there is a clear difference in scope between this VFIO patch (relay IO
> commands to the device) and VDPA (intercept all the control plane,
> control virtq and bring it to a RedHat/qemu standard common behavior)

IIUC VDPA itself does not really bring it to either RedHat or qemu
standard, it just allows userspace to control behaviour - if userspace
is qemu then it's qemu deciding how it behaves. Which I guess this
doesn't. Right?  RedHat's not in the picture at all I think.

> > There is also a question of capability. Specifically iommufd support
> > is lacking in vdpa (though there are finally some RFC patches to
> > address that). All this is fine, could be enough to motivate
> > a work like this one.
> 
> I've answered many times, you just don't semm to like the answers or
> dismiss them as not relevant to you.
> 
> Jason


Not really I think I lack some of the picture so I don't fully
understand. Or maybe I missed something else.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

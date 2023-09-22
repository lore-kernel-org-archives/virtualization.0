Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2389FCD4F44
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 09:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F9AA60B1D;
	Fri, 22 Sep 2023 09:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F9AA60B1D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JVODK6Qf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ZftVgN5p00D; Fri, 22 Sep 2023 09:47:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F30960ACA;
	Fri, 22 Sep 2023 09:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F30960ACA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61F7BC0071;
	Fri, 22 Sep 2023 09:47:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9624FC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D5BD40461
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D5BD40461
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JVODK6Qf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p71QjhmgPWBn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:47:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7775540414
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 09:47:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7775540414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695376051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6954+txMBpmYo04CypSUuQ2OMC1OEIajLVIpD63o/u0=;
 b=JVODK6Qfo8vRRtpri0NiDFVN9IXM3E/Nd4DxIP4WuWhAfhcn7dPCQnO0ITj/yow15KjjLJ
 GzxQxOG/OfpGxfrN+fXIeM/jNV9n5nwWwMMwq3HrE9DEnHpDbLcxdKqVY3k6Bi8f+T0gs3
 H4PsC6rgEAVP0AIuGmBE78V61igvO0Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-RAc2zYbBN7qrFo7z1nzbwQ-1; Fri, 22 Sep 2023 05:47:29 -0400
X-MC-Unique: RAc2zYbBN7qrFo7z1nzbwQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-532e56aa8f1so1360594a12.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 02:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695376048; x=1695980848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6954+txMBpmYo04CypSUuQ2OMC1OEIajLVIpD63o/u0=;
 b=VtrCbWT4kVGhTKK2oAi/ysKtFqjHXYS2YGowKRq/kR6SGXoFWpAqmHevgMJ949bLqs
 G/3bWM8lc6L8mrZ6kwHkBDoODTRr77IVcOag/LjVf7W9CC0uZ5GbCZcERebLjI9nAKnZ
 qdIDN2y26WNOSVfEhg3jEi2GWOWbCdQ8H7dchYeN94F6UDunPCfbZz+bqbv876CZZBDO
 dsslG/cGlkjrpHSnz1VORrMIyC7BaL5s/0sIvkHOtDjguoA2XlJXWowCGCTe4ylYIwvl
 SUlkM6e6A0cgha3jgXoAW76jPkjDi9dplXgqs6qoYhc+pgXUrw+nbfTHJ0IUS5a1PybU
 yGtw==
X-Gm-Message-State: AOJu0Yw40C0xmJK3A3oBmrjAmLpI7R67Yu/tMFPS3byFH+GD/FQlFjil
 8osD3gfusi/oU1YBdxVlxXQpqRznrxWGSLxdubdBbfmsle+ixG14wFouzBfduZlSHEehuN9cLbZ
 SWt0ts1C44YIh4f85cs/cISI1zdzl+Kt6e2+SXIY7/A==
X-Received: by 2002:a05:6402:114f:b0:522:2782:537 with SMTP id
 g15-20020a056402114f00b0052227820537mr6944667edw.15.1695376048474; 
 Fri, 22 Sep 2023 02:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETZwiYeXyPDle3xoL9UArqKdbiEUti5oIzUYd4pU34ry486/q6oDn1zR3wW3ZaN159Z0kJKQ==
X-Received: by 2002:a05:6402:114f:b0:522:2782:537 with SMTP id
 g15-20020a056402114f00b0052227820537mr6944656edw.15.1695376048077; 
 Fri, 22 Sep 2023 02:47:28 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 y6-20020aa7d506000000b0052a1a623267sm2029423edq.62.2023.09.22.02.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:47:27 -0700 (PDT)
Date: Fri, 22 Sep 2023 05:47:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230922011918-mutt-send-email-mst@kernel.org>
References: <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <20230921224836.GD13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921224836.GD13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 07:48:36PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 04:16:25PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 04:53:45PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 21, 2023 at 03:34:03PM -0400, Michael S. Tsirkin wrote:
> > > 
> > > > that's easy/practical.  If instead VDPA gives the same speed with just
> > > > shadow vq then keeping this hack in vfio seems like less of a problem.
> > > > Finally if VDPA is faster then maybe you will reconsider using it ;)
> > > 
> > > It is not all about the speed.
> > > 
> > > VDPA presents another large and complex software stack in the
> > > hypervisor that can be eliminated by simply using VFIO.
> > 
> > If all you want is passing through your card to guest
> > then yes this can be addressed "by simply using VFIO".
> 
> That is pretty much the goal, yes.
> 
> > And let me give you a simple example just from this patchset:
> > it assumes guest uses MSIX and just breaks if it doesn't.
> 
> It does? Really? Where did you see that?

This thing apparently:

+               opcode = (pos < VIRTIO_PCI_CONFIG_OFF(true)) ?
+                       VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ :
+                       VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ;

That "true" is supposed to be whether guest enabled MSI or not.


> > > VFIO is
> > > already required for other scenarios.
> > 
> > Required ... by some people? Most VMs I run don't use anything
> > outside of virtio.
> 
> Yes, some people. The sorts of people who run large data centers.
>
> > It seems to deal with emulating virtio which seems more like a vdpa
> > thing.
> 
> Alex described it right, it creates an SW trapped IO bar that relays
> the doorbell to an admin queue command.
> 
> > If you start adding virtio emulation to vfio then won't
> > you just end up with another vdpa? And if no why not?
> > And I don't buy the "we already invested in this vfio based solution",
> > sorry - that's not a reason upstream has to maintain it.
> 
> I think you would be well justified to object to actual mediation,
> like processing queues in VFIO or otherwise complex things.

This mediation is kind of smallish, I agree. Not completely devoid of
logic though.

> Fortunately there is no need to do that with DPU HW. The legacy IO BAR
> is a weird quirk that just cannot be done without a software trap, and
> the OASIS standardization effort was for exactly this kind of
> simplistic transformation.
> 
> I also don't buy the "upstream has to maintain it" line. The team that
> submitted it will maintain it just fine, thank you.

it will require maintainance effort when virtio changes are made.  For
example it pokes at the device state - I don't see specific races right
now but in the past we did e.g. reset the device to recover from errors
and we might start doing it again.

If more of the logic is under virtio directory where we'll remember
to keep it in loop, and will be able to reuse it from vdpa
down the road, I would be more sympathetic.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

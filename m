Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1547CCD4F5B
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 11:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 909C241946;
	Fri, 22 Sep 2023 11:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 909C241946
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BlXAvOet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UV_3vDqhb0Qf; Fri, 22 Sep 2023 11:23:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DE03E400D1;
	Fri, 22 Sep 2023 11:23:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE03E400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF128C0071;
	Fri, 22 Sep 2023 11:23:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96557C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 11:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7047083CAD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 11:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7047083CAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BlXAvOet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ubjLgGiBej2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 11:23:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AB3C838B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 11:23:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AB3C838B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695381816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVAoseet3AOqAGeef+zNpGtmDE6kNFQXHwi00L96/hM=;
 b=BlXAvOet3SvC7ftnBHNI7wzoSLssyxdbShTqb+anN+Bu0pkRl5GJLgIy3xQ63iyma1UbRv
 UG/tx4pasEuDMGbHLIVUrgHhXwmJt1kLdpj/3leULsxpc2LGaq/OjT0fuUFQQmU/iXqzCM
 2NB+WAC8RqjwsSmJsv6kKhJ/Sp+EeFY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-2Mt5D7_dM46-qGE3eq1fDg-1; Fri, 22 Sep 2023 07:23:34 -0400
X-MC-Unique: 2Mt5D7_dM46-qGE3eq1fDg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so160672366b.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695381813; x=1695986613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVAoseet3AOqAGeef+zNpGtmDE6kNFQXHwi00L96/hM=;
 b=TA73spejIcouUTZazu+93diK5k6TZTkG+5nV9wFKAKXD0UTZwd3IL6dSxhYtCljZQd
 Bd41jjANxDvJBqXiEQsV20OJDIvWSK0Rr+qkImlWbTfr7Tko6C+UK/ua4VPuoOFEW/eT
 yBoZo0WOakOn/U/ytIiwuTfc9dR5r07A3rPz8/APuPDu+izKrbLpVp03HVPOBMY5J9cf
 AaSJh5aL2ZK1MQY+UMIiLayYgQbWMBW+xBCbd3ZOUO56zk6e7S+WlOBnZDX0oj+S7WPF
 4XEfZaFHDJGqHei3BAHMVKkbpI35XBJFZSs+aPptZikjCVOaBWo8jNCK/scSzvAkRbO+
 xTWQ==
X-Gm-Message-State: AOJu0YwgP/8OCKsvYGC4F6K6AArGAJbXfFQRE7nPxsfA5KHtiGJODIXM
 0oP9BMFf7rzK/Z/1ulLD8kVEgaJUg2Uat9dIqb26ltgJUFCzawZIBjPNXAmXDvO4TQMignRHycI
 F8U383z9lMKk+zOYh/mrA5ZECNZwg+jI/obWhVPDwIg==
X-Received: by 2002:a17:906:cc:b0:9ae:6ad0:f6cd with SMTP id
 12-20020a17090600cc00b009ae6ad0f6cdmr2803709eji.24.1695381813347; 
 Fri, 22 Sep 2023 04:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFnlzjtlZL5Pyn2UrVjxRnnxkpoy5t/qU9mxSKBZinwSUOqHTcJUWBux+71zBO1jVhNsfwIQ==
X-Received: by 2002:a17:906:cc:b0:9ae:6ad0:f6cd with SMTP id
 12-20020a17090600cc00b009ae6ad0f6cdmr2803687eji.24.1695381812983; 
 Fri, 22 Sep 2023 04:23:32 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 m5-20020a1709062b8500b009928b4e3b9fsm2544958ejg.114.2023.09.22.04.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 04:23:32 -0700 (PDT)
Date: Fri, 22 Sep 2023 07:23:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230922064957-mutt-send-email-mst@kernel.org>
References: <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <20230921163421-mutt-send-email-mst@kernel.org>
 <20230921225526.GE13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921225526.GE13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 07:55:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 04:45:45PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 21, 2023 at 04:49:46PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Sep 21, 2023 at 03:13:10PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 21, 2023 at 03:39:26PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Sep 21, 2023 at 12:53:04PM -0400, Michael S. Tsirkin wrote:
> > > > > > > vdpa is not vfio, I don't know how you can suggest vdpa is a
> > > > > > > replacement for a vfio driver. They are completely different
> > > > > > > things.
> > > > > > > Each side has its own strengths, and vfio especially is accelerating
> > > > > > > in its capability in way that vpda is not. eg if an iommufd conversion
> > > > > > > had been done by now for vdpa I might be more sympathetic.
> > > > > > 
> > > > > > Yea, I agree iommufd is a big problem with vdpa right now. Cindy was
> > > > > > sick and I didn't know and kept assuming she's working on this. I don't
> > > > > > think it's a huge amount of work though.  I'll take a look.
> > > > > > Is there anything else though? Do tell.
> > > > > 
> > > > > Confidential compute will never work with VDPA's approach.
> > > > 
> > > > I don't see how what this patchset is doing is different
> > > > wrt to Confidential compute - you trap IO accesses and emulate.
> > > > Care to elaborate?
> > > 
> > > This patch series isn't about confidential compute, you asked about
> > > the future. VFIO will support confidential compute in the future, VDPA
> > > will not.
> > 
> > Nonsense it already works.
> 
> That isn't what I'm talking about. With a real PCI function and TDISP
> we can actually DMA directly from the guest's memory without needing
> the ugly bounce buffer hack. Then you can get decent performance.

Aha, TDISP.  But that one clearly does not need and can not use
this kind of hack?

> > But I did not ask about the future since I do not believe it
> > can be confidently predicted. I asked what is missing in VDPA
> > now for you to add this feature there and not in VFIO.
> 
> I don't see that VDPA needs this, VDPA should process the IO BAR on
> its own with its own logic, just like everything else it does.

First there's some logic here such as translating legacy IO
offsets to modern ones that could be reused.

But also, this is not just IO BAR, that indeed can be easily done in
software.  When a device operates in legacy mode there are subtle
differences with modern mode such as a different header size for the net
device.

> This is specifically about avoiding mediation by relaying directly the
> IO BAR operations to the device itself.
> 
> That is the entire irony, this whole scheme was designed and
> standardized *specifically* to avoid complex mediation and here you
> are saying we should just use mediation.
> 
> Jason

Not exactly. What I had in mind is just having the logic in
the vdpa module so users don't need to know what does the device
support and what it doesn't. If we can we bypass mediation
(to simplify the software stack) if we can not we do not.

Looking at it from user's POV, it is just super confusing that
card ABC would need to be used with VDPA to drive legacy while
card DEF needs to be used with VFIO. And both VFIO and VDPA
will happily bind, too. Oh man ...


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77613E7D0A3
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 17:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4F704026A;
	Thu, 21 Sep 2023 17:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4F704026A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcSiS0jj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ROB8xAS5SAAr; Thu, 21 Sep 2023 17:55:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2AEC0400C5;
	Thu, 21 Sep 2023 17:55:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2AEC0400C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00D7CC0039;
	Thu, 21 Sep 2023 17:55:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B00F4C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89A9A41FE9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89A9A41FE9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AcSiS0jj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9RgvK5kFqHUR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:55:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8762A41FD7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 17:55:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8762A41FD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695318952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MyqhpxeqARsdhRIANht3YMfMPFXcwzP0mgld7CNMDxo=;
 b=AcSiS0jjxmm1/AUwyiL3daAF/fLusOonzgLJFFreWb3SLPISagP0iTnMWkCUK2dSRsmdKk
 RtVjPPqmgOzmMSB+SahDP+nB+1qrWRdO4DfKwINK5pek7CHAGguUA0NnpLusb50ypeY1D1
 bdmlpS4mZ6c7JW10mongPtNwz8r9bJc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-JVv2BkvSMyGt3h4FfziUmg-1; Thu, 21 Sep 2023 13:55:49 -0400
X-MC-Unique: JVv2BkvSMyGt3h4FfziUmg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-532ec54cab9so878853a12.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695318948; x=1695923748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyqhpxeqARsdhRIANht3YMfMPFXcwzP0mgld7CNMDxo=;
 b=Z7SNtC4QELx+qs6k14eztxACqWr5R7ENPs/SlAliFrQoX0vVjoret7DKIobPKusVnx
 0DInQ1mR8Y+PnmFrY5gRrpnaqnoVwNpC3QgJECBVjZie9bxx8YfbADs0r5ougfvMPgVF
 lKnQxL+NrgmTo86coaSZIDZJgw4RTbHXlduTLa4qJvGzTMdgZeADflUtEgYPaDnnmBKl
 txC+XyMerNHdZzzudi/piqpvr+YU7lGY7cAY5uWSGO85ab+7cmwejgVul7TtRWrrWIWq
 iYbBQVCBM9OIQONFVykbvA3CPDyzPuaRBufirgmlPRIp7tNBIlHAp52gx0TQ6+rwOkAl
 TiQQ==
X-Gm-Message-State: AOJu0YzaQ+JE3hmvCqwVTv0wEIvc003OZiXBky2kuLE8vOcGlUtaRXHc
 gVwhKBMtUJcayxbB5JN7MLntISBnWMih0HjIPHrQajnnJI55O5ha3CTlGvnJ4G1MG6437IHJsHE
 cssdXh3OGaMr72mB+u4a3iYii30MdplbC/FZiRm8Bdw==
X-Received: by 2002:aa7:ca46:0:b0:531:3e89:1bef with SMTP id
 j6-20020aa7ca46000000b005313e891befmr5135977edt.32.1695318948396; 
 Thu, 21 Sep 2023 10:55:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/o7VnKnRlPFEfg+S7+ZS1Dsa+PHHOMSB6nxkr8+EDv0DGoCJGxXPKJmVvaB3A+xIAnEQumw==
X-Received: by 2002:aa7:ca46:0:b0:531:3e89:1bef with SMTP id
 j6-20020aa7ca46000000b005313e891befmr5135959edt.32.1695318948058; 
 Thu, 21 Sep 2023 10:55:48 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 c21-20020aa7df15000000b00532c5e2d375sm1139679edy.1.2023.09.21.10.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:55:47 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:55:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921135426-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921174450.GT13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 02:44:50PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 01:21:26PM -0400, Michael S. Tsirkin wrote:
> > Yea it's very useful - it's also useful for vdpa whether this patchset
> > goes in or not.  At some level, if vdpa can't keep up then maybe going
> > the vfio route is justified. I'm not sure why didn't anyone fix iommufd
> > yet - looks like a small amount of work. I'll see if I can address it
> > quickly because we already have virtio accelerators under vdpa and it
> > seems confusing to people to use vdpa for some and vfio for others, with
> > overlapping but slightly incompatible functionality.  I'll get back next
> > week, in either case. I am however genuinely curious whether all the new
> > functionality is actually useful for these legacy guests.
> 
> It doesn't have much to do with the guests - this is new hypervisor
> functionality to make the hypervisor do more things. This stuff can
> still work with old VMs.
> 
> > > > Another question I'm interested in is whether there's actually a
> > > > performance benefit to using this as compared to just software
> > > > vhost. I note there's a VM exit on each IO access, so ... perhaps?
> > > > Would be nice to see some numbers.
> > > 
> > > At least a single trap compared with an entire per-packet SW flow
> > > undoubtably uses alot less CPU power in the hypervisor.
> >
> > Something like the shadow vq thing will be more or less equivalent
> > then?
> 
> Huh? It still has the entire netdev stack to go through on every
> packet before it reaches the real virtio device.

No - shadow vq just tweaks the descriptor and forwards it to
the modern vdpa hardware. No net stack involved.

> > That's upstream in qemu and needs no hardware support. Worth comparing
> > against.  Anyway, there's presumably actual hardware this was tested
> > with, so why guess? Just test and post numbers.
> 
> Our prior benchmarking put our VPDA/VFIO solutions at something like
> 2x-3x improvement over the qemu SW path it replaces.
> Parav said 10% is lost, so 10% of 3x is still 3x better :)
> 
> I thought we all agreed on this when vdpa was created in the first
> place, the all SW path was hopeless to get high performance out of?
> 
> Jason

That's not what I'm asking about though - not what shadow vq does,
shadow vq is a vdpa feature.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

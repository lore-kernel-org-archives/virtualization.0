Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB3CD8CA6
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 15:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BA0B613F7;
	Tue, 10 Oct 2023 15:58:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BA0B613F7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kl5y4w0x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5x4HXIdqqFh; Tue, 10 Oct 2023 15:58:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DDC3F613F4;
	Tue, 10 Oct 2023 15:58:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDC3F613F4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB98EC0071;
	Tue, 10 Oct 2023 15:58:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9021C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5594613F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5594613F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnQFZwKci0j7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74685613F4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 15:58:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74685613F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696953501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oudCQHyxcWdtlvLX8YwEj24sygXojgTSTrmilxTDJr4=;
 b=Kl5y4w0xVdGIVy18xeounmpC/r4duFX75FpURZkVR4H/ADefR1VO0pLThcXAwY61ppQ/Zi
 K3tgkvm/jjzibVXTIv01Fk9SmgiL3WVHsJh0LYrUxbs4zohxF2bWLcy/Q6/XsJnqZi2Imx
 2X/tDet3w1TfAf3GtNcf/96ItkR2E4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-X0ddDk9tNhaSn9LsBBVyoQ-1; Tue, 10 Oct 2023 11:58:20 -0400
X-MC-Unique: X0ddDk9tNhaSn9LsBBVyoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so38132685e9.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 08:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696953498; x=1697558298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oudCQHyxcWdtlvLX8YwEj24sygXojgTSTrmilxTDJr4=;
 b=FXVk3ZY5zq4DjgngPeWEjwczrxX9g/zv57Gr0v1EimJ6ttoOvdTfLlv772PMb5t4Ad
 xXdi53Lt6r/VHGOlmVqv4VDpobQ7CklRyK1ObSTfHZZ2RJcO1cDppCc8buw8Jlrir9HI
 jBzWOa7iO1JKwpg0X7P7E8jJaEp3TTpmPTWs/LO4owAXaMWpw4ANbS9ffuJHvdSUQbeb
 UF9K3ekLCcECjnyFLVn8G7q45kGuFb7gWkfRiO89sleTmijhPivzdP8Ht1eRHR6IttNY
 KP6PmcSEMUCdukoE4I75aD916AUbDVVpyP9IscsOdEvtv6Ydp7vNKivhYiGAqsFdwoNX
 ZlmQ==
X-Gm-Message-State: AOJu0YyIq6iUqQSNdmEie951F3lMmOfvl+1x5PFGW8l26SocDY66Bscu
 un2YMhtlnYdWGA3tDOdKfljFEGm3HeWjNbpw94QYEIfwFgPxWswgaoDpydsjF23EEGe3NtcOBOt
 VCpjj1tj0k/Tog0EGKLB9GB+NC3rOmB3gkApGVj6Xzg==
X-Received: by 2002:a7b:cb89:0:b0:401:b6f6:d8fd with SMTP id
 m9-20020a7bcb89000000b00401b6f6d8fdmr16185160wmi.6.1696953498719; 
 Tue, 10 Oct 2023 08:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG28WYkFmBDZib1M7Q1/8gOqudz57nP7zYs4YtXbOBDq/kTRAGT7TnBEIRoAQrgtiAun/WLYQ==
X-Received: by 2002:a7b:cb89:0:b0:401:b6f6:d8fd with SMTP id
 m9-20020a7bcb89000000b00401b6f6d8fdmr16185152wmi.6.1696953498343; 
 Tue, 10 Oct 2023 08:58:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b00406447b798bsm16815932wmj.37.2023.10.10.08.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 08:58:17 -0700 (PDT)
Date: Tue, 10 Oct 2023 11:58:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010115649-mutt-send-email-mst@kernel.org>
References: <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <8ea954ba-e966-0b87-b232-06ffd79db4e3@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 06:43:32PM +0300, Yishai Hadas wrote:
> On 10/10/2023 18:14, Michael S. Tsirkin wrote:
> > On Tue, Oct 10, 2023 at 06:09:44PM +0300, Yishai Hadas wrote:
> > > On 10/10/2023 17:54, Michael S. Tsirkin wrote:
> > > > On Tue, Oct 10, 2023 at 11:08:49AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, Oct 10, 2023 at 09:56:00AM -0400, Michael S. Tsirkin wrote:
> > > > > 
> > > > > > > However - the Intel GPU VFIO driver is such a bad experiance I don't
> > > > > > > want to encourage people to make VFIO drivers, or code that is only
> > > > > > > used by VFIO drivers, that are not under drivers/vfio review.
> > > > > > So if Alex feels it makes sense to add some virtio functionality
> > > > > > to vfio and is happy to maintain or let you maintain the UAPI
> > > > > > then why would I say no? But we never expected devices to have
> > > > > > two drivers like this does, so just exposing device pointer
> > > > > > and saying "use regular virtio APIs for the rest" does not
> > > > > > cut it, the new APIs have to make sense
> > > > > > so virtio drivers can develop normally without fear of stepping
> > > > > > on the toes of this admin driver.
> > > > > Please work with Yishai to get something that make sense to you. He
> > > > > can post a v2 with the accumulated comments addressed so far and then
> > > > > go over what the API between the drivers is.
> > > > > 
> > > > > Thanks,
> > > > > Jason
> > > > /me shrugs. I pretty much posted suggestions already. Should not be hard.
> > > > Anything unclear - post on list.
> > > > 
> > > Yes, this is the plan.
> > > 
> > > We are working to address the comments that we got so far in both VFIO &
> > > VIRTIO, retest and send the next version.
> > > 
> > > Re the API between the modules, It looks like we have the below
> > > alternatives.
> > > 
> > > 1) Proceed with current approach where we exposed a generic API to execute
> > > any admin command, however, make it much more solid inside VIRTIO.
> > > 2) Expose extra APIs from VIRTIO for commands that we can consider future
> > > client usage of them as of LIST_QUERY/LIST_USE, however still have the
> > > generic execute admin command for others.
> > > 3) Expose API per command from VIRTIO and fully drop the generic execute
> > > admin command.
> > > 
> > > Few notes:
> > > Option #1 looks the most generic one, it drops the need to expose multiple
> > > symbols / APIs per command and for now we have a single client for them
> > > (i.e. VFIO).
> > > Options #2 & #3, may still require to expose the virtio_pci_vf_get_pf_dev()
> > > API to let VFIO get the VIRTIO PF (struct virtio_device *) from its PCI
> > > device, each command will get it as its first argument.
> > > 
> > > Michael,
> > > What do you suggest here ?
> > > 
> > > Thanks,
> > > Yishai
> > I suggest 3 but call it on the VF. commands will switch to PF
> > internally as needed. For example, intel might be interested in exposing
> > admin commands through a memory BAR of VF itself.
> > 
> The driver who owns the VF is VFIO, it's not a VIRTIO one.
> 
> The ability to get the VIRTIO PF is from the PCI device (i.e. struct
> pci_dev).
> 
> In addition,
> virtio_pci_vf_get_pf_dev() was implemented for now in virtio-pci as it
> worked on pci_dev.

On pci_dev of vf, yes? So again just move this into each command,
that's all. I.e. pass pci_dev to each.

> Assuming that we'll put each command inside virtio as the generic layer, we
> won't be able to call/use this API internally to get the PF as of cyclic
> dependencies between the modules, link will fail.
> 
> So in option #3 we may still need to get outside into VFIO the VIRTIO PF and
> give it as pointer to VIRTIO upon each command.
> 
> Does it work for you ?
> 
> Yishai

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

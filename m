Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF00C25B67
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 17:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B9C541C5E;
	Thu, 26 Oct 2023 17:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B9C541C5E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5KKkhh8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTOOn8EjDkYQ; Thu, 26 Oct 2023 17:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 825C641B84;
	Thu, 26 Oct 2023 17:55:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 825C641B84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A09DC0071;
	Thu, 26 Oct 2023 17:55:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC259C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C81FA83E50
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:55:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C81FA83E50
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K5KKkhh8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVKWKrnogzrI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:55:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9D1183E30
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 17:55:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9D1183E30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698342944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZ6iVv8oE6cIOnSLClGga0Gh0D3fHj5Pk7B1lo93yNA=;
 b=K5KKkhh8ZUAVFwlzi08WKOFBk5yNzIbS6v44WKnVj958zZ/kK2GlIf/u1CvjQicDF4cNz5
 Ojv383YCGliQw7MIEfDjjx/s6gWNTMQd2vFfC7oVWFYx90HAgOTAEhUmYJhNutSEBqPpvy
 baemgyRFJbadUGw/48byQj4JHBmov0k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-CpRiJ7zfNYKgOpJyBbk9pw-1; Thu, 26 Oct 2023 13:55:43 -0400
X-MC-Unique: CpRiJ7zfNYKgOpJyBbk9pw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3af7219c67fso1738987b6e.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 10:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698342942; x=1698947742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZ6iVv8oE6cIOnSLClGga0Gh0D3fHj5Pk7B1lo93yNA=;
 b=lWZnh8QUUYbzbZ3Ks6Rt/xIf8q9JnrlaK+Ps3m7Y64eLtmnsm4uBS8UKcJfznllW3b
 sTASXESKeCJ1sCUXCzWU5a19WeGpegKmT90rxZsAgKtJ0mxUoeZJQzmAHqzEEIN1mXRj
 f2XOLQ5tm+8y/UXBJx88skKSacp9YfNgTNPItvZS12/i+kLm/UgzukcoGmXtDbYcvgeG
 vge1LWJuQQPUJxnYmwfEJtY9cWOOcumLQnyJVYbuoLAiybvdy2froI0wD3B+VTcntfRz
 kVOmRWUqtn2Lv1oCZeOma7gQNvJRVIpQzk9b1uroouqjezvH0dr5pWiW1sBDQILQOGSJ
 GGag==
X-Gm-Message-State: AOJu0YxaI7zzcKQeZRokbD/5uWM8sc6Fs5AfIFTfAfYJFUms7tWNYXfS
 SJw4vGD19I/fEqCiFyCWcgcvvPhaKdAQgDzTKFX5ls0EDOpNknJJVyRSMm88yIrv7TN421+FM25
 tFOtylLUkaT5So2uzc5HQarnw8KHBlO7xrZ6LgdLXmQ==
X-Received: by 2002:a05:6871:a40c:b0:1dd:7f3a:b703 with SMTP id
 vz12-20020a056871a40c00b001dd7f3ab703mr415389oab.0.1698342942564; 
 Thu, 26 Oct 2023 10:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg08tFB7c1YeA7yTIAQ6470xh94njF6ucMpjnRWWMJg718xKWDwz4Z93pBDCLt/eA2gSz+KA==
X-Received: by 2002:a05:6871:a40c:b0:1dd:7f3a:b703 with SMTP id
 vz12-20020a056871a40c00b001dd7f3ab703mr415360oab.0.1698342942178; 
 Thu, 26 Oct 2023 10:55:42 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 fh10-20020a056638628a00b00459c279647bsm685293jab.127.2023.10.26.10.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 10:55:41 -0700 (PDT)
Date: Thu, 26 Oct 2023 11:55:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231026115539.72c01af9.alex.williamson@redhat.com>
In-Reply-To: <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jgg@nvidia.com, jiri@nvidia.com,
 leonro@nvidia.com
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

On Thu, 26 Oct 2023 15:08:12 +0300
Yishai Hadas <yishaih@nvidia.com> wrote:

> On 25/10/2023 22:13, Alex Williamson wrote:
> > On Wed, 25 Oct 2023 17:35:51 +0300
> > Yishai Hadas <yishaih@nvidia.com> wrote:
> >  
> >> On 24/10/2023 22:57, Alex Williamson wrote:  
> >>> On Tue, 17 Oct 2023 16:42:17 +0300
> >>> Yishai Hadas <yishaih@nvidia.com> wrote:
   
> >>>> +		if (copy_to_user(buf + copy_offset, &val32, copy_count))
> >>>> +			return -EFAULT;
> >>>> +	}
> >>>> +
> >>>> +	if (range_intersect_range(pos, count, PCI_SUBSYSTEM_ID, sizeof(val16),
> >>>> +				  &copy_offset, &copy_count, NULL)) {
> >>>> +		/*
> >>>> +		 * Transitional devices use the PCI subsystem device id as
> >>>> +		 * virtio device id, same as legacy driver always did.  
> >>> Where did we require the subsystem vendor ID to be 0x1af4?  This
> >>> subsystem device ID really only makes since given that subsystem
> >>> vendor ID, right?  Otherwise I don't see that non-transitional devices,
> >>> such as the VF, have a hard requirement per the spec for the subsystem
> >>> vendor ID.
> >>>
> >>> Do we want to make this only probe the correct subsystem vendor ID or do
> >>> we want to emulate the subsystem vendor ID as well?  I don't see this is
> >>> correct without one of those options.  
> >> Looking in the 1.x spec we can see the below.
> >>
> >> Legacy Interfaces: A Note on PCI Device Discovery
> >>
> >> "Transitional devices MUST have the PCI Subsystem
> >> Device ID matching the Virtio Device ID, as indicated in section 5 ...
> >> This is to match legacy drivers."
> >>
> >> However, there is no need to enforce Subsystem Vendor ID.
> >>
> >> This is what we followed here.
> >>
> >> Makes sense ?  
> > So do I understand correctly that virtio dictates the subsystem device
> > ID for all subsystem vendor IDs that implement a legacy virtio
> > interface?  Ok, but this device didn't actually implement a legacy
> > virtio interface.  The device itself is not tranistional, we're imposing
> > an emulated transitional interface onto it.  So did the subsystem vendor
> > agree to have their subsystem device ID managed by the virtio committee
> > or might we create conflicts?  I imagine we know we don't have a
> > conflict if we also virtualize the subsystem vendor ID.
> >  
> The non transitional net device in the virtio spec defined as the below 
> tuple.
> T_A: VID=0x1AF4, DID=0x1040, Subsys_VID=FOO, Subsys_DID=0x40.
> 
> And transitional net device in the virtio spec for a vendor FOO is 
> defined as:
> T_B: VID=0x1AF4,DID=0x1000,Subsys_VID=FOO, subsys_DID=0x1
> 
> This driver is converting T_A to T_B, which both are defined by the 
> virtio spec.
> Hence, it does not conflict for the subsystem vendor, it is fine.

Surprising to me that the virtio spec dictates subsystem device ID in
all cases.  The further discussion in this thread seems to indicate we
need to virtualize subsystem vendor ID for broader driver compatibility
anyway.

> > BTW, it would be a lot easier for all of the config space emulation here
> > if we could make use of the existing field virtualization in
> > vfio-pci-core.  In fact you'll see in vfio_config_init() that
> > PCI_DEVICE_ID is already virtualized for VFs, so it would be enough to
> > simply do the following to report the desired device ID:
> >
> > 	*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(0x1000);  
> 
> I would prefer keeping things simple and have one place/flow that 
> handles all the fields as we have now as part of the driver.

That's the same argument I'd make for re-using the core code, we don't
need multiple implementations handling merging physical and virtual
bits within config space.

> In any case, I'll further look at that option for managing the DEVICE_ID 
> towards V2.
> 
> > It appears everything in this function could be handled similarly by
> > vfio-pci-core if the right fields in the perm_bits.virt and .write
> > bits could be manipulated and vconfig modified appropriately.  I'd look
> > for a way that a variant driver could provide an alternate set of
> > permissions structures for various capabilities.  Thanks,  
> 
> OK
> 
> However, let's not block V2 and the series acceptance as of that.
> 
> It can always be some future refactoring as part of other series that 
> will bring the infra-structure that is needed for that.

We're already on the verge of the v6.7 merge window, so this looks like
v6.8 material anyway.  We have time.  Thanks,

Alex

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

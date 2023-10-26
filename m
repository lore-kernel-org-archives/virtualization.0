Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2A7C25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 19:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2F0A42F63;
	Thu, 26 Oct 2023 19:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2F0A42F63
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=USC74CsV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eWKDG43_t__6; Thu, 26 Oct 2023 19:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1DCD2403C6;
	Thu, 26 Oct 2023 19:49:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DCD2403C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF149C0071;
	Thu, 26 Oct 2023 19:49:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E28FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 19:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDC05467FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 19:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDC05467FF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=USC74CsV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iBEFD5eMo5K3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 19:49:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D89B14506F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 19:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D89B14506F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698349761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Ge+RJ7YbGV1FiftUYJphvZYNXalHGufmR6iNwfI/PI=;
 b=USC74CsVUVphLpu9W/OUMAcHl/bQGngv5WqRzKO+EXKP0lARY2AJCsOvilwMlxBUY2WGo4
 ugBP4ULxBTZQs2kC8Bxuu6jF9qUR2mKWvQiHbOm9qbR/PMoyZomleIQwTbF/ep4i6hn/tL
 L7oioz5IKeXOXqW0qbeGbvLAnAEXO1s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-DHBSGEVHNGmW3B3rZkFgjQ-1; Thu, 26 Oct 2023 15:49:20 -0400
X-MC-Unique: DHBSGEVHNGmW3B3rZkFgjQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso84187766b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 12:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698349759; x=1698954559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Ge+RJ7YbGV1FiftUYJphvZYNXalHGufmR6iNwfI/PI=;
 b=nr6Hu1td/yJFyPmLFE80AjRBFbm0qS3ERRFnr40Ha4cg509ikUuXWWsI85MJat2QeS
 xstY+7/nXCBZuoVtUMjFkK0L/hmfvyJqT+XPph9FsJYCyvw0jOUTIvIKb2Qrh6nsqAZK
 OsFldfTYg4QhUvLATCBpuSS8Yd3Ee0wGNm4oeUZQuLcF33sY1dIx8KdbBOLiR8ZwZGC2
 xWaNcyCc9KZ3DqUYsH3257wO0EH6BTPyOTQNpsLup4UvvAR8f/0tn1vvsnWMZWEaCA8E
 SD7pOxa4Fbn9xaz8Bckg4+gOiGWhrJ9jPvqxwYNBbOlM8hEdnM/htzKTVHWyGJREK67n
 z9kA==
X-Gm-Message-State: AOJu0YwYI4qjuni6RAiRObZd6dui0KU7wqINX4gZcDRdkQNhRHNmT6O6
 2NL3h0x7DaqxnjlJIeZ9Qq7nAPzTENROkmFDwK3JuHDQLLUhmmMCnDcRBVkG5ZFFz9hQ2UCRsZH
 M371Qjjo0y6X730goP/wf5PlI3TNebz9TkZSZegFT8w==
X-Received: by 2002:a17:907:9620:b0:9ae:5370:81d5 with SMTP id
 gb32-20020a170907962000b009ae537081d5mr597031ejc.41.1698349759153; 
 Thu, 26 Oct 2023 12:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXOHkBYIfn+2pBCYONpHqii41GknD203DYooZrGXdYwVBkC1hVdFsqenoFskybh62G6EpgA==
X-Received: by 2002:a17:907:9620:b0:9ae:5370:81d5 with SMTP id
 gb32-20020a170907962000b009ae537081d5mr597017ejc.41.1698349758844; 
 Thu, 26 Oct 2023 12:49:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17b:37eb:8e1f:4b3b:22c7:7722])
 by smtp.gmail.com with ESMTPSA id
 r24-20020a1709067fd800b0099cd008c1a4sm75668ejs.136.2023.10.26.12.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 12:49:18 -0700 (PDT)
Date: Thu, 26 Oct 2023 15:49:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V1 vfio 9/9] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231026140839-mutt-send-email-mst@kernel.org>
References: <20231017134217.82497-1-yishaih@nvidia.com>
 <20231017134217.82497-10-yishaih@nvidia.com>
 <20231024135713.360c2980.alex.williamson@redhat.com>
 <d6c720a0-1575-45b7-b96d-03a916310699@nvidia.com>
 <20231025131328.407a60a3.alex.williamson@redhat.com>
 <a55540a1-b61c-417b-97a5-567cfc660ce6@nvidia.com>
 <20231026115539.72c01af9.alex.williamson@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20231026115539.72c01af9.alex.williamson@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
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

On Thu, Oct 26, 2023 at 11:55:39AM -0600, Alex Williamson wrote:
> On Thu, 26 Oct 2023 15:08:12 +0300
> Yishai Hadas <yishaih@nvidia.com> wrote:
> 
> > On 25/10/2023 22:13, Alex Williamson wrote:
> > > On Wed, 25 Oct 2023 17:35:51 +0300
> > > Yishai Hadas <yishaih@nvidia.com> wrote:
> > >  
> > >> On 24/10/2023 22:57, Alex Williamson wrote:  
> > >>> On Tue, 17 Oct 2023 16:42:17 +0300
> > >>> Yishai Hadas <yishaih@nvidia.com> wrote:
>    
> > >>>> +		if (copy_to_user(buf + copy_offset, &val32, copy_count))
> > >>>> +			return -EFAULT;
> > >>>> +	}
> > >>>> +
> > >>>> +	if (range_intersect_range(pos, count, PCI_SUBSYSTEM_ID, sizeof(val16),
> > >>>> +				  &copy_offset, &copy_count, NULL)) {
> > >>>> +		/*
> > >>>> +		 * Transitional devices use the PCI subsystem device id as
> > >>>> +		 * virtio device id, same as legacy driver always did.  
> > >>> Where did we require the subsystem vendor ID to be 0x1af4?  This
> > >>> subsystem device ID really only makes since given that subsystem
> > >>> vendor ID, right?  Otherwise I don't see that non-transitional devices,
> > >>> such as the VF, have a hard requirement per the spec for the subsystem
> > >>> vendor ID.
> > >>>
> > >>> Do we want to make this only probe the correct subsystem vendor ID or do
> > >>> we want to emulate the subsystem vendor ID as well?  I don't see this is
> > >>> correct without one of those options.  
> > >> Looking in the 1.x spec we can see the below.
> > >>
> > >> Legacy Interfaces: A Note on PCI Device Discovery
> > >>
> > >> "Transitional devices MUST have the PCI Subsystem
> > >> Device ID matching the Virtio Device ID, as indicated in section 5 ...
> > >> This is to match legacy drivers."
> > >>
> > >> However, there is no need to enforce Subsystem Vendor ID.
> > >>
> > >> This is what we followed here.
> > >>
> > >> Makes sense ?  
> > > So do I understand correctly that virtio dictates the subsystem device
> > > ID for all subsystem vendor IDs that implement a legacy virtio
> > > interface?  Ok, but this device didn't actually implement a legacy
> > > virtio interface.  The device itself is not tranistional, we're imposing
> > > an emulated transitional interface onto it.  So did the subsystem vendor
> > > agree to have their subsystem device ID managed by the virtio committee
> > > or might we create conflicts?  I imagine we know we don't have a
> > > conflict if we also virtualize the subsystem vendor ID.
> > >  
> > The non transitional net device in the virtio spec defined as the below 
> > tuple.
> > T_A: VID=0x1AF4, DID=0x1040, Subsys_VID=FOO, Subsys_DID=0x40.
> > 
> > And transitional net device in the virtio spec for a vendor FOO is 
> > defined as:
> > T_B: VID=0x1AF4,DID=0x1000,Subsys_VID=FOO, subsys_DID=0x1
> > 
> > This driver is converting T_A to T_B, which both are defined by the 
> > virtio spec.
> > Hence, it does not conflict for the subsystem vendor, it is fine.
> 
> Surprising to me that the virtio spec dictates subsystem device ID in
> all cases.

Modern virtio spec doesn't. Legacy spec did.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

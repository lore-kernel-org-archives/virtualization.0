Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64B5CDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 11:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 163C941D9A;
	Thu, 12 Oct 2023 11:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 163C941D9A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgeABtbZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odqcd0ef-2pK; Thu, 12 Oct 2023 11:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 326A04168F;
	Thu, 12 Oct 2023 11:30:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 326A04168F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05D80C0071;
	Thu, 12 Oct 2023 11:30:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 632E3C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D69581F10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:30:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D69581F10
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgeABtbZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orgxjpwEfTW9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:30:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA81081F0D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 11:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EA81081F0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697110230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dkpePPgIVWd5oaGtwlSyhYxM45IhaABBMmHMkqnTYdA=;
 b=WgeABtbZrI87aPIRgP4XvZ25UA4cSMW63ztdBkP9cAizOvx4+O9/Ke5idxZ9TywaWQquaM
 7uaLD2buZKs3Y+mB7zVBYrgNUEM2N0aPAPuN7KD/oTXoef4lER/0jAumXAlt1WJIw6op0d
 y8Hh6b8Zw2mNAnrEBV5dY9lkVkUZYwo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-IVt07yR4OB61gX-2MT04mA-1; Thu, 12 Oct 2023 07:30:25 -0400
X-MC-Unique: IVt07yR4OB61gX-2MT04mA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-503177646d2so835295e87.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 04:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697110224; x=1697715024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkpePPgIVWd5oaGtwlSyhYxM45IhaABBMmHMkqnTYdA=;
 b=V2uebST50yeJEnEB3fvTjq2DTlamlbDPsby6FL/6ribDTBURYknRN43GinTvm1pTMZ
 KXEDorx5M3H1fmPAXWLkpyvgDJohI2clTzW7Rc8MtFM39zpRbsQU2/zBayNnljaxFX/U
 Ss/dfkTtvpWSYoseDqbxrlpHgpcOEGG5fVxodVcRfjiQ92YAateKi2J3RdAjiZYmyBFp
 NDZ65OuV/PugYa6nXBUTUu+OFbL3cO27NfwMGYkRDRYJ7uOAh6GNRPFRa3arc2FsePva
 Lc47RDABC7Z9O8KQu5z4te4c3x5cRXsNn7lID2iUTFd7jH2AXY2lFepXs7lJ3CNtQiJI
 EtIw==
X-Gm-Message-State: AOJu0YyWxN4vCWNq+4yX3n3wFPoCAWnNjDDsx02WRrqh2ow+DKrl3nV1
 mWVJH9MUq34XgAbiGWUjnI49xy4eCdM9Z/IE0dc1UmARY70uzrvEYqp1ubKl+jQUVZpFwHf5jC9
 JAURCJ0rmHarVuAPc3Pc2nHClcm9Dt5ssqhA/3SB+gQ==
X-Received: by 2002:a19:5513:0:b0:507:9683:519f with SMTP id
 n19-20020a195513000000b005079683519fmr202412lfe.37.1697110224269; 
 Thu, 12 Oct 2023 04:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGor000SivxDPktQW5GKmppDqVpkcOdvz9WUJoX9tNMyxlcE/WUw3DQITOpI1BS+aIB9Co5pQ==
X-Received: by 2002:a19:5513:0:b0:507:9683:519f with SMTP id
 n19-20020a195513000000b005079683519fmr202391lfe.37.1697110223896; 
 Thu, 12 Oct 2023 04:30:23 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a1c7909000000b00401b242e2e6sm21574262wme.47.2023.10.12.04.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 04:30:23 -0700 (PDT)
Date: Thu, 12 Oct 2023 07:30:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20231012071804-mutt-send-email-mst@kernel.org>
References: <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230925141713-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AF4B2F61E96794D7ABC7DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20231012065008-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548135D0DF3C8B0CD5F73616DCD3A@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548135D0DF3C8B0CD5F73616DCD3A@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Thu, Oct 12, 2023 at 11:11:20AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, October 12, 2023 4:23 PM
> > 
> > On Tue, Sep 26, 2023 at 03:45:36AM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, September 26, 2023 12:06 AM
> > >
> > > > One can thinkably do that wait in hardware, though. Just defer
> > > > completion until read is done.
> > > >
> > > Once OASIS does such new interface and if some hw vendor _actually_ wants
> > to do such complex hw, may be vfio driver can adopt to it.
> > 
> > The reset behaviour I describe is already in the spec. What else do you want
> > OASIS to standardize? Virtio currently is just a register map it does not yet
> > include suggestions on how exactly do pci express transactions look. You feel we
> > should add that?
> 
> The reset behavior in the spec for modern as listed in [1] and [2] is just fine.
> 
> What I meant is in context of having MMIO based legacy registers to "defer completion until read is done".
> I think you meant, "Just differ read completion, until reset is done".

yes

> This means the hw needs to finish the device reset for thousands of devices within the read completion timeout of the pci.

no, each device does it's own reset.

> So when if OASIS does such standardization, someone can implement it.
> 
> What I recollect, is OASIS didn't not standardize such anti-scale approach and took the admin command approach which achieve better scale.
> Hope I clarified.

You are talking about the extension for trap and emulate.
I am instead talking about devices that work with
existing legacy linux drivers with no traps.

> I am not expecting OASIS to do anything extra for legacy registers.
> 
> [1] The device MUST reset when 0 is written to device_status, and present a 0 in device_status once that is done.
> [2] After writing 0 to device_status, the driver MUST wait for a read of device_status to return 0 before reinitializing
> the device.

We can add a note explaining that legacy drivers do not wait
after doing reset, that is not a problem.
If someone wants to make a device that works with existing
legacy linux drivers, they can do that.
Won't work with all drivers though, which is why oasis did not
want to standardize this.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

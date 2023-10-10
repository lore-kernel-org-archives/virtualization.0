Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D520CCD8CBE
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 20:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 591BE81268;
	Tue, 10 Oct 2023 20:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 591BE81268
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WEChAKM4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LK4CXlhgtkMp; Tue, 10 Oct 2023 20:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECD74812EE;
	Tue, 10 Oct 2023 20:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECD74812EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBAE8C0032;
	Tue, 10 Oct 2023 20:40:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A40A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E46D400BD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E46D400BD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WEChAKM4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oHp4zikN9Xbh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:39:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48BB14006E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 20:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48BB14006E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696970350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bu6+g3n9/dR1bkl/BLL4uvtKzuJH78kbq1CDUX/csIY=;
 b=WEChAKM4uO99hGiMYuV7O7U0svSxUzFF+Z7JAm/AyTnmviOZ1oWssvjmDXnNaORc2PMOm8
 HI4riZtXupSpFs7/JmyPmNVT93thIjqSwNOUNFTSN8D5JRHz64yG5nisaoR0BU+arKhx3/
 vxs8T+tGc4Enw/DdaL4+1NFOjwVpHxs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216--AoTJwUMMdW0qoYJD6rSXA-1; Tue, 10 Oct 2023 16:38:58 -0400
X-MC-Unique: -AoTJwUMMdW0qoYJD6rSXA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so4157204f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696970337; x=1697575137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bu6+g3n9/dR1bkl/BLL4uvtKzuJH78kbq1CDUX/csIY=;
 b=m38GdaSF+bWK4d6dmGoHjeSDcul5+9FcIDYmUirAHrqUtk4CIBo821guqk2PqeDhe1
 vBMOJM07v5TYN5DWqeDwCltBFxo1zGz8//S3W2VvSB85js4giOhJ/RNFOLVcrAXpNIPd
 PwoAjEVjV+VBssaax41aC5tA2ZH8d2hAPYBHpkqmMkJM31cjbIdczMdohhThpM14Zlrd
 +QTfa+3GaGZyIqD7QHDbunOnv1dYShj3OFnfSKYYyJTOeDw13z1RIyD+9FK1n9OjTbPB
 zpYdV8A3frTEKwXtaxDMBG/LNXaceFXKLk1oVAhgYknT69eJYlOpowY2IXJAu9UTVStX
 C48g==
X-Gm-Message-State: AOJu0YwvwAJ+7wxKrT210NPRNuecNMLx3FLVlD5dQGs8ZcqoarUU6L2V
 VGJfPe/T19U0b6+9IRML7tzFgJKidqxtMefBhfRVm5T4Ccij9HBS3Zfg5IpX0murztrdjIxMaRY
 mWfShbjWuGHMHCCzd+snN7+Pt/X3PV2Lh/n8rPbdHUA==
X-Received: by 2002:a5d:44c6:0:b0:321:6486:d008 with SMTP id
 z6-20020a5d44c6000000b003216486d008mr17597526wrr.25.1696970337179; 
 Tue, 10 Oct 2023 13:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6TNYTU5dVHOcXiM2qQJk/9jz9aLNe0cQkVtwbjtE9hTrDS36LUD9fwll79vvg+2CTf4B2Xg==
X-Received: by 2002:a5d:44c6:0:b0:321:6486:d008 with SMTP id
 z6-20020a5d44c6000000b003216486d008mr17597511wrr.25.1696970336822; 
 Tue, 10 Oct 2023 13:38:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b00405391f485fsm14946271wmj.41.2023.10.10.13.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 13:38:56 -0700 (PDT)
Date: Tue, 10 Oct 2023 16:38:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010163741-mutt-send-email-mst@kernel.org>
References: <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com>
 <20231010120158-mutt-send-email-mst@kernel.org>
 <20231010160712.GO3952@nvidia.com>
 <PH0PR12MB548172E68035F25C47918D92DCCDA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548172E68035F25C47918D92DCCDA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
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

On Tue, Oct 10, 2023 at 04:21:15PM +0000, Parav Pandit wrote:
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, October 10, 2023 9:37 PM
> > 
> > On Tue, Oct 10, 2023 at 12:03:29PM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Oct 10, 2023 at 12:59:37PM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Oct 10, 2023 at 11:14:56AM -0400, Michael S. Tsirkin wrote:
> > > >
> > > > > I suggest 3 but call it on the VF. commands will switch to PF
> > > > > internally as needed. For example, intel might be interested in
> > > > > exposing admin commands through a memory BAR of VF itself.
> 
> If in the future if one does admin command on the VF memory BAR, there is no need of cast either.
> vfio-virtio-pci driver can do on the pci vf device directly.

this is why I want the API to get the VF pci device as a parameter.
I don't get what is cyclic about it, yet.

> (though per VF memory registers would be anti-scale design for real hw; to discuss in other forum).

up to hardware vendor really.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

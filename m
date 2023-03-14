Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B870C74A44
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 03:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 962B941843;
	Tue, 14 Mar 2023 03:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 962B941843
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HERGR+te
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcY6I8tvHEA9; Tue, 14 Mar 2023 03:44:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05C3A41853;
	Tue, 14 Mar 2023 03:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05C3A41853
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A0AC0071;
	Tue, 14 Mar 2023 03:44:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30CA04184B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30CA04184B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hFyNfiwME0CL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:44:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4503341843
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4503341843
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678765445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKir2Jo/5jNjPDTygO0Omt0pgTsSTcHRX41c6+l9cFU=;
 b=HERGR+teH9NXu8ebPWyQlrxcgzYCzgimapZc3dAG7JJgsBSvv7SD0aKEFW7UB54Gs5lAKQ
 8PMRXnix0ENcQvVqA/M0Ar3d0OxZa5B1B6OFc8GEVRD7YRsJR4mCfMSIWB9KjqvG62PDl0
 TgpGW8l4oqWPZzpQ3UrWFYJTJCedQ3Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-lYWgaqK1PeGaTdrLpAUtbg-1; Mon, 13 Mar 2023 23:44:03 -0400
X-MC-Unique: lYWgaqK1PeGaTdrLpAUtbg-1
Received: by mail-wm1-f70.google.com with SMTP id
 l20-20020a05600c1d1400b003e10d3e1c23so8763141wms.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 20:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678765443;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKir2Jo/5jNjPDTygO0Omt0pgTsSTcHRX41c6+l9cFU=;
 b=iHT1B11/bHL8yV3DTQyYI1MEdIZbDM6lv8nJo7GkS6WKzRr7Mmaufz7whmIiWTrARK
 sYIa4hO1ff8LDC2JDNzYV9hWMH9MaAJNqWyI5hXbsBUnkEMVAvgX7Wtey8ri3mj7lSvW
 Z0FTCR7VCu7vEq5DdSqjwuBmVWSUs9T9CJe2kcRKTyisGAbnyQbt/avH2Vsmqna7fIQL
 Evh+e204uBg4vK3FWVmSu1vGDCPUatrSIqnlCrMVzpekoZh30vC21V6VrpodDwkNwZb9
 6TQv3KTNaYVdSD0DSchQjOKNiG3Zrfp2W17Onuiv2ZznJbrGwqCwGL2nR1Pkrz6Ww31r
 5Qgw==
X-Gm-Message-State: AO0yUKXSAC/jE4j48HVhJSnpuHhSgPsCV3R06mixjfXx+uVcoFHcPwHa
 I7akcxXqGID2czRgjhfrxH4YOrhCcKpkEu0sskuSFBYV07w9lFSLTGLDWKKbjodg3Vn6lhp1Uru
 UD0ADfmg3Vks4G8zPMSyLBEwkv77odjXNjSWWqOEjvA==
X-Received: by 2002:a05:600c:1d29:b0:3eb:6878:5523 with SMTP id
 l41-20020a05600c1d2900b003eb68785523mr13746133wms.12.1678765442899; 
 Mon, 13 Mar 2023 20:44:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set+THqlhQnRsJI3CP/L16zK9cta8PEwT6S8bsWpm+ddsW9pTX0WN2MHntOD0YqoPSL7aj0tjiQ==
X-Received: by 2002:a05:600c:1d29:b0:3eb:6878:5523 with SMTP id
 l41-20020a05600c1d2900b003eb68785523mr13746121wms.12.1678765442620; 
 Mon, 13 Mar 2023 20:44:02 -0700 (PDT)
Received: from redhat.com ([2.52.26.7]) by smtp.gmail.com with ESMTPSA id
 j8-20020a05600c1c0800b003ebf73acf9asm485908wms.3.2023.03.13.20.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Mar 2023 20:44:02 -0700 (PDT)
Date: Mon, 13 Mar 2023 23:43:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Make VIRTIO_NET_F_MRG_RXBUF off by default
Message-ID: <20230313233835-mutt-send-email-mst@kernel.org>
References: <20230312045717-mutt-send-email-mst@kernel.org>
 <f01c7204-5629-297e-47b6-06e58bd3f543@nvidia.com>
 <20230312054559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816C24BAA322567BED21A0DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230312122355-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548140734E1A0A8A2FD2CE30DCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313172309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481766116A2C074EDA7B3CCDCB99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230313174313-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FBB83AF401E598448736DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481FBB83AF401E598448736DCBE9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "perezma@redhat.com" <perezma@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Eugenio Perez Martin <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Tue, Mar 14, 2023 at 02:07:02AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, March 13, 2023 5:45 PM
> 
> > On Mon, Mar 13, 2023 at 09:34:50PM +0000, Parav Pandit wrote:
> > >
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, March 13, 2023 5:24 PM I mean if this is claiming to
> > > > fix a performance regression it should have a Fixes:
> > > > tag with the commit that introduced the regression.
> > >
> > > The fixes tag should be,
> > >
> > > Fixes: deeacf35c922d ("vdpa/mlx5: support device features
> > > provisioning")
> > >
> > > Eli,
> > > Please add.
> > 
> > Hmm okay so to make sure, before this commit device by default is created
> > without mrg buffers? With the commit it's created with and what the change
> > does it revert the default back to what it was?
> 
> Yes.

So IIUC currently default comes from device. Which makes sense at some
level, we can say device knows best maybe?
However in this case, we decided to override the default
because changing this improves some things and regresses others.
Which is ok at some level but then how does user know what
are the device defaults?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02B7E7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 19:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6969883CA6;
	Thu, 21 Sep 2023 19:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6969883CA6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d2SJLEqr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TkbRoM9oiBMb; Thu, 21 Sep 2023 19:13:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EE87883CA1;
	Thu, 21 Sep 2023 19:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE87883CA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFA57C0039;
	Thu, 21 Sep 2023 19:13:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BDEEC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12CC483CA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:13:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12CC483CA1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gzZDBYhHBj4O
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:13:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 423E783CA0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 19:13:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 423E783CA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695323599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIcDHKJ63k2LO686PIhEvmmbJ6INtxlihcpXu8qTVw0=;
 b=d2SJLEqrAZHGkB9YWoxLgKu0X3sHygQfBXV0w4K8gMYG7jvUJXoCyuMBs08ADobUGNer9F
 udbDADKpyhXUY3b/96nDuiRjYijdpq5Gu9FG1V8Fa/Y59K7ErfXUHja61h9sQZvnho0CWe
 VyWwHmRgM0EJufG/pQVHXuRD7dDHzRs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-azFknaW_NamClvaAXLFSAg-1; Thu, 21 Sep 2023 15:13:17 -0400
X-MC-Unique: azFknaW_NamClvaAXLFSAg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-504319087d9so1015754e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 12:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695323596; x=1695928396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uIcDHKJ63k2LO686PIhEvmmbJ6INtxlihcpXu8qTVw0=;
 b=w3p9DMFZViOQviPJd6cX+FXxZnxzJOX8IqyrLkc7DG88GitQNg+r+YlR3m4SpGt5/e
 AUv3508IdJKfRkEbKxEDpbmVXhyfuUIJFNTjac6CHGThtS0qst7MbarypT/fOBsU0QRz
 APts0+iwZKP76rwGaVs9hzyn/eQN1QpzSTthoexjziCx8hy7lDnYuKzK5IQgV9/ZUpxI
 SXIJO721u5fS+SWeCkADUfNWb2+kKngr6ypz1aGjrie86+8aMn/eIU9V0NxGhAd6sIEj
 2HNr0YqhWZi3AYsfTuGWwPNTAm3ZA6Y/+EGF1hotwwBJ/a7C1TtECGyNAhblZiL+QiRQ
 8H6A==
X-Gm-Message-State: AOJu0YxC1+ssNiSm4oXuTPQ5nKmntPZ88KlBQTOIYWwaFnhjW7Y+vpvG
 uiiA548dmA9Esyn22N45RTgYW1iU6lk4D6sSeAlj1TMEigFJ07kbHZwsfvDHg/f6/ns4T2atcao
 sVa5b9USD2XP0fFpIhvIBHvatA9YfQQpHRcBk1tdgxA==
X-Received: by 2002:ac2:5f73:0:b0:502:ff3b:7671 with SMTP id
 c19-20020ac25f73000000b00502ff3b7671mr5170699lfc.9.1695323596065; 
 Thu, 21 Sep 2023 12:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8/iz5H5CKhlLgySdYaNA9eyFIKxMAik+l7vKm9bRvB3Re/xSzoPc116NYeijxnqI3CO20Tw==
X-Received: by 2002:ac2:5f73:0:b0:502:ff3b:7671 with SMTP id
 c19-20020ac25f73000000b00502ff3b7671mr5170689lfc.9.1695323595666; 
 Thu, 21 Sep 2023 12:13:15 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 u11-20020a056402064b00b0053120f313cbsm1213956edx.39.2023.09.21.12.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 12:13:14 -0700 (PDT)
Date: Thu, 21 Sep 2023 15:13:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921150448-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-1-yishaih@nvidia.com>
 <20230921124040.145386-12-yishaih@nvidia.com>
 <20230921090844-mutt-send-email-mst@kernel.org>
 <20230921141125.GM13733@nvidia.com>
 <20230921101509-mutt-send-email-mst@kernel.org>
 <20230921164139.GP13733@nvidia.com>
 <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921183926.GV13733@nvidia.com>
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

On Thu, Sep 21, 2023 at 03:39:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:53:04PM -0400, Michael S. Tsirkin wrote:
> > > vdpa is not vfio, I don't know how you can suggest vdpa is a
> > > replacement for a vfio driver. They are completely different
> > > things.
> > > Each side has its own strengths, and vfio especially is accelerating
> > > in its capability in way that vpda is not. eg if an iommufd conversion
> > > had been done by now for vdpa I might be more sympathetic.
> > 
> > Yea, I agree iommufd is a big problem with vdpa right now. Cindy was
> > sick and I didn't know and kept assuming she's working on this. I don't
> > think it's a huge amount of work though.  I'll take a look.
> > Is there anything else though? Do tell.
> 
> Confidential compute will never work with VDPA's approach.

I don't see how what this patchset is doing is different
wrt to Confidential compute - you trap IO accesses and emulate.
Care to elaborate?


> > There are a bunch of things that I think are important for virtio
> > that are completely out of scope for vfio, such as migrating
> > cross-vendor. 
> 
> VFIO supports migration, if you want to have cross-vendor migration
> then make a standard that describes the VFIO migration data format for
> virtio devices.

This has nothing to do with data formats - you need two devices to
behave identically. Which is what VDPA is about really.

> > What is the huge amount of work am I asking to do?
> 
> You are asking us to invest in the complexity of VDPA through out
> (keep it working, keep it secure, invest time in deploying and
> debugging in the field)
> 
> When it doesn't provide *ANY* value to the solution.

There's no "the solution" - this sounds like a vendor only caring about
solutions that involve that vendor's hardware exclusively, a little.

> The starting point is a completely working vfio PCI function and the
> end goal is to put that function into a VM. That is VFIO, not VDPA.
> 
> VPDA is fine for what it does, but it is not a reasonable replacement
> for VFIO.
> 
> Jason

VDPA basically should be a kind of "VFIO for virtio".

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3240C19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 23:04:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3C2BF40A8E;
	Tue,  9 Aug 2022 23:04:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C2BF40A8E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFyBSn6w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EsnJYlnBwjTC; Tue,  9 Aug 2022 23:04:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8336F40A8C;
	Tue,  9 Aug 2022 23:04:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8336F40A8C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DFC7C0033;
	Tue,  9 Aug 2022 23:04:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B8B5C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 118CD60F48
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:04:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 118CD60F48
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFyBSn6w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qtXJo6GYa_h9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:04:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4396D60A9C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4396D60A9C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660086250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fwzmgj/PUi5/ZtiUawMCQWqVDZFxHFDul+fgkVCzaYw=;
 b=GFyBSn6wz6OUWjbMSFRAEXm+G7cKwiyuBrjW7yamAp4OReDUDaJy62ySxJpQKlLuKpCMQq
 mxcMfBDQl/ql8qpm4AZ9o1hhd/xa89P6xQuqH5mLehTW6A7djeH1RcbSAHlnw1o4nJqfQe
 8VuFEABoyqbOH2JXXdWcWi4aD4xTim0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-SfiuViuWO7WXy1eHrdsTNw-1; Tue, 09 Aug 2022 19:04:08 -0400
X-MC-Unique: SfiuViuWO7WXy1eHrdsTNw-1
Received: by mail-ed1-f69.google.com with SMTP id
 v19-20020a056402349300b0043d42b7ddefso8005925edc.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 16:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Fwzmgj/PUi5/ZtiUawMCQWqVDZFxHFDul+fgkVCzaYw=;
 b=HedR7coA9fHvhhA5OGt8H5Upk9apvESS/RMAwShG0jkwX/Mt92TdAnf64xmFC9EYnA
 p7U7CoVwStBQYNcC8RZEdF3byBaIQncpXKy/5joINbFWvLsRYMOLaBj6ZzCVfvVOCEv+
 V48Bp8zLaP0WZ5/rsAgN4nELhk4wW5hWSe23V6kxUNJRCoGaiq6bpu76z5KBDXeSqkt1
 wb3f8tOW7XxksQoN+p/fk4HbtDP9q0+Vbl6jtnqBXSKL3m6xf4DBE4K0ipozxb6v+ity
 4Gs3LSIaoxaALi6Y5AFzqv5h+pjnJxSvral+cGKUtiyPr9B+RRDoccCFC9IsHq4bATHx
 fg4g==
X-Gm-Message-State: ACgBeo1h1XouU0zSHjOGOfCxyyt7oYN+6d65t1OwNrn76gV2vgjBliVo
 yOednuJASOihWOxhskgrzMu7tYAKHI1SeWFJ2JCMaoNGEcm7cj2WD9qctJEYdiR2oVY11nUuWWb
 scBpi88sNB9RFj6z5qnafXW+qpGPLvTK65lefgYSlCA==
X-Received: by 2002:a17:906:dc8f:b0:72f:ff33:b2d4 with SMTP id
 cs15-20020a170906dc8f00b0072fff33b2d4mr18740462ejc.7.1660086247730; 
 Tue, 09 Aug 2022 16:04:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5Aboj8KdJhNTxCNd2ZIbLCqSp4ubS6yun55SuWfT/ipMnHL3xi/hsKb/cOYh3OzB/juEG+vw==
X-Received: by 2002:a17:906:dc8f:b0:72f:ff33:b2d4 with SMTP id
 cs15-20020a170906dc8f00b0072fff33b2d4mr18740446ejc.7.1660086247533; 
 Tue, 09 Aug 2022 16:04:07 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 c17-20020a17090618b100b0072fd1e3d2basm1605904ejf.201.2022.08.09.16.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 16:04:06 -0700 (PDT)
Date: Tue, 9 Aug 2022 19:04:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [virtio-dev] [PATCH] virtio-net: use mtu size as buffer length
 for big packets
Message-ID: <20220809190317-mutt-send-email-mst@kernel.org>
References: <465efc4c-f41f-494e-8f2d-a87deae90c5d@nvidia.com>
 <CACGkMEsVG_62yJ5nGmp5ufF_xiEJk2TezQz-QFftF8ezKYLB8A@mail.gmail.com>
 <06bf192a-d310-943e-bbe1-1c53108db892@oracle.com>
 <PH0PR12MB54819B1419EF8D7AF306EE2CDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3b87cc07-525a-6753-6224-37ebc2503e65@oracle.com>
 <PH0PR12MB54810721EF477C778FDE3B98DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809173542-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481101A8414FAAB5FCAC537DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220809182306-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816FFF167D3EA3EF5F075FDC629@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>,
 Virtio-Dev <virtio-dev@lists.oasis-open.org>,
 "kubakici@wp.pl" <kubakici@wp.pl>,
 "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
 "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
 Gavi Teitz <gavi@nvidia.com>,
 virtualization <virtualization@lists.linux-foundation.org>, "Hemminger,
 Stephen" <stephen@networkplumber.org>,
 "loseweigh@gmail.com" <loseweigh@gmail.com>, davem <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

On Tue, Aug 09, 2022 at 10:49:48PM +0000, Parav Pandit wrote:
> > > When user prefers to override the device RO field, device is in the dark and
> > things work on best effort basis.
> > 
> > Dropping packets is best effort. Getting stuck forever isn't, that's a quality of
> > implementation issue.
> >
> Not sure, why things get stuck for ever. Maybe you have example to explain.
> I am mostly missing something.

I'm no longer sure I'm right. Will recheck tomorrow, it's late here.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

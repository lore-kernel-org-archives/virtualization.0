Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931D1C74A44
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 19:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CCA160C2E;
	Sat, 11 Mar 2023 19:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CCA160C2E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wpy23Xyn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7Iv-GZPY7yR; Sat, 11 Mar 2023 19:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E90560E41;
	Sat, 11 Mar 2023 19:05:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E90560E41
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D49C0071;
	Sat, 11 Mar 2023 19:05:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49EADC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A556405B8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A556405B8
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wpy23Xyn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8sksYun4CRAY
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:05:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 35FB1404A8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 35FB1404A8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678561513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JmD/8uiXopnxocosmaCE2aQS+YjwKAepXERygA6yzzQ=;
 b=Wpy23Xyn/s4lQ/oqBZ3VheD7yu8eYXaciu24cubhqVE/uOMTebgEUzzroLcd7VDoQspBXF
 OVTj0S2Lf0IFebVB+pAuX62sdseaBcCmlRdYh2+8RQ1QhogonL78qB+ULEIR0e9KiTtC1T
 2TyG/8bDzP4lOsdv74xpxkNutXAuQqg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-nFU_CrMmNuup6b6sh_3r9w-1; Sat, 11 Mar 2023 14:05:12 -0500
X-MC-Unique: nFU_CrMmNuup6b6sh_3r9w-1
Received: by mail-wr1-f72.google.com with SMTP id
 bh3-20020a05600005c300b002c70d6e2014so1577768wrb.10
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 11:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678561511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmD/8uiXopnxocosmaCE2aQS+YjwKAepXERygA6yzzQ=;
 b=V+pH7Hdp2xARmwsqrqjr+xa78Y7d3QY0I104Nh93/viv0QCHqB9hcdqP0wldGhxYCj
 QvOaTFHymkOkDlKpaaSkkWVb7dmzCHBZCYGVnnotiTRha49+N5j6XcTUFCgZ/uKni2ma
 VT3t6wF+O0F/892A3W6zDKi9pow5nKPa6dL0yTGWVVX1FfrrlVolzFnLybC/yB0fK8H3
 hQ6UaedjkXL3Vdn9YaINYYKp7i2NzdhAy7p3fJgVpwAS4vYyfYc62RSy7Q7ZfUXireso
 UJ5FQROupKWfL4KAwd2ueB2+kcoj+nxyD6c+1yVg+jZzdZ6EmFAnJxoH0U+XvKXZ0JKB
 zCQg==
X-Gm-Message-State: AO0yUKU2HY9QpF/jHI1VSAjrMPjfI1kG7xtCULrYeYIEBCq/4t0zT0IG
 2AKvCqC3BDlkv2iPqX1zissT9hiw4Oz7RoyKgs/euPtv8OWH5/1Q58t0neAQx9igS7kkJPMWr+R
 UjL3AG1KvXwjKCDhMcgxssfOxyIjsNJpoZnIQ+Pko2A==
X-Received: by 2002:a05:600c:4746:b0:3dc:58a2:3900 with SMTP id
 w6-20020a05600c474600b003dc58a23900mr6141740wmo.29.1678561511184; 
 Sat, 11 Mar 2023 11:05:11 -0800 (PST)
X-Google-Smtp-Source: AK7set+26aD64UYH+0pyPO44bJdIwteXqxswZxvCOfoT2/9aej8Qzlr47L9RAwhqrSiqjfQ9CjRI6A==
X-Received: by 2002:a05:600c:4746:b0:3dc:58a2:3900 with SMTP id
 w6-20020a05600c474600b003dc58a23900mr6141728wmo.29.1678561510879; 
 Sat, 11 Mar 2023 11:05:10 -0800 (PST)
Received: from redhat.com ([2.52.29.35]) by smtp.gmail.com with ESMTPSA id
 o4-20020a05600c378400b003e215a796fasm3492968wmr.34.2023.03.11.11.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Mar 2023 11:05:09 -0800 (PST)
Date: Sat, 11 Mar 2023 14:05:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
Message-ID: <20230311140355-mutt-send-email-mst@kernel.org>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310053428.3376-2-feliu@nvidia.com>
 <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bd763bf7-0b8e-ba9e-cbd2-a0302e820cc6@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <bd763bf7-0b8e-ba9e-cbd2-a0302e820cc6@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

On Fri, Mar 10, 2023 at 10:23:16AM -0500, Feng Liu wrote:
> 
> 
> On 2023-03-10 a.m.8:36, Parav Pandit wrote:
> > 
> > 
> > > From: Feng Liu <feliu@nvidia.com>
> > > Sent: Friday, March 10, 2023 12:34 AM
> > 
> > > 
> > > -	if (!is_power_of_2(num)) {
> > > -		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u",
> > > num);
> > > -		return ERR_PTR(-EINVAL);
> > > -	}
> > > -
> > 
> > The check is still valid for split q.
> > Maybe the right place for such a check is not the pci transport driver.
> > But layer below where split vs packed q knowledge resides and hence, power of 2 check can be omitted for packed vq.
> 
> Hi, Parav
>     I think you are right, I checked the virtio spec, only packed virtqueue
> can use queue size which is not power_of_2; so, I think the check can be
> reserved only for split queue here, something like
> 
> struct virtio_device *vdev = &vp_dev->vdev;
> if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)
>  && !is_power_of_2(num)){
>     dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
>     return ERR_PTR(-EINVAL);
> }
> 
> I will fix it in next version
> 
> Hi, Michael and Jason
> Do you have any comments on this?
> 

Hmm good point. Which raises the question: so how did you test it then?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

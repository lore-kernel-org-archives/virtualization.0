Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0659CC6FA99
	for <virtualization@archiver.kernel.org>; Sun, 12 Mar 2023 06:46:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B17481378;
	Sun, 12 Mar 2023 06:46:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B17481378
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LNdDV1k/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B02q_EoevwRk; Sun, 12 Mar 2023 06:46:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 02FC38135E;
	Sun, 12 Mar 2023 06:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 02FC38135E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFE3FC0071;
	Sun, 12 Mar 2023 06:46:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2350FC0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D814C60F45
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:46:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D814C60F45
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LNdDV1k/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JKab6BODfVwO
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:46:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BC5CB60F41
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC5CB60F41
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Mar 2023 06:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678603599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ARRgAW1rdAOIpriCSP8Ui2IvwhTOUYp4LtJkYm3vtrY=;
 b=LNdDV1k/4v9ncIWzUL3ur1BmsT2AjNiSjUZqB/xKFQUq0hc7c10lOrMqVeelMefazXIAYm
 RtixZSrYfeVmgc36fXvXxO6fp1DakhhUuhetFE+LVHYj9BD0to8rMM4S71boGjPMF5fd6m
 dmHMfsQoJRtbv9dr8SFNFZ7+QAJNAoU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-bovL53VINei99niCLvZ8mA-1; Sun, 12 Mar 2023 01:46:37 -0500
X-MC-Unique: bovL53VINei99niCLvZ8mA-1
Received: by mail-wr1-f71.google.com with SMTP id
 m10-20020adfe94a000000b002cdc5eac0d0so1671813wrn.2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 22:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678603596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARRgAW1rdAOIpriCSP8Ui2IvwhTOUYp4LtJkYm3vtrY=;
 b=2EtCCdvryR4wAzVzzKrRGSmZhFjt+xJ6RrgFXkeMzhNQJokkW37mUqhFDaeFrZV9tu
 DAHBUSL+nf9Pm++robzFwV+Unio0PyhwKx+cUNMJXecnWSLXFvTkHgeXJBilFEEpNr3j
 gnd0T/2y+niJuJ75qME9nxx8gjNSrOMtXTiL/s683U7duxBp9n9VUO/hSkYYZpaWAs19
 qG6+b4QyJbux9uMzBzUdeUiIiz8rvNdHRFg3sIvEuKZ5E/1272a3H8n5MetC7GQOkyNZ
 PeIV6eSreb26+YC0v39rPsoSKhtt37wEHdDr5YvZBARuq4ivg2vX6hOYA86FZt3MmDYs
 J5AA==
X-Gm-Message-State: AO0yUKXx/rPexRC2uYMbZxPHrtJ97ynH3fgOLtKZKfDgYeaKLrk5AnQZ
 6PAqcxheSJhFVKjr06BxU6U08gsrpKdrkOvcLgO6umfmpXYZ5sUBstJesk0d2UleGk707S3g7w6
 2VheU9jK3/sxadqjWGEqm7KMAT23m0MQInEoC4Bzvgg==
X-Received: by 2002:a05:600c:4f08:b0:3ea:e554:7815 with SMTP id
 l8-20020a05600c4f0800b003eae5547815mr7563179wmq.9.1678603595959; 
 Sat, 11 Mar 2023 22:46:35 -0800 (PST)
X-Google-Smtp-Source: AK7set+80MjuHQn7U2MSHy4W2WqvQo+AGEJK89nVvK3A9XRJG5XIKjDze9gn/quBSvbzMhcotlJLaQ==
X-Received: by 2002:a05:600c:4f08:b0:3ea:e554:7815 with SMTP id
 l8-20020a05600c4f0800b003eae5547815mr7563172wmq.9.1678603595612; 
 Sat, 11 Mar 2023 22:46:35 -0800 (PST)
Received: from redhat.com ([2.52.29.35]) by smtp.gmail.com with ESMTPSA id
 z4-20020a056000110400b002c71a32394dsm4091672wrw.64.2023.03.11.22.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Mar 2023 22:46:35 -0800 (PST)
Date: Sun, 12 Mar 2023 01:46:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v2 1/3] virtio_pci_modern: Allow non power of 2 sizes for
 virtqueues
Message-ID: <20230312014544-mutt-send-email-mst@kernel.org>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310053428.3376-2-feliu@nvidia.com>
 <PH0PR12MB5481188C606714C32353ED88DCBA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <bd763bf7-0b8e-ba9e-cbd2-a0302e820cc6@nvidia.com>
 <20230311140355-mutt-send-email-mst@kernel.org>
 <1bdcad80-eca7-9a6b-1375-1ddab3e6bae8@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1bdcad80-eca7-9a6b-1375-1ddab3e6bae8@nvidia.com>
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

On Sat, Mar 11, 2023 at 05:25:04PM -0500, Feng Liu wrote:
> 
> 
> On 2023-03-11 p.m.2:05, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Mar 10, 2023 at 10:23:16AM -0500, Feng Liu wrote:
> > > 
> > > 
> > > On 2023-03-10 a.m.8:36, Parav Pandit wrote:
> > > > 
> > > > 
> > > > > From: Feng Liu <feliu@nvidia.com>
> > > > > Sent: Friday, March 10, 2023 12:34 AM
> > > > 
> > > > > 
> > > > > - if (!is_power_of_2(num)) {
> > > > > -         dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u",
> > > > > num);
> > > > > -         return ERR_PTR(-EINVAL);
> > > > > - }
> > > > > -
> > > > 
> > > > The check is still valid for split q.
> > > > Maybe the right place for such a check is not the pci transport driver.
> > > > But layer below where split vs packed q knowledge resides and hence, power of 2 check can be omitted for packed vq.
> > > 
> > > Hi, Parav
> > >      I think you are right, I checked the virtio spec, only packed virtqueue
> > > can use queue size which is not power_of_2; so, I think the check can be
> > > reserved only for split queue here, something like
> > > 
> > > struct virtio_device *vdev = &vp_dev->vdev;
> > > if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)
> > >   && !is_power_of_2(num)){
> > >      dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
> > >      return ERR_PTR(-EINVAL);
> > > }
> > > 
> > > I will fix it in next version
> > > 
> > > Hi, Michael and Jason
> > > Do you have any comments on this?
> > > 
> > 
> > Hmm good point. Which raises the question: so how did you test it then?
> > 
> Hi Michael
> 
> I will construct a non power of 2 size packed virtqueue device to test
> whether the driver is loaded successfully and whether the traffic is normal;
> at the same time, I will also construct a non power of 2 size split
> virtqueue device for testing to see if an warning is given and the driver is
> loaded fail
> 
> The method of constructing the device, such as the reply steps in the
> previous email

Okay but previously you said you tested ring sizes 100 and 200 with
iperf. How did you construct these?


> > 
> > --
> > MST
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

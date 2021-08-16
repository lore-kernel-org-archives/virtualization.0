Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF11CC4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 20:54:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD4460F36
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 20:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AD4460F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0ECD340360;
	Mon, 16 Aug 2021 20:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gz9fy8tm4Xr9; Mon, 16 Aug 2021 20:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8402B402F2;
	Mon, 16 Aug 2021 20:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 443ABC0010;
	Mon, 16 Aug 2021 20:54:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E32FCC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1CC8401FC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qnlRvM85tH2N
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:54:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDF9C401F8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629147269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mgnd656ubER6m5U6lwnHn022dCGrOqShw0lNJclqLes=;
 b=c2pfd7gHixL6FWLk+mR55iepFbcsbPB/OUQILRmuQiPQpGNajmclb0F7u5Goijl8GCWKkW
 JRPRlw4ghPP8dkakPO7nHou2QsrAQDJVfltml75UQ9E4kq/u3+0yu7sQFmdyeGmmzb8GTh
 6jepdZFNUOi11xOzO0R3MurSbEqO0HI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-d1TwMitTOEiwTUZR2Yyi1g-1; Mon, 16 Aug 2021 16:54:28 -0400
X-MC-Unique: d1TwMitTOEiwTUZR2Yyi1g-1
Received: by mail-ej1-f69.google.com with SMTP id
 k12-20020a170906680cb02905aeccdbd1efso5170354ejr.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 13:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mgnd656ubER6m5U6lwnHn022dCGrOqShw0lNJclqLes=;
 b=WqTQhkJ1HP3zP3nh8+uLEzM3hlDD1N5aP1IoJ+D+hkx3SOLqGf0b5/VQlOgnWELnWf
 Uyf00qGx2hdOuU3QIElsY3TapKvesGY+n9iPNu9JWqRKxZdKpLbuXDFGzfu9tOMKaY/z
 MqtD1MqUwByxDmpgTvOO34xAXn99UONsmrFumVNL6wfKJ6PGiTHfO0SKYg+TDCMf+KdW
 MhiuKHO6gjZgOF57OVO8cTYTQgdOvAB5tQecGCPsL3GdzQXWw2BFNvVKVh39XCFYiF03
 7MCRmdMJqJ3HGJdzxWeBe2zxzvVG5nUbYdLLY6vaeeCqWtLQVeDPhIKIpRX+sh1ulgQb
 i8ug==
X-Gm-Message-State: AOAM530uLvuXLm8uBBvfsDHEWj+p9t2ihPNHqL0zyjFY+rNXzIsd004+
 D96mNPsPqFbXahoJOpXrEykA3Rnywqq/00JnFjpKcE4ngsAV8106Nel5AI9UKQddqEb1F367Dom
 XMEl47nC1eSNDEHxW+vmvM02u4Tr8JNVtBEfhdTfuKQ==
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr38000eds.381.1629147267505;
 Mon, 16 Aug 2021 13:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1mcJKGuG+F8JNEKu5Q5gEnSm6OBT3z0GtsjDRnIC1UDlwaYncAxXdoSRDv75SBMEdCQprzQ==
X-Received: by 2002:aa7:c78e:: with SMTP id n14mr37991eds.381.1629147267392;
 Mon, 16 Aug 2021 13:54:27 -0700 (PDT)
Received: from redhat.com ([2.55.150.133])
 by smtp.gmail.com with ESMTPSA id q30sm34982edi.84.2021.08.16.13.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 13:54:26 -0700 (PDT)
Date: Mon, 16 Aug 2021 16:54:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210816165217-mutt-send-email-mst@kernel.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Aug 09, 2021 at 09:51:49AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, August 9, 2021 3:10 PM
> > 
> > On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> > >
> > >
> > > >
> > > > The point is to try and not reinvent a dedicated vpda interface
> > > > where a generic one exits.
> > > > E.g. for phy things such as mac speed etc, I think most people are
> > > > using ethtool things right?
> > >
> > > As you know vdpa is the backend device for the front-end netdevice
> > accessed by the ethtool.
> > > vdpa management tool here is composing the vdpa device.
> > >
> > > For example creator (hypervisor) of the vdpa devices knows that a
> > > guest VM is given 4 vcpus, So hypervisor creates a vdpa devices with
> > > config space layout as, max_virtqueue_pairs = 4.
> > > And the MAC address chosen by hypervisor in mac[6].
> > >
> > > Guest VM ethtool can still chose to use less number of channels.
> > >
> > > Typically,
> > > ethtool is for guest VM.
> > > vdpa device is in hypevisor.
> > >
> > > How can hypervisor compose a vdpa device without any tool?
> > > How can it tell ethtool, what is supported and what are the defaults?
> > >
> > > I must be misunderstanding your comment about ethtool.
> > > Can you please explain?
> > 
> > 
> > I am basically saying that we probably want to be able to change MAC of a
> > VDPA device on the host without desroying and recreating the device as long
> > as it's not in use.
> Ok. I understood your comment now.
> Yes, this was the objective which is why they are present as independent config knob.
> Jason was suggesting to have them as creation only knobs, which requires recreate.
> 
> I don't have strong opinion for either method.
> 
> Passing them at creation time is simpler for user.
> If user needs the ability to modify and reuse same device with different config, extending such support in future like this patch should possible.
> 
> So there are two questions to close.
> 1. Can we start with config params at vdpa device creation time?

I'm not sure whether we need both but I'd like to see a full API
and I think we all agree host wants ability to tweak mac after
device creation even if guest is not allowed to change mac, right?

> 2. Is it ok to have these config params as individual fields at netlink U->K UAPI level?
> This is the method proposed in this patch series.
> (Similar to incrementally growing vxlan ip link command).
> 
> Or 
> They should be packed in a structure between U-> K and deal with typecasting based on size and more?
> (Jason's input).

I'm inclined to say vxlan is closer to a model to follow.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

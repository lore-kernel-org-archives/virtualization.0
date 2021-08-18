Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7343C4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 04:32:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5793F60F38
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 04:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5793F60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 057084013A;
	Wed, 18 Aug 2021 04:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YbXXlFvCa2xS; Wed, 18 Aug 2021 04:31:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 891EA401E9;
	Wed, 18 Aug 2021 04:31:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58D38C001A;
	Wed, 18 Aug 2021 04:31:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F10C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 505194013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vBgIX9fyQr1O
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F28E5401E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629261113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pqq73nMgR8vCSMXcMrRo7loaTCL+gFspMuJdxiPpkW0=;
 b=hR2rpT3VnKXStqv2J6f5VQ1psxSIt7FYD/YStTp4SHmU6tF0Gh8avHWBbS/juOgNoqspUy
 5rbDHI9mhlR+Htgl27ke9AqG3s1XEjndlxQku0HRlEFT1npYEQXDufuovEd7h9Sb+MIukh
 6zhJhezGdXU00ZMySukoW59mqlSTjHc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-5XO_YTJ0OvKttuRkIPUxuA-1; Wed, 18 Aug 2021 00:31:51 -0400
X-MC-Unique: 5XO_YTJ0OvKttuRkIPUxuA-1
Received: by mail-lj1-f198.google.com with SMTP id
 e4-20020a05651c0904b029018bc821fd31so528508ljq.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 21:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pqq73nMgR8vCSMXcMrRo7loaTCL+gFspMuJdxiPpkW0=;
 b=F7zDgT4qnbSbRyqbqLq7UqsGtwChz7QellrtsbmrA+kU4PltR78E+23y03hclSNe34
 WCEWUXE5sgnv6z1V5QPQhsImdwtdOR7FohAhGVJP0h5RKXAjebB84whytGVtEszlgGX+
 Ul6YXw4Aa6H1RkQkCviO+sSJC+VOsVMoMP5pS5hfnm0ur1th2BWzEAbL02H+S5UhttDr
 yISQjXla4k0vhyPlcqLI5Yg0oRigCX9ssJsEmdJ5waOQTmOfBybVAC2evlbiPTdwAs+f
 0VqAFE1mKOEvufY3BoC+jlBAgwP6+KK3J6RWauRUXZrqTvkgnkdv0o2AecVfjrQ6RCu8
 z5HA==
X-Gm-Message-State: AOAM532tCtGGGaJxO6XYPDYMzl+GGrQ7FYIUdZVC+2wiyMvnzl6YaKY0
 WCnO+OfQCx2o+nOaIvV/yP80IuBKaRgyk6frooknOcbip+E79s0MulfqtXXWsvXfEUN89A3rkU1
 UDghRtdGfEfgQ80dRa37fOKB60USCguDmL8yGm28VCRUKqgBzALTSs5tjsA==
X-Received: by 2002:a19:f719:: with SMTP id z25mr4918067lfe.339.1629261110216; 
 Tue, 17 Aug 2021 21:31:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMYuBPJ/nY7k7pGK34tCefnYU0Cj7x8nxA/qpETQSuq7OfEpfpRjBjzO6H14VDl7msx4BVAXhHUPXgaMmoof8=
X-Received: by 2002:a19:f719:: with SMTP id z25mr4918049lfe.339.1629261109924; 
 Tue, 17 Aug 2021 21:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Aug 2021 12:31:39 +0800
Message-ID: <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Wed, Aug 18, 2021 at 11:15 AM Parav Pandit <parav@nvidia.com> wrote:
>
>
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, August 17, 2021 2:24 AM
> >
> > On Mon, Aug 09, 2021 at 09:51:49AM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, August 9, 2021 3:10 PM
> > > >
> > > > On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> > > > >
> > > > >
> > > > > >
> > > > > > The point is to try and not reinvent a dedicated vpda interface
> > > > > > where a generic one exits.
> > > > > > E.g. for phy things such as mac speed etc, I think most people
> > > > > > are using ethtool things right?
> > > > >
> > > > > As you know vdpa is the backend device for the front-end netdevice
> > > > accessed by the ethtool.
> > > > > vdpa management tool here is composing the vdpa device.
> > > > >
> > > > > For example creator (hypervisor) of the vdpa devices knows that a
> > > > > guest VM is given 4 vcpus, So hypervisor creates a vdpa devices
> > > > > with config space layout as, max_virtqueue_pairs = 4.
> > > > > And the MAC address chosen by hypervisor in mac[6].
> > > > >
> > > > > Guest VM ethtool can still chose to use less number of channels.
> > > > >
> > > > > Typically,
> > > > > ethtool is for guest VM.
> > > > > vdpa device is in hypevisor.
> > > > >
> > > > > How can hypervisor compose a vdpa device without any tool?
> > > > > How can it tell ethtool, what is supported and what are the defaults?
> > > > >
> > > > > I must be misunderstanding your comment about ethtool.
> > > > > Can you please explain?
> > > >
> > > >
> > > > I am basically saying that we probably want to be able to change MAC
> > > > of a VDPA device on the host without desroying and recreating the
> > > > device as long as it's not in use.
> > > Ok. I understood your comment now.
> > > Yes, this was the objective which is why they are present as independent
> > config knob.
> > > Jason was suggesting to have them as creation only knobs, which requires
> > recreate.
> > >
> > > I don't have strong opinion for either method.
> > >
> > > Passing them at creation time is simpler for user.
> > > If user needs the ability to modify and reuse same device with different
> > config, extending such support in future like this patch should possible.
> > >
> > > So there are two questions to close.
> > > 1. Can we start with config params at vdpa device creation time?
> >
> > I'm not sure whether we need both but I'd like to see a full API and I think we
> > all agree host wants ability to tweak mac after device creation even if guest is
> > not allowed to change mac, right?
> >
> Yes.
> $ vdpa dev add name foo mgmtdev pci/0000:03:00.0 mac 00:11:22:33:44:55 maxvqs 8 mtu 9000
>
> Above API if we do at creation time. It is likely simpler for user to pass necessary params during creation time.
>
> > > 2. Is it ok to have these config params as individual fields at netlink U->K
> > UAPI level?
> > > This is the method proposed in this patch series.
> > > (Similar to incrementally growing vxlan ip link command).
> > >
> > > Or
> > > They should be packed in a structure between U-> K and deal with
> > typecasting based on size and more?
> > > (Jason's input).
> >
> > I'm inclined to say vxlan is closer to a model to follow.
> Ok. thanks for the feedback. We are using the model close to vxlan.
> Lets resolve should we have it at creation time, post creation or both?
> (a) Creation time
> Pros:
> - simpler single api for user
> - eliminates needs of inventing stats reset in future series
> Cons:
> - inability to reuse the device with different config

This can be solved by destroying the instance and re-creating it with
a different params?

> - This may not be of great advantage, and it is probably fine to have creation time params
>
> (b) post creation time:
> Pros:
> - able to reuse the device with different config for say different VM.
> - will require stats reset in future once stats are implemented

Any reason for doing this other than re-creating the device?

> Cons:
> - more commands for users to config a device, better to have the ability at create time.

We probably need to support post creation but it should be device specific.

E.g we may support device resize for virtio-blk devices.

But it can be done on top I think.

Thanks

>
> >
> > --
> > MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

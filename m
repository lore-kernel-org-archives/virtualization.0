Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCAFC4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:34:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0167A610FB
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 17:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0167A610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C6024024D;
	Wed, 18 Aug 2021 17:34:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w2fFk7yvFel5; Wed, 18 Aug 2021 17:33:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1528940276;
	Wed, 18 Aug 2021 17:33:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCDFBC001A;
	Wed, 18 Aug 2021 17:33:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A46BCC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93D70405D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7_ItjlqmiPY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:33:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5689405A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629308035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ix6zIByLS7a/F8NlblLsc08p+9CLLjNjkrO07dXdXio=;
 b=MQ4e3yYGjfoSKGk3oqPEoqDABFCxV9+kuZomWH0vR6u0tEjV6M3+sHeR1Y+XtXEvMewLuX
 L+8CDbjIoneTIJjQ92FchFzVDKsf1bf25P0zaqIKaPlgkMo5ywycg9fhMu4uP77ZNinkps
 PztupZQQ+9rAFL/eS44aLrAvERLaRhU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-H-qzTKxpONi5Qyx_VDqh3A-1; Wed, 18 Aug 2021 13:33:52 -0400
X-MC-Unique: H-qzTKxpONi5Qyx_VDqh3A-1
Received: by mail-ed1-f69.google.com with SMTP id
 p2-20020a50c9420000b02903a12bbba1ebso1410167edh.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 10:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ix6zIByLS7a/F8NlblLsc08p+9CLLjNjkrO07dXdXio=;
 b=XXwC5DohglL4wQHnmHyYJ622BHw3NIN88lIw8OL4EUf2uAa0Y95hn4W7DTG7jn9TEL
 tX3XhrzDX4m8UNWkecYg6nwJJmzl5NHL/NiHnViI6oNjJHcK7x+n1wQZz+Qx+ybPSG8W
 RCa6MdlgqoUbC0bh9RC27ClFK0QCDCMBUvoiGni4YpBEm+gzVnqWMuoOX9nF80XvNiQT
 HTYz0UZpxirhJcIPtLI4tZJaMVyr1JZ0Ng3bUGiDPEh82dGRvV5gP0SQxYsNPizgFadv
 04NF94RnBY3NXlvnLwzx961xeyDoBNU15zC7/b97YxYTiAp7g5XGcHbupoJqVyrwdmPw
 0L/A==
X-Gm-Message-State: AOAM532tm9XaBWHLHAZvCULqOLwvxIHZlQ2IAzlCd9MItQ5M/BNERtjT
 Jf+EWhJlyxt52Qc6CwXIkEeF+6S9D+3mZiLUPAjqoXX/TN6q7ZZlcGyTVrAIrssYEdlZQzGCi1r
 8dRQ7HlgQoDzI0MRgpNYeJ/11iVckIVwA5GAqiABNDA==
X-Received: by 2002:a17:906:b0c8:: with SMTP id
 bk8mr10981327ejb.412.1629308031277; 
 Wed, 18 Aug 2021 10:33:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRzt4+29zTXiK9O32F8qC+y9uYuB1n/gB0ky3DCJTeWZ776AkWxWYt9bOs2ui22PEPve57lQ==
X-Received: by 2002:a17:906:b0c8:: with SMTP id
 bk8mr10981315ejb.412.1629308031070; 
 Wed, 18 Aug 2021 10:33:51 -0700 (PDT)
Received: from redhat.com ([2.55.150.133])
 by smtp.gmail.com with ESMTPSA id m6sm383977edq.22.2021.08.18.10.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 10:33:50 -0700 (PDT)
Date: Wed, 18 Aug 2021 13:33:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210818133309-mutt-send-email-mst@kernel.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210809053624-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CF2E07B38C45A2829B7BDCF69@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20210816165217-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54819F68856798FBA8528BBADCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs4fnV2RT8DSW3i0TtHL6t1rwuNyC-uLi3tRopb7mOhvA@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 12:31:39PM +0800, Jason Wang wrote:
> On Wed, Aug 18, 2021 at 11:15 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Tuesday, August 17, 2021 2:24 AM
> > >
> > > On Mon, Aug 09, 2021 at 09:51:49AM +0000, Parav Pandit wrote:
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Monday, August 9, 2021 3:10 PM
> > > > >
> > > > > On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > The point is to try and not reinvent a dedicated vpda interface
> > > > > > > where a generic one exits.
> > > > > > > E.g. for phy things such as mac speed etc, I think most people
> > > > > > > are using ethtool things right?
> > > > > >
> > > > > > As you know vdpa is the backend device for the front-end netdevice
> > > > > accessed by the ethtool.
> > > > > > vdpa management tool here is composing the vdpa device.
> > > > > >
> > > > > > For example creator (hypervisor) of the vdpa devices knows that a
> > > > > > guest VM is given 4 vcpus, So hypervisor creates a vdpa devices
> > > > > > with config space layout as, max_virtqueue_pairs = 4.
> > > > > > And the MAC address chosen by hypervisor in mac[6].
> > > > > >
> > > > > > Guest VM ethtool can still chose to use less number of channels.
> > > > > >
> > > > > > Typically,
> > > > > > ethtool is for guest VM.
> > > > > > vdpa device is in hypevisor.
> > > > > >
> > > > > > How can hypervisor compose a vdpa device without any tool?
> > > > > > How can it tell ethtool, what is supported and what are the defaults?
> > > > > >
> > > > > > I must be misunderstanding your comment about ethtool.
> > > > > > Can you please explain?
> > > > >
> > > > >
> > > > > I am basically saying that we probably want to be able to change MAC
> > > > > of a VDPA device on the host without desroying and recreating the
> > > > > device as long as it's not in use.
> > > > Ok. I understood your comment now.
> > > > Yes, this was the objective which is why they are present as independent
> > > config knob.
> > > > Jason was suggesting to have them as creation only knobs, which requires
> > > recreate.
> > > >
> > > > I don't have strong opinion for either method.
> > > >
> > > > Passing them at creation time is simpler for user.
> > > > If user needs the ability to modify and reuse same device with different
> > > config, extending such support in future like this patch should possible.
> > > >
> > > > So there are two questions to close.
> > > > 1. Can we start with config params at vdpa device creation time?
> > >
> > > I'm not sure whether we need both but I'd like to see a full API and I think we
> > > all agree host wants ability to tweak mac after device creation even if guest is
> > > not allowed to change mac, right?
> > >
> > Yes.
> > $ vdpa dev add name foo mgmtdev pci/0000:03:00.0 mac 00:11:22:33:44:55 maxvqs 8 mtu 9000
> >
> > Above API if we do at creation time. It is likely simpler for user to pass necessary params during creation time.
> >
> > > > 2. Is it ok to have these config params as individual fields at netlink U->K
> > > UAPI level?
> > > > This is the method proposed in this patch series.
> > > > (Similar to incrementally growing vxlan ip link command).
> > > >
> > > > Or
> > > > They should be packed in a structure between U-> K and deal with
> > > typecasting based on size and more?
> > > > (Jason's input).
> > >
> > > I'm inclined to say vxlan is closer to a model to follow.
> > Ok. thanks for the feedback. We are using the model close to vxlan.
> > Lets resolve should we have it at creation time, post creation or both?
> > (a) Creation time
> > Pros:
> > - simpler single api for user
> > - eliminates needs of inventing stats reset in future series
> > Cons:
> > - inability to reuse the device with different config
> 
> This can be solved by destroying the instance and re-creating it with
> a different params?
> 
> > - This may not be of great advantage, and it is probably fine to have creation time params
> >
> > (b) post creation time:
> > Pros:
> > - able to reuse the device with different config for say different VM.
> > - will require stats reset in future once stats are implemented
> 
> Any reason for doing this other than re-creating the device?

Permissions.


> > Cons:
> > - more commands for users to config a device, better to have the ability at create time.
> 
> We probably need to support post creation but it should be device specific.
> 
> E.g we may support device resize for virtio-blk devices.
> 
> But it can be done on top I think.
> 
> Thanks
> 
> >
> > >
> > > --
> > > MST
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

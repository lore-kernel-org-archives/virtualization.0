Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B932C43334
	for <virtualization@archiver.kernel.org>; Wed, 13 Jul 2022 05:44:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A975342342;
	Wed, 13 Jul 2022 05:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A975342342
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YRaeqGE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id khJxEKQmOuL8; Wed, 13 Jul 2022 05:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B53DD42346;
	Wed, 13 Jul 2022 05:44:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B53DD42346
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C2B5C0033;
	Wed, 13 Jul 2022 05:44:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12F98C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D34EE4010D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D34EE4010D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YRaeqGE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GitUx3WgfpLF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E711F4010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E711F4010C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Jul 2022 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657691085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ye/OEisuk1M9Y7UFRb9TBjjAD4IQ42089/4Jo2aO6ys=;
 b=YRaeqGE8tDhCKRbgQNUxymPrqaT9Rc4pVew2olAgwIM/kvFYInrjGTk0KXv9Yv3lIM4GNG
 Zu/HmKZbNsG+P9J23b6GRxyP3PeKGB69pA8mSVGbGf/Ti1w/wsUQKg2Tq6YvxgKRiYwJPF
 +sAe2tUIKJcXTA3dbFaJZ2T01TAF9uA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-Rl1MP9fBMuaWnYhv6Et5tg-1; Wed, 13 Jul 2022 01:44:44 -0400
X-MC-Unique: Rl1MP9fBMuaWnYhv6Et5tg-1
Received: by mail-wm1-f70.google.com with SMTP id
 z11-20020a05600c0a0b00b003a043991610so488755wmp.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 22:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ye/OEisuk1M9Y7UFRb9TBjjAD4IQ42089/4Jo2aO6ys=;
 b=vhCE/NZj0Mgq0Fsa2d430SF0B3pEWnI0p4lGkC2GUSs5Vhzib5QRtePgN642Dkck9g
 Soa7PwJo0X8i30qJak4kJ9fVzALmcG9x3i4KZMfdgWGKCAkSdTjlwK9lHn9leJU7uA4o
 48xsRjxqpj6d+nFePZzhul+auh/8ZYvS1LvwKUj9Z0zS98pATwI6H8F8GdGsCCEyefgV
 FTqbJA4U2WdByNOHc/9xgcATwCu3S22dpBNBXPgujKHfR9n8PwYkr6O63o+ZUO/b11IU
 pS0L5qNeIXhNWgV6dsn+4djR3t0POfpjP+6jJe/4Bd9HB2no4OlQcil8fjAaL9yxsnZS
 bt2Q==
X-Gm-Message-State: AJIora+d054+Dm9iJ+9DPKuUb8Ar5M/T9iX9lckfLjt6qFfd9mmFTHJC
 azYwUKPWM8cmGALrVcQLLNSnE9Rfp2VoZOWK+YkmjaoxVDo/LUpuTKPl4mY4YIfsjr0BxyL9Q9+
 1f59uUF0dB3LxcKINCGMPgBWlQkVWyc1+W4Ziu/MGZA==
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id
 x1-20020adfffc1000000b0021d66a1c3eemr1390282wrs.364.1657691083328; 
 Tue, 12 Jul 2022 22:44:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sQssmai+lLbb0KzVW5xLsNMZ6wQ+8bMqipH7GIljNm9hRF4wnZnKrc96DYEniG7ZAFm7PQag==
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id
 x1-20020adfffc1000000b0021d66a1c3eemr1390276wrs.364.1657691083098; 
 Tue, 12 Jul 2022 22:44:43 -0700 (PDT)
Received: from redhat.com ([2.52.24.42]) by smtp.gmail.com with ESMTPSA id
 p12-20020a5d48cc000000b0021d9d13bf6csm8506209wrs.97.2022.07.12.22.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jul 2022 22:44:42 -0700 (PDT)
Date: Wed, 13 Jul 2022 01:44:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 1/6] vDPA/ifcvf: get_config_size should return a value
 no greater than dev implementation
Message-ID: <20220713013141-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-2-lingshan.zhu@intel.com>
 <CACGkMEvGo2urfPriS3f6dCxT+41KJ0E-KUd4-GvUrX81BVy8Og@mail.gmail.com>
 <b2b2fb5e-c1c2-84b6-0315-a6eef121cdac@intel.com>
MIME-Version: 1.0
In-Reply-To: <b2b2fb5e-c1c2-84b6-0315-a6eef121cdac@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Dawar, Gautam" <gautam.dawar@amd.com>
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

On Fri, Jul 08, 2022 at 02:44:08PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 7/4/2022 12:39 PM, Jason Wang wrote:
> > On Fri, Jul 1, 2022 at 9:36 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
> > > ifcvf_get_config_size() should return a virtio device type specific value,
> > > however the ret_value should not be greater than the onboard size of
> > > the device implementation. E.g., for virtio_net, config_size should be
> > > the minimum value of sizeof(struct virtio_net_config) and the onboard
> > > cap size.
> > Rethink of this, I wonder what's the value of exposing device
> > implementation details to users? Anyhow the parent is in charge of
> > "emulating" config space accessing.
> This will not be exposed to the users, it is a ifcvf internal helper,
> to get the actual device config space size.
> 
> For example, if ifcvf drives an Intel virtio-net device,
> if the device config space size is greater than sizeof(struct
> virtio_net_cfg),
> this means the device has something more than the spec, some private fields,
> we don't want to expose these extra private fields to the users, so in this
> case,
> we only return what the spec defines.

This is kind of already the case.

> If the device config space size is less than sizeof(struct virtio_net_cfg),
> means the device didn't implement all fields the spec defined, like no RSS.
> In such cases, we only return what the device implemented.
> So these are defensive programming.

I think the issue you are describing is simply this.


Driver must not access BAR outside capability length. Current code
does not verify that it does not. Not the case for the current
devices but it's best to be safe against the case where
device does not implement some of the capability.


From that POV I think the patch is good, just fix the log.



> > 
> > If we do this, it's probably a blocker for cross vendor stuff.
> > 
> > Thanks
> > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > ---
> > >   drivers/vdpa/ifcvf/ifcvf_base.c | 13 +++++++++++--
> > >   drivers/vdpa/ifcvf/ifcvf_base.h |  2 ++
> > >   2 files changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > index 48c4dadb0c7c..fb957b57941e 100644
> > > --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> > > +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> > > @@ -128,6 +128,7 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
> > >                          break;
> > >                  case VIRTIO_PCI_CAP_DEVICE_CFG:
> > >                          hw->dev_cfg = get_cap_addr(hw, &cap);
> > > +                       hw->cap_dev_config_size = le32_to_cpu(cap.length);
> > >                          IFCVF_DBG(pdev, "hw->dev_cfg = %p\n", hw->dev_cfg);
> > >                          break;
> > >                  }
> > > @@ -233,15 +234,23 @@ int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
> > >   u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
> > >   {
> > >          struct ifcvf_adapter *adapter;
> > > +       u32 net_config_size = sizeof(struct virtio_net_config);
> > > +       u32 blk_config_size = sizeof(struct virtio_blk_config);
> > > +       u32 cap_size = hw->cap_dev_config_size;
> > >          u32 config_size;
> > > 
> > >          adapter = vf_to_adapter(hw);
> > > +       /* If the onboard device config space size is greater than
> > > +        * the size of struct virtio_net/blk_config, only the spec
> > > +        * implementing contents size is returned, this is very
> > > +        * unlikely, defensive programming.
> > > +        */
> > >          switch (hw->dev_type) {
> > >          case VIRTIO_ID_NET:
> > > -               config_size = sizeof(struct virtio_net_config);
> > > +               config_size = cap_size >= net_config_size ? net_config_size : cap_size;
> > >                  break;
> > >          case VIRTIO_ID_BLOCK:
> > > -               config_size = sizeof(struct virtio_blk_config);
> > > +               config_size = cap_size >= blk_config_size ? blk_config_size : cap_size;
> > >                  break;
> > >          default:
> > >                  config_size = 0;
> > > diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
> > > index 115b61f4924b..f5563f665cc6 100644
> > > --- a/drivers/vdpa/ifcvf/ifcvf_base.h
> > > +++ b/drivers/vdpa/ifcvf/ifcvf_base.h
> > > @@ -87,6 +87,8 @@ struct ifcvf_hw {
> > >          int config_irq;
> > >          int vqs_reused_irq;
> > >          u16 nr_vring;
> > > +       /* VIRTIO_PCI_CAP_DEVICE_CFG size */
> > > +       u32 cap_dev_config_size;
> > >   };
> > > 
> > >   struct ifcvf_adapter {
> > > --
> > > 2.31.1
> > > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

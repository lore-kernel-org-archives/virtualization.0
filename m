Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CCBC4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:40:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC86F60D07
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC86F60D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EB94606CF;
	Mon,  9 Aug 2021 09:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8X2ks7afSK1d; Mon,  9 Aug 2021 09:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 09CCA6071F;
	Mon,  9 Aug 2021 09:40:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE345C001A;
	Mon,  9 Aug 2021 09:40:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9F93C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A10A3401EB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RU_zkBbPPzLN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EE3A401E7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628502022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LlMj016L1d5rVJuxIZjhKD1HiBUM/BI1KwecUKM19S0=;
 b=Hoy8pfycAaTVs0R7KPRdpLr3YFu9iSMXaHMGqoAgWuilbURgGH1gz/MrSH4KaIQClDhNHm
 jZA4t6VRMEiUhIM7PcQleGiNl8sXPJosu5er6NXWx5G+ZIBqVIC8OxRvMKMS13mDmqPm7i
 bHxr21peFJhwkaP5NwC/aXvaoSla5yo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-8jkjjEovOkmAjUZfGjl-gg-1; Mon, 09 Aug 2021 05:40:21 -0400
X-MC-Unique: 8jkjjEovOkmAjUZfGjl-gg-1
Received: by mail-ej1-f70.google.com with SMTP id
 qh25-20020a170906ecb9b02905a655de6553so4224956ejb.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 02:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LlMj016L1d5rVJuxIZjhKD1HiBUM/BI1KwecUKM19S0=;
 b=OgMqXb51OoRiwQy+SYQeSj7q7DV6REMqyfAEKa5wSi/BH+6BCcvWalMw8Bz6YQ3liu
 x6ClNeamXGvPwABPMvm0LIFBl+L6QwdzTwjqccEUmu0m9ZgW+7A18Wa7rl2nRsK7jCZb
 aApR+93STjP5UXY/E+KN64FZ+XwuBTN/seph+Wp7fGFuM6YYsK1ZsiKa/MOmhKZL4g/I
 KCjGD5MH4CgEb+q48oH6weMVXsSciiaRXMlahAgYRy3JLFNDFfCJqnREE0Nrvx+ZjUKg
 rCs5+BRDDYkswgfaWqi680OTf2njNwtHDcQuS/V9mqTCcXolKqRP2zjndrb5TTUyxaKb
 Eeig==
X-Gm-Message-State: AOAM531qBtegnqjaVo7oTLdLAwDHDWEjn7fopBrji8z1/Avme9jp4IwE
 TIQPlqL8zJzyvsuZOJGb2asZHxpaywQ2MKujBUS7IaYSnKxQu/0g9Uf4wwoSVQr6g8sMQcBCt5E
 LE2/3JWnk+iSJWhWMzEJq+N/SELzrYDnhquSHXaV3CQ==
X-Received: by 2002:a17:906:19d0:: with SMTP id
 h16mr21754231ejd.203.1628502019940; 
 Mon, 09 Aug 2021 02:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9x4joDMjSCCpKPXPsl9FMLUwM8svv5P1Drr8zXWMxJsUIYsVYipxYck3nPM7J/LDUL2tp7g==
X-Received: by 2002:a17:906:19d0:: with SMTP id
 h16mr21754213ejd.203.1628502019641; 
 Mon, 09 Aug 2021 02:40:19 -0700 (PDT)
Received: from redhat.com ([2.55.145.148])
 by smtp.gmail.com with ESMTPSA id jy17sm5694596ejc.112.2021.08.09.02.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 02:40:18 -0700 (PDT)
Date: Mon, 9 Aug 2021 05:40:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v3 0/6] vdpa: enable user to set mac, mtu
Message-ID: <20210809053624-mutt-send-email-mst@kernel.org>
References: <20210616191155.102303-1-parav@nvidia.com>
 <20210805055623-mutt-send-email-mst@kernel.org>
 <e3b31032-222a-e1bc-f452-a965b456f48b@redhat.com>
 <20210806034817-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812C49AAA468E1E6A871A9DCF39@PH0PR12MB5481.namprd12.prod.outlook.com>
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

On Fri, Aug 06, 2021 at 08:55:56AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, August 6, 2021 2:12 PM
> 
> 
> > >  enum vdpa_attr {
> > > @@ -33,6 +34,16 @@ enum vdpa_attr {
> > >  	VDPA_ATTR_DEV_MAX_VQS,			/* u32 */
> > >  	VDPA_ATTR_DEV_MAX_VQ_SIZE,		/* u16 */
> > > +	VDPA_ATTR_DEV_NET_CFG_MACADDR,		/* binary */
> > > +	VDPA_ATTR_DEV_NET_STATUS,		/* u8 */
> > > +	VDPA_ATTR_DEV_NET_CFG_MAX_VQP,		/* u16 */
> > > +	VDPA_ATTR_DEV_NET_CFG_MTU,		/* u16 */
> > > +	VDPA_ATTR_DEV_NET_CFG_SPEED,		/* u16 */
> > > +	VDPA_ATTR_DEV_NET_CFG_DUPLEX,		/* u16 */
> > > +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_KEY_LEN,	/* u8 */
> > > +	VDPA_ATTR_DEV_NET_CFG_RSS_MAX_IT_LEN,	/* u16 */
> > > +	VDPA_ATTR_DEV_NET_CFG_RSS_HASH_TYPES,	/* u32 */
> > > +
> > >  	/* new attributes must be added above here */
> > >  	VDPA_ATTR_MAX,
> > >  };
> > 
> > The point is to try and not reinvent a dedicated vpda interface where a
> > generic one exits.
> > E.g. for phy things such as mac speed etc, I think most people are using
> > ethtool things right?
> 
> As you know vdpa is the backend device for the front-end netdevice accessed by the ethtool.
> vdpa management tool here is composing the vdpa device.
> 
> For example creator (hypervisor) of the vdpa devices knows that a guest VM is given 4 vcpus,
> So hypervisor creates a vdpa devices with config space layout as,
> max_virtqueue_pairs = 4.
> And the MAC address chosen by hypervisor in mac[6].
> 
> Guest VM ethtool can still chose to use less number of channels.
> 
> Typically,
> ethtool is for guest VM.
> vdpa device is in hypevisor.
> 
> How can hypervisor compose a vdpa device without any tool?
> How can it tell ethtool, what is supported and what are the defaults?
> 
> I must be misunderstanding your comment about ethtool.
> Can you please explain?


I am basically saying that we probably want to be able to
change MAC of a VDPA device on the host without desroying and recreating the device
as long as it's not in use.

For a VF I can do this on the host:

ip link set eth0 vf 1 mac 00:11:22:33:44:55

ideally same thing would work for vdpa.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

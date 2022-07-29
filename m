Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C4C00144
	for <virtualization@archiver.kernel.org>; Fri, 29 Jul 2022 09:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8432460F44;
	Fri, 29 Jul 2022 09:23:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8432460F44
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVsG6AZf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y-HHbNQzEV9p; Fri, 29 Jul 2022 09:23:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D688E606F9;
	Fri, 29 Jul 2022 09:23:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D688E606F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E877C0035;
	Fri, 29 Jul 2022 09:23:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D87C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CC3A41B5E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:23:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CC3A41B5E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVsG6AZf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W26huQT3XEzn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:23:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52DAE41B57
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52DAE41B57
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659086594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oUdBoqQQwUbtvsfCW4fni3GA77RjAGhoP1Nsc9jk5ic=;
 b=eVsG6AZfQfD49aKMRKHuO7H1/X0a+qzQjkycGaWTz07y7UrzufEvd02hSq3fnyVAYaRSBe
 TeiPShMVsZ/68Mfnxxqwp/s7ZM+DUPxvurCkqoLaPwclX+xG9g4l2HHqHJ7/ArQ1xlVS2p
 4fCLUDHZ5Axmrs9BluXeF4kQZusb1EY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-ez8dwd57PYq82_gy9K0zUA-1; Fri, 29 Jul 2022 05:23:12 -0400
X-MC-Unique: ez8dwd57PYq82_gy9K0zUA-1
Received: by mail-wm1-f70.google.com with SMTP id
 r8-20020a1c4408000000b003a2fdeea756so3259375wma.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 02:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=oUdBoqQQwUbtvsfCW4fni3GA77RjAGhoP1Nsc9jk5ic=;
 b=WocEJQg8IRItKZXiadQ/x/5ABra/6g9AhzNVfEmZIGAX0Gt93uBJQO8fMPKC3yPQRB
 q3lml8wQPonbRBonKW7nx0VFvlGs4vaNaRwNEVYGdWouzHHtHF8Wvqt27uRcfnp+D2CA
 RleXkVAFdV5gigdoLMYJSIT7FimYovVgqsdb5dE9G1Zt69uJufNgvMoSduw9YWp+H1ig
 l54g7GUX2Pv/6WcQRwfg5h9yN6jGebvZ8XNgYIH238yLhSvKCdWEwavmxCVCdjrSG0C+
 VaX8jMoaURb5bGgiq+g2Lrnm2JvM0bMkYve+3lUGUff049pGqVtu3ukziflLlw4O6TQV
 i+tA==
X-Gm-Message-State: ACgBeo22mij+19DiS8dy9CMvyUT350h5YHN8aqFB+CUFc93ANLzRtnTK
 Zm/W/Nm9SapzRgE2ao6sfWGAFTprdA0WjCheGc+S03gr0Wu7qxXWy6OpjEkzNz1vU/gagwONlTZ
 mEJZEScSAJHjTj5DBU38YlAKaH/bCvxDHU6VYFZlqag==
X-Received: by 2002:a05:6000:15c3:b0:21d:9f8b:2c3e with SMTP id
 y3-20020a05600015c300b0021d9f8b2c3emr1849914wry.72.1659086591503; 
 Fri, 29 Jul 2022 02:23:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7FTu+5JLpQjx+VA3oidZ9+QsK896x0RakIZgfjw1iE6x88yNMooC2rjY7ywdS8cVawU+4U1g==
X-Received: by 2002:a05:6000:15c3:b0:21d:9f8b:2c3e with SMTP id
 y3-20020a05600015c300b0021d9f8b2c3emr1849896wry.72.1659086591261; 
 Fri, 29 Jul 2022 02:23:11 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 k18-20020a5d6d52000000b0021f0c05859esm2537511wri.71.2022.07.29.02.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 02:23:10 -0700 (PDT)
Date: Fri, 29 Jul 2022 05:23:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
Message-ID: <20220729052149-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-7-lingshan.zhu@intel.com>
 <20220729045039-mutt-send-email-mst@kernel.org>
 <7ce4da7f-80aa-14d6-8200-c7f928f32b48@intel.com>
 <20220729051119-mutt-send-email-mst@kernel.org>
 <50b4e7ba-3e49-24b7-5c23-d8a76c61c924@intel.com>
MIME-Version: 1.0
In-Reply-To: <50b4e7ba-3e49-24b7-5c23-d8a76c61c924@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, gautam.dawar@amd.com
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

On Fri, Jul 29, 2022 at 05:20:17PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 7/29/2022 5:17 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 29, 2022 at 05:07:11PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 7/29/2022 4:53 PM, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 01, 2022 at 09:28:26PM +0800, Zhu Lingshan wrote:
> > > > > This commit fixes spars warnings: cast to restricted __le16
> > > > > in function vdpa_dev_net_config_fill() and
> > > > > vdpa_fill_stats_rec()
> > > > > 
> > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > ---
> > > > >    drivers/vdpa/vdpa.c | 6 +++---
> > > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > index 846dd37f3549..ed49fe46a79e 100644
> > > > > --- a/drivers/vdpa/vdpa.c
> > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > @@ -825,11 +825,11 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > >    		    config.mac))
> > > > >    		return -EMSGSIZE;
> > > > > -	val_u16 = le16_to_cpu(config.status);
> > > > > +	val_u16 = __virtio16_to_cpu(true, config.status);
> > > > >    	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> > > > >    		return -EMSGSIZE;
> > > > > -	val_u16 = le16_to_cpu(config.mtu);
> > > > > +	val_u16 = __virtio16_to_cpu(true, config.mtu);
> > > > >    	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> > > > >    		return -EMSGSIZE;
> > > > Wrong on BE platforms with legacy interface, isn't it?
> > > > We generally don't handle legacy properly in VDPA so it's
> > > > not a huge deal, but maybe add a comment at least?
> > > Sure, I can add a comment here: this is for modern devices only.
> > > 
> > > Thanks,
> > > Zhu Lingshan
> > Hmm. what "this" is for modern devices only here?
> this cast, for LE modern devices.

I think status existed in legacy for sure, and it's possible that
some legacy devices backported mtu and max_virtqueue_pairs otherwise
we would have these fields as __le not as __virtio, right?

> > 
> > > > 
> > > > > @@ -911,7 +911,7 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> > > > >    	}
> > > > >    	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > > > -	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
> > > > > +	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > > > >    	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> > > > >    		return -EMSGSIZE;
> > > > > -- 
> > > > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

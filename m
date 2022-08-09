Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A27AC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 19:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00C1960BC1;
	Tue,  9 Aug 2022 19:36:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00C1960BC1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NlMTdFgB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ttG4Zh9mb557; Tue,  9 Aug 2022 19:36:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B1E860AA4;
	Tue,  9 Aug 2022 19:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B1E860AA4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10A0DC0032;
	Tue,  9 Aug 2022 19:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A006C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 182D9404F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:36:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 182D9404F6
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NlMTdFgB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2UvwtH7fQo3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:36:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 08148400E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 08148400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660073767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=86z9/W88KKlZHXVb1k6E/YXG9z9XRpPQOI7vpeaGWug=;
 b=NlMTdFgByOQKGj0lZI7M9Kkt+YgO4j8YniULQjWSXDbRV6EjRBoDkCPFuIq6G48vwhzc0A
 ML9DVhEInWFcvxvT/5MQKgf0DaiIwzIUrw5IZyalFnq7SWe/8sAt2hudKTIFUTfGKAASc7
 MxpuaiXjarZk9EnyPaxfPGAY/r+jhRI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-7kU7KU0rNhCTtXIqSjo64w-1; Tue, 09 Aug 2022 15:36:06 -0400
X-MC-Unique: 7kU7KU0rNhCTtXIqSjo64w-1
Received: by mail-ed1-f70.google.com with SMTP id
 n8-20020a05640205c800b00434fb0c150cso7744690edx.19
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 12:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=86z9/W88KKlZHXVb1k6E/YXG9z9XRpPQOI7vpeaGWug=;
 b=AvY6E62gwHwgQAyA18zB/L7QlkFnS5AWYJHH8Xt/1+2qLd+ruZbBUN3XXkUmg4MInQ
 eYBRXwzPNyn7Xds+8Zgk89XvXoUJPj0CD2M8S0XwiXR5U1NJRfSlLDW1tgDIMKSp6vV7
 pJyseFq/HcX2MQoOLNUbF/qWUsSt8UcDKWOImNaJE9z6oxCcJ0xDivz0O1tcptMUPRkO
 Smmha4+oG1LSa9dxgaceccGCdQHLApZSkqzu9rLbSSGsM0dwqsuaXQGaFguMqX14OXZ2
 kXxOYowgGSEGxaUM35i6F75Y/tWVnIxxGcPNp+eeEwe5Ni2yx4P9E5O9I3Jfmfhed6jl
 IkSw==
X-Gm-Message-State: ACgBeo3nUVyabl2p5+UNy2/VV8Dg/rybgeYao7+l2ckzYMIPUAOpFFV+
 6yA4ujWtTzY0YVeb2yU6p8ATppcAWo18Tm8V+Dyd3iG7VIIIZTxANxLl9fetBTZ+TSUzbakdf10
 xaGATAYO1bCx/oZeTA4dMXUjW8IxAE5ZMwXyNNMk3ZA==
X-Received: by 2002:aa7:d0d8:0:b0:441:4671:49d6 with SMTP id
 u24-20020aa7d0d8000000b00441467149d6mr3941259edo.252.1660073764940; 
 Tue, 09 Aug 2022 12:36:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6SVgSalV0wsmO7HBLIT8305FcJrKLeyl6xNti4dZOesLImI7NiKREUy8wFLzman/e7qzyfUg==
X-Received: by 2002:aa7:d0d8:0:b0:441:4671:49d6 with SMTP id
 u24-20020aa7d0d8000000b00441467149d6mr3941240edo.252.1660073764751; 
 Tue, 09 Aug 2022 12:36:04 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 o15-20020aa7dd4f000000b0043bba5ed21csm6408172edw.15.2022.08.09.12.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 12:36:04 -0700 (PDT)
Date: Tue, 9 Aug 2022 15:36:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH V4 5/6] vDPA: answer num of queue pairs = 1 to userspace
 when VIRTIO_NET_F_MQ == 0
Message-ID: <20220809152457-mutt-send-email-mst@kernel.org>
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-6-lingshan.zhu@intel.com>
 <PH0PR12MB5481AC83A7C7B0320D6FB44CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AC83A7C7B0320D6FB44CDC909@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "gautam.dawar@amd.com" <gautam.dawar@amd.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>
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

On Fri, Jul 22, 2022 at 01:14:42PM +0000, Parav Pandit wrote:
> 
> 
> > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > Sent: Friday, July 22, 2022 7:53 AM
> > 
> > If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair, so
> > when userspace querying queue pair numbers, it should return mq=1 than
> > zero.
> > 
> > Function vdpa_dev_net_config_fill() fills the attributions of the vDPA
> > devices, so that it should call vdpa_dev_net_mq_config_fill() so the
> > parameter in vdpa_dev_net_mq_config_fill() should be feature_device than
> > feature_driver for the vDPA devices themselves
> > 
> > Before this change, when MQ = 0, iproute2 output:
> > $vdpa dev config show vdpa0
> > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 0
> > mtu 1500
> > 
> > After applying this commit, when MQ = 0, iproute2 output:
> > $vdpa dev config show vdpa0
> > vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 1
> > mtu 1500
> > 
> No. We do not want to diverge returning values of config space for fields which are not present as discussed in previous versions.
> Please drop this patch.
> Nack on this patch.

Wrt this patch as far as I'm concerned you guys are bikeshedding.

Parav generally don't send nacks please they are not helpful.

Zhu Lingshan please always address comments in some way.  E.g. refer to
them in the commit log explaining the motivation and the alternatives.
I know you don't agree with Parav but ghosting isn't nice.

I still feel what we should have done is
not return a value, as long as we do return it we might
as well return something reasonable, not 0.

And I like it that this fixes sparse warning actually:
max_virtqueue_pairs it tagged as __virtio, not __le.

However, I am worried there is another bug here:
this is checking driver features. But really max vqs
should not depend on that, it depends on device
features, no?



> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> >  drivers/vdpa/vdpa.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c index
> > d76b22b2f7ae..846dd37f3549 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -806,9 +806,10 @@ static int vdpa_dev_net_mq_config_fill(struct
> > vdpa_device *vdev,
> >  	u16 val_u16;
> > 
> >  	if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> > -		return 0;
> > +		val_u16 = 1;
> > +	else
> > +		val_u16 = __virtio16_to_cpu(true, config-
> > >max_virtqueue_pairs);
> > 
> > -	val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> >  	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP,
> > val_u16);  }
> > 
> > @@ -842,7 +843,7 @@ static int vdpa_dev_net_config_fill(struct
> > vdpa_device *vdev, struct sk_buff *ms
> >  			      VDPA_ATTR_PAD))
> >  		return -EMSGSIZE;
> > 
> > -	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver,
> > &config);
> > +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_device,
> > +&config);
> >  }
> > 
> >  static int
> > --
> > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

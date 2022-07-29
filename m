Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF88DC25B06
	for <virtualization@archiver.kernel.org>; Fri, 29 Jul 2022 09:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 714B540C90;
	Fri, 29 Jul 2022 09:39:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 714B540C90
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VppifL1j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xYUajhTbaHh; Fri, 29 Jul 2022 09:39:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C36244016A;
	Fri, 29 Jul 2022 09:39:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C36244016A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E235C0035;
	Fri, 29 Jul 2022 09:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12CEAC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC8F060E16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC8F060E16
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VppifL1j
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sW4ym-IV_m2K
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:39:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EDA260BDB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EDA260BDB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659087558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=veILWJlK3GPd3S49p7aK/EHdqJpWr9yfw6rdaxJfX5Y=;
 b=VppifL1jgrCqyEBA9032NWP6ESgdJx4WkIUB1RF2cPkEOTkTTs9zNFpDQX7/4VitVpBo92
 8xzPdDxp0FJ8KsVR9HSFBj8OUWVVIeCHKC04Eh3AD89pGQdOvdyWvs7SzEC60EdRo9GEpb
 lmV8J5p7lFND5lU0ROPvn/UagAZokzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-KtnhSdCVNkGpZZbdWOc87A-1; Fri, 29 Jul 2022 05:39:10 -0400
X-MC-Unique: KtnhSdCVNkGpZZbdWOc87A-1
Received: by mail-wm1-f70.google.com with SMTP id
 n30-20020a05600c501e00b003a3264465ebso3033946wmr.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 02:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=veILWJlK3GPd3S49p7aK/EHdqJpWr9yfw6rdaxJfX5Y=;
 b=FqRfA/43ZHZT4WR5BJ4d1G7KXD8Lxr0PrKMptJfsh9pNAcaq5s2gOeIKYPkCsQmOSi
 B/GOAu9POG7/CzNEaWVapvfVoEktmL2ORfIRW+WpBoTf8MdHQ2XCl67ciHOdvs8DQGL5
 KIvfJANw6/FSerdkGo5AAOkCSlPtqExr8Ve/6lmxpNb8aSd70wdiyjtrcUIRVlCG/wM6
 hRDXGaTFz1k88aflMD2J2Hxh+SOrJtoNw3lz8wUjE4J6RLiDBtL/qZgXZnn5o5fouAQR
 EiS5ugdquw26s5s5seutUV5XvwDp1qkmHM9wh7IB1iyEckZZuZFapx4WZND3KJxPre7L
 aRUg==
X-Gm-Message-State: AJIora/istkQ6wLh7lH5WLKNuYMTqpxTFE0RIu1ijWXxeTyaF2F6QCCp
 2SnjgUjdyD3ZWM/dVIMAS8dATto0BJkD2t0+/5Qwx9GcD03nRRtwjUI4RQomdD+Bvg84Sw9kyZR
 8zmxPz5WtG+DjR+mlPo0dMxcgSrLhm7hzRUc1xEkVkg==
X-Received: by 2002:a05:600c:148:b0:3a3:2753:e551 with SMTP id
 w8-20020a05600c014800b003a32753e551mr2208993wmm.131.1659087549047; 
 Fri, 29 Jul 2022 02:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tbyRTL/8Lv3vfGTNM0C+yZ1EEvOWVn6mvxMInB7QddAbrbqGJfi3Vojgz6ddWBuADpj8fvMA==
X-Received: by 2002:a05:600c:148:b0:3a3:2753:e551 with SMTP id
 w8-20020a05600c014800b003a32753e551mr2208978wmm.131.1659087548815; 
 Fri, 29 Jul 2022 02:39:08 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c4f4e00b003a2d47d3051sm4608160wmq.41.2022.07.29.02.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 02:39:08 -0700 (PDT)
Date: Fri, 29 Jul 2022 05:39:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
Message-ID: <20220729053615-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-7-lingshan.zhu@intel.com>
 <20220729045039-mutt-send-email-mst@kernel.org>
 <7ce4da7f-80aa-14d6-8200-c7f928f32b48@intel.com>
 <20220729051119-mutt-send-email-mst@kernel.org>
 <50b4e7ba-3e49-24b7-5c23-d8a76c61c924@intel.com>
 <20220729052149-mutt-send-email-mst@kernel.org>
 <05bf4c84-28dd-4956-4719-3a5361d151d8@intel.com>
MIME-Version: 1.0
In-Reply-To: <05bf4c84-28dd-4956-4719-3a5361d151d8@intel.com>
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

On Fri, Jul 29, 2022 at 05:35:09PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 7/29/2022 5:23 PM, Michael S. Tsirkin wrote:
> > On Fri, Jul 29, 2022 at 05:20:17PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 7/29/2022 5:17 PM, Michael S. Tsirkin wrote:
> > > > On Fri, Jul 29, 2022 at 05:07:11PM +0800, Zhu, Lingshan wrote:
> > > > > On 7/29/2022 4:53 PM, Michael S. Tsirkin wrote:
> > > > > > On Fri, Jul 01, 2022 at 09:28:26PM +0800, Zhu Lingshan wrote:
> > > > > > > This commit fixes spars warnings: cast to restricted __le16
> > > > > > > in function vdpa_dev_net_config_fill() and
> > > > > > > vdpa_fill_stats_rec()
> > > > > > > 
> > > > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > > > ---
> > > > > > >     drivers/vdpa/vdpa.c | 6 +++---
> > > > > > >     1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > > > > index 846dd37f3549..ed49fe46a79e 100644
> > > > > > > --- a/drivers/vdpa/vdpa.c
> > > > > > > +++ b/drivers/vdpa/vdpa.c
> > > > > > > @@ -825,11 +825,11 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > > > > >     		    config.mac))
> > > > > > >     		return -EMSGSIZE;
> > > > > > > -	val_u16 = le16_to_cpu(config.status);
> > > > > > > +	val_u16 = __virtio16_to_cpu(true, config.status);
> > > > > > >     	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> > > > > > >     		return -EMSGSIZE;
> > > > > > > -	val_u16 = le16_to_cpu(config.mtu);
> > > > > > > +	val_u16 = __virtio16_to_cpu(true, config.mtu);
> > > > > > >     	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> > > > > > >     		return -EMSGSIZE;
> > > > > > Wrong on BE platforms with legacy interface, isn't it?
> > > > > > We generally don't handle legacy properly in VDPA so it's
> > > > > > not a huge deal, but maybe add a comment at least?
> > > > > Sure, I can add a comment here: this is for modern devices only.
> > > > > 
> > > > > Thanks,
> > > > > Zhu Lingshan
> > > > Hmm. what "this" is for modern devices only here?
> > > this cast, for LE modern devices.
> > I think status existed in legacy for sure, and it's possible that
> > some legacy devices backported mtu and max_virtqueue_pairs otherwise
> > we would have these fields as __le not as __virtio, right?
> yes, that's the reason why it is virtio_16 than just le16.
> 
> I may find a better solution to detect whether it is LE, or BE without a
> virtio_dev structure.
> Check whether vdpa_device->get_device_features() has VIRTIO_F_VERISON_1. If
> the device offers _F_VERSION_1, then it is a LE device,
> or it is a BE device, then we use __virtio16_to_cpu(false, config.status).
> 
> Does this look good?

No since the question is can be a legacy driver with a transitional
device.  I don't have a good idea yet. vhost has VHOST_SET_VRING_ENDIAN
and maybe we need something like this for config as well?

> > 
> > > > > > > @@ -911,7 +911,7 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> > > > > > >     	}
> > > > > > >     	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> > > > > > > -	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
> > > > > > > +	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
> > > > > > >     	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
> > > > > > >     		return -EMSGSIZE;
> > > > > > > -- 
> > > > > > > 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

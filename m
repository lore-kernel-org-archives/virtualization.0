Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49792C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD51883381;
	Thu, 22 Sep 2022 09:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD51883381
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WF00QsFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snXz-x35nsTk; Thu, 22 Sep 2022 09:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C58D8329A;
	Thu, 22 Sep 2022 09:12:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C58D8329A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC63C0033;
	Thu, 22 Sep 2022 09:12:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C92B9C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A206D4195C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:12:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A206D4195C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WF00QsFg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yR_bryUv20vm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:12:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4ED03418CD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ED03418CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663837927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ttSrBLEpKZyjQV5l0E/DFEKouaPon4bF3E/8yZe2v0g=;
 b=WF00QsFgEhPTTOo+0+LGg3gnqnC74XiMsdHS7j7AhEQSAFpsBmaz7KrP7jo18ED9pyEiRZ
 nG/mSL9tOlrGBjh94hAoTLn5gEVY/XcbZAVx+fIBBew/51ahEBw+YZbjBtyY2dSP/xJhUK
 H9yrSxO37lY67N/4kZePTJQf0oNS6xY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-FvOMb-buMnGLSlvjIwVkeA-1; Thu, 22 Sep 2022 05:12:06 -0400
X-MC-Unique: FvOMb-buMnGLSlvjIwVkeA-1
Received: by mail-wr1-f72.google.com with SMTP id
 s5-20020adfa285000000b0022ad5c2771cso3061432wra.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=ttSrBLEpKZyjQV5l0E/DFEKouaPon4bF3E/8yZe2v0g=;
 b=pMxFTOCZJVeOCAIb+lnvwhvLHLjTxb7Ed2ULun4fp/WH2e6hTFMGur5MqpAZzlZGbE
 6VpNTPN/RkzZyQ/grNsSADSQutDYM+6A03D28qWG4TT8f/MBc2z+918oIrjxgAhmWvrX
 CnZcYn7SlOwt2WfsQyCPDcrj7/BMiSj/1wg2LlG9eG0OYQnzdLTYGzvTErdC8WKrWHsL
 nh0bzm/Udd5ZZmIxKVh6y3iv5LwuWkbzyjr8r+mgYaFsZIDea1S+plbXPsmN3Wxt4M8j
 dkDjINMpWMzPYta4yGyNL26ePaom7rsdAuOabEpsT78b0gq0lLv2ocziRY0XlMovdqSD
 kgWg==
X-Gm-Message-State: ACrzQf1tzlCPUwEo3mes85/rnKtVTlIOEQGevsFF3JeZr5etqODQ6PkA
 cRGP1QyQlheG6F8XbhG/WODLzobWFhVDbkD3y/06t6k9zWt1jDGX93vjsJwmxmJ0kHaqjkDCIym
 /1XTFpbLK1GBxCwvGfpOtvrxTZbiGX8Z9Uhs+C2fzIA==
X-Received: by 2002:a05:600c:350f:b0:3b4:c5f2:4295 with SMTP id
 h15-20020a05600c350f00b003b4c5f24295mr1623646wmq.200.1663837925180; 
 Thu, 22 Sep 2022 02:12:05 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6KgIVxrv1hpbdDgKYQPaoxL+qyx5p5U+Vg1s8fE6n6+lqclJ9qu1pSVL6c46b45j52D9hXxA==
X-Received: by 2002:a05:600c:350f:b0:3b4:c5f2:4295 with SMTP id
 h15-20020a05600c350f00b003b4c5f24295mr1623620wmq.200.1663837924929; 
 Thu, 22 Sep 2022 02:12:04 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 l14-20020a5d410e000000b00228aea99efcsm4752657wrp.14.2022.09.22.02.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:12:04 -0700 (PDT)
Date: Thu, 22 Sep 2022 05:11:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20220922050639-mutt-send-email-mst@kernel.org>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922035028-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400EC129B7A2B0D86EE72F2AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "lulu@redhat.com" <lulu@redhat.com>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "gdawar@xilinx.com" <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eperezma@redhat.com" <eperezma@redhat.com>,
 "wuzongyong@linux.alibaba.com" <wuzongyong@linux.alibaba.com>,
 "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>
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

On Thu, Sep 22, 2022 at 08:01:23AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, 22 September 2022 10:53
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > 
> > On Thu, Sep 22, 2022 at 07:47:40AM +0000, Eli Cohen wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Thursday, 22 September 2022 10:30
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > > > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > >
> > > > On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > > > > > From: Jason Wang <jasowang@redhat.com>
> > > > > > Sent: Thursday, 22 September 2022 5:43
> > > > > > To: mst@redhat.com; jasowang@redhat.com
> > > > > > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > > > > > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > > > virtualization@lists.linux-foundation.org; linux-
> > kernel@vger.kernel.org;
> > > > > > eperezma@redhat.com; lingshan.zhu@intel.com;
> > gdawar@xilinx.com;
> > > > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > > > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > > > >
> > > > > > This patch implements features provisioning for vdpa_sim_net.
> > > > > >
> > > > > > 1) validating the provisioned features to be a subset of the parent
> > > > > >    features.
> > > > > > 2) clearing the features that is not wanted by the userspace
> > > > > >
> > > > > > For example:
> > > > > >
> > > > > > # vdpa mgmtdev show
> > > > > > vdpasim_net:
> > > > > >   supported_classes net
> > > > > >   max_supported_vqs 3
> > > > > >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > > > > > VERSION_1 ACCESS_PLATFORM
> > > > > >
> > > > > > 1) provision vDPA device with all features that are supported by the
> > > > > >    net simulator
> > > > > >
> > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > > > > # vdpa dev config show
> > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR
> > VERSION_1
> > > > > > ACCESS_PLATFORM
> > > > > >
> > > > > > 2) provision vDPA device with a subset of the features
> > > > > >
> > > > > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > > > > > 0x300020000
> > > > >
> > > > > How about "features_mask" instead of "device_features"? Could avoid
> > > > confusion.
> > > >
> > > > Not sure I agree.
> > > > features_mask to me would mean it is & with features. Not the case here.
> > > >
> > >
> > >
> > > See the code below
> > >
> > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > vdpa_mgmt_dev *mdev, const char *name,
> > >  	dev_attr.work_fn = vdpasim_net_work;
> > >  	dev_attr.buffer_size = PAGE_SIZE;
> > >
> > > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > +		if (config->device_features &
> > > +		    ~dev_attr.supported_features)
> > > +			return -EINVAL;
> > > +		dev_attr.supported_features &=
> > > +			 config->device_features;
> > > +	}
> > > +
> > 
> > Oh I didn't notice. It's unnecessary, isn't it?
> > Can just equivalently be
> > 
> > 	dev_attr.supported_features = config->device_features;
> > 
> > right?
> > 
> 
> I don't think so. You want to mask the set of features that the device will offer but you cannot dictate it.

Sure, but it's already a given because device_features is a subset of
supported_features. Observe:

After this line:

         if (config->device_features &
            ~dev_attr.supported_features)
                return -EINVAL;

we know that config->device_features & ~dev_attr.supported_features
is 0.

Therefore logically

config->device_features  == 
    (config->device_features & ~dev_attr.supported_features) |
    (config->device_features & dev_attr.supported_features); 

it follows that

config->device_features  == 
    0 |
    (config->device_features & dev_attr.supported_features); 

and finally

config->device_features  == 
    (config->device_features & dev_attr.supported_features); 


now

		dev_attr.supported_features &=
			 config->device_features;

is equivalent to

		dev_attr.supported_features =
    (config->device_features & dev_attr.supported_features); 

and therefore to

		dev_attr.supported_features = config->device_features;



> > 
> > > > > > # vdpa dev config show
> > > > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > > > >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > > > >
> > > > > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > index 886449e88502..a9ba02be378b 100644
> > > > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > > > > vdpa_mgmt_dev *mdev, const char *name,
> > > > > >  	dev_attr.work_fn = vdpasim_net_work;
> > > > > >  	dev_attr.buffer_size = PAGE_SIZE;
> > > > > >
> > > > > > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > > > +		if (config->device_features &
> > > > > > +		    ~dev_attr.supported_features)
> > > > > > +			return -EINVAL;
> > > > > > +		dev_attr.supported_features &=
> > > > > > +			 config->device_features;
> > > > > > +	}
> > > > > > +
> > > > > >  	simdev = vdpasim_create(&dev_attr);
> > > > > >  	if (IS_ERR(simdev))
> > > > > >  		return PTR_ERR(simdev);
> > > > > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > > > > >  	.id_table = id_table,
> > > > > >  	.ops = &vdpasim_net_mgmtdev_ops,
> > > > > >  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > > > > -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > > > > +			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > > > > +		             1 << VDPA_ATTR_DEV_FEATURES),
> > > > > >  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > > > > >  	.supported_features = VDPASIM_NET_FEATURES,
> > > > > >  };
> > > > > > --
> > > > > > 2.25.1
> > > > >
> > >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

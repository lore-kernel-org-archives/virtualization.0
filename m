Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D87C6FA8B
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 07:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7B944053C;
	Thu, 22 Sep 2022 07:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7B944053C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ejhzTfZe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tWDVhTU6qE1V; Thu, 22 Sep 2022 07:53:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 623EB400FC;
	Thu, 22 Sep 2022 07:53:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 623EB400FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 391DEC0033;
	Thu, 22 Sep 2022 07:53:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58611C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F5E5404B1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:53:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F5E5404B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KQZP5NDyLlX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31C24400FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31C24400FC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663833219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CiB9cgwGik9cVTleJNmc31WLxMKDN3Tl6RLpLoNrDfg=;
 b=ejhzTfZeYATSouSV5/RZizn53xEB7JRgVPO6+arg66iG1pup+XNstPGnmkbw/1tVzL6vlx
 ihISF6P3aJwPoOP/HRLXhX33iI4vEFETNQnfEaXIEQf0aSTaUx4AgDJte/ZufqC13U2Owh
 V0A9vOtjK8YQtW2UmA2CSWh4iJb8H24=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-558-ebqyYkAiN6uPiZzwgAaRlQ-1; Thu, 22 Sep 2022 03:53:35 -0400
X-MC-Unique: ebqyYkAiN6uPiZzwgAaRlQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 n32-20020a05600c3ba000b003b5054c71faso239611wms.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 00:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=CiB9cgwGik9cVTleJNmc31WLxMKDN3Tl6RLpLoNrDfg=;
 b=ZjQHGCvTklWXzIZoJfPdD69SUbdcn83AHeGkXH/u44l7XiTd/hoS/XkvdXFmMFWo6z
 WC7pOynKer7o0ajzNzgSgH1BUdmsu7br4kX6B//lf2Fyl60iCHlcHhCpYBPSKjuLIPWv
 Fvg+QBsUMBTw32N2pZLv3utc5lcy0B4q8u+d9vl1rYec0Mqdy3wx47Jumx0/byKcGAcV
 kgPrzGyERmt9umWnr5+MdIJUpSUv467KHyI/GnVUQ3OdPduRngxnhomHzN3XPtSFhf6D
 1ADhGRYwNysvSxrXGhwZBCvOPTybzwio5NNlFpxP9aSf7nFd3pEVFg34SZIbdN9HeSq0
 2A9g==
X-Gm-Message-State: ACrzQf1LXYG6L39bkaUfxzSHS3PYMaEu0s3EzbiL6FIPlaooHjC5S8Nw
 LoZ+2Bv1+OOItIl9KzYCeSg7cAdO8Yw4zvvgAOOD6S/2DJkA5IicYwoLph+HLq86sZ0xX4Z3469
 eCEmfwvX0umMmMRLI5x+qwlLZccHrWLUElJdTUfGDNA==
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id
 r11-20020a1c440b000000b003b3330d88d8mr1394206wma.31.1663833214621; 
 Thu, 22 Sep 2022 00:53:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5TzlWYRFYY9faCipZv1rcrv69J4gEWeKFLl4r9bcrqQkV1vatXxBR056G+/UGoKmCZVb/+mA==
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id
 r11-20020a1c440b000000b003b3330d88d8mr1394186wma.31.1663833214328; 
 Thu, 22 Sep 2022 00:53:34 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 q7-20020a05600c2e4700b003b31fc77407sm4865602wmf.30.2022.09.22.00.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 00:53:33 -0700 (PDT)
Date: Thu, 22 Sep 2022 03:53:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20220922035028-mutt-send-email-mst@kernel.org>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220922032858-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB5400D6550D2253E9964260F8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Thu, Sep 22, 2022 at 07:47:40AM +0000, Eli Cohen wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, 22 September 2022 10:30
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Jason Wang <jasowang@redhat.com>; si-wei.liu@oracle.com; Parav
> > Pandit <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > 
> > On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Thursday, 22 September 2022 5:43
> > > > To: mst@redhat.com; jasowang@redhat.com
> > > > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > > > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > > > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > > > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > > > lulu@redhat.com; xieyongji@bytedance.com
> > > > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > > >
> > > > This patch implements features provisioning for vdpa_sim_net.
> > > >
> > > > 1) validating the provisioned features to be a subset of the parent
> > > >    features.
> > > > 2) clearing the features that is not wanted by the userspace
> > > >
> > > > For example:
> > > >
> > > > # vdpa mgmtdev show
> > > > vdpasim_net:
> > > >   supported_classes net
> > > >   max_supported_vqs 3
> > > >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > > > VERSION_1 ACCESS_PLATFORM
> > > >
> > > > 1) provision vDPA device with all features that are supported by the
> > > >    net simulator
> > > >
> > > > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > > > # vdpa dev config show
> > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1
> > > > ACCESS_PLATFORM
> > > >
> > > > 2) provision vDPA device with a subset of the features
> > > >
> > > > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > > > 0x300020000
> > >
> > > How about "features_mask" instead of "device_features"? Could avoid
> > confusion.
> > 
> > Not sure I agree.
> > features_mask to me would mean it is & with features. Not the case here.
> > 
> 
> 
> See the code below
> 
> @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  	dev_attr.work_fn = vdpasim_net_work;
>  	dev_attr.buffer_size = PAGE_SIZE;
>  
> +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (config->device_features &
> +		    ~dev_attr.supported_features)
> +			return -EINVAL;
> +		dev_attr.supported_features &=
> +			 config->device_features;
> +	}
> +

Oh I didn't notice. It's unnecessary, isn't it?
Can just equivalently be

	dev_attr.supported_features = config->device_features;

right?


> > > > # vdpa dev config show
> > > > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> > > >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > > >
> > > > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > index 886449e88502..a9ba02be378b 100644
> > > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > > > vdpa_mgmt_dev *mdev, const char *name,
> > > >  	dev_attr.work_fn = vdpasim_net_work;
> > > >  	dev_attr.buffer_size = PAGE_SIZE;
> > > >
> > > > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > > > +		if (config->device_features &
> > > > +		    ~dev_attr.supported_features)
> > > > +			return -EINVAL;
> > > > +		dev_attr.supported_features &=
> > > > +			 config->device_features;
> > > > +	}
> > > > +
> > > >  	simdev = vdpasim_create(&dev_attr);
> > > >  	if (IS_ERR(simdev))
> > > >  		return PTR_ERR(simdev);
> > > > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> > > >  	.id_table = id_table,
> > > >  	.ops = &vdpasim_net_mgmtdev_ops,
> > > >  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > > > -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > > > +			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > > > +		             1 << VDPA_ATTR_DEV_FEATURES),
> > > >  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> > > >  	.supported_features = VDPASIM_NET_FEATURES,
> > > >  };
> > > > --
> > > > 2.25.1
> > >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

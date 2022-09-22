Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E914C6FA8B
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 07:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 131A9416E8;
	Thu, 22 Sep 2022 07:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 131A9416E8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cDEQZblb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nmrHHbl-ZV5Y; Thu, 22 Sep 2022 07:30:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2ACAE416F2;
	Thu, 22 Sep 2022 07:30:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2ACAE416F2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB055C0033;
	Thu, 22 Sep 2022 07:30:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FD51C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34F8F416F2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:30:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34F8F416F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TgA_Pv9qW9yx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:30:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE55A416E8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE55A416E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 07:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663831798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kbup5Fpy9jSUW1POLJvMYeKDSQiZ2Bk6VOpsIsxqqKs=;
 b=cDEQZblbZSAYSS+SDE8LWGESjpo+6a4Ex5HDCmSRONckygy00dz22hLVSpdgBd3/cNvEe+
 aijybu/FiZu8uySlUVWigo/C/OceUf/ZniSYIcLoxfol8X6rXmL2R/+YRmh2UqnrwcJVuQ
 TTfVICzsmV2x+qgcmhf1303PEDGNWpc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-481-4iLrWH5mOM63NPoXBkPEAw-1; Thu, 22 Sep 2022 03:29:57 -0400
X-MC-Unique: 4iLrWH5mOM63NPoXBkPEAw-1
Received: by mail-wm1-f70.google.com with SMTP id
 l15-20020a05600c4f0f00b003b4bec80edbso3677603wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 00:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=Kbup5Fpy9jSUW1POLJvMYeKDSQiZ2Bk6VOpsIsxqqKs=;
 b=P/zExUQpfuHimwiBaHc/JEkuhEZtjkdF76C9JR0PwY7+it6vNeLWou2RKZqKtpqwZ6
 azLSWIvTcoHnzvPO+I9tuhbe6BGxIKu/0T40kGnMCfcLWoQXB6A2QZknwCXK2Fi02OB7
 5S53uSxL5ufEbuIwG20STrMnLhG8PFcc8ZXP0mBeEjjjAzy1LnD/GqHinKrQj4CAp3nL
 HCUwqHhHYJBgYMdMEAxULoeM3PdTT071px4yNq3xRqpv0ETItovZMCDAnOoFAJXlxpxA
 M1tizASg/ipwyoemMyOzuZkwdBkYPzBT6GnXWu3KmWVrVbSBWUa8GBjbAjX7zg8dDs+X
 F2sg==
X-Gm-Message-State: ACrzQf1l4/6zrmdxtw0YCGjmBrs884lr43qj5pqQHhjuqVLhSoT68RLz
 eGvL04I1Okq9JyAO/nVhh6zeO/FSEodi3RQymOLSp2+PhQe5bQRAtKUjhV7MUmrsKaBfeq5N+DV
 tEpctOHtM6vE+h3z7+c/W215CKzVFa/SE7GTmOT18jw==
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id
 p21-20020a05600c359500b003b4837898d2mr1351507wmq.64.1663831796652; 
 Thu, 22 Sep 2022 00:29:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6d3sPnC0/xR5T1IuwaFJ8oueiIl2rfbv0L00UmB89dILcchBGOD5u01PouOpp4WE/e99xU+A==
X-Received: by 2002:a05:600c:3595:b0:3b4:8378:98d2 with SMTP id
 p21-20020a05600c359500b003b4837898d2mr1351482wmq.64.1663831796418; 
 Thu, 22 Sep 2022 00:29:56 -0700 (PDT)
Received: from redhat.com ([2.55.47.213]) by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c358400b003b4935f04a4sm6386230wmq.5.2022.09.22.00.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 00:29:55 -0700 (PDT)
Date: Thu, 22 Sep 2022 03:29:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20220922032858-mutt-send-email-mst@kernel.org>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
 <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54005C65A85B32063A5E17A8AB4E9@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Thu, Sep 22, 2022 at 05:13:59AM +0000, Eli Cohen wrote:
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, 22 September 2022 5:43
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; si-wei.liu@oracle.com; Parav Pandit
> > <parav@nvidia.com>; wuzongyong@linux.alibaba.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > eperezma@redhat.com; lingshan.zhu@intel.com; gdawar@xilinx.com;
> > lulu@redhat.com; xieyongji@bytedance.com
> > Subject: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
> > 
> > This patch implements features provisioning for vdpa_sim_net.
> > 
> > 1) validating the provisioned features to be a subset of the parent
> >    features.
> > 2) clearing the features that is not wanted by the userspace
> > 
> > For example:
> > 
> > # vdpa mgmtdev show
> > vdpasim_net:
> >   supported_classes net
> >   max_supported_vqs 3
> >   dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT
> > VERSION_1 ACCESS_PLATFORM
> > 
> > 1) provision vDPA device with all features that are supported by the
> >    net simulator
> > 
> > # vdpa dev add name dev1 mgmtdev vdpasim_net
> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1
> > ACCESS_PLATFORM
> > 
> > 2) provision vDPA device with a subset of the features
> > 
> > # vdpa dev add name dev1 mgmtdev vdpasim_net device_features
> > 0x300020000
> 
> How about "features_mask" instead of "device_features"? Could avoid confusion.

Not sure I agree.
features_mask to me would mean it is & with features. Not the case here.

> > # vdpa dev config show
> > dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
> >   negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
> > 
> > Reviewed-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index 886449e88502..a9ba02be378b 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct
> > vdpa_mgmt_dev *mdev, const char *name,
> >  	dev_attr.work_fn = vdpasim_net_work;
> >  	dev_attr.buffer_size = PAGE_SIZE;
> > 
> > +	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +		if (config->device_features &
> > +		    ~dev_attr.supported_features)
> > +			return -EINVAL;
> > +		dev_attr.supported_features &=
> > +			 config->device_features;
> > +	}
> > +
> >  	simdev = vdpasim_create(&dev_attr);
> >  	if (IS_ERR(simdev))
> >  		return PTR_ERR(simdev);
> > @@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> >  	.id_table = id_table,
> >  	.ops = &vdpasim_net_mgmtdev_ops,
> >  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
> > -			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
> > +			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> > +		             1 << VDPA_ATTR_DEV_FEATURES),
> >  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> >  	.supported_features = VDPASIM_NET_FEATURES,
> >  };
> > --
> > 2.25.1
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

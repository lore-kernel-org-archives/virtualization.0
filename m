Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F0DC6FA90
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 09:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B8434053C;
	Thu, 22 Sep 2022 09:23:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B8434053C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bnDEs5U+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3f1gpfA_A8C; Thu, 22 Sep 2022 09:23:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E59934017A;
	Thu, 22 Sep 2022 09:23:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E59934017A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC7DCC0033;
	Thu, 22 Sep 2022 09:23:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82F36C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 571D44051D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 571D44051D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PRksMEGwy_Ot
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:23:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6814140385
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6814140385
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663838584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SuTHYJVFAUSisqUYJ7aEiJ6bas6gBkFhem0cKwxhc6c=;
 b=bnDEs5U+mxBmG1Mog+lnfwm/MB7hJ/mEKGaJrRkTSKtNfHiPG0yaDNRTl4eERBg3Wwjl6F
 XhzyzcfEVtXCno/M/h3VC69Wr9yqP4JLzTrEqY8MZssbPxH2kS8tkIm4kN2gWoIdxLMTmt
 AcE42SDcgqo8pTaTedfUeqKSqSINArE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-Vd1Vw7FbMWGJDnokBe2roA-1; Thu, 22 Sep 2022 05:23:00 -0400
X-MC-Unique: Vd1Vw7FbMWGJDnokBe2roA-1
Received: by mail-qk1-f197.google.com with SMTP id
 bl17-20020a05620a1a9100b006cdf19243acso6161623qkb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 02:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=SuTHYJVFAUSisqUYJ7aEiJ6bas6gBkFhem0cKwxhc6c=;
 b=tWXlZJXCAdUa4Xi4IqHGsypLDsW8zxZg3/ZxlNwzidRjc9GSROLxAQ7snXyCElRPc4
 6ptZdXHNITmdrrITUxomfXtfXkyMRz3k/aj+6YXrW58h8eHEGzn+nLFTZ3++JQJCbI+3
 /iEL1BHOd5OgZRY78SFCs3B7kr6BMUI4qSL39stH1xDxEtIvaKDosCZ0q5+i9IYOBoOw
 tQ1MJoAlEJN77eVHK9VHsMKXxqQzUGiXeVlhx9eAGVsgB9YYWBpWn6wpK3x1/1yIDyl3
 A0SolXv2Q0DYh2t6STesC6kvqiimfSiXFu0i5+1+Q/Qz9xGbIBEh1yBaw0WB+j/o9Aa/
 c1og==
X-Gm-Message-State: ACrzQf2aOtI3hffSwWcFKi1W7xyYEgkA8Z+1ADpj8NHD8Ft7NNMputVV
 au0A6kcOQY+IXlHPsbfMsgBcG/D5u92ibfOJebyhZujni6hK7uxr1XBdYwew79dE9p56wjToLmT
 /6RKrnwyxXAkSJsVIiuNRygOaFNX+G3vcAYkHZnqtaA==
X-Received: by 2002:ac8:5d89:0:b0:35b:b58a:2bcb with SMTP id
 d9-20020ac85d89000000b0035bb58a2bcbmr1954234qtx.273.1663838580263; 
 Thu, 22 Sep 2022 02:23:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM719h5lWWPYiNaxVsN/CPer8q5YrppAFE1Z2dDMsAoQmzX/B3T49d7wpsslOfN8ulseMZmieg==
X-Received: by 2002:ac8:5d89:0:b0:35b:b58a:2bcb with SMTP id
 d9-20020ac85d89000000b0035bb58a2bcbmr1954229qtx.273.1663838580053; 
 Thu, 22 Sep 2022 02:23:00 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 q20-20020a05620a0d9400b006b919c6749esm3689379qkl.91.2022.09.22.02.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 02:22:59 -0700 (PDT)
Date: Thu, 22 Sep 2022 11:22:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 2/3] vdpa_sim_net: support feature provisioning
Message-ID: <20220922092250.pj26iutmywlemvbm@sgarzare-redhat>
References: <20220922024305.1718-1-jasowang@redhat.com>
 <20220922024305.1718-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220922024305.1718-3-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, wuzongyong@linux.alibaba.com, elic@nvidia.com,
 eperezma@redhat.com, lingshan.zhu@intel.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Sep 22, 2022 at 10:43:04AM +0800, Jason Wang wrote:
>This patch implements features provisioning for vdpa_sim_net.
>
>1) validating the provisioned features to be a subset of the parent
>   features.
>2) clearing the features that is not wanted by the userspace
>
>For example:
>
># vdpa mgmtdev show
>vdpasim_net:
>  supported_classes net
>  max_supported_vqs 3
>  dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
>1) provision vDPA device with all features that are supported by the
>   net simulator
>
># vdpa dev add name dev1 mgmtdev vdpasim_net
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features MTU MAC CTRL_VQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
>2) provision vDPA device with a subset of the features
>
># vdpa dev add name dev1 mgmtdev vdpasim_net device_features 0x300020000
># vdpa dev config show
>dev1: mac 00:00:00:00:00:00 link up link_announce false mtu 1500
>  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index 886449e88502..a9ba02be378b 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -254,6 +254,14 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> 	dev_attr.work_fn = vdpasim_net_work;
> 	dev_attr.buffer_size = PAGE_SIZE;
>
>+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>+		if (config->device_features &
>+		    ~dev_attr.supported_features)
>+			return -EINVAL;
>+		dev_attr.supported_features &=
>+			 config->device_features;
>+	}
>+

How about doing this inside vdpasim_create()?

That way we support this feature in all simulators.

Thanks,
Stefano

> 	simdev = vdpasim_create(&dev_attr);
> 	if (IS_ERR(simdev))
> 		return PTR_ERR(simdev);
>@@ -294,7 +302,8 @@ static struct vdpa_mgmt_dev mgmt_dev = {
> 	.id_table = id_table,
> 	.ops = &vdpasim_net_mgmtdev_ops,
> 	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>-			     1 << VDPA_ATTR_DEV_NET_CFG_MTU),
>+			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
>+		             1 << VDPA_ATTR_DEV_FEATURES),
> 	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
> 	.supported_features = VDPASIM_NET_FEATURES,
> };
>-- 
>2.25.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

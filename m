Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C054C77B7C
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 16:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B40C614FC;
	Wed, 10 May 2023 16:20:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B40C614FC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xQhhCDip
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EePmnJ4Tmf_d; Wed, 10 May 2023 16:20:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48BD561526;
	Wed, 10 May 2023 16:20:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48BD561526
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25C7FC0036;
	Wed, 10 May 2023 16:20:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E03E3C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC5F041D85
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:20:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC5F041D85
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=xQhhCDip
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dNk8H5KcfKpV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:20:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 12A8941D77
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12A8941D77
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 16:20:45 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f42769a0c1so34601315e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1683735644; x=1686327644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Obt8pVoKfz1tH1SqzwUaz8mcp0zUYaijmYQeIqh31d0=;
 b=xQhhCDipjC0f0UqWuzN265VPFF8YOekzAEDhbBPlCrQomMsy6nQOEcAH9GQipyo2Af
 3AKt5rhNWfyuHm4wiTbygvVCyRK+eFVelkvq9YI+Pgocnu0/G52koiBX+Dy+LG04UPLl
 8Z1IGWZx3wxr+FZ2+zMD2V85UMGdtDqpxP0FOOOdS3iskdzGS6bxS2pnY6wofeuxiPmz
 oqYmHIH5dO6ZNxIYXD55A+uI3kXeUSDUfkBIjc/EtWy4YCGYlFK2kMzkEDyX5Hk6yRhp
 fKTKtVEh+U3EUYvyfFNny7xhgFxK4P8NlXKpup/3WuG7yMpAnk+DCFBVLTIq+fK/9JOY
 oxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683735644; x=1686327644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Obt8pVoKfz1tH1SqzwUaz8mcp0zUYaijmYQeIqh31d0=;
 b=AHdgJDq6yx+bknUYBOOlSqvf2AUYS/kZX8ILw3j+SJETmE34z1k2ozivgLrDMTM5Te
 ONQfIB+siBm3sbUNcC1dCEl/9OjDd8nvy5qdYJZdq4GIQI8hca8TOmsrGxLAHfeSws3A
 3ietAhusm3qvQ5e61Kq6SLWP0+jL+7Mclbrr9nbert/RsG63kH04AqCF4oFhjiaoVSRB
 3DDTGH4++K/lNhdHv8DYLt/CptlHIrJwzlCE/0v0KQuGTeTKuRbjOYMmevj0mbiP3le1
 DoZ0hOoZTiFJiRTVEWbPijaTv1HGhaO+bAEW0z550BK6VM+zcOMp+WmJptfQwpzdcA/G
 8QWA==
X-Gm-Message-State: AC+VfDyfqVf6KVxsdNOVBwnOLEtVinC5m4uFMaAxL1xF5qDNstlFDXg+
 6S2Qr4rNWXYtFeXW87D7W8UqEg==
X-Google-Smtp-Source: ACHHUZ5fATrqXEHKAu4umZysP4EZQVdpN9F4L+0yZryOi2EdhCPvsVeCsvyhDKqUSUhwrZ3qx+QjfQ==
X-Received: by 2002:a05:600c:2201:b0:3f4:253b:92ae with SMTP id
 z1-20020a05600c220100b003f4253b92aemr7317004wml.0.1683735644170; 
 Wed, 10 May 2023 09:20:44 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bc5d7000000b003ee74c25f12sm23222570wmk.35.2023.05.10.09.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 May 2023 09:20:43 -0700 (PDT)
Date: Wed, 10 May 2023 17:20:34 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230510162034.GA3390634@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <e58c48e0-6339-41ec-e65b-e3104c65bb81@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e58c48e0-6339-41ec-e65b-e3104c65bb81@redhat.com>
Cc: akihiko.odaki@daynix.com, will@kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 robin.murphy@arm.com
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

On Wed, May 10, 2023 at 05:37:22PM +0200, Eric Auger wrote:
> Hi Jean,
> 
> On 4/14/23 17:07, Jean-Philippe Brucker wrote:
> > When an endpoint is released, for example a PCIe VF is disabled or a
> > function hot-unplugged, it should be detached from its domain. Send a
> > DETACH request.
> >
> > Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> > Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 5b8fe9bfa9a5..3d3d4462359e 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >  	return 0;
> >  }
> >  
> > +static void viommu_detach_dev(struct viommu_endpoint *vdev)
> > +{
> > +	int i;
> > +	struct virtio_iommu_req_detach req;
> > +	struct viommu_domain *vdomain = vdev->vdomain;
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
> > +
> > +	if (!vdomain)
> > +		return;
> > +
> > +	req = (struct virtio_iommu_req_detach) {
> > +		.head.type	= VIRTIO_IOMMU_T_DETACH,
> > +		.domain		= cpu_to_le32(vdomain->id),
> > +	};
> > +
> > +	for (i = 0; i < fwspec->num_ids; i++) {
> > +		req.endpoint = cpu_to_le32(fwspec->ids[i]);
> > +		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
> > +	}
> just a late question: don't you need to decrement vdomain's nr_endpoints?
> 

Ah yes, I'll fix that, thank you. I think attach() could use some cleanup
as well: if the request fails then we should keep the nr_endpoints
reference on the previous domain. But that's less urgent.

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

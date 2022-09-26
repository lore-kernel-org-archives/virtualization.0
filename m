Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4522C07E9D
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 12:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F45C60F91;
	Mon, 26 Sep 2022 12:23:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F45C60F91
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=8STw8MnS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4VfUfARG1qdE; Mon, 26 Sep 2022 12:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C18360F6F;
	Mon, 26 Sep 2022 12:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C18360F6F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9E6DC0032;
	Mon, 26 Sep 2022 12:23:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D4FFC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ABC660F86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:23:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5ABC660F86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PYqMRpun3ezv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:23:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2470A60F8F
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2470A60F8F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 12:23:08 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id D942A40735;
 Mon, 26 Sep 2022 14:23:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1664194987;
 bh=DwscMU+GZ+AeXouVGc8h0vEjh2jlqGirwv9sMdq7tsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=8STw8MnSA0vAVtkrtSmDF4+3u6QSLslcq6Xos5c6BmVi2sGIcexptmY1qBKF+PFU6
 bwYuW4DOVStwI+tWdsF+XG2x4884iYGuP9q38l2CX1WX0M1+PVV+Rva59Cc0/A4l1F
 WgDtM0LRo0FxDvtTvzrrG1djmPU5AzJ6SjwDfyP9vDSN7L04lUGovAjNEMnlEE1Hi4
 lYfrTK7DMdVUzzJNas/Z4FvIiET7Cy0awBlNiQtpUlugi0haBDLBrU4hwevC2j6mDt
 iI3i+WFV531V6RNsmJHgS2+MjucxbD8bTDHvjhL1ewAS0KBhGs0F4s9d9ID+AD4o8a
 C1RtC8FyC38tw==
Date: Mon, 26 Sep 2022 14:23:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v6 0/5] Define EINVAL as device/domain incompatibility
Message-ID: <YzGZqXCuw6yoXBla@8bytes.org>
References: <cover.1663899032.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1663899032.git.nicolinc@nvidia.com>
Cc: quic_saipraka@quicinc.com, virtualization@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 jean-philippe@linaro.org, zhang.lyra@gmail.com, jon@solid-run.com,
 jonathanh@nvidia.com, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, jgg@nvidia.com, yangyingliang@huawei.com,
 orsonzhai@gmail.com, dwmw2@infradead.org, linux-arm-msm@vger.kernel.org,
 vdumpa@nvidia.com, christophe.jaillet@wanadoo.fr,
 baolin.wang@linux.alibaba.com, thunder.leizhen@huawei.com,
 matthias.bgg@gmail.com, tglx@linutronix.de, yong.wu@mediatek.com,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, linux-mediatek@lists.infradead.org,
 quic_jjohnson@quicinc.com, baolu.lu@linux.intel.com
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

Hi Nicolin,

On Fri, Sep 23, 2022 at 12:16:29AM -0700, Nicolin Chen wrote:
> This series is to replace the previous EMEDIUMTYPE patch in a VFIO series:
> https://lore.kernel.org/kvm/Yxnt9uQTmbqul5lf@8bytes.org/

\o/

> Nicolin Chen (5):
>   iommu/amd: Drop unnecessary checks in amd_iommu_attach_device()
>   iommu: Add return value rules to attach_dev op and APIs
>   iommu: Regulate EINVAL in ->attach_dev callback functions
>   iommu: Use EINVAL for incompatible device/domain in ->attach_dev
>   iommu: Propagate return value in ->attach_dev callback functions

This looks good to me, but I'd like to have the SMMU people have a look
at patch 4. And I think it is too late for this to make it into 6.1, so
please re-send after 6.1-rc1 is out.

Thanks,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

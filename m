Return-Path: <SRS0=jkwN=O7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45584C433F5
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 09:17:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7CB60EB6
	for <virtualization@archiver.kernel.org>; Mon, 11 Oct 2021 09:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD7CB60EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A058C403F8;
	Mon, 11 Oct 2021 09:17:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1GP7sJRUYVRt; Mon, 11 Oct 2021 09:16:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 424C2403EA;
	Mon, 11 Oct 2021 09:16:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1259BC000F;
	Mon, 11 Oct 2021 09:16:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DE31C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1219F607B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0c8okZV4ncH
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:16:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B7E660723
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 09:16:56 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id v17so53825353wrv.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Oct 2021 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=0nkxjPYEpK6G/BSPxshK+If3Vx5Dign77+8NPOgdp5A=;
 b=o5bhT6O7zjOThtxY/SJmo4tsUFG2/zdzUm67PXqH2uM3Esme6jlzv21/ETV6z4c7RR
 wzk8ZM9TcGX+XY6xe2WX3EPIG5a8uot5ytWGlgBDE+cXGvtHArsho3kAovfIYHDvBBMT
 EmqoNKrLNr5HvSpSfSUoAD+YZa/+XjXLE7bIok+S+QqWx699qRA/778xoMcmdT8TNzQi
 9+Ed+xbGf0D/DcsbK7tM/jj8umMxvEla2ovIJULkjMPNVZ9uo1HYBO0KieMZguX13pfQ
 xNVC1AxlTATx4mu/mfVe6OYfPdJ3kiaOfm6cOUOakTMFchkCtVp7AKjIxMPCOlagfxXg
 7LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0nkxjPYEpK6G/BSPxshK+If3Vx5Dign77+8NPOgdp5A=;
 b=2MJ8vnjhK9lwYn2c7mWwISfdcyzrknCjJw7gX7NLD+V/r7XBZR2t+ggUVPO/MYxLyU
 /wCIE1nSHAcKDe7IDO2ujk65DvK6YngdTqjRa7iz3MUORKaO5BvKa5LowmmZgEt3CPYg
 46CWaT+kP9tTnkqaxekaALW50WiHFRBVaS+CBJQwAmFKtGVdcxNexfY8thiEwHT0FDUV
 bWuCBk/QUReOBAtHON6EfoAkYwa04Pxya2DVEA+axxEfGTFm0Gpau+iFqeDWFpzO9krM
 hthy9qnV+6WVaWPEWv0rs7mkzuJeSxWsZMUlFgQ/8VLjBBqfBWufOcNAFJekCPdxyW+8
 oVBw==
X-Gm-Message-State: AOAM5322b6KVSJLor7mtuiwm7DlvaQNqRt7anVJ328ncnXTpOkIVpGWx
 oaVYNFwFgT4INUBYf9janm95fA==
X-Google-Smtp-Source: ABdhPJzmZPpxlzZgyZ5KgwS2WYv6prD2WVEkkWH0I0HXdlYIksxaPY0vrb+dREOxa4LLg5+rfZGlMQ==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr23299307wrg.327.1633943814314; 
 Mon, 11 Oct 2021 02:16:54 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id v185sm15278013wme.35.2021.10.11.02.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Oct 2021 02:16:53 -0700 (PDT)
Date: Mon, 11 Oct 2021 10:16:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 03/11] iommu/virtio: Handle incoming page faults
Message-ID: <YWQA8JLXfmQ4DMXv@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-4-vivek.gautam@arm.com>
 <YUoCTV6WYxxE10qj@myrica>
 <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFp+6iEM7K8YOnQ4vSNoM+HuHQ-7pr=G3aui-77dGipyJ0+RjQ@mail.gmail.com>
Cc: mst@redhat.com, Will Deacon <will.deacon@arm.com>,
 open list <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Vivek,

On Mon, Oct 11, 2021 at 01:41:15PM +0530, Vivek Gautam wrote:
> > > +     list_for_each_entry(ep, &viommu->endpoints, list) {
> > > +             if (ep->eid == endpoint) {
> > > +                     vdev = ep->vdev;
> 
> I have a question here though -
> Is endpoint-ID unique across all the endpoints available per 'viommu_dev' or
> per 'viommu_domain'?
> If it is per 'viommu_domain' then the above list is also incorrect.
> As you pointed to in the patch [1] -
> [PATCH RFC v1 02/11] iommu/virtio: Maintain a list of endpoints served
> by viommu_dev
> I am planning to add endpoint ID into a static global xarray in
> viommu_probe_device() as below:
> 
>         vdev_for_each_id(i, eid, vdev) {
>                 ret = xa_insert(&viommu_ep_ids, eid, vdev, GFP_KERNEL);
>                 if (ret)
>                         goto err_free_dev;
>         }
> 
> and replace the above list traversal as below:
> 
>                 xa_lock_irqsave(&viommu_ep_ids, flags);
>                 xa_for_each(&viommu_ep_ids, eid, vdev) {
>                         if (eid == endpoint) {
>                                 ret =
> iommu_report_device_fault(vdev->dev, &fault_evt);
>                                 if (ret)
>                                         dev_err(vdev->dev, "Couldn't
> handle page request\n");
>                         }
>                 }
>                 xa_unlock_irqrestore(&viommu_ep_ids, flags);
> 
> But using a global xarray would also be incorrect if the endpointsID are global
> across 'viommu_domain'.
> 
> I need to find the correct 'viommu_endpoint' to call iommu_report_device_fault()
> with the correct device.

The endpoint IDs are only unique across viommu_dev, so a global xarray
wouldn't work but one in viommu_dev would. In vdomain it doesn't work
either because we can't get to the domain from the fault handler without
first finding the endpoint

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

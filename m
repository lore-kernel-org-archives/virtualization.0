Return-Path: <SRS0=ulPH=O2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1937DC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 09:55:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC48461139
	for <virtualization@archiver.kernel.org>; Wed,  6 Oct 2021 09:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC48461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BBA5608D2;
	Wed,  6 Oct 2021 09:55:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iMoJ_SQaZ0RV; Wed,  6 Oct 2021 09:55:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1802D60B8D;
	Wed,  6 Oct 2021 09:55:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0456C0011;
	Wed,  6 Oct 2021 09:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67172C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 09:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 486FB60B8D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 09:55:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YD5pxfknmvCa
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 09:55:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 723C8608D2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Oct 2021 09:55:39 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id m22so7124985wrb.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Oct 2021 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=53P0MWqxHQf69YIQTg7++jhQaclFdr/J2LBfnT7Jxag=;
 b=SyqmL0KIwaYYoAnvxjN3cUgFEI9q0HKr8Ar/pWsMkn9kMDGzeCkwbxNr5N5Kc/UWS7
 qniK5NqdpFiEqx+FSrnniWhRiB36WlBCYKNtzy05dCMjzUyTW9QFNaEZ/f4z9YXH30MO
 IEn+GlPNPbZiWY/3MJ/uJXvLCXC/DyO5mBNQTIQJy/+FRS6AC8YCO7GzAia1tIaS52In
 ZmFzmtuOnaCJYRjB58b+zDAHwub8BWctoYeAeSgPq+1yuZ1lQzB34HrNc4dGrF/+kr4F
 r46OH/pMw/2AQQASBIOLJueH5xJxURZBBbE0SHmAeD1lDV/X9+qdhjVkuRQXODpRNfTK
 jVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=53P0MWqxHQf69YIQTg7++jhQaclFdr/J2LBfnT7Jxag=;
 b=u8NF7hjS0/QfubWuLHCbmecCZGdeVOxKXmXfWplLfQxH8x2+KpkGQj3yhEV0Y+9tWE
 B4wcmNNoOx9uYA50jSU9d0/O5Qhfazc84/DPdIZMd6EdAlvfAaxxbBZ+aWDXbJ508vDS
 vmIPomCYZiZQtoDjCD/HsdooReF7QAS28hrUkQ/R4uVxwMEpjigbSdSt/zjIkU4NyfTV
 F/Xntl6wKDmYIZGT5qOE7nX2jklZBWa+NE0n/j+yv3ZdtHfdTTa4iQHMvc2e8YiyaEV8
 6C0ndqhUKSeRvGHEzzJpos3LDpyOxT75jbkPwgGquQyJ1dPGMtnM1eZIFp5v9B74QVbG
 3kiw==
X-Gm-Message-State: AOAM532AbwSTM7uoVYVvzUDnqgP/eBA/LxXpTfBS5q+4Z4UD3bfIe6/n
 5VnqiVIDZa6/pY2MFyCe11FpZQ==
X-Google-Smtp-Source: ABdhPJzxdeXU89q22gyHmthoWcnGdg9zFvCS0EtqufEuzVaX6IYosj6/AmW+M3t0tXGZdbu/vTLWjg==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr8775367wma.53.1633514137346;
 Wed, 06 Oct 2021 02:55:37 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id o6sm378418wri.49.2021.10.06.02.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 02:55:36 -0700 (PDT)
Date: Wed, 6 Oct 2021 10:55:14 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 10/11] uapi/virtio-iommu: Add a new request type
 to send page response
Message-ID: <YV1ygu5URvuHB4qb@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-11-vivek.gautam@arm.com>
 <YUoFSrAK2gi3GWp/@myrica>
 <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d40ea85b-3612-10b3-0add-40d07e6d9ca5@arm.com>
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Sep 30, 2021 at 02:54:05PM +0530, Vivek Kumar Gautam wrote:
> > > +struct virtio_iommu_req_page_resp {
> > > +	struct virtio_iommu_req_head		head;
> > > +	__le32					domain;
> > 
> > I don't think we need this field, since the fault report doesn't come with
> > a domain.
> 
> But here we are sending the response which would be consumed by the vfio
> ultimately. In kvmtool, I am consuming this "virtio_iommu_req_page_resp"
> request in the virtio/iommu driver, extracting the domain from it, and using
> that to call the respective "page_response" ops from "vfio_iommu_ops" in the
> vfio/core driver.
> 
> Is this incorrect way of passing on the page-response back to the host
> kernel?

That works for the host userspace-kernel interface because the device is
always attached to a VFIO container.

For virtio-iommu the domain info is redundant. The endpoint information
needs to be kept through the whole response path in order to target the
right endpoint in the end. In addition the guest could enable PRI without
attaching the endpoint to a domain, or fail to disable PRI before
detaching the endpoint. Sure it's weird, but the host can still inject the
recoverable page fault in this case, and the guest answers with "invalid"
status but no domain. We could mandate domains for recoverable faults but
that forces a synchronization against attach/detach and I think it
needlessly deviates from other IOMMUs.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

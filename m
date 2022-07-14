Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F57DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 13:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B839C847BC;
	Thu, 14 Jul 2022 13:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B839C847BC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=T5QWHjEb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBhzZuqKXsg0; Thu, 14 Jul 2022 13:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A71F84803;
	Thu, 14 Jul 2022 13:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A71F84803
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E9C0C0033;
	Thu, 14 Jul 2022 13:00:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EFACC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17F45614CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 17F45614CC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=T5QWHjEb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rkoMAEk7Ufse
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:00:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90DC8612D4
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90DC8612D4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 13:00:44 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 f24-20020a1cc918000000b003a30178c022so1006157wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oyGofj7adAy+ioh++szahjgmRi11ejZPUA5+K3Ca9do=;
 b=T5QWHjEb9MFsZO+WOG3HyJouzePFH2fVUtERQ1Z26Mdd0hzbEEn3VCFHxMx7vUtCkw
 HaN/I5LldKr3T8rl8Ferjwk6MscqJWzTveaSRTucHeeOX/cmy6dP1rTL8qDStnVyvSQf
 NxhgmlLOPZ854HzLMRZ5fPndUMDBMN3ahstr0Cnm5Ele2Ztp8fNZgv0AC0DuIFqt5QFt
 Y8wKZS8t1jelVB5RGEXUAaaw0nJESG+rWiqmE7a76W8sp7zw1by9Ns6uToFjxD7lmBNo
 Ub+1TkCcc1VzB1IA87jzfEZ6a81gTn0nVb8VSeUVPnfYHaYx/4TCpDd4GDKAHQCqm09Z
 QROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oyGofj7adAy+ioh++szahjgmRi11ejZPUA5+K3Ca9do=;
 b=S5QWMXAciDvwNBRyi803LwBU2alwXkJDGUUhpe5HN82Kcefq+joETDQCA39F/Jgpnr
 ZJ9/Xm3drvDkV/rf3jyny2EK0hh4nMrAy+6ajUeLVWiKztx7EUQ2+tLVWG/KVMeUL40j
 +f8TFDsUEGTuZ8EMwqSv5IimuqDMpN9Xhex3QSv/dP9j0557tvsObLV6mEPfCyxGnBxL
 duPf/M008A7AcDwTneTlTTBfGr+yot9I3vFKHPAfUhAsUWU5NVqQYF77IoST+qhnkZrg
 uBb9v4OLHquJ0xONpSiTPEheu5ix+U9SqTyq5GrsNnMum84N4hVKMzOp7OAA9MSlvWFs
 CcXw==
X-Gm-Message-State: AJIora979rfv3M2lN9A5puqHAc7yvM8WaJdRzIFNyCDEBTVzExpXQUUn
 uE6z8YaIj07h6nRSAacIab4m1g==
X-Google-Smtp-Source: AGRyM1uDVqWiyBJuqbvSTtI0Tvld6fOuVDXwdAwFgrDQUlfh95fa39o2B8aN5yyqyPM452sqvizX2w==
X-Received: by 2002:a1c:ed05:0:b0:3a2:ebae:c5e7 with SMTP id
 l5-20020a1ced05000000b003a2ebaec5e7mr8847103wmh.78.1657803642657; 
 Thu, 14 Jul 2022 06:00:42 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 m65-20020a1ca344000000b0039c5a765388sm1873497wme.28.2022.07.14.06.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 06:00:42 -0700 (PDT)
Date: Thu, 14 Jul 2022 14:00:17 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Message-ID: <YtATYaBOz5UnTNC6@myrica>
References: <20220714111059.708735-1-jean-philippe@linaro.org>
 <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>
Cc: eric.auger@redhat.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, virtualization@lists.linux-foundation.org
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

On Thu, Jul 14, 2022 at 01:01:37PM +0100, Robin Murphy wrote:
> On 2022-07-14 12:11, Jean-Philippe Brucker wrote:
> > Fix virtio-iommu interaction with VFIO, as VFIO now requires
> > IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
> > mappings, and always expects to be called with IOMMU_CACHE.
> 
> Can we know this is actually true though? What if the virtio-iommu
> implementation is backed by something other than VFIO, and the underlying
> hardware isn't coherent? AFAICS the spec doesn't disallow that.

Right, I should add a note about that. If someone does actually want to
support non-coherent device, I assume we'll add a per-device property, a
'non-cacheable' mapping flag, and IOMMU_CAP_CACHE_COHERENCY will hold.
I'm also planning to add a check on (IOMMU_CACHE && !IOMMU_NOEXEC) in
viommu_map(), but not as a fix.

In the meantime we do need to restore VFIO support under virtio-iommu,
since userspace still expects that to work, and the existing use-cases are
coherent devices.

Thanks,
Jean

> 
> Thanks,
> Robin.
> 
> > Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/virtio-iommu.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index 25be4b822aa0..bf340d779c10 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> >   	return iommu_fwspec_add_ids(dev, args->args, 1);
> >   }
> > +static bool viommu_capable(enum iommu_cap cap)
> > +{
> > +	switch (cap) {
> > +	case IOMMU_CAP_CACHE_COHERENCY:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >   static struct iommu_ops viommu_ops = {
> > +	.capable		= viommu_capable,
> >   	.domain_alloc		= viommu_domain_alloc,
> >   	.probe_device		= viommu_probe_device,
> >   	.probe_finalize		= viommu_probe_finalize,
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

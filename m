Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49A4CE7A95
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 12:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3900C41587;
	Mon, 25 Sep 2023 12:40:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3900C41587
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=EEk5O6T5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nWZpMx95poLB; Mon, 25 Sep 2023 12:40:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ACC6041030;
	Mon, 25 Sep 2023 12:40:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ACC6041030
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53492C0071;
	Mon, 25 Sep 2023 12:40:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D53ECC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 12:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A859041565
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 12:40:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A859041565
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7xDiEzN5zLTr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 12:40:54 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B212B41030
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 12:40:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B212B41030
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d7ecdb99b7aso7099797276.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1695645653; x=1696250453;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E4kzsEhG+gR50UuYrr0hWNyVHM1Qwmcb10rU8QBkH+4=;
 b=EEk5O6T54BGSw21QLIEUb779d4xd/QqBvfj98ij8dyRPHKZimwi0WTxa4DpgMKsL5s
 SUOVByONzxQgbuSYDGQ1XgkEyYH1fDRX8OWbEJ0g+uIPOQvURe6Lnj1rysx+lKt4hFK/
 HRu3UqYITmFIdlCjFomYfD02dRbjwRuZkAFNturS4PmaA/yMXhlSEnmsWNiOmwNv7/Lt
 61Ahl/FNkz3P/f8ghfNSNPjp5h18Qi+6NzfSZWq9F5w/t/F7QhxhJ6957QoOFF7ocAzj
 vAsU9mcplCLimiXkSyYRhOUCfcGzWK3F+j4VAphbTxXlt7/p+izWDQyuInGsLy0BN7kP
 EbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695645653; x=1696250453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4kzsEhG+gR50UuYrr0hWNyVHM1Qwmcb10rU8QBkH+4=;
 b=RD8YyTPxw09nlC93qn3IfwZ/lpGoBBRRw2Xj91fP3ewaHF9+7mydkX7huFj+JSPcPs
 YKuzBHyklYVdlqGQOCvViAes3eE0HJmjdM5cI+fgv5F+FGzK7sfBVZubjbN59N+kir7s
 iuIz8YbY3VoCkGX6Y1m6JTUYNuvdgrPlWnJ2zA6ux+zAyMXVXAdbkE7PyPb7Azty59Fj
 QmSrgach+bOGrcoWXEYpsBYBxEU/NfsyCxfD2TVMuhqFlvM/uub5J76CNQJCukKYlG06
 yBXJqWTvqAUTuxGDoPLYRC16q+LGFiqtsDpTOJF1gXoQw4Fryv1nIhGv2H9gYxDLby2C
 TFJA==
X-Gm-Message-State: AOJu0Yy0QOxiiB5xi0rGF7MbgcSF1mtiUDmCfB/TO2cIR7FnoSDf87wR
 UoHddEqLNz9d/ksckr9CeCLyGw==
X-Google-Smtp-Source: AGHT+IH3Y+9j9raszOHHXw26GDW4jOHx9++pXJi8a0moyryr53oJi6UZzICnhW5K7XiQ5mDWOsyiGA==
X-Received: by 2002:a25:496:0:b0:d80:9ed:5038 with SMTP id
 144-20020a250496000000b00d8009ed5038mr5820473ybe.21.1695645653492; 
 Mon, 25 Sep 2023 05:40:53 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 m8-20020a0cf188000000b0065898a8977dsm1891356qvl.71.2023.09.25.05.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 05:40:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qkktQ-000qtP-5V;
 Mon, 25 Sep 2023 09:40:52 -0300
Date: Mon, 25 Sep 2023 09:40:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230925124052.GJ13795@ziepe.ca>
References: <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
 <42860c87-cf4d-0413-c3ae-b74ee9e7e5e6@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <42860c87-cf4d-0413-c3ae-b74ee9e7e5e6@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Sep 25, 2023 at 10:48:21AM +0800, Baolu Lu wrote:
> On 9/23/23 7:33 AM, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> > 
> > > virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> > > either; it sets it once it's discovered any instance, since apparently it's
> > > assuming that all instances must support identical page sizes, and thus once
> > > it's seen one it can work "normally" per the core code's assumptions. It's
> > > also I think the only driver which has a "finalise" bodge but*can*  still
> > > properly support map-before-attach, by virtue of having to replay mappings
> > > to every new endpoint anyway.
> > Well it can't quite do that since it doesn't know the geometry - it
> > all is sort of guessing and hoping it doesn't explode on replay. If it
> > knows the geometry it wouldn't need finalize...
> 
> The ultimate solution to this problem seems to be to add device pointer
> to the parameter of ops->domain_alloc. So once the domain is allocated,
> it is fully initialized. Attaching this domain to a device that is not
> compatible will return -EINVAL, then the caller has to allocate a new
> domain for this device.

Sure, it looks like this, and it works already for default domain
setup.

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 8599394c9157d7..1697f5a2370785 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -637,15 +637,10 @@ static void viommu_event_handler(struct virtqueue *vq)
 
 /* IOMMU API */
 
-static struct iommu_domain *viommu_domain_alloc(unsigned type)
+static struct viommu_domain *__viommu_domain_alloc(void)
 {
 	struct viommu_domain *vdomain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED &&
-	    type != IOMMU_DOMAIN_DMA &&
-	    type != IOMMU_DOMAIN_IDENTITY)
-		return NULL;
-
 	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
 	if (!vdomain)
 		return NULL;
@@ -654,16 +649,32 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 	spin_lock_init(&vdomain->mappings_lock);
 	vdomain->mappings = RB_ROOT_CACHED;
 
+	return vdomain;
+}
+
+static struct iommu_domain *viommu_domain_alloc(unsigned type)
+{
+	struct viommu_domain *vdomain;
+
+	/*
+	 * viommu sometimes creates an identity domain out of a
+	 * paging domain, that can't use the global static.
+	 * During attach it will fill in an identity page table.
+	 */
+	if (type != IOMMU_DOMAIN_IDENTITY)
+		return NULL;
+	vdomain = __viommu_domain_alloc();
+	if (!vdomain)
+		return NULL;
 	return &vdomain->domain;
 }
 
 static int viommu_domain_finalise(struct viommu_endpoint *vdev,
-				  struct iommu_domain *domain)
+				  struct viommu_domain *vdomain)
 {
 	int ret;
 	unsigned long viommu_page_size;
 	struct viommu_dev *viommu = vdev->viommu;
-	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
 	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
 	if (viommu_page_size > PAGE_SIZE) {
@@ -680,13 +691,13 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 
 	vdomain->id		= (unsigned int)ret;
 
-	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
-	domain->geometry	= viommu->geometry;
+	vdomain->domain.pgsize_bitmap = viommu->pgsize_bitmap;
+	vdomain->domain.geometry = viommu->geometry;
 
 	vdomain->map_flags	= viommu->map_flags;
 	vdomain->viommu		= viommu;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+	if (vdomain->domain.type == IOMMU_DOMAIN_IDENTITY) {
 		if (virtio_has_feature(viommu->vdev,
 				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
 			vdomain->bypass = true;
@@ -717,6 +728,24 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	kfree(vdomain);
 }
 
+static struct iommu_domain *viommu_domain_alloc_paging(struct device *dev)
+{
+	struct viommu_domain *vdomain;
+	vdomain = __viommu_domain_alloc();
+	if (!vdomain)
+		return NULL;
+
+	if (dev) {
+		struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
+
+		if (viommu_domain_finalise(vdev, vdomain)) {
+			viommu_domain_free(&vdomain->domain);
+			return NULL;
+		}
+	}
+	return &vdomain->domain;
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int i;
@@ -732,7 +761,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * Properly initialize the domain now that we know which viommu
 		 * owns it.
 		 */
-		ret = viommu_domain_finalise(vdev, domain);
+		ret = viommu_domain_finalise(vdev, vdomain);
 	} else if (vdomain->viommu != vdev->viommu) {
 		ret = -EINVAL;
 	}
@@ -1045,6 +1074,7 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 static struct iommu_ops viommu_ops = {
 	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
+	.domain_alloc_paging	= viommu_domain_alloc_paging,
 	.probe_device		= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
 	.release_device		= viommu_release_device,
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

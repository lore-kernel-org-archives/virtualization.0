Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8492F8C50
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765115; cv=none; b=UdumTMSEA66OYevLr1IP0/OjNlTmeUFF54oOXB7XJOCQw5x3AEWwjhL0ElHLftlmplDrYIZcovXnAtC5d8ARljWdkXTm4TAurzyBIf5mklASyQzQfeiP/VCoM7x3PMZP6sOcaGN64FBPuvdBFl+SNNRfVgEOqdEUIO1Xv/fN45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765115; c=relaxed/simple;
	bh=F85tYXY6VV6nTjJyZOX8HjAMj77RP6ilys53ORMr8BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kPkrI5J9YdIm0rh2LRP1sYisDiG6Q6K3yzcHMx6PEICPAI1ynOPpyqVtwV40J3C3JPbREm2nyRQQIuAfOSMeTRZF3+jcHkV/Lx7jmyAa76PDS5PrZEdn0pLyDJRqXk7tpth94KsLUO1pAh4wG60GhoTeFd2HpBebbVW/7ySIFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+kQnrzx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+kQnrzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752765113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37glsxypXkn1C3d6CO3iVbC1wX6loiRVfTLNayBy9I8=;
	b=E+kQnrzxYniemvsxuqrRvAQUNeDB82VuHraJAMp6zLrJRpVSiL4jVOSuE76nEP2PxRSwRV
	yOQBwMZTRsWafjHS0ultJV4Om1HnZW2IQ370tYdibkPeesum6KKqYEzI8fB88EuxlwmN9S
	ZJA+5qPcRtGesOKP/28ut4RBLfe6RPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-zjQgGmy5MGGWBZOoUqzJTQ-1; Thu, 17 Jul 2025 11:11:49 -0400
X-MC-Unique: zjQgGmy5MGGWBZOoUqzJTQ-1
X-Mimecast-MFC-AGG-ID: zjQgGmy5MGGWBZOoUqzJTQ_1752765108
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4560a30a793so4651095e9.3
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 08:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765108; x=1753369908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37glsxypXkn1C3d6CO3iVbC1wX6loiRVfTLNayBy9I8=;
        b=sb0ac/0oNF+hd5gWjSOvNORbPZIe2ygGr49sR4rN9lqYk8iLslVwn7maZMxKMXTrzO
         /xwk/o7Dxq+ybRyUmsef8nr9v2n45d23kdXxR65SvyqtFM2qxBns2lIita8lnYa7/I34
         U+5xs333hugsCwz4jqLSpM+inlvi+TckbIiDXIqOwVzrBtMRjL9DmaVQQr5owM9ppqqU
         Uyrb79lgbUNsMQ912aqGzrzjAzNr6ibMZBBsIcgKVbFmkgSUQ9fRHMluC5Sn8NzrveF4
         y8ztaHlQHwCKaZM1bkpNIngXDupBOxfk5bLXUBpoOrIGZONN7TRFK7AqRjIIES+ALKHH
         COLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3UCyBA7PDS9lRqTXKqCeG22F4/QPG+AIdqU3YoPbf6vlO7Rm4iir67mW9WA8KNC3eVnhmAqY760U0owSmxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLZ4mTxj20ksDiLmeO+J0VpzSyMVn6SsIwUP7Sm9fXzwLGj7HX
	20jed4DbKw15HebcQjJepN9kduMuiHrjCcdbI+luVPlmplN4nvaTuqIyewHdmI70Pj2qLLQwcIT
	CQdHWrhYaypzgEiU6HVBK7caqbPW1HSH5k8ZDDrV1NxaTjcrvt+S8gb0NUNTe1SbgaVIp
X-Gm-Gg: ASbGncs/S3lQO3ct8TtkqQzbBjNyktjniWXsb6ykoTLAvKy6gyCBQD9L8QXjzqHCzk3
	erjLYOMJcPJ7MGlmuNj9ENWuqpjL/ZTSI1wDXDQCaV/1VoH/g6+Z4YKB/s9fupL6D659rkqnOPZ
	42f9pXlzNN2IXGie6cpoyLguazd0PS8/xoi/BNW0HypVpTP0xEZrsvYjG5BRPe7keWjnHEhQsNK
	Eip3zcKgcv9C6ZWJsMsKFuGWZnG+O+33Oa5lwzz5FSR4+ct2AdrvZVlrfoJlxuQ5kb6+VULwarH
	rdfrIbGiUvUA+DDxBvSDlM3K2J2L/KMk
X-Received: by 2002:a05:600c:a088:b0:456:43d:118d with SMTP id 5b1f17b1804b1-4562e38afacmr77016815e9.17.1752765108167;
        Thu, 17 Jul 2025 08:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB07BVIwzcHvYAUkNSqmK1BkSLoQgRTplE4Zrs0SicJiAMmS6QZSUUkIaNPKwNmV0oVrmn1A==
X-Received: by 2002:a05:600c:a088:b0:456:43d:118d with SMTP id 5b1f17b1804b1-4562e38afacmr77016505e9.17.1752765107748;
        Thu, 17 Jul 2025 08:11:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm20649298f8f.74.2025.07.17.08.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 08:11:47 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:11:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250717091025-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aHSfeNhpocI4nmQk@wunner.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8ZfFDyEYbhqHaDCn-GnQ1wve5tT4dz6stGSnbhL4Z6o_1752765108
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2025 at 08:11:04AM +0200, Lukas Wunner wrote:
> On Wed, Jul 09, 2025 at 04:55:26PM -0400, Michael S. Tsirkin wrote:
> > At the moment, in case of a surprise removal, the regular remove
> > callback is invoked, exclusively.  This works well, because mostly, the
> > cleanup would be the same.
> > 
> > However, there's a race: imagine device removal was initiated by a user
> > action, such as driver unbind, and it in turn initiated some cleanup and
> > is now waiting for an interrupt from the device. If the device is now
> > surprise-removed, that never arrives and the remove callback hangs
> > forever.
> 
> For PCI devices in a hotplug slot, user space can initiate "safe removal"
> by writing "0" to the hotplug slot's "power" file in sysfs.
> 
> If the PCI device is yanked from the slot while safe removal is ongoing,
> there is likewise no way for the driver to know that the device is
> suddenly gone.  That's because pciehp_unconfigure_device() only calls
> pci_dev_set_disconnected() in the surprise removal case, not for
> safe removal.
> 
> The solution proposed here is thus not a complete one:  It may work
> if user space initiated *driver* removal, but not if it initiated *safe*
> removal of the entire device.  For virtio, that may be sufficient.

So just as an idea, something like this can work I guess?  I'm yet to
test this - wrote this on the go - and also I'll need to implement for
other hotplug drivers, I need it at least for ACPI additonally.
WDYT?



diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bcc938d4420f..46468a1f0244 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -231,6 +231,15 @@ void pciehp_handle_disable_request(struct controller *ctrl)
 void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 {
 	int present, link_active;
+	/*
+	 * Always mark downstream devices disconnected on Presence Detect Change.
+	 * Covers device yanked during safe removal.
+	 */
+	if (events & PCI_EXP_SLTSTA_PDC) {
+		struct pci_bus *parent = ctrl->pcie->port->subordinate;
+		if (parent)
+			pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+	}
 
 	/*
 	 * If the slot is on and presence or link has changed, turn it off.


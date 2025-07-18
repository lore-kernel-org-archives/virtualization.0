Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8B29346F
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828034; cv=none; b=AYOcGJAkmfHFRbYXzNFxlfKvREIDgzyd3MfZ/v7XH+f2ieKNWv8aVjxceGZCQlBKypzrJX/g+ecC7mgsKap8s2J2P+h8elvDOYU8gZ/NKYFyPjpQEYGSuXcgp3GbT5x5mKI+12XSfeADTbnO7e8b7aEv2tF4/+e4asPWh3n1jyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828034; c=relaxed/simple;
	bh=d/cITLBHlMU6TAxUTNaIP7pa1O0kFJWp8UkvhASv7Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Y/0DXi/HGiKoaLNCfBsoZnowWFYzoEMDS7E414dJKHqZRNTxssdvjc14s22c77/pyyUwfRkLoBBHo0Hy6zUwBM1g1a5fZT9RtuNRV392vr82GfqFczJA7nFYW5b19ncqqIgx21iHCHlt9jTcpNVd8dPCUjhklbn210IHvsVxKtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyTPgiot; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyTPgiot"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752828031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qhhj+5lPdjvEGUsT5bIy4jc4ubsrbG5zCwrEB9sz+w4=;
	b=MyTPgiotJFEQ3hZIiSckKisTy5f2QIbItgwbrtBXmHykOMlO71OozWNYzs+oLSNkn7b+LI
	DPU2WLmoUd0iQlV1yO7Pks/3idc2N9cacqB2adHZHnKv+azQ9+vRLsrDmVH/M0qljctFUY
	eIUMO4mKL+Y1afkxHj4pRdP00tqlfqc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-umQ1JsgROni-NYS3Dhc8nw-1; Fri, 18 Jul 2025 04:40:27 -0400
X-MC-Unique: umQ1JsgROni-NYS3Dhc8nw-1
X-Mimecast-MFC-AGG-ID: umQ1JsgROni-NYS3Dhc8nw_1752828027
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso924770f8f.3
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 01:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828026; x=1753432826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhhj+5lPdjvEGUsT5bIy4jc4ubsrbG5zCwrEB9sz+w4=;
        b=sFD4gHuNAmBRWX5nrUmQqdyI1pktBUGHNwgAEB8455N6Qtv3+ATFzS4FLdfKXexfKk
         2DVqkyn2pj5vetQdQ0vYn3Wznl6tyz8DXsQS+I/lRyG9zIGKCjlLJXCgFs0A80PViG4H
         rLB7C8+bGGdGiWmp3HMCbRww0MgNWkDX3m08YR3U4LOjQLEXTNbyQN304h9oL5/FJ8Ws
         LXftbgWpgC261ZRlzr0e7BbHWvcHSmDw1MPw3q/Jz1PKr92VKT3AyxvkFPZ+bjY8/rzB
         lhSWucZJ7DUFkHcxpBIqLASCnp9PfmxOwC98RLE6FLizDjOm/1mTBqT/9FP+x676EQrI
         CmhA==
X-Forwarded-Encrypted: i=1; AJvYcCUmKU8uPKS65iaKkW9FXcqASo2lDtaGiFYMePVjEi6YItWFoOsEu9uYyugXw9Hk3i7IhfDZJvjTcq+JXeRtCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfnZZmal+t4h8GBCJnDvcqdk8zx311ipnb+2gI7JUQp3KiStBm
	drbC91Hwa0sir4AOCkO2Ap8Rik+UBoEtTV1g/9xF/TWj7uNEDoBDEWK+c3dEeySMOxzqqfANYvM
	gWsxCIjCFzBTbTUFamX7X86Q8+qhQGu5mMIMSLvz9qnQ96kH71hXKp2qXapEFQfgATKeA
X-Gm-Gg: ASbGncsdYIZFdrZ/8dKv061rLzByUVEmNFMgc0qlFh5luRRSZmUTXhbbFjDQpvcyOaX
	JqsgjnBiexK1EWJiwPcCz5b+mC7q1N3LWvay3j439m9EETfF6d0TFHMb81W+jVBAT155ZefsFyj
	pKGcPKAVe/7P+jbHakbu2W+paqpd82f7Hh6hcZb8+Zz088e4VMxEBNpt6fAs55pYnPJO+aOlq2+
	XIF56AwB2sgvtgbTud++SyV+sv/lOT8nXoxSjHwpBWs6Zg158lAbAQo38xV641kNu6r6tcp8HRM
	Rn91BzeTYcGTapgC0AD8ZOEouk6ZanD7
X-Received: by 2002:adf:e192:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b61b0ebf41mr1511863f8f.5.1752828026487;
        Fri, 18 Jul 2025 01:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqBvIibZpxmEevMb7PnR+yqkZwG63DgOrUJ7WvDQrH3ySphvekTPCQWQL3DTfQJNDfF22bDw==
X-Received: by 2002:adf:e192:0:b0:3a4:e5ea:1ac0 with SMTP id ffacd0b85a97d-3b61b0ebf41mr1511830f8f.5.1752828026104;
        Fri, 18 Jul 2025 01:40:26 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d475sm1164451f8f.65.2025.07.18.01.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:40:25 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:40:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
	stefanha@redhat.com, alok.a.tiwari@oracle.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC v5 1/5] pci: report surprise removal event
Message-ID: <20250718044006-mutt-send-email-mst@kernel.org>
References: <cover.1752094439.git.mst@redhat.com>
 <fba3d235e38c1c6fcef2a30ed083ad9e25b20fa3.1752094439.git.mst@redhat.com>
 <aHSfeNhpocI4nmQk@wunner.de>
 <20250717091025-mutt-send-email-mst@kernel.org>
 <aHlZE18kPuHuDtTT@wunner.de>
 <20250717193122-mutt-send-email-mst@kernel.org>
 <aHnPLIe-0ScYDfej@wunner.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aHnPLIe-0ScYDfej@wunner.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wlxqLQYky1lVLitydaL7fBncktx64bTlPL2WKzUhbQQ_1752828027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2025 at 06:35:56AM +0200, Lukas Wunner wrote:
> On Thu, Jul 17, 2025 at 07:31:57PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 17, 2025 at 10:12:03PM +0200, Lukas Wunner wrote:
> > > pciehp_handle_presence_or_link_change() is called from pciehp_ist(),
> > > the IRQ thread.  During safe removal the IRQ thread is busy in
> > > pciehp_unconfigure_device() and waiting for the driver to unbind
> > > from devices being safe-removed.
> > 
> > Confused. I thought safe removal happens in the userspace thread
> > that wrote into sysfs?
> 
> No, the userspace thread synthesizes a DISABLE_SLOT event,
> calls irq_wake_thread(), then waits for the IRQ thread to
> finish handling that event.  See pciehp_sysfs_disable_slot().
> 
> Until 2018 we indeed brought down the slot in the userspace
> thread, but that required locking between the workqueue fed
> by the interrupt handler on the one hand and the userspace
> thread on the other hand.  It was difficult to reason about
> the code.
> 
> We had bug reports about slots flapping the link or presence
> bits on slot bringdown that we could easily address by handling
> everything in the IRQ thread, see 3943af9d01e9.  The same was
> reported for slot bringup and addressed by 6c35a1ac3da6.
> 
> This wouldn't have been possible with the architecture prior
> to 2018, at least not this easily.
> 
> Thanks,
> 
> Lukas

Got it, thanks!

-- 
MST


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D7274659
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819370; cv=none; b=k5Q8zj+DDlpBg9rxS+JoWiEO+hIfy1jkOBXyFR/ky2QDfM28kIUQNkcuwn9tK1PFhpQzpLZpbqTRBYOJ3joZl0V0t8ElzAoIzs8UT0YAGFizYgmRsA3YbMWyzsAKAjmGZTDJd9FroKztPNOuYuaFhFeAwk6o7GDCvv6xdlIlqC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819370; c=relaxed/simple;
	bh=suu5B7JT+nltyxVLocDs4lzGj2tyeaQ92aGBTUkPsc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MMKYKu8cxQ4yIJM5XA7lkJwVKpjA4h3j/zclRnObc4CpcGmV5CDP2TrQG/2Kj/Q8dIF43cSvCWN1+gzUtXNHTGadFlRbFNTdILHqucouCRu5ZrXAjdN2PEzVupxLnbYYj51SskOL10FIMhPHpedvrEk//u3DGyphFgGGPLf0Cfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL0FUbIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL0FUbIP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758819367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ExJlMZbEeqHx17txFFfBUFBbqoWdfhaK/jRKu008q3E=;
	b=AL0FUbIPMRcHvgUAv7XkqQJzMCZ0LgeEgVAzD69Gfo+d0ciDy8cVyZgHQd7QRfYBZDjLsb
	MKmKuCMGkckRAsmb5SjX10PjUb9D4ShehzMD84AMsB8WUtmWsRZTu+p5pKDDbrtsN0x+og
	55Zy9ZDf62s4qtEX7IgH5JyWbDYl5JE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-BgK8m26xMUiHoQ-seZnSYQ-1; Thu, 25 Sep 2025 12:56:06 -0400
X-MC-Unique: BgK8m26xMUiHoQ-seZnSYQ-1
X-Mimecast-MFC-AGG-ID: BgK8m26xMUiHoQ-seZnSYQ_1758819365
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e25f5ed85so7706975e9.3
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758819365; x=1759424165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExJlMZbEeqHx17txFFfBUFBbqoWdfhaK/jRKu008q3E=;
        b=b2TiX5w2fs5aMYWeHDfcDndc1SxGsi0+klEsIqXrm8z/DJEehNZ/lo8sE89y23t7pe
         aVtWrZS5iHMO/wU5ZTdFEoV+3HQ96qQI7C/7aRRiyUHfp19KMFHd14QV/qBEL6cxpwZq
         fO6nyGt3T98/7XxQ7cSfIce3nbuThNdk89D8prkyfqbTrG9RjC3qJLTibkfLez+xT3mv
         kTDux+0Zpm5lHPEOHrry40eQX94HWiPOvoDnRy6ePX52sJRaYooXFzcyec9brZ6mkNll
         ODO2ahIxvMJcXcy/8HmM7O/SyW9S0F+vtQVOPf1vuKf2oEPpbPWGQG5XpuVS7qGT8D+Y
         sQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoqWLO6gfB6pmgBUmeWDaDWOy/tQkRFS+pu3BXnvCyl8xZE8utjqG5wKW089f4oJRUeOeRAZcLU1l1G6Z4Hg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySPJAQYx0yGu6sWaGP2niLdPxdyEr/xZvfG2456YEnJZO/e2ku
	6+8fL6RwAfs0dhWisrlQlD0i+jTSHniSMXnHlUyf8CY2m2dCPSsCKPWCpTbu18bwKXbYp82BrQf
	kD0NTgABix5B6b6SfbiY4NzH8lHAeiZ9NLVwYefHkplOT/25IgdWWxG+cQWwojY2SuGHI
X-Gm-Gg: ASbGncsN/BMUHtiHloSPh+5miGVaElv29YgI3R+QbxcwrcvhQFRX89qANwA+BFHrviy
	fqvXtgfPwkJ5PNdtRq9VgB1TY50cOSRpFcMh6kjPQoxkEi9jwMPh26PmdXEZaJ0SGPLjTIwIfG7
	mVT8KK7G9wzDy5sX01HDFFa+ufCZbn/thXf4UvL5V2860RMMJxbI1Oogj9y7Il6qFIkJsVYftYN
	Ex/uAR7yGaFQPjBJ62gifSLXYDCoIPOD4wCcStwZy8rTFjd1+yLv3KffvHngGdxcriXBRz5iF5M
	zHf+XDUBmdAqWeD6FblcKSOFKMw0OG8rFQ==
X-Received: by 2002:a05:600c:4512:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-46e329e3f76mr51430055e9.10.1758819364337;
        Thu, 25 Sep 2025 09:56:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeAb6b4av0W9CmbCIL5oQM/OPUBcpXLL9D5kvrebwEqAmOtmw5A6IkqGOvrgEx/Y5psyxduw==
X-Received: by 2002:a05:600c:4512:b0:46d:996b:828c with SMTP id 5b1f17b1804b1-46e329e3f76mr51427825e9.10.1758819363315;
        Thu, 25 Sep 2025 09:56:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb871c811sm3677653f8f.15.2025.09.25.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:56:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 12:55:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925125528-mutt-send-email-mst@kernel.org>
References: <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
 <20250925074814-mutt-send-email-mst@kernel.org>
 <b3a7715a-5826-4395-9cc3-73bac8c26a63@nvidia.com>
 <20250925085537-mutt-send-email-mst@kernel.org>
 <bc70cd99-31a5-44d4-9648-20dcd80e9f8f@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bc70cd99-31a5-44d4-9648-20dcd80e9f8f@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uoGm1K6E01uq6uGtNwKLvzn_rTo05AVIpmT7BKgyV_Q_1758819365
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 11:53:50AM -0500, Dan Jurgens wrote:
> On 9/25/25 8:08 AM, Michael S. Tsirkin wrote:
> > On Thu, Sep 25, 2025 at 05:39:54PM +0530, Parav Pandit wrote:
> >>
> >> On 25-09-2025 05:19 pm, Michael S. Tsirkin wrote:
> >>> On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
> >>>> On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
> >>>>> On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> >>>>>> Function pointers are there for multiple transports to implement their own
> >>>>>> implementation.
> >>>>> My understanding is that you want to use flow control admin commands
> >>>>> in virtio net, without making it depend on virtio pci.
> >>>> No flow control in vnet.
> >>>>> This why the callbacks are here. Is that right?
> >>>> No. callbacks are there so that transport agnostic layer can invoke it,
> >>>> which is drivers/virtio/virtio.c.
> >>>>
> >>>> And transport specific code stays in transport layer, which is presently
> >>>> following config_ops design.
> >>>>
> >>>>> That is fair enough, but it looks like every new command then
> >>>>> needs a lot of boilerplate code with a callback a wrapper and
> >>>>> a transport implementation.
> >>>> Not really. I dont see any callbacks or wrapper in current proposed patches.
> >>>>
> >>>> All it has is transport specific implementation of admin commands.
> >>>>
> >>>>>
> >>>>> Why not just put all this code in virtio core? It looks like the
> >>>>> transport just needs to expose an API to find the admin vq.
> >>>> Can you please be specific of which line in the current code can be moved to
> >>>> virtio core?
> >>>>
> >>>> When the spec was drafted, _one_ was thinking of admin command transport
> >>>> over non admin vq also.
> >>>>
> >>>> So current implementation of letting transport decide on how to transport a
> >>>> command seems right to me.
> >>>>
> >>>> But sure, if you can pin point the lines of code that can be shifted to
> >>>> generic layer, that would be good.
> >>> I imagine a get_admin_vq operation in config_ops. The rest of the
> >>> code seems to be transport independent and could be part of
> >>> the core. WDYT?
> >>>
> >> IMHV, the code before vp_modern_admin_cmd_exec() can be part of
> >> drivers/virtio/virtio_admin_cmds.c and admin_cmd_exec() can be part of the
> >> config ops.
> >>
> >> However such refactor can be differed when it actually becomes boiler plate
> >> code where there is more than one transport and/or more than one way to send
> >> admin cmds.
> > 
> > Well administration virtqueue section is currently not a part of a
> > transport section in the spec.  But if you think it will change and so
> > find it cleaner for transports to expose, instead of a VQ, a generic
> > interfaces to send an admin command, that's fine too. That is still a
> > far cry from adding all the object management in the transport. 
> > 
> > 
> > Well we have all the new code you are writing, and hacking around
> > the fact it's in the wrong module with a level of indirection
> > seems wrong.
> > If you need help moving this code let me know, it's not hard.
> > 
> >> Even if its done, it probably will require vfio-virtio-pci to interact with
> >> generic virtio layer. Not sure added value of that complication to be part
> >> of this series.
> >>
> >>
> >> Dan,
> >>
> >> WDYT?
> > 
> > 
> > virtio pci pulls in the core already, and VFIO only uses the SRIOV
> > group, so it can keep using the existing pci device based interfaces,
> > if you prefer.
> > 
> 
> I can make changes here. I'd appreciate if you review the rest of the
> series while I do so. Patches 3+ are isolated from this, so it won't be
> a waste of your time.

OK - will review 3+, thanks!

-- 
MST


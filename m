Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00D219302
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805728; cv=none; b=tW2OYNq//sAz+0K4FAbH3JeIrr+ON7JywRPcIINj79rE4iqAc49U2C4Hliy11GX7enX+si7SrbYe5EJCN1kUtI3rjRy9X9s7Z6d6V8aVmP08JZbaU3wH8sVKBXjYEf8qBVSuneuE2SvFkkUKpbv11pICbALrWmg4xoSmI+20kV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805728; c=relaxed/simple;
	bh=pHzeN0pOLnRL8cdMP6gwjLAE11wWYnJrYQEwhqDwNN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XDqXYrQZYMmGGFge4cnqKQlO+GXYS84yValGCQ98sY1WFKc+EjjCqNUDt67yeDlNq8ZrqSL0kJUJJ98btlgHiXv0eTKSYRLm5pltSC176KCipLx2MZMRoudOPvtCsItNM/2bmQfuiaE1QgdRklhHDyOOlYlt4Ep/QZSyTqerNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpIX8O8G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpIX8O8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S8NPCXjHrvi8f6KNdbiSPsT35lRRwKO5pQNvMmoDVVg=;
	b=hpIX8O8GvLx86IzLoHv7jw4TmnxiaDJNrOrZvyiLm6tKmyBrIrkqCB2z5cKy5d9gdas7Yz
	rNsGw7KtjBDzGolwAQWMam9bQhlaTQ8KbaGoyFaL5OeZYx/ef8QXp3kdgN1jJTxAnF2dWR
	yZ7XVg+S1B7Yp0n301sQbWsNyypSeRo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-H4LY7SftMCygwV0erH1Plw-1; Thu, 25 Sep 2025 09:08:43 -0400
X-MC-Unique: H4LY7SftMCygwV0erH1Plw-1
X-Mimecast-MFC-AGG-ID: H4LY7SftMCygwV0erH1Plw_1758805721
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so5317395e9.2
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 06:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805720; x=1759410520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8NPCXjHrvi8f6KNdbiSPsT35lRRwKO5pQNvMmoDVVg=;
        b=eIMl8HcQm5XaC4ERL/kblObSqmHssSbqyzM1hZ3ELqRVBAwiMSQS4eVEcZcTqSJNv3
         qRULjFhN00fyq8zT0+LdB+paY8M6JRIeYmWfYklRC49SaMwF73+amVKZJfhPnZ/arRz4
         HHRtpA9j5CDMBhy6UmCMC7PL6jLSM3jxysgG4uRpdFHHB+2Dur1BE4FdOBvMXdvTWdQ8
         Ous8OUGxwIUmMVJSfE8OtvlciFk4SNu3I+LSuw0xiCeZ6BDwI0C6BC6JU/X5Ze/wwtWr
         eFruF+Z/OHTdrdxUcwM1pza45AgeNhA6KDaAv00RtmxgQwiw2RLTQ/2R1kvWEYhqTU5/
         ms0w==
X-Forwarded-Encrypted: i=1; AJvYcCU+X7DDrxKBaMNPu4nI6j20xKptY1zgBCIJ6j9i/HDoRJxLP8PSyExvZLV/dZdwI2b15dLUQVCjb+U0IMn5TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyT/FORcX26v94rAcZ5t6ifdk74rlJsNWqBYJwbuiWCFYtMFlCy
	HEjbayKIkBZ+Fg64iLZR/We4XHAIo4T2e3wUmvllt7B7VNlFlCr5N1Sh1UBFEQFXS3QO/0ajDBB
	ocHnIgfEiMUR3+cPzOoqP1XRKAfSEFqHS/tzrJvdDVYT5Wmdhq4BY9FSj6yqp8Yuek+xe
X-Gm-Gg: ASbGncsVtu+2WX9/TpzsDwK+f5hCEC4XXZc3X1tmKcbUWVLYot6o3yv/bhrBMTJaTcO
	8kxf12I+DBZIQXngZDCMH78ES+fOmJB0ETqLOnpzuxuntauyTZihqmR+ToY9WT4R+nMA0XIJ86h
	+sm9uZaMuTSE5+Hj1nF061bofpIPCuGerp17VJBw1IwJUmEOQ56QBSgrSuuEW4bF0fWJXO2o3Dj
	AiXjyTkaBZJ5vYpAWfFBfPUFsqxopKFTRAlnx8IYtXH8wgBDWkeWNh2e2tFwqa1/BY8lN1g7Msb
	vdPrNlN0WbHmtgymLOJ0sQE3G5D5oSzLxg==
X-Received: by 2002:a05:600c:c043:b0:46e:3901:4a25 with SMTP id 5b1f17b1804b1-46e39014e80mr3241245e9.20.1758805720453;
        Thu, 25 Sep 2025 06:08:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEn//U9TkSGTeqttHJGpDOiUft9Moe2Tu1OG7UsN3cLPGwbmTbhnSi9WX8hXjq/kF7wetAzw==
X-Received: by 2002:a05:600c:c043:b0:46e:3901:4a25 with SMTP id 5b1f17b1804b1-46e39014e80mr3240935e9.20.1758805719976;
        Thu, 25 Sep 2025 06:08:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab838b6sm75360965e9.24.2025.09.25.06.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:08:39 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:08:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	netdev@vger.kernel.org, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH net-next v3 01/11] virtio-pci: Expose generic device
 capability operations
Message-ID: <20250925085537-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-2-danielj@nvidia.com>
 <CACGkMEtkqhvsP1-b8zBnrFZwnK3LvEO4GBN52rxzdbOXJ3J7Qw@mail.gmail.com>
 <20250924021637-mutt-send-email-mst@kernel.org>
 <16019785-ca9e-4d63-8a0f-c2f3fdcd32b8@nvidia.com>
 <20250925021351-mutt-send-email-mst@kernel.org>
 <4fa7bf85-e935-45aa-bb2f-f37926397c31@nvidia.com>
 <20250925062741-mutt-send-email-mst@kernel.org>
 <92ca5ed1-629d-4dc3-85fc-f1c6299a42ba@nvidia.com>
 <20250925074814-mutt-send-email-mst@kernel.org>
 <b3a7715a-5826-4395-9cc3-73bac8c26a63@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b3a7715a-5826-4395-9cc3-73bac8c26a63@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Z8SOOVSk5oWK__R_K9YI3jkwbEMhNQ_xx6u64uN9WY_1758805721
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2025 at 05:39:54PM +0530, Parav Pandit wrote:
> 
> On 25-09-2025 05:19 pm, Michael S. Tsirkin wrote:
> > On Thu, Sep 25, 2025 at 04:15:19PM +0530, Parav Pandit wrote:
> > > On 25-09-2025 04:05 pm, Michael S. Tsirkin wrote:
> > > > On Thu, Sep 25, 2025 at 03:21:38PM +0530, Parav Pandit wrote:
> > > > > Function pointers are there for multiple transports to implement their own
> > > > > implementation.
> > > > My understanding is that you want to use flow control admin commands
> > > > in virtio net, without making it depend on virtio pci.
> > > No flow control in vnet.
> > > > This why the callbacks are here. Is that right?
> > > No. callbacks are there so that transport agnostic layer can invoke it,
> > > which is drivers/virtio/virtio.c.
> > > 
> > > And transport specific code stays in transport layer, which is presently
> > > following config_ops design.
> > > 
> > > > That is fair enough, but it looks like every new command then
> > > > needs a lot of boilerplate code with a callback a wrapper and
> > > > a transport implementation.
> > > Not really. I dont see any callbacks or wrapper in current proposed patches.
> > > 
> > > All it has is transport specific implementation of admin commands.
> > > 
> > > > 
> > > > Why not just put all this code in virtio core? It looks like the
> > > > transport just needs to expose an API to find the admin vq.
> > > Can you please be specific of which line in the current code can be moved to
> > > virtio core?
> > > 
> > > When the spec was drafted, _one_ was thinking of admin command transport
> > > over non admin vq also.
> > > 
> > > So current implementation of letting transport decide on how to transport a
> > > command seems right to me.
> > > 
> > > But sure, if you can pin point the lines of code that can be shifted to
> > > generic layer, that would be good.
> > I imagine a get_admin_vq operation in config_ops. The rest of the
> > code seems to be transport independent and could be part of
> > the core. WDYT?
> > 
> IMHV, the code before vp_modern_admin_cmd_exec() can be part of
> drivers/virtio/virtio_admin_cmds.c and admin_cmd_exec() can be part of the
> config ops.
> 
> However such refactor can be differed when it actually becomes boiler plate
> code where there is more than one transport and/or more than one way to send
> admin cmds.

Well administration virtqueue section is currently not a part of a
transport section in the spec.  But if you think it will change and so
find it cleaner for transports to expose, instead of a VQ, a generic
interfaces to send an admin command, that's fine too. That is still a
far cry from adding all the object management in the transport. 


Well we have all the new code you are writing, and hacking around
the fact it's in the wrong module with a level of indirection
seems wrong.
If you need help moving this code let me know, it's not hard.

> Even if its done, it probably will require vfio-virtio-pci to interact with
> generic virtio layer. Not sure added value of that complication to be part
> of this series.
> 
> 
> Dan,
> 
> WDYT?


virtio pci pulls in the core already, and VFIO only uses the SRIOV
group, so it can keep using the existing pci device based interfaces,
if you prefer.

-- 
MST


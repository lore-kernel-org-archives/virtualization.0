Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7726AE8
	for <virtualization@lists.linux.dev>; Sun,  1 Sep 2024 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725216580; cv=none; b=MjWsKMJ2Vb7WegunNYG8c1m0pQkz+crlcIFfE8JmYsq9QjIrizcNfr9Wsjfy3tw868NfPrstI2EOw+fPdFwnuFUW/mcU484WtdCUEDCmywcgn+OlpzW7KXzDQOmng9kAX6bTIMVTCktMXMSFe+Yf9T9JpGC5oyPNWoG1XEVUpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725216580; c=relaxed/simple;
	bh=HwSyN4h6ziyZ76wyV8L6R3L5D7GGAeZEjELFYHLwwEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cNtADFHR+Y42FCdeHW9lEIjOlZl7khHXOaWRn+hrspBD+QgBBIg9ktK2amQgmx/zE1KT8pUxUSAq7ThM2JQymBDjGS0+1l64QVK7oq3W3UpcS+fjsnm4uCCEERWQW2aNpimbcmPXzqqkPmgiILDRhv9kyPiP+2VRYC07d8UOXFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2rjWdrO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2rjWdrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725216576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itWaFhuqL6tNMv1kyiXnZw2XEueWMKuw6g/pzcmyLBo=;
	b=b2rjWdrOOhNfpEbNkbZZi9rYHP1CiW73WJnxSK/4KaRQr+o19FBINM5umOtnBPuo0F9a/P
	4mhOTic+5yNwYOgdYZEpSpXn+pqtWrO8I4delVaR5ih/twzyJotimWif1cPPd7kwal8ucm
	8QMw7M85LQgVnYyaqnTtIdDAbzVdS6I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Cw7oe9x9PhWlViwCylpSeg-1; Sun, 01 Sep 2024 14:49:34 -0400
X-MC-Unique: Cw7oe9x9PhWlViwCylpSeg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c3402d93so654116f8f.0
        for <virtualization@lists.linux.dev>; Sun, 01 Sep 2024 11:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725216573; x=1725821373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itWaFhuqL6tNMv1kyiXnZw2XEueWMKuw6g/pzcmyLBo=;
        b=J38oeP1Iqf/S9csTnPtZDwm8CCiPWVOs+DvwkYAtT/NhcNIyP6plJPBah+zBOzHo50
         MRjBSGr+b4D+a+QK3wSK4Rgzzlkp0Le2dddM75m6kX3v9LR3InNgDuBkBss09mpi+Eha
         OSmEhmyWxg+xJHH9vaHCkQpPgR2auXat2hpUe5YLS2vuy4CD+Yp1FkxITFUCVR+s2OKu
         Rb14eeOnmdl7v4pvZDK5L7YJlMucU9di7MhbqcOAxrec6stYNCpuN2O5JGCJUrLV05LQ
         f8oV/tP5Qj7HxnQf8WdfkJN5KVKab4JJ6oFATQljurQRBQVeyfJ4XLJcUYrAARGRA6E/
         Lw4w==
X-Forwarded-Encrypted: i=1; AJvYcCUW33j4/Gn7r6AB3F324/LHou7C/O0fdBqwJv/vwcubzEBu12CW0ZFTcGj4Z1tH0y5GAw38cfC4syRbUVNwFw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyRGvxc7O0iVtEbtG6Izp6x4nj+8+C847bgL55KjJABQPnwzp9H
	4z6eHrpanUkUdmNZ2ainlz/FIECY0RdnGBBxXTotkFSGCN5jBET7NjTfD8df8ZZuO6OXJHcQoBF
	EV7anbqgPgHaFlOqSyZU1ppMlu/n1eM6EAKBSNHY74gprlETY72vlrxxE8N60pWax
X-Received: by 2002:adf:ce87:0:b0:374:c651:4abf with SMTP id ffacd0b85a97d-374c6514c30mr1516809f8f.52.1725216573451;
        Sun, 01 Sep 2024 11:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpxRe2152v75wQRnEpmcsZH/Hws5JITnZW22gEg/EAXSi5nn2RQPmZDPmv7GJN6y57ASKI9Q==
X-Received: by 2002:adf:ce87:0:b0:374:c651:4abf with SMTP id ffacd0b85a97d-374c6514c30mr1516792f8f.52.1725216572406;
        Sun, 01 Sep 2024 11:49:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:69ff:9d10:5dde:d984:6a82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c15705easm4120504f8f.33.2024.09.01.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 11:49:31 -0700 (PDT)
Date: Sun, 1 Sep 2024 14:49:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	si-wei.liu@oracle.com, Jiri Pirko <jiri@nvidia.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC address when no nic vport MAC
 set
Message-ID: <20240901144739-mutt-send-email-mst@kernel.org>
References: <20240827160256.2446626-2-dtatulea@nvidia.com>
 <CACGkMEuRvqu8W9-OqPBRhn1DG-+DO6TCzFdHqc7zB74GkNDkAQ@mail.gmail.com>
 <CACLfguXjiyp+Ya4mUKXu6Dmb3Wx5wW0bbNGRSFWE-Z0E5gALTA@mail.gmail.com>
 <8daf221f-8d87-4da1-944c-3bcd0edea604@nvidia.com>
 <CACLfguVr1bd6=bkGn6hX3W7xBr45qydaCpQ1mNpsATeWFqe2ZA@mail.gmail.com>
 <55b7ae23-6000-4699-9bac-5e72fbdcd803@nvidia.com>
 <0648a9d9-a056-4cdb-bfb8-a792bce1e771@nvidia.com>
 <CACLfguXM97JAdWcYO17+H6pu7MWLu2QqBgu_PypGxU_Ab+OUOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACLfguXM97JAdWcYO17+H6pu7MWLu2QqBgu_PypGxU_Ab+OUOQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Aug 30, 2024 at 05:29:14PM +0800, Cindy Lu wrote:
> On Fri, 30 Aug 2024 at 03:03, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> >
> >
> >
> > On 29.08.24 12:00, Dragos Tatulea wrote:
> > >
> > >
> > > On 29.08.24 11:05, Cindy Lu wrote:
> > >> On Wed, 28 Aug 2024 at 17:37, Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > >>>
> > >>>
> > >>>
> > >>> On 28.08.24 11:00, Cindy Lu wrote:
> > >>>> On Wed, 28 Aug 2024 at 09:51, Jason Wang <jasowang@redhat.com> wrote:
> > >>>>>
> > >>>>> On Wed, Aug 28, 2024 at 12:03 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
> > >>>>>>
> > >>>>>> When the vdpa device is configured without a specific MAC
> > >>>>>> address, the vport MAC address is used. However, this
> > >>>>>> address can be 0 which prevents the driver from properly
> > >>>>>> configuring the MPFS and breaks steering.
> > >>>>>>
> > >>>>>> The solution is to simply generate a random MAC address
> > >>>>>> when no MAC is set on the nic vport.
> > >>>>>>
> > >>>>>> Now it's possible to create a vdpa device without a
> > >>>>>> MAC address and run qemu with this device without needing
> > >>>>>> to configure an explicit MAC address.
> > >>>>>>
> > >>>>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > >>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > >>>>>
> > >>>>> Acked-by: Jason Wang <jasowang@redhat.com>
> > >>>>>
> > >>>>> (Adding Cindy for double checking if it has any side effect on Qemu side)
> > >>>>>
> > >>>>> Thanks
> > >>>>>
> > >>>> But Now there is a bug in QEMU: if the hardware MAC address does not
> > >>>> match the one in the QEMU command line, it will cause traffic loss.
> > >>>>
> > >>> Why is this a new issue in qemu? qemu in it's current state won't work
> > >>> with a different mac address that the one that is set in HW anyway.
> > >>>
> > >> this is not a new bug. We are trying to fix it because it will cause
> > >> traffic lose without any warning.
> > >> in my fix , this setting (different mac in device and Qemu) will fail
> > >> to load the VM.
> > > Which is a good thing, right? Some feedback to the user that there is
> > > a misconfig. I got bitten by this so many times... Thank you for adding it.
> > >
> > >>
> > >>>> So, Just an FYI here: if your patch merged, it may cause traffic loss.
> > >>>> and now I'm working in the fix it in qemu, the link is
> > >>>> https://patchew.org/QEMU/20240716011349.821777-1-lulu@redhat.com/
> > >>>> The idea of this fix is
> > >>>> There are will only two acceptable situations for qemu:
> > >>>> 1. The hardware MAC address is the same as the MAC address specified
> > >>>> in the QEMU command line, and both MAC addresses are not 0.
> > >>>> 2. The hardware MAC address is not 0, and the MAC address in the QEMU
> > >>>> command line is 0. In this situation, the hardware MAC address will
> > >>>> overwrite the QEMU command line address.
> > >>>>
> > >>> Why would this not work with this patch? This patch simply sets a MAC
> > >>> if the vport doesn't have one set. Which allows for more scenarios to
> > >>> work.
> > >>>
> > >> I do not mean your patch will not work, I just want to make some
> > >> clarify here.Your patch + my fix may cause the VM to fail to load in
> > >> some situations, and this is as expected.
> > >> Your patch is good to merge.
> > > Ack. Thank you for the clarification.
> > (Side note)
> > While looking at another issue I discovered that it's possible to
> > configure a random MAC on the mlx5_vdpa device at VM boot time if
> > device MAC configuration is implemented during during .set_config(). So
> > I was able to boot up a VM with a random MAC address coming from qemu
> > and the traffic worked with this new MAC.
> >
> > So now I'm not sure if this is just by luck or if the .set_config()
> > op should be implemented for the MAC part in our device.
> >
> > Thanks,
> > Dragos
> >
> Hi Dragos，
> For qemu part, I think this is not set from set_config()?  it should
> be from the CVQ?


You are confusing two things.
Provisioning is not through CVQ.


> Usually, we don't recommend using the set_config() function because
> the configuration space should be read-only for modern devices.
> 
> Now there is a bug in this part of qemu, and we plan to remove the
> code to set_config() in virtio_net_device_realize(), here is the patch
> https://lore.kernel.org/all/CACGkMEvCSKfahpBQLAMmSzdFN-QPhg5Zx+UQVrFX0HsWybZZNA@mail.gmail.com/T/
> and this is still under review
> 
> thanks
> cindy


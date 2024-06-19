Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23176763FD
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782377; cv=none; b=DGX1eaqMRI7eXiglxJUAxoet6qTAwXynfjLSXas/XoJHAtwqkfAkVjI2Zj6uFqmPRbQXS+EkfLBmYLiia+YpbT/FApmr7LoJNmnvVHPRFE+Vb86Sn0H/wPEEsySWO+uvUq5n2DaGVoPsfwoyBzQ+7MGxB+KU0hsizVA1gpqJWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782377; c=relaxed/simple;
	bh=YnVIBVW+DucY1bvIa21vpFhPXS6nuJHaOh2ceP7KWWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V+6wPPyomzggKOSsMlDnPqUh09vhUXzTFi/SM9RvYpZ68XZAqD1cuVNMwlnSOu0zjGwwJZgg5f64Er52JnI3MEaj4CRNQeUogEMhpJyxcDUsDCXRBuCFZmNRWuVY5Tzf9tRUTPCk14dhJVib90rW/V/AGGiRTWxGaZbvO02YOAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KR8L0YJG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR8L0YJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718782374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mtDCVVnBIT0YPxVqNog2X+Um6e5a8CYkKH0uc+Y5to=;
	b=KR8L0YJGizHRPcbH7N8Epd3io3L9XHKEisVwhg9YvsXPtVE683sJtzJaLox7vAE+LnClb7
	SDREtSAsOQJVQgQyOZK4iqdBGrQz1+SgF/Vvx4a9x19qmE7gk+U0akihrxE5mmPdBa8BQQ
	HcT8OQJBfa5iowUMlrNOYz2Z2z5XetQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-p6eVhPp3Od-0z3v8AI43jw-1; Wed, 19 Jun 2024 03:32:53 -0400
X-MC-Unique: p6eVhPp3Od-0z3v8AI43jw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-362a0c1041dso542781f8f.1
        for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 00:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782372; x=1719387172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mtDCVVnBIT0YPxVqNog2X+Um6e5a8CYkKH0uc+Y5to=;
        b=M0LNJkD5Yc5cnOYSzeP0iS2UJY7NjOMyJlUVvx0kZfFeiB7yPy6+1RdAZZTIIHYcgK
         CVPuA+HwgdO6QsvRblG7HDNMc2nkRZJY+G3FYt9fsoLNwzm1XYcYWEgyEiFXdeL2rmg5
         PbYLTskKdwa6r/8Vp6cz+4dBeLm95Al7RHGXd2hJlbe1Mj+jLxaowo6PAOGEoqNn7KQR
         TDDpDab5Nh/LRRKI/djb+yj5D9GztYBBIby0aX12eyoC/ene5a8ZpxKaC4Gw9kIdRjfu
         55+lMWpn63py3Es5+cjLuzAOueUOoTboAVIO5PYc0mOWVWMq0gbLQsBTsk3hdAxuMVZK
         sGAg==
X-Forwarded-Encrypted: i=1; AJvYcCWZtbseuzs7oStmA+M679fKSVuo7Byy+Q7tdCjt6lSpxN9dGc5Ehi3By2DTpG+RweU9INGVZzYyMeomfOhAnctOF/uVcHnYQwIVnW1hrVo=
X-Gm-Message-State: AOJu0YwmaMAEgFnvblhg0VrbE6VZmwdxW0EvhEUbdJix9w0gWok/Fd8g
	JSbwNyFa59f44M2tU59TsSlAblu9m9sFL6UHTt068KIqqUuF5O/JBd9XUqQ94BJdFRk5LVYMhpJ
	WLn/DmijfUaAzruRK7aYoDkuDou8cTN3rY3yWDHUOoIznnFoVQHxP9lWluUV9V/DU
X-Received: by 2002:adf:e410:0:b0:361:f6b5:c158 with SMTP id ffacd0b85a97d-363192ce375mr1196502f8f.55.1718782372357;
        Wed, 19 Jun 2024 00:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWu8WQcXPnvy3BVybhXSi/i857J9YUn472E47YOCG8+sh0GllZpTAgcvjYtFfrr1zBYku75w==
X-Received: by 2002:adf:e410:0:b0:361:f6b5:c158 with SMTP id ffacd0b85a97d-363192ce375mr1196472f8f.55.1718782371635;
        Wed, 19 Jun 2024 00:32:51 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093a4asm16316367f8f.21.2024.06.19.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:32:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:32:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240619032703-mutt-send-email-mst@kernel.org>
References: <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
 <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 18, 2024 at 09:51:41PM +0900, Shunsuke Mie wrote:
> 2024年6月18日(火) 19:47 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > > 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> > > >
> > > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > > Thank you for your response.
> > > > >
> > > > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > > > >
> > > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > > Let's clarify the situation.
> > > > > > >
> > > > > > > The Virtio device and driver are not working properly due to a
> > > > > > > combination of the following reasons:
> > > > > > >
> > > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > > > Physical DMAC to be used.
> > > > > > > - This feature is not available in the legacy spec.
> > > > > >
> > > > > > ... because legacy drivers don't set it
> > > > > >
> > > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > > >
> > > > > > It's a PCI capability actually. People have been asking
> > > > > > about option to make it a pcie extended capability,
> > > > > > but no one did the spec, qemu and driver work, yet.
> > > > > >
> > > > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > > > >
> > > > > > why not?
> > > > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > > > virtio's.
> > > >
> > > > Okay. So where could these structures live, if not in pci config?
> > > What does "these structures" refer to? PCIe Capabilities? virtio configs?
> >
> > Virtio uses a bunch of read only structures that look like this:
> >
> > struct virtio_pci_cap {
> >
> >         ..... [skipped, specific to pci config caps] ...
> >
> >         u8 cfg_type;    /* Identifies the structure. */
> >         u8 bar;         /* Where to find it. */
> >         u8 id;          /* Multiple capabilities of the same type */
> >         u8 padding[2];  /* Pad to full dword. */
> >         le32 offset;    /* Offset within bar. */
> >         le32 length;    /* Length of the structure, in bytes. */
> > };
> >
> >
> > The driver uses that to locate parts of device interface it
> > later uses.
> >
> >
> > Per spec, they are currently in pci config, you are saying some devices
> > can't have this data in pci config - is that right? Where yes?
> I understood. The configuration structure is in the space that is
> indicated by BAR0.
> Follows the instructions in the spec:
> ```
> 4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
> Transitional devices MUST present part of configuration registers in a
> legacy configuration structure in BAR0 in the first I/O region of the
> PCI device, as documented below.
> ...
> ```

No, and it's best everyone stopped talking about legacy like we
are going to add new features to it.

The configuration structure is in the space that is
indicated by the vendor specific structure, which is currently
in pci config space.

If use of a vendor specific structure in pci config space is
problematic, we can try to fix that by extending the virtio spec.


> >
> > > > --
> > > > MST
> > > >
> >


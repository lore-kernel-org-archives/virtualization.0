Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711629D0E
	for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745154466; cv=none; b=fI7TH1rJqxvRr8l67G5PJykbhemR1OY3E977Nw6tWknAgw1Nogn1bme3DKXyFCfGJpvSbujSNuBBBcduZzpOos8jVhkiw9vh2TpyOWHSTpMl8lVmfRtV1ZQXWT++3zPcUfcL1/Pdfk7tRN9uG0NB7PYr41dQCSS7NlN5GvH058c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745154466; c=relaxed/simple;
	bh=nPrCaNCN8/6sDzEWqsJhz+CqjgCQF82LweL2Utpr7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CMdeJKygoK5+4o5xJpS/5C8V3GamiCu6PhHJ6uBI4hQ0bxbksZZguMN4NV2FfJNhMk+DQ79IrUzTE0nb7sqK17c6j+HKik7+2uSyJncn9VBpSWlmCFbD+XGqF5vaIbsnS1IZ7adSJd0JDirZ2YvDYW91nMKInAOoSVMO/4LEqwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lzh9/OzW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lzh9/OzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745154461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tie+47PKAcwdCHZNvGQCdPNVeSzpJG6j1yFv957U9P8=;
	b=Lzh9/OzWtpZWms1XbldBPuYm4betQG78fc7fWygCPMGm/Lhv1xjPYVFYwfEW6O1zTtRbdQ
	HAy9B1FGjd7LZAGbexi0GAIw7fY/93G5QXuUkSn/rwVJjfVw+TDuxaOfPkILTPIBxmLDu/
	RAk8au8Z0Eg44MjilB1RBBQbOq+ILg8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-a4H5QUZqOLKLtXDp6x5k_w-1; Sun, 20 Apr 2025 09:07:38 -0400
X-MC-Unique: a4H5QUZqOLKLtXDp6x5k_w-1
X-Mimecast-MFC-AGG-ID: a4H5QUZqOLKLtXDp6x5k_w_1745154457
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43efa869b19so19385505e9.2
        for <virtualization@lists.linux.dev>; Sun, 20 Apr 2025 06:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745154457; x=1745759257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tie+47PKAcwdCHZNvGQCdPNVeSzpJG6j1yFv957U9P8=;
        b=SpczkJwPZBwyxWcYQU+uwr6NV6HzzV4tYCIVXCl+dvhvoKUSrKwVE+5h2i5LaWCxLy
         LafAsd+/3RjYJ2R3d+FUn/CCYawWLjeG9LeC7VbPSnMk1MtbuQ1sMSurOiGoxM4XvtdG
         uK8b2FRcmRHkIbQJ6Xu2M7L6qvgbZw/I1RL0Rv+dr74WCxwIj9eTDMRo2oW2otGeyLeY
         utBeUQnYwzUil6WS2UteE2OnCnWSP0ioecIi8RuA1n/T7BO1lUJI9FzeqWtyZWrSpscc
         IUaj2e0nEYXb0jcrkptWFvq1OcBGn7gsKp6SJw0YprwXb22YBUfT19beP6grSI72fOMC
         cVmg==
X-Forwarded-Encrypted: i=1; AJvYcCWV3lHA7hU+nWrTPRiz89Zr1tCl1sKBfYaK4xIib6RWmHDUQSZK+IZJcOq8xq0kIQq7k9kBKHohOhHikcVQaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw73Dw7LKuTpccNdzNWPikAfmT6MdVIqeog1FOc6+D4WG/Nh5Wt
	gAutB7EaZnGoMkJ+T9Q2KamdLWvxtSXFtabBu1T+SdBEhe8XtQC8eKl5T41iEl2emzD1aPhbqOQ
	ss/H+AZ51su2fecFOYNRRfnI92wot/6fEyIMF2SUaddb6Rmp0s1/M1/2bdHy2K42G
X-Gm-Gg: ASbGncuofsXAI/0d41LsdqrrT83M/Bz8X1qH9DJi2zx/XwujWo/2725wrOFMXLBMy2O
	2J/tnYSosnMxeERfR3jBzpHQL0Vjid3B3G/J0ejrwLZu+NzvAz82i7NBE+I0IVmcOm2Vhl+/Yna
	jNjA10u4j9Yx88kWTcDQ8WnUyiQR0GveCG85dlsB01cMC8YYPKq8NkNCeh4PF+ihN6FCKkejAb+
	nvO6WWnwzN0/moDVSIUQUdJs3uBNvzKJGeSfaWaqvF7WKhPQ8eiiZVBCP4TTF7b3CCbP7JiIh62
	xKmfEw==
X-Received: by 2002:a5d:64ae:0:b0:38f:3e1c:211d with SMTP id ffacd0b85a97d-39efba5081cmr7406525f8f.14.1745154456805;
        Sun, 20 Apr 2025 06:07:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+kcOnT31QO7lRdUT3jxLPnPZ0lxc0FgFx0lkebfWhmP4rLv3scX26LDI+yYy9dAIQ1L0v8g==
X-Received: by 2002:a5d:64ae:0:b0:38f:3e1c:211d with SMTP id ffacd0b85a97d-39efba5081cmr7406502f8f.14.1745154456435;
        Sun, 20 Apr 2025 06:07:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4206ecsm9004253f8f.17.2025.04.20.06.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 06:07:35 -0700 (PDT)
Date: Sun, 20 Apr 2025 09:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Israel Rukshin <israelr@nvidia.com>, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for
 device writable portions
Message-ID: <20250420090604-mutt-send-email-mst@kernel.org>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vYi8I-1dB3Ez7VgDWumBIsLovL_QN3T0aXiH0TmzGIw_1745154457
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
> 
> On 20/04/2025 14:33, Michael S. Tsirkin wrote:
> > On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
> > > Add a safety check to ensure that the length of data written by the
> > > device is at least as large as the status length. If this condition is
> > > not met, it indicates a potential error in the device's response.
> > > 
> > > This change aligns with the virtio specification, which states:
> > > "The driver MUST NOT make assumptions about data in device-writable
> > > buffers beyond the first len bytes, and SHOULD ignore this data."
> > > 
> > > By failing the admin command when len is insufficient, we ensure
> > > that the driver does not process potentially invalid or incomplete
> > > status from the device.
> > > 
> > > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > ---
> > >   drivers/virtio/virtio_pci_modern.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > index 7209390a5cbf..0374e86aece3 100644
> > > --- a/drivers/virtio/virtio_pci_modern.c
> > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > >   {
> > >   	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > >   	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> > > +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
> > >   	struct virtio_admin_cmd *cmd;
> > >   	unsigned long flags;
> > >   	unsigned int len;
> > > @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > >   	do {
> > >   		virtqueue_disable_cb(vq);
> > >   		while ((cmd = virtqueue_get_buf(vq, &len))) {
> > > -			cmd->result_sg_size =
> > > -				len - sizeof(struct virtio_admin_cmd_status);
> > > +			if (len < status_size)
> > > +				cmd->ret = -EIO;
> > > +			else
> > > +				cmd->result_sg_size = len - status_size;
> > >   			complete(&cmd->completion);
> > >   		}
> > 
> > 
> > No this is out of spec:
> > 	Similarly, the driver compares the used buffer length
> > 	of the buffer to what it expects and then silently
> > 	truncates the structure to the used buffer length.
> > 	The driver silently ignores any data falling outside
> > 	the used buffer length reported by the device.  Any missing
> > 	fields are interpreted as set to zero.
> > 
> > so if status is 0, device can just write a shorter buffer and
> > driver must assume 0, which is success, not failure.
> 
> maybe we can make a sanity check that the len is at least 4B (status and
> status_qualifier) which is basic size to make sure device is acting as
> expected ?
> 


The spec says nothing about this. Just zero-initialize the buffer
beyond len and be done with it.

> 
> > 
> > 
> > 
> > >   	} while (!virtqueue_enable_cb(vq));
> > > -- 
> > > 2.34.1


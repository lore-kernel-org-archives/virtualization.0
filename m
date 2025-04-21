Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625D4263F3B
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745235006; cv=none; b=qt2wyoXfZjXU6Ip60sM4zHOaFi4/xApJREOjpipXlLlB47jUoEZW80dmXvmSsBbREdCCpfoV17OwoHQ9QjKsa47LuUH2d+ogkNbIm4mYDF0ImJ6/KqpEKNHdSVi16veGJ8Ix2rTbKvsYMenAnJ6HaZGTM06CyKqCnqzSR++KG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745235006; c=relaxed/simple;
	bh=eNt3b/AUKzRuzXNbSqzeKKx+00IbDgeiXz42Lm1lExQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=N49fPo3dOPQ/gz8qZduaKMyKcShnxt3ji6a/BPtbE1J0PTftjhOwp5XzRTsBsnxekaIiWeqvnNhpkgD28uF4sOGBpI/vjqVxU1POrxZYIoGEt0bhsHGQngOrxK9a0aNQx9zWPivg26V9GHOmBE0HXfMAZtHb3L2GJtg3CY2YGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezamOShD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezamOShD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745235003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/d+LHErioy2YCsrpqYCxpDu4o475ZnWLKYcfDCjLgUY=;
	b=ezamOShDUnFSBMRN+Tyb0VAHagmyy8Xsx2RDR8hjeLRvlMB1kSND8hk5BthizBvngPoFMu
	VI8ja7nwUUrREkgGWLdbjJIUrqNnLou9pKb3To08C6g0zjzWsVRplz+MFaQNOxQOLb14Cu
	6YyP5QS8alTYFj3ITUX4t8mgGK6O8Xw=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-R2-LVbmEN5-d3sgbpqLsHA-1; Mon, 21 Apr 2025 07:30:01 -0400
X-MC-Unique: R2-LVbmEN5-d3sgbpqLsHA-1
X-Mimecast-MFC-AGG-ID: R2-LVbmEN5-d3sgbpqLsHA_1745235001
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5240a43243dso4366906e0c.1
        for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 04:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745235001; x=1745839801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d+LHErioy2YCsrpqYCxpDu4o475ZnWLKYcfDCjLgUY=;
        b=ktgce4LTGtIY6U8i6aP+UT8j1wq+4FTTpnd9fH3nPYCYxyclHQVD20RveyrfwcHGGr
         DpY6E3J/q4qKKGaiiev6IZYNDizDsxv8JUtuba39x/4qPNyLNvyiBKImxl2FHGwv/Fec
         JrsuyrsRgMm9Lo2GN1TqGY03A0MUNtTgs5/ungVrbFCVqVQn1UUA7rIvf+x+r3rP1IDk
         xG3fYjflKGqIKl1iiI/Q84u84ntgkpxEL07aNMwQXXBBEkKKntMSIeOkn9J9dnTh80++
         aQHvIAFtF2+L+LQLmdEV4/zLb8+z8hK0JRVdDoVHizYurq/I9P1jo/r+QhUj7Y7EAne+
         1GMw==
X-Forwarded-Encrypted: i=1; AJvYcCWLlCCFVg35zeNPZdiRg5BRKHW4m6gSSr53GPFhh5ETnkijsO6nPO+9EwMLRik6qBGHsYhIb9mgopjLUpOewQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPyNXfx8V+yOADyZ8JMyDylllVcWx+dyD2Abf2PW45oPkf7MDk
	2oi/zPGJJAhuBymkS+Bq3FJeCnRABOp4jRANVNf8w3sgU0Libsdb6ZRx1ysqosRAOFEkZe8ymkL
	BgvLvAqzv3W/WjRQVqtWMn1XwNYT6KwXaDeORSW7lMtKNNyG+rMd1ogtm4lwNcGdE
X-Gm-Gg: ASbGncskZIzsEtDAjT452CVm0mqvhj2X3/Kl/5zqbBf0kw/YvfZtC6mrSbwjFWuB51H
	kaInKuhG20qh9vWCD9yTkQ8xpYX6hQyGJJdSOAPeqvnDmMHwLR7OU56bTja4QVc/ZYNpYp3nMNS
	Bt/RbBBqXi/pmASZWq7k8CeKDhCZ61owTJMrTNqUivu2cFyYn1LvtWBaCDrmN6lTkh95CYTBzs5
	kmBSBISqruzdnPXcqbUBYPCUOGqOMdZePJl03wuN88H/yx4gNFQaF4sKH/Wn2wUxpMWH3kxhqVQ
	Zg==
X-Received: by 2002:a05:6122:2092:b0:520:4fff:4c85 with SMTP id 71dfb90a1353d-529267e722bmr7269125e0c.2.1745235001189;
        Mon, 21 Apr 2025 04:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtXJhXfzdCJDlzVDddyhUDfGlJwG29Gv+ndVcxdvnZqRR2eWjLWVSjK5qaLpqr0xl3i0jDFw==
X-Received: by 2002:a05:6122:2092:b0:520:4fff:4c85 with SMTP id 71dfb90a1353d-529267e722bmr7269115e0c.2.1745235000874;
        Mon, 21 Apr 2025 04:30:00 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922c10c1bsm1401234e0c.12.2025.04.21.04.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 04:30:00 -0700 (PDT)
Date: Mon, 21 Apr 2025 07:29:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for
 device writable portions
Message-ID: <20250421071734-mutt-send-email-mst@kernel.org>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
 <20250420090604-mutt-send-email-mst@kernel.org>
 <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FugNo9pInM-9Y-cBR6ugtg5dYb2tsAnNa18s17XGiW8_1745235001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 21, 2025 at 02:05:27PM +0300, Israel Rukshin wrote:
> On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
> > On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
> > > On 20/04/2025 14:33, Michael S. Tsirkin wrote:
> > > > On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
> > > > > Add a safety check to ensure that the length of data written by the
> > > > > device is at least as large as the status length. If this condition is
> > > > > not met, it indicates a potential error in the device's response.
> > > > > 
> > > > > This change aligns with the virtio specification, which states:
> > > > > "The driver MUST NOT make assumptions about data in device-writable
> > > > > buffers beyond the first len bytes, and SHOULD ignore this data."
> > > > > 
> > > > > By failing the admin command when len is insufficient, we ensure
> > > > > that the driver does not process potentially invalid or incomplete
> > > > > status from the device.
> > > > > 
> > > > > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > ---
> > > > >    drivers/virtio/virtio_pci_modern.c | 7 +++++--
> > > > >    1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > index 7209390a5cbf..0374e86aece3 100644
> > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > >    {
> > > > >    	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > > > >    	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> > > > > +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
> > > > >    	struct virtio_admin_cmd *cmd;
> > > > >    	unsigned long flags;
> > > > >    	unsigned int len;
> > > > > @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > >    	do {
> > > > >    		virtqueue_disable_cb(vq);
> > > > >    		while ((cmd = virtqueue_get_buf(vq, &len))) {
> > > > > -			cmd->result_sg_size =
> > > > > -				len - sizeof(struct virtio_admin_cmd_status);
> > > > > +			if (len < status_size)
> > > > > +				cmd->ret = -EIO;
> > > > > +			else
> > > > > +				cmd->result_sg_size = len - status_size;
> > > > >    			complete(&cmd->completion);
> > > > >    		}
> > > > 
> > > > No this is out of spec:
> > > > 	Similarly, the driver compares the used buffer length
> > > > 	of the buffer to what it expects and then silently
> > > > 	truncates the structure to the used buffer length.
> > > > 	The driver silently ignores any data falling outside
> > > > 	the used buffer length reported by the device.  Any missing
> > > > 	fields are interpreted as set to zero.
> > > > 
> > > > so if status is 0, device can just write a shorter buffer and
> > > > driver must assume 0, which is success, not failure.
> > > maybe we can make a sanity check that the len is at least 4B (status and
> > > status_qualifier) which is basic size to make sure device is acting as
> > > expected ?
> > > 
> > 
> > The spec says nothing about this. Just zero-initialize the buffer
> > beyond len and be done with it.
> 
> What do you think on the bellow change for v2?
> 
> @@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
>         do {
>                 virtqueue_disable_cb(vq);
>                 while ((cmd = virtqueue_get_buf(vq, &len))) {
> -                       cmd->result_sg_size = len;
> +                       /* If the length written is less than the status
> size,
> +                        * the remaining status bytes stay zero-initialized.
> +                        */
> +                       if (len < status_size)
> +                               cmd->result_sg_size = 0;
> +                       else
> +                               cmd->result_sg_size = len - status_size;
>                         complete(&cmd->completion);
>                 }
>         } while (!virtqueue_enable_cb(vq));

Can you please explain what exactly is this change doing?
The changelog claims all that is done is adding a check,
but that's not true: previously we reported the whole length. Now you want to report
length less status_size. This is a userspace-visible change, is it not?



> > > > 
> > > > 
> > > > >    	} while (!virtqueue_enable_cb(vq));
> > > > > -- 
> > > > > 2.34.1


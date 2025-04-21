Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D406EB7C
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244755; cv=none; b=Dw9yq7DG1P/NpFkrmmZERoWLLkSyj6GI8anAIwuPoib+KV459MejGocKrBQvkwCGU9uKpJyP7H4kiAdOPzpHJ7sS3DdQ+CnzUs0k89MFUBlq0VVieNtn0E+fcphK6/UXGa2Oz5S5vx75abIKuVf4NWYLyJZnByIjRxbuN2U32OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244755; c=relaxed/simple;
	bh=sbGCIwSyzHfv/f2eEZgOBo2+QePkKC+X/WsyaXl11M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PUbqIykoVAyKGS48K57zLZLyCR8PxN23qlSaH963GeTbdz1tjgXRE5MMHKBuiVgH/oAEpps8Js/MBhm9p8M947U0RwYDoiFy/Onlo+tDZ7lO8DaUyKa2pSmtP7ZLJ24iI1KkDTH/h3ZqJ9b9z0f7G0I7YAwnAAnfee5H384ej64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cynq5dRr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cynq5dRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745244752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nO6f89h82ourq9BvbgI0w0Ytk18wn5ISKiV8XHU1SYg=;
	b=Cynq5dRrW6f+abVA6VHujgH1i0KW2d2knJf7+WbGbwLT4QxCMU8kVWOVFQyTKhRBjC1vIs
	qwCkk/bHRnJCFlqzJ0dPu4327AsrS5taCARBmMSpj/gTevPfKWI400kEuZ3inUg8EVxaTH
	fMfOMzyQzyj0BwRHBpE53jDJaqqUOMM=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-SssPdEZAM4aVs4Bqa_3eJQ-1; Mon, 21 Apr 2025 10:12:31 -0400
X-MC-Unique: SssPdEZAM4aVs4Bqa_3eJQ-1
X-Mimecast-MFC-AGG-ID: SssPdEZAM4aVs4Bqa_3eJQ_1745244751
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-875a2033753so4485962241.2
        for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 07:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745244751; x=1745849551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nO6f89h82ourq9BvbgI0w0Ytk18wn5ISKiV8XHU1SYg=;
        b=dtKQauo8cbXqZcOePfcUtLpG0lf9RfJMKbW+s7Y7Z7iujgp/u0jyR2SbT+VwKJBzmo
         CZz1/q6gg6eSxU3u7hoCkT/acQnQDF7DKipJBIV5qtAqtF84udgAOZLW2tC+qa8y5ERf
         0wC7nHdDvtV4nzplG+ak5ptBlNvyT9gS1+DwwoS1WIDq8dg8OCZQ2AIHVa3WRDujavZH
         3O1ZtqLKxTT0yG7vJPsVEb8CokwAWCL2B0KZ4tqnhdAK3mWbnfR6oDNI/xwbgWPeZLRw
         afdhv7OF7VSYm5MqY1Z6XrnuglYmky7GerDMsYMHX310iv52gDWN9WzQIQN9h2k1csnn
         L2zg==
X-Forwarded-Encrypted: i=1; AJvYcCU9yUgYly+38NLRKkDaxvW8XozjZkHf4G+NUB9zDmSXJnt0G8KlhSqY5joyrL8/Erifx94clgfimDw1a+OnGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRMfacRK+KUb8VUN9i5yPv8cnylWyvNfGnzr588dAfVzO/xa+W
	NxzVm10Bu4nMzGR8LGpPZ1hT0ST34Z3DsuDrNfs/tQ7LK5EYFBuAlSKHJmEf1VTWPBKuBjF9PdV
	RXqWwX3peN60cLTaTyXnz91oE3ZZIAsj0hwD1dwLjLLJBXyLztHKwTMM2UD+AxJ60
X-Gm-Gg: ASbGnctK7w5xWee8iC+82H21rCBD1RR7jfReL2MM4dKNmZ+OmC16PwwtONxQkzj0EzS
	fWXm49k2oJ+ObyyqwqxJtox/EK/hDctFLjwTC0XArP1qcRO4aamTLMlnj/JPNFgTm6jXhyFauVW
	WbsFA+90HkvKZYAJqL23g0deufOZHC6eyEW0wF3m2q24WKsLapCHAaMEIkA7Lg3p7oM6umjKWgl
	t/MiD3Th7D9HLDbJRxhbd+zGE8OgFYPMJNj9AUTgE/uLbaNmbSnChqbGQg3OkOjHue/2YG6EqMt
	SQ==
X-Received: by 2002:a05:6102:367:b0:4c1:94df:9aea with SMTP id ada2fe7eead31-4cb80134c1amr6522327137.15.1745244750877;
        Mon, 21 Apr 2025 07:12:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvquyMOG1b+pkYQgCmPPP7vNsJ1WGlOBnRge9UTqdPasqR72OlElXPI62eAkjdIpFoxrjcIw==
X-Received: by 2002:a05:6102:367:b0:4c1:94df:9aea with SMTP id ada2fe7eead31-4cb80134c1amr6522296137.15.1745244750581;
        Mon, 21 Apr 2025 07:12:30 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dfff822sm1629381137.23.2025.04.21.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:12:30 -0700 (PDT)
Date: Mon, 21 Apr 2025 10:12:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for
 device writable portions
Message-ID: <20250421101137-mutt-send-email-mst@kernel.org>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
 <20250420090604-mutt-send-email-mst@kernel.org>
 <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
 <20250421071734-mutt-send-email-mst@kernel.org>
 <af1e660c-3252-4f13-b0a1-4718e5ce4420@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <af1e660c-3252-4f13-b0a1-4718e5ce4420@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pLbhOIrUbDJB3wLPYHC5vFqpdHEGkUZ5h2XHuNE5DHM_1745244751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 21, 2025 at 03:36:21PM +0300, Israel Rukshin wrote:
> On 4/21/2025 2:29 PM, Michael S. Tsirkin wrote:
> > On Mon, Apr 21, 2025 at 02:05:27PM +0300, Israel Rukshin wrote:
> > > On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
> > > > On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
> > > > > On 20/04/2025 14:33, Michael S. Tsirkin wrote:
> > > > > > On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
> > > > > > > Add a safety check to ensure that the length of data written by the
> > > > > > > device is at least as large as the status length. If this condition is
> > > > > > > not met, it indicates a potential error in the device's response.
> > > > > > > 
> > > > > > > This change aligns with the virtio specification, which states:
> > > > > > > "The driver MUST NOT make assumptions about data in device-writable
> > > > > > > buffers beyond the first len bytes, and SHOULD ignore this data."
> > > > > > > 
> > > > > > > By failing the admin command when len is insufficient, we ensure
> > > > > > > that the driver does not process potentially invalid or incomplete
> > > > > > > status from the device.
> > > > > > > 
> > > > > > > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > ---
> > > > > > >     drivers/virtio/virtio_pci_modern.c | 7 +++++--
> > > > > > >     1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > > index 7209390a5cbf..0374e86aece3 100644
> > > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > > @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > > > >     {
> > > > > > >     	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > > > > > >     	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> > > > > > > +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
> > > > > > >     	struct virtio_admin_cmd *cmd;
> > > > > > >     	unsigned long flags;
> > > > > > >     	unsigned int len;
> > > > > > > @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > > > >     	do {
> > > > > > >     		virtqueue_disable_cb(vq);
> > > > > > >     		while ((cmd = virtqueue_get_buf(vq, &len))) {
> > > > > > > -			cmd->result_sg_size =
> > > > > > > -				len - sizeof(struct virtio_admin_cmd_status);
> > > > > > > +			if (len < status_size)
> > > > > > > +				cmd->ret = -EIO;
> > > > > > > +			else
> > > > > > > +				cmd->result_sg_size = len - status_size;
> > > > > > >     			complete(&cmd->completion);
> > > > > > >     		}
> > > > > > No this is out of spec:
> > > > > > 	Similarly, the driver compares the used buffer length
> > > > > > 	of the buffer to what it expects and then silently
> > > > > > 	truncates the structure to the used buffer length.
> > > > > > 	The driver silently ignores any data falling outside
> > > > > > 	the used buffer length reported by the device.  Any missing
> > > > > > 	fields are interpreted as set to zero.
> > > > > > 
> > > > > > so if status is 0, device can just write a shorter buffer and
> > > > > > driver must assume 0, which is success, not failure.
> > > > > maybe we can make a sanity check that the len is at least 4B (status and
> > > > > status_qualifier) which is basic size to make sure device is acting as
> > > > > expected ?
> > > > > 
> > > > The spec says nothing about this. Just zero-initialize the buffer
> > > > beyond len and be done with it.
> > > What do you think on the bellow change for v2?
> > > 
> > > @@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > >          do {
> > >                  virtqueue_disable_cb(vq);
> > >                  while ((cmd = virtqueue_get_buf(vq, &len))) {
> > > -                       cmd->result_sg_size = len;
> > > +                       /* If the length written is less than the status
> > > size,
> > > +                        * the remaining status bytes stay zero-initialized.
> > > +                        */
> > > +                       if (len < status_size)
> > > +                               cmd->result_sg_size = 0;
> > > +                       else
> > > +                               cmd->result_sg_size = len - status_size;
> > >                          complete(&cmd->completion);
> > >                  }
> > >          } while (!virtqueue_enable_cb(vq));
> > Can you please explain what exactly is this change doing?
> > The changelog claims all that is done is adding a check,
> > but that's not true: previously we reported the whole length. Now you want to report
> > length less status_size. This is a userspace-visible change, is it not?
> > 
> Sorry for the confusion.
> 
> This change is essentially PATCH 1/2 from this series with the addition of
> handling the case when len is smaller than status_size to avoid getting a
> negative value.
> According to your comments, I will remove PATCH 2/2 and post only PATCH 1/2
> with this change.
> You are correct, this is a userspace-visible change, and the size currently
> reported in virtio_pci_admin_dev_parts_get() is incorrect.


Sounds good. My only question is, how bad is the current condition?
is there a chance userspace will try to work around it?


> > 
> > > > > > 
> > > > > > >     	} while (!virtqueue_enable_cb(vq));
> > > > > > > -- 
> > > > > > > 2.34.1


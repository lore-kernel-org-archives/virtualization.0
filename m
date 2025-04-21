Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43533086
	for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247986; cv=none; b=KcvBuFhi4fQaC5EBLy1NAu2WjeZ7zCcoDnZkLIx6tp8p1nbpfbmWAodJeQslnJIXtgayVETFFrXQq2SRb2imQHA1LOKtrqpl2z3KGgu8KGKN/SVtBowIGsNqr+XC1gvqsIGYaK0urFC7NIZo/05jNbs6N4xj1qnJIfzzRAPQvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247986; c=relaxed/simple;
	bh=8pUSAt+oefXqQcjmWxPl2meHFEt80FdfuUAQdf291ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GzIt2OpXIyjx2jT7u3wIkamWP7Q7yBeGMhoyTxOfengoTG+WxYLbDQFrb3lmXFrmgiqG/VdygmUaSWDiYaYgHDxrW03sGLr6up4DKz+WUZZLQ6NzpMWv0vMjAv+18fztrRbHuMeujECI78mQTl4XEGmVELuaDatwR03Erb1XHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BF4DlAom; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BF4DlAom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745247982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U0VxVKuuu4aWvOQhhAMKT1SPdikEEDzCYY202G6bnaw=;
	b=BF4DlAomnczc+2DG0sAUvd9GL6h1dSq8EQEM+E3reHcO5b2RXMNktTw+nYMMl2RM3mz+as
	eDf1mXmrq7vNXTqbD6XlS/GVGxgZaGD2K6pucU69WthZGL4V1FsimCatxgK2yH8Zu/Rfp0
	7JC/gOZmC4PfntbS2gNfvxmK3KDofls=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-Fz6inP_cPhCpP57hXzt7Jw-1; Mon, 21 Apr 2025 11:06:21 -0400
X-MC-Unique: Fz6inP_cPhCpP57hXzt7Jw-1
X-Mimecast-MFC-AGG-ID: Fz6inP_cPhCpP57hXzt7Jw_1745247981
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-86d8c567446so797153241.1
        for <virtualization@lists.linux.dev>; Mon, 21 Apr 2025 08:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745247981; x=1745852781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0VxVKuuu4aWvOQhhAMKT1SPdikEEDzCYY202G6bnaw=;
        b=CKQEasZBY3V75c/HXsWf72Cr+s9hQBl4s7wHmIGLK/QTBT2i9uBWDwq4qXteKjwZ55
         A14TBLUP/7Bdot9CtB9WvlrB6z+LiIdKGmvdh85n8axrljrfonmTrERLPmXo50OSvBFt
         lq92Hjp+Cc506D97mj1/k1Lu0xPWphG02REDX118U0nlTNjhs/RoDNlLoyUIKq2I0NNn
         64vjsv+blwRH+4EQ283DfAS89BV/26xncuvo2XFPIqr1ls01TYexR2Q7n0Oa9NSL8qRD
         0usWYfszQgxJz211yRj4YPqrESe+8gDLUQjrp5HsAIJIFNQwELmKRB1jVU77IVJa6z+6
         85QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMKf0Aa2M4Z1lAQLLz59uISzIuHHvoKsUDfWMq/PHccRuMCzyzKVqQ3Ezg8z4jrhnAPWsLATl5I2VdCU4KQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMblmJuYZ76jBZwNv/+GocOf6dVaKrvCk5BbLid7cB8l+P/5Dx
	l+gVDYE29JP59H2QeSYEo6sGfDFwXqImnWbiwJkSINXqoil4dAALuz7VvVp863J+UUf4KDoQRqU
	OonsXm68LHX31I0xBmK5jhBvwbmpSdhGNvSv3Gw0WX+mCx68Wsi7OKFm/cjV0Ta7e
X-Gm-Gg: ASbGncuyzjS5M/weJd3w0WRtCId1N1oZEogM5/zrnkByUc0Ke6oW5RuvEzPklePf1Sn
	Qj15/kRMyG0yfaejwWK/14qBliC7LrPK+5nbAqDOCRnl+nlnLl0IpXeFqyuPYh4SNkiixzoYLTR
	gEtzECX4LurhReaAHkJJQFxDIVyanomaAyeljOa1pOZpfHfgxgORo1cyvcZ6I/tlnLvz45KOeBn
	LklgjioJlWAql5Fz8qA/ukfp/eWcevJISE9ivaXC/62GuWTTTWJXZ9BYXTFHYIMh0zqqKAcVMvf
	dA==
X-Received: by 2002:a67:f096:0:b0:4c3:7f7:92f4 with SMTP id ada2fe7eead31-4cb800dcb72mr5746010137.6.1745247980927;
        Mon, 21 Apr 2025 08:06:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvx6nWFIMI0oyOuaqBNS1aEWNYGmvDTlHZimhUdIJlVBHrwurfUHfnoZr9MDD7QsaYKppMYQ==
X-Received: by 2002:a67:f096:0:b0:4c3:7f7:92f4 with SMTP id ada2fe7eead31-4cb800dcb72mr5745966137.6.1745247980427;
        Mon, 21 Apr 2025 08:06:20 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dffee13sm1636135137.19.2025.04.21.08.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:06:19 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:06:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH 2/2] virtio-pci: Add admin command length check for
 device writable portions
Message-ID: <20250421110458-mutt-send-email-mst@kernel.org>
References: <1745147945-194225-1-git-send-email-israelr@nvidia.com>
 <1745147945-194225-3-git-send-email-israelr@nvidia.com>
 <20250420073230-mutt-send-email-mst@kernel.org>
 <b9e80050-9d09-4ed7-ab05-6a23a8e6e6a9@nvidia.com>
 <20250420090604-mutt-send-email-mst@kernel.org>
 <f8ee410c-bfbb-4364-8e1e-c73ee7147fc6@nvidia.com>
 <20250421071734-mutt-send-email-mst@kernel.org>
 <af1e660c-3252-4f13-b0a1-4718e5ce4420@nvidia.com>
 <20250421101137-mutt-send-email-mst@kernel.org>
 <28749eee-7dcb-4f25-923a-0a858a661610@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <28749eee-7dcb-4f25-923a-0a858a661610@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x67vpmTGqMWeFNqCyN45jNKuHRV76KiETMc0M_Q2lxI_1745247981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 21, 2025 at 06:00:27PM +0300, Israel Rukshin wrote:
> On 4/21/2025 5:12 PM, Michael S. Tsirkin wrote:
> > On Mon, Apr 21, 2025 at 03:36:21PM +0300, Israel Rukshin wrote:
> > > On 4/21/2025 2:29 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 21, 2025 at 02:05:27PM +0300, Israel Rukshin wrote:
> > > > > On 4/20/2025 4:07 PM, Michael S. Tsirkin wrote:
> > > > > > On Sun, Apr 20, 2025 at 03:31:25PM +0300, Max Gurtovoy wrote:
> > > > > > > On 20/04/2025 14:33, Michael S. Tsirkin wrote:
> > > > > > > > On Sun, Apr 20, 2025 at 02:19:05PM +0300, Israel Rukshin wrote:
> > > > > > > > > Add a safety check to ensure that the length of data written by the
> > > > > > > > > device is at least as large as the status length. If this condition is
> > > > > > > > > not met, it indicates a potential error in the device's response.
> > > > > > > > > 
> > > > > > > > > This change aligns with the virtio specification, which states:
> > > > > > > > > "The driver MUST NOT make assumptions about data in device-writable
> > > > > > > > > buffers beyond the first len bytes, and SHOULD ignore this data."
> > > > > > > > > 
> > > > > > > > > By failing the admin command when len is insufficient, we ensure
> > > > > > > > > that the driver does not process potentially invalid or incomplete
> > > > > > > > > status from the device.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> > > > > > > > > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/virtio/virtio_pci_modern.c | 7 +++++--
> > > > > > > > >      1 file changed, 5 insertions(+), 2 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > > index 7209390a5cbf..0374e86aece3 100644
> > > > > > > > > --- a/drivers/virtio/virtio_pci_modern.c
> > > > > > > > > +++ b/drivers/virtio/virtio_pci_modern.c
> > > > > > > > > @@ -48,6 +48,7 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > > > > > >      {
> > > > > > > > >      	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> > > > > > > > >      	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
> > > > > > > > > +	unsigned int status_size = sizeof(struct virtio_admin_cmd_status);
> > > > > > > > >      	struct virtio_admin_cmd *cmd;
> > > > > > > > >      	unsigned long flags;
> > > > > > > > >      	unsigned int len;
> > > > > > > > > @@ -56,8 +57,10 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > > > > > >      	do {
> > > > > > > > >      		virtqueue_disable_cb(vq);
> > > > > > > > >      		while ((cmd = virtqueue_get_buf(vq, &len))) {
> > > > > > > > > -			cmd->result_sg_size =
> > > > > > > > > -				len - sizeof(struct virtio_admin_cmd_status);
> > > > > > > > > +			if (len < status_size)
> > > > > > > > > +				cmd->ret = -EIO;
> > > > > > > > > +			else
> > > > > > > > > +				cmd->result_sg_size = len - status_size;
> > > > > > > > >      			complete(&cmd->completion);
> > > > > > > > >      		}
> > > > > > > > No this is out of spec:
> > > > > > > > 	Similarly, the driver compares the used buffer length
> > > > > > > > 	of the buffer to what it expects and then silently
> > > > > > > > 	truncates the structure to the used buffer length.
> > > > > > > > 	The driver silently ignores any data falling outside
> > > > > > > > 	the used buffer length reported by the device.  Any missing
> > > > > > > > 	fields are interpreted as set to zero.
> > > > > > > > 
> > > > > > > > so if status is 0, device can just write a shorter buffer and
> > > > > > > > driver must assume 0, which is success, not failure.
> > > > > > > maybe we can make a sanity check that the len is at least 4B (status and
> > > > > > > status_qualifier) which is basic size to make sure device is acting as
> > > > > > > expected ?
> > > > > > > 
> > > > > > The spec says nothing about this. Just zero-initialize the buffer
> > > > > > beyond len and be done with it.
> > > > > What do you think on the bellow change for v2?
> > > > > 
> > > > > @@ -56,7 +57,13 @@ void vp_modern_avq_done(struct virtqueue *vq)
> > > > >           do {
> > > > >                   virtqueue_disable_cb(vq);
> > > > >                   while ((cmd = virtqueue_get_buf(vq, &len))) {
> > > > > -                       cmd->result_sg_size = len;
> > > > > +                       /* If the length written is less than the status
> > > > > size,
> > > > > +                        * the remaining status bytes stay zero-initialized.
> > > > > +                        */
> > > > > +                       if (len < status_size)
> > > > > +                               cmd->result_sg_size = 0;
> > > > > +                       else
> > > > > +                               cmd->result_sg_size = len - status_size;
> > > > >                           complete(&cmd->completion);
> > > > >                   }
> > > > >           } while (!virtqueue_enable_cb(vq));
> > > > Can you please explain what exactly is this change doing?
> > > > The changelog claims all that is done is adding a check,
> > > > but that's not true: previously we reported the whole length. Now you want to report
> > > > length less status_size. This is a userspace-visible change, is it not?
> > > > 
> > > Sorry for the confusion.
> > > 
> > > This change is essentially PATCH 1/2 from this series with the addition of
> > > handling the case when len is smaller than status_size to avoid getting a
> > > negative value.
> > > According to your comments, I will remove PATCH 2/2 and post only PATCH 1/2
> > > with this change.
> > > You are correct, this is a userspace-visible change, and the size currently
> > > reported in virtio_pci_admin_dev_parts_get() is incorrect.
> > 
> > Sounds good. My only question is, how bad is the current condition?
> The migration fails if the state size is exactly 4KB, because the allocated
> buffer (4KB) is smaller than the amount the user is trying to read (4KB + 8
> bytes).
> For other state sizes, there are an extra 8 bytes of data at the end of the
> state.
> According to the specification, the device at the destination must fail the
> migration because this is not a valid state.
> > is there a chance userspace will try to work around it?
> I am not aware of.

My concern is userspace might try to work around this bug..
Do you want to add a module attribute to tell userspace it's fixed?


> > 
> > 
> > > > > > > > >      	} while (!virtqueue_enable_cb(vq));
> > > > > > > > > -- 
> > > > > > > > > 2.34.1


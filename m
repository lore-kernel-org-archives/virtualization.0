Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43030AAA6
	for <virtualization@lists.linux.dev>; Sun,  2 Aug 2026 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785694011; cv=none; b=oG8//sfcivjsyaMYR0d9gWSM47XqjElCVnP0z9FkJKt2G5dYHJiMZ+1JnWiYHn99SoVUuNA21dbUFfXhGLmRvX36iFF+s6qX+0DFPFHdEtbUrP5offADkUHwswgl4GTtsc7MW7FQ0FHkyJhaWvVzm0MU9nzqN81nVkSes1Ul/Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785694011; c=relaxed/simple;
	bh=0721f4vmVaFpsYQoeVth8st770OMdfYYTZ1FRqKCGD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dCWJAEUhB8FP3VmbxwEzhmCTzmvcdRm/sLNoOWhaTUWwVUmVIDvvOLytKSldh+7B6Ed9iwkL9LzOrh+WhZVlqgMUGxO8vkcdxzZ07nf/w3HS92XDRzUXniYDc+pGKWrDefTYkLYjGsDWV/rDcd131Azl7paVKJA4LOZcCiwR7JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZyY7l6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZyY7l6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785694008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ivcDPdF+qxoBSUUmqUxuF9hBASHgxG6u4YtAkrRSfRw=;
	b=XZyY7l6XI+HQ5jwL95NxkORGPIVXTDzRYfqIkiCklVELMSLxMPJ0nr5CXbgZKpanej2vGN
	sSAAU5A75Rk+Zhi8o25eu/1Kr7Iz3oKjswmPwpfuhLs9+JLOF/LF3sLxy3zaHLAD8NqatY
	Ol3/xs0BXRpxdX40ZchbZs4Y6TvDwjs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-pWwqI_TWOXukDjehvOkk_Q-1; Sun, 02 Aug 2026 14:06:45 -0400
X-MC-Unique: pWwqI_TWOXukDjehvOkk_Q-1
X-Mimecast-MFC-AGG-ID: pWwqI_TWOXukDjehvOkk_Q_1785694004
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49808ea1b64so16060365e9.1
        for <virtualization@lists.linux.dev>; Sun, 02 Aug 2026 11:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785694004; x=1786298804;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivcDPdF+qxoBSUUmqUxuF9hBASHgxG6u4YtAkrRSfRw=;
        b=DZTVW7txi9po7relJqLHJZdHX0JHgRInY2ABbcjQTdAZxkyrScXspVS2f8zjDEOMct
         mJxA/PrvNa4gPCtfM1+qvBwxNgxnlDseH32bGgWk/82AVxaNcUzbI1X9WG+0QP2HFbHO
         eIjk+Q/hHIJ//wKvjK+j7PRhgQMBQbc7Ay5+EwrqsX/ES120z1GqmhZ0HFv1nIOQFK1Q
         S9QU2t3+2dwse+53Ogwjg3PZmTrUInMCAU/4xqFNnOkMKIMmu7AKius90j/KGEz4ItiD
         AwD1dCJzxMizXpn5o1G2xlN23tJf//oJEO7rFb40txIB/FrWEOyYWBbSI3zWb5vQSbLM
         i/Hw==
X-Forwarded-Encrypted: i=1; AHgh+RpEdqc5vPyO89SQmlTlBT0mb+P5yQAm8gsMYEixzzbUJGrESlq593vsM9tTAlUDMizwXsc347//v7UQyOJlJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyebRhqct7CbjoXIYCXQ5gMvte3Jqy5n+GIFZgqq93fhCbV4aJS
	llFZyV2Tk0jEC3Lz6SXwpzgfpHB8mHSYOIfjr0WmbHtlgpsIChvCW98R2CMSaSgTNGmjxMLGmXU
	WB5OrVc/H/nPJgaaMn4GEjJ54Qgsn+m4zBPjEqSbgIJLPySUnlLW8N3sqS3Ltpeq7cV0t
X-Gm-Gg: AR+sD120F+urAS4TBxMoorRajB7OkY1vMiRSIKfyINLMY92fpVBNSE05PQ1vjeeBz2L
	dvdflhU4xs3NdHru9q9xrihINtMNUKHnA+nroTfm/LT3n/iQ8h7gb84F/+kV/BYHkKP2qg+0BVP
	VHV4Dymeld0n2ObKhfPvceYHKKB/WddWVaBFl977lhsoxF1Ieum+zfMKsMqwaBlYbTWca74oAoN
	LODsTKmgBoVF2fg53CH95bUzX8Umjw57u8RqsHCkkaLNfsPzA6ZIATCxt1beY/XaMUJ5GFG6MM2
	2k/gng4mSsXFKdxR/mJ9l1faVgLQ6qgZvxV8tqECwreaxjKFtNy4CoK2KREZvV7BpZxiSpAAiNj
	uGMK150vFBG3jHgHaOHFeKw==
X-Received: by 2002:a05:600c:1912:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-4980eb8c4a1mr119588085e9.4.1785694004023;
        Sun, 02 Aug 2026 11:06:44 -0700 (PDT)
X-Received: by 2002:a05:600c:1912:b0:495:4f84:7280 with SMTP id 5b1f17b1804b1-4980eb8c4a1mr119587535e9.4.1785694003526;
        Sun, 02 Aug 2026 11:06:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807eb12c5sm94121995e9.3.2026.08.02.11.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 11:06:42 -0700 (PDT)
Date: Sun, 2 Aug 2026 14:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Abhin Parekadan Jose <abhinjoses@gmail.com>
Cc: jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_pci_modern: avoid infinite loop in vp_reset()
 on invalid status
Message-ID: <20260802134301-mutt-send-email-mst@kernel.org>
References: <20260802174059.4082-1-abhinjoses@gmail.com>
 <20260802174059.4082-3-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260802174059.4082-3-abhinjoses@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KVmry9fRMdiZ-yBRw_bnRgEvY8Yy6ryaOp6efdcrtY0_1785694004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 02, 2026 at 05:40:59PM +0000, Abhin Parekadan Jose wrote:
> vp_reset() polls device_status in a tight loop, waiting for it to read
> back as 0 after the reset write. device_status is read via MMIO from
> the common configuration structure, which requires the PCI_COMMAND
> Memory Space Enable bit to be set. If that bit is cleared while the
> device is bound -- e.g. by writing 0x0000 to PCI_COMMAND (config space
> offset 4)

So don't do it?

> -- the MMIO read no longer reaches the device and returns
> the bus's synthesized all-ones response instead. Since that value can
> never legitimately clear to 0, the loop spins forever and hangs the
> caller.
> 
> Use VIRTIO_STATUS_ERROR() to recognize such values and bail out of the
> poll loop instead of looping indefinitely.

If you want to work on suprise removal, that is great, but
with actual surprise removal testing, please. I'm not
inclined to include changes when testing amounted
to illegally poking at pci command, and without much in the way
of what effect this has on the drivers.

In particular, please read cover.1752094439.git.mst@redhat.com - a thread
where we seem to have come to the conclusion that hangs where
surprise removal happens while the remove callback is in progress
are fundamentally unfixable without pci (and likely acpi) core
changes.

> 
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 6d8ae2a6a8ca..209fa3b36c90 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -547,6 +547,7 @@ static void vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	u8 status;
>  
>  	/* 0 status means a reset. */
>  	vp_modern_set_status(mdev, 0);
> @@ -555,8 +556,11 @@ static void vp_reset(struct virtio_device *vdev)
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
>  	 */
> -	while (vp_modern_get_status(mdev))
> +	while ((status = vp_modern_get_status(mdev))) {
> +		if (VIRTIO_STATUS_ERROR(status))
> +			break;
>  		msleep(1);
> +	}


I am not convinced we'll never use all status bits eventually.
Currently a single bit (32, bit 5) is unused.

And then this test will give false positives.

>  
>  	vp_modern_avq_cleanup(vdev);
>  
> -- 
> 2.51.1


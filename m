Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D934A08
	for <virtualization@lists.linux.dev>; Sun, 24 Aug 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045997; cv=none; b=BYVPc/oyLqmQrCz35h9JrdtlXiVbuev/XtMyvYmYZqNDUjnmZvLkazxM9jgf7OruSWZ5WGou0gJjk2fm5QNA3vTJbsDR9AN0S1Lsj29BeHzWyqDCid0kpmHHeM9EqutCJwCDh7JhdSpAoz/rUkFqg0rZAp37AMkL9KXu/2jdK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045997; c=relaxed/simple;
	bh=AAydxmtXdOEr9pUQiFzLGmLEfxElC6MQjjUnrMu4GUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mPndvCot3jLv+wSkr++/pCxQINZwLWGc3TU0EuAbRufOb+hTaUuLfMzgqAcwx/UYXDenyDiQ5o2W+1XvsskfLHbR/gEpjX8LJnk0Dze1Ve2zAFwScZIyjJ7YoNDGKnt5DNA8LbQ5ZTeWfFuo1dyFLo49kw1V5kjHBLDRICujbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AK3MDQmy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK3MDQmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756045995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXOZi6fX2O22AbP7K5PtVdG4I/B05K0GknRoq68gV8w=;
	b=AK3MDQmyGEvNjj2JUE4DBgQRQWZ2pbKAtzXrbjv2xHaHJoQoJcwYP54d/ubh8wbhocHq+G
	1J5PQnNL85UbLrnXjcmBbQQDDjfb3+G5se6LMCE/TbtxK1NUgPnXa3lwBo649Zire3EfSS
	Mo5PSM3ZCLrDqv3Nnabm++mfgPVVc08=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-1UIJfA6_MPWBSjo9TdsGWQ-1; Sun, 24 Aug 2025 10:33:13 -0400
X-MC-Unique: 1UIJfA6_MPWBSjo9TdsGWQ-1
X-Mimecast-MFC-AGG-ID: 1UIJfA6_MPWBSjo9TdsGWQ_1756045993
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a256a20fcso20229305e9.2
        for <virtualization@lists.linux.dev>; Sun, 24 Aug 2025 07:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756045992; x=1756650792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXOZi6fX2O22AbP7K5PtVdG4I/B05K0GknRoq68gV8w=;
        b=q7i15IXLIEn07M+IIoUoiysbL9L6GBNubIkNFf8w9sYr6vJ4vG/bKMs0rpHcX7lgVE
         zv3zdBXEvVrDa9sz78zG6SEQ+W2yhLWourqh8euLj/ihmTyA4nSgfR1orV9LEA3CbqXT
         AxQjJxZ9qFPHTsI2xvygq3Nem8EmKLAfcSfxZnVHnVVDXeYcFxmHwDpgnwNbiPGKn0Wn
         YsJRilMvuB/rkLYpS81twGwmekVLrfYU9muKTLIB95QeektiqacncuT0L3JpUNFqoIV8
         7JHDDMiSy40hQ0IqN1Nf08eCr2H3wVjchrfygh/8HZVY8fS3Y50ME5rHeNbfV24+WB8D
         kFKQ==
X-Gm-Message-State: AOJu0YxE4WChdY3yEDUvUY7Y93E/97tDM1uQN+iE5GnN1u/1K2pSCZDh
	9/NF4ZAHYkDlJbiUqzskk9EYvTM5+L+cAGM1/frUTU/mgoH3014wXZWK+6ecV4ZLQ+ArvulMVFY
	1M8MB+gv70i6RCeYoB7IjXEOzvnhUOhAFlshb6emNm+XhyATHUbYTMMmlujQwPNIoIYZ5
X-Gm-Gg: ASbGncuJkfZ0nO9KQsx7bbXJDYsowHlBOMi3wqNYeSG8QZ9gog9rnjmY1eo961n/7ZA
	9MpAFmnfleF43gDOjjo+4E5UBAWsIcY9vhEPhSoigzIrhysG+R1bkpxvr+6j2LKTTQQ1hV//UP4
	K+ZeUEPWiGrsD4L/j9GWBq4PT09QTWv2I/poHY0VC/dd4w9Ijots/SIHl/OWLPvqwRF0bTTAsin
	Ikf9a7BxVrLLsYu6f8bULRXGDlwhyu4MvIlrE/s74InLyzzJxLLf+jMQzdxnIH6CH/60f4lm/a8
	8TxUW5pYxSPr8pHxtUVj+GUqh3eTu4eG
X-Received: by 2002:a05:600c:c87:b0:456:475b:7af6 with SMTP id 5b1f17b1804b1-45b5179b6aamr65632165e9.7.1756045992575;
        Sun, 24 Aug 2025 07:33:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnuB6LlR7eU2gREcHAgZVnNkQuY/7F9VLSGBy1Hqh3QwVI8FGRhtEnh4i0AirRf60ui3aTcw==
X-Received: by 2002:a05:600c:c87:b0:456:475b:7af6 with SMTP id 5b1f17b1804b1-45b5179b6aamr65631965e9.7.1756045992120;
        Sun, 24 Aug 2025 07:33:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5f28fa02sm15104475e9.11.2025.08.24.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 07:33:11 -0700 (PDT)
Date: Sun, 24 Aug 2025 10:33:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>
Subject: Re: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Message-ID: <20250824102947-mutt-send-email-mst@kernel.org>
References: <20250822091706.21170-1-parav@nvidia.com>
 <20250822060839-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195292684E62FD44B3ADFF9DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090249-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195392690042EF1600CEAC5DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095225-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CY8PR12MB7195C932CA73F6C2FC7484ABDC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LlmJUrpXvWtHfQNskYRFjqIQQV6QXKaMxSlPgBHxYvM_1756045993
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 24, 2025 at 02:36:23AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: 22 August 2025 07:30 PM
> > 
> > On Fri, Aug 22, 2025 at 01:49:36PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: 22 August 2025 06:34 PM
> > > >
> > > > On Fri, Aug 22, 2025 at 12:22:50PM +0000, Parav Pandit wrote:
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: 22 August 2025 03:52 PM
> > > > > >
> > > > > > On Fri, Aug 22, 2025 at 12:17:06PM +0300, Parav Pandit wrote:
> > > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > > surprise removal of
> > > > > > virtio pci device").
> > > > > > >
> > > > > > > Virtio drivers and PCI devices have never fully supported true
> > > > > > > surprise (aka hot unplug) removal. Drivers historically
> > > > > > > continued processing and waiting for pending I/O and even
> > > > > > > continued synchronous device reset during surprise removal.
> > > > > > > Devices have also continued completing I/Os, doing DMA and
> > > > > > > allowing device reset after surprise removal to support such drivers.
> > > > > > >
> > > > > > > Supporting it correctly would require a new device capability
> > > > > >
> > > > > > If a device is removed, it is removed.
> > > > > This is how it was implemented and none of the virtio drivers supported it.
> > > > > So vendors had stepped away from such device implementation.
> > > > > (not just us).
> > > >
> > > >
> > > > If the slot does not have a mechanical interlock, I can pull the
> > > > device out. It's not up to a device implementation.
> > >
> > > Sure yes, stack is not there yet to support it.
> > > Each of the virtio device drivers are not there yet.
> > > Lets build that infra, let device indicate it and it will be smooth ride for driver
> > and device.
> > 
> > There is simply no way for the device to "support" for surprise removal, or lack
> > such support thereof. 
> > The support is up to the slot, not the device.  Any pci
> > compliant device can be placed in a slot that allows surprise removal and that is
> > all. The user can then remove the device.
> > Software can then either recover gracefully - it should - or hang or crash - it
> > does sometimes, now. The patch you are trying to revert is an attempt to move
> > some use-cases from the 1st to the 2nd category.
> > 
> It is the driver (and not the device) who needs to tell the device that it will do sane cleanup and not wait infinitely.

You can invent a way for driver to tell the device that it is not
broken. But even if the driver does not do it, nothing at all
prevents users from removing the device.


> > But what is going on now, as far as I could tell, is that someone developed a
> > surprise removal emulation that does not actually remove the device, and is
> > using that for testing the code in linux that supports surprise removal.  
> Nop. Your analysis is incorrect.
> And I explained you that already.
> The device implementation supports correct implementation where device stops all the dma and also does not support register access.
> And no single virtio driver supported that.
> 
> On a surprised removed device, driver expects I/Os to complete and this is beyond a 'bug fix' watermark.
> 
> > That
> > weird emulation seems to lead to all kind of weird issues. You answer is to
> > remove the existing code and tell your testing team "we do not support
> > surprise removal".
> >
> He he, it is no the device, it is the driver that does not support surprise removal as you can see in your proposed patches and other sw changes.

Then fix the driver. Or don't, for that matter, if you lack the time.

> > But just go ahead and tell this to them straight away. You do not need this patch
> > for this.
> > 
> It is needed until infrastructure in multiple subsystem is built.

What I do not understand, is what good does the revert do. Sorry.

> > 
> > Or better still, let's fix the issues please.
> > 
> The implementation is more than a fix category for stable kernels.
> Hence, what is asked is to do proper implementation for future kernels and until that point restore the bad use experience.



I am not at all interested in discussing ease of backporting fixes
before they are developed.
Not how we do kernel development, sorry.

> > 
> > --
> > MST


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9C35A387
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579089; cv=none; b=SDjAbLDDAiWFYv9d4dMeGVSLQHiXrLem1We3gsUklzdGDxwjifGKYE4isvuo1TJADINhnPfDcKmrBjXlkJwxNFWzbQPoRgoHK7O0nLah/VbuHIOB7/7G/P18Fh7rQrb+HBtqmHcJenFS1gWKIf1Ut7uC0iNQzWqPd56HJuoDZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579089; c=relaxed/simple;
	bh=aCMBeV3cnf5n3JM33g0J4ogJfrvQSyYqY3uNmEZ3m68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MwqReSsgfRcG+hBHuGTLPa3HA5F8F7XlOFEr15GcBe57qruQjKfcHOoYxPGcBCOzp2GV9riUGqJYXdK9G4fVIgjJAfki/pCaBvPhx5U66H2hDeP/7Au+8jsz6m3J8N+Th3LNMCLos3MkHlnHnz32j8r3YTtcoPnYmwBnxaQnmmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rjd6cx8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjd6cx8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775579087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=48q4T/J+5CiP1vEILcKccvbIoqQ2tPiWCqLC85kBGDw=;
	b=Rjd6cx8CQqpKpm9fX9q6l4YJcBxnq002mr8sPFMT9GenOm5OCDyCwMJ8Oam+D+nFSdjY/6
	L338HiRf9inaI20eT8eA2sQkNWpLEo8ZjGxY0WGFt2hidALHhSb6oGEMlHj1+yQeavBmtx
	bJt/baz2z24X01EbcPBcr9YlncktG1s=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-ZGl3TMTyN5K2wjCFNYCWqA-1; Tue, 07 Apr 2026 12:24:46 -0400
X-MC-Unique: ZGl3TMTyN5K2wjCFNYCWqA-1
X-Mimecast-MFC-AGG-ID: ZGl3TMTyN5K2wjCFNYCWqA_1775579086
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8d432f1b84dso913452485a.1
        for <virtualization@lists.linux.dev>; Tue, 07 Apr 2026 09:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775579086; x=1776183886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48q4T/J+5CiP1vEILcKccvbIoqQ2tPiWCqLC85kBGDw=;
        b=OV/mGTQ+XjlZyjafZ/VIKAlJ2nvTKymOZDWgmKwG3Z/9Fr3BftI4GCw37pBa64oVTd
         nu+5FfnWX9y7gymVhLXDtxzJDesap+0STbrmDlAWSBrHthwSobAxC5DV3JegGPOpvt9k
         tKlZnZ8WOUMrM0DRIAO+MVPwLBuY11/V5tHS24a0QKsHAX4bBpngHq/2hL+h0nf6U5wQ
         CZRpWk3ewJTI3WBRTMhfrrbLaeoxCuTuW5uzEEg+UG4lhZjHYmHdWW3zq+H0p1dAec81
         N9+WIY20SznctGzOQ7jut8DubGN8fOSfBG3nLEHaompyyTVuXOzai202VcGT7RVCXVpz
         ntuA==
X-Forwarded-Encrypted: i=1; AJvYcCVgz1K5BGavDTCcS/qvp5CRrfBiTRNOIlvTEBtG+u8Nudvc04mrE8P1WkVEAicS8Yg1vHZF044en40huRBxMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvuBRwBM0JtJ0hvQGgIOp27FOYx2FFDWwdPj8DdE6m+cpz8Ft2
	KK02Ui9IBX0m06joYr3ZSrBIGA11zlY1u+LxrNccKMz3KzIZy7wvhV9b/st2R/AXga5uWhmCvv7
	h5wWftp+umf+9yv/qxPClmYc7apy/neu8z6WjW+Z+iR588gbLe7/NERqHW3nD4roDGia4
X-Gm-Gg: AeBDietL/IBT8YkksbUHEk0ELNkDZTov+PZQsb7FubCjrFOYy8LImLhbp9C+kAodapK
	Wfg5LNjTqLPeAlEd4ZHtjsYiunxpRHBSFcTgM9tINHTWifXjx6X5vJ/TfG07qvvVc+3rKIlD8m4
	DdItUpYRJl8gxi3Fk9tFjK9czKcJRFsVqqUBCR9F9Tb2JynIUwLoNDGgDsSZaemIDUTYyjBOiN2
	5oNvw9yj2f0bbW+zO8RPfs6Xw8JERe3wkwom1m+goLRakO7/f0G07ZX4q3zWR0Bqd5gbXmJ3GhP
	5+DfHT6BtwS0yOtM5hEXkUhsmJe+VYRcLgnbV7qAFAvm7EWaoUEKqoWVxOnXJAEDFV9dLXpq6d+
	4o88r72328wVE
X-Received: by 2002:a05:620a:3d90:b0:8d7:a015:5dd5 with SMTP id af79cd13be357-8d7a01561bemr871535885a.57.1775579085991;
        Tue, 07 Apr 2026 09:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3d90:b0:8d7:a015:5dd5 with SMTP id af79cd13be357-8d7a01561bemr871528585a.57.1775579084717;
        Tue, 07 Apr 2026 09:24:44 -0700 (PDT)
Received: from redhat.com ([37.19.196.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8648c17sm1345024585a.33.2026.04.07.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:24:44 -0700 (PDT)
Date: Tue, 7 Apr 2026 12:24:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Stellman <astellman@stellman-greene.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/4] virtio-mmio: wait for status readback after reset
Message-ID: <20260407122409-mutt-send-email-mst@kernel.org>
References: <20260407123904.6390-1-astellman@stellman-greene.com>
 <20260407123904.6390-2-astellman@stellman-greene.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260407123904.6390-2-astellman@stellman-greene.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AxmBMs_ufHIxQ4OFDVhz-D67j5ef4WNRCo53EzfBWhk_1775579086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2026 at 08:39:01AM -0400, Andrew Stellman wrote:
> The virtio specification requires that after writing 0 to the status
> register, the driver must wait until the device has actually completed
> the reset (status reads back as 0) before proceeding.

It does? But where?
I see:
    Reading from this register returns the current device status
    flags.
    Writing non-zero values to this register sets the status flags,
    indicating the OS/driver progress. Writing zero (0x0) to this
    register triggers a device reset. The device
    sets \field{QueuePFN} to zero (0x0) for all queues in the device.



> vm_reset() writes
> 0 but returns immediately without confirming the device has reset.
> 
> Add a poll loop matching the pattern already used in virtio-pci's
> vp_reset(), which calls msleep(1) in a loop until the status register
> reads 0.
> 
> Signed-off-by: Andrew Stellman <astellman@stellman-greene.com>
> ---
>  drivers/virtio/virtio_mmio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 595c227..a477977 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -56,6 +56,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/delay.h>
>  #include <linux/highmem.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -254,6 +255,8 @@ static void vm_reset(struct virtio_device *vdev)
>  
>  	/* 0 status means a reset. */
>  	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> +	while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> +		msleep(1);
>  }
>  
>  
> -- 
> 2.34.1


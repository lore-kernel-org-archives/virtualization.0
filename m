Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17733DECC
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132701; cv=none; b=JAzrpxUzDaJ3gQbjqXsDxm8Azf7ILAk9+u8DLtIjGlYQABX/pZi0K4qnXQAWSWeVZTA6YoxfPx1BkjpIhe3Upj0A4rsz8F5fyoIaXMnowzkA5gUXLW2C1YQ8BM06KGQrIWRUesCOGIR0C1IZ1w0nA9YQzm52gxXCZcDvGwgkvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132701; c=relaxed/simple;
	bh=CfiJ4w7hONlL9Z/PTXNxd8RtUwGNC3XNKW6kMFh/qzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JkjYB3/f7GnOQkqjofv1y1urov0GjRDvUFwHz0pBEBewOnk0Wohnbled8f1L0cM+Cb1VkvjN4NxBG872Xk3bTWRFYv3dZ+7Z5Q4wLl/X43QlLopeofM60Gqge9Th8hckMaxRaiKSMt3yiLsmZCpiwCouLlBM0pDm+W7MDl+HwQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bF4SKYm+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bF4SKYm+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761132695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S156bE12aAREpof0agTiIl+Kj94oA1TNzE1mu5dBvoc=;
	b=bF4SKYm+WM425xYlHmhz4lyJaKzg1JoVosrFMDolwvhooP+GY5XQdcabtKT1TI9CZj30hz
	CRZRTG/F084QgNS87C4WTye1NF8uLQQg4w6GbeKObX2GyG1NJLjiK8pi5XNGyIfOMaaX7v
	V3d8dTBo/K6akiAGkT1MXOE0ofFdSvE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-aY6FG76lN6mtgH4OSKSZDg-1; Wed, 22 Oct 2025 07:31:34 -0400
X-MC-Unique: aY6FG76lN6mtgH4OSKSZDg-1
X-Mimecast-MFC-AGG-ID: aY6FG76lN6mtgH4OSKSZDg_1761132693
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3c72638b5dso874172066b.3
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 04:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132693; x=1761737493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S156bE12aAREpof0agTiIl+Kj94oA1TNzE1mu5dBvoc=;
        b=leDfJiodM4exmSiSOtxSlxFnH908507xa/zSzl9XdqGyP6KG39AVabmJMYjgMxiQw/
         WApIKVy/gaEXMMZf5xaZe9L6PyQspV8+oRraJOA4+4Q9tu8/6aaFHDzaCFmXEidmI9x3
         awjQE2WqYyn3H3VT7bb0C55kTwEJR+QQqgHuhZZDRMLyQ8z3yAAtYwaKwufMpQ+G5RDz
         rgzmUFzdgTbO4eYWP8icqAxaOdShhTKVDr+Lrgk5CvMBwZSaEdlzbXbmanRPeL9LZYdu
         eaU24g/fp76KRE+bnXxUlBR9gNBr3MU17aSqaBCDnk3w1ZfooHrV2c+UveOqR2/Wct0I
         uJvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmgg7Q/NHsLut9Om5V4LGSPkxSOh8V51Lwx2lcQogK4mh3j10Xr6UR7uLa6HWcGHwCilTMLac40KrpQR4maw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWXhHlZWJVo8H6eTlAu9oaKc3PYnAGjTIpuGHqAnFdfIuHFxCI
	Z002jnPwTHiF4k2RoMt1IqhAF0qvlO0WunF4S7ZH51L5wV+ngrRCZlJhM84eBSqmC6zuC7pDlyz
	O/Q1dVDkByRXHwaV9fFqCobvG0Wo0Q4giWNzCPvq+Wj8RdppdkGQWpo1tGauc+aJk1qVr
X-Gm-Gg: ASbGncvobYF4fv+Oj5KGQ43zSaShnEdnGLO6aHjjDpUY234E2c2IFpdGzhZ1Uv4Kk6N
	cdS+WQqJnQoe9WejATfL6v6ioC0MMyReYw4xjXpcwlqVRol4EUPP2f01O9KTNku44wmnovO3k2B
	T1FoVrLEbZ9zXG2gjo88hWmkNYkGiTV7HpRJV/5IJuxV+O6YdCgJAS6QrldQ5N+IcA96mS59AQu
	geU/uU9gwp1oPwdn8TA3AWKbdUBxX1iP+pM+kI1zDjrU5J/c6cY2ffWWG1iNYY72Oj0uJbHx/1a
	HiC8dkUQzM2kPfyYxpwNWjo+0lb75zrps+NAi2OD5njPXiwCthYdUf8rGLDE725I
X-Received: by 2002:a17:907:94d3:b0:b47:2be3:bc75 with SMTP id a640c23a62f3a-b647550e7damr2122595366b.60.1761132693190;
        Wed, 22 Oct 2025 04:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtkVRHnJq0ka0/fuJfbAd6TfpVf0F9/6FtX3D4bCRn1GC5f1VpViV3OitxoY9hYS2UiW4bBA==
X-Received: by 2002:a17:907:94d3:b0:b47:2be3:bc75 with SMTP id a640c23a62f3a-b647550e7damr2122591066b.60.1761132692754;
        Wed, 22 Oct 2025 04:31:32 -0700 (PDT)
Received: from redhat.com ([31.187.78.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8395c52sm1309380066b.30.2025.10.22.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:31:32 -0700 (PDT)
Date: Wed, 22 Oct 2025 07:31:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, xieyongji@bytedance.com
Subject: Re: virtio_pci: Question about virtio_pci kernel module refcnt
Message-ID: <20251022073015-mutt-send-email-mst@kernel.org>
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i79wbbW7tgrH2hE3wdm-bSDnZB8sUU7G3Aq7v5KJiUQ_1761132693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> Hi,
> I noticed that the reference count of the virtio_pci kernel module
> in the VM is always 0, even though there are at least two
> virtio block devices and one virtiofs device in the VM.
> 
> Using rmmod virtio_pci can unload the virtio_pci module,
> but this renders the virtio block devices unusable.

it removes them. you can put it back in and you will
get devices again.

> I wonder if this result is expected? Why don't the virtio block devices
> and virtiofs device hold a reference count to the virtio_pci kernel module?

because they don't have to.

-- 
MST


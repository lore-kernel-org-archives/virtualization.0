Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBBD2066D3
	for <virtualization@lists.linux.dev>; Mon, 16 Dec 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365653; cv=none; b=UMnJaH2/thQUPzrJmDrDi6KPDoIc8vxmxuiSOYeu2gx6nMHCWnxniqPzxDz5svdex/Og8X5OeVVSg/wFwhaPjUDb25iKncuZr+40fFUWRGKXJvXhU+T3ubqobLYiHoTo03qp5WUkgR0gbiGlj6mIzB5M/D6dBOgTuwMTL0v0gN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365653; c=relaxed/simple;
	bh=Sn3chrE/m9+5fI4KxN090tU8mgWC4Aj8lyQMOoz6teM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6XXWSVBPefUDH1jnLWPYRivJ7Dy33EJJ7Edi3xF8QWQsEpUYArYn+o88N6IF9VFEyTbP9JGhY4dmHnMp90Ucl8CADIU+p+hfxPlGSfeqq0anfO5XBAWxQ7451dDn74rlaEJ/dauE4ABXWSzskGv38Z/gPF0i4y14GeVDiA6z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQTtv5Hv; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQTtv5Hv"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso7848265a12.3
        for <virtualization@lists.linux.dev>; Mon, 16 Dec 2024 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734365650; x=1734970450; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHJ2lOqPcI4uWgZuisuf6hiF/EJ4Ewdtymu38Ng39Fs=;
        b=PQTtv5Hv9742T7QGlC7RK7ilyUD0Qc3UwM+aOqg5riaEexBR3zbVzktkFo70Eca8II
         HrAyiePbzDfQrUNVGSwNaa/AaWyqQ+GBwF1/3/t8KdmW82zD32NxtRKiGtRb+qmh0fCM
         B6Um7lsz5E1h3z+ZY7htiPNM9qhaUKjXiDjYi3ioUzYcesG4uQdRMc8keIjNQr8W4cOu
         5I0FHIO1CvXxSoVSxCf/G7on6bVTJzeM7pMsEjvGe0iQ+vAwwRItU4DrXUTvJ3bPJfKD
         ml37jPHdB+WfpWUC9wYrhPBMyFKx+2gITevSjMYd6zbz/IwqgUP5g4TXe72Si3ykX+XX
         o9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734365650; x=1734970450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHJ2lOqPcI4uWgZuisuf6hiF/EJ4Ewdtymu38Ng39Fs=;
        b=bbeKJuzpTS+YaYRyYkqJM1J5gZ3iiwKAYeaTDl5e3g4A8jXop9kPqHkZJ8iUvamFji
         gjhsrs50etD5wgthAK9G6FhA3HZyPSAlTYdA9yXzd/zNbAJ7w0XUwlomt/9mDGzG0IS7
         xTNhWjBdsHTBZF46PdJc8lwsmqluGr2cu04KPKADIwPLtY024eykYAVa+/LulKCSeyoZ
         1pyWIr1HJ/TG393999NwPn+XTaoBqSBIiFVik2mZxSPVBhqZrr25qLacvdj2SssMDDat
         oC1MdycWcjF2i+tQmsPU3cCK3D6VgviSN6GmOCVeiGmlvxD5aKfKs+2ufjg1DjkSz+ZQ
         NffQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsUQqAIZtfmwGS/Lvncix6QwnA5CcuFJV8ZWO6hAiMJd1WjY2hYoJplfk7203EtnfyjuRytLQYm9SwsAb4Mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyE6+Qed4x/J2Wn1INJ+WRs60zmaXGxALDe0+bKDNJcmUzb0Rv
	JE6AZStENNDTsbl8m4AwgMo5NJdEwjeuz2M+ISStYky+fN2Rvc5C5IZfXd73g1xyNokx9tlul0H
	KFwxMp1fBd0Jtpy1Z0fC+kyLVZBE=
X-Gm-Gg: ASbGncvDZCm/g04OVhCOQFbwQZZpZQM8Ln4vSkcZ1h9j76FSLE0PP90KABE9kqQe3O6
	88uJJ8XGVnzMTYCsyPHlSQm5/5R4UGBsssCag
X-Google-Smtp-Source: AGHT+IGpUyDeh2IFWn704xO0ehU/HUo5hO1pZVdfXYwfm9voS07OecSnnJ41T38qduxnCKav2XsaiBT/Q8IVjk4NfGI=
X-Received: by 2002:a05:6402:1914:b0:5d0:d91d:c195 with SMTP id
 4fb4d7f45d1cf-5d63c42dd88mr11156129a12.32.1734365649482; Mon, 16 Dec 2024
 08:14:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241203121424.19887-1-mengferry@linux.alibaba.com> <Z2BNHWFWgLjEMiAn@infradead.org>
In-Reply-To: <Z2BNHWFWgLjEMiAn@infradead.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 16 Dec 2024 11:13:57 -0500
Message-ID: <CAJSP0QXU_uNqL-9LmLRkDdPPSdUAGdesQ2DFuCMHnjyEuREvXQ@mail.gmail.com>
Subject: Re: [PATCH 0/3][RFC] virtio-blk: add io_uring passthrough support for virtio-blk
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Ferry Meng <mengferry@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	io-uring@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Dec 2024 at 10:54, Christoph Hellwig <hch@infradead.org> wrote:
>
> Hacking passthrough into virtio_blk seems like not very good layering.
> If you have a use case where you want to use the core kernel virtio code
> but not the protocol drivers we'll probably need a virtqueue passthrough
> option of some kind.

I think people are finding that submitting I/O via uring_cmd is faster
than traditional io_uring. The use case isn't really passthrough, it's
bypass :).

That's why I asked Jens to weigh in on whether there is a generic
block layer solution here. If uring_cmd is faster then maybe a generic
uring_cmd I/O interface can be defined without tying applications to
device-specific commands. Or maybe the traditional io_uring code path
can be optimized so that bypass is no longer attractive.

The virtio-level virtqueue passthrough idea is interesting for use
cases that mix passthrough applications with non-passthrough
applications. VFIO isn't enough because it prevents sharing and
excludes non-passthrough applications. Something similar to  VDPA
might be able to pass through just a subset of virtqueues that
userspace could access via the vhost_vdpa driver. This approach
doesn't scale if many applications are running at the same time
because the number of virtqueues is finite and often the same as the
number of CPUs.

Stefan

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F5384047
	for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724653954; cv=none; b=usfD1Wm2lW73hRdGunfI9X54w+lLTWqm8/FThUqt0Ozca0kjuFUnQZosYNRKKUPWWuR8f1j+k3BPlasAdbLWzCk8LiOr/A5VU9EMC9BWZUVTqFE3jIls2Tp50Qlt8tXspM5Dde90EIhNZ+IXaAnMLWLmzBXs82xG5T7RhiTBdTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724653954; c=relaxed/simple;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYihFLetYaLzozlPcwHQUIMGejz3TnEwq1wRnRJtxbYICUpWhDEoINlHk4vGRZ75GNwkzWE8JSKwqgLsvcuLYozTN+N8awni1GP7NYudWIeLwBuRttuzstmny3Lc+x9BzELp3SEchUoCVNzTCWX91SfKUE4zyirWDi0p2uHYiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6kGQxY4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6kGQxY4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724653952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
	b=E6kGQxY4xYiApSOlxL+UwCD068R0rgW2rO3CvvjD0WWae/XH95I5/A3nD01OT3+h0l+NkD
	QNOTW9GQ9Pt3Ocp3hGp60v3xX2RNiyAByuxWXnGSMz0pwOf/pgt/rfjZikGNGfdNq8KN5O
	X0QK3iumZ6bIojjfODaFgcI3atBhU/k=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-qVNxq9z2NEKsIDpEIKkYZA-1; Mon, 26 Aug 2024 02:32:31 -0400
X-MC-Unique: qVNxq9z2NEKsIDpEIKkYZA-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-498d3dfe83aso1371550137.0
        for <virtualization@lists.linux.dev>; Sun, 25 Aug 2024 23:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724653951; x=1725258751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JESifInmWvZeQwWI8Jn8J0cYeIeDZ3prAXhvDlTsSj8=;
        b=Cn8qBT7E87AYpyQnncO3H7vAcR7sQp+kWVQ+/OJaNfzKCX3vfA6PrFfJFBUiN6wiS3
         xphI2ikiP0pjnh8BrRKjdTtMdFiP2GJ/6MuVUhx7STcUTO7teY590JQes5n9zLrUcXnN
         ED0h5jeaxk2FWUUbowj/DUREyBZMwsj4Mz8NW97Nq0x4qts4W8qQ0ZL5bHAAvdXoeg+Z
         xRFryFu4W27NSbcyS0J41gBfe+vaLf4Hyap1ZFQW6ZUFObsN5Pekm1WrbaNw16vyJVAH
         0E1s8F9WcpYltLGHoJu7c/KoqzO1vXvhei8sWota19b77QHd1PpQfgLrO1kTXGTmQ0Np
         zsVw==
X-Forwarded-Encrypted: i=1; AJvYcCX3RoNYQpssqeUy9Iyk2NlJKgoujxwSxmY1RIWctwJepHojmJxyZhhqExKRsUPN02WzDHuxwkvIvtKeJh+5eA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZOKh9MVxhmI/l3natxNf8O07HQ43FDILxnB6m72ausGCOToo/
	HCBCBQbsZKmjJHy/rShLKiY4iaKGgVcX9oHB6satLEdNNkfvypGuoUe5vf5KElCjY7kW9YSEQ1f
	IJ0/hAQF1pr+XFeekOVlEn0W2V6Ksw/XyGn+3YIAJtQrTHtlDz9NChxP2HJsmj7adtNCeRKFn6x
	RyFs/uL6Xy+xwYYHdc6FYhYshXhZDQIhr7f2AQcow=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id ada2fe7eead31-498f4768d98mr6498549137.31.1724653950685;
        Sun, 25 Aug 2024 23:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwydcuFOVlgtFmwjWlxiF2u2xtiMO6UvY+/x7l/PEgUFs/udwBSaHF5gxdau0K58G8iWDDv631otNdoDoL8Rg=
X-Received: by 2002:a05:6102:3f0f:b0:498:cca9:8b3 with SMTP id
 ada2fe7eead31-498f4768d98mr6498530137.31.1724653950260; Sun, 25 Aug 2024
 23:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240824035817.1163502-1-hch@lst.de> <CACGkMEsK8k=yX2ZytMJQhdZi4PS9-7KLUYmf2oGLu-UvNEYzug@mail.gmail.com>
 <CACGkMEu83MjTpkSS1mX02ar8RNDc5T4bsd4kkGHYhkH7LZY-wA@mail.gmail.com> <20240826063002.GA30266@lst.de>
In-Reply-To: <20240826063002.GA30266@lst.de>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Aug 2024 14:32:15 +0800
Message-ID: <CACGkMEvB20-iwNKepBdJBNAvxN-5+MduxnX6XDbPFsVA4hNz5A@mail.gmail.com>
Subject: Re: clearly mark DMA_OPS support as an architecture feasture
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-media@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Aug 26, 2024 at 02:27:27PM +0800, Jason Wang wrote:
> > Actually I meant, we can extend the virtio_config_ops to allow mapping
> > ops there, then simulator and VDUSE can hook the map ops there.
>
> From a quick glance that feels like the right layer of abstraction,
> although the config part of the name feels wrong at that point.

Right, or we could have a dedicated map_ops instead of trying to use
virtio_config_ops.

Thanks

>


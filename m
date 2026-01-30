Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0752EB5A9
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738628; cv=none; b=KUA2iubhLVQErs8MT+8CVQgCGju+CEo4PoL/cebKMiEPfLVzXEh+2WiqIHYHFLOb/m/yPa75Z7LhZZOFmYyTFLAnNrOcr3ea3VzcSiO7y+NqjNL4WkS/9h5tnh9IVM3kwQ1rEkMzAEbS15+YNpBDzq+5nXSpeIfI8YSqSfzVvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738628; c=relaxed/simple;
	bh=WwLQAKmrP1+mzKlUH3NqnIXocadie9PpT2ywPiGYikM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5+xd78WKpMQtIGRu+u/YVuHce1lQCj+e7lLsSLquiGkkEOfRl12u3z3GCb/Ln6dbEuc4tEgDD2erpohJZDRFmar6xwheWv8qRG3+Ji/kGDy1Zuc0AXVZ6lb9hmysumHxoUVtsXQWjiZWTAo+64jIonHWu1K3GMWS8FAN6sE8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXP0Cgz7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXP0Cgz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769738625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwLQAKmrP1+mzKlUH3NqnIXocadie9PpT2ywPiGYikM=;
	b=AXP0Cgz755HZauxAtDuiImuaBZ1ZrNLzOWbK/A8SIjrvnFPgIS4lhar9JSx9mSZ5yW8YtD
	stJxHI+z3uv5pB9F+PV4cC9c71m+61U56CWdqwdks2d7QnRW3anxvIs/dyzHG08O04UY//
	3uuSqplqk4w0XvtSrSz+YUYh2nqI2iQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-SeMDlI7RM62IyOeEmHN9nw-1; Thu, 29 Jan 2026 21:03:37 -0500
X-MC-Unique: SeMDlI7RM62IyOeEmHN9nw-1
X-Mimecast-MFC-AGG-ID: SeMDlI7RM62IyOeEmHN9nw_1769738617
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c314af2d4so1234997a91.3
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 18:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769738616; x=1770343416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WwLQAKmrP1+mzKlUH3NqnIXocadie9PpT2ywPiGYikM=;
        b=wlOTjMqLF/fugsYSj0ZtTbiqF72E3K1JgGnji/dW041WtM0CSIzYKRzm2zyD0799YV
         kRB83yVeR9f8W1CVJPajFxooxcZkhIZaFDe+bztJ75vwcZaDTVR28fwdze3UU1Ksc4VA
         8tWUxyhs/lBOZ2Ej5r9MbJjhakvkds3G0ODIeSYyyQfdvqQZvi/ufNCd4EP0iWOGxRXb
         iU0zPNoqskqIAcYP90CX83LTiDQPV25JCoiOCLaoXLqBmshnCddXJ3gQJnRATqlF0ryA
         cWTxlPNKHtYiyh3fas8MLuhzv1x+QlKj7MYZfnZmyFH5cZxi+csa0ug+uxs7tEBWin9C
         tK9g==
X-Forwarded-Encrypted: i=1; AJvYcCXBuBtHBKFBF3Sbbo+i9/HwPthpi356+Xj5F4OhqsawwRMjstYp1Slm4nZ2ooMzT/L2f2iAzCw7wZHR5Qt+Qg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8ONCIPeDL+R/KfcZN35aT9QgzUi5y23UcyVkKIUPciBkYp/0o
	KrCBgINscdFU4L2SBdPhUyTpI/C5JFut5O4GCesBsmm1xgaLlu3bXXyeJtaA6xUhWlqWtQMbfUI
	giTE9rYrIeudFXnhSutAKpQ6f6AahQq3wDAs638LHnmFGlwLyu8JM7LyB2NnScC4CdxGsK4uJRF
	UJq46MxS8lLUH/t0HjGZQeKA4YLOzAcQh7rez+ywDASgw=
X-Gm-Gg: AZuq6aKWuSE16dWqZH3ONDLueProSNnAPTdsSDcE5KeDdRe88rlotv74lORYjvg7OAl
	N+6oUkYmawH6K0OtmcSf6kZAjyor7eOZpuiJR6xOOol5uRtW+OCOpEr2RLK0VVfV+SKw1PIpw15
	cdmy6Mw7orup24EVoL96OuwODMLNDdoxED+w86/X5DvFiJwmXgUNT8ikgmlYRA/D9e
X-Received: by 2002:a17:90b:5210:b0:33f:ebc2:643 with SMTP id 98e67ed59e1d1-3543b398bd4mr1396803a91.23.1769738616560;
        Thu, 29 Jan 2026 18:03:36 -0800 (PST)
X-Received: by 2002:a17:90b:5210:b0:33f:ebc2:643 with SMTP id
 98e67ed59e1d1-3543b398bd4mr1396771a91.23.1769738616147; Thu, 29 Jan 2026
 18:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jan 2026 10:03:23 +0800
X-Gm-Features: AZwV_QgzWFF5_u9pjfuMd-MVrX7zWKH92ysyEYpjuDDgSXPpBo5ReuMLtNKdkqU
Message-ID: <CACGkMEtqBJKaG0H6zcyr_RJZ3bZgdNvT1KX52fKHpA=bLsUuew@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: Add READ_ONCE annotations for
 device-writable fields
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Alexander Graf <graf@amazon.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"open list:VIRTIO CORE" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5lEIgcFDXOOw-C9Jp-iHiw-gpavW6LzRx1HYQV2Jep8_1769738617
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 8:16=E2=80=AFPM Johannes Thumshirn
<johannes.thumshirn@wdc.com> wrote:
>
> From: Alexander Graf <graf@amazon.com>
>
> KCSAN reports data races when accessing virtio ring fields that are
> concurrently written by the device (host). These are legitimate
> concurrent accesses where the CPU reads fields that the device updates
> via DMA-like mechanisms.

Technically, the device can write to the descriptor ring as well, do
we need to care about this case or not?

>
> Add accessor functions that use READ_ONCE() to properly annotate these
> device-writable fields and prevent compiler optimizations that could in
> theory break the code. This also serves as documentation showing which
> fields are shared with the device.
>
> The affected fields are:
> - Split ring: used->idx, used->ring[].id, used->ring[].len
> - Packed ring: desc[].flags, desc[].id, desc[].len
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> [jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
> Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>

Thanks


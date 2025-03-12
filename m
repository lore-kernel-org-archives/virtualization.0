Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E1224EF7C
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792287; cv=none; b=FgMaHuykPS/IjTQfmBsKDos9RmWMH1kcrTe61Ci4jtakWDgZy26h5shgZShU6Mk47O0OD7LmsaYU6F/ACve7d63KkZTn3MGHasdFJ/FR0Zib34wViz4pkXYcs4SwHh2F3wdwVfO1l7/pRqgg9nEs7/O23dQ1+WNzKDrfyWmA7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792287; c=relaxed/simple;
	bh=ztlmegBzBKs8vJ1Sj3J75o5jqxXX3n3n98UKsP0n/bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sqt3zfHlIa8rK6HSFvjRNd0f31AQbwStA1sh4O3NKE5R8ZJdAqclnknOtgfLfImLW5qBUKFma8tMtp8Rv1iv8U6kvLWX0MbA4synR9REShf5fGFWaz0+P8+r/NTJVryep+nP3OC+VRAe7dIr2vtM4Vp4DUYHUBJBO/Gr6VyrlOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cHRcZPLN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHRcZPLN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741792284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3wvkUF9pbg03+vUjzzWddDimlNCCehc9tv57CFp/bk=;
	b=cHRcZPLNtv9E3ou3E/M/UVZ5jfawT54zag5dQZ3d1flStogsf3w4BbhuTJQSsMmEegVPF5
	0IJ00g4MhsWrtnTqK7uVy57UWBXOxU8qbzJ6CaGojOTzbmd46qSdqg4Eabk58o/OOR9Idq
	ACv/CLV/uzo2f0bQpO2kh+4Gm38hqNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-MDkzkUj2McWZYMzcEe0CLQ-1; Wed, 12 Mar 2025 11:11:23 -0400
X-MC-Unique: MDkzkUj2McWZYMzcEe0CLQ-1
X-Mimecast-MFC-AGG-ID: MDkzkUj2McWZYMzcEe0CLQ_1741792282
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so30104365e9.1
        for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 08:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792282; x=1742397082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3wvkUF9pbg03+vUjzzWddDimlNCCehc9tv57CFp/bk=;
        b=MrgGPaSP0rDpTh6mwBVx3IvVEj3Xi4WwiG+iNAVjoWuDBE1uZIiGEltD6wkJRB37H7
         6AKjSpYMiVgLCpI8/96vVmEGtQPwO9B4yjQInOPtv3v0gg7oUeA+NQEIYx+wpkKJMTAF
         wlXa+aXTGskQjcC01awuWRaKCmFcJHiJ4cSlHX05uJBmofuxUXGhndj4sZYGSi7AWlh5
         TQ7OiQ/+lOQfwBze0scZ+VAg55TRlZBcRXTwmj/z12VzajA+BkWgpGkPXiwToDsmqW1b
         /VLhWzAeczyj8Tz1liZ2mScFEIbq3s8RwFfuESTf5Irpid1SUkg2r+NfYl66shPKS/CF
         iacw==
X-Forwarded-Encrypted: i=1; AJvYcCUs9vR2qpuup6ctL5n1r2PJEmC5eR3BIqaFRd2lldGc+m4BkhrnbRjFe7IVdk2M31iSRJWslyDPliDpUbE84A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZJwFdfHN1E7B0tqmfmtUGALnAlLA0VzaWUzkyoXZOI5w5vNR7
	dFMSxV+LftyHJnOUh//UTSLYWNsfD3aI8SZyXC+TpjZkHXnDmJrYO9vA6kqYYvkyvYxRU5YmYYj
	0lKPR7fsyRGNZCQsyuckXTBiPvjBxY9y6TRaHTW+otBlMmH/9/9ighgpzhP0bMYnK
X-Gm-Gg: ASbGncsTyE7dK9D/C5Kd7sxVrfs3VNFprLcqHZyqI1dxF65msBGHmI5UtCVSHngKZNR
	b6WIQ+A2xAWXJKDxuB0CIKMB3hPIZF2GTbr48ZFKXQQhfoWLGNJY+CSX/EfIJja9YYcM80urMAY
	NMhJDUNX3bbmv/OAvFv/quvn+HaeGS/8kN0I7HgveBBAWu2mg4lD3ztW+8RuF1UoOcsxTkLDnx8
	/jnORq7+U99FWTiqTmk1/+wGZMqo9e0NecaJHxVGO9g3i2npR5aKbfremHS0XkCOxtIF3tc0SJ1
	aTNDDvdctw==
X-Received: by 2002:a05:600c:1c0f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d0ac51609mr16259725e9.21.1741792282003;
        Wed, 12 Mar 2025 08:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5W/D3ES/M6kJRPjyEgSuPr9XA1jcGO11zxvnqEpd0Ho/mZnkNgRao4/TRivG1z/At8axlrA==
X-Received: by 2002:a05:600c:1c0f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-43d0ac51609mr16259465e9.21.1741792281627;
        Wed, 12 Mar 2025 08:11:21 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba686sm21749973f8f.19.2025.03.12.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:11:21 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:11:19 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Harald Mommer <harald.mommer@opensynergy.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Damir Shaikhutdinov <Damir.Shaikhutdinov@opensynergy.com>,
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v5] can: virtio: Initial virtio CAN driver.
Message-ID: <Z9GkFxPQ54Jzn45f@fedora>
References: <20240108131039.2234044-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <a366f529-c901-4cd1-a1a6-c3958562cace@wanadoo.fr>
 <0878aedf-35c2-4901-8662-2688574dd06f@opensynergy.com>
 <Z9FicA7bHAYZWJAb@fedora>
 <20250312-conscious-sloppy-pegasus-b5099d-mkl@pengutronix.de>
 <Z9GL6o01fuhTbHWO@fedora>
 <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250312-able-refreshing-hog-ed14e7-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oT4KeejX2Nygl5CvD0T7zxX_1Pt4WhXHqU738_YAYdQ_1741792282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2025 at 02:36:05PM +0100, Marc Kleine-Budde wrote:
> On 12.03.2025 14:28:10, Matias Ezequiel Vara Larsen wrote:
> > On Wed, Mar 12, 2025 at 11:41:26AM +0100, Marc Kleine-Budde wrote:
> > > On 12.03.2025 11:31:12, Matias Ezequiel Vara Larsen wrote:
> > > > On Thu, Feb 01, 2024 at 07:57:45PM +0100, Harald Mommer wrote:
> > > > > Hello,
> > > > > 
> > > > > I thought there would be some more comments coming and I could address
> > > > > everything in one chunk. Not the case, besides your comments silence.
> > > > > 
> > > > > On 08.01.24 20:34, Christophe JAILLET wrote:
> > > > > > 
> > > > > > Hi,
> > > > > > a few nits below, should there be a v6.
> > > > > > 
> > > > > 
> > > > > I'm sure there will be but not so soon. Probably after acceptance of the
> > > > > virtio CAN specification or after change requests to the specification are
> > > > > received and the driver has to be adapted to an updated draft.
> > > > > 
> > > > What is the status of this series?
> > > 
> > > There has been no movement from the Linux side. The patch series is
> > > quite extensive. To get this mainline, we need not only a proper Linux
> > > CAN driver, but also a proper VirtIO specification. 
> > 
> > Thanks for your answer. AFAIK the spec has been merged (see
> > https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4). 
> 
> Yes, the spec was merged. I think it was written with a specific
> use-case (IIRC: automotive, Linux on-top of a specific hypervisor) in
> mind, in Linux we have other use cases that might not be covered.

What use-case you have in Linux?

> 
> > > This whole project is too big for me to do it as a collaborative
> > > effort.
> > 
> > What do you mean?
> 
> I mean the driver is too big to review on a non-paid community based
> effort.
> 
I think I can help reviewing it. I will try to spend some time in the next
weeks.

Matias


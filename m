Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96C30F88
	for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpRTm4I0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700173357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=eVYRwZH6sXIrFWDlCdH/KfifoXv/KM4gb+nu7SJwO7k=;
	b=GpRTm4I0HToIByLcSkzEyLibm/SMvvFP1TbnOwYpUy/oUiiIecYRx2vgrHY35X5s6ChT/6
	xY7EGnFGrr/cOnrZ8Wjd1SKF6Lxt7okgy/zxndps/DAG3qGUX5x7rKrIW2xWzh1Ofvg53f
	cryCGF9DbDFTNwCvmv6xbWa5ARdegsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-3DeAtSn7MdGf-v5yeeU4jg-1; Thu, 16 Nov 2023 17:22:34 -0500
X-MC-Unique: 3DeAtSn7MdGf-v5yeeU4jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29A9585A58C;
	Thu, 16 Nov 2023 22:22:34 +0000 (UTC)
Received: from localhost (unknown [10.39.192.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99C44492B2E;
	Thu, 16 Nov 2023 22:22:33 +0000 (UTC)
Date: Thu, 16 Nov 2023 15:02:45 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.reshetova@intel.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux.dev
Subject: Using packed virtqueues in Confidential VMs
Message-ID: <20231116200245.GA336841@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UXVqzP4HaiAThsgh"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10


--UXVqzP4HaiAThsgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Elena,
You raised concerns about using packed virtqueues with untrusted devices at
Linux Plumbers Conference. I reviewed the specification and did not find
fundamental issues that would preclude the use of packed virtqueues in
untrusted devices. Do you have more information about issues with packed
virtqueues?

I also reviewed Linux's virtio_ring.c to look for implementation issues. One
thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed trusts
the fields of indirect descriptors that have been mapped to the device:

  flags = le16_to_cpu(desc->flags);

  dma_unmap_page(vring_dma_dev(vq),
                 le64_to_cpu(desc->addr),
                 le32_to_cpu(desc->len),
                 (flags & VRING_DESC_F_WRITE) ?
                 DMA_FROM_DEVICE : DMA_TO_DEVICE);

This could be problematic if the device is able to modify indirect descriptors.
However, the indirect descriptor table is mapped with DMA_TO_DEVICE:

  addr = vring_map_single(vq, desc,
                          total_sg * sizeof(struct vring_packed_desc),
                          DMA_TO_DEVICE);

There is no problem when there is an enforcing IOMMU that maps the page with
read-only permissions but that's not always the case. Software devices (QEMU,
vhost kernel, or vhost-user) usually have full access to guest RAM. They can
cause dma_unmap_page() to be invoked with arguments of their choice (except for
the first argument) by modifying indirect descriptors.

I am not sure if this poses a danger since software devices already have access
to guest RAM, but I think this code is risky. It would be safer for the driver
to stash away the arguments needed for dma_unmap_page() in memory that is not
mapped to the device.

Other than that, I didn't find any issues with the packed virtqueue
implementation.

Stefan

--UXVqzP4HaiAThsgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVWdWUACgkQnKSrs4Gr
c8jzIwf/VNcXA1BGnKbeFiqj4GYXPsVHLgF68vDjj90ry1WI2KEC7cFJMVbYTfQf
N+ZyTAczQSeVVVvT8qTDkO4qQWTrPzHvd1TrVHhYK8x9XZwA8fASiyEWDSPAzfKY
EBsAEJll9ZNmZUdbGTGCbJxMnE6LQLPCJrAgmG9vZ1OKgc/f5Ljitnr21DhHktq9
aPhKUaTXNVlhrZYoXsRg4erY718tzoBK4xGP+PixGwrg7r8kNUkXPINGanSMVHxB
iCeeMma1n3gHE0p7LAVm2KcUQHs7s4X0qdmwS1JrYr+liGQmo/x/CDsFoPYjf3x+
QHoL+/8BIu2oRBo6Zbhdcfa9wNwABw==
=UCVN
-----END PGP SIGNATURE-----

--UXVqzP4HaiAThsgh--


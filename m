Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865E25F857
	for <virtualization@lists.linux.dev>; Tue, 23 Jan 2024 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019607; cv=none; b=QhbNwvcfAR/9nwLjmNcLB9sHGic/epVqgm0iA0gMWMXOacxp2aCKAysU7x51XkmE2fBdCNnugoB2OHK9cmWLUSjVt/uQTpOZYPpoApJtxF51wNihEPHXXn+JOM249kjx8ZDFmipwoTFstHWtWY/29LcMfDg7pv31QhvxVMMs8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019607; c=relaxed/simple;
	bh=+0K0FE/1mJRFBCaKuXNDftE1C7Np4yImA6qBQbvBin4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8G4rdjybEFNlELQeT0JE/ZPsKrQLKC7Q9Kwijnnq5Qqk7yY5hTAa/6hgRy2BeWDEdZjDeBLwvkeX5zWhzNfmbusGowGH93afew6G51+zLtdLCw18A/+2y0C7P92mDTt9+1MuBfnF5ZuK2JZJwpOguyHp5b08+s4HRqMirWMWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOGFqVnc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOGFqVnc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706019605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlcL1UcCgDVT7MhGuA928CkmMK0FKDd9MTFr+LYjIzE=;
	b=hOGFqVncMfko3NqdaHF6O3/9bzmo+sUnpJfSPNnM1Aiit3iB+HZcqeCscFNZDReY/0V26S
	w7BO2iqCrhkXV9z4o6KxB4ekrmMINgUig83BoUqjM+zdFEF6XaUO3kHX/o20rF2tWgkCEc
	3Q2w7jR8KAoEdrqR4q0CHpdHrltWZbE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-JXZltlc9N36DPttQDoWOvw-1; Tue, 23 Jan 2024 09:20:00 -0500
X-MC-Unique: JXZltlc9N36DPttQDoWOvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 23B5E86C149;
	Tue, 23 Jan 2024 14:19:53 +0000 (UTC)
Received: from localhost (unknown [10.39.195.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79DC640D1B64;
	Tue, 23 Jan 2024 14:19:52 +0000 (UTC)
Date: Tue, 23 Jan 2024 09:19:50 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
Message-ID: <20240123141950.GC484337@fedora>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mDtWIMHGvnCXc65y"
Content-Disposition: inline
In-Reply-To: <20240122173645.1686078-13-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--mDtWIMHGvnCXc65y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 06:36:42PM +0100, Christoph Hellwig wrote:
> Call virtblk_read_limits and most of virtblk_probe_zoned_device before
> allocating the gendisk and thus request_queue and make them read into
> a queue_limits structure instead.  Pass this initialized queue_limits
> to blk_mq_alloc_disk to set the queue up with the right parameters
> from the start and only leave a few final touches for zoned devices
> to be done just before adding the disk.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/virtio_blk.c | 130 ++++++++++++++++++-------------------
>  1 file changed, 64 insertions(+), 66 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mDtWIMHGvnCXc65y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWvywYACgkQnKSrs4Gr
c8gzVwf9EKmoB088HuY7OLUbPNpCcZjXyWI+2X1VMsWjo6oMgMLBkwloYqFJXkuK
9iRxRmOeQ45ohORcQPhB/NbK2imZw/dA8CQaej6vUvXBVVJNM2bigRGPu+enbl+m
wT//j9fZFJLQrBuDMoOrbB5d13+ypPScTquwMs3FB0LEG2FvwJFRIX4YWMVAI/Rt
vd21AdV6AZcs6xBCLZIDAZgKaoWOqceI4n8lAp0tyEYJ+X/DIE21l6vF+fIQ6XMx
ZLm2g4WwHvxxaNfylNY4dsi5o6aGOvu+30LNd8+s4o2K5McAQ9IuOCNb858jLDw2
7KM3LbCZ1OT7KHY0fmETesHh+K9HOw==
=xF5e
-----END PGP SIGNATURE-----

--mDtWIMHGvnCXc65y--


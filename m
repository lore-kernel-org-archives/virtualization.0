Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8B01DE3CA
	for <virtualization@lists.linux.dev>; Thu, 14 Nov 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731549320; cv=none; b=Qb0M4YYi+ns/T0LuG0upOTY6kc4bWo5T8MXkolXNCPrTwjpIGECr2AFFKmqjcCk6tMIT8MYB+zZ15j+wdBnBgTXptxF4hovUTFIVrE+p9U6ichnCs0um+hbvglqNTklEAMmxoJEjQiTuR8RtQHGe4jcqovbrcfPPNzIYtFXkMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731549320; c=relaxed/simple;
	bh=mTr1lzdkO5zlYQaTbzNzWxFNkfsH1oazUf+9Hceyhxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkZkI8bypHS0Nhnidjls4lou1/QdENpKGDJtQlbaj/u9iBoIfNKADG1thj1jCRg+jrp/quKaC34eg76A5mlzCEnFKfeGQCopy0a7ivVDj7Osld03KhLP8ARos1dl/oaZNg4lsMZC4TenVZK0ZMwHY/1h5VAF7ZwGyW3Pj/sFqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jS4Z2mPw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS4Z2mPw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731549317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cgTPShsgIIZ1ZLU7PYZZo1vctkNnSNtVjEovX4LwaF0=;
	b=jS4Z2mPwdL7Smuiw4d6A41JlWjia8K0jVJVL51qftjpXF3DlMwG0CQ7/ptuEBBgxgOtjXN
	I+w95mTkj7rxENH4yKZGgO4PdI+NduWp0KEfja38hS1l2a0ovs9Kfxtji0SJzwKsW/ADUf
	aECiDZ/xBKukSp3Qj/mFFyssKm4ob/U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-XOUP_S0xM52svOns2kYspg-1; Wed,
 13 Nov 2024 20:55:13 -0500
X-MC-Unique: XOUP_S0xM52svOns2kYspg-1
X-Mimecast-MFC-AGG-ID: XOUP_S0xM52svOns2kYspg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAF7A195419D;
	Thu, 14 Nov 2024 01:55:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.113])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 760CE1956089;
	Thu, 14 Nov 2024 01:54:57 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:54:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 04/10] virtio: hookup irq_get_affinity callback
Message-ID: <ZzVYbJchbb-OD7m5@fedora>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
 <20241113-refactor-blk-affinity-helpers-v4-4-dd3baa1e267f@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-4-dd3baa1e267f@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Nov 13, 2024 at 03:26:18PM +0100, Daniel Wagner wrote:
> struct bus_type has a new callback for retrieving the IRQ affinity for a
> device. Hook this callback up for virtio based devices.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


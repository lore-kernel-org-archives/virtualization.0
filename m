Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02E11713
	for <virtualization@lists.linux.dev>; Thu, 25 Jan 2024 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156639; cv=none; b=FgJYw093353PaXghOhv/uR5I5oLTDoFOD3zctsfxvKXl8NnoQ8WbBeYkvj1h+F6Gw47uriqQDCGqbE5rAt9qY8GqhAk7hWtTQSjLGng4sUPdmv6sOCZWhHhatrcORFgcDaTqVI6+R7FBPPV1JYUQDNqS71nTQkhSoq7AD5kCWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156639; c=relaxed/simple;
	bh=R5YXEwIcgCvtxuAhjzaTmoUKArEnnx1P3nMdeJdX9a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEOl9iouacBF3aseNU/ao41NFgBWV2HVdMDCfh5VRFTnVYd83IfW0CO1qq8DN8qO2k6aFtrB8MEc6fkkgpiN58If59Yk/X8etAaxc6MEgM05qI27knVH8+CRtlZcyf5Qp9dtAhBmfBYSK7lFCWRlIx0elYgPaaHTBCK1kX3wfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Om+cfrMf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Om+cfrMf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706156637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gfdw7K+9a69TgeX8sgmnQQKT35P/vA2QZmn4VjqvAI=;
	b=Om+cfrMfUmcLMj/yzxGMuj2S3jXenculvTMLq5mly9Ufkcyvf/ZT3R0w17E9uP8fMbSglJ
	+/BaM5zN5tZInNsDQ5Lb5RXQr3Y8XZh4ojs77YkKsnDE1eHlU7JKfSV7oV6lX39kmRS1Fz
	XphyZJQ0VFXwu4NnQbObTleNrq5tCHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-gs1EVHb9PH62IwHqZz6GnA-1; Wed, 24 Jan 2024 23:23:52 -0500
X-MC-Unique: gs1EVHb9PH62IwHqZz6GnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB509881EA3;
	Thu, 25 Jan 2024 04:23:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C9651D5;
	Thu, 25 Jan 2024 04:23:48 +0000 (UTC)
Date: Thu, 25 Jan 2024 12:23:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZbHiOs3R8SgGClvN@fedora>
References: <ZbD7ups50ryrlJ/G@fedora>
 <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
 <772618f3-f4d3-470e-bf06-70d8ee66d7b0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772618f3-f4d3-470e-bf06-70d8ee66d7b0@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Thu, Jan 25, 2024 at 07:32:37AM +0900, Damien Le Moal wrote:
> On 1/25/24 00:41, Keith Busch wrote:
> > On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
> >> Requests are added to plug list in reverse order, and both virtio-blk
> >> and nvme retrieves request from plug list in order, so finally requests
> >> are submitted to hardware in reverse order via nvme_queue_rqs() or
> >> virtio_queue_rqs, see:
> >>
> >> 	io_uring       submit_bio  vdb      6302096     4096
> >> 	io_uring       submit_bio  vdb     12235072     4096
> >> 	io_uring       submit_bio  vdb      7682280     4096
> >> 	io_uring       submit_bio  vdb     11912464     4096
> >> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> >> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> >> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> >> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> >>
> >>
> >> May this reorder be one problem for virtio-blk and nvme-pci?
> > 
> > For nvme, it depends. Usually it's probably not a problem, though some
> > pci ssd's have optimizations for sequential IO that might not work if
> > these get reordered.
> 
> ZNS and zoned virtio-blk drives... Cannot use io_uring at the moment. But I do
> not thing we reliably can anyway, unless the issuer is CPU/ring aware and always
> issue writes to a zone using the same ring.

It isn't related with io_uring.

What matters is plug & none & queue_rqs(). If none is applied, any IOs
in single batch will be added to plug list, then dispatched to hardware
in reversed order via queue_rqs().

Thanks,
Ming


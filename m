Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52A31A83F0
	for <virtualization@lists.linux.dev>; Fri, 20 Dec 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685496; cv=none; b=rK0OdfVnW3SpVr70TiJGLoKeOPhZz+LRv8zH6oXZRo+tZI4vHxQ/o4hQBzyJ5k+RLn9lwZ0gQXjZ5B4HkDibpJXG0InCK7by5ye0piDmalk6fR2JIbL/SDUVYnOEdrzbl5GrRqgoimRQ6FAal2M2XsgltbkviscclqdeSXps57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685496; c=relaxed/simple;
	bh=23QV/Z0ncYZtoK3/rhdLeNgePmQZYVuuHiMosMT5tyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBApdT+wfMyt07yrCjmNeBlLyW/FEqI7MeOaZB5hlr94/CiQkwyoyTuT1BIOcK40CSf9lGxezrKlPYCCOTA4RRTioCbmqNFTFk2gPv3mpC6cAz1CE9sV1qGWt70Zpuqacpun/Wtt88KTV3e6/4q0nkU1Vlr5hBlidOVqU9G3u44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEuGnJVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEuGnJVv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734685493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TNCekzdNJZmUuGpzwzOxUn2DY6eci5HZ8lsy1e03Zho=;
	b=SEuGnJVvW27H54VFC6K1jq2v6R/kGJhhpoM6PGv22B4ahsO7kCeLH7sPAgjpv79ur9PHDB
	RjTRvqWn4fOhSQluilB/WcCJ33uwrhjER+pAHuokCht5VCzq2OnNnB2U7eUJ5oJ05+r4K8
	iK2wG0kxn5rSFROel3t44LS12Mlw/qc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-V_hpjVgqOaWhO_PeQOMseg-1; Fri,
 20 Dec 2024 04:04:50 -0500
X-MC-Unique: V_hpjVgqOaWhO_PeQOMseg-1
X-Mimecast-MFC-AGG-ID: V_hpjVgqOaWhO_PeQOMseg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53E431956048;
	Fri, 20 Dec 2024 09:04:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4FDE195608A;
	Fri, 20 Dec 2024 09:04:24 +0000 (UTC)
Date: Fri, 20 Dec 2024 17:04:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
Message-ID: <Z2UzE-CGa7YVwx0f@fedora>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-isolcpus-io-queues-v4-9-5d355fbb1e14@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Tue, Dec 17, 2024 at 07:29:43PM +0100, Daniel Wagner wrote:
> When we offlining a hardware context which also serves isolcpus mapped
> to it, any IO issued by the isolcpus will stall as there is nothing
> which handles the interrupts etc.
> 
> This configuration/setup is not supported at this point thus just issue
> a warning.

As I mentioned on patch 8, this io hang is regression on existed
applications which can work just fine with 'isolcpus=managed_irq'.

Do you think the added warning will prevent people from complaining
the regression? :-)


Thanks,
Ming


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4854689
	for <virtualization@lists.linux.dev>; Sat, 11 Jan 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736566873; cv=none; b=cam64iPdQP0VeAlxS1ffncUJjI0IzjXH43jo5UrChE9xA9VND7fr9a9cWjs727+NiPEMiVg6SfrImvNQMgb8Efiivcs9z5wV5UKcB5DLPXvnglcjwwtPSN06ATqjOg1I2kN9iNrVnuMeguqVMpqvB+Flg13j+VFdu7jvLooxd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736566873; c=relaxed/simple;
	bh=SY3ZkHRd1kXRdXW/z27Av3VBVXcUG9mklyUNsdIljHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pz3eE308Y0Dhko3dUnLMzIoOZft7xxBwJxw1GObTtul9oE2zJ0BFG4rCiXsFkIHR5JnBYAlNpdtH8rb0p3YFA6L2ajhhlpas4KkBqvt1C7dVvOj7qjhezxa3EAI1VQzQG39xioLPHCvYzI0z6Sj2/j/FOpw+LoHi+xAdkeHIjxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZ7jjB28; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ7jjB28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736566870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFwpZ4lNqHc8a93lKvyOmLFaFeR0q5NU2Y4FGP31Aws=;
	b=EZ7jjB285EWl+3u/UH5IsfZfsj0FymP3uPaW3xejc0CUlV53mOLHnjIGSj/+XTKCygOPvp
	jnElmWxce07S5kxK1eOBbK9DPyg2gDZssEa3leW9Q8Arqu28DrJI4xnonHcE2HXiwIkTN+
	saInPlFTwHKqIhQsgjzr/RI3WaBAQj0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-9L9FZIIhP4Sk_aSRXlxo0Q-1; Fri,
 10 Jan 2025 22:41:05 -0500
X-MC-Unique: 9L9FZIIhP4Sk_aSRXlxo0Q-1
X-Mimecast-MFC-AGG-ID: 9L9FZIIhP4Sk_aSRXlxo0Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD781956083;
	Sat, 11 Jan 2025 03:40:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFABD19560AB;
	Sat, 11 Jan 2025 03:40:44 +0000 (UTC)
Date: Sat, 11 Jan 2025 11:40:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 8/9] blk-mq: issue warning when offlining hctx with
 online isolcpus
Message-ID: <Z4HoN0F0cKD5G16F@fedora>
References: <20250110-isolcpus-io-queues-v5-0-0e4f118680b0@kernel.org>
 <20250110-isolcpus-io-queues-v5-8-0e4f118680b0@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110-isolcpus-io-queues-v5-8-0e4f118680b0@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Daniel,

On Fri, Jan 10, 2025 at 05:26:46PM +0100, Daniel Wagner wrote:
> When isolcpus=managed_irq is enabled, and the last housekeeping CPU for
> a given hardware context goes offline, there is no CPU left which
> handles the IOs anymore. If isolated CPUs mapped to this hardware
> context are online and an application running on these isolated CPUs
> issue an IO this will lead to stalls.
> 
> The kernel will not schedule IO to isolated CPUS thus this avoids IO
> stalls.
> 
> Thus issue a warning when housekeeping CPUs are offlined for a hardware
> context while there are still isolated CPUs online.

Why do you continue to send patch without addressing the fundamental regression?

This patchset does break existed applications which can't follow the new
rule of offlining CPU in order.

Again, it violates no-regression rule of kernel development.


Thanks,
Ming


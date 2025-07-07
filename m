Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82528A3E1
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874303; cv=none; b=B2W8u1uaxkHqxwesIDUPqFrBGbHuUl/A1jg27fLs2sa/QI9R+TmkPuuLAdNQPASZSYapNarGLitrqoe3HVtHXqf/lbmD0iPMOic6cuRQYY1jFhGuLn7rZCX8eYpD8xhGNFwpg3Ywe+8juJrkTl6IniVUS7BJGrPkM38azUWZpmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874303; c=relaxed/simple;
	bh=yK4aIwKsyQJ35dvSsCmxtiNLfyzf0Pq1Pic5u+EzrNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KglTeprEOFxmFJpg0Q/vBTMAivjOmKPEbOP2R5rhP85prxH2ZNFFUMxiW0XEvMBoS6DFHfShbMJgKPixi5vIdQAmfK+BTVQpI0Pj6o9ph/5urVOcBr/SogVuG7XgzH7CC6jBHPS7VWjlBk/iJUY2LsPn00zIvnqCXX8R4psyzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3hXKwsB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3hXKwsB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751874301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OalrTZVgCTcY8CfgCXR2MxPAgz7dMXIrKso6Jipbb5U=;
	b=M3hXKwsBbcPh/m1yaED/F8CxXK0Qgan7IyHBaxL3j7j3ruOCqbzFyRVPV09igBJrVsaQ4M
	cMttRfpa1+xQisn0ey9clM+NF8zdy7jf0YbMdsDD0UmatAJRYBbAYWFTy/FBH5rERAC2hY
	ivf3MhTnpuI486M0rpWRh+8NAmOFQtU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-ZccoFHbxPKqYGcrylrjfjg-1; Mon,
 07 Jul 2025 03:44:54 -0400
X-MC-Unique: ZccoFHbxPKqYGcrylrjfjg-1
X-Mimecast-MFC-AGG-ID: ZccoFHbxPKqYGcrylrjfjg_1751874292
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60B6F1801211;
	Mon,  7 Jul 2025 07:44:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.160])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0525F1956087;
	Mon,  7 Jul 2025 07:44:35 +0000 (UTC)
Date: Mon, 7 Jul 2025 15:44:30 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v7 09/10] blk-mq: prevent offlining hk CPUs with
 associated online isolated CPUs
Message-ID: <aGt63lJr2JY8VAqc@fedora>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org>
 <20250702-isolcpus-io-queues-v7-9-557aa7eacce4@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-isolcpus-io-queues-v7-9-557aa7eacce4@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jul 02, 2025 at 06:33:59PM +0200, Daniel Wagner wrote:
> When isolcpus=io_queue is enabled, and the last housekeeping CPU for a
> given hctx goes offline, there would be no CPU left to handle I/O. To
> prevent I/O stalls, prevent offlining housekeeping CPUs that are still
> serving isolated CPUs.
> 
> When isolcpus=io_queue is enabled and the last housekeeping CPU
> for a given hctx goes offline, no CPU would be left to handle I/O.
> To prevent I/O stalls, disallow offlining housekeeping CPUs that are
> still serving isolated CPUs.

If you do so, cpu offline is failed, and this change is user visible, please
document the cpu offline failure limit on Documentation/admin-guide/kernel-parameters.txt.
in the next patch.

Thanks,
Ming


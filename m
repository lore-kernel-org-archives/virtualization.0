Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918B299AB5
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 01:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997962; cv=none; b=UcE5dhkKeyW/Guw8c21Ed2dACzT6QdmmfO2gtMNyYEZc4lG+EcZc4nHDrife6ChBJACbhhIj1/wOaTn+1LzPRsstbruHn2j71SVbNWBRlSMNgjkpVPMEyShXUBDO3MItQqx1Dn35L7ZvtMjBogX7sCO6xQgQgTa/k6G9TA3OhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997962; c=relaxed/simple;
	bh=nTaC2MXKVwUNrsqMVxHeDZJeAIpAEmr1Yb7c4yWjDC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne2hmnfwHTqSeRE2OBJ4QkO631VTLvfSkGsjjOP4Oavt8s2awZkeNAGpAeUCSPVYfZoEY6y70bo84+mFHiUTTD8FDtucIoPyVyThUuGUG6qdtD6c2nBMEAKG09cwnqoDxt0GyoQ9CgRhaj/XfZH3OHw7FNZ4sk3OEWfSHnoQG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLgD0EGK; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLgD0EGK"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5D5D60EF9
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 01:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K_q1kbcFbcLV for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Nov 2025 01:39:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=ming.lei@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CAD7F60F27
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAD7F60F27
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLgD0EGK
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CAD7F60F27
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Nov 2025 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762997957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YE3L5VAgzoQWOHqB3Rk/jnMG/XnJ1XD/9vBp3BPJiDk=;
	b=RLgD0EGK/mWseEzVG8H+2C9u41Djp0a/8tysp496dKM/M0JoqoK6nr4UvequkHSFBT0Hv+
	qqwH8mOJ4MvrhaKPPddur82226Z58WCKVCz+/fGesJISZnF6UIYgiSeQ3GcLaR7CiaTxrI
	ekOy5SvJ77w3kNNlkJo8D/A+eYZuYEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-fUfLTIZSPE24s4BrvPuQOA-1; Wed,
 12 Nov 2025 20:39:14 -0500
X-MC-Unique: fUfLTIZSPE24s4BrvPuQOA-1
X-Mimecast-MFC-AGG-ID: fUfLTIZSPE24s4BrvPuQOA_1762997952
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43DEE18007F2;
	Thu, 13 Nov 2025 01:39:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 753CF30044E0;
	Thu, 13 Nov 2025 01:39:01 +0000 (UTC)
Date: Thu, 13 Nov 2025 09:38:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Guo, Wangyang" <wangyang.guo@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Tianyou Li <tianyou.li@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Dan Liang <dan.liang@intel.com>
Subject: Re: [PATCH RESEND] lib/group_cpus: make group CPU cluster aware
Message-ID: <aRU2sC5q5hCmS_eM@fedora>
References: <20251111020608.1501543-1-wangyang.guo@intel.com>
 <aRKssW96lHFrT2ZN@fedora>
 <b94a0d74-0770-4751-9064-2ef077fada14@intel.com>
 <aRMnR5DRdsU8lGtU@fedora>
 <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a101fe80-ca0b-4b4b-94b1-f08db1b164fc@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Nov 12, 2025 at 11:02:47AM +0800, Guo, Wangyang wrote:
> On 11/11/2025 8:08 PM, Ming Lei wrote:
> > On Tue, Nov 11, 2025 at 01:31:04PM +0800, Guo, Wangyang wrote:
> > > On 11/11/2025 11:25 AM, Ming Lei wrote:
> > > > On Tue, Nov 11, 2025 at 10:06:08AM +0800, Wangyang Guo wrote:
> > > > > As CPU core counts increase, the number of NVMe IRQs may be smaller than
> > > > > the total number of CPUs. This forces multiple CPUs to share the same
> > > > > IRQ. If the IRQ affinity and the CPU’s cluster do not align, a
> > > > > performance penalty can be observed on some platforms.
> > > > 
> > > > Can you add details why/how CPU cluster isn't aligned with IRQ
> > > > affinity? And how performance penalty is caused?
> > > 
> > > Intel Xeon E platform packs 4 CPU cores as 1 module (cluster) and share the
> > > L2 cache. Let's say, if there are 40 CPUs in 1 NUMA domain and 11 IRQs to
> > > dispatch. The existing algorithm will map first 7 IRQs each with 4 CPUs and
> > > remained 4 IRQs each with 3 CPUs each. The last 4 IRQs may have cross
> > > cluster issue. For example, the 9th IRQ which pinned to CPU32, then for
> > > CPU31, it will have cross L2 memory access.
> > 
> > 
> > CPUs sharing L2 usually have small number, and it is common to see one queue
> > mapping includes CPUs from different L2.
> > 
> > So how much does crossing L2 hurt IO perf?
> We see 15%+ performance difference in FIO libaio/randread/bs=8k.

As I mentioned, it is common to see CPUs crossing L2 in same group, but why
does it make a difference here? You mentioned just some platforms are
affected.

> > They still should share same L3 cache, and cpus_share_cache() should be
> > true when the IO completes on the CPU which belong to different L2 with the
> > submission CPU, and remote completion via IPI won't be triggered.
> Yes, remote IPI not triggered.

OK, in my test on AMD zen4, NVMe performance can be dropped to 1/2 - 1/3 if
remote IPI is triggered in case of crossing L3, which is understandable.

I will check if topo cluster can cover L3, if yes, the patch still can be
simplified a lot by introducing sub-node spread by changing build_node_to_cpumask()
and adding nr_sub_nodes.


Thanks,
Ming


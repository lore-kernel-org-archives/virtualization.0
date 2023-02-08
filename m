Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32460C636D3
	for <virtualization@archiver.kernel.org>; Wed,  8 Feb 2023 20:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9ACCB404BA;
	Wed,  8 Feb 2023 20:24:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9ACCB404BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jia+tDjr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OxJV3zpQV7Hi; Wed,  8 Feb 2023 20:24:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6F8E40338;
	Wed,  8 Feb 2023 20:24:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6F8E40338
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CC45C0033;
	Wed,  8 Feb 2023 20:24:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06CDCC002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 20:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF17F403F5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 20:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF17F403F5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jia+tDjr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nv_Jvcq7zY86
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 20:24:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAC16403CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAC16403CA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Feb 2023 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675887847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ml0XrxpI4s5idQPM/sdTSxC9+Tt+h6O846Ch5/bRl1Q=;
 b=Jia+tDjrvLAkXrqDyEfQ9smYJzvHm6ncYUbbc8ncusPcjpPriU3Dm0YZfn3kqHSqk6Lyar
 NnBR/t4iOLSGP6SChO2z+GnzGeBbBbCvZIfArFmffeozmwjQXrLDRuf52S5C2UXcKswSTb
 T9CgFHQkJk4q3mH8wNxGIafWB33PGxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-iW992OYAOHuTxPsWOzt1ow-1; Wed, 08 Feb 2023 15:24:04 -0500
X-MC-Unique: iW992OYAOHuTxPsWOzt1ow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE0A88028B0;
 Wed,  8 Feb 2023 20:24:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.9.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A6531121315;
 Wed,  8 Feb 2023 20:24:03 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id DCD97FA00F; Wed,  8 Feb 2023 15:23:51 -0500 (EST)
Date: Wed, 8 Feb 2023 15:23:51 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Peter-Jan Gootzen <peter-jan@gootzen.net>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y+QE17rQaj8/vjrl@redhat.com>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
 <Y+LDUmWyXCdPIriB@fedora> <Y+LJMwo/K2CHdaPc@redhat.com>
 <9babf0e8-19c3-bb1b-39f8-c755fdc57c8d@gootzen.net>
 <Y+N8x5kIe3pAaeUj@fedora>
 <82ddafee-7548-e7bd-2f41-24ce9251aa25@gootzen.net>
MIME-Version: 1.0
In-Reply-To: <82ddafee-7548-e7bd-2f41-24ce9251aa25@gootzen.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: German Maglione <gmaglione@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 miklos@szeredi.hu
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 08, 2023 at 05:29:25PM +0100, Peter-Jan Gootzen wrote:
> On 08/02/2023 11:43, Stefan Hajnoczi wrote:
> > On Wed, Feb 08, 2023 at 09:33:33AM +0100, Peter-Jan Gootzen wrote:
> > > 
> > > 
> > > On 07/02/2023 22:57, Vivek Goyal wrote:
> > > > On Tue, Feb 07, 2023 at 04:32:02PM -0500, Stefan Hajnoczi wrote:
> > > > > On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
> > > > > > On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
> > > > > > > On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
> > > > > > > > Hi,
> > > > > > > > 
> > > > > > 
> > > > > > [cc German]
> > > > > > 
> > > > > > > > For my MSc thesis project in collaboration with IBM
> > > > > > > > (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
> > > > > > > > performance of the virtio-fs driver in high throughput scenarios. We think
> > > > > > > > the main bottleneck is the fact that the virtio-fs driver does not support
> > > > > > > > multi-queue (while the spec does). A big factor in this is that our setup on
> > > > > > > > the virtio-fs device-side (a DPU) does not easily allow multiple cores to
> > > > > > > > tend to a single virtio queue.
> > > > > > 
> > > > > > This is an interesting limitation in DPU.
> > > > > 
> > > > > Virtqueues are single-consumer queues anyway. Sharing them between
> > > > > multiple threads would be expensive. I think using multiqueue is natural
> > > > > and not specific to DPUs.
> > > > 
> > > > Can we create multiple threads (a thread pool) on DPU and let these
> > > > threads process requests in parallel (While there is only one virt
> > > > queue).
> > > > 
> > > > So this is what we had done in virtiofsd. One thread is dedicated to
> > > > pull the requests from virt queue and then pass the request to thread
> > > > pool to process it. And that seems to help with performance in
> > > > certain cases.
> > > > 
> > > > Is that possible on DPU? That itself can give a nice performance
> > > > boost for certain workloads without having to implement multiqueue
> > > > actually.
> > > > 
> > > > Just curious. I am not opposed to the idea of multiqueue. I am
> > > > just curious about the kind of performance gain (if any) it can
> > > > provide. And will this be helpful for rust virtiofsd running on
> > > > host as well?
> > > > 
> > > > Thanks
> > > > Vivek
> > > > 
> > > There is technically nothing preventing us from consuming a single queue on
> > > multiple cores, however our current Virtio implementation (DPU-side) is set
> > > up with the assumption that you should never want to do that (concurrency
> > > mayham around the Virtqueues and the DMAs). So instead of putting all the
> > > work into reworking the implementation to support that and still incur the
> > > big overhead, we see it more fitting to amend the virtio-fs driver with
> > > multi-queue support.
> > > 
> > > 
> > > > Is it just a theory at this point of time or have you implemented
> > > > it and seeing significant performance benefit with multiqueue?
> > > 
> > > It is a theory, but we are currently seeing that using the single request
> > > queue, the single core attending to that queue on the DPU is reasonably
> > > close to being fully saturated.
> > > 
> > > > And will this be helpful for rust virtiofsd running on
> > > > host as well?
> > > 
> > > I figure this would be dependent on the workload and the users-needs.
> > > Having many cores concurrently pulling on their own virtq and then
> > > immediately process the request locally would of course improve performance.
> > > But we are offloading all this work to the DPU, for providing
> > > high-throughput cloud services.
> > 
> > I think Vivek is getting at whether your code processes requests
> > sequentially or in parallel. A single thread processing the virtqueue
> > that hands off requests to worker threads or uses io_uring to perform
> > I/O asynchronously will perform differently from a single thread that
> > processes requests sequentially in a blocking fashion. Multiqueue is not
> > necessary for parallelism, but the single queue might become a
> > bottleneck.
> 
> Requests are handled non-blocking with remote IO on the DPU. Our current
> architecture is as follows:
> T1: Tends to the Virtq, parses FUSE to remote IO and fires off the
> asynchronous remote IO.
> T2: Polls for completion on the remote IO and parses it back to FUSE, puts
> the FUSE buffers in a completion queue of T1.
> T1: Handles the Virtio completion and DMA of the requests in the CQ.
> 
> Thread 1 is busy polling on its two queues (Virtq and CQ) with equal
> priority, thread 2 is busy polling as well. This setup is not really
> optimal, but we are working within the constraints of both our DPU and
> remote IO stack.
> Currently we are able to get with sequential single job 4k throughput:
> Write: 246MiB/s
> Read: 20MiB/s

I had been doing some performance benchmarking for virtiofs and I found
some old results.

https://github.com/rhvgoyal/virtiofs-tests/tree/master/performance-results/feb-10-2021

While running on top of local fs, with bs=4K, with single queue I could
achieve more than 600MB/s.

NAME                    WORKLOAD                Bandwidth       IOPS            
default                 seqread-psync           625.0mb         156.2k          
no-tpool                seqread-psync           660.8mb         165.2k          

But catch here I think is that host is doing the caching. In your
case I am assuming there is no caching at DPU and all the I/O is
going to remote storage (which might be doing caching in memory).

Anyway, point I am trying to make is that even with single vq, virtiofs
can push a reasonable amount of I/O.

I will be cuirous to find how multiqueue can improve these numbers
further.

> We are not sure yet where the bottleneck is for reads, we hope to be able to
> match it to the write speed. For writes the two main bottlenecks we see are:
> the single Virtq (so limited parallelism on the DPU and remote-side) and
> that virtio-fs IO is constrained to the page size of 4k (NFS for example,
> who we are trying to replace, sees huge performance gains with larger block
> sizes).

I am wondering how did you conclude that single vq is the bottleneck for
performance and not the remote storage DPU is sending I/O to.

Thanks
Vivek

> 
> > > This is what I remembered as well, but can't find it clearly in the source
> > > right now, do you have references to the source for this?
> > 
> > virtio_blk.ko uses an irq_affinity descriptor to tell virtio_find_vqs()
> > to spread MSI interrupts across CPUs:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/block/virtio_blk.c#n609
> > 
> > The core blk-mq code has the blk_mq_virtio_map_queues() function to map
> > block layer queues to virtqueues:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-mq-virtio.c#n24
> > 
> > virtio_net.ko manually sets virtqueue affinity:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/virtio_net.c#n2283
> > 
> > virtio_net.ko tells the core net subsystem about queues using
> > netif_set_real_num_tx_queues() and then skbs are mapped to queues by
> > common code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/core/dev.c#n4079
> 
> Thanks for the pointers. :)
> 
> Thanks,
> Peter-Jan
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

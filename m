Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70677C636D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 21:57:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DC3181E64;
	Tue,  7 Feb 2023 21:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DC3181E64
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YV2gGv35
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9LwjwrYd_FSL; Tue,  7 Feb 2023 21:57:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A036C81E49;
	Tue,  7 Feb 2023 21:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A036C81E49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79CD2C0033;
	Tue,  7 Feb 2023 21:57:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53052C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A6376105A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A6376105A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YV2gGv35
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KGIDoityHgun
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:57:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D38EF6106B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D38EF6106B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675807041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TOkRaigupH8i6Gb6OACaNdT13Uwqnnh+QpDJlzfoAao=;
 b=YV2gGv35tUfTTEi6Pko1wouDDTKepMaYld0HYaPSU3/mq1FJnR/j/CbmWa/7CS2RVbiURI
 +PckNUV3jhrFqNFvbNtHVHhpAVv0L/aC3NTTQZzKGZJAZwFF12fihsHRzzqszCImxkEtCE
 poMr6vZzg2Nt0n+oI0TXyJb9nLaHYJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-MDj8C7h5NziTYLpyHkpHRw-1; Tue, 07 Feb 2023 16:57:18 -0500
X-MC-Unique: MDj8C7h5NziTYLpyHkpHRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8CF7101A52E;
 Tue,  7 Feb 2023 21:57:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3A2F1121314;
 Tue,  7 Feb 2023 21:57:17 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id 492B5F9162; Tue,  7 Feb 2023 16:57:07 -0500 (EST)
Date: Tue, 7 Feb 2023 16:57:07 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y+LJMwo/K2CHdaPc@redhat.com>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora> <Y+KsVhIR9aEoSdRu@redhat.com>
 <Y+LDUmWyXCdPIriB@fedora>
MIME-Version: 1.0
In-Reply-To: <Y+LDUmWyXCdPIriB@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: German Maglione <gmaglione@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Jonas Pfefferle <JPF@zurich.ibm.com>, miklos@szeredi.hu
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

On Tue, Feb 07, 2023 at 04:32:02PM -0500, Stefan Hajnoczi wrote:
> On Tue, Feb 07, 2023 at 02:53:58PM -0500, Vivek Goyal wrote:
> > On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
> > > On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
> > > > Hi,
> > > > 
> > 
> > [cc German]
> > 
> > > > For my MSc thesis project in collaboration with IBM
> > > > (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
> > > > performance of the virtio-fs driver in high throughput scenarios. We think
> > > > the main bottleneck is the fact that the virtio-fs driver does not support
> > > > multi-queue (while the spec does). A big factor in this is that our setup on
> > > > the virtio-fs device-side (a DPU) does not easily allow multiple cores to
> > > > tend to a single virtio queue.
> > 
> > This is an interesting limitation in DPU.
> 
> Virtqueues are single-consumer queues anyway. Sharing them between
> multiple threads would be expensive. I think using multiqueue is natural
> and not specific to DPUs.

Can we create multiple threads (a thread pool) on DPU and let these
threads process requests in parallel (While there is only one virt
queue).

So this is what we had done in virtiofsd. One thread is dedicated to
pull the requests from virt queue and then pass the request to thread
pool to process it. And that seems to help with performance in
certain cases.

Is that possible on DPU? That itself can give a nice performance
boost for certain workloads without having to implement multiqueue
actually.

Just curious. I am not opposed to the idea of multiqueue. I am
just curious about the kind of performance gain (if any) it can
provide. And will this be helpful for rust virtiofsd running on
host as well?

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

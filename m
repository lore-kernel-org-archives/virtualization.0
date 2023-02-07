Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CDFC636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 19:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29E4681E59;
	Tue,  7 Feb 2023 19:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29E4681E59
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEFzRugb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UktA8EiDRMhj; Tue,  7 Feb 2023 19:54:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9389A81E56;
	Tue,  7 Feb 2023 19:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9389A81E56
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C814C0033;
	Tue,  7 Feb 2023 19:54:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F3ADC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:54:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DEAD640AE7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:54:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEAD640AE7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eEFzRugb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CUSWTq0iledh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B420440186
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B420440186
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675799652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vxV72DgVCQC5IHxviguEQ/fPSLGhYn38Rupt2TSn+zI=;
 b=eEFzRugboOtyFTP659XkO8a1xR0lDSymM3PwHrgfwhD7wCQ7NgfsPdbPDhgKtdS/l8UsBu
 MtBFt3pqZ4BSAU0pZYBnzB1ffx5e2oYbI8Vywchhf0Zgw+FFquBu4PRsYoMmvH9QGuX2cW
 2ymvIxppfxqNIPLEGMEtFoD8kfquj6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-z4utw0kePq2m9hSj2iRbjg-1; Tue, 07 Feb 2023 14:54:09 -0500
X-MC-Unique: z4utw0kePq2m9hSj2iRbjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7945811E9C;
 Tue,  7 Feb 2023 19:54:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B276F175AD;
 Tue,  7 Feb 2023 19:54:08 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
 id 588E0F8F6E; Tue,  7 Feb 2023 14:53:58 -0500 (EST)
Date: Tue, 7 Feb 2023 14:53:58 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: virtio-fs: adding support for multi-queue
Message-ID: <Y+KsVhIR9aEoSdRu@redhat.com>
References: <2fd99bc2-0414-0b85-2bff-3a84ae6c23bd@gootzen.net>
 <Y+KqY3Nse0pVhd3X@fedora>
MIME-Version: 1.0
In-Reply-To: <Y+KqY3Nse0pVhd3X@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On Tue, Feb 07, 2023 at 02:45:39PM -0500, Stefan Hajnoczi wrote:
> On Tue, Feb 07, 2023 at 11:14:46AM +0100, Peter-Jan Gootzen wrote:
> > Hi,
> > 

[cc German]

> > For my MSc thesis project in collaboration with IBM
> > (https://github.com/IBM/dpu-virtio-fs) we are looking to improve the
> > performance of the virtio-fs driver in high throughput scenarios. We think
> > the main bottleneck is the fact that the virtio-fs driver does not support
> > multi-queue (while the spec does). A big factor in this is that our setup on
> > the virtio-fs device-side (a DPU) does not easily allow multiple cores to
> > tend to a single virtio queue.

This is an interesting limitation in DPU.

> > 
> > We are therefore looking to implement multi-queue functionality in the
> > virtio-fs driver. The request queues seem to already get created at probe,
> > but left unused afterwards. The current plan is to select the queue for a
> > request based on the current smp processor id and set the virtio queue
> > interrupt affinity for each core accordingly at probe.
> > 
> > This is my first time contributing to the Linux kernel so I am here to ask
> > what the maintainers' thoughts are about this plan.

In general we have talked about multiqueue support in the past but
nothing actually made upstream. So if there are patches to make
it happen, it should be reasonable to look at these and review.

Is it just a theory at this point of time or have you implemented
it and seeing significant performance benefit with multiqueue?

Thanks
Vivek
> 
> Hi,
> Sounds good. Assigning vqs round-robin is the strategy that virtio-net
> and virtio-blk use. virtio-blk could be an interesting example as it's
> similar to virtiofs. The Linux multiqueue block layer and core virtio
> irq allocation handle CPU affinity in the case of virtio-blk.
> 
> Which DPU are you targetting?
> 
> Stefan
> 
> > 
> > Best,
> > Peter-Jan Gootzen
> > MSc student at VU University Amsterdam & IBM Research Zurich
> > 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

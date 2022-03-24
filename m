Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486B4C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 17:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1EF78443B;
	Thu, 24 Mar 2022 17:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kcN6fqVBa_TT; Thu, 24 Mar 2022 17:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B8C084435;
	Thu, 24 Mar 2022 17:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5466AC001A;
	Thu, 24 Mar 2022 17:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B6A3C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 17:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFF1584439
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 17:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 153aVKzB2bq3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 17:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2566C84435
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648144587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K1rRuvdeVE+p43mVKCo+9JbhVwz1CF9F7SMs1X4zTSk=;
 b=QPir44n6HDOnvd4IeZlCypj620IwcRqZlodkgmlN2rsB/iA0BpdVCleWJsAyJtdb33ac80
 1RYtTkf4J6VESiZXsLGh8APeZmY5HHCcm0mdNKcVRKnlH64AS6rj6PnxrE/SgXqFxecieb
 j9zTArAq7G522iXIGP08tBSjwPVYv3Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-oLg5-G2jNJOTjIz9UBdKHg-1; Thu, 24 Mar 2022 13:56:24 -0400
X-MC-Unique: oLg5-G2jNJOTjIz9UBdKHg-1
Received: by mail-wm1-f70.google.com with SMTP id
 o10-20020a1c4d0a000000b0038c6e5fcbaeso1841862wmh.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 10:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K1rRuvdeVE+p43mVKCo+9JbhVwz1CF9F7SMs1X4zTSk=;
 b=Lfe0Od4o2rkf56qLoi97iVaVHsuztypmylFnXpbRVy5EIokJ8maglt9zNsyqAJDe1i
 JWwUK7RP2WAPapmonYejXasQC5t8htUQp7w6wwP/jCFDkxx0G6WVBpbq8EwG8I+YW/BZ
 w0lWkgKvjcsowoPtXXnokUp9NBkNap2au9cV2hz4Xsa4pdjDNFVQuTEjfhqcIy8ayMh1
 yNXTNzc4xyj5gPEUoBal+nwU3Zgx7YCFFUu96RiCnUHsDqXQtZNj4X8eafJ4AvQ6MNlg
 7VxmLjJeEq7dLIEm5Iwa9oLN8oCD+gPDgQiX5V8bMj4bFJcBw+oVsiP+Ag1Xo9erpuP9
 Iv4Q==
X-Gm-Message-State: AOAM5339Yla1JYjnaQaQkimLY+vb9FwqA1hYJHUEWOxGZLkih6/MGhcO
 SGLPKVwLqF5Kqf4Go0eEUlPcxhyCucfIEKcajESA/ASTlP3Utlwduo+P+YCReSAaIwuRTNt58a3
 kzS8FKoGZ8W9Tr7mog7JUl8G1tDZ2ASezomrrTAhUQw==
X-Received: by 2002:a05:6000:10ce:b0:204:203:9c87 with SMTP id
 b14-20020a05600010ce00b0020402039c87mr5368417wrx.181.1648144583000; 
 Thu, 24 Mar 2022 10:56:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiMTRzqgSTdtdRgb33oi/EZn8C/VD+y9bPjT79yWQxteeWRRsF3keydqYNyxNTNtpqmyRJvA==
X-Received: by 2002:a05:6000:10ce:b0:204:203:9c87 with SMTP id
 b14-20020a05600010ce00b0020402039c87mr5368399wrx.181.1648144582776; 
 Thu, 24 Mar 2022 10:56:22 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 a12-20020a5d53cc000000b00205a0ee9c74sm281412wrw.89.2022.03.24.10.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Mar 2022 10:56:22 -0700 (PDT)
Date: Thu, 24 Mar 2022 13:56:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v3 1/2] virtio-blk: support polling I/O
Message-ID: <20220324135556-mutt-send-email-mst@kernel.org>
References: <20220324140450.33148-1-suwan.kim027@gmail.com>
 <20220324140450.33148-2-suwan.kim027@gmail.com>
 <20220324103056-mutt-send-email-mst@kernel.org>
 <YjyEKuKhmhML6NN3@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <YjyEKuKhmhML6NN3@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mgurtovoy@nvidia.com, kernel test robot <lkp@intel.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Thu, Mar 24, 2022 at 11:46:02PM +0900, Suwan Kim wrote:
> On Thu, Mar 24, 2022 at 10:32:02AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Mar 24, 2022 at 11:04:49PM +0900, Suwan Kim wrote:
> > > This patch supports polling I/O via virtio-blk driver. Polling
> > > feature is enabled by module parameter "num_poll_queues" and it
> > > sets dedicated polling queues for virtio-blk. This patch improves
> > > the polling I/O throughput and latency.
> > > 
> > > The virtio-blk driver doesn't not have a poll function and a poll
> > > queue and it has been operating in interrupt driven method even if
> > > the polling function is called in the upper layer.
> > > 
> > > virtio-blk polling is implemented upon 'batched completion' of block
> > > layer. virtblk_poll() queues completed request to io_comp_batch->req_list
> > > and later, virtblk_complete_batch() calls unmap function and ends
> > > the requests in batch.
> > > 
> > > virtio-blk reads the number of poll queues from module parameter
> > > "num_poll_queues". If VM sets queue parameter as below,
> > > ("num-queues=N" [QEMU property], "num_poll_queues=M" [module parameter])
> > > It allocates N virtqueues to virtio_blk->vqs[N] and it uses [0..(N-M-1)]
> > > as default queues and [(N-M)..(N-1)] as poll queues. Unlike the default
> > > queues, the poll queues have no callback function.
> > > 
> > > Regarding HW-SW queue mapping, the default queue mapping uses the
> > > existing method that condsiders MSI irq vector. But the poll queue
> > > doesn't have an irq, so it uses the regular blk-mq cpu mapping.
> > > 
> > > For verifying the improvement, I did Fio polling I/O performance test
> > > with io_uring engine with the options below.
> > > (io_uring, hipri, randread, direct=1, bs=512, iodepth=64 numjobs=N)
> > > I set 4 vcpu and 4 virtio-blk queues - 2 default queues and 2 poll
> > > queues for VM.
> > > 
> > > As a result, IOPS and average latency improved about 10%.
> > > 
> > > Test result:
> > > 
> > > - Fio io_uring poll without virtio-blk poll support
> > > 	-- numjobs=1 : IOPS = 339K, avg latency = 188.33us
> > > 	-- numjobs=2 : IOPS = 367K, avg latency = 347.33us
> > > 	-- numjobs=4 : IOPS = 383K, avg latency = 682.06us
> > > 
> > > - Fio io_uring poll with virtio-blk poll support
> > > 	-- numjobs=1 : IOPS = 380K, avg latency = 167.87us
> > > 	-- numjobs=2 : IOPS = 409K, avg latency = 312.6us
> > > 	-- numjobs=4 : IOPS = 413K, avg latency = 619.72us
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 101 +++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 97 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 8c415be86732..3d16f8b753e7 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -37,6 +37,10 @@ MODULE_PARM_DESC(num_request_queues,
> > >  		 "0 for no limit. "
> > >  		 "Values > nr_cpu_ids truncated to nr_cpu_ids.");
> > >  
> > > +static unsigned int num_poll_queues;
> > > +module_param(num_poll_queues, uint, 0644);
> > > +MODULE_PARM_DESC(num_poll_queues, "The number of dedicated virtqueues for polling I/O");
> > > +
> > >  static int major;
> > >  static DEFINE_IDA(vd_index_ida);
> > >
> > 
> > Is there some way to make it work reasonably without need to set
> > module parameters? I don't see any other devices with a num_poll_queues
> > parameter - how do they handle this?
> 
> Hi Michael,
> 
> NVMe driver uses module parameter.
> 
> Please refer to this.
> -----
> drivers/nvme/host/pci.c
> 
> static unsigned int poll_queues;
> module_param_cb(poll_queues, &io_queue_count_ops, &poll_queues, 0644);
> MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
> -----
> 
> Regards,
> Suwan Kim

OK then. Let's maybe be consistent wrt parameter naming?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

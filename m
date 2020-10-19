Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D33FC43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 17:16:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709C7208B3
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 17:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMefzZ/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709C7208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB838872B9;
	Mon, 19 Oct 2020 17:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jDLup8r93ZDx; Mon, 19 Oct 2020 17:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A704D86C1B;
	Mon, 19 Oct 2020 17:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D1F4C0052;
	Mon, 19 Oct 2020 17:16:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99E79C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 17:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 866F187271
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 17:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqnl0-keSpW0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 17:16:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5DA9E86C1B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603127781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5niLxnNtbS1aOnJmQgMaE+zu+ug62i26X4CG928pr8=;
 b=CMefzZ/7kDlINoy38ncko77mqF9574xgi/Bc75Bt//CKwk327t2hvx+UnxMjNksh5OfP1d
 VCespPc6Ubdx4JRGhGixSvdkGuTol/+zOFH8BAQVDliOLB5Aa3BgohwFUECwt3+D0+RPl5
 WXEOCtPUp5otmAQnV1F+9KT1W7XdDDk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ryMPntFxNeOXIWH86wYAyg-1; Mon, 19 Oct 2020 13:16:15 -0400
X-MC-Unique: ryMPntFxNeOXIWH86wYAyg-1
Received: by mail-wm1-f72.google.com with SMTP id z7so69940wmi.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 10:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M5niLxnNtbS1aOnJmQgMaE+zu+ug62i26X4CG928pr8=;
 b=DuuUNJHbXmvDNjSOOhoTeG0j3iV18b/fsEovg6/4UsH7qDvsUCsnqRW/MyYwq0scLf
 nvGytDePBsj6m8yahmS9HJnFYFq6Cl9m6KUYQbX4uLTus3SeI1fHijfMgpsl0F+KXwHI
 ZODWaAR1sit9ZNtVdY41l8xrfZPDAifo+ufKWf9zD51m3rqPQwXrklIZgQ6FmIsFNwDa
 irVcV4nmxjc9EiZYetjmkVLiJ622hpxLpbanGxegN4BGiOQgz863GsRDodDnz5ZtLnrg
 2iD2QDv1+C/TQVUMkYdDXhlZ06J6EzJk4Ez/Y1Gh+Uf+tpkvYLleK3tHipWXTnwmBpP7
 4Mcw==
X-Gm-Message-State: AOAM530S/h8p/btdBs0bfe8yvngX6JWhkt7jMisJoXIKPZLWLQkQR34B
 mdIRRylpG8VfNaYNfGHIIBrO3UqxN2yexvSR6SX0vmrobgHd+Kv6yBoilXDADT6fM04KMUhtFG4
 KIfkY23Cei9qbdIsY3bQjh553alfU15G4Ia9S1gVSFQ==
X-Received: by 2002:adf:9027:: with SMTP id h36mr241378wrh.163.1603127774044; 
 Mon, 19 Oct 2020 10:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy50ZQWEz1nLN1KYZDUvO4T6N8ODx9NyHZdqht8KFxyP4+BwusFK11On3I7wbFaj0DqL0FZxg==
X-Received: by 2002:adf:9027:: with SMTP id h36mr241344wrh.163.1603127773767; 
 Mon, 19 Oct 2020 10:16:13 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id j7sm268311wmc.7.2020.10.19.10.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 10:16:12 -0700 (PDT)
Date: Mon, 19 Oct 2020 13:16:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [RFC 0/4] Introduce VDUSE - vDPA Device in Userspace
Message-ID: <20201019130815-mutt-send-email-mst@kernel.org>
References: <20201019145623.671-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20201019145623.671-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 virtualization@lists.linux-foundation.org
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

On Mon, Oct 19, 2020 at 10:56:19PM +0800, Xie Yongji wrote:
> This series introduces a framework, which can be used to implement
> vDPA Devices in a userspace program. To implement it, the work
> consist of two parts: control path emulating and data path offloading.
> 
> In the control path, the VDUSE driver will make use of message
> mechnism to forward the actions (get/set features, get/st status,
> get/set config space and set virtqueue states) from virtio-vdpa
> driver to userspace. Userspace can use read()/write() to
> receive/reply to those control messages.
> 
> In the data path, the VDUSE driver implements a MMU-based
> on-chip IOMMU driver which supports both direct mapping and
> indirect mapping with bounce buffer. Then userspace can access
> those iova space via mmap(). Besides, eventfd mechnism is used to
> trigger interrupts and forward virtqueue kicks.
> 
> The details and our user case is shown below:
> 
> ------------------------     -----------------------------------------------------------
> |                  APP |     |                          QEMU                           |
> |       ---------      |     | --------------------    -------------------+<-->+------ |
> |       |dev/vdx|      |     | | device emulation |    | virtio dataplane |    | BDS | |
> ------------+-----------     -----------+-----------------------+-----------------+-----
>             |                           |                       |                 |
>             |                           | emulating             | offloading      |
> ------------+---------------------------+-----------------------+-----------------+------
> |    | block device |           |  vduse driver |        |  vdpa device |    | TCP/IP | |
> |    -------+--------           --------+--------        +------+-------     -----+---- |
> |           |                           |                |      |                 |     |
> |           |                           |                |      |                 |     |
> | ----------+----------       ----------+-----------     |      |                 |     |
> | | virtio-blk driver |       | virtio-vdpa driver |     |      |                 |     |
> | ----------+----------       ----------+-----------     |      |                 |     |
> |           |                           |                |      |                 |     |
> |           |                           ------------------      |                 |     |
> |           -----------------------------------------------------              ---+---  |
> ------------------------------------------------------------------------------ | NIC |---
>                                                                                ---+---
>                                                                                   |
>                                                                          ---------+---------
>                                                                          | Remote Storages |
>                                                                          -------------------
> We make use of it to implement a block device connecting to
> our distributed storage, which can be used in containers and
> bare metal.

What is not exactly clear is what is the APP above doing.

Taking virtio blk requests and sending them over the network
in some proprietary way?

> Compared with qemu-nbd solution, this solution has
> higher performance, and we can have an unified technology stack
> in VM and containers for remote storages.
> 
> To test it with a host disk (e.g. /dev/sdx):
> 
>   $ qemu-storage-daemon \
>       --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server,nowait \
>       --monitor chardev=charmonitor \
>       --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/sdx,node-name=disk0 \
>       --export vduse-blk,id=test,node-name=disk0,writable=on,vduse-id=1,num-queues=16,queue-size=128
> 
> The qemu-storage-daemon can be found at https://github.com/bytedance/qemu/tree/vduse
> 
> Future work:
>   - Improve performance (e.g. zero copy implementation in datapath)
>   - Config interrupt support
>   - Userspace library (find a way to reuse device emulation code in qemu/rust-vmm)


How does this driver compare with vhost-user-blk (which doesn't need kernel support)?



> Xie Yongji (4):
>   mm: export zap_page_range() for driver use
>   vduse: Introduce VDUSE - vDPA Device in Userspace
>   vduse: grab the module's references until there is no vduse device
>   vduse: Add memory shrinker to reclaim bounce pages
> 
>  drivers/vdpa/Kconfig                 |    8 +
>  drivers/vdpa/Makefile                |    1 +
>  drivers/vdpa/vdpa_user/Makefile      |    5 +
>  drivers/vdpa/vdpa_user/eventfd.c     |  221 ++++++
>  drivers/vdpa/vdpa_user/eventfd.h     |   48 ++
>  drivers/vdpa/vdpa_user/iova_domain.c |  488 ++++++++++++
>  drivers/vdpa/vdpa_user/iova_domain.h |  104 +++
>  drivers/vdpa/vdpa_user/vduse.h       |   66 ++
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 1081 ++++++++++++++++++++++++++
>  include/uapi/linux/vduse.h           |   85 ++
>  mm/memory.c                          |    1 +
>  11 files changed, 2108 insertions(+)
>  create mode 100644 drivers/vdpa/vdpa_user/Makefile
>  create mode 100644 drivers/vdpa/vdpa_user/eventfd.c
>  create mode 100644 drivers/vdpa/vdpa_user/eventfd.h
>  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.c
>  create mode 100644 drivers/vdpa/vdpa_user/iova_domain.h
>  create mode 100644 drivers/vdpa/vdpa_user/vduse.h
>  create mode 100644 drivers/vdpa/vdpa_user/vduse_dev.c
>  create mode 100644 include/uapi/linux/vduse.h
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

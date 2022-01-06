Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9FDC433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Jan 2022 14:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0060681A6F;
	Thu,  6 Jan 2022 14:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6paK0YGctyRz; Thu,  6 Jan 2022 14:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B8B3823EB;
	Thu,  6 Jan 2022 14:42:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 587D3C0030;
	Thu,  6 Jan 2022 14:42:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D213C001E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 14:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C7F1823EB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 14:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rdKhBjoga8bm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 14:42:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB83781A6F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641480159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ziI0c5zpDrfARzHWSXczYyQXV4rhV2uF5H/yu3MCuIA=;
 b=hzjCB8vgmtRRoJgUfU+7Tqssh59RVeI0eWmS+3a235FiajsGSLfkkjpWwp66nYDVgZKDHu
 0yztWn5AnhP0IX+hXURGGUimEoM8kpTf1fXD44UzYUNcbaFzDdLHqtYvs0e9pQmkpTQptt
 sHvQUJudodyszxvXBV1+OGJoz3TnMns=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-133-DU1GTpOINbCV45VzyXmTWw-1; Thu, 06 Jan 2022 09:42:38 -0500
X-MC-Unique: DU1GTpOINbCV45VzyXmTWw-1
Received: by mail-qv1-f71.google.com with SMTP id
 jt5-20020a05621427e500b0041425477b6dso1328860qvb.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 06:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ziI0c5zpDrfARzHWSXczYyQXV4rhV2uF5H/yu3MCuIA=;
 b=B0oQgTMcH9t3909GPoFna43/trifKqRsnaAcbmfzQptqw5iEnuNnZvjaeE84Y7+e+I
 5AA5A30IlHZ5oJLu/K0uGsAfaTEJ6Awjg5fl9ZhPOwRSvtjk4IChHQR32SpSJin1CsgO
 OjEjpJ4TRzsYXjGLfNnQ8pPPzYqNY9b3u4t0djvMaH5OzAzdKri4QWeWJgfD5J90eUO3
 9Hiec3TqYWKJUKysGmMFIh/kB3iUXwhaYgnI4/I4dFjA6CkWqNHa2dzTGwXHdMUg7+KK
 MAnlfJECfN06l0PPM9jg8OHw1uuB+06k3zD4PMzxUMBZhhIOKke0WQ8vqtetjTG+R5lL
 mqyA==
X-Gm-Message-State: AOAM5336kbihQFjNd/VV1oNJ4F6LebraUVawzJ8yqLyP4w8RR9f3sEJR
 tEDyLiK49ZUrZDbTTbirZvlkQ71G//9YpWwvpyI1JiMHNfsBaP3kPPWbIdjoF0dqp4e2nFAVN8I
 HWcdc7VNCfcaHynOJ8ab5WNXSskFQde/zNGZUFj9b
X-Received: by 2002:a05:620a:bcc:: with SMTP id
 s12mr40958049qki.440.1641480157666; 
 Thu, 06 Jan 2022 06:42:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3FRhHacqx3hvXCbD5dR5jpsBPvBE8m7URZnWLXDzc/nf2wfv2oNDbZeyhxFZfEJhygNyDig==
X-Received: by 2002:a05:620a:bcc:: with SMTP id
 s12mr40958035qki.440.1641480157454; 
 Thu, 06 Jan 2022 06:42:37 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id t3sm2038461qtc.7.2022.01.06.06.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jan 2022 06:42:37 -0800 (PST)
Date: Thu, 6 Jan 2022 09:42:36 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <Ydb/3P+8nvjCjYfO@redhat.com>
References: <20211215084508.435401-1-hch@lst.de>
 <20211215084508.435401-5-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20211215084508.435401-5-hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, dm-devel@redhat.com,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Alasdair Kergon <agk@redhat.com>
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

On Wed, Dec 15 2021 at  3:45P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> These methods indirect the actual DAX read/write path.  In the end pmem
> uses magic flush and mc safe variants and fuse and dcssblk use plain ones
> while device mapper picks redirects to the underlying device.
> 
> Add set_dax_nocache() and set_dax_nomc() APIs to control which copy
> routines are used to remove indirect call from the read/write fast path
> as well as a lot of boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Vivek Goyal <vgoyal@redhat.com> [virtiofs]

Late to the game here, but quite a lot of dax DM code removed, thanks!

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

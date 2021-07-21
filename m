Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD89C636C9
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:43:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755516121F
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755516121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26FD4600C9;
	Wed, 21 Jul 2021 14:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-rpkbdjXasP; Wed, 21 Jul 2021 14:43:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5F12606C6;
	Wed, 21 Jul 2021 14:43:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6033C0010;
	Wed, 21 Jul 2021 14:43:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8BD9C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89791402C0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9xuNRzZ0lHHO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:43:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B55F14026B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626878579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aKs3+Xdc2Yu+lcTu46rzXDZNt56m1hbeO49s4AhSxWY=;
 b=b5AhOuFdD00mAzbUu8FtMiwbabWhYSquAVqRZ8p3qEwI2Tf/vVmTKkNvZqh7FUsBQduBiT
 a5EFU/N6YdBYJ5yf/HOmXS9dpumcMM8IHETAp4k3VvFhL95wM7JMfvaXx3LlkccuwyNWw0
 Hvn98gpB1U6fQaT9IYcjtVlrxVFDldw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-s-RFpwf6O2aYXw05b7YYdg-1; Wed, 21 Jul 2021 10:42:58 -0400
X-MC-Unique: s-RFpwf6O2aYXw05b7YYdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0B17760C0;
 Wed, 21 Jul 2021 14:42:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E0E61F21;
 Wed, 21 Jul 2021 14:42:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 568DB223E70; Wed, 21 Jul 2021 10:42:50 -0400 (EDT)
Date: Wed, 21 Jul 2021 10:42:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 0/4] virtiofs,fuse: support per-file DAX
Message-ID: <YPgyalU0avl9KI/U@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <YPXu3BefIi7Ts48I@redhat.com>
 <031efb1d-7c0d-35fb-c147-dcc3b6cac0ef@linux.alibaba.com>
 <YPchgf665bwUMKWU@redhat.com>
 <38e9da34-cc2b-f496-7ebb-18db8da1aa01@linux.alibaba.com>
 <YPgXuacFfJ/JVRjo@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPgXuacFfJ/JVRjo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: miklos@szeredi.hu, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org, joseph.qi@linux.alibaba.com,
 bo.liu@linux.alibaba.com, stefanha@redhat.com, linux-fsdevel@vger.kernel.org
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

On Wed, Jul 21, 2021 at 08:48:57AM -0400, Vivek Goyal wrote:
[..]
> > > So is "dax=inode" enough for your needs? What's your requirement,
> > > can you give little bit of more details.
> > 
> > In our use case, the backend fs is something like SquashFS on host. The
> > content of the file on host is downloaded *as needed*. When the file is
> > not completely ready (completely downloaded), the guest will follow the
> > normal IO routine, i.e., by FUSE_READ/FUSE_WRITE request. While the file
> > is completely ready, per-file DAX is enabled for this file. IOW the FUSE
> > server need to dynamically decide if per-file DAX shall be enabled,
> > depending on if the file is completely downloaded.
> 
> So you don't want to enable DAX yet because guest might fault on
> a section of file which has not been downloaded yet?
> 
> I am wondering if somehow user fault handling can help with this.
> If we could handle faults for this file in user space, then you
> should be able to download that particular page[s] and resolve
> the fault?

Stefan mentioned that can't we block when fuse mmap request comes
in and download corresponding section of file. Or do whatever you
are doing in FUSE_READ. 

IOW, even if you enable dax in your use case on all files,
FUSE_SETUPMAPPING request will give you control to make sure 
file section being mmaped has been downloaded.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

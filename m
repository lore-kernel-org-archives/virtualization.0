Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D9C4338F
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 15:20:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B639A60F58
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 15:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B639A60F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7976A80E9C;
	Tue, 17 Aug 2021 15:20:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ybyw-wv1ayFb; Tue, 17 Aug 2021 15:20:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E2CB780D3B;
	Tue, 17 Aug 2021 15:20:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B067C0010;
	Tue, 17 Aug 2021 15:20:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2163DC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 15:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04A834044A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 15:20:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kv5T6kI3eUVI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 15:20:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EC33401CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629213608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Be+Prm+eAgDG7EnJxJOUP6plitOtAD+UIwtIrNoX3hY=;
 b=UmnXreIRxBvY/NjoPSg/AFWtLbcbRy6hRddG2cGVo0wCPXEGt94ES4sCRUVRPRponnCaDB
 dZmUm+99zcuzmVit2Ei8wDvZOE03PlalINaTZYicyjkAwbtpNyKzR+ett6/pL/0HmF7ypu
 JisTH2mtAr9N3erj0ihM6gv0fCi1JN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-C0N0TL4FMMuP7TLeFOLm0Q-1; Tue, 17 Aug 2021 11:20:06 -0400
X-MC-Unique: C0N0TL4FMMuP7TLeFOLm0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A665100E324;
 Tue, 17 Aug 2021 15:20:05 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F4636A90E;
 Tue, 17 Aug 2021 15:19:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 82EE3220637; Tue, 17 Aug 2021 11:19:52 -0400 (EDT)
Date: Tue, 17 Aug 2021 11:19:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [Virtio-fs] [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRvTmIjt/WAl/UOP@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRuCHvhICtTzMK04@work-vm>
 <CAJfpegvM+S5Xru3Yfc88C64mecvco=f99y-TajQBDfkLD-S8zQ@mail.gmail.com>
 <0896b1f6-c8c4-6071-c05b-a333c6cccacd@linux.alibaba.com>
 <CAJfpeguA3zeJq-HJUVZHv4nNybqFezkzPNhcWmj0n5+i7YpW4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpeguA3zeJq-HJUVZHv4nNybqFezkzPNhcWmj0n5+i7YpW4Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, linux-fsdevel@vger.kernel.org
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

On Tue, Aug 17, 2021 at 04:11:14PM +0200, Miklos Szeredi wrote:

[..]
> > As for virtiofs, Dr. David Alan Gilbert has mentioned that various files
> > may compete for limited DAX window resource.
> >
> > Besides, supporting DAX for small files can be expensive. Small files
> > can consume DAX window resource rapidly, and if small files are accessed
> > only once, the cost of mmap/munmap on host can not be ignored.
> 
> That's a good point.   Maybe we should disable DAX for file sizes much
> smaller than the chunk size?

This indeed seems like a valid concern. 2MB chunk size will consume
512 struct page entries. If an entry is 64 bytes in size, then that's
32K RAM used to access 4K bytes of file. Does not sound like good usage
of resources.

If we end up selectively disabling dax based on file size, two things
come to me mind.

- Will be good if it is users can opt-in for this behavior. There
  might be a class of users who always want to enable dax on all
  files.

- Secondly, we will have to figure out how to do it safely in the
  event of shared filesystem where file size can change suddenly.
  Will need to make sure change from dax to no-dax and vice-versa
  is safe w.r.t page cache and other paths.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

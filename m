Return-Path: <SRS0=dYih=NI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1887C4320A
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 12:49:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A1E60EE4
	for <virtualization@archiver.kernel.org>; Tue, 17 Aug 2021 12:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 78A1E60EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47443607F2;
	Tue, 17 Aug 2021 12:49:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PhuseuEouEzb; Tue, 17 Aug 2021 12:49:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D8BF160815;
	Tue, 17 Aug 2021 12:49:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C041CC001A;
	Tue, 17 Aug 2021 12:49:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3461BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 12:49:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 23B0040196
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 12:49:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z66Mh9co2fmy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 12:49:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87E8D40185
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Aug 2021 12:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629204573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xncVMYj4I8zKo79uuJkhEb9a+TNyKb9f4/f8x3DpaAI=;
 b=g+nNCi/ey5XzFsxuuwm+sNtqfmBQvvSbGkTEiUtYNz11x8uImkSu3ZZ8vkgOS7nMBqONyd
 cQN0TX8fuhLCCM475qz0KAKBeVTF2y2fQwEc5Qld+qHthSE9y1ZhLRYvDpi3sxgyAb/g2O
 rl9nR/j1XaHF+NucyTRvbgarFlmwH98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-kdxSo6RsMOKNgZGGOCZe3A-1; Tue, 17 Aug 2021 08:49:32 -0400
X-MC-Unique: kdxSo6RsMOKNgZGGOCZe3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD485192CC4F;
 Tue, 17 Aug 2021 12:49:30 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.10.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB68620DE;
 Tue, 17 Aug 2021 12:49:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id B210D220637; Tue, 17 Aug 2021 08:39:02 -0400 (EDT)
Date: Tue, 17 Aug 2021 08:39:02 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YRut5sioYfc2M1p7@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org,
 virtio-fs-list <virtio-fs@redhat.com>, linux-fsdevel@vger.kernel.org,
 Liu Bo <bo.liu@linux.alibaba.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Aug 17, 2021 at 10:06:53AM +0200, Miklos Szeredi wrote:
> On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
> >
> > This patchset adds support of per-file DAX for virtiofs, which is
> > inspired by Ira Weiny's work on ext4[1] and xfs[2].
> 
> Can you please explain the background of this change in detail?
> 
> Why would an admin want to enable DAX for a particular virtiofs file
> and not for others?

Initially I thought that they needed it because they are downloading
files on the fly from server. So they don't want to enable dax on the file
till file is completely downloaded. But later I realized that they should
be able to block in FUSE_SETUPMAPPING call and make sure associated
file section has been downloaded before returning and solve the problem.
So that can't be the primary reason.

Other reason mentioned I think was that only certain files benefit
from DAX. But not much details are there after that. It will be nice
to hear a more concrete use case and more details about this usage.

Thanks
Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

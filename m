Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082ABC4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 16:58:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CFB060E09
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 16:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CFB060E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64F934048E;
	Wed, 18 Aug 2021 16:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFgs9_wQQfot; Wed, 18 Aug 2021 16:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 00F64403BD;
	Wed, 18 Aug 2021 16:58:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8FD8C0010;
	Wed, 18 Aug 2021 16:58:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 721C5C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 16:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57D9160BB9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 16:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8CH5aXuN2823
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 16:58:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B40660BB8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629305910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jIOt3Tax48EHjcS9UTqIzuMFAHA5tBCIflSiAzkMVWM=;
 b=NflkoGIe3F3RXoA/EPjrS4bgAedHqe2rbitzkNot+NS9eambByYPX/tDjja3YpEjGzpJgH
 RX+mP3jkfXoTew9sgr4uz3tyHTCc2Q98yYDH3AZxrd0yZC0mcd8OCau+yhg9JOGkZmKY/y
 CDtKxOq8o/dn8Jt0W68BbS/0IxZvXxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-LcooZPDlPl-FClJC09JXig-1; Wed, 18 Aug 2021 12:58:28 -0400
X-MC-Unique: LcooZPDlPl-FClJC09JXig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9279019611A0;
 Wed, 18 Aug 2021 16:58:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C16211036D11;
 Wed, 18 Aug 2021 16:58:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 23438223863; Wed, 18 Aug 2021 12:58:18 -0400 (EDT)
Date: Wed, 18 Aug 2021 12:58:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
Message-ID: <YR08KnP8cO8LjKY7@redhat.com>
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com>
 <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
 <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com>
 <1100b711-012d-d68b-7078-20eea6fa4bab@linux.alibaba.com>
 <CAJfpegsdX1H_=ZMORA-9YiBGdszG0WVmAjFY2QSZPa0iLUEjXw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJfpegsdX1H_=ZMORA-9YiBGdszG0WVmAjFY2QSZPa0iLUEjXw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

On Wed, Aug 18, 2021 at 07:08:24AM +0200, Miklos Szeredi wrote:
> On Wed, 18 Aug 2021 at 05:40, JeffleXu <jefflexu@linux.alibaba.com> wrote:
> 
> > I'm not sure if I fully understand your idea. Then in this case, host
> > daemon only prepares 4KB while guest thinks that the whole DAX window
> > (e.g., 2MB) has been fully mapped. Then when guest really accesses the
> > remained part (2MB - 4KB), page fault is triggered, and now host daemon
> > is responsible for downloading the remained part?
> 
> Yes.  Mapping an area just means setting up the page tables, it does
> not result in actual data transfer.

But daemon will not get the page fault (its the host kernel which
will handle it). And host kernel does not know that file chunk 
needs to be downloaded.

- Either we somehow figure out user fault handling and somehow
  qemu/virtiofsd get to handle the page fault then they can
  download file.

- Or we download the 2MB chunk at the FUSE_SETUPMAPPING time so
  that later kernel fault can handle it.

Am I missing something.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

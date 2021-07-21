Return-Path: <SRS0=hAHP=MN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C89C12002
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:40:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F71608FE
	for <virtualization@archiver.kernel.org>; Wed, 21 Jul 2021 14:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F71608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CE40607BE;
	Wed, 21 Jul 2021 14:40:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lhWrSKSmVATt; Wed, 21 Jul 2021 14:40:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 034A8606E7;
	Wed, 21 Jul 2021 14:40:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C09C5C0010;
	Wed, 21 Jul 2021 14:40:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76487C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 648F54021E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:40:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9BNZ169ucmk2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:40:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D5D4401DF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626878434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pe6IL0lY4+BmYk7TYzqnbY5CUvQ+ZXsB2yM3wwA1rMA=;
 b=G+wIPzFdXMRhXWRNTLF1nyIgyixZ9vBDyBNwmj30S1shWczCGRd63AMhSP3n+raTjAD8bb
 Y9vMJWJ/91ezfW5BUvDva1qFMhZCmDRJg8no8nwqB+xee3BeMbTugnizU7XghXP4sYmbwu
 jSiLcbgcphW6gkwhvER8bCjB3u8Wy2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-nUsPwB42Mn-jARrDsSXGXw-1; Wed, 21 Jul 2021 10:40:30 -0400
X-MC-Unique: nUsPwB42Mn-jARrDsSXGXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 386F564ADA;
 Wed, 21 Jul 2021 14:40:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB37A5C1BB;
 Wed, 21 Jul 2021 14:40:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 3514C223E70; Wed, 21 Jul 2021 10:40:23 -0400 (EDT)
Date: Wed, 21 Jul 2021 10:40:23 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPgx10F0ZMDnhGex@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXWA+Uo5vFuHCH0@redhat.com>
 <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
 <YPcjlN1ThL4UX8dn@redhat.com>
 <0ad3b5d2-3d19-a33b-7841-1912ea30c081@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ad3b5d2-3d19-a33b-7841-1912ea30c081@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On Wed, Jul 21, 2021 at 10:14:44PM +0800, JeffleXu wrote:
[..]
> > Also, please copy virtiofs list (virtio-fs@redhat.com) when you post
> > patches next time.
> > 
> 
> Got it. By the way, what's the git repository of virtiofsd? AFAIK,
> virtiofsd included in qemu (git@github.com:qemu/qemu.git) doesn't
> support DAX yet?

Yes virtiofsd got merged in qemu upstream. And it does not support dax
yet. David is still sorting out couple of issues based on feedback. I
think following is the branch where he had pushed his latest patches.

https://gitlab.com/virtio-fs/qemu/-/tree/virtio-fs-dev

David, please correct me if that's not the case.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

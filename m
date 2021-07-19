Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA159C07E95
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 18:41:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6324861003
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 18:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6324861003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1934C6075B;
	Mon, 19 Jul 2021 18:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2-7WjqxpwdCj; Mon, 19 Jul 2021 18:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C53CC60752;
	Mon, 19 Jul 2021 18:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95031C0010;
	Mon, 19 Jul 2021 18:41:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A41CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 18:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF9DD40350
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 18:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AdxIy-aMN0ks
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 18:41:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8189F4034D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 18:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626720099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p204Ua/8UMVEDK/XuK5qa9JXwwuGxX3Scr0fvegt0Q8=;
 b=NU4B4IIYND7BQGflnhCsU1nYeg1AJ+c9LkcHabMcQUX+2wmaa4lzEOQHrHj36R/LHebBdM
 QHlYtaw7qE+Lfol1DBBnV9F8BesY9d1UnYhr95dvYyyMXqb/qw05r8/WhrW8Y8sYkzo7Za
 nLpM6zHCr5EbEIjG2nEqzzIox3n3sgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-iNZ3s_tHMRaavc_J-FzkGg-1; Mon, 19 Jul 2021 14:41:37 -0400
X-MC-Unique: iNZ3s_tHMRaavc_J-FzkGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04456101F7A5;
 Mon, 19 Jul 2021 18:41:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F16055D6A1;
 Mon, 19 Jul 2021 18:41:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 79845223E4F; Mon, 19 Jul 2021 14:41:30 -0400 (EDT)
Date: Mon, 19 Jul 2021 14:41:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPXHWmiYXMNxxhf7@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210716104753.74377-4-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: miklos@szeredi.hu, virtualization@lists.linux-foundation.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
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

On Fri, Jul 16, 2021 at 06:47:52PM +0800, Jeffle Xu wrote:
> Add one flag for fuse_attr.flags indicating if DAX shall be enabled for
> this file.
> 
> When the per-file DAX flag changes for an *opened* file, the state of
> the file won't be updated until this file is closed and reopened later.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

[..]
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 36ed092227fa..90c9df10d37a 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -184,6 +184,9 @@
>   *
>   *  7.34
>   *  - add FUSE_SYNCFS
> + *
> + *  7.35
> + *  - add FUSE_ATTR_DAX
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -449,8 +452,10 @@ struct fuse_file_lock {
>   * fuse_attr flags
>   *
>   * FUSE_ATTR_SUBMOUNT: Object is a submount root
> + * FUSE_ATTR_DAX: Enable DAX for this file in per-file DAX mode
>   */
>  #define FUSE_ATTR_SUBMOUNT      (1 << 0)
> +#define FUSE_ATTR_DAX		(1 << 1)

Generic fuse changes (addition of FUSE_ATTR_DAX) should probably in
a separate patch. 

I am not clear on one thing. If we are planning to rely on persistent
inode attr (FS_XFLAG_DAX as per Documentation/filesystems/dax.rst), then
why fuse server needs to communicate the state of that attr using a 
flag? Can client directly query it?  I am not sure where at these
attrs stored and if fuse protocol currently supports it.

What about flag STATX_ATTR_DAX. We probably should report that too
in stat if we are using dax on the inode?

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

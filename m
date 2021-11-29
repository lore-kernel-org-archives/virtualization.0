Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0C9C433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 13:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49E1E403FF;
	Mon, 29 Nov 2021 13:33:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VllxSDniNXhg; Mon, 29 Nov 2021 13:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72AC0403EF;
	Mon, 29 Nov 2021 13:33:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 441CCC0012;
	Mon, 29 Nov 2021 13:33:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2241CC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 13:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E4814055F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 13:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zALMNOdQJaLQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 13:33:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 45BDE403CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 13:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638192830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p/Ma4OjV1QAHTKX0nrgFV6x1HeF1oMP1qvIIB/p5juI=;
 b=d46bxNKDPFAtAz64syUXm8k7uVfiYYO6we26EJPLu58OEFdG/R/qqRnZvH2c23Droi7MFI
 +/gytiWMvlAa4OvWSZYS3toa09b+oiTp27g9RaONgOwsHpblgs7AEyuf/zJcW3PR19NWBT
 3aNp4+lvOO3hsh9hQaNZfot7kAqeDa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-i8s6QBecPMqroT3LKu8W_w-1; Mon, 29 Nov 2021 08:33:46 -0500
X-MC-Unique: i8s6QBecPMqroT3LKu8W_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748721927800;
 Mon, 29 Nov 2021 13:33:45 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9356A10013D6;
 Mon, 29 Nov 2021 13:33:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 1D5B1225EC1; Mon, 29 Nov 2021 08:33:42 -0500 (EST)
Date: Mon, 29 Nov 2021 08:33:42 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2] fuse: rename some files and clean up Makefile
Message-ID: <YaTWtgSrtSDCU1ti@redhat.com>
References: <1638008002-3037-1-git-send-email-yangtiezhu@loongson.cn>
 <YaSpRwMlMvcIIMZo@stefanha-x1.localdomain>
 <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7277c1ee-6f7b-611d-180d-866db37b2bd7@loongson.cn>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Miklos Szeredi <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel@vger.kernel.org
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

On Mon, Nov 29, 2021 at 09:27:17PM +0800, Tiezhu Yang wrote:
> On 11/29/2021 06:19 PM, Stefan Hajnoczi wrote:
> > On Sat, Nov 27, 2021 at 06:13:22PM +0800, Tiezhu Yang wrote:
> > > No need to generate virtio_fs.o first and then link to virtiofs.o, just
> > > rename virtio_fs.c to virtiofs.c and remove "virtiofs-y := virtio_fs.o"
> > > in Makefile, also update MAINTAINERS. Additionally, rename the private
> > > header file fuse_i.h to fuse.h, like ext4.h in fs/ext4, xfs.h in fs/xfs
> > > and f2fs.h in fs/f2fs.
> > 
> > There are two separate changes in this patch (virtio_fs.c -> virtiofs.c
> > and fuse_i.h -> fuse.h). A patch series with two patches would be easier
> > to review and cleaner to backport.
> > 
> > I'm happy with renaming virtio_fs.c to virtiofs.c:
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> 
> Hi Stefan and Miklos,
> 
> Thanks for your reply, what should I do now?
> 
> (1) split this patch into two separate patches to send v3;
> (2) just ignore this patch because
> "This will make backport of bugfixes harder for no good reason."
> said by Miklos.

I agree with Miklos that there does not seem to be a very strong reason
to rename. It probably falls in the category of nice to have cleanup. But
it will also make backports harder. So I also like the idea of not making
this change.

Vivek

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

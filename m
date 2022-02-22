Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28558C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 23:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E54401CD;
	Tue, 22 Feb 2022 23:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KIjGc0-FJCbA; Tue, 22 Feb 2022 23:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4BB3C4015B;
	Tue, 22 Feb 2022 23:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27C79C0021;
	Tue, 22 Feb 2022 23:18:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C551C0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59DE3401CD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VZy6EYBO2oQc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:18:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 273F84015B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WgBSWEgjN1w1rfgdGYqlLhuiwSB4vMovObriufzKuVs=; b=AYR1hh89Un+yzNFBdfLoaw/kgX
 TcXqsECvACDyD51bpK5KdTdaWCFE/wMx973gswpmlGWtqfvzAet6H1bfuTAfVh+NgRzyGT757ZeNE
 tgOmWLYHTvkpoAr3UBHHidTzd7tKTRndZBGMau3jpsP2cW7vl5xWroNgRH9aAR49wfVOvjmxsOwEw
 Cc+Ix1tSTQyZ3wSVBvHlIz3jjFe3VgnZjZpAfSrXfDHie06eZZDTyTezLhvvIEzNHyfsgebXE+q3b
 FwTLs1EvcLliZR5Js16MuSAG+SpMNFwLRUnLGFj4W12eUM9+o+1kOE3pad4Zuc0/LVyDAszOmKc4K
 drZ4/7NA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nMeQE-003E8X-Ff; Tue, 22 Feb 2022 23:18:18 +0000
Date: Tue, 22 Feb 2022 23:18:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <YhVvOsI0+xVAKHdr@casper.infradead.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Feb 22, 2022 at 07:58:33AM +0000, David Woodhouse wrote:
> On Tue, 2022-02-22 at 01:31 -0500, Michael S. Tsirkin wrote:
> > On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> > > 
> > > [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> > > Detected virtual address range 0x1000-0x7ffffffff000
> > > spurious wakeups: 0x0 started=0x100000 completed=0x100000
> > > 
> > > Although in some circumstances I also see a different build failure:
> > > 
> > > cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c

Trying to test this myself ...

$ cd tools/virtio/
$ make
...
cc -lpthread  virtio_test.o virtio_ring.o   -o virtio_test
/usr/bin/ld: virtio_ring.o: in function `spin_lock':
/home/willy/kernel/folio/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'

So this is not the only problem here?

> > > In file included from ./linux/uio.h:3,
> > >                  from ./linux/../../../include/linux/vringh.h:15,
> > >                  from ./linux/vringh.h:1,
> > >                  from vringh_test.c:9:
> > > ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
> > >    10 | #include <linux/mm_types.h>
> > >       |          ^~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make: *** [<builtin>: vringh_test.o] Error 1
> > 
> > Which tree has this build failure? In mine linux/uio.h does not
> > include linux/mm_types.h.
> 
> Strictly it's
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/xen-evtchn-kernel
> but I'm sure my part isn't relevant; it's just v5.17-rc5.
> 
>  $ git blame include/linux/uio.h | grep mm_types.h
> d9c19d32d86fa (Matthew Wilcox (Oracle) 2021-10-18 10:39:06 -0400  10) #include <linux/mm_types.h>
>  $ git describe --tags d9c19d32d86fa
> v5.16-rc4-37-gd9c19d32d86f

grr.  Originally, I had this doing a typebusting cast, but hch objected,
so I had to include mm_types.h.  This should fix it ...

$ git diff
diff --git a/tools/virtio/linux/mm_types.h b/tools/virtio/linux/mm_types.h
new file mode 100644
index 000000000000..3b0fc9bc5b8f
--- /dev/null
+++ b/tools/virtio/linux/mm_types.h
@@ -0,0 +1,3 @@
+struct folio {
+       struct page page;
+};

At least, it makes it compile for me.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

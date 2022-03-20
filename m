Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774F5C433F5
	for <virtualization@archiver.kernel.org>; Sun, 20 Mar 2022 11:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13484813C5;
	Sun, 20 Mar 2022 11:04:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pYicvIa3V2d7; Sun, 20 Mar 2022 11:04:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 89B168129D;
	Sun, 20 Mar 2022 11:03:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67DFEC001A;
	Sun, 20 Mar 2022 11:03:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B090DC000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C6864091D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EIQLQGIvsTXD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:03:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B2044091C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647774234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFzoF0hHDOlcsVq7gujqkCRBLubjXsP/Roy3iuwOSII=;
 b=EibkjjX02ZQxEAtMP+rK4MtLB7avVhEpsUtBftQPlPJtE0hZkfkLecxrMfrqzmWAy0M8WV
 fEw2I+NIyPSJqqGqrT5ALX/zcLjAL4lISSmSLrfv6EQIHoFr5g3R9+f2Qr4QJP2ltJdirF
 WfhZYL7+QRRsoqsdReBS/pUL1dhG+Yg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-s1EAAMrjO-mNOSmOhtXgUg-1; Sun, 20 Mar 2022 07:03:51 -0400
X-MC-Unique: s1EAAMrjO-mNOSmOhtXgUg-1
Received: by mail-ed1-f69.google.com with SMTP id
 f2-20020a50d542000000b00418ed3d95d8so6674697edj.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 04:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hFzoF0hHDOlcsVq7gujqkCRBLubjXsP/Roy3iuwOSII=;
 b=1K1ekZTCOUxk/mh3vSmyuaE7CbNBp2XJP+jgCxDNdxa7w5RPfSYBL5xCVdkXqqTjQ1
 SZx00LTKodHPja4QYsgqR15L7sYvE1rsstPaszhYS1H0EN5kjUk2Lhyyd4JPJhhfasVT
 GCe9IiWFpjYsfXFGkgNKyDrClFz6FrU2iNbp9vQOedUuc8o9u9kGz3oeLxxWIIxyaOSm
 rYgmx7gBu6Ju5/khaVz2PUiEYeouS98v2xO36jhdn0q5hJO4o+Whya/aGkXx2mSqHtuU
 MrBB1CCiDdBkjmaMcqUgt7XsAUdCnn4i8mBigSNRU5MuiprF/Lo/ZlSKMqersCIpm30I
 pTfg==
X-Gm-Message-State: AOAM533xySQqLvZ46BiPlzlXJMQM4ZwM5rb8NmmfMsPbmtGjg4M+VQ0h
 Sb547R5i3pDAQLvZsYczMGvJdCkQPcOs0Rb9Bm7EOq7gJQ3sFPXvid1DZpkVle8DzA/jOIGfkYO
 6qXAlXocpe9JdtDJUNsjTsz6lCtqWTK2H11m+8BJRSA==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id
 f15-20020a50bf0f000000b00410c512cb6fmr18241297edk.262.1647774230356; 
 Sun, 20 Mar 2022 04:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjjAtm3/nvXUKsceBT8RN+aLhHOJTRyYxPZll7mzodeHfVLEMC07NKkUsLeu6jNKkhDa9glA==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id
 f15-20020a50bf0f000000b00410c512cb6fmr18241282edk.262.1647774230126; 
 Sun, 20 Mar 2022 04:03:50 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 q22-20020a170906771600b006cf8a37ebf5sm5743141ejm.103.2022.03.20.04.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Mar 2022 04:03:49 -0700 (PDT)
Date: Sun, 20 Mar 2022 07:03:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220320070309-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
 <YhVvOsI0+xVAKHdr@casper.infradead.org>
MIME-Version: 1.0
In-Reply-To: <YhVvOsI0+xVAKHdr@casper.infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Feb 22, 2022 at 11:18:18PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 07:58:33AM +0000, David Woodhouse wrote:
> > On Tue, 2022-02-22 at 01:31 -0500, Michael S. Tsirkin wrote:
> > > On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> > > > 
> > > > [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> > > > Detected virtual address range 0x1000-0x7ffffffff000
> > > > spurious wakeups: 0x0 started=0x100000 completed=0x100000
> > > > 
> > > > Although in some circumstances I also see a different build failure:
> > > > 
> > > > cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c
> 
> Trying to test this myself ...
> 
> $ cd tools/virtio/
> $ make
> ...
> cc -lpthread  virtio_test.o virtio_ring.o   -o virtio_test
> /usr/bin/ld: virtio_ring.o: in function `spin_lock':
> /home/willy/kernel/folio/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
> 
> So this is not the only problem here?

Could you let me know which system and gcc version have this problem, for inclusion
in the commit log?

> > > > In file included from ./linux/uio.h:3,
> > > >                  from ./linux/../../../include/linux/vringh.h:15,
> > > >                  from ./linux/vringh.h:1,
> > > >                  from vringh_test.c:9:
> > > > ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
> > > >    10 | #include <linux/mm_types.h>
> > > >       |          ^~~~~~~~~~~~~~~~~~
> > > > compilation terminated.
> > > > make: *** [<builtin>: vringh_test.o] Error 1
> > > 
> > > Which tree has this build failure? In mine linux/uio.h does not
> > > include linux/mm_types.h.
> > 
> > Strictly it's
> > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/xen-evtchn-kernel
> > but I'm sure my part isn't relevant; it's just v5.17-rc5.
> > 
> >  $ git blame include/linux/uio.h | grep mm_types.h
> > d9c19d32d86fa (Matthew Wilcox (Oracle) 2021-10-18 10:39:06 -0400  10) #include <linux/mm_types.h>
> >  $ git describe --tags d9c19d32d86fa
> > v5.16-rc4-37-gd9c19d32d86f
> 
> grr.  Originally, I had this doing a typebusting cast, but hch objected,
> so I had to include mm_types.h.  This should fix it ...
> 
> $ git diff
> diff --git a/tools/virtio/linux/mm_types.h b/tools/virtio/linux/mm_types.h
> new file mode 100644
> index 000000000000..3b0fc9bc5b8f
> --- /dev/null
> +++ b/tools/virtio/linux/mm_types.h
> @@ -0,0 +1,3 @@
> +struct folio {
> +       struct page page;
> +};
> 
> At least, it makes it compile for me.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7904DC433EF
	for <virtualization@archiver.kernel.org>; Fri, 25 Feb 2022 18:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BFF1740484;
	Fri, 25 Feb 2022 18:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDHKWC_ykKKq; Fri, 25 Feb 2022 18:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0EC7240323;
	Fri, 25 Feb 2022 18:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF276C0070;
	Fri, 25 Feb 2022 18:25:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D026C001A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 18:25:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68F02408EE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 18:25:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SjWoZaT8nJkC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 18:25:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0F1E408E6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645813520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wJUmzL6cjzVUtVOWwFY0p71jUm6NF80QB8+jDDkstEI=;
 b=enVKImUQJIbGRXupM7qEgK7DzQbjdHcRA3D/+lMh4R0rocNh+oivm6ZYSITFPRnQtT36Oy
 4CTuHNTadnfwxOM82+6adi7iYzF4ZabVWiCWMMYBe0l/XyjkUxDqRaBGFSc5rMe8SaL3rU
 xdti+Z/R4DkP3gY5EpjlLLS3wA3bkdo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-eP4f1Qx8N_eetSXiqQP5EA-1; Fri, 25 Feb 2022 13:25:17 -0500
X-MC-Unique: eP4f1Qx8N_eetSXiqQP5EA-1
Received: by mail-wr1-f70.google.com with SMTP id
 c5-20020adffb05000000b001edbbefe96dso1115251wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 10:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wJUmzL6cjzVUtVOWwFY0p71jUm6NF80QB8+jDDkstEI=;
 b=LSPvKOHPk7IvhwJfr39RDMWMsypMhp771XmeITjcEziDs7x32gg0ZLQtOK37UbttKT
 AeZPtBAyuwt9fb2N2COCmOcYsmDwNAagLzJlUzbaFqb2MZjOfPuHPu1rEOHgUc7olLHz
 uk6MpTgWZXf9xQM6JsF+Xz16cMAxSEg7TxcenKesJIQaRM8x/6sejnv20T9p/pUyik/C
 Tz5rlvOPmzhJ399pGRc7y+sl6MpZa+JRLUptese7MJf1IVkTs/amnMLQ4i8TIaGZzQbz
 kxrYvyfaD+S6ZFwqZjMexyjZuMfktFdQh0OVpJM76qap7EXNXmWzznfptWPjRkSI3PFu
 yslw==
X-Gm-Message-State: AOAM533dd5ww3L3ZIkYJHpfcPUfG9VuYjFnDVSGijb1jvd3cb2tIWHoZ
 aCSIneo3dNjJCKRmwMSTyx29ml+PrT8+0j9NT6hBu42xKLbAgWtuoiTLZCqCu8VuIgZXX3hS13O
 gyXJ+NtRcEpRN8424+Avb23Q/pSdDeeEqDmQjdogmLw==
X-Received: by 2002:a05:600c:3590:b0:34a:5f6:9e6 with SMTP id
 p16-20020a05600c359000b0034a05f609e6mr3862274wmq.182.1645813516074; 
 Fri, 25 Feb 2022 10:25:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDrC8FSsPSLgMPhm8mD/DAjo9CntPreULCTyAAKeyXsCdkoIz/+sBHnr1REDXKrhrLZbdWng==
X-Received: by 2002:a05:600c:3590:b0:34a:5f6:9e6 with SMTP id
 p16-20020a05600c359000b0034a05f609e6mr3862258wmq.182.1645813515794; 
 Fri, 25 Feb 2022 10:25:15 -0800 (PST)
Received: from redhat.com ([2.55.165.55]) by smtp.gmail.com with ESMTPSA id
 c14-20020a7bc84e000000b0038100c9a593sm8104653wml.45.2022.02.25.10.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 10:25:15 -0800 (PST)
Date: Fri, 25 Feb 2022 13:25:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220225132505-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
 <YhVvOsI0+xVAKHdr@casper.infradead.org>
 <Yhj6ap3uEl2xFE8G@casper.infradead.org>
MIME-Version: 1.0
In-Reply-To: <Yhj6ap3uEl2xFE8G@casper.infradead.org>
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

On Fri, Feb 25, 2022 at 03:48:58PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 22, 2022 at 11:18:18PM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 22, 2022 at 07:58:33AM +0000, David Woodhouse wrote:
> > > On Tue, 2022-02-22 at 01:31 -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> > > > > 
> > > > > [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> > > > > Detected virtual address range 0x1000-0x7ffffffff000
> > > > > spurious wakeups: 0x0 started=0x100000 completed=0x100000
> > > > > 
> > > > > Although in some circumstances I also see a different build failure:
> > > > > 
> > > > > cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c
> > 
> > Trying to test this myself ...
> > 
> > $ cd tools/virtio/
> > $ make
> > ...
> > cc -lpthread  virtio_test.o virtio_ring.o   -o virtio_test
> > /usr/bin/ld: virtio_ring.o: in function `spin_lock':
> > /home/willy/kernel/folio/tools/virtio/./linux/spinlock.h:16: undefined reference to `pthread_spin_lock'
> > 
> > So this is not the only problem here?
> > 
> > > > > In file included from ./linux/uio.h:3,
> > > > >                  from ./linux/../../../include/linux/vringh.h:15,
> > > > >                  from ./linux/vringh.h:1,
> > > > >                  from vringh_test.c:9:
> > > > > ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
> > > > >    10 | #include <linux/mm_types.h>
> > > > >       |          ^~~~~~~~~~~~~~~~~~
> > > > > compilation terminated.
> > > > > make: *** [<builtin>: vringh_test.o] Error 1
> > > > 
> > > > Which tree has this build failure? In mine linux/uio.h does not
> > > > include linux/mm_types.h.
> > > 
> > > Strictly it's
> > > https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/xen-evtchn-kernel
> > > but I'm sure my part isn't relevant; it's just v5.17-rc5.
> > > 
> > >  $ git blame include/linux/uio.h | grep mm_types.h
> > > d9c19d32d86fa (Matthew Wilcox (Oracle) 2021-10-18 10:39:06 -0400  10) #include <linux/mm_types.h>
> > >  $ git describe --tags d9c19d32d86fa
> > > v5.16-rc4-37-gd9c19d32d86f
> > 
> > grr.  Originally, I had this doing a typebusting cast, but hch objected,
> > so I had to include mm_types.h.  This should fix it ...
> 
> ping?  Just noticed this one crop up in a "list of problems".  Should
> I submit it myself?

Pls do.

> > $ git diff
> > diff --git a/tools/virtio/linux/mm_types.h b/tools/virtio/linux/mm_types.h
> > new file mode 100644
> > index 000000000000..3b0fc9bc5b8f
> > --- /dev/null
> > +++ b/tools/virtio/linux/mm_types.h
> > @@ -0,0 +1,3 @@
> > +struct folio {
> > +       struct page page;
> > +};
> > 
> > At least, it makes it compile for me.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

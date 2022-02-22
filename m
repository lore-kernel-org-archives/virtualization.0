Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6D2C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 06:32:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 308F860E5A;
	Tue, 22 Feb 2022 06:32:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VCFPAAFA8_6U; Tue, 22 Feb 2022 06:32:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1FCD60E8C;
	Tue, 22 Feb 2022 06:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 963DBC0021;
	Tue, 22 Feb 2022 06:32:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 882EFC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 06:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65EC840165
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 06:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BerSbOjXnbA6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 06:32:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D93A940145
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 06:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645511524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O/oig1Hr2Zgb+hiYEUeq6XCTE+b6757ivsb+f39hvIQ=;
 b=aDqqcD/E613e6kaiScyf/3SxOVuOMUOKOCf+AyF7LMzNV5QkAFTnjGeSPsMVYCPKF/NVY3
 Vr79Ymjd4UZS1lpD7BCwJgXQt9a76gILnH+QN1M/ZcXwUQswezbu6kY590wRUkpXhyxfzy
 ybTII02pYe56hqKVIx1nUMNO041sR70=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-C5Tx5XClNu-wC4boeYza2A-1; Tue, 22 Feb 2022 01:32:02 -0500
X-MC-Unique: C5Tx5XClNu-wC4boeYza2A-1
Received: by mail-wr1-f69.google.com with SMTP id
 t8-20020adfa2c8000000b001e8f6889404so6506770wra.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 22:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O/oig1Hr2Zgb+hiYEUeq6XCTE+b6757ivsb+f39hvIQ=;
 b=iis/GpZJVUYueoOtc8vlF8hK6oqoOwToVy6tUOAGdxC7pUup3W3hNoMeTtNv3XiZdP
 tkm8fexLmhoSIY83y7YSxYzkmzSjftIhUG6WWqXX0lxWopff4RDWAlug7KJ+/wyw9J4u
 02gZxNwehxbOE3GYVxKtOa7lqk3oIMpqmIRikSHD/8G0tYpTpjecEHx+kGygeY3bPKDF
 8UFK0luOyBwWXUyZsHDf8rCBVpzOemGEXix0dmlfyNAisyIY9paSeZ1d91ogn5kHzrST
 27Q5ykjiHI80Z06tZmiTGSRziOtwcIwtRQ3CZLvx8pz62bn+qcz/u+Y2BvXvvdBzHh+Z
 umeQ==
X-Gm-Message-State: AOAM5318ldEQi+Hz10Rkwp3mTLQDmr5wnvXJdmh53RAnvH0R9bW4hr8d
 xPtNhoFhVl/83jDnnUr2xv3hiW8cO0Peus9bfmCl+Nvincn4ye5Qvq2X/eZVQO6H5CyzS7T0MhL
 M2aRml/iqOEOJwdzgxNOs4p/p0OCwPgxK5lCUIo2kyQ==
X-Received: by 2002:a5d:53c4:0:b0:1e6:5b69:a25a with SMTP id
 a4-20020a5d53c4000000b001e65b69a25amr18421846wrw.341.1645511520893; 
 Mon, 21 Feb 2022 22:32:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYOJh4GkMGTE2m37wnxk7zYf2DWYlSZDrFaNNuT8tW+F1P7wnt9uGo2yUs52mYcbnryj1Uhg==
X-Received: by 2002:a5d:53c4:0:b0:1e6:5b69:a25a with SMTP id
 a4-20020a5d53c4000000b001e65b69a25amr18421834wrw.341.1645511520686; 
 Mon, 21 Feb 2022 22:32:00 -0800 (PST)
Received: from redhat.com ([2.55.129.240])
 by smtp.gmail.com with ESMTPSA id u7sm40984521wrm.15.2022.02.21.22.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Feb 2022 22:31:58 -0800 (PST)
Date: Tue, 22 Feb 2022 01:31:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220222013121-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
MIME-Version: 1.0
In-Reply-To: <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization <virtualization@lists.linux-foundation.org>,
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

On Mon, Feb 21, 2022 at 05:18:48PM +0000, David Woodhouse wrote:
> On Mon, 2022-02-21 at 18:02 +0100, Stefano Garzarella wrote:
> > On Mon, Feb 21, 2022 at 04:15:22PM +0000, David Woodhouse wrote:
> > > As things stand, an application which wants to use vhost with a trivial
> > > 1:1 mapping of its virtual address space is forced to jump through hoops
> > > to detect what the address range might be. The VHOST_SET_MEM_TABLE ioctl
> > > helpfully doesn't fail immediately; you only get a failure *later* when
> > > you attempt to set the backend, if the table *could* map to an address
> > > which is out of range, even if no out-of-range address is actually
> > > being referenced.
> > > 
> > > Since userspace is growing workarounds for this lovely kernel API, let's
> > > ensure that we have a regression test that does things basically the same
> > > way as 
> > > https://gitlab.com/openconnect/openconnect/-/commit/443edd9d8826
> > > 
> > > does.
> > > 
> > > This is untested as I can't actually get virtio_test to work at all; it
> > > just seems to deadlock on a spinlock. But it's getting the right answer
> > > for the virtio range on x86_64 at least.
> > 
> > I had a similar issue with virtio_test and this simple patch [1] should 
> > fix the deadlock.
> > 
> > [1] 
> > https://lore.kernel.org/lkml/20220118150631.167015-1-sgarzare@redhat.com/=
> 
> Thanks.
> 
> [dwoodhou@i7 virtio]$ sudo ~/virtio_test
> Detected virtual address range 0x1000-0x7ffffffff000
> spurious wakeups: 0x0 started=0x100000 completed=0x100000
> 
> Although in some circumstances I also see a different build failure:
> 
> cc -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h   -c -o vringh_test.o vringh_test.c
> In file included from ./linux/uio.h:3,
>                  from ./linux/../../../include/linux/vringh.h:15,
>                  from ./linux/vringh.h:1,
>                  from vringh_test.c:9:
> ./linux/../../../include/linux/uio.h:10:10: fatal error: linux/mm_types.h: No such file or directory
>    10 | #include <linux/mm_types.h>
>       |          ^~~~~~~~~~~~~~~~~~
> compilation terminated.
> make: *** [<builtin>: vringh_test.o] Error 1

Which tree has this build failure? In mine linux/uio.h does not
include linux/mm_types.h.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

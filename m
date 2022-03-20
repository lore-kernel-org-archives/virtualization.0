Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBF5C433EF
	for <virtualization@archiver.kernel.org>; Sun, 20 Mar 2022 11:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 100FF81ABB;
	Sun, 20 Mar 2022 11:01:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I1cq1gvwW5x5; Sun, 20 Mar 2022 11:01:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2018F81A8E;
	Sun, 20 Mar 2022 11:01:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8EC3C001A;
	Sun, 20 Mar 2022 11:01:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9927C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9293160BD0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSBeQlE7blR8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:01:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 606A660B0D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647774087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70n8djccLGvTwEN3SXJpGKJYJ4sRqN4FFre0FvejuPA=;
 b=CrDEOvOKjfi5klBEkUtWzdPDgp7SyHoF8Q5yimzZME5ek9CPBzBDCTMeWPRTmUSzq5NbnU
 AHnpN3l7yOaMn1nI5fGJrLWxmWI2oTCr9PXNnxXxF0mvn1uuNDjU9fKCCdq7WYWIfoFxcI
 rkgQW2/gYKwyIoWN8XmtiFSNBvZpWcE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-W_8eMLrhPkCtJDDjBwG7bw-1; Sun, 20 Mar 2022 07:01:24 -0400
X-MC-Unique: W_8eMLrhPkCtJDDjBwG7bw-1
Received: by mail-ej1-f72.google.com with SMTP id
 jl19-20020a17090775d300b006dff5abe965so561259ejc.18
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 04:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=70n8djccLGvTwEN3SXJpGKJYJ4sRqN4FFre0FvejuPA=;
 b=koVQnZ20wsvKnOqOODPt7oMjuPMgtA/2ZHW7jySCGV1/ywOL381vp6aqQOVOX/0DXV
 3bKJ7c+4NjOtsB8OA6RjG6uCYgdu+IRhmOpr4WJvx5fzAT1QXXdFVbrT8/TXZnWRgSW1
 bmX9EGHYI8b03LfCctxUWOaqBoTrdW1qnhNMf+nMnaCGrErOeKw6BlVa3MmtkgGgQ1En
 cm9dNP7B6A7o6y3YXdh+FwfgroMsstUQGK9EiMFG/KgWtqq3dEYOpSg5/rpy/1pUZYS1
 H2YluwplpBA401Hxtc8FGdRXwhf4JZDnxTTQ/+SzGtXNURnRH6P1BQJG0vhNbmTSMHtc
 pXSg==
X-Gm-Message-State: AOAM533fNf1sAW31S23dOqTbnie9BiB3XnOOz59+77ZZPjYk5kc+aYod
 FWFxLTk/d5jrom6HZi2xeYhjkhv677y/6ubgE1SOLC/2pfZsOy1c9fZ82Jd/Hluf0iTKDmFGwyT
 Y5g6Inh16/RgInAIgEy4SazCib+fPCiBn8FE1K7r76Q==
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id
 dt11-20020a170907728b00b006df8f3b28aemr15008463ejc.336.1647774083261; 
 Sun, 20 Mar 2022 04:01:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwy07Ub9HgPan/haxPXZAmsmftl771vhR4MLzcj9Pv2RUOJsuF09d0skyISjV6IqXosGrJIhQ==
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id
 dt11-20020a170907728b00b006df8f3b28aemr15008448ejc.336.1647774083039; 
 Sun, 20 Mar 2022 04:01:23 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 o7-20020a17090608c700b006cef23cf158sm5731563eje.175.2022.03.20.04.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Mar 2022 04:01:22 -0700 (PDT)
Date: Sun, 20 Mar 2022 07:01:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/virtio: Test virtual address range detection
Message-ID: <20220320065640-mutt-send-email-mst@kernel.org>
References: <c1895bcc240d413ff067f982b6e653996ace9887.camel@infradead.org>
 <20220221170217.5bq7nhr3pvchku5x@sgarzare-redhat>
 <75d5002ad505b476c81c0b92c0d624824e93d6ac.camel@infradead.org>
 <20220222013121-mutt-send-email-mst@kernel.org>
 <8e60951973cab3a3d27a3c7f18d866cdb804e663.camel@infradead.org>
 <YhVvOsI0+xVAKHdr@casper.infradead.org>
 <YjH3H9KvTFAayTPY@casper.infradead.org>
MIME-Version: 1.0
In-Reply-To: <YjH3H9KvTFAayTPY@casper.infradead.org>
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

On Wed, Mar 16, 2022 at 02:41:35PM +0000, Matthew Wilcox wrote:
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
> 
> FYI, this fixes it for me:
> 
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 0d7bbe49359d..83b6a522d0d2 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -5,7 +5,7 @@ virtio_test: virtio_ring.o virtio_test.o
>  vringh_test: vringh_test.o vringh.o virtio_ring.o
> 
>  CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h
> -LDFLAGS += -lpthread
> +LDFLAGS += -pthread
>  vpath %.c ../../drivers/virtio ../../drivers/vhost
>  mod:
>         ${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}

gcc documentation seems to say this is neeed in cflags too:

       -pthread
           Define additional macros required for using the POSIX threads library.  You should use this option consistently for both
           compilation and linking.  This option is supported on GNU/Linux targets, most other Unix derivatives, and also on x86
           Cygwin and MinGW targets.

right?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

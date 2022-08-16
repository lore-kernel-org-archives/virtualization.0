Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0454C2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7892C60D75;
	Tue, 16 Aug 2022 08:39:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7892C60D75
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M3TPUjxi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8YcJ4riIWAx; Tue, 16 Aug 2022 08:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19BE460E39;
	Tue, 16 Aug 2022 08:39:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19BE460E39
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7303C0033;
	Tue, 16 Aug 2022 08:39:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A976C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3594D60E39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:39:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3594D60E39
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SSPs-6urDjOI
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64B4860D75
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64B4860D75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660639178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pkmnzfq5Du4+IpC/SOB8b+jym/xpDFauilnCKRriXN0=;
 b=M3TPUjxi3cfFK9ns/q0Z9vhzlfFEjgmtotMSl3qKmWYvh0STFEBEWXw/qvnbRheDubNg7z
 saDzZ2ZsGhygiDQdfq8uSdz8ij1A0WO73MIOm8jbZFaus60CTUkTXvCqEQ0AonlMYRv6Jc
 lyJv42/CWbjxTAGYlJHF+8jd0ho+ESg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-t4aAAADZMSCkcDYM7NVKFw-1; Tue, 16 Aug 2022 04:39:35 -0400
X-MC-Unique: t4aAAADZMSCkcDYM7NVKFw-1
Received: by mail-wm1-f72.google.com with SMTP id
 f18-20020a05600c4e9200b003a5f81299caso1537508wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Pkmnzfq5Du4+IpC/SOB8b+jym/xpDFauilnCKRriXN0=;
 b=aN0SanJy49gp8pcls4lVkie8Bz3Sn1yvUjP4OEs6m3H9mCwRW8Ti0yhzjzJse9zcrv
 6S+0c8y8EAkM/BolPrP6flfgDUvv1JbSMxZNwiMZFsJ7vKwCoE/TgT8aGqO187Holfcb
 U0bFiV1lkd7maBhzbtrbAA3HX/ADQNUTdmNsOikh2ijKCQTpDfpfy8MOigZVfoBMQz75
 8r9sgXKhEl1vz2yOSncKqIFmdDpwXpKWJ4htdToYkBq8msWCWMeyvivoGkbRsgX1c3gv
 J/D62VSCmvOdvpmi/Nxn4yK2ifoM6qGX/gDJZEJY2yS81zrn8LTcYy3tnA+U2qgh2UFh
 0Nog==
X-Gm-Message-State: ACgBeo0AE4VtJ2l9NKBKQbJItdwOtQ7EvKerp6yOKd9l9lSlp6TI6oUp
 hkDDL7Anbbh6CI6pBszQacuSRB181EXYJzSy5WI2aYqZP9eMaG54lMb/JyoDFTuFcTqczB4BwrT
 kSz7Ca/MTiu8IKvFhdCWmWBZYz1kEvMoJo2pfXY/d3A==
X-Received: by 2002:a05:6000:1241:b0:21e:f1e1:2ca2 with SMTP id
 j1-20020a056000124100b0021ef1e12ca2mr10686801wrx.122.1660639173974; 
 Tue, 16 Aug 2022 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR62zLpA/rKoq4pMz52JoH1S7NGG9J5gC8GxUSXyXoNKxFLGqqhu5xZcI3GN1hjWZmYwtTm7sA==
X-Received: by 2002:a05:6000:1241:b0:21e:f1e1:2ca2 with SMTP id
 j1-20020a056000124100b0021ef1e12ca2mr10686793wrx.122.1660639173730; 
 Tue, 16 Aug 2022 01:39:33 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 n21-20020a05600c4f9500b003a5f3f5883dsm7255122wmq.17.2022.08.16.01.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 01:39:33 -0700 (PDT)
Date: Tue, 16 Aug 2022 04:39:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] vduse:  Remove include of rwlock.h
Message-ID: <20220816043636-mutt-send-email-mst@kernel.org>
References: <20220816074816.173227-1-bigeasy@linutronix.de>
 <20220816042557-mutt-send-email-mst@kernel.org>
 <YvtWdVtH4Y0MuG7k@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <YvtWdVtH4Y0MuG7k@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xie Yongji <xieyongji@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org
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

On Tue, Aug 16, 2022 at 10:33:57AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-08-16 04:26:59 [-0400], Michael S. Tsirkin wrote:
> > #ifndef __LINUX_SPINLOCK_H
> > # error "please don't include this file directly"
> > #endif
> > 
> > I wonder how does it build.
> 
> spinlock.h is included earlier by other means so this define is
> satisfied.
> 
> Sebastian

I see. In that case this ifndef is pointless isn't it?
We want something like:

>>>

rwlock: detect use outside of spinlock.h

current ifndef does not really prevent including rwlock.h
directly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 8f416c5e929e..c0ef596f340b 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_RWLOCK_H
 #define __LINUX_RWLOCK_H
 
-#ifndef __LINUX_SPINLOCK_H
+#ifndef __LINUX_INSIDE_SPINLOCK_H
 # error "please don't include this file directly"
 #endif
 
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c5174155d..3d456d71d235 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_SPINLOCK_H
 #define __LINUX_SPINLOCK_H
 
+#define __LINUX_INSIDE_SPINLOCK_H
+
 /*
  * include/linux/spinlock.h - generic spinlock/rwlock declarations
  *
@@ -492,4 +494,6 @@ int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 
 void free_bucket_spinlocks(spinlock_t *locks);
 
+#undef __LINUX_INSIDE_SPINLOCK_H
+
 #endif /* __LINUX_SPINLOCK_H */

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

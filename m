Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207BFC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91A3C81A6F;
	Tue, 16 Aug 2022 08:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91A3C81A6F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YkITrLj/;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=83P6WSCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r74_d6_cm1v2; Tue, 16 Aug 2022 08:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2905C8176D;
	Tue, 16 Aug 2022 08:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2905C8176D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE189C0033;
	Tue, 16 Aug 2022 08:34:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07C16C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0A3160E39
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0A3160E39
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=YkITrLj/; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=83P6WSCA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNdUATbAGQQc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:34:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D2F860D75
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D2F860D75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:34:00 +0000 (UTC)
Date: Tue, 16 Aug 2022 10:33:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1660638838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qb1htg8huN6WePvkV5kqZM1sZNSCFd3WQd9nTLSNS38=;
 b=YkITrLj/VYtsfLu6xIM760Eat7yPUEdGkHbblXb4OsQFrc+cnyUU1Kv/QxaBaGiFKbQe5k
 MIu6mXGjpFxBdlOtvq11SNYEFuq9nAr5jh0HLuabfwGNgrSs3O56aW0xDSrCYYwCrdY5lp
 6gchMCjw/1eMaDnwEjz54Y5qcOJTw3dKHmpJOqm9lCRNA46e3NOIM6RcGrBsTiSf3FZI55
 YdMn1Jvf4JOlNx1alS61k8FmzEvtFAngrNvjYnlxp5Vi3JVr0Aat3PG7gS9jwk6WALxmMj
 PcoELigBsIQz6ObY/VgDuAhRZWSNXVWo6d45arYyeBVKtDDAbxoO2U/gc820lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1660638838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qb1htg8huN6WePvkV5kqZM1sZNSCFd3WQd9nTLSNS38=;
 b=83P6WSCA7HRzZ2FungsZqEu1XZHUsW3Z4MdCsNEuQLO6g04XwlDSD8hI4ZwKWD81nYdJZt
 TsvwfiRs9d/48kAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vduse:  Remove include of rwlock.h
Message-ID: <YvtWdVtH4Y0MuG7k@linutronix.de>
References: <20220816074816.173227-1-bigeasy@linutronix.de>
 <20220816042557-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220816042557-mutt-send-email-mst@kernel.org>
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

On 2022-08-16 04:26:59 [-0400], Michael S. Tsirkin wrote:
> #ifndef __LINUX_SPINLOCK_H
> # error "please don't include this file directly"
> #endif
> 
> I wonder how does it build.

spinlock.h is included earlier by other means so this define is
satisfied.

Sebastian
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

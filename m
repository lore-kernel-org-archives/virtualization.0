Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1469C433EF
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 18:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41481402C5;
	Tue, 29 Mar 2022 18:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kHi5TPl_pyZL; Tue, 29 Mar 2022 18:14:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E42C401B1;
	Tue, 29 Mar 2022 18:14:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7075CC001D;
	Tue, 29 Mar 2022 18:14:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 660D6C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 18:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4443060B6C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 18:14:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="ZunERedB";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="aAtoPleL"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W5QWp-J-Rlsl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 18:14:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73F0660B6A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 18:14:02 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1648577638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K56BsfoBgMn9W+rnuLsv0bm5grEALntNroa6Yc82KdQ=;
 b=ZunERedBvlyrIkmrxBOXq+SFQ8oPAJgIiSTJSupnoMy84lsSq8+Y2ithnhrH89ev3RuYLd
 on4YdUn5/atLStXdp46m8hsxV++A3QYBwbS5ZZ1u/pUbMcaUe08ao8nRJKuZruOCClE7/b
 s3wNIGzjDFF9ojCSNct1rQQ4GYfogIrQPuQ4dD+1WHoiI4MPyxvIwZjPR0cx8CDhUnNIcP
 +wiD1x8SnNtfwssRGq9F2ST0x1KxfN+vEp9aJfdnG828YtchAykyspeoOMkiZx7eQ9y6gG
 SbrRF1hqYi8kGkBiMcG39wlAxjJcQvbi0bu0GOFo/KIWqucqNk3/UqFn3zcutQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1648577638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K56BsfoBgMn9W+rnuLsv0bm5grEALntNroa6Yc82KdQ=;
 b=aAtoPleLjBNdBeKI37H4sj56tIZfUR4WxK9DqSTju6swEfqZnVAHT4B/GXVkAxEykVGOB3
 gVyYaZS/2js+eTBg==
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re:
In-Reply-To: <20220329100859-mutt-send-email-mst@kernel.org>
References: <Yj1hkpyUqJE9sQ2p@redhat.com>
 <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org> <87fsn1f96e.ffs@tglx>
 <20220329100859-mutt-send-email-mst@kernel.org>
Date: Tue, 29 Mar 2022 20:13:57 +0200
Message-ID: <87v8vweie2.ffs@tglx>
MIME-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Keir Fraser <keirf@google.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Mar 29 2022 at 10:37, Michael S. Tsirkin wrote:
> On Tue, Mar 29, 2022 at 10:35:21AM +0200, Thomas Gleixner wrote:
> We are trying to fix the driver since at the moment it does not
> have the dev->ok flag at all.
>
> And I suspect virtio is not alone in that.
> So it would have been nice if there was a standard flag
> replacing the driver-specific dev->ok above, and ideally
> would also handle the case of an interrupt triggering
> too early by deferring the interrupt until the flag is set.
>
> And in fact, it does kind of exist: IRQF_NO_AUTOEN, and you would call
> enable_irq instead of dev->ok = true, except
> - it doesn't work with affinity managed IRQs
> - it does not work with shared IRQs
>
> So using dev->ok as you propose above seems better at this point.

Unless there is a big enough amount of drivers which could make use of a
generic mechanism for that.

>> If any driver does this in the wrong order, then the driver is
>> broken.
> 
> I agree, however:
> $ git grep synchronize_irq `git grep -l request_irq drivers/net/`|wc -l
> 113
> $ git grep -l request_irq drivers/net/|wc -l
> 397
>
> I suspect there are more drivers which in theory need the
> synchronize_irq dance but in practice do not execute it.

That really depends on when the driver requests the interrupt, when
it actually enables the interrupt in the device itself and how the
interrupt service routine works.

So just doing that grep dance does not tell much. You really have to do
a case by case analysis.

Thanks,

        tglx

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

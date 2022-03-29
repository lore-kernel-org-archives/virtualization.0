Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA689C433F5
	for <virtualization@archiver.kernel.org>; Tue, 29 Mar 2022 08:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EEF6417C2;
	Tue, 29 Mar 2022 08:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ttcQgecHFAM; Tue, 29 Mar 2022 08:35:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3D5A417BC;
	Tue, 29 Mar 2022 08:35:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93E16C002C;
	Tue, 29 Mar 2022 08:35:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A7E7C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 08:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D393417C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 08:35:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DXv4cIh83GV1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 08:35:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4343D417BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Mar 2022 08:35:26 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1648542922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxo2fANONHqaPhhHVOh0yDywiTjWcuYhsxdsXZUuyQc=;
 b=RStcuUQ735QvEvgn2gP9AapfqEBcHTu1/DqKNr5yru+C2lPrbU7b6ZlpJrZYw+cb2pk4+6
 nMaWjBzg4BrnqZtn3NtLo6Loaxlh3Rm6ODAZmD66KvnqwqDbzUmfJcA8yXZy6GnJikR7zx
 /RIT/57HJRUE7VufPGF3asvKSms60au634m5gN0olLRQ1KVzJFMzTqYLErSz647Akq2j08
 c6E5tK9MbNWaIRTnrp9q1Zzi4fBmFSbUNu5rC9z4PsvKvJZXcmT4zSHbwHTa8/cx9t+hWo
 Q/zWFyoHDs8GzU2Y2LuWGB7no7RIx77oKYN+KdJsAfVJ/wPDV0iIKZTkOfImmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1648542922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxo2fANONHqaPhhHVOh0yDywiTjWcuYhsxdsXZUuyQc=;
 b=jrfi9eIOoNRFIhbQjDceJgTfM2tvd35PV2BCmvdNn6rpaFI3gczf6bRiJsPo+vNhrCd0YM
 sXtUVGrgLpd8SgCQ==
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re:
In-Reply-To: <20220328062452-mutt-send-email-mst@kernel.org>
References: <Yj1hkpyUqJE9sQ2p@redhat.com>
 <CACGkMEunsuWhn+aB2dM7noU257M9JV6jDjkQXLyOA+GjEoz_iw@mail.gmail.com>
 <20220325050947-mutt-send-email-mst@kernel.org>
 <CACGkMEvioAVMmB+ab2xXB2YPECtwi1J55u8mRRk9-JAjFSZ8vg@mail.gmail.com>
 <20220325060659-mutt-send-email-mst@kernel.org>
 <CACGkMEu4mRfNbJXJtAFzhyd55fD7phUDKnVtYW0aqRnQmT_bYw@mail.gmail.com>
 <20220328015757-mutt-send-email-mst@kernel.org>
 <CACGkMEu+fax6YYwhfbc1yoSxv6o1FTQyrOheVTmUfqGvmbAEfA@mail.gmail.com>
 <20220328062452-mutt-send-email-mst@kernel.org>
Date: Tue, 29 Mar 2022 10:35:21 +0200
Message-ID: <87fsn1f96e.ffs@tglx>
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

On Mon, Mar 28 2022 at 06:40, Michael S. Tsirkin wrote:
> On Mon, Mar 28, 2022 at 02:18:22PM +0800, Jason Wang wrote:
>> > > So I think we might talk different issues:
>> > >
>> > > 1) Whether request_irq() commits the previous setups, I think the
>> > > answer is yes, since the spin_unlock of desc->lock (release) can
>> > > guarantee this though there seems no documentation around
>> > > request_irq() to say this.
>> > >
>> > > And I can see at least drivers/video/fbdev/omap2/omapfb/dss/dispc.c is
>> > > using smp_wmb() before the request_irq().

That's a complete bogus example especially as there is not a single
smp_rmb() which pairs with the smp_wmb().

>> > > And even if write is ordered we still need read to be ordered to be
>> > > paired with that.
>
> IMO it synchronizes with the CPU to which irq is
> delivered. Otherwise basically all drivers would be broken,
> wouldn't they be?
> I don't know whether it's correct on all platforms, but if not
> we need to fix request_irq.

There is nothing to fix:

request_irq()
   raw_spin_lock_irq(desc->lock);       // ACQUIRE
   ....
   raw_spin_unlock_irq(desc->lock);     // RELEASE

interrupt()
   raw_spin_lock(desc->lock);           // ACQUIRE
   set status to IN_PROGRESS
   raw_spin_unlock(desc->lock);         // RELEASE
   invoke handler()

So anything which the driver set up _before_ request_irq() is visible to
the interrupt handler. No?

>> What happens if an interrupt is raised in the middle like:
>> 
>> smp_store_release(dev->irq_soft_enabled, true)
>> IRQ handler
>> synchornize_irq()

This is bogus. The obvious order of things is:

    dev->ok = false;
    request_irq();

    moar_setup();
    synchronize_irq();  // ACQUIRE + RELEASE
    dev->ok = true;

The reverse operation on teardown:

    dev->ok = false;
    synchronize_irq();  // ACQUIRE + RELEASE

    teardown();

So in both cases a simple check in the handler is sufficient:

handler()
    if (!dev->ok)
    	return;

I'm not understanding what you folks are trying to "fix" here. If any
driver does this in the wrong order, then the driver is broken.

Sure, you can do the same with:

    dev->ok = false;
    request_irq();
    moar_setup();
    smp_wmb();
    dev->ok = true;

for the price of a smp_rmb() in the interrupt handler:

handler()
    if (!dev->ok)
    	return;
    smp_rmb();

but that's only working for the setup case correctly and not for
teardown.

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

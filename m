Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC638C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 06:41:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 645218266C;
	Wed, 13 Apr 2022 06:41:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gIbN_UAknKSQ; Wed, 13 Apr 2022 06:41:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3DB48267C;
	Wed, 13 Apr 2022 06:41:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAB51C0033;
	Wed, 13 Apr 2022 06:41:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3E74C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C07D740877
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wPbE-dk6hNuv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C088A40876
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649832105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/G4+V/2r9lJkom+e8pScX/b0FmMM9Qy+8u3OkZBVmQ=;
 b=dB7aGemGlEqs8PnHiYXpE9wcTREFRbzpZsb4rVJiWW5QT6lFkeKndEsmBUzYxKGPIEcfzi
 sHzaMg1rpjfgIp6flUW4+OBlWZlrdEtady37ceDxFuDwEwaiplNrX/FsNFdPDss9eGSNHB
 46Dpsx2fsDz0INeh9w80QTeNP2Kb4G8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-6cM1yx9tMj6dMc1NTxRJhg-1; Wed, 13 Apr 2022 02:41:41 -0400
X-MC-Unique: 6cM1yx9tMj6dMc1NTxRJhg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCC3385A5BE;
 Wed, 13 Apr 2022 06:41:40 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 902112166B4F;
 Wed, 13 Apr 2022 06:41:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <CACGkMEuUXAUK-8GnBWgij5TOSN0ct_gmxnDQEcovRmTLK6bv4w@mail.gmail.com>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com> <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com> <20220412020145.32e26e5a.pasic@linux.ibm.com>
 <87r1629rio.fsf@redhat.com>
 <CACGkMEuUXAUK-8GnBWgij5TOSN0ct_gmxnDQEcovRmTLK6bv4w@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Wed, 13 Apr 2022 08:41:25 +0200
Message-ID: <87o815a3je.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Apr 13 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Wed, Apr 13, 2022 at 12:49 AM Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Tue, Apr 12 2022, Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>> > On Mon, 11 Apr 2022 16:27:41 +0200
>> > Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> >> My main concern is that we would need to synchronize against a single
>> >> interrupt that covers all kinds of I/O interrupts, not just a single
>> >> device...
>> >>
>> >
>> > Could we synchronize on struct airq_info's lock member? If we were
>> > to grab all of these that might be involved...
>>
>> Hm, that could possibly narrow the sync down to a subset, which seems
>> better. For devices still using classic interrupts, per-device sync
>> would be easy.
>>
>> >
>> > AFAIU for the synchronize implementation we need a lock or a set of locks
>> > that contain all the possible vring_interrupt() calls with the queuues
>> > that belong to the given device as a critical section. That way, one
>> > has the acquire's and release's in place so that the vrign_interrupt()
>> > either guaranteed to finish before the change of driver_ready is
>> > guaranteed to be complete, or it is guaranteed to see the change.
>> >
>> > In any case, I guess we should first get clear on the first part. I.e.
>> > when do we want to allow host->guest notifications.
>>
>> Also, whether we just care about vring interrupts, or general device
>> interrupts (not sure if a config change interrupt may also trigger
>> things we do not want to trigger?)
>
> I think only vring interrupts, since the config interrupt hardening is
> done via 22b7050a024d7 ("virtio: defer config changed notifications")

Ah thanks, I even reviewed that one back then :)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

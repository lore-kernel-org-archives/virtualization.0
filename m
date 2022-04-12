Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF73C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Apr 2022 16:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 812F2610AB;
	Tue, 12 Apr 2022 16:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qnUCMinyOBk6; Tue, 12 Apr 2022 16:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C9CE610B4;
	Tue, 12 Apr 2022 16:49:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9C84C0033;
	Tue, 12 Apr 2022 16:49:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFAEBC002C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E75F640B2F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:49:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDHAFKca7uop
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:49:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A27EA40B1A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649782144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UaNDfDtZrF6G9nBA9RDO8xMUJdj8q1bYX1cCWIIUT/8=;
 b=S1OKSttfoqZGCIo4c0d3jVweEozTLaJzZvj0TYEhDdmGhNhRN7U76fFrZIBAesHXJH2sWr
 bjpHmdgEueaEBFECIVS/b+3pTAeOE7Nw7N/gWFzSqGx2dGp7lqUW/1ghoYeUJCRuF9zQLA
 mqg2iCDL5CI//Gxuwr9NozDo1TvNoSU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-0_C0awwMMxmhlkf01iFzdw-1; Tue, 12 Apr 2022 12:48:59 -0400
X-MC-Unique: 0_C0awwMMxmhlkf01iFzdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF6DA3C01B97;
 Tue, 12 Apr 2022 16:48:58 +0000 (UTC)
Received: from localhost (unknown [10.39.193.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEEA02024CD2;
 Tue, 12 Apr 2022 16:48:48 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <20220412020145.32e26e5a.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com> <20220408150307.24b6b99f.pasic@linux.ibm.com>
 <20220410034556-mutt-send-email-mst@kernel.org>
 <CACGkMEtarZb6g3ij5=+As17+d9jtdAqNa1EzSuTXc7Pq_som0Q@mail.gmail.com>
 <877d7vbspu.fsf@redhat.com> <20220412020145.32e26e5a.pasic@linux.ibm.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Tue, 12 Apr 2022 18:48:47 +0200
Message-ID: <87r1629rio.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
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

On Tue, Apr 12 2022, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 11 Apr 2022 16:27:41 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:

>> My main concern is that we would need to synchronize against a single
>> interrupt that covers all kinds of I/O interrupts, not just a single
>> device...
>> 
>
> Could we synchronize on struct airq_info's lock member? If we were
> to grab all of these that might be involved...

Hm, that could possibly narrow the sync down to a subset, which seems
better. For devices still using classic interrupts, per-device sync
would be easy.

>
> AFAIU for the synchronize implementation we need a lock or a set of locks
> that contain all the possible vring_interrupt() calls with the queuues
> that belong to the given device as a critical section. That way, one
> has the acquire's and release's in place so that the vrign_interrupt()
> either guaranteed to finish before the change of driver_ready is
> guaranteed to be complete, or it is guaranteed to see the change.
>
> In any case, I guess we should first get clear on the first part. I.e.
> when do we want to allow host->guest notifications.

Also, whether we just care about vring interrupts, or general device
interrupts (not sure if a config change interrupt may also trigger
things we do not want to trigger?)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

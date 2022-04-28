Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E379C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 07:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26EFD4027F;
	Thu, 28 Apr 2022 07:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19RbwwGvJeQ8; Thu, 28 Apr 2022 07:42:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BBBE340117;
	Thu, 28 Apr 2022 07:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CB86C0032;
	Thu, 28 Apr 2022 07:42:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A2CFC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4197E4171E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhlV9h6Wq78M
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:42:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 55053416D0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651131744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ma9q9NfHZgQzwDwsNAsEAp8GMR2Aw0rkaNjfoUxgzjA=;
 b=NzvX6pmV65iNRTnTh2asip7fbVnm2N8VfUyqIehQMpO0K3dkMOhd7cqejd0yR1Xk0vUu/h
 FuV6+yn3L2ONjfa1Qazhcc34Vurt1JtNF5ADut7gycwBrdYM4H5D7Skg2FeUuzY7A15xIb
 cUXvJTZBv0fyy0uVmPlN/ULeOKsh4yY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313-A4wupFJ8M4u7aoDXIuCY9w-1; Thu, 28 Apr 2022 03:42:19 -0400
X-MC-Unique: A4wupFJ8M4u7aoDXIuCY9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48213185A7BA;
 Thu, 28 Apr 2022 07:42:19 +0000 (UTC)
Received: from localhost (unknown [10.39.193.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF41341136EF;
 Thu, 28 Apr 2022 07:42:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
Organization: Red Hat GmbH
References: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <87o80n7soq.fsf@redhat.com>
 <20220426124243-mutt-send-email-mst@kernel.org>
 <87ilqu7u6w.fsf@redhat.com> <20220428044315.3945e660.pasic@linux.ibm.com>
 <CACGkMEudDf=XXhV2tV+xZ586AnDyrQEotGAiSQZ4k1CTAWHZJQ@mail.gmail.com>
 <20220428012156-mutt-send-email-mst@kernel.org>
 <CACGkMEsd+WHp=LN0BnnDKfzv+nbS2hjgVC-tdemZWuPTc60HBQ@mail.gmail.com>
 <20220428015318-mutt-send-email-mst@kernel.org>
 <CACGkMEutdd=9c-2h5ijMkgUzEqNPtUCXAum7bm8W7a6m62i_Mg@mail.gmail.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Thu, 28 Apr 2022 09:42:17 +0200
Message-ID: <87zgk5lkme.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Apr 28 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Apr 28, 2022 at 1:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Thu, Apr 28, 2022 at 01:51:59PM +0800, Jason Wang wrote:
>> > On Thu, Apr 28, 2022 at 1:24 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> > >
>> > > On Thu, Apr 28, 2022 at 11:04:41AM +0800, Jason Wang wrote:
>> > > > > But my guess is that rwlock + some testing for the legacy indicator case
>> > > > > just to double check if there is a heavy regression despite of our
>> > > > > expectations to see none should do the trick.
>> > > >
>> > > > I suggest this, rwlock (for not airq) seems better than spinlock, but
>> > > > at worst case it will cause cache line bouncing. But I wonder if it's
>> > > > noticeable (anyhow it has been used for airq).
>> > > >
>> > > > Thanks
>> > >
>> > > Which existing rwlock does airq use right now? Can we take it to sync?
>> >
>> > It's the rwlock in airq_info, it has already been used in this patch.
>> >
>> >                 write_lock(&info->lock);
>> >                 write_unlock(&info->lock);
>> >
>> > But the problem is, it looks to me there could be a case that airq is
>> > not used, (virtio_ccw_int_hander()). That's why the patch use a
>> > spinlock, it could be optimized with using a rwlock as well.
>> >
>> > Thanks
>>
>> Ah, right. So let's take that on the legacy path too and Halil promises
>> to test to make sure performance isn't impacted too badly?
>
> I think what you meant is using a dedicated rwlock instead of trying
> to reuse one of the airq_info locks.
>
> If this is true, it should be fine.

FWIW, that approach makes sense to me as well.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

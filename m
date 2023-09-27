Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6E8E810DA
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 12:12:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65FD340AD9;
	Wed, 27 Sep 2023 12:12:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65FD340AD9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyHjkfX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Nvd-F0HJbWl; Wed, 27 Sep 2023 12:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DAA2E4038B;
	Wed, 27 Sep 2023 12:12:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAA2E4038B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FCC1C0039;
	Wed, 27 Sep 2023 12:12:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90635C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 12:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6AC21830E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 12:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AC21830E3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cvyHjkfX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upnKdgaJIZzB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 12:12:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93CFE830E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 12:12:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93CFE830E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695816744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CxP1yuTUEp+02dovUMlVDBiyWThstH4vw04Sljh8/2M=;
 b=cvyHjkfXM9b40ora/vzCDOBDKeJsTUmw56Lup9DGe0rXJJ2mJ5Eovp7SP8y2H9gV/lNugm
 resUgF6Z83capRsQuWlvbc2dPj6vsAl7pMTn4+CWotjMbGWTo+AAnajPDs0S/w+Wkoiq88
 gttf7kCGDM2iUUjndTxbKJy2lHi/nz0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-ztKu2Z9SNPCpTK5kJ19O1w-1; Wed, 27 Sep 2023 08:12:21 -0400
X-MC-Unique: ztKu2Z9SNPCpTK5kJ19O1w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FDA5811E7B;
 Wed, 27 Sep 2023 12:12:21 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AFC44492B05;
 Wed, 27 Sep 2023 12:12:20 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
In-Reply-To: <20230927132536.4b19ab2f.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com> <877coc2aj8.fsf@redhat.com>
 <20230927132536.4b19ab2f.pasic@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 27 Sep 2023 14:12:19 +0200
Message-ID: <874jjf3jdo.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "pizhenwei@bytedance.com" <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Halil Pasic <pasic@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
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

On Wed, Sep 27 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 27 Sep 2023 12:08:43 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> > On the other hand virtio_airq_handler() calls vring_interrupt() with
>> > interrupts enabled. (While vring_interrupt() is called in a (read)
>> > critical section in virtio_airq_handler() we use read_lock() and
>> > not read_lock_irqsave() to grab the lock. Whether that is correct in
>> > it self (i.e. disregarding the crypto problem) or not I'm not sure right
>> > now. Will think some more about it tomorrow.) If the way to go forward
>> > is disabling interrupts in virtio-ccw before vring_interrupt() is
>> > called, I would be glad to spin a patch for that.  
>> 
>> virtio_airq_handler() is supposed to be an interrupt handler for an
>> adapter interrupt -- as such I would expect it to always run with
>> interrupts disabled (and I'd expect vring_interrupt() to be called
>> with interrupts disabled as well; if that's not the case, I think it
>> would need to run asynchronously.) At least that was my understanding at
>> the time I wrote the code.
>
> Thanks Connie! I don't quite understand what do you mean by "run with
> interrupts disabled" in this context.
>
> Do you mean that if I were to add the following warning:
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index ac67576301bf..2a9c73f5964f 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -211,6 +211,8 @@ static void virtio_airq_handler(struct airq_struct *airq,
>         struct airq_info *info = container_of(airq, struct airq_info, airq);
>         unsigned long ai;
>  
> +       WARN_ONCE(in_irq(), "irqs are ought to be disabled but are not\n");
> +
>         inc_irq_stat(IRQIO_VAI);
>
> it would/should never trigger, or do you mean something different?
>
> If yes, does that mean that you would expect the common airq code (i.e. something
> like do_airq_interrupt()) to disable interrupts, or call virtio_airq_handler()?
> asynchronously sort of as a bottom half (my understanding of bottom halves is currently
> not complete).
>
> If no what do you actually mean?

My understanding (at the time) was that we're coming from the low-level
interrupt handler (which disables interrupts via the NEW PSW);
interrupts will be re-enabled once the basic processing is done. This
might no longer be the case, but I currently don't have the time to dig
into the code -- it has been some time.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

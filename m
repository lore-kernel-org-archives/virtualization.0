Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C495FE810BB
	for <virtualization@archiver.kernel.org>; Wed, 27 Sep 2023 10:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 569FE82CCB;
	Wed, 27 Sep 2023 10:08:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 569FE82CCB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B8zn/OFC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mDzvE5q1I7aE; Wed, 27 Sep 2023 10:08:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D057282BD6;
	Wed, 27 Sep 2023 10:08:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D057282BD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD178C0039;
	Wed, 27 Sep 2023 10:08:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A36CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 10:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EF1D41471
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 10:08:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EF1D41471
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=B8zn/OFC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YVsg42oUrf4j
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 10:08:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB2DA400D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 10:08:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB2DA400D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695809330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iuruE1nulZgndw+cQHO0vj1TexCC3+sKU/XFHVoq3fQ=;
 b=B8zn/OFCnD4f9VFHijoQaa8YrJvYKrHaMGnjKEv4N/AHExXgQYMZKP4GGBjXXncmHrES3N
 nDCv9cb2tA+PeW53p9XEFBALOococjb3t1nAPorDkD7+rSuBgVmMIr+eu+GGxF1T+Aw6SS
 DPThkN591y1zP1CaXlFCAFBI2Ct0naU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-H03athJJOsSVs1ir8KZCwg-1; Wed, 27 Sep 2023 06:08:46 -0400
X-MC-Unique: H03athJJOsSVs1ir8KZCwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 761551C06E14;
 Wed, 27 Sep 2023 10:08:45 +0000 (UTC)
Received: from localhost (dhcp-192-239.str.redhat.com [10.33.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7773214026F7;
 Wed, 27 Sep 2023 10:08:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>
Subject: Re: [PATCH] crypto: virtio-crypto: call finalize with bh disabled
In-Reply-To: <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <1914739e2de14ed396e5674aa2d4766c@huawei.com>
 <20230926184158.4ca2c0c3.pasic@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 27 Sep 2023 12:08:43 +0200
Message-ID: <877coc2aj8.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Tue, Sep 26 2023, Halil Pasic <pasic@linux.ibm.com> wrote:

> [..]
>> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
>> @@ -61,8 +61,9 @@ static void virtio_crypto_akcipher_finalize_req(
>>  	vc_akcipher_req->src_buf = NULL;
>>  	vc_akcipher_req->dst_buf = NULL;
>>  	virtcrypto_clear_request(&vc_akcipher_req->base);
>> -
>> +	local_bh_disable();
>>  	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
>> +	local_bh_enable();
>
> Thanks Gonglei!
>
> I did this a quick spin, and it does not seem to be sufficient on s390x.
> Which does not come as a surprise to me, because 
>
> #define lockdep_assert_in_softirq()                                     \
> do {                                                                    \
>         WARN_ON_ONCE(__lockdep_enabled                  &&              \
>                      (!in_softirq() || in_irq() || in_nmi()));          \
> } while (0)
>
> will still warn because  in_irq() still evaluates to true (your patch
> addresses the !in_softirq() part).
>
> I don't have any results on x86 yet. My current understanding is that the
> virtio-pci transport code disables interrupts locally somewhere in the
> call chain (actually in vp_vring_interrupt() via spin_lock_irqsave())
> and then x86 would be fine. But I will get that verified.
>
> On the other hand virtio_airq_handler() calls vring_interrupt() with
> interrupts enabled. (While vring_interrupt() is called in a (read)
> critical section in virtio_airq_handler() we use read_lock() and
> not read_lock_irqsave() to grab the lock. Whether that is correct in
> it self (i.e. disregarding the crypto problem) or not I'm not sure right
> now. Will think some more about it tomorrow.) If the way to go forward
> is disabling interrupts in virtio-ccw before vring_interrupt() is
> called, I would be glad to spin a patch for that.

virtio_airq_handler() is supposed to be an interrupt handler for an
adapter interrupt -- as such I would expect it to always run with
interrupts disabled (and I'd expect vring_interrupt() to be called
with interrupts disabled as well; if that's not the case, I think it
would need to run asynchronously.) At least that was my understanding at
the time I wrote the code.

>
> Copying Conny, as she may have an opinion on this (if I'm not wrong she
> authored that code).
>
> Regards,
> Halil

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

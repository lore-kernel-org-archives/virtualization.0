Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E679C7EE23
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 16:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19C2F4026A;
	Tue, 30 May 2023 16:12:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19C2F4026A
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ci9AJsPS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uBbc3DZnw0NQ; Tue, 30 May 2023 16:12:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B344F40531;
	Tue, 30 May 2023 16:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B344F40531
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89502C0037;
	Tue, 30 May 2023 16:12:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07A39C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8CD283CC0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8CD283CC0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ci9AJsPS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uOc-Kpdn3GhG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:12:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0AF2681F5E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AF2681F5E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685463127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elhjqE3fNBnQQxlIlFk7OLjzO9acLMNW6reIgAraQ64=;
 b=Ci9AJsPSDojXpcUFoTmTZjG2Ib/e4BgRkO5MpMIEyeNBISIshYyH64tB6IXvot1MctM7wr
 dk4BXGRQSxR0dCosHXE6ShPk0xlm/3wD12OoSZSN2fQ5QOKE14FkIQ7GbzQQFMFoauD6Q5
 HvXSx9mXBJug2cwJAb1oVFbuhmAAwCQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-MMR7Oy_pOFGEijk_9M8CAA-1; Tue, 30 May 2023 12:12:03 -0400
X-MC-Unique: MMR7Oy_pOFGEijk_9M8CAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30af00323b0so798853f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 09:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685463122; x=1688055122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=elhjqE3fNBnQQxlIlFk7OLjzO9acLMNW6reIgAraQ64=;
 b=UWe81skagij95eYZ61Xlw/BJINZ8tFvpq5o2fc1GwDSEOir1ctqrZbHbgi13e4vFCn
 KT6GB96H0UWyVsVH4dHmdgZhJ9J4+QTio/3M1PwzdS3dumwhxvG8Mcjgn8lkJPKzLuvD
 R5tz83+tq3z1/xu2WP5DwPurm6ebVQR4BuMsfbbIMfJP6mJRisE2UNKrjfmHYxwemaOE
 ziKwYjJs6W8wbbbpKKosBv9UAWirMHvuTzNy5rl9t36HGWRz6iX2QGPoxjlx0VY1qfH4
 xl/YYiTqXhpGPEI/wJFc+mi+H+YMiCLi/Ua+6u+DwUAitxwiVSwOpqRs6h2d+iuB8NvN
 ZvhQ==
X-Gm-Message-State: AC+VfDznS4Haxry7w7yZSo9Olk9DdFnbfEsH4kp/p4OWo/jya1D+eva2
 iUBnUHXJG2zg8fYkGgr1ocHjlfAYEAVOc8lCWR8J0lkx/5Jd0G0e5gGeHZBCb2KUJAVCaLyycib
 oR4HfrCPhuHlwvZlmbDYzbXx2nzDR0D19XT9p8Dn7qw==
X-Received: by 2002:a5d:5909:0:b0:309:4e64:7a28 with SMTP id
 v9-20020a5d5909000000b003094e647a28mr2029562wrd.49.1685463122245; 
 Tue, 30 May 2023 09:12:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76yj+cHMYLKtEr2159YgsXI3xWTpZbjGYKy+isWK8mqhybl41e+higOqGxCzQ6/lC2tHLEZQ==
X-Received: by 2002:a5d:5909:0:b0:309:4e64:7a28 with SMTP id
 v9-20020a5d5909000000b003094e647a28mr2029549wrd.49.1685463121984; 
 Tue, 30 May 2023 09:12:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 l9-20020adfe589000000b00307c8d6b4a0sm3781887wrm.26.2023.05.30.09.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 09:12:01 -0700 (PDT)
Date: Tue, 30 May 2023 18:11:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Message-ID: <4opfq7hcowqwmz2hzpfcu3icx3z6ce4vmn6pkaeeqxnclgvjd6@x7lyji2owgae>
References: <0000000000001777f605fce42c5f@google.com>
 <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <85836a9b-b30a-bdb6-d058-1f7c17d8e48e@oracle.com>
 <c87f0768-027b-c192-1baf-05273aac382b@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c87f0768-027b-c192-1baf-05273aac382b@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, May 30, 2023 at 11:01:11AM -0500, Mike Christie wrote:
>On 5/30/23 10:58 AM, Mike Christie wrote:
>> On 5/30/23 8:44 AM, Stefano Garzarella wrote:
>>>
>>> From a first glance, it looks like an issue when we call vhost_work_queue().
>>> @Mike, does that ring any bells since you recently looked at that code?
>>
>> I see the bug. needed to have set the dev->worker after setting worker->vtsk

Yes, I came to the same conclusion (see my email sent at the same time
:-).

>> like below:
>>
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index a92af08e7864..7bd95984a501 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -564,7 +564,6 @@ static int vhost_worker_create(struct vhost_dev *dev)
>>  	if (!worker)
>>  		return -ENOMEM;
>>
>> -	dev->worker = worker;
>>  	worker->kcov_handle = kcov_common_handle();
>>  	init_llist_head(&worker->work_list);
>>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>> @@ -576,6 +575,7 @@ static int vhost_worker_create(struct vhost_dev *dev)
>>  	}
>>
>>  	worker->vtsk = vtsk;
>
>Shoot, oh wait, I think I needed a smp_wmb to always make sure worker->vtask
>is set before dev->worker or vhost_work_queue could still end up seeing
>dev->worker set before worker->vtsk right?

But should we pair smp_wmb() with an smp_rmb() wherever we check 
dev->worker?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

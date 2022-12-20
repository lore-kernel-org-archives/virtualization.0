Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F3FC4167B
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 08:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27EA1818D7;
	Tue, 20 Dec 2022 08:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27EA1818D7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDBoOFFf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Li5DLqbsUAI; Tue, 20 Dec 2022 08:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5D47081975;
	Tue, 20 Dec 2022 08:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D47081975
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E1FC0035;
	Tue, 20 Dec 2022 08:33:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACC40C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D57A4013C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:33:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D57A4013C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hDBoOFFf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SooX1z_CZDgP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:33:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4856940133
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4856940133
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671525203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bSjHn3a3hvKLyvcCrRE0qPqm28ju8MVOgmbyDKX+PI=;
 b=hDBoOFFfs5rLxo1VAsLUzSyN9EhoiR+Y6TmdXuZtQxHy6PyQylMR3y+gwKnKJatJadY9h0
 8WDvcbgF15fNbHkatVSuM2BEJaCvFdo2zOROKMVV3XM8jkQXr3+9CstKcXqr5vZdqBZuIN
 p3+fnFcUN3xNHNBzam6kk2+JbHs1AGU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-YDc4W7p0M_mMWltROgOf2Q-1; Tue, 20 Dec 2022 03:33:21 -0500
X-MC-Unique: YDc4W7p0M_mMWltROgOf2Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 ay40-20020a05622a22a800b003a978b3019cso4012013qtb.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 00:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bSjHn3a3hvKLyvcCrRE0qPqm28ju8MVOgmbyDKX+PI=;
 b=1p8520cZKqyjzHAy/O+Vye/5wA9ZRGUTHfadKDwcm5Ah90SfwYbM7V9iUNy4x6mZtM
 9tgg+AL57vcTVEJ0EvjOmXt5ff81TkxjLWZD3w3777C5eXh13lNtpCsNwgafDIgbv6hw
 ulg7UH+lqgOPfFtXvdvw3alvG769FavLc1AM+YMakcyDw5AW8U3Mczwm0mb9B7/872Pd
 7DHwfZz/2scRMdv4Uc0S7/XKj4WIbu/8PxaVXxnO0/Q3SbXYQ3rrPTbRNcSITHqxflSG
 KPWRl9E7Utu93rmWR0z7cVxLFpLVDkO8CIYuvJMK2bIssd+omBmaBl9oHNrr7rsfJc9V
 /P5Q==
X-Gm-Message-State: ANoB5pnR8KxgKr4Ujlw8XZe1DfyaEFauC8damwiREMV9iPyNONtmHnJ8
 IIhkKAJSSvgCpJ4LsSQQ1mXBGphsvV84lzigW6UtUSImWYacH3vTuXnuw3OHSRZxeiqN20+T/kH
 6A+DbI+AiTEw+QrPWwpkP1/St9pierU70JWOtrUcjng==
X-Received: by 2002:a05:622a:581b:b0:39c:da1f:f817 with SMTP id
 fg27-20020a05622a581b00b0039cda1ff817mr60895002qtb.61.1671525201406; 
 Tue, 20 Dec 2022 00:33:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ve/d+0DDMyGhpz1aVQZE7nDpZoLr+/LoGDbriBQXg8eTnb92+kKWzJtB2dHCjem4WX45Zdg==
X-Received: by 2002:a05:622a:581b:b0:39c:da1f:f817 with SMTP id
 fg27-20020a05622a581b00b0039cda1ff817mr60894981qtb.61.1671525201136; 
 Tue, 20 Dec 2022 00:33:21 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 fx11-20020a05622a4acb00b003a6934255dasm7445601qtb.46.2022.12.20.00.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 00:33:20 -0800 (PST)
Date: Tue, 20 Dec 2022 09:33:13 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/2] virtio/vsock: fix mutual rx/tx hungup
Message-ID: <20221220083313.mj2fd4tvfoifayaq@sgarzare-redhat>
References: <39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru>
 <CAGxU2F4ca5pxW3RX4wzsTx3KRBtxLK_rO9KxPgUtqcaSNsqXCA@mail.gmail.com>
 <2bc5a0c0-5fb7-9d0e-bd45-879e42c1ea50@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <2bc5a0c0-5fb7-9d0e-bd45-879e42c1ea50@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Dec 20, 2022 at 07:14:27AM +0000, Arseniy Krasnov wrote:
>On 19.12.2022 18:41, Stefano Garzarella wrote:
>
>Hello!
>
>> Hi Arseniy,
>>
>> On Sat, Dec 17, 2022 at 8:42 PM Arseniy Krasnov <AVKrasnov@sberdevices.ru> wrote:
>>>
>>> Hello,
>>>
>>> seems I found strange thing(may be a bug) where sender('tx' later) and
>>> receiver('rx' later) could stuck forever. Potential fix is in the first
>>> patch, second patch contains reproducer, based on vsock test suite.
>>> Reproducer is simple: tx just sends data to rx by 'write() syscall, rx
>>> dequeues it using 'read()' syscall and uses 'poll()' for waiting. I run
>>> server in host and client in guest.
>>>
>>> rx side params:
>>> 1) SO_VM_SOCKETS_BUFFER_SIZE is 256Kb(e.g. default).
>>> 2) SO_RCVLOWAT is 128Kb.
>>>
>>> What happens in the reproducer step by step:
>>>
>>
>> I put the values of the variables involved to facilitate understanding:
>>
>> RX: buf_alloc = 256 KB; fwd_cnt = 0; last_fwd_cnt = 0;
>>     free_space = buf_alloc - (fwd_cnt - last_fwd_cnt) = 256 KB
>>
>> The credit update is sent if
>> free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [64 KB]
>>
>>> 1) tx tries to send 256Kb + 1 byte (in a single 'write()')
>>> 2) tx sends 256Kb, data reaches rx (rx_bytes == 256Kb)
>>> 3) tx waits for space in 'write()' to send last 1 byte
>>> 4) rx does poll(), (rx_bytes >= rcvlowat) 256Kb >= 128Kb, POLLIN is set
>>> 5) rx reads 64Kb, credit update is not sent due to *
>>
>> RX: buf_alloc = 256 KB; fwd_cnt = 64 KB; last_fwd_cnt = 0;
>>     free_space = 192 KB
>>
>>> 6) rx does poll(), (rx_bytes >= rcvlowat) 192Kb >= 128Kb, POLLIN is set
>>> 7) rx reads 64Kb, credit update is not sent due to *
>>
>> RX: buf_alloc = 256 KB; fwd_cnt = 128 KB; last_fwd_cnt = 0;
>>     free_space = 128 KB
>>
>>> 8) rx does poll(), (rx_bytes >= rcvlowat) 128Kb >= 128Kb, POLLIN is set
>>> 9) rx reads 64Kb, credit update is not sent due to *
>>
>> Right, (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) is still false.
>>
>> RX: buf_alloc = 256 KB; fwd_cnt = 196 KB; last_fwd_cnt = 0;
>>     free_space = 64 KB
>>
>>> 10) rx does poll(), (rx_bytes < rcvlowat) 64Kb < 128Kb, rx waits in poll()
>>
>> I agree that the TX is stuck because we are not sending the credit
>> update, but also if RX sends the credit update at step 9, RX won't be
>> woken up at step 10, right?
>
>Yes, RX will sleep, but TX will wake up and as we inform TX how much
>free space we have, now there are two cases for TX:
>1) send "small" rest of data(e.g. without blocking again), leave 'write()'
>   and continue execution. RX still waits in 'poll()'. Later TX will
>   send enough data to wake up RX.
>2) send "big" rest of data - if rest is too big to leave 'write()' and TX
>   will wait again for the free space - it will be able to send enough data
>   to wake up RX as we compared 'rx_bytes' with rcvlowat value in RX.

Right, so I'd update the test to behave like this.
And I'd explain better the problem we are going to fix in the commit 
message.

>>
>>>
>>> * is optimization in 'virtio_transport_stream_do_dequeue()' which
>>>   sends OP_CREDIT_UPDATE only when we have not too much space -
>>>   less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>>>
>>> Now tx side waits for space inside write() and rx waits in poll() for
>>> 'rx_bytes' to reach SO_RCVLOWAT value. Both sides will wait forever. I
>>> think, possible fix is to send credit update not only when we have too
>>> small space, but also when number of bytes in receive queue is smaller
>>> than SO_RCVLOWAT thus not enough to wake up sleeping reader. I'm not
>>> sure about correctness of this idea, but anyway - I think that problem
>>> above exists. What do You think?
>>
>> I'm not sure, I have to think more about it, but if RX reads less 
>> than
>> SO_RCVLOWAT, I expect it's normal to get to a case of stuck.
>>
>> In this case we are only unstucking TX, but even if it sends that single
>> byte, RX is still stuck and not consuming it, so it was useless to wake
>> up TX if RX won't consume it anyway, right?
>
>1) I think it is not useless, because we inform(not just wake up) TX that
>there is free space at RX side - as i mentioned above.
>2) Anyway i think that this situation is a little bit strange: TX thinks that
>there is no free space at RX and waits for it, but there is free space at RX!
>At the same time, RX waits in poll() forever - it is ready to get new portion
>of data to return POLLIN, but TX "thinks" exactly opposite thing - RX is full
>of data. Of course, if there will be just stalls in TX data handling - it will
>be ok - just performance degradation, but TX stucks forever.

We did it to avoid a lot of credit update messages.
Anyway I think here the main point is why RX is setting SO_RCVLOWAT to 
128 KB and then reads only half of it?

So I think if the users set SO_RCVLOWAT to a value and then RX reads 
less then it, is expected to get stuck.

Anyway, since the change will not impact the default behaviour 
(SO_RCVLOWAT = 1) we can merge this patch, but IMHO we need to explain 
the case better and improve the test.

>
>>
>> If RX woke up (e.g. SO_RCVLOWAT = 64KB) and read the remaining 64KB,
>> then it would still send the credit update even without this patch and
>> TX will send the 1 byte.
>
>But how RX will wake up in this case? E.g. it calls poll() without timeout,
>connection is established, RX ignores signal

RX will wake up because SO_RCVLOWAT is 64KB and there are 64 KB in the 
buffer. Then RX will read it and send the credit update to TX because
free_space is 0.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

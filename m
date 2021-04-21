Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBE3C433ED
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:39:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E28E56143D
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28E56143D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 80C6140284;
	Wed, 21 Apr 2021 09:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a6k8li5GS5J4; Wed, 21 Apr 2021 09:39:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1FBCE40279;
	Wed, 21 Apr 2021 09:39:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9AF4C000F;
	Wed, 21 Apr 2021 09:39:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04B3DC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:39:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CFC9260861
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:38:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dAIhheYkctfe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:38:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB8ED6064F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618997937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gSlikRZsUWJsx7Rq6CkgW2e557egJiXRO6RyE7OIcao=;
 b=Qm38YQluwhJMAEdAtWBP/e6A9EGkhfPp0mE628pJJwV8QOCfLaALm23TH4FcxENBjwonY2
 Zvbz7Z95hhSq/qc7y76nDgob+mDyNfMY7igdcCSU+QUYUX4nE7Q/s/l1ivomyus5vv+h+D
 DFaH3x32dDGa7jVSbjH1x4DyIqf8GTI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-UJsyoisQPzCODlKpOGZtVg-1; Wed, 21 Apr 2021 05:38:56 -0400
X-MC-Unique: UJsyoisQPzCODlKpOGZtVg-1
Received: by mail-ed1-f69.google.com with SMTP id
 l7-20020aa7c3070000b029038502ffe9f2so8935723edq.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gSlikRZsUWJsx7Rq6CkgW2e557egJiXRO6RyE7OIcao=;
 b=QIg3FxMYX28IM3pmdvT/ytmFYLaH3JVVztRILxOm4IcMQ0A5jbmDBwgso4QYm2y4QA
 48yTC10jp3rf5NHjeF9weQpf3M82nQuppxyYbJvyh710/i9QCSgZHlY3WweVIjkFGwOA
 ESUj7kmw1XC61wk9BGFGfDb/oNSNMEhAubDnz9q1o8GuWFM0NwtT/wVmu9h8THMtxAeF
 zkT/BN/esbHTMG/Trc0Gn0MLyI3NMS0q3QPIUzyaYPTtOeY9xv5p1f8El3gkpenu+lS+
 lKPpuomaFDZFs81fuQabsC3TQfSD7Vmp7xqa7aczcyV5CtHkHk73QLdRRp0ySlAgbdAg
 6pAg==
X-Gm-Message-State: AOAM532KvtIr3VAAU0bUSA5E8KQd2TzMHfSGEl60hbxKOH5/PASIlbYZ
 xJymLBoNLYGK/HEcElI31BE3dDM/+4SSfCca92Rpxf0zZlPJLyOQrZApowNPQsZB1w4on3m52/2
 5nhfXNnC2kUWOcGEvHHH2JFhwcR6qAekbt1OI88lp4A==
X-Received: by 2002:a17:907:76c5:: with SMTP id
 kf5mr31320931ejc.526.1618997934984; 
 Wed, 21 Apr 2021 02:38:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIwbBRm7mr85h28m7cl7ow2IIb274l/KuCduv8M7TerEq2T8gyqF0loaor8I4gqRyLdgQpMw==
X-Received: by 2002:a17:907:76c5:: with SMTP id
 kf5mr31320915ejc.526.1618997934762; 
 Wed, 21 Apr 2021 02:38:54 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id g11sm2506664edw.37.2021.04.21.02.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 02:38:54 -0700 (PDT)
Date: Wed, 21 Apr 2021 11:38:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 19/19] af_vsock: serialize writes to shared socket
Message-ID: <20210421093851.36yazy5vp4uwimd6@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124739.3408031-1-arseny.krasnov@kaspersky.com>
 <7d433ed9-8d4c-707a-9149-ff0e65d7f943@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <7d433ed9-8d4c-707a-9149-ff0e65d7f943@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Wed, Apr 14, 2021 at 01:51:17PM +0300, Arseny Krasnov wrote:
>
>On 13.04.2021 15:47, Arseny Krasnov wrote:
>> This add logic, that serializes write access to single socket
>> by multiple threads. It is implemented be adding field with TID
>> of current writer. When writer tries to send something, it checks
>> that field is -1(free), else it sleep in the same way as waiting
>> for free space at peers' side.
>>
>> This implementation is PoC and not related to SEQPACKET close, so
>> i've placed it after whole patchset.
>>
>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>> ---
>>  include/net/af_vsock.h   |  1 +
>>  net/vmw_vsock/af_vsock.c | 10 +++++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>> index 53d3f33dbdbf..786df80b9fc3 100644
>> --- a/include/net/af_vsock.h
>> +++ b/include/net/af_vsock.h
>> @@ -69,6 +69,7 @@ struct vsock_sock {
>>  	u64 buffer_size;
>>  	u64 buffer_min_size;
>>  	u64 buffer_max_size;
>> +	pid_t tid_owner;
>>
>>  	/* Private to transport. */
>>  	void *trans;
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 54bee7e643f4..d00f8c07a9d3 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -1765,7 +1765,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>  		ssize_t written;
>>
>>  		add_wait_queue(sk_sleep(sk), &wait);
>> -		while (vsock_stream_has_space(vsk) == 0 &&
>> +		while ((vsock_stream_has_space(vsk) == 0 ||
>> +			(vsk->tid_owner != current->pid &&
>> +			 vsk->tid_owner != -1)) &&
>>  		       sk->sk_err == 0 &&
>>  		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
>>  		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
>> @@ -1796,6 +1798,8 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>  				goto out_err;
>>  			}
>>  		}
>> +
>> +		vsk->tid_owner = current->pid;
>>  		remove_wait_queue(sk_sleep(sk), &wait);
>>
>>  		/* These checks occur both as part of and after the loop
>> @@ -1852,7 +1856,10 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>>  			err = total_written;
>>  	}
>>  out:
>> +	vsk->tid_owner = -1;
>>  	release_sock(sk);
>> +	sk->sk_write_space(sk);
>> +
>>  	return err;
>>  }
>>
>> @@ -2199,6 +2206,7 @@ static int vsock_create(struct net *net, struct socket *sock,
>>  		return -ENOMEM;
>>
>>  	vsk = vsock_sk(sk);
>> +	vsk->tid_owner = -1;
>This must be moved to '__vsock_create()'

Okay, I'll review the next version.

In order to backport this fix to stable branches I think is better to 
move at the beginning of this series or even out as a separate patch.

Thanks,
Stefano

>>
>>  	if (sock->type == SOCK_DGRAM) {
>>  		ret = vsock_assign_transport(vsk, NULL);
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

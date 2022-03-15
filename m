Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FDCC433EF
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 11:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1A1B40255;
	Tue, 15 Mar 2022 11:49:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1g3b5aHp_fh; Tue, 15 Mar 2022 11:49:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 55E2F40308;
	Tue, 15 Mar 2022 11:49:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C123C0012;
	Tue, 15 Mar 2022 11:49:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29264C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:49:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E8B660F7D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:49:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k-FtHpBYFfYB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:49:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5281C60B71
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647344974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PterqoyvBh+msSA0i+V9VnnV0+IT1msM0OrO0D3B12Q=;
 b=MvH+of0RrqKqufDLcv/t9OLZEBi1wmrr1uMoDyBap4k0k191QGzParmsQmbxLZyO9Y8qeY
 8P6GmjL9b6wxkK+b128XMunsS9rgecO6/BoofOff3lgoSNrGWmn2BTKNN/TR2pmU5hQnQu
 rZc4tW7Q/enQk9xyeJQ3N0O+JWPrbyU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-S1d_khJ1N7GPiOUy6bq58w-1; Tue, 15 Mar 2022 07:49:33 -0400
X-MC-Unique: S1d_khJ1N7GPiOUy6bq58w-1
Received: by mail-qt1-f197.google.com with SMTP id
 k1-20020ac85fc1000000b002e1c5930386so7553050qta.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 04:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PterqoyvBh+msSA0i+V9VnnV0+IT1msM0OrO0D3B12Q=;
 b=FofRUNrWG2jiOmVszCCjqoe66zt6tcJ5XpRiVCQqFiua4pttkbRVAc9awp7lQ+h26N
 VVO+aRoo2TAbYv2NMOWIvBNSzqy3QwYqexJcJgf8N/SmgVMMct4JW2o6+wUCrKZRC0Jc
 4G3JEDXJyBMgR4W5PfFjg8Y7s+auHUfN+nF2nwFzobggPLDIR3fIhKbakoi3IZEpc0BW
 NckKDjwQiNTacqv+8GxfeilCWp3ZxWT7tmPZKS2hY4yici70hlwGTlNofpKWcBIjS9zu
 vbmlH+mTL877GGUxQRKjltFrQ2q5KarPbirbJwHBe+cq3ckp5zJqSWhy69eoStJI/3qs
 voRQ==
X-Gm-Message-State: AOAM530lp9w0NRHnB5s70b0/lLf//EyROyTZYu24UoHvOr8DV7SkhpEq
 J0QEkUBOFe8amO88wHvqW3hLkoXq3MfIYfxnYB1i8kLd0qVgoyCP0TubyAGF9ejzlaPQSR7AGbl
 Zh3huRxXxkvYZAvw13w0v+5m7qDuMb8lK3wJCyiGSCw==
X-Received: by 2002:a05:620a:284d:b0:5ff:320d:c0a5 with SMTP id
 h13-20020a05620a284d00b005ff320dc0a5mr17984064qkp.681.1647344972640; 
 Tue, 15 Mar 2022 04:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlVn8tnyxlBYGoPjGDSTQP/ITXgasxjqs34flNZkJRFrJ4Au6tkURG5Do6GTqcbi4TFZ7ZTQ==
X-Received: by 2002:a05:620a:284d:b0:5ff:320d:c0a5 with SMTP id
 h13-20020a05620a284d00b005ff320dc0a5mr17984052qkp.681.1647344972385; 
 Tue, 15 Mar 2022 04:49:32 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 s12-20020a05622a018c00b002e1cd88645dsm5305032qtw.74.2022.03.15.04.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 04:49:31 -0700 (PDT)
Date: Tue, 15 Mar 2022 12:49:24 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 3/3] af_vsock: SOCK_SEQPACKET broken buffer test
Message-ID: <20220315114924.er65xwzw6mg3zp6t@sgarzare-redhat>
References: <1bb5ce91-da53-7de9-49ba-f49f76f45512@sberdevices.ru>
 <bc309cf9-5bcf-b645-577f-8e5b0cf6f220@sberdevices.ru>
 <20220315083617.n33naazzf3se4ozo@sgarzare-redhat>
 <b452aeac-9628-5e37-e0e6-d33f8bb47b22@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b452aeac-9628-5e37-e0e6-d33f8bb47b22@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
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

On Tue, Mar 15, 2022 at 09:34:35AM +0000, Krasnov Arseniy Vladimirovich 
wrote:
>On 15.03.2022 11:36, Stefano Garzarella wrote:
>>
>> Is this the right behavior? If read() fails because the buffer is invalid, do we throw out the whole packet?
>>
>> I was expecting the packet not to be consumed, have you tried AF_UNIX, does it have the same behavior?
>
>I've just checked AF_UNIX implementation of SEQPACKET receive in net/unix/af_unix.c. So, if 'skb_copy_datagram_msg()'
>fails, it calls 'skb_free_datagram()'. I think this means that whole sk buff will be dropped, but anyway, i'll check
>this behaviour in practice. See '__unix_dgram_recvmsg()' in net/unix/af_unix.c.
>

Yep. you are right it seems to be discarded but I don't know that
code very well, so better to test as you said ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04525C43334
	for <virtualization@archiver.kernel.org>; Tue, 19 Jul 2022 12:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7654A60B86;
	Tue, 19 Jul 2022 12:59:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7654A60B86
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfMVkAVK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lv3SzF80eU1n; Tue, 19 Jul 2022 12:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AAA7260A9E;
	Tue, 19 Jul 2022 12:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAA7260A9E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AEEFC0033;
	Tue, 19 Jul 2022 12:59:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62EADC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CF4540C41
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3CF4540C41
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VfMVkAVK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sAV1iCsiPGT1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:59:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0080240C40
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0080240C40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658235552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GpFb8vkFvojqhTGDZMr57afoE9WFfoScp9OlFzV0WwU=;
 b=VfMVkAVKH0EWaOwWC/56hDRbF7ONnUozsgvkQ1byFzeI7/cOCelWnQvKA7jHpv7yjHmgsu
 6RBUFwsHSLeIwVhvlsz2wWI0457qqnsAdjTwEG7PHmcZhYlnt0jaeNfbnBHjizighwveJR
 RiVVvUdC/gWGUTwzrPkic/XsjNYjR50=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-cKNuF5pLMtqnIz85lMqLGQ-1; Tue, 19 Jul 2022 08:59:06 -0400
X-MC-Unique: cKNuF5pLMtqnIz85lMqLGQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 f1-20020ac84641000000b0031ecb35e4d1so10096928qto.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 05:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GpFb8vkFvojqhTGDZMr57afoE9WFfoScp9OlFzV0WwU=;
 b=py7aJ+7aJjS4nfnAm84OSb14xdMSu+IrfiCh/t8EN/HI6DdEZeF89pJ61Ci6D51L7m
 sv6Ucpinlq7vNufK+8ybGBPZnIZyeiwfThu+6r43eQ3H0hizXAM/Y75x4nfEIkGXkqN8
 ciA62S0mOQQ1kVsKqf59oIg2lesbp8Y65VVKM0MmxAvVCOOncMiLNgwA7ySnaWFFAcJc
 8J1NOqBwSmkLA+bH2nXGbkLGGGuqEm8OaO1el4bnXYoDpiIK62prscU+pb0T3tnxNV9J
 9Ol9AR4cOB1OxNU7m499EA4vrhW/4q2swXmij8q/RAomEv0cPOKSxxKTzbOp31j0I+Zz
 nYmw==
X-Gm-Message-State: AJIora+/OSCqtUKUGbPR1uS75pR8ezCApkOEPaEbXBzHABRzD7fZU9Zb
 oD2p3c9UmxZpB5rnH2+Dekg0Sj/51JJUBGQawJ6PWNagqxOU/9nwLRV7UlzA/5qE1GHN9daYODW
 /INhxUzvpGLZhv+7CO/DwUkjHKpKOtrhdAaIn5g1ULA==
X-Received: by 2002:a37:bb06:0:b0:6af:1396:733a with SMTP id
 l6-20020a37bb06000000b006af1396733amr20076309qkf.19.1658235545578; 
 Tue, 19 Jul 2022 05:59:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v3rTh6rpiRFqOJRQK0ZLJtgg3flVdhc61hiFQaT3lCYarTqS5U4ciXv6GiDuKhdb9qoBSiNg==
X-Received: by 2002:a37:bb06:0:b0:6af:1396:733a with SMTP id
 l6-20020a37bb06000000b006af1396733amr20076290qkf.19.1658235545356; 
 Tue, 19 Jul 2022 05:59:05 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 bk8-20020a05620a1a0800b006b5fe4c333fsm1422065qkb.85.2022.07.19.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 05:59:04 -0700 (PDT)
Date: Tue, 19 Jul 2022 14:58:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC PATCH v1 0/3] virtio/vsock: use SO_RCVLOWAT to set
 POLLIN/POLLRDNORM
Message-ID: <20220719125856.a6bfwrvy66gxxzqe@sgarzare-redhat>
References: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <c8de13b1-cbd8-e3e0-5728-f3c3648c69f7@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>
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

On Mon, Jul 18, 2022 at 08:12:52AM +0000, Arseniy Krasnov wrote:
>Hello,
>
>during my experiments with zerocopy receive, i found, that in some
>cases, poll() implementation violates POSIX: when socket has non-
>default SO_RCVLOWAT(e.g. not 1), poll() will always set POLLIN and
>POLLRDNORM bits in 'revents' even number of bytes available to read
>on socket is smaller than SO_RCVLOWAT value. In this case,user sees
>POLLIN flag and then tries to read data(for example using  'read()'
>call), but read call will be blocked, because  SO_RCVLOWAT logic is
>supported in dequeue loop in af_vsock.c. But the same time,  POSIX
>requires that:
>
>"POLLIN     Data other than high-priority data may be read without
>            blocking.
> POLLRDNORM Normal data may be read without blocking."
>
>See https://www.open-std.org/jtc1/sc22/open/n4217.pdf, page 293.
>
>So, we have, that poll() syscall returns POLLIN, but read call will
>be blocked.
>
>Also in man page socket(7) i found that:
>
>"Since Linux 2.6.28, select(2), poll(2), and epoll(7) indicate a
>socket as readable only if at least SO_RCVLOWAT bytes are available."
>
>I checked TCP callback for poll()(net/ipv4/tcp.c, tcp_poll()), it
>uses SO_RCVLOWAT value to set POLLIN bit, also i've tested TCP with
>this case for TCP socket, it works as POSIX required.

I tried to look at the code and it seems that only TCP complies with it 
or am I wrong?

>
>I've added some fixes to af_vsock.c and virtio_transport_common.c,
>test is also implemented.
>
>What do You think guys?

Nice, thanks for fixing this and for the test!

I left some comments, but I think the series is fine if we will support 
it in all transports.

I'd just like to understand if it's just TCP complying with it or I'm 
missing some check included in the socket layer that we could reuse.

@David, @Jakub, @Paolo, any advice?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

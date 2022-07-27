Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20A4C04A68
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 12:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6D25C40518;
	Wed, 27 Jul 2022 12:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6D25C40518
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGxYMQQz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BHqGfQQRpfEc; Wed, 27 Jul 2022 12:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9261A40165;
	Wed, 27 Jul 2022 12:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9261A40165
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48067C0033;
	Wed, 27 Jul 2022 12:37:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F18D1C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B49C1823DD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B49C1823DD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KGxYMQQz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYgJh6giJS59
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:37:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E96C819ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E96C819ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658925440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4LWH5gfewkP2m9y0QehAONnCxfwoC2hdUW6P/cyixj4=;
 b=KGxYMQQz5eSin7cNmWyCMiEZAiKL38MkIN2ZsE2lpFxs/NFOCyHYIJTYs6GGe7c3t49Re2
 9L4msp1aNDLgNbnLmm+T/zXXXfAD9Jc6ewebTS6v5Y5Q1Mxj4mxnao7DTnb3/0XdJefE9K
 WWV4bTvxIWcTuKw4ppfZHJlzIoY8Hfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-aERfNnpGPGqJeiKiHLF6Dg-1; Wed, 27 Jul 2022 08:37:17 -0400
X-MC-Unique: aERfNnpGPGqJeiKiHLF6Dg-1
Received: by mail-wr1-f69.google.com with SMTP id
 c7-20020adfc6c7000000b0021db3d6961bso2809727wrh.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 05:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4LWH5gfewkP2m9y0QehAONnCxfwoC2hdUW6P/cyixj4=;
 b=lQfs6AJsP9i7+1uOxjVwaKJY2KLZa2nw7DrDPb5ErIhKEHADMyVTRVVYxpmLu34hor
 jdKUIHwu2XWWKU0ozpyCqaDKsQn+TvpVWkAR8s8+7+clsSpuyzmTAcqf++C/VuuUNdG3
 DSmUlJh0wnUJINzu0CMVk56CJGIw5CRRbTK2RnjuWN6As+ajtNmRsQktNc+4NqPjzJbk
 MBT0viEetYtO70DUNb8SRjYfAiiQIOlD3lMvdPge7x17nrtlz5K7YkkU7nDEl4RmnhQV
 gtdLbVnAMgfJixDO2AzOsti5vDqJcqDTB5w48gewnT/pQ5kj2F1/RzRpTEYWpEWwoDjV
 jofA==
X-Gm-Message-State: AJIora9Tpcxcn0zxSJGEo6uDT3J6rpS2ogdau7jqevhXK4rs7+sEgCgC
 svGQUVRohAyuyDRBxbY92SS7CgQulHYbAqwcl7nYy7+WuXv8aU4xlUZ+j8qTk4bLHc/9M8fZbvN
 J0tdip9+oD4UyvUVGGZGa2Ikvx/wQPULuOhcv/dgJww==
X-Received: by 2002:adf:d1e8:0:b0:21d:ac9c:983d with SMTP id
 g8-20020adfd1e8000000b0021dac9c983dmr13770277wrd.629.1658925436043; 
 Wed, 27 Jul 2022 05:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vJrWqBiaq6uBMB03xiUMkRFhOPCI0fFvUqiEuTuZWyTbuHIhoAAyTdDFMM07jJhUESZdjGNg==
X-Received: by 2002:adf:d1e8:0:b0:21d:ac9c:983d with SMTP id
 g8-20020adfd1e8000000b0021dac9c983dmr13770264wrd.629.1658925435819; 
 Wed, 27 Jul 2022 05:37:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u9-20020adff889000000b0020fcaba73bcsm16755266wrp.104.2022.07.27.05.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Jul 2022 05:37:15 -0700 (PDT)
Date: Wed, 27 Jul 2022 14:37:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Subject: Re: [RFC PATCH v2 0/9] vsock: updates for SO_RCVLOWAT handling
Message-ID: <20220727123710.pwzy6ag3gavotxda@sgarzare-redhat>
References: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <19e25833-5f5c-f9b9-ac0f-1945ea17638d@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Arseniy,

On Mon, Jul 25, 2022 at 07:54:05AM +0000, Arseniy Krasnov wrote:
>Hello,
>
>This patchset includes some updates for SO_RCVLOWAT:
>
>1) af_vsock:
>   During my experiments with zerocopy receive, i found, that in some
>   cases, poll() implementation violates POSIX: when socket has non-
>   default SO_RCVLOWAT(e.g. not 1), poll() will always set POLLIN and
>   POLLRDNORM bits in 'revents' even number of bytes available to read
>   on socket is smaller than SO_RCVLOWAT value. In this case,user sees
>   POLLIN flag and then tries to read data(for example using  'read()'
>   call), but read call will be blocked, because  SO_RCVLOWAT logic is
>   supported in dequeue loop in af_vsock.c. But the same time,  POSIX
>   requires that:
>
>   "POLLIN     Data other than high-priority data may be read without
>               blocking.
>    POLLRDNORM Normal data may be read without blocking."
>
>   See https://www.open-std.org/jtc1/sc22/open/n4217.pdf, page 293.
>
>   So, we have, that poll() syscall returns POLLIN, but read call will
>   be blocked.
>
>   Also in man page socket(7) i found that:
>
>   "Since Linux 2.6.28, select(2), poll(2), and epoll(7) indicate a
>   socket as readable only if at least SO_RCVLOWAT bytes are available."
>
>   I checked TCP callback for poll()(net/ipv4/tcp.c, tcp_poll()), it
>   uses SO_RCVLOWAT value to set POLLIN bit, also i've tested TCP with
>   this case for TCP socket, it works as POSIX required.
>
>   I've added some fixes to af_vsock.c and virtio_transport_common.c,
>   test is also implemented.
>
>2) virtio/vsock:
>   It adds some optimization to wake ups, when new data arrived. Now,
>   SO_RCVLOWAT is considered before wake up sleepers who wait new data.
>   There is no sense, to kick waiter, when number of available bytes
>   in socket's queue < SO_RCVLOWAT, because if we wake up reader in
>   this case, it will wait for SO_RCVLOWAT data anyway during dequeue,
>   or in poll() case, POLLIN/POLLRDNORM bits won't be set, so such
>   exit from poll() will be "spurious". This logic is also used in TCP
>   sockets.

Nice, it looks good!

>
>3) vmci/vsock:
>   Same as 2), but i'm not sure about this changes. Will be very good,
>   to get comments from someone who knows this code.

I CCed VMCI maintainers to the patch and also to this cover, maybe =

better to keep them in the loop for next versions.

(Jorgen's and Rajesh's emails bounced back, so I'm CCing here only =

Bryan, Vishnu, and pv-drivers@vmware.com)

>
>4) Hyper-V:
>   As Dexuan Cui mentioned, for Hyper-V transport it is difficult to
>   support SO_RCVLOWAT, so he suggested to disable this feature for
>   Hyper-V.

I left a couple of comments in some patches, but it seems to me to be in =

a good state :-)

I would just suggest a bit of a re-organization of the series (the =

patches are fine, just the order):
   - introduce vsock_set_rcvlowat()
   - disabling it for hv_sock
   - use 'target' in virtio transports
   - use 'target' in vmci transports
   - use sock_rcvlowat in vsock_poll()
    =A0I think is better to pass sock_rcvlowat() as 'target' when the
     transports are already able to use it
   - add vsock_data_ready()
   - use vsock_data_ready() in virtio transports
   - use vsock_data_ready() in vmci transports
   - tests

What do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

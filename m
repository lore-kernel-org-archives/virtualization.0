Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECC3C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:46:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD9361458
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 08:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD9361458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 708246069A;
	Thu, 22 Apr 2021 08:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yVxP49JCODFp; Thu, 22 Apr 2021 08:46:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12DC26068D;
	Thu, 22 Apr 2021 08:46:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5E62C000F;
	Thu, 22 Apr 2021 08:46:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70BD4C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 556C56069A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:46:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GEAFkMwSTWJe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:46:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B9816068D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619081212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=igvzL5hliAA2FzGw5dEDKa40CGCMUv5IZGyJe8BTj8Q=;
 b=KlkhHnYRrmUvNSXOWVP7q+FU5f4ide9IikV/wyK3Dx59F/9rRrGoF7MtnWRa8zopWHmC2N
 OEFMaL5ABxpnTg1vw9Dq02U89SZ/b60MHLIBTCv3g0gnS6gtd8b9PaerJXZdOC9+/gIrPk
 mLk+OltQCHLxELs7X4BisKJq5X9yJ+o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-61wzQWWbNgipasFzN3TxvQ-1; Thu, 22 Apr 2021 04:46:42 -0400
X-MC-Unique: 61wzQWWbNgipasFzN3TxvQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 d16-20020a1709066410b0290373cd3ce7e6so6921565ejm.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 01:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=igvzL5hliAA2FzGw5dEDKa40CGCMUv5IZGyJe8BTj8Q=;
 b=PKRpxaYrd8ZRO1m2KcxI9rKocCfYdE5BrxgmD74aWNYekhN/AwC1dig9dfg3Y2voxQ
 GBb7RT0Jr5RBP4V8Kqfpp+Tmo5JXs9f3CglN2g3vUwjTms7So7LNpzGVRnumNVKV48J9
 CrYY8luVpwEb93vrTs7Ffz4Q4elTfbZH4YjWKgGnLI1sOe8MJLvhgZ7cZLIz7nmo9b8W
 8PWqdBA2AC/4m6iU/gnVDj0Rn9TB+SwoGUdOV0UtNkYJA6ez25WqEzRFcxIzuNlL7GfW
 9h3OS1VQd1U3duphax6a9vSvjSg+xddu6HQ9auE9XRCpLsj08Qp2RDnjbx84lmfca8Im
 xCDQ==
X-Gm-Message-State: AOAM533XNrzHM1cF0aJEnbJKHahSjaPhr9E3e0A4ihqK8SUyrim0u+YA
 Jtg9MDDGauwmXwn8swreH1Aabwkr5bNDjJRJpTHtIvTtZyiruZJW/+nwkQGM+E+wxRyeE7R5crA
 I7qpEJkBQwknMtQNPBPQVWl2ItSVyQbI+xLLS3zj9aQ==
X-Received: by 2002:a05:6402:1a52:: with SMTP id
 bf18mr2410634edb.289.1619081201234; 
 Thu, 22 Apr 2021 01:46:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMOmZX/WNU70MrtatibX4Wtl/+Aav9csAem9coMeZKqvTUqG/etSg6TxT6HkUvxXRS4imtXQ==
X-Received: by 2002:a05:6402:1a52:: with SMTP id
 bf18mr2410622edb.289.1619081201063; 
 Thu, 22 Apr 2021 01:46:41 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id q25sm1506681edt.51.2021.04.22.01.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 01:46:40 -0700 (PDT)
Date: Thu, 22 Apr 2021 10:46:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210422084638.bvblk33b4oi6cec6@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210421095213.25hnfi2th7gzyzt2@steredhat>
 <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
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

On Wed, Apr 21, 2021 at 06:06:28PM +0300, Arseny Krasnov wrote:
>On 21.04.2021 12:52, Stefano Garzarella wrote:
>> On Tue, Apr 13, 2021 at 03:39:51PM +0300, Arseny Krasnov wrote:
>>> v7 -> v8:
>>> General changelog:
>>> - whole idea is simplified: channel now considered reliable,
>>>   so SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id' were removed.
>>>   Only thing that is used to mark end of message is bit in
>>>   'flags' field of packet header: VIRTIO_VSOCK_SEQ_EOR. Packet
>>>   with such bit set to 1 means, that this is last packet of
>>>   message.
>>>
>>> - POSIX MSG_EOR support is removed, as there is no exact
>>>   description how it works.
>> It would be nice to support it, I'll try to see if I can find anything.
>>
>> I just reviewed the series. I think the most important things to fix are
>> the `seqpacket_allow` stored in the struct virtio_transport that is
>> wrong IMHO, and use cpu_to_le32()/le32_to_cpu() to access the flags.
>
>Thank You, i'll prepare next version. Main question is: does this
>approach(no SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id') considered
>good? In this case it will be easier to prepare final version, because 
>is smaller and more simple than previous logic. Also patch to spec
>will be smaller.

Yes, it's definitely much better than before.

The only problem I see is that we add some overhead per fragment 
(header). We could solve that with the mergeable buffers that Jiang is 
considering for DGRAM.

If we have that support, I think we could reuse it here as well, but it 
might be a next step.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

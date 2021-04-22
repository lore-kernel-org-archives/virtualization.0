Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47885C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 10:02:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CC561131
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 10:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CC561131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 425D483C39;
	Thu, 22 Apr 2021 10:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJqq7fxaHolc; Thu, 22 Apr 2021 10:02:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id F10DF83C46;
	Thu, 22 Apr 2021 10:02:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6A3DC000E;
	Thu, 22 Apr 2021 10:02:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5CC1C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:02:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0A6160707
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:02:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PDIH2awV1Pe5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:02:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40F62606F7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619085743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xNNORhYicU7gfoyOCuO0kweWS4Sw8ld/VVblR3G06wg=;
 b=I9ey2zfVBWm3BB757mk6lRuhG3v29ceLOQYBkD+Iqwn1FtR3zbCMey56snYEit6v50+lpB
 2CV4xS7RgJ07oIaHQmfi7cEC2tBEwWZDDu7itIW0kgnYDgnEddA2jnTQ2aUxmNqAYLjVYS
 OObXLohuekT6FnXURXkx386w/CPb4GM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-DtsW95h0OfO9ltaP_zzBOw-1; Thu, 22 Apr 2021 06:02:21 -0400
X-MC-Unique: DtsW95h0OfO9ltaP_zzBOw-1
Received: by mail-ed1-f72.google.com with SMTP id
 d2-20020aa7d6820000b0290384ee872881so12361691edr.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 03:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xNNORhYicU7gfoyOCuO0kweWS4Sw8ld/VVblR3G06wg=;
 b=RQ+Y07AKHX5xXImRfZaZs44OcFmzRzmTkuR9O5wCR5qrnLglk3etJfGTxFFw9AokQ7
 8EuyCPaxPUqvd4aIIqfsucDZQXeig6rDgVdWaCZENd6DrkW6g3Dbh4Vg3+a1XrynVguL
 gkEGTqPNGnwGWiN7p3UtAENFPIZgdZJGqG+aq+e4taq/My/wejt6JtULVBw3AcE5bCt2
 p1XgBpuIBdxRP/xQofak/Zb33WCA3RA3BZqaDlGMBQx1jH2dFr4gz4/Lw1lQ/5zaKFRt
 AaMKpTmNTB2kKnJ814QFZCxjsDrCQChWhyoEfvGLZW/gtYOMrmvwmyBYQzl6z4eWcsU2
 WdcA==
X-Gm-Message-State: AOAM5316CKXjPaY/Ah7SD9RRzAa2jiQi2Tbr3zaeyC6CNobyyaOT8V9A
 N9gcQ8E88EhOhWQA7GnOS/+GVRigCppDx6O8m6HVU9D/F9OUSJSlOipHFwyf2oiLVBSQCCgGXfX
 4w9LpvNov1ZfI088+GVSVdpaugS/b0cZH5e52beoAVA==
X-Received: by 2002:a17:906:704a:: with SMTP id
 r10mr2573004ejj.312.1619085740317; 
 Thu, 22 Apr 2021 03:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoHUf/42/0fX52T0AvMJggbGbBnbTG84Gu4+wvT51LpZ70eW/cmD2f8ZCtTt0nyd7+UiYVVg==
X-Received: by 2002:a17:906:704a:: with SMTP id
 r10mr2572977ejj.312.1619085740170; 
 Thu, 22 Apr 2021 03:02:20 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id l15sm1662876edb.48.2021.04.22.03.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 03:02:19 -0700 (PDT)
Date: Thu, 22 Apr 2021 12:02:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210422100217.jmpgevtrukqyukfo@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210421095213.25hnfi2th7gzyzt2@steredhat>
 <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
 <20210422084638.bvblk33b4oi6cec6@steredhat>
 <bfefdd94-a84f-8bed-331e-274654a7426f@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <bfefdd94-a84f-8bed-331e-274654a7426f@kaspersky.com>
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

On Thu, Apr 22, 2021 at 12:40:17PM +0300, Arseny Krasnov wrote:
>On 22.04.2021 11:46, Stefano Garzarella wrote:
>> On Wed, Apr 21, 2021 at 06:06:28PM +0300, Arseny Krasnov wrote:
>>> Thank You, i'll prepare next version. Main question is: does this
>>> approach(no SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id') considered
>>> good? In this case it will be easier to prepare final version, because
>>> is smaller and more simple than previous logic. Also patch to spec
>>> will be smaller.
>> Yes, it's definitely much better than before.
>>
>> The only problem I see is that we add some overhead per fragment
>> (header). We could solve that with the mergeable buffers that Jiang is
>> considering for DGRAM.
>
>If we are talking about receive, i think, i can reuse merge logic for

Yep, for TX the guest can potentially enqueue a big buffer.
Maybe it's still worth keeping a maximum size and fragmenting as we do 
now.

>
>stream sockets, the only difference is that buffers are mergeable
>until previous EOR(e.g. previous message) bit is found in rx queue.
>

I got a little lost.
Can you elaborate more?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

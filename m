Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D13C433ED
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 15:41:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8B3611AB
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 15:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8B3611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BA8340FA3;
	Thu, 13 May 2021 15:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxo6bzlT4nDW; Thu, 13 May 2021 15:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0F7240496;
	Thu, 13 May 2021 15:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94D59C000E;
	Thu, 13 May 2021 15:41:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B74DDC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 15:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 982B284541
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 15:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FAhOm8D5iaE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 15:41:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68D188453E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620920490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sXZYS/0BUExKj3W5kBmFWrcfidrqXplf+lopV9pbEik=;
 b=V9A6wZihr3fNYA+i97JBSsZIIDanAvuoYXB1X3aWLcYkV0tMzgeY9asnRZY5KaomohzLTY
 7lIn9dg0K/oab7qRwGfSd+9ls1BAbjIEogGmdNpo5L+HdYKSd2VDtVZbOoflDD3lfzGlWz
 7OqYS3wg5ZbIdUBS+YaAxuoIELlZaNE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-3gfbTW2tOy6MqbkyL3FU7A-1; Thu, 13 May 2021 11:41:27 -0400
X-MC-Unique: 3gfbTW2tOy6MqbkyL3FU7A-1
Received: by mail-ej1-f69.google.com with SMTP id
 yh1-20020a17090706e1b029038d0f848c7aso8577159ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 08:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sXZYS/0BUExKj3W5kBmFWrcfidrqXplf+lopV9pbEik=;
 b=k6ybUk2uqzHY+qHjcl+PO9qZXa4Yi5vCWyuaDsT1VHarSVTQsS2l7V4FeWGnjFhK9x
 sqNDqVBQUrOWdbVt85tT63m7tZrJN6ddeMTcqRFQRQz5VVjiC5MAXyBje5SD0JrML61z
 Mw8P9qCF1cgQemWuhBum4TKhDbdvd86G0SNjGcqWSJ0Ajoe0KsWPCSvSfqiqXpHG3qge
 kO/LqEk+YZE2x4qy0NzZZqydSIhbCOzog9eiDDJJ4gyAqOBVwZ7AdQ7QoPU/k2oEO1pG
 J83y5baK7LiqxpoIieDqH5VDJBDkb/6Ko/ZWw+6omiA6QOyl6C1xayFduNI8xDCzNJcn
 cVqQ==
X-Gm-Message-State: AOAM531nasg4fTSekYr4VJD2C6NHz5FDFtv4AfKMkNeTDabVMlCQ6o3V
 FpfsytRRKyqlBtHCC8PQt0Zlmbn/9IOXPDNvekpo2o25YqNIVxqiaS0ERA/D2Fb2+AY0Q9lNg+u
 K4mP0AjBWsi5DPZxr3AJQ979EAQOLDtY//mre/WiYZw==
X-Received: by 2002:aa7:dd41:: with SMTP id o1mr50245489edw.361.1620920486218; 
 Thu, 13 May 2021 08:41:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPjtArqT2SrP+FHXngcrCXNm8mzmb8hWvhCdzDFicV/Wrm8pfSoY4vN4Vx8FaRAq4VLVTKdw==
X-Received: by 2002:aa7:dd41:: with SMTP id o1mr50245467edw.361.1620920486053; 
 Thu, 13 May 2021 08:41:26 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id o3sm2624150edr.84.2021.05.13.08.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 May 2021 08:41:25 -0700 (PDT)
Date: Thu, 13 May 2021 17:41:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v9 19/19] af_vsock: serialize writes to shared socket
Message-ID: <20210513154121.a4p2gxwnrxxlj64n@steredhat>
References: <20210508163027.3430238-1-arseny.krasnov@kaspersky.com>
 <20210508163738.3432975-1-arseny.krasnov@kaspersky.com>
 <20210513140150.ugw6foy742fxan4w@steredhat>
 <20210513144653.ogzfvypqpjsz2iga@steredhat>
 <a0cd1806-22d1-8197-50dc-b63a43f33807@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <a0cd1806-22d1-8197-50dc-b63a43f33807@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Thu, May 13, 2021 at 05:48:19PM +0300, Arseny Krasnov wrote:
>
>On 13.05.2021 17:46, Stefano Garzarella wrote:
>> On Thu, May 13, 2021 at 04:01:50PM +0200, Stefano Garzarella wrote:
>>> On Sat, May 08, 2021 at 07:37:35PM +0300, Arseny Krasnov wrote:
>>>> This add logic, that serializes write access to single socket
>>>> by multiple threads. It is implemented be adding field with TID
>>>> of current writer. When writer tries to send something, it checks
>>>> that field is -1(free), else it sleep in the same way as waiting
>>>> for free space at peers' side.
>>>>
>>>> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>>>> ---
>>>> include/net/af_vsock.h   |  1 +
>>>> net/vmw_vsock/af_vsock.c | 10 +++++++++-
>>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>> I think you forgot to move this patch at the beginning of the series.
>>> It's important because in this way we can backport to stable branches
>>> easily.
>>>
>>> About the implementation, can't we just add a mutex that we hold until
>>> we have sent all the payload?
>> Re-thinking, I guess we can't because we have the timeout to deal
>> with...
>Yes, i forgot about why i've implemented it using 'tid_owner' :)

It is not clear to me if we need to do this also for stream.

I think will be better to follow af_inet/af_unix, but I need to check 
their implementation.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

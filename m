Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA894C43217
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 09:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B2A5418AC;
	Thu,  1 Dec 2022 09:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B2A5418AC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D4KxFRky
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NbHPXbh82evJ; Thu,  1 Dec 2022 09:31:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B5F94093D;
	Thu,  1 Dec 2022 09:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B5F94093D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BE83C0032;
	Thu,  1 Dec 2022 09:31:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9867FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64BEF82009
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64BEF82009
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D4KxFRky
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2pPVaDKagYEE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:31:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A87382007
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A87382007
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669887068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t6GQr0UM9rGj3V8rz/OXkK1eGrs2rQLTQ7/eb6SPTLc=;
 b=D4KxFRkycl6u4m6EmzVjgcQSP8+VXfreh6XuRA7+TmtcXrDqpbI7wqNourHpxlYUr1Ur2v
 wco5MWuZfddxZHTOaVBXlpbUXJyUWqNq2ye3xpD9Kjz5WGS0l5Q3FW39+6vXsCnVzDR9wG
 qaIz9uZbmBGVEepljZBmVOT7LFAutAM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-644-Ne-5ZPqqP-i6AZntgfwT7g-1; Thu, 01 Dec 2022 04:31:07 -0500
X-MC-Unique: Ne-5ZPqqP-i6AZntgfwT7g-1
Received: by mail-wr1-f72.google.com with SMTP id
 k1-20020adfb341000000b0024215e0f486so226858wrd.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 01:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6GQr0UM9rGj3V8rz/OXkK1eGrs2rQLTQ7/eb6SPTLc=;
 b=dnMKeFhxloUDA2paq6mFYalWaw3f/dtoS1ho9QsjIqa+YJj3Ee+rr8KBT5IExCzsus
 VUZ3UXb5Y1PM7M9TVRMc/PN79IzriC0pEjBhpLJ0/dGHwJBi6shNn0pxk8v+TbheISHn
 7TVnAP6RWq2yP1lMg7TyADRzXy2ustzwIU6Ii7ejTIZ409LVxI/sNFUUiYaFcz7D8g4n
 EG4k4h1T/KlzsCsiSNiCVFBCL/GHCOw37R8bNS0g6Dy0S4P1u5zQa3IxrDzLyKUhTEJu
 s6ZWpqi37SOpY4/NN7f40VsS5Q3l46aMtBV7ZqQyOf37NYdJNMjsOdgltj0Ok9tMd7Yu
 E1ZA==
X-Gm-Message-State: ANoB5plZY7QqZwPrfQWTx6NYr8QFo2mvYQP1Ey65gYaqYwAyqrjSMg3u
 Xi1oeEhGaJt1Mu0EL9p+0K41DaOfbLpWhoNYOuHY0BE5UNRuXc/GnY+yuGm9f+GI2FnQfHmXFvV
 eEqAYDtdiohrHYX1UySU7JSAHKtNBm/+rDT39p9XHRw==
X-Received: by 2002:adf:f74f:0:b0:236:71fe:c9b9 with SMTP id
 z15-20020adff74f000000b0023671fec9b9mr39003157wrp.663.1669887066195; 
 Thu, 01 Dec 2022 01:31:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7OwVhMzKkMp2PXxHvQ8kcJNcpLNqHzaKFW2CmbRvflPB4XQg0+N7ynITOD6o9BgughqgPaHA==
X-Received: by 2002:adf:f74f:0:b0:236:71fe:c9b9 with SMTP id
 z15-20020adff74f000000b0023671fec9b9mr39003129wrp.663.1669887065950; 
 Thu, 01 Dec 2022 01:31:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 q128-20020a1c4386000000b003c71358a42dsm11534117wma.18.2022.12.01.01.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 01:31:05 -0800 (PST)
Date: Thu, 1 Dec 2022 10:30:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [RFC PATCH v2 3/6] vsock/vmci: always return ENOMEM in case of
 error
Message-ID: <20221201093048.q2pradrgn5limcfb@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <675b1f93-dc07-0a70-0622-c3fc6236c8bb@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <675b1f93-dc07-0a70-0622-c3fc6236c8bb@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
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

On Fri, Nov 25, 2022 at 05:08:06PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This saves original behaviour from af_vsock.c - switch any error
>code returned from transport layer to ENOMEM.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

@Bryan @Vishnu what do you think about this patch?

A bit of context:

Before this series, the af_vsock core always returned ENOMEM to the user 
if the transport failed to queue the packet.

Now we are changing it by returning the transport error. So I think here 
we want to preserve the previous behavior for vmci, but I don't know if 
that's the right thing.



@Arseniy please in the next versions describe better in the commit 
messages the reasons for these changes, so it is easier review for 
others and also in the future by reading the commit message we can 
understand the reason for the change.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 842c94286d31..289a36a203a2 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1838,7 +1838,14 @@ static ssize_t vmci_transport_stream_enqueue(
> 	struct msghdr *msg,
> 	size_t len)
> {
>-	return vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
>+	int err;
>+
>+	err = vmci_qpair_enquev(vmci_trans(vsk)->qpair, msg, len, 0);
>+
>+	if (err < 0)
>+		err = -ENOMEM;
>+
>+	return err;
> }
>
> static s64 vmci_transport_stream_has_data(struct vsock_sock *vsk)
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F54BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 17 Mar 2022 08:09:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34759612A4;
	Thu, 17 Mar 2022 08:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8XjQ-PNE7w7U; Thu, 17 Mar 2022 08:09:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB0A4612A5;
	Thu, 17 Mar 2022 08:09:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6034C001A;
	Thu, 17 Mar 2022 08:09:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4858EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 377C1416F5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d16Tg1bt4GTy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:09:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 959C3409A0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647504589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnLdr4HwqrI6g2eVldupmYABxQ1B7HkrLHxzrYkWZNY=;
 b=H7FiNj4xi8lCplKClInuiAVxjcQFdFWc8AueOAL8oKcBvC1jWE5ZTSjj7Od/Tq2HeSiRud
 y6aDh4vRq/CgjAswQWZphyUOr8STQO1ANsWMmB9/WcjE1426CojDAZxylCed8xUtzXbtRI
 zig+1jDhLRy1ew0h+J7MVbA9w767Pww=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-nkzRQ8woNCWw6gJV_Xdv0A-1; Thu, 17 Mar 2022 04:09:45 -0400
X-MC-Unique: nkzRQ8woNCWw6gJV_Xdv0A-1
Received: by mail-qk1-f198.google.com with SMTP id
 w200-20020a3762d1000000b0067d2149318dso2908949qkb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 01:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bnLdr4HwqrI6g2eVldupmYABxQ1B7HkrLHxzrYkWZNY=;
 b=pg9MaajigfumrXpLBFDZ1cifHZ9RwOO/xzBejJ8h9x3RoZZgss6JQFGcN/Fjz+yMYe
 zkcspVUWXvO2ZTcjY5487M6QIBB5SbP4RxkucSmUh6Mfy+u4CuRGvlcl4tFEztTenHVe
 AoFokzPG3i5k/qgVB/8oESrmocOmA3l4X8xq+tMMdTyvHMCdQk9R6XNAzQxd4lzE6ovo
 rJtekHA/5arCZcItojkaX45LLwkpGsyNVN8NvEsaHQ95iDOzckbhSdf605M1zz1G7PXv
 fAaN3XZlkMwcdkb8IJucrZL/Qcc4rmOoSWfs07OaIHTt/JsXWTxChZQ4+zkd5kAP5Jhv
 YMaQ==
X-Gm-Message-State: AOAM533V8t2pUBy6shrvMW42yVjs7LRRVEJAplEF7jv66Bga8uz4FGuI
 mski/94Q06mbRKW2N0FOxdtojYvGl4XTdcE0FNQJXzpep2oAIxKfCi4U+sYshR58Hj8cD2+VNMH
 QsEX98rbDJ1kIgLpOaPuzYsa9WzzlG1+7gjyevj2xGw==
X-Received: by 2002:ac8:5ccc:0:b0:2e1:b355:5c36 with SMTP id
 s12-20020ac85ccc000000b002e1b3555c36mr2733609qta.402.1647504584993; 
 Thu, 17 Mar 2022 01:09:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxnAp8LRv0pGr4caYh2PYRswaZ3blc4m+lTKdGlnP5IFQMb25svYg88Zli7hmhO5GnMJsu3Q==
X-Received: by 2002:ac8:5ccc:0:b0:2e1:b355:5c36 with SMTP id
 s12-20020ac85ccc000000b002e1b3555c36mr2733597qta.402.1647504584792; 
 Thu, 17 Mar 2022 01:09:44 -0700 (PDT)
Received: from sgarzare-redhat (host-79-42-202-12.retail.telecomitalia.it.
 [79.42.202.12]) by smtp.gmail.com with ESMTPSA id
 a6-20020ae9e806000000b0067ba5a8a2a7sm2003975qkg.134.2022.03.17.01.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 01:09:44 -0700 (PDT)
Date: Thu, 17 Mar 2022 09:09:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v3 2/2] af_vsock: SOCK_SEQPACKET broken buffer
 test
Message-ID: <20220317080938.pyngcehb3lmags7k@sgarzare-redhat>
References: <4ecfa306-a374-93f6-4e66-be62895ae4f7@sberdevices.ru>
 <c3ce3c67-1bbd-8172-0c98-e0c3cd5a80b6@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <c3ce3c67-1bbd-8172-0c98-e0c3cd5a80b6@sberdevices.ru>
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

On Thu, Mar 17, 2022 at 05:28:21AM +0000, Krasnov Arseniy Vladimirovich wrote:
>Add test where sender sends two message, each with own
>data pattern. Reader tries to read first to broken buffer:
>it has three pages size, but middle page is unmapped. Then,
>reader tries to read second message to valid buffer. Test
>checks, that uncopied part of first message was dropped
>and thus not copied as part of second message.
>
>Signed-off-by: Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>
>---
> v2 -> v3:
> 1) "got X, expected Y" -> "expected X, got Y".
> 2) Some checkpatch.pl fixes.
>
> tools/testing/vsock/vsock_test.c | 131 +++++++++++++++++++++++++++++++
> 1 file changed, 131 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

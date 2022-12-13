Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6965EC04FDE
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 10:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF39C415BF;
	Tue, 13 Dec 2022 10:45:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF39C415BF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TD1gazDl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OEOrBIT89rpr; Tue, 13 Dec 2022 10:45:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5607F416AB;
	Tue, 13 Dec 2022 10:45:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5607F416AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19FCBC0033;
	Tue, 13 Dec 2022 10:45:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E03DCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:45:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB494416AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:45:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB494416AB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u1WIhxW4stew
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:45:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 459A4415BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 459A4415BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670928348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ng1wd9XMGqm8kfTwHIk/MN0YdretQ2zd7KrLEZThTl8=;
 b=TD1gazDlq1yl0A4XBIKZ2x3Pmp6ZXR9CpvKnPMFTN4nGr7YMnhYt+2veFkGIh5wmlcDIjT
 WPBUOeZ6g/h2C8yYOja8OVcCP4KRQnNdbUa3FHKrWByH7I1TTSvP/W5lZvzdvsWGr1A/Mg
 +cmzCOenZzXuxoXIM9VNZXUeq7DV73g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-SaIqn66mPKu-sGgjPU_6LQ-1; Tue, 13 Dec 2022 05:45:46 -0500
X-MC-Unique: SaIqn66mPKu-sGgjPU_6LQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 l9-20020adfa389000000b00241f907e102so2797282wrb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 02:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ng1wd9XMGqm8kfTwHIk/MN0YdretQ2zd7KrLEZThTl8=;
 b=JtQMaZmoYv1D4W/KmEWZAvlZYVlLfn+w0RI+ic5LL7E1QkjY4lroPCuaEkfomiJhrF
 wrCj+e9FsnGRa/72AXZf1UVOfFQcoi82Q2Bsyzijt2BF8F9KXlwMXU0BJKhTmBVh9e4J
 CmUgp6p1S1qg5ulVtxy1/6wgg1N2DGUNA1WBClm9IZ8YEVtoM687Tt5yC/j+LZLb+y6K
 NImWC26S56Bprll6Y85ni+VUGjm24JVHKqCjfruqRdrcs3Nh7kvYz4Gx3p7TXNe6/9d6
 Nui98xt9qOAovav0GXzs6PVNsDRTdXFaH3PiSN/YtnXHpohXPsYNtR99lc4d9zxzBrrd
 iv8g==
X-Gm-Message-State: ANoB5pkuysix5t3099uKbaZtoOWHc4zH4+vWO9r2jqB+Rb5J+HfWwwQ5
 9Ukh7njNUGVYS8+H9hy6ftlVjseQC8R8i10DaXT2qDn25b7Ks12vSqsAedbX+D4g0UPJzTSVh8K
 2a+GzTuTdg/ZBzSUNr6BRkuOo0Lhznvf5WvYmFCrlCQ==
X-Received: by 2002:a5d:4747:0:b0:242:1f8d:999 with SMTP id
 o7-20020a5d4747000000b002421f8d0999mr12652331wrs.14.1670928345341; 
 Tue, 13 Dec 2022 02:45:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ztoklTJqIwHxoPbA5x2OKUpO2qh4VDozvm8AXd41GT3ej8DL4wCxvlY2h7af0pfy4ekABUA==
X-Received: by 2002:a5d:4747:0:b0:242:1f8d:999 with SMTP id
 o7-20020a5d4747000000b002421f8d0999mr12652317wrs.14.1670928345137; 
 Tue, 13 Dec 2022 02:45:45 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 i8-20020adfefc8000000b0022cdeba3f83sm11389245wrp.84.2022.12.13.02.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 02:45:44 -0800 (PST)
Date: Tue, 13 Dec 2022 11:45:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 2/4] test/vsock: rework message bounds test
Message-ID: <20221213104542.o2fzurh3fsrkgod4@sgarzare-redhat>
References: <6be11122-7cf2-641f-abd8-6e379ee1b88f@sberdevices.ru>
 <44a15b4f-5769-7ed8-f4d1-04abbca6f379@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <44a15b4f-5769-7ed8-f4d1-04abbca6f379@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
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

On Tue, Dec 06, 2022 at 08:50:55PM +0000, Arseniy Krasnov wrote:
>This updates message bound test making it more complex. Instead of
>sending 1 bytes messages with one MSG_EOR bit, it sends messages of
>random length(one half of messages are smaller than page size, second
>half are bigger) with random number of MSG_EOR bits set. Receiver
>also don't know total number of messages.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/control.c    |  28 +++++++
> tools/testing/vsock/control.h    |   2 +
> tools/testing/vsock/util.c       |  13 ++++
> tools/testing/vsock/util.h       |   1 +
> tools/testing/vsock/vsock_test.c | 128 +++++++++++++++++++++++++++----
> 5 files changed, 157 insertions(+), 15 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

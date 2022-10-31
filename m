Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A70FA3740
	for <virtualization@archiver.kernel.org>; Mon, 31 Oct 2022 08:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A78660B21;
	Mon, 31 Oct 2022 08:37:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A78660B21
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D6/Z5a02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UrYIs-gncbnf; Mon, 31 Oct 2022 08:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CB94605AB;
	Mon, 31 Oct 2022 08:37:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CB94605AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01DDAC0033;
	Mon, 31 Oct 2022 08:37:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C509C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2EE3A40154
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:37:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2EE3A40154
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D6/Z5a02
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXi32UAV_7EO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:37:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B9D040122
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B9D040122
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 08:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667205429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g7Dq1aOGhSqbnLXSSpuWXNREMYffR0XtNShs/CkTqkk=;
 b=D6/Z5a026gLfys+dccFVPbixA22pLuKI7oRMgB+FoJvyWuAlgveYZ9qBlxhS0ljuT2jGl6
 2SIpIzfFPi8vd2BLVnlT82jMI0BrS5wb9XrMnEjjTN+tW1G3ly1uhflaumwuaNrDfeS13+
 nzhmhX3Fkg6OQDgZvdPLmZ4OE5N09a8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-452-MmQRgI8iOIOKHoc9oMEu0A-1; Mon, 31 Oct 2022 04:37:07 -0400
X-MC-Unique: MmQRgI8iOIOKHoc9oMEu0A-1
Received: by mail-ed1-f72.google.com with SMTP id
 q13-20020a056402518d00b00462b0599644so6741632edd.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Oct 2022 01:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7Dq1aOGhSqbnLXSSpuWXNREMYffR0XtNShs/CkTqkk=;
 b=EqH9b1CvM6fYuesEElcpJbVcyYcK2Jghgrw4tqyG1GEaequ93bp3OqJvsweJE/Kf8d
 j/6pyQlSsSY3HTWOB8ppWN+ANTkVhT6QitsGAJViIx7gX29yibW2f5CKiOYjGz2cZxzq
 ejPmRZB6yx/67tobYwG5I4JDNXGMMe4sUnKsTPm4VLGcSeyhek19i7gjM1EOfUymUI+g
 M1X/B18+y59mXXjNm+7CG5FD3y3y5Boa6+7b+8DxG7ruengqyT6GPBCmx1t6GcuwqTZW
 6Jy2MLdbd5ZoEKnWZCzVIs847yzMOHjD0+E6T3Yitk09gU4g6f7xusLKaMTzGm8RbexE
 Bkkw==
X-Gm-Message-State: ACrzQf1ff4O7SV69HLh7yCyLB/kIlCs90Bydl7iO2I9SP4wnhSC9QnJz
 0ivY4qhwiuEkT+Bz29ddntKtHX864ZWi2zLu575OR/YXVMNjapoEeTBNY0X1T6eICGgr0d3xj8r
 vBk6wwUtpmGB90G/V1tyABCQf0LoG5ztvk55MrQovBg==
X-Received: by 2002:a17:906:4795:b0:794:8b93:2e33 with SMTP id
 cw21-20020a170906479500b007948b932e33mr11943139ejc.265.1667205426655; 
 Mon, 31 Oct 2022 01:37:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5uNSsXtfuDCxQDPjmlh78PdWRxENqpMT+1GcFwXzsCqnYJKcM79AP3wlMyFUJpg0Tdpzq1ow==
X-Received: by 2002:a17:906:4795:b0:794:8b93:2e33 with SMTP id
 cw21-20020a170906479500b007948b932e33mr11943114ejc.265.1667205426401; 
 Mon, 31 Oct 2022 01:37:06 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 m24-20020aa7c2d8000000b0044dbecdcd29sm2909250edp.12.2022.10.31.01.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Oct 2022 01:37:06 -0700 (PDT)
Date: Mon, 31 Oct 2022 09:37:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 1/2] vsock: remove the unused 'wait' in
 vsock_connectible_recvmsg()
Message-ID: <20221031083704.yqzz4qcrzbcqxbrw@sgarzare-redhat>
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-2-decui@microsoft.com>
MIME-Version: 1.0
In-Reply-To: <20221028205646.28084-2-decui@microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 edumazet@google.com, kuba@kernel.org, arseny.krasnov@kaspersky.com,
 pabeni@redhat.com, davem@davemloft.net
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

On Fri, Oct 28, 2022 at 01:56:45PM -0700, Dexuan Cui wrote:
>Remove the unused variable introduced by 19c1b90e1979.
>
>Fixes: 19c1b90e1979 ("af_vsock: separate receive data loop")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/af_vsock.c | 2 --
> 1 file changed, 2 deletions(-)

Good catch!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ee418701cdee..d258fd43092e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2092,8 +2092,6 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	const struct vsock_transport *transport;
> 	int err;
>
>-	DEFINE_WAIT(wait);
>-
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
> 	err = 0;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

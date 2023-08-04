Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149AFC001DB
	for <virtualization@archiver.kernel.org>; Fri,  4 Aug 2023 07:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6DAC160F4D;
	Fri,  4 Aug 2023 07:50:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DAC160F4D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T/JKVneQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SxcVs2_1JgJB; Fri,  4 Aug 2023 07:50:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0396760C16;
	Fri,  4 Aug 2023 07:50:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0396760C16
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C604CC0072;
	Fri,  4 Aug 2023 07:50:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99B4AC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 07:50:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C6EA400BB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 07:50:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C6EA400BB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T/JKVneQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XQlnT47W8yEJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 07:50:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B815840538
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Aug 2023 07:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B815840538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691135417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EJNCjBbUaxpHFi81g2fq9zXIhVcgdwCTwZCKF8pxHv8=;
 b=T/JKVneQQzZ8Wh9vwHzjl/3XcodEoEvWW9SGVpU8UnDtb3m4K7DGmmjNY1U98+JOwHaaS4
 1P5pVPWwlGG1oUC29hiUwpv211tRT/mx7oy9KL6o+VAn7Ak/IiW3q27zUuM4qbzzjFG/XA
 qMwSSTxSSmPJcoEtKv1zyc7JKrqzmdc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-yutQkVZ2OjWu3RV8dwt0Uw-1; Fri, 04 Aug 2023 03:50:13 -0400
X-MC-Unique: yutQkVZ2OjWu3RV8dwt0Uw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-63d41d15574so22557006d6.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Aug 2023 00:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691135413; x=1691740213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJNCjBbUaxpHFi81g2fq9zXIhVcgdwCTwZCKF8pxHv8=;
 b=EnkbgsQxzuSFw4cAq1iedmTNlp2+TNQYcxH0WIUFxEBe/SWxv3T25poCstimoNrFwT
 8RSg01kkbzUmPT4wppE72LXilNtfgIILj8VWyH8Hp7O3CPVV5hqmV/nQZy2ZVbvtHsXG
 +ghSEm4p1TapPeBFRPUqkcSITMl5Or9+a9NzAmxkN69uArBjgj/kHTwmYXvA6FpXH6Bw
 XAzQjD66PFNXbIKzc9ZoaCXjYpUgZj/q2d8MAxI5jqW3lw6iiRqy3FbvWYyYDyWeLGYW
 DUjxVo7xgIHJAw4hwtenR7raOYRvNkQXkDmjnwKa2iBHEAoTbMDM/3u9wSh03KKabQUA
 4IZg==
X-Gm-Message-State: AOJu0Yzc1IAW+7UEfm1y7kcpKdsN1i070zB0Ex+2A2f1PmzBRcEEDkrk
 beMILMJVSZpiQmof8Hfahu0yw/As1M5wuaUwXLg4pLAvrySZLgH37SqqhIJVwLuTucrm9HkVL9g
 PlHjo2Q6LQEPvMcN3awwPO5WGdESfmNaO4CLZAajmdQ==
X-Received: by 2002:a05:622a:651:b0:405:49e0:899f with SMTP id
 a17-20020a05622a065100b0040549e0899fmr1604387qtb.39.1691135413413; 
 Fri, 04 Aug 2023 00:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdJhhhHo66q8mOj5/wTJahLgvxWofEBXXNIVMVbM5UXM0NqJORuYMOilvr66YHHR5o9ji0/w==
X-Received: by 2002:a05:622a:651:b0:405:49e0:899f with SMTP id
 a17-20020a05622a065100b0040549e0899fmr1604364qtb.39.1691135413153; 
 Fri, 04 Aug 2023 00:50:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 c24-20020ac80098000000b003f7fd3ce69fsm485256qtg.59.2023.08.04.00.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 00:50:12 -0700 (PDT)
Date: Fri, 4 Aug 2023 09:50:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH -next] af_vsock: Remove unused declaration
 vsock_release_pending()/vsock_init_tap()
Message-ID: <xjs5cdmrcnsnzvbezd24lzvb4fgoofkyamvbxzbcwpetslhizc@seph4jwbpziv>
References: <20230803134507.22660-1-yuehaibing@huawei.com>
 <ZMwBFdw8BTno3dn2@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZMwBFdw8BTno3dn2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: bobby.eshleman@bytedance.com, netdev@vger.kernel.org,
 Yue Haibing <yuehaibing@huawei.com>, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Aug 03, 2023 at 09:33:41PM +0200, Simon Horman wrote:
>On Thu, Aug 03, 2023 at 09:45:07PM +0800, Yue Haibing wrote:
>> Commit d021c344051a ("VSOCK: Introduce VM Sockets") declared but never implemented
>> vsock_release_pending(). Also vsock_init_tap() never implemented since introduction
>> in commit 531b374834c8 ("VSOCK: Add vsockmon tap functions").
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>
>Hi Yue Haibing,
>
>FWIIW, I think this should be targeted at net-next.

Yep, please send to net-next.

Looks good also to me:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1B8C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 11:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED10741E44;
	Thu, 23 Mar 2023 11:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED10741E44
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MixwL05+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ttu_L9Sj9jO8; Thu, 23 Mar 2023 11:11:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 313B841E23;
	Thu, 23 Mar 2023 11:11:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 313B841E23
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3F25C0071;
	Thu, 23 Mar 2023 11:11:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D63C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:11:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 797E961524
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 797E961524
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MixwL05+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0r4z_oCxv90k
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:11:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2463C61521
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2463C61521
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679569878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BchtG9wKeZ97oxXjhrm96XFjZ5ZGtPrJx2tGt2VfOfg=;
 b=MixwL05+8bIr4KefEaQhkgOm7bFc9mIU2qBm2V07yVr+kDzipG2elyP+jFS11ZRl7yJAkp
 cJY+Mk+EYvMN8iJOcps7a5KFCQiFCJVojTztvSuwiXZZGXU1vPw5KhkVuU90ESsAHaTs78
 LJwc4+b9XuZj7KI+dS2n4GAI4kDKCss=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-X7cLjSUNObmGfjurqF1avQ-1; Thu, 23 Mar 2023 07:11:16 -0400
X-MC-Unique: X7cLjSUNObmGfjurqF1avQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 ga17-20020a05622a591100b003bfdf586476so12717037qtb.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 04:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679569876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BchtG9wKeZ97oxXjhrm96XFjZ5ZGtPrJx2tGt2VfOfg=;
 b=5D0+lyhilxLyxUD51q3EOq1MQSyQuAJ1/fLDM1IXmZHSdtbrY5YpCoo19DZBrIoaja
 +RV5AGvDJgBQhCntGQmI6rX18M7GRtXL0ChfBra2jQSZHx6yuUNXQHhxMW+pCW44UA6J
 /NYE81kEwB0ROhCwPiHAzBQuM1pBmoIRJn9ZtoN1RPyQ78bu8VT/Ki8Pc3mHAdh8+qf6
 mD4LYRk9v19TRNJ1VeWehmwpUFCNRyD2mQuh5HjaG5oQCEu+nSUzSgmcMbHdZ4IBlGN6
 niy1I/sFqh6d192V1c6HTyGQLppVaOZK/bMaUAqpUwQB4eJqgTDz4fIquCKoo7RduA5m
 PcbA==
X-Gm-Message-State: AO0yUKXsjyreBjWxrDnII2olEQjI7IX20tBWTCUOrHF1um284Q5FBuIA
 Q1SQhuEcbetCi5J3tTyw0eaJ8btFGM4ip7RkRJj9msjHr3jYNLlaEakZCLksGvi/DSaQbKkL2uG
 47pJuwSY3CTCRI6WXahHOl/sXupQ8apRsmYGE4LQF7Q==
X-Received: by 2002:a05:622a:15d3:b0:3e3:791e:72cf with SMTP id
 d19-20020a05622a15d300b003e3791e72cfmr10008575qty.26.1679569876176; 
 Thu, 23 Mar 2023 04:11:16 -0700 (PDT)
X-Google-Smtp-Source: AK7set/KaamBvlgMtErYI/M4H7LuQVV0ilEhCcyJ2CVaFr2tiTj0CxZrISYp/ghNz4Mfs3oe/NjWig==
X-Received: by 2002:a05:622a:15d3:b0:3e3:791e:72cf with SMTP id
 d19-20020a05622a15d300b003e3791e72cfmr10008542qty.26.1679569875838; 
 Thu, 23 Mar 2023 04:11:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 p17-20020a374211000000b007428e743508sm13015960qka.70.2023.03.23.04.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 04:11:15 -0700 (PDT)
Date: Thu, 23 Mar 2023 12:11:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 0/2] allocate multiple skbuffs on tx
Message-ID: <20230323111110.gb4vlaqaf7icymv3@sgarzare-redhat>
References: <f0b283a1-cc63-dc3d-cc0c-0da7f684d4d2@sberdevices.ru>
 <2e06387d-036b-dde2-5ddc-734c65a2f50d@sberdevices.ru>
 <20230323104800.odrkkiuxi3o2l37q@sgarzare-redhat>
 <15e9ac56-bedc-b444-6d9a-8a1355e32eaf@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <15e9ac56-bedc-b444-6d9a-8a1355e32eaf@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Mar 23, 2023 at 01:53:40PM +0300, Arseniy Krasnov wrote:
>
>
>On 23.03.2023 13:48, Stefano Garzarella wrote:
>> On Thu, Mar 23, 2023 at 01:01:40PM +0300, Arseniy Krasnov wrote:
>>> Hello Stefano,
>>>
>>> thanks for review!
>>
>> You're welcome!
>>
>>>
>>> Since both patches are R-b, i can wait for a few days, then send this
>>> as 'net-next'?
>>
>> Yep, maybe even this series could have been directly without RFC ;-)
>
>"directly", You mean 'net' tag? Of just without RFC, like [PATCH v5]. In this case
>it will be merged to 'net' right?

Sorry for the confusion. I meant without RFC but with net-next.

Being enhancements and not fixes this is definitely net-next material,
so even in RFCs you can already use the net-next tag, so the reviewer
knows which branch to apply them to. (It's not super important since
being RFCs it's expected that it's not complete, but it's definitely an
help for the reviewer).

Speaking of the RFC, we usually use it for patches that we don't think
are ready to be merged. But when they reach a good state (like this
series for example), we can start publishing them already without the
RFC tag.

Anyway, if you are not sure, use RFC and then when a maintainer has
reviewed them all, surely you can remove the RFC tag.

Hope this helps, at least that's what I usually do, so don't take that
as a strict rule ;-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

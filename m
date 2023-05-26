Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF4C77B7A
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 12:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A62A80E5A;
	Fri, 26 May 2023 12:23:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A62A80E5A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=doUjJsKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmbZjGDXzjwA; Fri, 26 May 2023 12:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 164BE84294;
	Fri, 26 May 2023 12:23:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 164BE84294
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEC9EC0036;
	Fri, 26 May 2023 12:23:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCD71C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 12:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FC05410C6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 12:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FC05410C6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=doUjJsKz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lrU6fyWttBna
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 12:23:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7030410B7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7030410B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685103803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2Bwg3T31bZ+IgI/U7aTrux02yFikGDvD9aeFeEQO12U=;
 b=doUjJsKzjfwksvECZNMZNxO0Ejq7tLgYu5Tfo0nfKS5ehEP7IZEdWxJ2VCGf1MGqpvqHTr
 OWPX4suuye7nT2OuGavK3H5DQa4W1k3OJyYJEYeyqx8zgZsHXNNaVcSV1quIFRxVNF8zAF
 1Fw0CoNalqz65QNVSu2Q35ka+o3IX6M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-wN472XX3Mwi-DThZvPIIgw-1; Fri, 26 May 2023 08:23:22 -0400
X-MC-Unique: wN472XX3Mwi-DThZvPIIgw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f5157aca5so86849566b.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685103801; x=1687695801;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Bwg3T31bZ+IgI/U7aTrux02yFikGDvD9aeFeEQO12U=;
 b=azi9ZFNmkjeQhJO+Tcb6+HRjzbWEJloAt4MKTMS+VnQMv+yXwdIwRly3mr0tUuUTfZ
 Ts0M3zz7OUOsfHhTCaYCTgikVvZLSt9y5ICKvS56z3Taw3p5sVn6KnTufd0k8/z/Tplk
 6ZxwndflMLf4kuW9uGyk8OPYRA9dGxeJESAvWsX864Ho/bLtZG8PmwHdaRnszqMSu0vc
 O2seIJiNzEPwHzYSO83TUfFqXXLpAZ6ttNBToufj2TAD43WUxWd3lL+GlHaLGoI9igs6
 W/znEBEzlggzNjWXK1k/J6d7c1J4/Mr/L3IsrY8frEuvK7wPZXPlMm1VRAL6Z2UvHxS6
 bRqg==
X-Gm-Message-State: AC+VfDxTGG7FEYToeDRyD49o+KlwGmpJ4ZKjkfqz/ET0GiQsuPuJQKIk
 dGMUQxR1Q5m5AAjmsHGKwRoMQYdIjsFkxCEp91VJsXlgfmi7XvUYhN0zvIWbZPsN7553DJKCmbZ
 4FdruzQ0RVRzK9RnTxxbOHqcR4avRlittYBtYWtzsHA==
X-Received: by 2002:a17:906:9753:b0:96f:f50b:9b15 with SMTP id
 o19-20020a170906975300b0096ff50b9b15mr2168445ejy.35.1685103801340; 
 Fri, 26 May 2023 05:23:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4p68NtoZoWsrla18nN4jigUwF5uKUcnp+Gb5FRHBIJzNJpRjw7/voNOUwf2ky2tlI7n7Dq4Q==
X-Received: by 2002:a17:906:9753:b0:96f:f50b:9b15 with SMTP id
 o19-20020a170906975300b0096ff50b9b15mr2168425ejy.35.1685103801031; 
 Fri, 26 May 2023 05:23:21 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 lz13-20020a170906fb0d00b0094f67ea6598sm2096292ejb.193.2023.05.26.05.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 05:23:20 -0700 (PDT)
Date: Fri, 26 May 2023 14:23:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 00/17] vsock: MSG_ZEROCOPY flag support
Message-ID: <sdm43ibxqzdylwxaai4mjj2ucqpduc74ucyg3yrn75dxu2kix5@jynppv7kxyjz>
References: <20230522073950.3574171-1-AVKrasnov@sberdevices.ru>
 <76270fab-8af7-7597-9193-64cb553a543e@sberdevices.ru>
 <y5tgyj5awrd4hvlrsxsvrern6pd2sby2mdtskah2qp5hemmo2a@72nhcpilg7v2>
 <4baf786b-afe5-371d-9bc4-90226e5df3af@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <4baf786b-afe5-371d-9bc4-90226e5df3af@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Fri, May 26, 2023 at 02:36:17PM +0300, Arseniy Krasnov wrote:
>
>
>On 26.05.2023 13:30, Stefano Garzarella wrote:
>> On Thu, May 25, 2023 at 06:56:42PM +0300, Arseniy Krasnov wrote:
>>>
>>>
>>> On 22.05.2023 10:39, Arseniy Krasnov wrote:
>>>
>>> This patchset is unstable with SOCK_SEQPACKET. I'll fix it.
>>
>> Thanks for let us know!
>>
>> I'm thinking if we should start split this series in two, because it
>> becomes too big.
>>
>> But let keep this for RFC, we can decide later. An idea is to send
>> the first 7 patches with a preparation series, and the next ones with a
>> second series.
>
>Hello, ok! So i'll split patchset in the following way:
>1) Patches which adds new fields/flags and checks. But all of this is not used,
>   as it is preparation.
>2) Second part starts to use it and also carries tests.

As long as they're RFCs, maybe you can keep them together if they're
related, possibly specifying in the cover letter where you'd like to
split them. When we agree that we are in good shape, we can split it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization

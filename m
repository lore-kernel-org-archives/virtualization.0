Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDDEC433FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Nov 2022 17:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2B3F81E56;
	Wed,  2 Nov 2022 17:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2B3F81E56
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=docker.com header.i=@docker.com header.a=rsa-sha256 header.s=google header.b=Kq7IwIHG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bmEMSXVGjkKt; Wed,  2 Nov 2022 17:08:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6362781E5A;
	Wed,  2 Nov 2022 17:08:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6362781E5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 396E7C0032;
	Wed,  2 Nov 2022 17:08:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C088CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 17:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 94B1760E5B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 17:08:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94B1760E5B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=docker.com header.i=@docker.com
 header.a=rsa-sha256 header.s=google header.b=Kq7IwIHG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FyARx5OmcXcf
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 17:08:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E63AA60B8A
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E63AA60B8A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 17:08:14 +0000 (UTC)
Received: by mail-io1-xd36.google.com with SMTP id q142so9488076iod.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Nov 2022 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=docker.com; s=google;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QYpb4d0goOw4Qakn303/fmOhgAIywNtc7WDJeQRPfyI=;
 b=Kq7IwIHGR1V6/baYeT2eDh5Y4bSEGpfBS7B08g6NLbQhphskuNcyelhtTtbycYkAMM
 86aepi4OkIf4jLOV2Vr/QNeA8CDd8pAzbdPIIKMcjQdpl65LfTtLh94c146ypWyL/MqT
 epxM4ECPHB6upmujHKvyW2hMZSkQUMv98tSn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYpb4d0goOw4Qakn303/fmOhgAIywNtc7WDJeQRPfyI=;
 b=2UbOEgUi5ufEnW71PLSK1dV9hjZStMBRwSx2bicLvrokCa5lyKqFB5BVh/eNSJuPlT
 MZdohzaHLVy8+4haSCRk4MCLsJiKLRef5eHkOXUYqZl9lYCz0IDXmagogauCUyCiNJxD
 PWmHR9XxYfF52cMJ4vsswlXqXQPrnPPy2DHiqYFi8OpEskFvKwuJlF+a/FdnFaQUQxiB
 uZQxD/DOBOdrcJSU7H5/wxaGkh7PvUBi8h/2rNNogONZVD6qUqYGlKpJ94QO+d9AyvZW
 brkpHWfoK4GMxPqw+sHLhiupNVJp18sLdXSmo2xEo2gmPuWqQYcN258Rpp9G7f9gNDbz
 c4Yw==
X-Gm-Message-State: ACrzQf3PRJGoUZAlbbpi6slLlypOarC46aAJVRJGfR1cm/XnNRaBKwS+
 HI7kMq2q4x7xPk/dzbMnOm5p82EGUWVvgG2lIBJH4g==
X-Google-Smtp-Source: AMsMyM5qV5kZNIawOYXAXvYYQOMoQBp1yfN5MVvXg41kmZNpBZM1irQma9pnpokWz9vReEDPyEs6PxMzR/syikwq/KI=
X-Received: by 2002:a5d:8913:0:b0:6a4:71b5:8036 with SMTP id
 b19-20020a5d8913000000b006a471b58036mr16071369ion.171.1667408894004; Wed, 02
 Nov 2022 10:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-3-decui@microsoft.com>
 <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
 <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
 <20221102094504.vhf6x2hgo6fqr7pi@sgarzare-redhat>
In-Reply-To: <20221102094504.vhf6x2hgo6fqr7pi@sgarzare-redhat>
Date: Wed, 2 Nov 2022 18:08:03 +0100
Message-ID: <CANWeT6hWU0tH6sBCUkxnfA21_qxcFuk56sqy=ZHgEJHogxqY5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: wei.liu@kernel.org, netdev@vger.kernel.org, haiyangz@microsoft.com,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 edumazet@google.com, kuba@kernel.org, arseny.krasnov@kaspersky.com
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
From: Frederic Dalleau via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Frederic Dalleau <frederic.dalleau@docker.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

PiBEaWQgeW91IHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsPwpOb3QgcmVhbGx5LCBJIGp1
c3QgcGlja2VkIHRoZSBsaXN0IHRoYXQgc2VlbWVkIG5hcnJvdyBlbm91Z2ggZm9yIHRoZSB0b3Bp
YwoKPiByZXNwb25kIHdpdGggeW91ciBUZXN0ZWQtYnk/CkRvbmUKCj4gSSB3b3VsZCBsaWtlIHRv
IGdpdmUgY3JlZGl0IHRvIGJvdGgsIHNvIEkgYXNrZWQgdG8gYWRkIHlvdXIgUmVwb3J0ZWQtYnkK
PiB0byB0aGUgRGV4dWFuJ3MgcGF0Y2guClRoYW5rIHlvdSEKClJlZ2FyZHMsCkZyw6lkw6lyaWMK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

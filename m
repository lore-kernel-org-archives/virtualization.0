Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429B4C433F5
	for <virtualization@archiver.kernel.org>; Mon, 30 May 2022 07:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB63A60EAB;
	Mon, 30 May 2022 07:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOApxBVBDnnd; Mon, 30 May 2022 07:00:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D0C1610E5;
	Mon, 30 May 2022 07:00:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD9EC0039;
	Mon, 30 May 2022 07:00:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB08C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E2724049F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cm8jpLj5P-uN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:00:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 09C49400A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 07:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653894052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U31K93Uq+Fvheeupr2NMZcwHmZ55uz0S5WD0bojawpY=;
 b=eiYROFcltg8czPFyMjj+Z2IwiHXj8lCGol1JrxqpelVpcYQSwi2woFK9E2+tRiAIKCpkoG
 zo5KRwtD8aZS9+izygosYyELNVYpZTuvJRpTvc40dVbrkaN8nGhyBcLWTnf2GZVEOZjF13
 uj9kzy31h5/x9hqP3ssFRR+Xwi7hOdQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-yz-aZ1WlNNGurf2Oybki-Q-1; Mon, 30 May 2022 03:00:50 -0400
X-MC-Unique: yz-aZ1WlNNGurf2Oybki-Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 e7-20020adfa747000000b0020fe61b0c62so1386792wrd.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 May 2022 00:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=U31K93Uq+Fvheeupr2NMZcwHmZ55uz0S5WD0bojawpY=;
 b=I1Shr43CIAuyCERS/GdnspGHhypV/HeYzXWjftHKDEif8FDM6pQ/LOGDG5MUMqYUrx
 Gzn05p05LQOgcCy2aLsa0b8RwrR4TvdON1YBupcnh1btvfhCbNr9nqhHt9DI3CmH+LPp
 eDnfrThQurKlQBpY7Ie5MLZn5d/MSS1q1AyMKLghutQOL6Qxf9Z40iuOULAzM3UbRwaS
 CSBjQnTFb5MGVwulgZSygmHJ4tzUzxgDbmYX+FkVrGCy1usY/RgdLKesF0FuAJ3+pzyD
 VAxoK/hjbaU/XYjQTau+uZ1FVurfz4D4JVCA3hPcTpyL3YHP21r0TU0jR/Mx6DnnkQFH
 Zgbw==
X-Gm-Message-State: AOAM533PORHIUSDIma4FCE9RxTHm8R0+VaCyr+8i6KSr49wfkqiPf6uG
 Wmj6AU8chOYELzA+/5ud6nueSrI2jNBoxFPFQA5oaFkMYDF12Cqc4SrKsjh4LoSNLIVXHH9dfPX
 75osUM8z0QQTwoc4qE6pHLDBqBs39zYQcy0ZMATe+ig==
X-Received: by 2002:a5d:678d:0:b0:210:2f33:4399 with SMTP id
 v13-20020a5d678d000000b002102f334399mr4865032wru.599.1653894049325; 
 Mon, 30 May 2022 00:00:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWbVjgbHJgDifYnjzVjmFGHKAJhvPFV/7EXQPi3xye3rM5BEYeXuoSqoi7mYy2rbSD+dcKpw==
X-Received: by 2002:a5d:678d:0:b0:210:2f33:4399 with SMTP id
 v13-20020a5d678d000000b002102f334399mr4865010wru.599.1653894049074; 
 Mon, 30 May 2022 00:00:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736?
 (p200300cbc7047c00aaa92ce55aa0f736.dip0.t-ipconnect.de.
 [2003:cb:c704:7c00:aaa9:2ce5:5aa0:f736])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a5d5292000000b0020ff3a2a925sm9714539wrv.63.2022.05.30.00.00.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 May 2022 00:00:48 -0700 (PDT)
Message-ID: <8ab86020-8e24-4004-d6b1-c122639e584b@redhat.com>
Date: Mon, 30 May 2022 09:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
To: =?UTF-8?B?Qm8gTGl1ICjliJjms6IpLea1qua9ruS/oeaBrw==?=
 <liubo03@inspur.com>, "mst@redhat.com" <mst@redhat.com>
References: <7a413652a9a9469f948fbfa2eae5c401@inspur.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <7a413652a9a9469f948fbfa2eae5c401@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMzAuMDUuMjIgMDQ6MTYsIEJvIExpdSAo5YiY5rOiKS3mtarmva7kv6Hmga8gd3JvdGU6Cj4g
QWRkaW5nIHRoaXMgcGF0Y2ggY2FuIGF2b2lkIHVubmVjZXNzYXJ5IFZNIGV4aXRzIGFuZCByZWR1
Y2UgdGhlIG51bWJlciBvZiBWTSBleGl0cwo+IAoKLi4uIGluIGNvcm5lciBjYXNlcyB3aGVyZSB2
aXJ0cXVldWVfYWRkX291dGJ1ZigpIGZhaWxzPyBXaHkgZG8gd2UgY2FyZQphYm91dCB0aGF0IGNv
cm5lciBjYXNlPwoKTG9va3MgbGlrZSB1bm5lY2Vzc2FyeSBjb2RlIGNodXJuIHRvIG1lLCB1bmxl
c3MgSSBhbSBtaXNzaW5nIHNvbWV0aGluZwppbXBvcnRhbnQuCgotLSAKVGhhbmtzLAoKRGF2aWQg
LyBkaGlsZGVuYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

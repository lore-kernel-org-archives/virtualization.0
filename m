Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56587C46467
	for <virtualization@archiver.kernel.org>; Wed, 28 Dec 2022 06:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD480813CD;
	Wed, 28 Dec 2022 06:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD480813CD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmTSd2N6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2skg1s_AhDr; Wed, 28 Dec 2022 06:36:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 84BE58131B;
	Wed, 28 Dec 2022 06:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84BE58131B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6754BC0032;
	Wed, 28 Dec 2022 06:36:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 286CBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E967660B9B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E967660B9B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JmTSd2N6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6G5JhSWrGXTX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:36:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3123760B2F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3123760B2F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Dec 2022 06:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672209374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+zBLxn+Zbw2TrfTyqVY7Ndr4jEPeMjeEB3bk31p0XY=;
 b=JmTSd2N6Ww57ThkacBdxDzI9l6e/K+KzVdaVEDeX49OBvZC2HVZOPsj6aPV+CGMI77mRWx
 WhwMirTmeykpONgiADN3P1e+OL5BxDKepUp05Cegdu7eCMIzEsVVHieCPct/RPekxaS7LZ
 8RBi9jkgaW8ZQN4+BaDvJ0XkugD6LdE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-21-E5aayHfNMy2IANcZTJ8-MQ-1; Wed, 28 Dec 2022 01:36:04 -0500
X-MC-Unique: E5aayHfNMy2IANcZTJ8-MQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 84-20020a630257000000b00477f88d334eso7625139pgc.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 22:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4+zBLxn+Zbw2TrfTyqVY7Ndr4jEPeMjeEB3bk31p0XY=;
 b=5HxHDMetWtFtMIb8CvbjKku2U0vRgLoB+Ki2jx/nU1x567a4GbZpXfK4yJQIhXtcsg
 J0997loQlVmjo1kvK+YjVgwm//q2HgWNhXaO3W+xiVISvsoPOf8TxqFNU81dLC87ny3G
 BD8ZD4meLPT2F54YKoHH20hnCuUmCGJqfsk2Xa7nA8yUoIYvWUh0UmpQ4N66GnoD3N3g
 aOZQYsSFXXpBQiHEcfsGHs2TM6H6mWqfBJX9LhdDXHgULDTzeV/THDEbEKFi1/n2RYUF
 +kAPmgF5JHYR1t6kN5r2Gt1eiUcHxmXuF7mS+jBmOk1VrgwOSxZ9f9SyFHtkjBbOhpkE
 80bw==
X-Gm-Message-State: AFqh2krCP8epnOEiG0Cnf6F5lQ9x28L7gAl6O4ruzcOtRNDz+nz+0F/+
 xhj7Tbn1IVnVG+4ZHrO62HO/oenXD1taIq03g6Hac8qy1DELAyhSrjBMRHOgTZ+aStDgwIsh0+k
 CwgIVfC9aI5oP/ehPKHEO4HpSvkIrWMLlfveWp/f/jg==
X-Received: by 2002:a17:902:ee41:b0:191:2181:d6e0 with SMTP id
 1-20020a170902ee4100b001912181d6e0mr24566558plo.8.1672209363824; 
 Tue, 27 Dec 2022 22:36:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu7PTvGIi4AYHXcrJhhBc8J2Wq9geK2D6iRjgRfX+XHd+/ICMcRm+yCxoD9vchCHpVfGZfBhQ==
X-Received: by 2002:a17:902:ee41:b0:191:2181:d6e0 with SMTP id
 1-20020a170902ee4100b001912181d6e0mr24566543plo.8.1672209363600; 
 Tue, 27 Dec 2022 22:36:03 -0800 (PST)
Received: from [10.72.13.7] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a170902bd8900b00186ad73e2d5sm10086583pls.208.2022.12.27.22.36.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 22:36:03 -0800 (PST)
Message-ID: <03d53bb3-49e8-4bab-176f-f76fdede885a@redhat.com>
Date: Wed, 28 Dec 2022 14:35:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
 <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
 <20221227042855-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227042855-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, maxime.coquelin@redhat.com,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzEyLzI3IDE3OjMxLCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9uIFR1
ZSwgRGVjIDI3LCAyMDIyIGF0IDA1OjE3OjIwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4+IEluIHBhcnRpY3VsYXIsIHdlIHdpbGwgYWxzbyBkaXJlY3RseSBicmVhayB0aGUgZGV2aWNl
Lgo+Pj4+IEl0J3Mga2luZCBvZiBoYXJkZW5pbmcgZm9yIG1hbGljaW91cyBkZXZpY2VzLgo+Pj4g
QVRNIG5vIGFtb3VudCBvZiBoYXJkZW5pbmcgY2FuIHByZXZlbnQgYSBtYWxpY2lvdXMgaHlwZXJ2
aXNvciBmcm9tCj4+PiBibG9ja2luZyB0aGUgZ3Vlc3QuIFJlY292ZXJpbmcgd2hlbiBhIGhhcmR3
YXJlIGRldmljZSBpcyBicm9rZW4gd291bGQgYmUKPj4+IG5pY2UgYnV0IEkgdGhpbmsgaWYgd2Ug
ZG8gYm90aGVyIHRoZW4gd2Ugc2hvdWxkIHRyeSBoYXJkZXIgdG8gcmVjb3ZlciwKPj4+IHN1Y2gg
YXMgYnkgZHJpdmluZyBkZXZpY2UgcmVzZXQuCj4+Cj4+IFByb2JhYmx5LCBidXQgYXMgZGlzY3Vz
c2VkIGluIGFub3RoZXIgdGhyZWFkLCBpdCBuZWVkcyBjby1vcGVyYXRpb24gaW4gdGhlCj4+IHVw
cGVyIGxheWVyIChuZXR3b3JraW5nIGNvcmUpLgo+IFRvIHRyYWNrIGFsbCBzdGF0ZT8gWWVhLCBt
YXliZS4gRm9yIHN1cmUgaXQncyBkb2FibGUganVzdCBpbiB2aXJ0aW8sCj4gYnV0IGlmIHlvdSBj
YW4gZmluZCAxLTIgb3RoZXIgZHJpdmVycyB0aGF0IGRvIHRoaXMgaW50ZXJuYWxseQo+IHRoZW4g
ZmFjdG9yaW5nIHRoaXMgb3V0IHRvIG5ldCBjb3JlIHdpbGwgbGlrZWx5IGJlIGFjY2VwdGVkLgoK
Ck9uZSB0aGluZyB0aGF0IG1pZ2h0IGJlIHVzZWZ1bCBpcyB0byByZXVzZSB0eF90aW1lb3V0KCkg
YnV0IGN1cnJlbnQgCnZpcnRpby1uZXQgZG9lc24ndCBkbyBtb3JlIHRoYW4gYSBzaW1wbGUgd2Fy
bmluZyAob3RoZXIgZHJpdmVycyBtYXkgdHJ5IAp0byByZXNldCkuCgpTbyBJIHdvdWxkIGxlYXZl
IGl0IGZvciBmdXR1cmUgaW52ZXN0aWdhdGlvbi4KClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

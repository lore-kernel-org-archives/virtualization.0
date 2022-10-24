Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C55C3A59D
	for <virtualization@archiver.kernel.org>; Mon, 24 Oct 2022 02:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16932813F4;
	Mon, 24 Oct 2022 02:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16932813F4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DTNZesGk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id riykFVYbaHWc; Mon, 24 Oct 2022 02:17:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A548281353;
	Mon, 24 Oct 2022 02:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A548281353
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A4A0C0032;
	Mon, 24 Oct 2022 02:17:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB47EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8295160A75
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8295160A75
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DTNZesGk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nCtjAmUFOY3W
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:17:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7217B607D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7217B607D1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Oct 2022 02:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666577858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5ejgXTPkf9QyM7vcgzmFiIJ4FUH4N8fN2CgcASFjFc=;
 b=DTNZesGkdPV7UVdADXieSEFws/gPTbkXk4OH34yfrM67gJed49Dhtcg5Vu5KH5RjEryZN1
 2cNobuMwrRw9rzPT2LaGeWtZ+43MxIuEaKgCp8abSNscOSAx/ve9fhG/Kj7z1Il5DjGDg0
 ZKyu8jfqp29gnAU5uBZPWLI/NC/QgsU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-76-25KmtqwJO32P5WAqxaqeEQ-1; Sun, 23 Oct 2022 22:17:36 -0400
X-MC-Unique: 25KmtqwJO32P5WAqxaqeEQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 i17-20020a05640242d100b0044f18a5379aso8106715edc.21
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Oct 2022 19:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5ejgXTPkf9QyM7vcgzmFiIJ4FUH4N8fN2CgcASFjFc=;
 b=NjyHtDKDh1Kn6T8RsHRYXIvJqxkMdgcgIwWnlYG2rYPGPTTha8LMq7dPDDFAPUwZzc
 9FMX9p4qn4JILNJHwav387HNDyooLPMwEilPnXfKz8kyhy//jCKjip3G2UIKF0K8Iowf
 mUwB9VmHTIU0R4SrjgjWsP0qDTzigxmz9In+2znRJvClLdl/Al0rmiwHKkD4ZNBGdkUE
 7U6go8WH+fIf5NNndvwU3rzW4EfWM/rvVfJ8rObWeDjMOf/AOCG9R3Yeyln2lr2Y36VY
 dJNVCQwNN09MMqAGtHOTNzvKupqoRmvmxH5s/JlXu0sTTAktGXA4NB5GHomMifMmVje0
 E5Yw==
X-Gm-Message-State: ACrzQf10YTXwVmxLVSpsX/C6hqhaiMuONH3NqCceyt//k38vjXGMOWmq
 N4T/BIFCRcCqKXLeu1NnCAM+2Gj9lgluPGYxjcs3V/96StXygFuM1nx3W6Zg/wZOqLcxawEP9Ba
 cPtRNouJHgxOxu4GgnJMNwRT4RoO18G8u9NCDT80o6e6Q6U+XiYYMWXaFvw==
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id
 mp31-20020a1709071b1f00b0072f56dbcce9mr24877734ejc.605.1666577855633; 
 Sun, 23 Oct 2022 19:17:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4V4+oouWykGGn8UXC6mX8Y9laaJOnj+0dXphRCw8klmWC6rlnvVSDb4GdYlsBcZV+YqjW90k9m84ED2AwLQCs=
X-Received: by 2002:a17:907:1b1f:b0:72f:56db:cce9 with SMTP id
 mp31-20020a1709071b1f00b0072f56dbcce9mr24877721ejc.605.1666577855494; Sun, 23
 Oct 2022 19:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221024015510.1917-1-angus.chen@jaguarmicro.com>
 <CACGkMEsag0xGcGxPnaou3wiO8iJBL4Pxecj6Vd-KEN7otQX5aQ@mail.gmail.com>
 <TY2PR06MB342493C73F9119E847765796852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
In-Reply-To: <TY2PR06MB342493C73F9119E847765796852E9@TY2PR06MB3424.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Oct 2022 10:17:22 +0800
Message-ID: <CACGkMEsVP8qwT5aOqvwp-YjswT59Ctu6jDfYPBftzbn_wb7ZzA@mail.gmail.com>
Subject: Re: [PATCH v2] vDPA: rename get_vq_num_max to get_vq_size_max
To: Angus Chen <angus.chen@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

T24gTW9uLCBPY3QgMjQsIDIwMjIgYXQgMTA6MTYgQU0gQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBq
YWd1YXJtaWNyby5jb20+IHdyb3RlOgo+Cj4gSGkgSmFzb24KPgo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0KPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4g
PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjQsIDIwMjIgMTA6MDEgQU0KPiA+IFRvOiBBbmd1cyBD
aGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+IENjOiBtc3RAcmVkaGF0LmNvbTsg
dmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7Cj4gPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW5nc2hhbi56aHVAaW50ZWwuY29tCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSB2RFBBOiByZW5hbWUgZ2V0X3ZxX251bV9tYXggdG8gZ2V0X3ZxX3NpemVf
bWF4Cj4gPgo+ID4gT24gTW9uLCBPY3QgMjQsIDIwMjIgYXQgOTo1NiBBTSBBbmd1cyBDaGVuIDxh
bmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+IHdyb3RlOgo+ID4gPgo+ID4gPiBUaGUgZ2V0
X3ZxX251bV9tYXggb2YgdmRwYV9jb25maWdfb3BzIGlzIG1lYW4gZ2V0IHRoZSBtYXggc2l6ZSBv
ZiB2cSxub3QKPiA+ID4gdGhlIG1heCBudW1iZXIgb2YgdnEsaXQgaXMga2luZCBvZiBjb25mdXNl
ZCxyZW5hbWUgaXQuCj4gPiA+IEFuZCBnZXRfdnFfbnVtX21pbiByZW5hbWUgdG8gZ2V0X3ZxX3Np
emVfbWluLAo+ID4gPiBzZXRfdnFfbnVtIHJlbmFtZSB0byBzZXRfdnFfc2l6ZSwKPiA+ID4gcmVu
YW1lIGltcGxlbWVudCBvZiB0aGlzIG9wcyBhbHNvLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4KPiA+ID4gLS0tCj4gPgo+
ID4gTm90IGEgbmF0aXZlIHNwYXJrZXIuIEJ1dCBudW1fbWF4IGNhbWUgZnJvbSB2aXJ0cXVldWUg
c3RydWN0dXJlOgo+ID4KPiA+IC8qCj4gPiAgLi4uCj4gPiAgKiBAbnVtX21heDogdGhlIG1heGlt
dW0gbnVtYmVyIG9mIGVsZW1lbnRzIHN1cHBvcnRlZCBieSB0aGUgZGV2aWNlLgo+ID4gIC4uLgo+
ID4gICovCj4gPgo+ID4gc3RydWN0IHZpcnRxdWV1ZSB7Cj4gPiAgICAgICAgIC4uLgo+ID4gICAg
ICAgICB1bnNpZ25lZCBpbnQgbnVtX21heDsKPiBJIG5vdGljZWQgdGhpcyBhbHNv77yMYW5kIEkg
YWx3YXlzIGNvbmZ1c2VkIGJ5IHRoZSBkZWZpbml0aW9uLiBUYWtlIHZpcnRpb19wY2lfY29tbW9u
X2NmZyBmb3IgZXhhbXBsZToKPgo+IC8qIEZpZWxkcyBpbiBWSVJUSU9fUENJX0NBUF9DT01NT05f
Q0ZHOiAqLwo+IHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ICAgICAgICAgLi4uCj4g
ICAgIF9fbGUxNiBudW1fcXVldWVzOyAgICAgIC8qIHJlYWQtb25seSAqLwo+Cj4gSXQganVzdCBh
IHN1Z2dlc3Rpb24uCj4gVGhhbmsgeW91LgoKTGV0J3MgaGVhciBmcm9tIHRoZSBvdGhlcnMgdGhl
biBkZWNpZGUuCgpUaGFua3MKCj4gPiAgICAgICAgIC4uLgo+ID4gfTsKPiA+Cj4gPiBUaGFua3MK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u

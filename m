Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC9CC4332F
	for <virtualization@archiver.kernel.org>; Wed,  1 Nov 2023 10:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D924484AA4;
	Wed,  1 Nov 2023 10:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D924484AA4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IuZA4VTz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 72HeHVT-8Mv3; Wed,  1 Nov 2023 10:44:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 63B5784AB5;
	Wed,  1 Nov 2023 10:44:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63B5784AB5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38E25C0039;
	Wed,  1 Nov 2023 10:44:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F367C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 10:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D1F97036F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 10:44:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D1F97036F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IuZA4VTz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eI80qPLbAwB8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 10:44:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60F976FBDE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Nov 2023 10:44:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60F976FBDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698835463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NM+KVWhTEC+q6McYK/U8CnEcwO0FYAak05UnunuNB8s=;
 b=IuZA4VTzAHfPOWmxWdc8Vy4u/6orP2x3Y5C8dPUeJ3ZoNCUbmS4bLCh5Ft+vuqxW3CyF/Y
 tZh4JqSlOEhqahqaHKpDOIm5wPPOxjfB7L6CdYl9MTy/s55tEz31Q42ZBL/b/KYt7EhIlH
 MVRg5mrK0Ug3YZNeqw0QYmlh266RM0I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-_JG1cQexOnSaBeGJ_WHm4w-1; Wed, 01 Nov 2023 06:44:21 -0400
X-MC-Unique: _JG1cQexOnSaBeGJ_WHm4w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9c7f0a33afbso468144866b.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Nov 2023 03:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698835461; x=1699440261;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NM+KVWhTEC+q6McYK/U8CnEcwO0FYAak05UnunuNB8s=;
 b=YSG7yZUH2JwljyUEEIVpo3ADceVKpYQy24VRUg/9nXUeD3XuEjffdjLyVIKG73pJ5O
 +o4jnoj5AZ/xjbSTX1iPiHEbUrIJx6wAx4acghkws5XU7GoTUp/88riB+SwVio5rbXJC
 4dTVNfpicOK7f89QqWgxRmyUvYiQVslGk8aL7UygoAruRVLMBGMtFbKlgi6phj6SIJ7e
 JToyx1UT1RHOT6W0cnVzyeYlryLAyxLTorKWYB0QTyQ5Cyg+EM4fac3SkewwPc0//Utk
 3Z76kwkvX2INKhBtyGRkWjc78Wg7J0dJM4GYNxRAcYfjeuDvX40bx/xjeDCoHunKpf+A
 fQXA==
X-Gm-Message-State: AOJu0YyJ5is8zEmIprXqjXJyNDrU3DTPWD/oTMFZbsk7O8OO38Cr/KuZ
 cLHNuSz4WwlP3a4NSCkVXM2W1EsXrApK8vwK0a2I87efWbIIIEJUsJazCxc/cRfcf9gIi2V+Adm
 azchgPx3JfGu0YEvySk5/OA7nr15mdpsWc6WMhNnbjw==
X-Received: by 2002:a50:d603:0:b0:53e:4762:9373 with SMTP id
 x3-20020a50d603000000b0053e47629373mr12119358edi.18.1698835460847; 
 Wed, 01 Nov 2023 03:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNJ18E3fuGGGw1XNgF2qYD2m7aCnyPEpflL1I2fxO2j1Rbq+/UI47tJgllwGtn9ne4qZUYIw==
X-Received: by 2002:a50:d603:0:b0:53e:4762:9373 with SMTP id
 x3-20020a50d603000000b0053e47629373mr12119342edi.18.1698835460477; 
 Wed, 01 Nov 2023 03:44:20 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a05640226d100b00542da55a716sm884668edd.90.2023.11.01.03.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 03:44:19 -0700 (PDT)
Date: Wed, 1 Nov 2023 06:44:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
Message-ID: <20231101064348-mutt-send-email-mst@kernel.org>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <20231025014821-mutt-send-email-mst@kernel.org>
 <707be7fa-3bb7-46c5-bb34-ef2900fe473f@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <707be7fa-3bb7-46c5-bb34-ef2900fe473f@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Liu, Yujie" <yujie.liu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBOb3YgMDEsIDIwMjMgYXQgMDU6NDA6MzBQTSArMDgwMCwgSGVuZyBRaSB3cm90ZToK
PiAKPiAKPiDlnKggMjAyMy8xMC8yNSDkuIvljYgxOjQ5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ
6YGTOgo+ID4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDM6NDQ6MDRQTSArMDgwMCwgSGVuZyBR
aSB3cm90ZToKPiA+ID4gTm93LCB2aXJ0aW8tbmV0IGFscmVhZHkgc3VwcG9ydHMgcGVyLXF1ZXVl
IG1vZGVyYXRpb24gcGFyYW1ldGVyCj4gPiA+IHNldHRpbmcuIEJhc2VkIG9uIHRoaXMsIHdlIHVz
ZSB0aGUgbmV0ZGltIGxpYnJhcnkgb2YgbGludXggdG8gc3VwcG9ydAo+ID4gPiBkeW5hbWljIGNv
YWxlc2NpbmcgbW9kZXJhdGlvbiBmb3IgdmlydGlvLW5ldC4KPiA+ID4gCj4gPiA+IER1ZSB0byBo
YXJkd2FyZSBzY2hlZHVsaW5nIGlzc3Vlcywgd2Ugb25seSB0ZXN0ZWQgcnggZGltLgo+ID4gU28g
cGF0Y2hlcyAxIHRvIDQgbG9vayBvayBidXQgcGF0Y2ggNSBpcyB1bnRlc3RlZCAtIHdlIHNob3Vs
ZAo+ID4gcHJvYmFibHkgd2FpdCB1bnRpbCBpdCdzIHRlc3RlZCBwcm9wZXJseS4KPiAKPiBIaSwg
TWljaGFlbC4KPiAKPiBGb3IgYSBmZXcgcmVhc29ucyAocmVwbHkgdG8gSmFzb24ncyB0aHJlYWQp
LCBJIHdvbid0IGJlIHRyeWluZyB0byBwdXNoIHR4Cj4gZGltIGFueSBtb3JlIGluIHRoZSBzaG9y
dCB0ZXJtLgo+IAo+IFBsZWFzZSByZXZpZXcgdGhlIHJlbWFpbmluZyBwYXRjaGVzLgo+IAo+IFRo
YW5rcyBhIGxvdCEKCgpZb3UgZ290IGEgYnVuY2ggb2YgY29tbWVudHMgZnJvbSBKYXNvbiAtIHdh
bnQgdG8gYWRkcmVzcyB0aGVtCmluIGEgbmV3IHZlcnNpb24gdGhlbiwgYW5kIEknbGwgcmV2aWV3
IHRoYXQ/Cgo+ID4gCj4gPiAKPiA+ID4gQFRlc3QgZW52Cj4gPiA+IHJ4cTAgaGFzIGFmZmluaXR5
IHRvIGNwdTAuCj4gPiA+IAo+ID4gPiBAVGVzdCBjbWQKPiA+ID4gY2xpZW50OiB0YXNrc2V0IC1j
IDAgc29ja3BlcmYgdHAgLWkgJHtJUH0gLXQgMzAgLS10Y3AgLW0gJHttc2dfc2l6ZX0KPiA+ID4g
c2VydmVyOiB0YXNrc2V0IC1jIDAgc29ja3BlcmYgc3IgLS10Y3AKPiA+ID4gCj4gPiA+IEBUZXN0
IHJlcwo+ID4gPiBUaGUgc2Vjb25kIGNvbHVtbiBpcyB0aGUgcmF0aW8gb2YgdGhlIHJlc3VsdCBy
ZXR1cm5lZCBieSBjbGllbnQKPiA+ID4gd2hlbiByeCBkaW0gaXMgZW5hYmxlZCB0byB0aGUgcmVz
dWx0IHJldHVybmVkIGJ5IGNsaWVudCB3aGVuCj4gPiA+IHJ4IGRpbSBpcyBkaXNhYmxlZC4KPiA+
ID4gCS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+IAl8IG1zZ19z
aXplIHwgIHJ4X2RpbT1vbiAvIHJ4X2RpbT1vZmYgfAo+ID4gPiAJLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gCXwgICAxNEIgICAgfCAgICAgICAgICsgMyUgICAg
ICAgICAgICB8Cj4gPiA+IAktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
ID4gPiAJfCAgIDEwMEIgICB8ICAgICAgICAgKyAxNiUgICAgICAgICAgIHwKPiA+ID4gCS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+IAl8ICAgNTAwQiAgIHwgICAg
ICAgICArIDI1JSAgICAgICAgICAgfAo+ID4gPiAJLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiA+ID4gCXwgICAxNDAwQiAgfCAgICAgICAgICsgMjglICAgICAgICAgICB8
Cj4gPiA+IAktLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAJfCAg
IDIwNDhCICB8ICAgICAgICAgKyAyMiUgICAgICAgICAgIHwKPiA+ID4gCS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiA+IAl8ICAgNDA5NkIgIHwgICAgICAgICArIDUl
ICAgICAgICAgICAgfAo+ID4gPiAJLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KPiA+ID4gCj4gPiA+IC0tLQo+ID4gPiBUaGlzIHBhdGNoIHNldCB3YXMgcGFydCBvZiB0aGUg
cHJldmlvdXMgbmV0ZGltIHBhdGNoIHNldFsxXS4KPiA+ID4gWzFdIHdhcyBzcGxpdCBpbnRvIGEg
bWVyZ2VkIGJ1Z2ZpeCBzZXRbMl0gYW5kIHRoZSBjdXJyZW50IHNldC4KPiA+ID4gVGhlIHByZXZp
b3VzIHJlbGV2YW50IGNvbW1lbnRhdG9ycyBoYXZlIGJlZW4gQ2NlZC4KPiA+ID4gCj4gPiA+IFsx
XSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4MTEwNjU1MTIuMjIxOTAtMS1oZW5n
cWlAbGludXguYWxpYmFiYS5jb20vCj4gPiA+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvY292ZXIuMTY5Njc0NTQ1Mi5naXQuaGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tLwo+ID4gPiAK
PiA+ID4gSGVuZyBRaSAoNSk6Cj4gPiA+ICAgIHZpcnRpby1uZXQ6IHJldHVybnMgd2hldGhlciBu
YXBpIGlzIGNvbXBsZXRlCj4gPiA+ICAgIHZpcnRpby1uZXQ6IHNlcGFyYXRlIHJ4L3R4IGNvYWxl
c2NpbmcgbW9kZXJhdGlvbiBjbWRzCj4gPiA+ICAgIHZpcnRpby1uZXQ6IGV4dHJhY3QgdmlydHF1
ZXVlIGNvYWxlc2NpZyBjbWQgZm9yIHJldXNlCj4gPiA+ICAgIHZpcnRpby1uZXQ6IHN1cHBvcnQg
cnggbmV0ZGltCj4gPiA+ICAgIHZpcnRpby1uZXQ6IHN1cHBvcnQgdHggbmV0ZGltCj4gPiA+IAo+
ID4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDM5NCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzIyIGluc2VydGlv
bnMoKyksIDcyIGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gLS0gCj4gPiA+IDIuMTkuMS42Lmdi
NDg1NzEwYgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

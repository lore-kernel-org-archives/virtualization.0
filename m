Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95247C7EE23
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 10:30:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2197B41793;
	Mon,  8 May 2023 10:30:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2197B41793
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=drUTJiB1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNuG8SOb4wPl; Mon,  8 May 2023 10:30:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B9674175E;
	Mon,  8 May 2023 10:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B9674175E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2EF5C0036;
	Mon,  8 May 2023 10:30:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92C1AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 660EC4175E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:30:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 660EC4175E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eu3uVnC9br8d
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 00944416FC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 00944416FC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683541816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPsu5YVFrEenCLv+iZuaZj4Zmadv4HGEz/gE1xJGp6I=;
 b=drUTJiB1n3DLo5YemSOacZmi7dmMWEFhRFEpjOdQpjCrYNxPfjsjImqFlnuHBt6nxZAauP
 QdpE6PtLYlDDoX4Oqz1Df7aPTtUCYmwg4Aw/OdE/h5tIUHkfsszHCaOAfwjFrl1M+q7gKE
 ef6l0JX7REoyuopX8Ao803fco2P/ym0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-4h7q_cKyPai1c5mKxofEAg-1; Mon, 08 May 2023 06:30:14 -0400
X-MC-Unique: 4h7q_cKyPai1c5mKxofEAg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-306286b3573so2681690f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 May 2023 03:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683541813; x=1686133813;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xPsu5YVFrEenCLv+iZuaZj4Zmadv4HGEz/gE1xJGp6I=;
 b=eOK+OhRijjEZJfQItGwJDuCjXMQcvdcPTZZQ4HpqQ48s7gwIKC/8tElz4LqP1UD42I
 DU7D76vqsajrXVtzHv1zlZzJoBaCm3XO2CijeZfrHddgd7JA1BipHUInbN/3l2Tjau/d
 2h4r41HMXzsSO+zez5YjADbkLVx9LMlqmD+o8almH7oy7nmMl0obzhfw0KiKuXrey4c5
 sAbwiAQX6U+0/Ur/q8Tq5PjZ17nLFVUCpFynkobJSk5uCG6Jwu+boT03peP7Buw49IzI
 pw3QOOvvDSRrbWhtxmu6mPJIPjxB5+553KdbFVMju55+bw8XIIgnfmrlQOhQnPs5v60a
 +xBw==
X-Gm-Message-State: AC+VfDxA05n3nGt5A3ohSN0t7yjgfSwMYAZS6nLGk0+uz/NIp7KO8fcm
 TrSI+EGFeeXXUkzUfZ07WF0M0slqEORjgpeow2E6xJcxodbVfPkHfiMmS65X4mmUdU1xYQxXsWW
 q+ysXTxH6QLhURR78dJKp2z/UMLLgjW1yc+8n+w3weQ==
X-Received: by 2002:adf:e943:0:b0:306:2cf5:79dc with SMTP id
 m3-20020adfe943000000b003062cf579dcmr7718613wrn.35.1683541813557; 
 Mon, 08 May 2023 03:30:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ykEugQ/sjlWtVtf+RWhyd+Wdn5biO6WeKJ/H0kdlQUIkECfX6aLaJNv/UFBtqbWwQjfrirw==
X-Received: by 2002:adf:e943:0:b0:306:2cf5:79dc with SMTP id
 m3-20020adfe943000000b003062cf579dcmr7718591wrn.35.1683541813164; 
 Mon, 08 May 2023 03:30:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.15]) by smtp.gmail.com with ESMTPSA id
 h14-20020a5d6e0e000000b0030631dcbea6sm10959097wrz.77.2023.05.08.03.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 May 2023 03:30:12 -0700 (PDT)
Date: Mon, 8 May 2023 06:30:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230508062928-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
 <20230508020953-mutt-send-email-mst@kernel.org>
 <1683526688.7492425-1-xuanzhuo@linux.alibaba.com>
 <20230508024147-mutt-send-email-mst@kernel.org>
 <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: zy@yusur.tech, Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, hengqi@linux.alibaba.com,
 huangml@yusur.tech, Jakub Kicinski <kuba@kernel.org>,
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

T24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMDM6NDE6NTZQTSArMDgwMCwgWHVhbiBaaHVvIHdyb3Rl
Ogo+IE9uIE1vbiwgOCBNYXkgMjAyMyAwMjo0MzoyNCAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtp
biIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+IE9uIE1vbiwgTWF5IDA4LCAyMDIzIGF0IDAy
OjE4OjA4UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gT24gTW9uLCA4IE1heSAyMDIz
IDAyOjE1OjQ2IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+IHdy
b3RlOgo+ID4gPiA+IE9uIE1vbiwgTWF5IDA4LCAyMDIzIGF0IDEwOjAxOjU5QU0gKzA4MDAsIFh1
YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+IE9uIFN1biwgNyBNYXkgMjAyMyAwNDo1ODo1OCAtMDQw
MCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4gT24gU2F0LCBNYXkgMDYsIDIwMjMgYXQgMDQ6NTY6MzVQTSArMDgwMCwgSGFvIENoZW4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IOWcqCAyMDIzLzUv
NiAxMDo1MCwgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+IE9uIFNhdCwgIDYgTWF5
IDIwMjMgMTA6MTU6MjkgKzA4MDAsIEhhbyBDaGVuIDxjaGVuaEB5dXN1ci50ZWNoPiB3cm90ZToK
PiA+ID4gPiA+ID4gPiA+ID4gV2hlbiBWSVJUSU9fTkVUX0ZfTVRVKDMpIERldmljZSBtYXhpbXVt
IE1UVSByZXBvcnRpbmcgaXMgc3VwcG9ydGVkLgo+ID4gPiA+ID4gPiA+ID4gPiBJZiBvZmZlcmVk
IGJ5IHRoZSBkZXZpY2UsIGRldmljZSBhZHZpc2VzIGRyaXZlciBhYm91dCB0aGUgdmFsdWUgb2Yg
aXRzCj4gPiA+ID4gPiA+ID4gPiA+IG1heGltdW0gTVRVLiBJZiBuZWdvdGlhdGVkLCB0aGUgZHJp
dmVyIHVzZXMgbXR1IGFzIHRoZSBtYXhpbXVtCj4gPiA+ID4gPiA+ID4gPiA+IE1UVSB2YWx1ZS4g
QnV0IHRoZXJlIHRoZSBkcml2ZXIgYWxzbyB1c2VzIGl0IGFzIGRlZmF1bHQgbXR1LAo+ID4gPiA+
ID4gPiA+ID4gPiBzb21lIGRldmljZXMgbWF5IGhhdmUgYSBtYXhpbXVtIE1UVSBncmVhdGVyIHRo
YW4gMTUwMCwgdGhpcyBtYXkKPiA+ID4gPiA+ID4gPiA+ID4gY2F1c2Ugc29tZSBsYXJnZSBwYWNr
YWdlcyB0byBiZSBkaXNjYXJkZWQsCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gWW91
IG1lYW4gdHggcGFja2V0Pwo+ID4gPiA+ID4gPiA+IFllcy4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiBJZiB5ZXMsIEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgdGhlIHByb2JsZW0gb2Yg
ZHJpdmVyLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IE1heWJlIHlvdSBzaG91bGQg
Z2l2ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIGRpc2NhcmQuCj4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IEluIHRoZSBjdXJyZW50IGNvZGUsIGlmIHRoZSBtYXhpbXVtIE1UVSBzdXBwb3J0
ZWQgYnkgdGhlIHZpcnRpbyBuZXQgaGFyZHdhcmUKPiA+ID4gPiA+ID4gPiBpcyA5MDAwLCB0aGUg
ZGVmYXVsdCBNVFUgb2YgdGhlIHZpcnRpbyBuZXQgZHJpdmVyIHdpbGwgYWxzbyBiZSBzZXQgdG8g
OTAwMC4KPiA+ID4gPiA+ID4gPiBXaGVuIHNlbmRpbmcgcGFja2V0cyB0aHJvdWdoICJwaW5nIC1z
IDUwMDAiLCBpZiB0aGUgcGVlciByb3V0ZXIgZG9lcyBub3QKPiA+ID4gPiA+ID4gPiBzdXBwb3J0
IG5lZ290aWF0aW5nIGEgcGF0aCBNVFUgdGhyb3VnaCBJQ01QIHBhY2tldHMsIHRoZSBwYWNrZXRz
IHdpbGwgYmUKPiA+ID4gPiA+ID4gPiBkaXNjYXJkZWQuIElmIHRoZSBwZWVyIHJvdXRlciBzdXBw
b3J0cyBuZWdvdGlhdGluZyBwYXRoIG10dSB0aHJvdWdoIElDTVAKPiA+ID4gPiA+ID4gPiBwYWNr
ZXRzLCB0aGUgaG9zdCBzaWRlIHdpbGwgcGVyZm9ybSBwYWNrZXQgc2hhcmRpbmcgcHJvY2Vzc2lu
ZyBiYXNlZCBvbiB0aGUKPiA+ID4gPiA+ID4gPiBuZWdvdGlhdGVkIHBhdGggbXR1LCB3aGljaCBp
cyBnZW5lcmFsbHkgd2l0aGluIDE1MDAuCj4gPiA+ID4gPiA+ID4gVGhpcyBpcyBub3QgYSBidWdm
aXggcGF0Y2gsIEkgdGhpbmsgc2V0dGluZyB0aGUgZGVmYXVsdCBtdHUgdG8gd2l0aGluIDE1MDAK
PiA+ID4gPiA+ID4gPiB3b3VsZCBiZSBtb3JlIHN1aXRhYmxlIGhlcmUuVGhhbmtzLgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiBJIGRvbid0IHRoaW5rIFZJUlRJT19ORVRfRl9NVFUgaXMgYXBwcm9w
cmlhdGUgZm9yIHN1cHBvcnQgZm9yIGp1bWJvIHBhY2tldHMuCj4gPiA+ID4gPiA+IFRoZSBzcGVj
IHNheXM6Cj4gPiA+ID4gPiA+IAlUaGUgZGV2aWNlIE1VU1QgZm9yd2FyZCB0cmFuc21pdHRlZCBw
YWNrZXRzIG9mIHVwIHRvIG10dSAocGx1cyBsb3cgbGV2ZWwgZXRoZXJuZXQgaGVhZGVyIGxlbmd0
aCkgc2l6ZSB3aXRoCj4gPiA+ID4gPiA+IAlnc29fdHlwZSBOT05FIG9yIEVDTiwgYW5kIGRvIHNv
IHdpdGhvdXQgZnJhZ21lbnRhdGlvbiwgYWZ0ZXIgVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBz
dWNjZXNzLQo+ID4gPiA+ID4gPiAJZnVsbHkgbmVnb3RpYXRlZC4KPiA+ID4gPiA+ID4gVklSVElP
X05FVF9GX01UVSBoYXMgYmVlbiBkZXNpZ25lZCBmb3IgYWxsIGtpbmQgb2YgdHVubmVsaW5nIGRl
dmljZXMsCj4gPiA+ID4gPiA+IGFuZCB0aGlzIGlzIHdoeSB3ZSBzZXQgbXR1IHRvIG1heCBieSBk
ZWZhdWx0Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBGb3IgdGhpbmdzIGxpa2UganVtYm8gZnJh
bWVzIHdoZXJlIE1UVSBtaWdodCBvciBtaWdodCBub3QgYmUgYXZhaWxhYmxlLAo+ID4gPiA+ID4g
PiBhIG5ldyBmZWF0dXJlIHdvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuCj4gPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPiA+IFNvIGZvciBqdW1ibyBmcmFtZSwgd2hhdCBpcyB0aGUgcHJvYmxlbT8K
PiA+ID4gPiA+Cj4gPiA+ID4gPiBXZSBhcmUgdHJ5aW5nIHRvIGRvIHRoaXMuIEBIZW5nCj4gPiA+
ID4gPgo+ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+ID4gSXQgaXMgbm90IGEgcHJvYmxl
bSBhcyBzdWNoLiBCdXQgVklSVElPX05FVF9GX01UVSB3aWxsIHNldCB0aGUKPiA+ID4gPiBkZWZh
dWx0IE1UVSBub3QganVzdCB0aGUgbWF4aW11bSBvbmUsIGJlY2F1c2Ugc3BlYyBzZWVtcyB0bwo+
ID4gPiA+IHNheSBpdCBjYW4uCj4gPiA+Cj4gPiA+IEkgc2VlLgo+ID4gPgo+ID4gPiBJbiB0aGUg
Y2FzZSBvZiBKdW1ibyBGcmFtZSwgd2UgYWxzbyBob3BlIHRoYXQgdGhlIGRyaXZlciB3aWxsIHNl
dCB0aGUgZGVmYXVsdAo+ID4gPiBkaXJlY3RseSB0byB0aGUgbWF4IG10dS4gSnVzdCBsaWtlIHdo
YXQgeW91IHNhaWQgIkJpZ2dlciBwYWNrZXRzID0gYmV0dGVyCj4gPiA+IHBlcmZvcm1hbmNlLiIK
PiA+ID4KPiA+ID4gSSBkb24ndCBrbm93LCBpbiBhbnkgc2NlbmFyaW8sIHdoZW4gdGhlIGhhcmR3
YXJlIHN1cHBvcnRzIGEgbGFyZ2UgbXR1LCBidXQgd2UgZG8KPiA+ID4gbm90IHdhbnQgdGhlIHVz
ZXIgdG8gdXNlIGl0IGJ5IGRlZmF1bHQuCj4gPgo+ID4gV2hlbiBvdGhlciBkZXZpY2VzIG9uIHRo
ZSBzYW1lIExBTiBoYXZlIG10dSBzZXQgdG8gMTUwMCBhbmQKPiA+IHdvbid0IGFjY2VwdCBiaWdn
ZXIgcGFja2V0cy4KPiAKPiBTbywgdGhhdCBkZXBlbmRzIG9uIHBtdHUvdGNwLXByb2JlLW10dS4K
PiAKPiBJZiB0aGUgb3Mgd2l0aG91dCBwbXR1L3RjcC1wcm9iZS1tdHUgaGFzIGEgYmlnZ2VyIG10
dSwgdGhlbiBpdCdzIGJpZyBwYWNrZXQKPiB3aWxsIGxvc3QuCj4gCj4gVGhhbmtzLgo+IAoKcG10
dSBpcyBkZXNpZ25lZCBmb3Igcm91dGluZy4gTEFOIGlzIHN1cHBvc2VkIHRvIGJlIGNvbmZpZ3Vy
ZWQgd2l0aAphIGNvbnNpc3RlbnQgTVRVLgoKPiA+Cj4gPiA+IE9mIGNvdXJzZSwgdGhlIHNjZW5l
IHRoYXQgdGhpcyBwYXRjaAo+ID4gPiB3YW50cyB0byBoYW5kbGUgZG9lcyBleGlzdCwgYnV0IEkg
aGF2ZSBuZXZlciB0aG91Z2h0IHRoYXQgdGhpcyBpcyBhIHByb2JsZW0gYXQKPiA+ID4gdGhlIGRy
aXZlciBsZXZlbC4KPiA+ID4KPiA+ID4gVGhhbmtzLgo+ID4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IHNvIEkgY2hhbmdlZCB0
aGUgTVRVIHRvIGEgbW9yZQo+ID4gPiA+ID4gPiA+ID4gPiBnZW5lcmFsIDE1MDAgd2hlbiAnRGV2
aWNlIG1heGltdW0gTVRVJyBiaWdnZXIgdGhhbiAxNTAwLgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIYW8gQ2hlbiA8Y2hlbmhAeXVzdXIudGVjaD4K
PiA+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiA+ICAgZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jIHwgNSArKysrLQo+ID4gPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gPiA+ID4gPiA+ID4gPiBpbmRleCA4ZDgwMzg1MzhmYzQuLmU3
MWM3ZDFiNWYyOSAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+ID4gPiA+ID4gPiA+ID4gPiBAQCAtNDA0MCw3ICs0MDQwLDEwIEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4gPiA+ID4gPiA+ID4g
ICAJCQlnb3RvIGZyZWU7Cj4gPiA+ID4gPiA+ID4gPiA+ICAgCQl9Cj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+IC0JCWRldi0+bXR1ID0gbXR1Owo+ID4gPiA+ID4gPiA+ID4gPiAr
CQlpZiAobXR1ID4gMTUwMCkKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBzLzE1MDAv
RVRIX0RBVEFfTEVOLwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoYW5rcy4KPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ICsJCQlkZXYtPm10dSA9IDE1MDA7Cj4gPiA+
ID4gPiA+ID4gPiA+ICsJCWVsc2UKPiA+ID4gPiA+ID4gPiA+ID4gKwkJCWRldi0+bXR1ID0gbXR1
Owo+ID4gPiA+ID4gPiA+ID4gPiAgIAkJZGV2LT5tYXhfbXR1ID0gbXR1Owo+ID4gPiA+ID4gPiA+
ID4gPiAgIAl9Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiA+ID4gPiA+IDIuMjcuMAo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+Cj4g
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u

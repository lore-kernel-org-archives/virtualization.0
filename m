Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F70C77B7C
	for <virtualization@archiver.kernel.org>; Sun,  7 May 2023 08:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B315610FC;
	Sun,  7 May 2023 08:59:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B315610FC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlCOsEfk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uHTMbi2sq85Z; Sun,  7 May 2023 08:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F099E60F21;
	Sun,  7 May 2023 08:59:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F099E60F21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD7CEC0037;
	Sun,  7 May 2023 08:59:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46138C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 08:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0C70181464
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 08:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C70181464
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MlCOsEfk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NWci6JLBpb_k
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 08:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F7668145C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F7668145C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 08:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683449945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeeGTjp1K1OeCb3ZIEFft75WO1ELEw08OZwAFoljYwY=;
 b=MlCOsEfktIlfqWuKVQsf7MPlkA5KlLOAmzkznToc6T7l7a3wAbG7HXbcLVQqLU/KkXspiZ
 HbBLwnAXkNZJ6iES6y+DM5hKxZBoxUVHz1tCVIWO+/MliC45qtsz9tLCChvpndzct+AMwu
 ld8Po6og3reXRX8u4akSWwGC0HITbpQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-ofZN8bYFNUGooyZy7IDDjw-1; Sun, 07 May 2023 04:59:04 -0400
X-MC-Unique: ofZN8bYFNUGooyZy7IDDjw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f21e35dc08so13882275e9.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 01:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683449943; x=1686041943;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yeeGTjp1K1OeCb3ZIEFft75WO1ELEw08OZwAFoljYwY=;
 b=MeC9AwId0Ttck8kpaaaLVvJJuSfYgoWBAnk0sOu3v7+g01dKYBPxJCjtGS8Kjlo+YA
 3CfRc9PAakxPUgugzPi4KcocczTYN+DWuiaeJxfhYGNBSDWEBcc5aaDvP+idnVJlmcri
 FVpng5hDZLH1ELiXAY8J92Sdcdeuw8f4LgS8NmzpOw8//mgfLOC9ELGUiBFm6denaELn
 qC6Ol9u881p/51tFyYZ8oZpZr4Z1guGOVY5fRSfDc442rkNkGqW7m67nBkNGHuON27k9
 vkUYskQO3P3/v09eSq2P21PPUS9VEbVdOcxDFMMOaD4zICCatRR2tTW6Vx1ln6Li21OS
 /8eg==
X-Gm-Message-State: AC+VfDxSa3SNXGZSrLwPYjFC9+9tRq445jRQjDsuMN6dfRHEI1zdZ012
 CaOp6TLvDdojYLrE/qz/n1sGEdPd1pKeBiB1cEOCw9AvDPaKdkg1CcC9G1qogDsaSNIin82YGby
 NEAiBK63m7FxfK91t9tg1xyEkyxbFRz5Wds3tEkLikg==
X-Received: by 2002:a05:600c:b4b:b0:3f2:73a:32fc with SMTP id
 k11-20020a05600c0b4b00b003f2073a32fcmr4521786wmr.32.1683449943590; 
 Sun, 07 May 2023 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7a9eutfAfd8aF4Cg4js80tavVGTVSzB9sy+7qygN//4rj17mi5XdK64Z91HAiqV/PL3Wlj8A==
X-Received: by 2002:a05:600c:b4b:b0:3f2:73a:32fc with SMTP id
 k11-20020a05600c0b4b00b003f2073a32fcmr4521773wmr.32.1683449943324; 
 Sun, 07 May 2023 01:59:03 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 e19-20020a05600c219300b003f173419e7asm12993148wme.43.2023.05.07.01.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 01:59:02 -0700 (PDT)
Date: Sun, 7 May 2023 04:58:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hao Chen <chenh@yusur.tech>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230507045627-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
MIME-Version: 1.0
In-Reply-To: <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, zy@yusur.tech,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, huangml@yusur.tech,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU2F0LCBNYXkgMDYsIDIwMjMgYXQgMDQ6NTY6MzVQTSArMDgwMCwgSGFvIENoZW4gd3JvdGU6
Cj4gCj4gCj4g5ZyoIDIwMjMvNS82IDEwOjUwLCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gT24gU2F0
LCAgNiBNYXkgMjAyMyAxMDoxNToyOSArMDgwMCwgSGFvIENoZW4gPGNoZW5oQHl1c3VyLnRlY2g+
IHdyb3RlOgo+ID4gPiBXaGVuIFZJUlRJT19ORVRfRl9NVFUoMykgRGV2aWNlIG1heGltdW0gTVRV
IHJlcG9ydGluZyBpcyBzdXBwb3J0ZWQuCj4gPiA+IElmIG9mZmVyZWQgYnkgdGhlIGRldmljZSwg
ZGV2aWNlIGFkdmlzZXMgZHJpdmVyIGFib3V0IHRoZSB2YWx1ZSBvZiBpdHMKPiA+ID4gbWF4aW11
bSBNVFUuIElmIG5lZ290aWF0ZWQsIHRoZSBkcml2ZXIgdXNlcyBtdHUgYXMgdGhlIG1heGltdW0K
PiA+ID4gTVRVIHZhbHVlLiBCdXQgdGhlcmUgdGhlIGRyaXZlciBhbHNvIHVzZXMgaXQgYXMgZGVm
YXVsdCBtdHUsCj4gPiA+IHNvbWUgZGV2aWNlcyBtYXkgaGF2ZSBhIG1heGltdW0gTVRVIGdyZWF0
ZXIgdGhhbiAxNTAwLCB0aGlzIG1heQo+ID4gPiBjYXVzZSBzb21lIGxhcmdlIHBhY2thZ2VzIHRv
IGJlIGRpc2NhcmRlZCwKPiA+IAo+ID4gWW91IG1lYW4gdHggcGFja2V0Pwo+IFllcy4KPiA+IAo+
ID4gSWYgeWVzLCBJIGRvIG5vdCB0aGluayB0aGlzIGlzIHRoZSBwcm9ibGVtIG9mIGRyaXZlci4K
PiA+IAo+ID4gTWF5YmUgeW91IHNob3VsZCBnaXZlIG1vcmUgZGV0YWlscyBhYm91dCB0aGUgZGlz
Y2FyZC4KPiA+IAo+IEluIHRoZSBjdXJyZW50IGNvZGUsIGlmIHRoZSBtYXhpbXVtIE1UVSBzdXBw
b3J0ZWQgYnkgdGhlIHZpcnRpbyBuZXQgaGFyZHdhcmUKPiBpcyA5MDAwLCB0aGUgZGVmYXVsdCBN
VFUgb2YgdGhlIHZpcnRpbyBuZXQgZHJpdmVyIHdpbGwgYWxzbyBiZSBzZXQgdG8gOTAwMC4KPiBX
aGVuIHNlbmRpbmcgcGFja2V0cyB0aHJvdWdoICJwaW5nIC1zIDUwMDAiLCBpZiB0aGUgcGVlciBy
b3V0ZXIgZG9lcyBub3QKPiBzdXBwb3J0IG5lZ290aWF0aW5nIGEgcGF0aCBNVFUgdGhyb3VnaCBJ
Q01QIHBhY2tldHMsIHRoZSBwYWNrZXRzIHdpbGwgYmUKPiBkaXNjYXJkZWQuIElmIHRoZSBwZWVy
IHJvdXRlciBzdXBwb3J0cyBuZWdvdGlhdGluZyBwYXRoIG10dSB0aHJvdWdoIElDTVAKPiBwYWNr
ZXRzLCB0aGUgaG9zdCBzaWRlIHdpbGwgcGVyZm9ybSBwYWNrZXQgc2hhcmRpbmcgcHJvY2Vzc2lu
ZyBiYXNlZCBvbiB0aGUKPiBuZWdvdGlhdGVkIHBhdGggbXR1LCB3aGljaCBpcyBnZW5lcmFsbHkg
d2l0aGluIDE1MDAuCj4gVGhpcyBpcyBub3QgYSBidWdmaXggcGF0Y2gsIEkgdGhpbmsgc2V0dGlu
ZyB0aGUgZGVmYXVsdCBtdHUgdG8gd2l0aGluIDE1MDAKPiB3b3VsZCBiZSBtb3JlIHN1aXRhYmxl
IGhlcmUuVGhhbmtzLgoKSSBkb24ndCB0aGluayBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFwcHJvcHJp
YXRlIGZvciBzdXBwb3J0IGZvciBqdW1ibyBwYWNrZXRzLgpUaGUgc3BlYyBzYXlzOgoJVGhlIGRl
dmljZSBNVVNUIGZvcndhcmQgdHJhbnNtaXR0ZWQgcGFja2V0cyBvZiB1cCB0byBtdHUgKHBsdXMg
bG93IGxldmVsIGV0aGVybmV0IGhlYWRlciBsZW5ndGgpIHNpemUgd2l0aAoJZ3NvX3R5cGUgTk9O
RSBvciBFQ04sIGFuZCBkbyBzbyB3aXRob3V0IGZyYWdtZW50YXRpb24sIGFmdGVyIFZJUlRJT19O
RVRfRl9NVFUgaGFzIGJlZW4gc3VjY2Vzcy0KCWZ1bGx5IG5lZ290aWF0ZWQuClZJUlRJT19ORVRf
Rl9NVFUgaGFzIGJlZW4gZGVzaWduZWQgZm9yIGFsbCBraW5kIG9mIHR1bm5lbGluZyBkZXZpY2Vz
LAphbmQgdGhpcyBpcyB3aHkgd2Ugc2V0IG10dSB0byBtYXggYnkgZGVmYXVsdC4KCkZvciB0aGlu
Z3MgbGlrZSBqdW1ibyBmcmFtZXMgd2hlcmUgTVRVIG1pZ2h0IG9yIG1pZ2h0IG5vdCBiZSBhdmFp
bGFibGUsCmEgbmV3IGZlYXR1cmUgd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZS4KCj4gPiA+IHNv
IEkgY2hhbmdlZCB0aGUgTVRVIHRvIGEgbW9yZQo+ID4gPiBnZW5lcmFsIDE1MDAgd2hlbiAnRGV2
aWNlIG1heGltdW0gTVRVJyBiaWdnZXIgdGhhbiAxNTAwLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSGFvIENoZW4gPGNoZW5oQHl1c3VyLnRlY2g+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUgKysrKy0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGlu
ZGV4IDhkODAzODUzOGZjNC4uZTcxYzdkMWI1ZjI5IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4g
PiA+IEBAIC00MDQwLDcgKzQwNDAsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3Byb2JlKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAgIAkJCWdvdG8gZnJlZTsKPiA+ID4gICAJCX0K
PiA+ID4gCj4gPiA+IC0JCWRldi0+bXR1ID0gbXR1Owo+ID4gPiArCQlpZiAobXR1ID4gMTUwMCkK
PiA+IAo+ID4gcy8xNTAwL0VUSF9EQVRBX0xFTi8KPiA+IAo+ID4gVGhhbmtzLgo+ID4gCj4gPiA+
ICsJCQlkZXYtPm10dSA9IDE1MDA7Cj4gPiA+ICsJCWVsc2UKPiA+ID4gKwkJCWRldi0+bXR1ID0g
bXR1Owo+ID4gPiAgIAkJZGV2LT5tYXhfbXR1ID0gbXR1Owo+ID4gPiAgIAl9Cj4gPiA+IAo+ID4g
PiAtLQo+ID4gPiAyLjI3LjAKPiA+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

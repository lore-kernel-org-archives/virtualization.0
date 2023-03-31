Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAC9C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 09:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9750441FD2;
	Fri, 31 Mar 2023 09:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9750441FD2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ryz4IHjn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BeWBrQl_YdGc; Fri, 31 Mar 2023 09:14:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D69E140207;
	Fri, 31 Mar 2023 09:14:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D69E140207
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9E64C0036;
	Fri, 31 Mar 2023 09:14:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F9B1C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E186616C8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:14:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E186616C8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ryz4IHjn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Np_yJIUb_mk5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 16A2F6001B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 16A2F6001B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680254085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JS/osSA5h7igfJZxqOSBjqf6v2ujYGgr3ycuj9xUb4=;
 b=Ryz4IHjnYl+W5w47S3fnHyX+AAs2/zK51aq3UqlPwkFTXAk+P40PpWL+KYskbjVz+PSPF6
 tDJ0c7U3+ALKqM9Pdwow9/HxICflDAdjS0ghEN1Yfh1HFjZ/9uYGg7a4hmLxivKkLW257D
 MYY/fbH1wC22A5A5l5TIxKYp3g1AEeQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-bZlBD89EM-SQQf4ALPF8DA-1; Fri, 31 Mar 2023 05:14:42 -0400
X-MC-Unique: bZlBD89EM-SQQf4ALPF8DA-1
Received: by mail-pl1-f200.google.com with SMTP id
 n13-20020a170902d2cd00b001a22d27406bso10991349plc.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 02:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680254081; x=1682846081;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/JS/osSA5h7igfJZxqOSBjqf6v2ujYGgr3ycuj9xUb4=;
 b=04Hhy6psKmTPBF3on5K9IfM4NSoWk6eNkPwuLnkBWTuVPDkKU6vASYIe8j2S/58k3C
 Bo2HFY0eXmKwBfHUGzOVy2BAzW+i08LHD3Qq1vxiJD7WVjEibB6UbzGZtrZXOmsgbMcn
 Ip3/PjVMnk+jrZwMBI6wbX+W1wPYopg9aNYz9Y9aeVq4Xl91nSrOINfk05SBwGvDPlRa
 ok+rSKPNKei/U0zn4yS/+32eAP5+Izugl2jiTLq3+GAZeQ4ontk/Jf5J35d7Ov5NSCb3
 n5i+XDylNi4nLCqUcYKScOVZjcZzlAEjUWK2dYNSMKv3w/Lbg5QRxVZVF9R12XnMGSxS
 KGyQ==
X-Gm-Message-State: AAQBX9dwcfZfGR2qcvI2qr7D2htnmvTFLVJxSTiiiEBdZU7HgWBdp3iA
 VbfM21G44/aaQYxffi3hs+MqvPVExBOmuXZDLvwKN/GyufkYTaAqLSgbFSUsFE3BfhH0zdQQaeg
 xi9EAiD1Tc0n2V3Dxts+FLkBAETIejwkwPX7WzpX/Mw==
X-Received: by 2002:a17:90b:1d09:b0:240:5397:bd91 with SMTP id
 on9-20020a17090b1d0900b002405397bd91mr29295203pjb.4.1680254081363; 
 Fri, 31 Mar 2023 02:14:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350azVcu+SuzZYBuZrGYsfh+gJoBAdGdFAR0ZndpXH0PoLcS0dzSktKrdCcUjh9hiMfgdfnHQVw==
X-Received: by 2002:a17:90b:1d09:b0:240:5397:bd91 with SMTP id
 on9-20020a17090b1d0900b002405397bd91mr29295183pjb.4.1680254081048; 
 Fri, 31 Mar 2023 02:14:41 -0700 (PDT)
Received: from [10.72.13.208] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 jh5-20020a170903328500b0019f892dc696sm1077019plb.229.2023.03.31.02.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Mar 2023 02:14:40 -0700 (PDT)
Message-ID: <a5b743d1-37d1-1225-c1cb-62cd23d26aef@redhat.com>
Date: Fri, 31 Mar 2023 17:14:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH net-next 2/8] virtio_net: mergeable xdp: introduce
 mergeable_xdp_prepare
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com>
 <20230328120412.110114-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230328120412.110114-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzMvMjggMjA6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGluZyB0aGUg
bG9naWMgb2YgcHJlcGFyYXRpb24gZm9yIHhkcCBmcm9tIHJlY2VpdmVfbWVyZ2VhYmxlLgo+Cj4g
VGhlIHB1cnBvc2Ugb2YgdGhpcyBpcyB0byBzaW1wbGlmeSB0aGUgbG9naWMgb2YgZXhlY3V0aW9u
IG9mIFhEUC4KPgo+IFRoZSBtYWluIGxvZ2ljIGhlcmUgaXMgdGhhdCB3aGVuIGhlYWRyb29tIGlz
IGluc3VmZmljaWVudCwgd2UgbmVlZCB0bwo+IGFsbG9jYXRlIGEgbmV3IHBhZ2UgYW5kIGNhbGN1
bGF0ZSBvZmZzZXQuIEl0IHNob3VsZCBiZSBub3RlZCB0aGF0IGlmCj4gdGhlcmUgaXMgbmV3IHBh
Z2UsIHRoZSB2YXJpYWJsZSBwYWdlIHdpbGwgcmVmZXIgdG8gdGhlIG5ldyBwYWdlLgo+Cj4gU2ln
bmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDEzNSArKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCA1
OCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCA0ZDJiZjFjZTA3MzAuLmJiNDI2OTU4
Y2RkNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMTE2Miw2ICsxMTYyLDc5IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAly
ZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCAqbWVyZ2VhYmxlX3hkcF9wcmVwYXJl
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICsJCQkJICAgc3RydWN0IHJlY2VpdmVfcXVldWUg
KnJxLAo+ICsJCQkJICAgc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZywKPiArCQkJCSAgIHZvaWQg
KmN0eCwKPiArCQkJCSAgIHVuc2lnbmVkIGludCAqZnJhbWVfc3osCj4gKwkJCQkgICBpbnQgKm51
bV9idWYsCj4gKwkJCQkgICBzdHJ1Y3QgcGFnZSAqKnBhZ2UsCj4gKwkJCQkgICBpbnQgb2Zmc2V0
LAo+ICsJCQkJICAgdW5zaWduZWQgaW50ICpsZW4sCj4gKwkJCQkgICBzdHJ1Y3QgdmlydGlvX25l
dF9oZHJfbXJnX3J4YnVmICpoZHIpCj4gK3sKPiArCXVuc2lnbmVkIGludCB0cnVlc2l6ZSA9IG1l
cmdlYWJsZV9jdHhfdG9fdHJ1ZXNpemUoY3R4KTsKPiArCXVuc2lnbmVkIGludCBoZWFkcm9vbSA9
IG1lcmdlYWJsZV9jdHhfdG9faGVhZHJvb20oY3R4KTsKPiArCXN0cnVjdCBwYWdlICp4ZHBfcGFn
ZTsKPiArCXVuc2lnbmVkIGludCB4ZHBfcm9vbTsKPiArCj4gKwkvKiBUcmFuc2llbnQgZmFpbHVy
ZSB3aGljaCBpbiB0aGVvcnkgY291bGQgb2NjdXIgaWYKPiArCSAqIGluLWZsaWdodCBwYWNrZXRz
IGZyb20gYmVmb3JlIFhEUCB3YXMgZW5hYmxlZCByZWFjaAo+ICsJICogdGhlIHJlY2VpdmUgcGF0
aCBhZnRlciBYRFAgaXMgbG9hZGVkLgo+ICsJICovCj4gKwlpZiAodW5saWtlbHkoaGRyLT5oZHIu
Z3NvX3R5cGUpKQo+ICsJCXJldHVybiBOVUxMOwo+ICsKPiArCS8qIE5vdyBYRFAgY29yZSBhc3N1
bWVzIGZyYWcgc2l6ZSBpcyBQQUdFX1NJWkUsIGJ1dCBidWZmZXJzCj4gKwkgKiB3aXRoIGhlYWRy
b29tIG1heSBhZGQgaG9sZSBpbiB0cnVlc2l6ZSwgd2hpY2gKPiArCSAqIG1ha2UgdGhlaXIgbGVu
Z3RoIGV4Y2VlZCBQQUdFX1NJWkUuIFNvIHdlIGRpc2FibGVkIHRoZQo+ICsJICogaG9sZSBtZWNo
YW5pc20gZm9yIHhkcC4gU2VlIGFkZF9yZWN2YnVmX21lcmdlYWJsZSgpLgo+ICsJICovCj4gKwkq
ZnJhbWVfc3ogPSB0cnVlc2l6ZTsKPiArCj4gKwkvKiBUaGlzIGhhcHBlbnMgd2hlbiBoZWFkcm9v
bSBpcyBub3QgZW5vdWdoIGJlY2F1c2UKPiArCSAqIG9mIHRoZSBidWZmZXIgd2FzIHByZWZpbGxl
ZCBiZWZvcmUgWERQIGlzIHNldC4KPiArCSAqIFRoaXMgc2hvdWxkIG9ubHkgaGFwcGVuIGZvciB0
aGUgZmlyc3Qgc2V2ZXJhbCBwYWNrZXRzLgo+ICsJICogSW4gZmFjdCwgdnEgcmVzZXQgY2FuIGJl
IHVzZWQgaGVyZSB0byBoZWxwIHVzIGNsZWFuIHVwCj4gKwkgKiB0aGUgcHJlZmlsbGVkIGJ1ZmZl
cnMsIGJ1dCBtYW55IGV4aXN0aW5nIGRldmljZXMgZG8gbm90Cj4gKwkgKiBzdXBwb3J0IGl0LCBh
bmQgd2UgZG9uJ3Qgd2FudCB0byBib3RoZXIgdXNlcnMgd2hvIGFyZQo+ICsJICogdXNpbmcgeGRw
IG5vcm1hbGx5Lgo+ICsJICovCj4gKwlpZiAoIXhkcF9wcm9nLT5hdXgtPnhkcF9oYXNfZnJhZ3Mg
JiYKPiArCSAgICAoKm51bV9idWYgPiAxIHx8IGhlYWRyb29tIDwgdmlydG5ldF9nZXRfaGVhZHJv
b20odmkpKSkgewo+ICsJCS8qIGxpbmVhcml6ZSBkYXRhIGZvciBYRFAgKi8KPiArCQl4ZHBfcGFn
ZSA9IHhkcF9saW5lYXJpemVfcGFnZShycSwgbnVtX2J1ZiwKPiArCQkJCQkgICAgICAqcGFnZSwg
b2Zmc2V0LAo+ICsJCQkJCSAgICAgIFZJUlRJT19YRFBfSEVBRFJPT00sCj4gKwkJCQkJICAgICAg
bGVuKTsKPiArCj4gKwkJaWYgKCF4ZHBfcGFnZSkKPiArCQkJcmV0dXJuIE5VTEw7Cj4gKwl9IGVs
c2UgaWYgKHVubGlrZWx5KGhlYWRyb29tIDwgdmlydG5ldF9nZXRfaGVhZHJvb20odmkpKSkgewo+
ICsJCXhkcF9yb29tID0gU0tCX0RBVEFfQUxJR04oVklSVElPX1hEUF9IRUFEUk9PTSArCj4gKwkJ
CQkJICBzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+ICsJCWlmICgqbGVuICsgeGRw
X3Jvb20gPiBQQUdFX1NJWkUpCj4gKwkJCXJldHVybiBOVUxMOwo+ICsKPiArCQl4ZHBfcGFnZSA9
IGFsbG9jX3BhZ2UoR0ZQX0FUT01JQyk7Cj4gKwkJaWYgKCF4ZHBfcGFnZSkKPiArCQkJcmV0dXJu
IE5VTEw7Cj4gKwo+ICsJCW1lbWNweShwYWdlX2FkZHJlc3MoeGRwX3BhZ2UpICsgVklSVElPX1hE
UF9IRUFEUk9PTSwKPiArCQkgICAgICAgcGFnZV9hZGRyZXNzKCpwYWdlKSArIG9mZnNldCwgKmxl
bik7Cj4gKwl9IGVsc2Ugewo+ICsJCXJldHVybiBwYWdlX2FkZHJlc3MoKnBhZ2UpICsgb2Zmc2V0
OwoKClRoaXMgbWFrZXMgdGhlIGNvZGUgYSBsaXR0bGUgaGFyZGVyIHRvIGJlIHJlYWQgdGhhbiB0
aGUgb3JpZ2luYWwgY29kZS4KCldoeSBub3QgZG8gYSB2ZXJiYXRpbSBtb3Zpbmcgd2l0aG91dCBp
bnRyb2R1Y2luZyBuZXcgbG9naWM/IChPciAKaW50cm9kdWNpbmcgbmV3IGxvZ2ljIG9uIHRvcD8p
CgpUaGFua3MKCgo+ICsJfQo+ICsKPiArCSpmcmFtZV9zeiA9IFBBR0VfU0laRTsKPiArCj4gKwlw
dXRfcGFnZSgqcGFnZSk7Cj4gKwo+ICsJKnBhZ2UgPSB4ZHBfcGFnZTsKPiArCj4gKwlyZXR1cm4g
cGFnZV9hZGRyZXNzKHhkcF9wYWdlKSArIFZJUlRJT19YRFBfSEVBRFJPT007Cj4gK30KPiArCj4g
ICBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCj4gICAJCQkJCSBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAkJCQkJIHN0
cnVjdCByZWNlaXZlX3F1ZXVlICpycSwKPiBAQCAtMTE4MSw3ICsxMjU0LDcgQEAgc3RhdGljIHN0
cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+
ICAgCXVuc2lnbmVkIGludCBoZWFkcm9vbSA9IG1lcmdlYWJsZV9jdHhfdG9faGVhZHJvb20oY3R4
KTsKPiAgIAl1bnNpZ25lZCBpbnQgdGFpbHJvb20gPSBoZWFkcm9vbSA/IHNpemVvZihzdHJ1Y3Qg
c2tiX3NoYXJlZF9pbmZvKSA6IDA7Cj4gICAJdW5zaWduZWQgaW50IHJvb20gPSBTS0JfREFUQV9B
TElHTihoZWFkcm9vbSArIHRhaWxyb29tKTsKPiAtCXVuc2lnbmVkIGludCBmcmFtZV9zeiwgeGRw
X3Jvb207Cj4gKwl1bnNpZ25lZCBpbnQgZnJhbWVfc3o7Cj4gICAJaW50IGVycjsKPiAgIAo+ICAg
CWhlYWRfc2tiID0gTlVMTDsKPiBAQCAtMTIxMSw2NSArMTI4NCwxMSBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJ
CXUzMiBhY3Q7Cj4gICAJCWludCBpOwo+ICAgCj4gLQkJLyogVHJhbnNpZW50IGZhaWx1cmUgd2hp
Y2ggaW4gdGhlb3J5IGNvdWxkIG9jY3VyIGlmCj4gLQkJICogaW4tZmxpZ2h0IHBhY2tldHMgZnJv
bSBiZWZvcmUgWERQIHdhcyBlbmFibGVkIHJlYWNoCj4gLQkJICogdGhlIHJlY2VpdmUgcGF0aCBh
ZnRlciBYRFAgaXMgbG9hZGVkLgo+IC0JCSAqLwo+IC0JCWlmICh1bmxpa2VseShoZHItPmhkci5n
c29fdHlwZSkpCj4gKwkJZGF0YSA9IG1lcmdlYWJsZV94ZHBfcHJlcGFyZSh2aSwgcnEsIHhkcF9w
cm9nLCBjdHgsICZmcmFtZV9zeiwgJm51bV9idWYsICZwYWdlLAo+ICsJCQkJCSAgICAgb2Zmc2V0
LCAmbGVuLCBoZHIpOwo+ICsJCWlmICghZGF0YSkKPiAgIAkJCWdvdG8gZXJyX3hkcDsKPiAgIAo+
IC0JCS8qIE5vdyBYRFAgY29yZSBhc3N1bWVzIGZyYWcgc2l6ZSBpcyBQQUdFX1NJWkUsIGJ1dCBi
dWZmZXJzCj4gLQkJICogd2l0aCBoZWFkcm9vbSBtYXkgYWRkIGhvbGUgaW4gdHJ1ZXNpemUsIHdo
aWNoCj4gLQkJICogbWFrZSB0aGVpciBsZW5ndGggZXhjZWVkIFBBR0VfU0laRS4gU28gd2UgZGlz
YWJsZWQgdGhlCj4gLQkJICogaG9sZSBtZWNoYW5pc20gZm9yIHhkcC4gU2VlIGFkZF9yZWN2YnVm
X21lcmdlYWJsZSgpLgo+IC0JCSAqLwo+IC0JCWZyYW1lX3N6ID0gdHJ1ZXNpemU7Cj4gLQo+IC0J
CS8qIFRoaXMgaGFwcGVucyB3aGVuIGhlYWRyb29tIGlzIG5vdCBlbm91Z2ggYmVjYXVzZQo+IC0J
CSAqIG9mIHRoZSBidWZmZXIgd2FzIHByZWZpbGxlZCBiZWZvcmUgWERQIGlzIHNldC4KPiAtCQkg
KiBUaGlzIHNob3VsZCBvbmx5IGhhcHBlbiBmb3IgdGhlIGZpcnN0IHNldmVyYWwgcGFja2V0cy4K
PiAtCQkgKiBJbiBmYWN0LCB2cSByZXNldCBjYW4gYmUgdXNlZCBoZXJlIHRvIGhlbHAgdXMgY2xl
YW4gdXAKPiAtCQkgKiB0aGUgcHJlZmlsbGVkIGJ1ZmZlcnMsIGJ1dCBtYW55IGV4aXN0aW5nIGRl
dmljZXMgZG8gbm90Cj4gLQkJICogc3VwcG9ydCBpdCwgYW5kIHdlIGRvbid0IHdhbnQgdG8gYm90
aGVyIHVzZXJzIHdobyBhcmUKPiAtCQkgKiB1c2luZyB4ZHAgbm9ybWFsbHkuCj4gLQkJICovCj4g
LQkJaWYgKCF4ZHBfcHJvZy0+YXV4LT54ZHBfaGFzX2ZyYWdzICYmCj4gLQkJICAgIChudW1fYnVm
ID4gMSB8fCBoZWFkcm9vbSA8IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHZpKSkpIHsKPiAtCQkJLyog
bGluZWFyaXplIGRhdGEgZm9yIFhEUCAqLwo+IC0JCQl4ZHBfcGFnZSA9IHhkcF9saW5lYXJpemVf
cGFnZShycSwgJm51bV9idWYsCj4gLQkJCQkJCSAgICAgIHBhZ2UsIG9mZnNldCwKPiAtCQkJCQkJ
ICAgICAgVklSVElPX1hEUF9IRUFEUk9PTSwKPiAtCQkJCQkJICAgICAgJmxlbik7Cj4gLQkJCWZy
YW1lX3N6ID0gUEFHRV9TSVpFOwo+IC0KPiAtCQkJaWYgKCF4ZHBfcGFnZSkKPiAtCQkJCWdvdG8g
ZXJyX3hkcDsKPiAtCQkJb2Zmc2V0ID0gVklSVElPX1hEUF9IRUFEUk9PTTsKPiAtCj4gLQkJCXB1
dF9wYWdlKHBhZ2UpOwo+IC0JCQlwYWdlID0geGRwX3BhZ2U7Cj4gLQkJfSBlbHNlIGlmICh1bmxp
a2VseShoZWFkcm9vbSA8IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHZpKSkpIHsKPiAtCQkJeGRwX3Jv
b20gPSBTS0JfREFUQV9BTElHTihWSVJUSU9fWERQX0hFQURST09NICsKPiAtCQkJCQkJICBzaXpl
b2Yoc3RydWN0IHNrYl9zaGFyZWRfaW5mbykpOwo+IC0JCQlpZiAobGVuICsgeGRwX3Jvb20gPiBQ
QUdFX1NJWkUpCj4gLQkJCQlnb3RvIGVycl94ZHA7Cj4gLQo+IC0JCQl4ZHBfcGFnZSA9IGFsbG9j
X3BhZ2UoR0ZQX0FUT01JQyk7Cj4gLQkJCWlmICgheGRwX3BhZ2UpCj4gLQkJCQlnb3RvIGVycl94
ZHA7Cj4gLQo+IC0JCQltZW1jcHkocGFnZV9hZGRyZXNzKHhkcF9wYWdlKSArIFZJUlRJT19YRFBf
SEVBRFJPT00sCj4gLQkJCSAgICAgICBwYWdlX2FkZHJlc3MocGFnZSkgKyBvZmZzZXQsIGxlbik7
Cj4gLQkJCWZyYW1lX3N6ID0gUEFHRV9TSVpFOwo+IC0JCQlvZmZzZXQgPSBWSVJUSU9fWERQX0hF
QURST09NOwo+IC0KPiAtCQkJcHV0X3BhZ2UocGFnZSk7Cj4gLQkJCXBhZ2UgPSB4ZHBfcGFnZTsK
PiAtCQl9IGVsc2Ugewo+IC0JCQl4ZHBfcGFnZSA9IHBhZ2U7Cj4gLQkJfQo+IC0KPiAtCQlkYXRh
ID0gcGFnZV9hZGRyZXNzKHhkcF9wYWdlKSArIG9mZnNldDsKPiAgIAkJZXJyID0gdmlydG5ldF9i
dWlsZF94ZHBfYnVmZl9tcmcoZGV2LCB2aSwgcnEsICZ4ZHAsIGRhdGEsIGxlbiwgZnJhbWVfc3os
Cj4gICAJCQkJCQkgJm51bV9idWYsICZ4ZHBfZnJhZ3NfdHJ1ZXN6LCBzdGF0cyk7Cj4gICAJCWlm
ICh1bmxpa2VseShlcnIpKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

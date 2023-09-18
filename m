Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F13C46CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 08:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17D8140B26;
	Mon, 18 Sep 2023 08:41:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17D8140B26
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZtOOpbhr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9Qk7jCsDI5w; Mon, 18 Sep 2023 08:41:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7BBD1404C1;
	Mon, 18 Sep 2023 08:41:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BBD1404C1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD0FAC0039;
	Mon, 18 Sep 2023 08:41:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD5F5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA27681AAC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:41:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA27681AAC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZtOOpbhr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SguWdIiZ4CoB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:41:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B451081A0D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:41:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B451081A0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695026475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCPsfcbIVqzhPMc9WpjHh54nSWIDbNSd7gzRQ5+/f94=;
 b=ZtOOpbhrAAN6iKIa5oCGAQadxZQ7RulnPPpfo69X0gJ7vj5shF0EcfIXVS0VLmLHpmyhxb
 DctLn5RPK7302cUdbUU9Z+lQdPwSNkwcaSaVB9RHK/aVovO2+ZD8bSaaVqVyj9oJH+Gawa
 YRxsIw/fMimmEoLjpgr3pNOien5qj24=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-R8iUAs08N4iXLj7Sa4ynUQ-1; Mon, 18 Sep 2023 04:41:13 -0400
X-MC-Unique: R8iUAs08N4iXLj7Sa4ynUQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5009121067cso4880415e87.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 01:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695026472; x=1695631272;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCPsfcbIVqzhPMc9WpjHh54nSWIDbNSd7gzRQ5+/f94=;
 b=dNou0Gvin4PUKDiKLA0p/xHFPC1mxPdGcjNPnBUCOiSo0grDVGTaEyF/jcMyPPN2iq
 KdU1RYiP2qJ1DQ8+Rqobe4g66rlW6lCmh1fOERBaOSMQiwqrlkI20/eRWiR9t9Ri4fCu
 tcNrjLFCPyjt+e0VPbsfF355F9tbjW81Bq+2Rsq4ZIMunhMiplA+U3ZKaYmFaH1dl+Tm
 +MTK1Pvaw+SKybzZlj9Wy176IkHMf7/CHOjvNXMWXiGyQbztUKQdAAFUSfgIpC/CnDu1
 7mz7fw2+vQ6TrfCARgB9W3g31GOPJOjH6L8T7xy6e0Q8Y32wAA5YRM0Ru67b/IHlVMEJ
 XOhg==
X-Gm-Message-State: AOJu0YwKljkxItT7F1oLuRTUrSkCz7LEi1D8D2iGgxPJdbRRVLwGphAo
 ehw9X4s8xMgXYl5tXg6xyUyQwJuSPXnc46W0el3MC0MLexCMLTHVCQxp+2hq1tqmIQGMDReTFrd
 2mgf2zrSUEjCZqOuI0GJPliajHiHagwtfu8cFpS+k8xETX9JS5nWZbdNBTw==
X-Received: by 2002:a05:6512:23a7:b0:500:a092:d085 with SMTP id
 c39-20020a05651223a700b00500a092d085mr7708222lfv.68.1695026472253; 
 Mon, 18 Sep 2023 01:41:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHftb4P10wWIp3v1EHXZOaP1ysBNS2M6oNZ6GDQlDzpedtNdGUMoZMBhfxfUMabxjFMqZEsMi5wHIELNox0cn8=
X-Received: by 2002:a05:6512:23a7:b0:500:a092:d085 with SMTP id
 c39-20020a05651223a700b00500a092d085mr7708204lfv.68.1695026471949; Mon, 18
 Sep 2023 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-2-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:41:00 +0800
Message-ID: <CACGkMEuwjga949gGBKyZozfppMa2UF5mu8wuk4o88Qi6GthtXw@mail.gmail.com>
Subject: Re: [RFC v2 1/4] vduse: Add function to get/free the pages for
 reconnection
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 maxime.coquelin@redhat.com
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6MDDigK9BTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEFkZCB0aGUgZnVuY3Rpb24gdmR1c2VfYWxsb2NfcmVjb25ubmVjdF9p
bmZvX21lbQo+IGFuZCB2ZHVzZV9hbGxvY19yZWNvbm5uZWN0X2luZm9fbWVtCj4gSW4gdGhpcyAy
IGZ1bmN0aW9uLCB2ZHVzZSB3aWxsIGdldC9mcmVlICh2cV9udW0gKyAxKSpwYWdlCj4gUGFnZSAw
IHdpbGwgYmUgdXNlZCB0byBzYXZlIHRoZSByZWNvbm5lY3Rpb24gaW5mb3JtYXRpb24sIFRoZQo+
IFVzZXJzcGFjZSBBcHAgd2lsbCBtYWludGFpbiB0aGlzLiBQYWdlIDEgfiB2cV9udW0gKyAxIHdp
bGwgc2F2ZQo+IHRoZSByZWNvbm5lY3Rpb24gaW5mb3JtYXRpb24gZm9yIHZxcy4KClBsZWFzZSBl
eHBsYWluIHdoeSB0aGlzIGlzIG5lZWRlZCBpbnN0ZWFkIG9mIG9ubHkgZGVzY3JpYmluZyBob3cg
aXQgaXMKaW1wbGVtZW50ZWQuIChDb2RlIGNhbiBleHBsYWluIGl0c2VsZikuCgo+Cj4gU2lnbmVk
LW9mZi1ieTogQ2luZHkgTHUgPGx1bHVAcmVkaGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy92ZHBh
L3ZkcGFfdXNlci92ZHVzZV9kZXYuYyB8IDg2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+ICAxIGZpbGUgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2Vy
L3ZkdXNlX2Rldi5jCj4gaW5kZXggMjZiN2UyOWNiOTAwLi40YzI1NmZhMzFmYzQgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAtMzAsNiArMzAsMTAgQEAKPiAgI2luY2x1
ZGUgPHVhcGkvbGludXgvdmlydGlvX2Jsay5oPgo+ICAjaW5jbHVkZSA8bGludXgvbW9kX2Rldmlj
ZXRhYmxlLmg+Cj4KPiArI2lmZGVmIENPTkZJR19YODYKPiArI2luY2x1ZGUgPGFzbS9zZXRfbWVt
b3J5Lmg+Cj4gKyNlbmRpZgo+ICsKPiAgI2luY2x1ZGUgImlvdmFfZG9tYWluLmgiCj4KPiAgI2Rl
ZmluZSBEUlZfQVVUSE9SICAgIllvbmdqaSBYaWUgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPiIK
PiBAQCAtNDEsNiArNDUsMjMgQEAKPiAgI2RlZmluZSBWRFVTRV9JT1ZBX1NJWkUgKDEyOCAqIDEw
MjQgKiAxMDI0KQo+ICAjZGVmaW5lIFZEVVNFX01TR19ERUZBVUxUX1RJTUVPVVQgMzAKPgo+ICsv
KiBzdHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyBzYXZlIHRoZSBwYWdlIGluZm9ybWF0aW9uIGZv
ciByZWNvbm5lY3Rpb24KPiArICoga2VybmVsIHdpbGwgaW5pdCB0aGVzZSBpbmZvcm1hdGlvbiB3
aGlsZSBhbGxvYyB0aGUgcGFnZXMKPiArICogYW5kIHVzZSB0aGVzZSBpbmZvcm1hdGlvbiB0byBm
cmVlIHRoZSBwYWdlcwo+ICsgKi8KPiArc3RydWN0IHZkcGFfcmVjb25uZWN0X2luZm8gewo+ICsg
ICAgICAgLyogT2Zmc2V0ICh3aXRoaW4gdm1fZmlsZSkgaW4gUEFHRV9TSVpFLAo+ICsgICAgICAg
ICogdGhpcyBqdXN0IGZvciBjaGVjaywgbm90IHVzaW5nCj4gKyAgICAgICAgKi8KPiArICAgICAg
IHUzMiBpbmRleDsKPiArICAgICAgIC8qIHBoeXNpY2FsIGFkZHJlc3MgZm9yIHRoaXMgcGFnZSov
Cj4gKyAgICAgICBwaHlzX2FkZHJfdCBhZGRyOwo+ICsgICAgICAgLyogdmlydHVhbCBhZGRyZXNz
IGZvciB0aGlzIHBhZ2UqLwo+ICsgICAgICAgdW5zaWduZWQgbG9uZyB2YWRkcjsKCklmIGl0IGNv
dWxkIGJlIHN3aXRjaGVkIGJ5IHZpcnRfdG9fcGh5cygpIHdoeSBkdXBsaWNhdGUgdGhvc2UgZmll
bGRzPwoKPiArICAgICAgIC8qIG1lbW9yeSBzaXplLCBoZXJlIGFsd2F5cyBwYWdlX3NpemUqLwo+
ICsgICAgICAgcGh5c19hZGRyX3Qgc2l6ZTsKCklmIGl0J3MgYWx3YXlzIFBBR0VfU0laRSB3aHkg
d291bGQgd2UgaGF2ZSB0aGlzPwoKPiArfTsKPiArCj4gIHN0cnVjdCB2ZHVzZV92aXJ0cXVldWUg
ewo+ICAgICAgICAgdTE2IGluZGV4Owo+ICAgICAgICAgdTE2IG51bV9tYXg7Cj4gQEAgLTU3LDYg
Kzc4LDcgQEAgc3RydWN0IHZkdXNlX3ZpcnRxdWV1ZSB7Cj4gICAgICAgICBzdHJ1Y3QgdmRwYV9j
YWxsYmFjayBjYjsKPiAgICAgICAgIHN0cnVjdCB3b3JrX3N0cnVjdCBpbmplY3Q7Cj4gICAgICAg
ICBzdHJ1Y3Qgd29ya19zdHJ1Y3Qga2ljazsKPiArICAgICAgIHN0cnVjdCB2ZHBhX3JlY29ubmVj
dF9pbmZvIHJlY29ubmVjdF9pbmZvOwo+ICB9Owo+Cj4gIHN0cnVjdCB2ZHVzZV9kZXY7Cj4gQEAg
LTEwNiw2ICsxMjgsNyBAQCBzdHJ1Y3QgdmR1c2VfZGV2IHsKPiAgICAgICAgIHUzMiB2cV9hbGln
bjsKPiAgICAgICAgIHN0cnVjdCB2ZHVzZV91bWVtICp1bWVtOwo+ICAgICAgICAgc3RydWN0IG11
dGV4IG1lbV9sb2NrOwo+ICsgICAgICAgc3RydWN0IHZkcGFfcmVjb25uZWN0X2luZm8gcmVjb25u
ZWN0X3N0YXR1czsKPiAgfTsKPgo+ICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyB7Cj4gQEAgLTEwMzAs
NiArMTA1Myw2NSBAQCBzdGF0aWMgaW50IHZkdXNlX2Rldl9yZWdfdW1lbShzdHJ1Y3QgdmR1c2Vf
ZGV2ICpkZXYsCj4gICAgICAgICByZXR1cm4gcmV0Owo+ICB9Cj4KPiAraW50IHZkdXNlX2FsbG9j
X3JlY29ubm5lY3RfaW5mb19tZW0oc3RydWN0IHZkdXNlX2RldiAqZGV2KQo+ICt7Cj4gKyAgICAg
ICBzdHJ1Y3QgdmRwYV9yZWNvbm5lY3RfaW5mbyAqaW5mbzsKPiArICAgICAgIHN0cnVjdCB2ZHVz
ZV92aXJ0cXVldWUgKnZxOwo+ICsgICAgICAgdm9pZCAqYWRkcjsKPiArCj4gKyAgICAgICAvKnBh
Z2UgMCBpcyB1c2UgdG8gc2F2ZSBzdGF0dXMsZHBkayB3aWxsIHVzZSB0aGlzIHRvIHNhdmUgdGhl
IGluZm9ybWF0aW9uCj4gKyAgICAgICAgKm5lZWRlZCBpbiByZWNvbm5lY3Rpb24sa2VybmVsIGRv
bid0IG5lZWQgdG8gbWFpbnRhaW4gdGhpcwo+ICsgICAgICAgICovCj4gKyAgICAgICBpbmZvID0g
JmRldi0+cmVjb25uZWN0X3N0YXR1czsKPiArICAgICAgIGFkZHIgPSAodm9pZCAqKWdldF96ZXJv
ZWRfcGFnZShHRlBfS0VSTkVMKTsKPiArICAgICAgIGlmICghYWRkcikKPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC0xOwoKLUVOT01FTT8KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

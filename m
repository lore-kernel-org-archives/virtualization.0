Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61884E81810
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 02:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF4E941938;
	Tue, 26 Sep 2023 02:47:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF4E941938
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eWFKEzOX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5DHf_lj_DYBq; Tue, 26 Sep 2023 02:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18A6041919;
	Tue, 26 Sep 2023 02:47:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18A6041919
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 272AFC0071;
	Tue, 26 Sep 2023 02:47:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08219C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C70474191A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C70474191A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M8G7xG2Dus4C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A36041911
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 02:47:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A36041911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695696459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3cx0kxtLpPGv+5EBA2RQ4RZiZDVBT8lLjm6nn2c/2U=;
 b=eWFKEzOXQ7A+uVMTTl20FaYo27NuY0gwHE2H3TCmXUCtmEExGUJQ2dusDVqBEU3/085gcd
 godoSu5gMPTc9S+N8k/Uf6Y1dXrqm/bINWtrJThtxM38UNIpyU1OhJuZpeSPNLYo2lWyrX
 kYUhq2R4VkCvqsYdyBFkFO0S87kgpnI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-eWYMDNkwP0ed2VZUksjl8Q-1; Mon, 25 Sep 2023 22:47:38 -0400
X-MC-Unique: eWYMDNkwP0ed2VZUksjl8Q-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-500a9156daaso10930796e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 19:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695696456; x=1696301256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3cx0kxtLpPGv+5EBA2RQ4RZiZDVBT8lLjm6nn2c/2U=;
 b=H06FNp2ZZIVsONJM5MVg3c052bfQ3E0q2n0XrtbfpIuBi1birSejxeZBJvYWRNmUMm
 aSynoAvfWjkMjpHJgGti+z+UIrhrO/7fFk74EAqsdA2pSnaNnV0BCyi+GI6N5zji0LY/
 h7Rm0wufgpIIKr2I54o95xwtSz6mP8VDFepLLyqkXcT/JDQ4y8rM+8kimP0WsIQZWlKa
 1x2ed+OEdpYHRBV59rairjSJDwpICx3ZAiBNUmwBJ6b2DDkbOYX0GJHWPPKqNy0LRnt2
 dpsa/tIaExQr+K6fuK/NCzDIfl/sNy15LE9E5uFqn+g6R5ddaqBtVEMfmmx/1i/4SvWd
 edwg==
X-Gm-Message-State: AOJu0Yw0aYWL2UkTykkg7l1QjFgFeyIWWYBEDJfnomC9gXP7PrUOQmeQ
 RZMk3Y+NDP4NE02/ua3jgB+Kpbtnvv8ihosRVAeI8/Tdq94nsqvQuTgEd+oMSXD/T8eXOmWTd8u
 zItLnFfcKumDw70vwivVzNnuDG6x37TtUf2gfNWDSKAOxulv33lZJUdl+3+mzPQm7EgnazUU=
X-Received: by 2002:ac2:484a:0:b0:504:3807:22a4 with SMTP id
 10-20020ac2484a000000b00504380722a4mr6579866lfy.23.1695696456741; 
 Mon, 25 Sep 2023 19:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkOWZjTRPau3mG9Pjn/pYVEjqanRn4CgrReXQdv2VpQOTnisrlxsRXRGDqSTR77juC7tMdGrvAHT7rO57F9E=
X-Received: by 2002:ac2:484a:0:b0:504:3807:22a4 with SMTP id
 10-20020ac2484a000000b00504380722a4mr6579862lfy.23.1695696456554; Mon, 25 Sep
 2023 19:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20230923170540.1447301-2-lulu@redhat.com>
In-Reply-To: <20230923170540.1447301-2-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 10:47:25 +0800
Message-ID: <CACGkMEsL-jWiNeWG5pEA2jp50=BqYmGWM1HsMiCigxic+S0_5A@mail.gmail.com>
Subject: Re: [RFC 1/7] vhost/iommufd: Add the functions support iommufd
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: yi.l.liu@intel.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 jgg@nvidia.com
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

T24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgMTowNeKAr0FNIENpbmR5IEx1IDxsdWx1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gQWRkIGEgbmV3IGZpbGUgdmhvc3QvaW9tbXVmZC5jIHRvIHN1cHBvcnQg
dGhlIGZ1bmN0aW9uIG9mCj4gaW9tbXVmZCwgVGhpcyBmaWxlIGNvbnRhaW5zIGlvbW11ZmQgZnVu
Y3Rpb24gb2YgZW11bGF0ZWQgZGV2aWNlIGFuZAo+IHRoZSBwaHlzaWNhbCBkZXZpY2UuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBDaW5keSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJz
L3Zob3N0L2lvbW11ZmQuYyB8IDE1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gIGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCAgIHwgIDIxICsrKysrKwo+ICAyIGZpbGVz
IGNoYW5nZWQsIDE3MiBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3Zob3N0L2lvbW11ZmQuYwo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvaW9tbXVmZC5j
IGIvZHJpdmVycy92aG9zdC9pb21tdWZkLmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IDAwMDAwMDAwMDAwMC4uMDgwODU4Zjc2ZmQ1Cj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL2RyaXZl
cnMvdmhvc3QvaW9tbXVmZC5jCj4gQEAgLTAsMCArMSwxNTEgQEAKPiArI2luY2x1ZGUgPGxpbnV4
L3ZkcGEuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2lvbW11ZmQuaD4KPiArCj4gKyNpbmNsdWRlICJ2
aG9zdC5oIgo+ICsKPiArTU9EVUxFX0lNUE9SVF9OUyhJT01NVUZEKTsKPiArCj4gK2ludCB2ZHBh
X2lvbW11ZmRfYmluZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEsIHN0cnVjdCBpb21tdWZkX2N0
eCAqaWN0eCwKPiArICAgICAgICAgICAgICAgICAgICAgdTMyICppb2FzX2lkLCB1MzIgKmRldmlj
ZV9pZCkKPiArewo+ICsgICAgICAgaW50IHJldDsKPiArCj4gKyAgICAgICB2aG9zdF92ZHBhX2xv
Y2tkZXBfYXNzZXJ0X2hlbGQodmRwYSk7Cj4gKwo+ICsgICAgICAgLyoKPiArICAgICAgICAqIElm
IHRoZSBkcml2ZXIgZG9lc24ndCBwcm92aWRlIHRoaXMgb3AgdGhlbiBpdCBtZWFucyB0aGUgZGV2
aWNlIGRvZXMKPiArICAgICAgICAqIG5vdCBkbyBETUEgYXQgYWxsLiBTbyBub3RoaW5nIHRvIGRv
Lgo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoIXZkcGEtPmNvbmZpZy0+YmluZF9pb21tdWZk
KQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiArCj4gKyAgICAgICByZXQgPSB2ZHBhLT5j
b25maWctPmJpbmRfaW9tbXVmZCh2ZHBhLCBpY3R4LCBkZXZpY2VfaWQpOwo+ICsgICAgICAgaWYg
KHJldCkKPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPiArCj4gKyAgICAgICByZXQgPSB2
ZHBhLT5jb25maWctPmF0dGFjaF9pb2FzKHZkcGEsIGlvYXNfaWQpOwo+ICsgICAgICAgaWYgKHJl
dCkKPiArICAgICAgICAgICAgICAgZ290byBlcnJfdW5iaW5kOwo+ICsgICAgICAgdmRwYS0+aW9t
bXVmZF9hdHRhY2hlZCA9IHRydWU7Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gKwo+ICtlcnJf
dW5iaW5kOgo+ICsgICAgICAgaWYgKHZkcGEtPmNvbmZpZy0+dW5iaW5kX2lvbW11ZmQpCj4gKyAg
ICAgICAgICAgICAgIHZkcGEtPmNvbmZpZy0+dW5iaW5kX2lvbW11ZmQodmRwYSk7Cj4gKyAgICAg
ICByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICt2b2lkIHZkcGFfaW9tbXVmZF91bmJpbmQoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICt7Cj4gKyAgICAgICB2aG9zdF92ZHBhX2xvY2tkZXBfYXNz
ZXJ0X2hlbGQodmRwYSk7Cj4gKwo+ICsgICAgICAgaWYgKHZkcGEtPmNvbmZpZy0+dW5iaW5kX2lv
bW11ZmQpCj4gKyAgICAgICAgICAgICAgIHZkcGEtPmNvbmZpZy0+dW5iaW5kX2lvbW11ZmQodmRw
YSk7Cj4gK30KPiArCj4gK2ludCB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfYmluZChzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBp
b21tdWZkX2N0eCAqaWN0eCwgdTMyICpvdXRfZGV2aWNlX2lkKQo+ICt7Cj4gKyAgICAgICBzdHJ1
Y3QgZGV2aWNlICpkbWFfZGV2ID0gdmRwYV9nZXRfZG1hX2Rldih2ZHBhKTsKPiArICAgICAgIHN0
cnVjdCBpb21tdWZkX2RldmljZSAqaWRldjsKPiArCj4gKyAgICAgICBpZGV2ID0gaW9tbXVmZF9k
ZXZpY2VfYmluZChpY3R4LCBkbWFfZGV2LCBvdXRfZGV2aWNlX2lkKTsKPiArICAgICAgIGlmIChJ
U19FUlIoaWRldikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKGlkZXYpOwo+ICsg
ICAgICAgdmRwYS0+aW9tbXVmZF9kZXZpY2UgPSBpZGV2Owo+ICsgICAgICAgcmV0dXJuIDA7Cj4g
K30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmRwYV9pb21tdWZkX3BoeXNpY2FsX2JpbmQpOwo+ICsK
PiArdm9pZCB2ZHBhX2lvbW11ZmRfcGh5c2ljYWxfdW5iaW5kKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYSkKPiArewo+ICsgICAgICAgdmhvc3RfdmRwYV9sb2NrZGVwX2Fzc2VydF9oZWxkKHZkcGEp
Owo+ICsKPiArICAgICAgIGlmICh2ZHBhLT5pb21tdWZkX2F0dGFjaGVkKSB7Cj4gKyAgICAgICAg
ICAgICAgIGlvbW11ZmRfZGV2aWNlX2RldGFjaCh2ZHBhLT5pb21tdWZkX2RldmljZSk7Cj4gKyAg
ICAgICAgICAgICAgIHZkcGEtPmlvbW11ZmRfYXR0YWNoZWQgPSBmYWxzZTsKPiArICAgICAgIH0K
PiArICAgICAgIGlvbW11ZmRfZGV2aWNlX3VuYmluZCh2ZHBhLT5pb21tdWZkX2RldmljZSk7Cj4g
KyAgICAgICB2ZHBhLT5pb21tdWZkX2RldmljZSA9IE5VTEw7Cj4gK30KPiArRVhQT1JUX1NZTUJP
TF9HUEwodmRwYV9pb21tdWZkX3BoeXNpY2FsX3VuYmluZCk7Cj4gKwo+ICtpbnQgdmRwYV9pb21t
dWZkX3BoeXNpY2FsX2F0dGFjaF9pb2FzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwgdTMyICpw
dF9pZCkKPiArewo+ICsgICAgICAgdW5zaWduZWQgaW50IGZsYWdzID0gMDsKPiArCj4gKyAgICAg
ICByZXR1cm4gaW9tbXVmZF9kZXZpY2VfYXR0YWNoKHZkcGEtPmlvbW11ZmRfZGV2aWNlLCBwdF9p
ZCk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmRwYV9pb21tdWZkX3BoeXNpY2FsX2F0dGFj
aF9pb2FzKTsKPiArCj4gK3N0YXRpYyB2b2lkIHZkcGFfZW11bGF0ZWRfdW5tYXAodm9pZCAqZGF0
YSwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBsZW5ndGgpCj4gK3sKPiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYSA9IGRhdGE7Cj4gKwo+ICsgICAgICAgdmRwYS0+Y29uZmlnLT5kbWFfdW5tYXAodmRwYSwg
MCwgaW92YSwgbGVuZ3RoKTsKPiArfQo+ICsKPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpb21tdWZk
X2FjY2Vzc19vcHMgdmRwYV91c2VyX29wcyA9IHsKPiArICAgICAgIC5uZWVkc19waW5fcGFnZXMg
PSAxLAoKTm90ZSB0aGF0IHNpbXVsYXRvcnMgc3VwcG9ydCBWQSwgc28gbm8gcGFnZSBwaW5uaW5n
IGluIHRoYXQgY2FzZSB3aGlsZSByZWJhc2luZy4KCnN0YXRpYyBib29sIHVzZV92YSA9IHRydWU7
Cm1vZHVsZV9wYXJhbSh1c2VfdmEsIGJvb2wsIDA0NDQpOwpNT0RVTEVfUEFSTV9ERVNDKHVzZV92
YSwgIkVuYWJsZS9kaXNhYmxlIHRoZSBkZXZpY2UncyBhYmlsaXR5IHRvIHVzZSBWQSIpOwoKU28g
d2UgbmVlZCB0byBoYW5kbGUgdGhhdCBjYXNlIGFzIHdlbGwuCgooTm90ZSB0aGF0IGl0IGxvb2tz
IGxpa2UgVkEgbW9kZSBpcyBicm9rZW4sIEkgbWF5IG5lZWQgc29tZSB0aW1lIHRvIGZpeCB0aGF0
KS4KCj4gKyAgICAgICAudW5tYXAgPSB2ZHBhX2VtdWxhdGVkX3VubWFwLAo+ICt9Owo+ICsKPiAr
aW50IHZkcGFfaW9tbXVmZF9lbXVsYXRlZF9iaW5kKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSwK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvbW11ZmRfY3R4ICppY3R4
LCB1MzIgKm91dF9kZXZpY2VfaWQpCj4gK3sKPiArICAgICAgIHZob3N0X3ZkcGFfbG9ja2RlcF9h
c3NlcnRfaGVsZCh2ZHBhKTsKPiArCj4gKyAgICAgICB2ZHBhLT5pb21tdWZkX2ljdHggPSBpY3R4
Owo+ICsgICAgICAgaW9tbXVmZF9jdHhfZ2V0KGljdHgpOwo+ICsgICAgICAgc3RydWN0IGlvbW11
ZmRfZGV2aWNlICppZGV2Owo+ICsKPiArICAgICAgIGlkZXYgPSBpb21tdWZkX2RldmljZV9iaW5k
KGljdHgsIHZkcGEtPmRtYV9kZXYsIG91dF9kZXZpY2VfaWQpOwoKVGhpcyBzZWVtcyBub3QgYXBw
cm9wcmlhdGUgZm9yIGVtdWxhdGVkIGRldmljZXMgYXMgaXQgZGVhbHMgd2l0aCB0aGUKY29uY2Vw
dHMgdGhhdCBvbmx5IGV4aXN0IGluIHBoeXNpY2FsIGRldmljZXMgbGlrZSB0aGUgSU9NTVUgZG9t
YWluCmV0Yy4KCklmIHBvc3NpYmxlLCBwbGVhc2UgcmVmZXIgaG93IFZGSU8gaGFuZGxlcyB0aGlz
IChJIGd1ZXNzIGl0IHNob3VsZApoYXZlIHNvbWV0aGluZykKClRoYW5rcwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

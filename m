Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE5FC678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 06:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4266140338;
	Tue,  7 Mar 2023 06:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4266140338
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeWAkXvj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W40w4DnQh7Uh; Tue,  7 Mar 2023 06:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B1887402F3;
	Tue,  7 Mar 2023 06:44:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1887402F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EB8AC0035;
	Tue,  7 Mar 2023 06:44:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1123BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D306C61029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D306C61029
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XeWAkXvj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qxX3DBSaBPd9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05FEB61022
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05FEB61022
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678171439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxgiVeKMInPfepXnXqNFnKwtvVhXpzr7DeYZZxERIzU=;
 b=XeWAkXvjZi4jbeJSxHCaZQkkz258Yzx0Mg0eXZ6rTb3FHT0pUHFsJ838mls9JuBtQIt/x4
 rWvEeSjc0nGXhCYsf1n899BMX33WfGBiN/l4YK45mTGddUJcusgI/uFBzczOnTYjdOCyT8
 Yn9xIKV6PGV0mqadIX+Fm9zEg2M/pjM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-rYs56PxhNRC_R-20O3Kjuw-1; Tue, 07 Mar 2023 01:43:57 -0500
X-MC-Unique: rYs56PxhNRC_R-20O3Kjuw-1
Received: by mail-ot1-f70.google.com with SMTP id
 x23-20020a05683000d700b0069438ae848cso5501301oto.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 22:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678171437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxgiVeKMInPfepXnXqNFnKwtvVhXpzr7DeYZZxERIzU=;
 b=ONWr/fXi2Cf72OyjbzTT4X8AsLu9/Qpk7Em33aleE1GNtSRxpHEqPtIwGNFRqBmThj
 plASWNnEeIOnYTD+/VLiXtpscg8fyeCCD2pXTIhdaNhaDmrLi5+LEiUNhNghiQDT1rOc
 vQVi+lC80vTOnYtxPBX0Mklc6Roy66pTXPvMQ+msUigemoooW0QXbteLyQBbGAUuQKbL
 tjEDexUIfoHLJe6K6K2cynETFmVQ1eR3pcwaQkLsv+OtXeulJX7IZab6T2OEIhJx7oWl
 +bXnLW+fXlAxoxdMwdhHpRo3I9nlLV+UOow9cIBT72Lk1sl5ozZxu++JdmkGZLJeI/J1
 Xd9w==
X-Gm-Message-State: AO0yUKXub9+fwvcO8Vt/YZeYkfAo/bKN8VyJOghmdmjD6NBrJCH+DjY+
 7BL3KtOJS7gc4KmrkTgJYwx4lxoDBsI+6plrUrL6JS/MSTX9j5rVhleVlbBRZzVM3gn1Fiqt23p
 goRXLIqCQfVsUQVKUtNZxzEpdaPacBgT4CaFVm0bOwDsvsofwQONaAu6hFQ==
X-Received: by 2002:a05:6870:c79a:b0:176:6a34:52ab with SMTP id
 dy26-20020a056870c79a00b001766a3452abmr3564981oab.9.1678171437052; 
 Mon, 06 Mar 2023 22:43:57 -0800 (PST)
X-Google-Smtp-Source: AK7set/SIp7U3pzm1XADw0LGhn2yyEqeNRpuPJglykI+NpANJdZPQepSSldt88ErZVaHcf4j3iivZrbLX6TjbgYq3J0=
X-Received: by 2002:a05:6870:c79a:b0:176:6a34:52ab with SMTP id
 dy26-20020a056870c79a00b001766a3452abmr3564977oab.9.1678171436844; Mon, 06
 Mar 2023 22:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
 <20230302115908.1461-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230302115908.1461-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Mar 2023 14:43:45 +0800
Message-ID: <CACGkMEtY7L1jFRXdkFVtYAbk6dzQZRJ-eaG8w-NthNBcu42A_w@mail.gmail.com>
Subject: Re: [PATCH vhost v1 04/12] virtio_ring: packed: separate prepare code
 from virtuque_add_indirect_packed()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjU54oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBTZXBhcmF0aW5nIHRoZSBsb2dpYyBvZiBhbGxvY2F0
aW5nIGluZGlyZWN0IGRlc2MgYW5kIGNoZWNraW5nIHF1ZXVlCj4gc3RhdHVzIHRvIHRoZSB1cHBl
ciBsYXllciBmdW5jdGlvbi4KCk5vdGUgdGhhdCBpdCBsb29rcyB0byBtZSBpdCdzIG5vdCBsb2dp
YyBzZXBhcmF0aW9uIGJ1dCBhIHNpbXBsZSBtb3ZpbmcuCgoKPgo+IFRoZSBwcm9wb3NhbCBvZiB0
aGlzIGlzIGNvbnZlbmllbnQgdG8gcmVmYWN0b3IgdmlydHF1ZXVlX2FkZF9wYWNrZWQoKQo+IGZv
ciBwcmVtYXBwZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjkg
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2Vy
dGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNWIx
ODZjZTczZDM1Li4xNzhlZGYxMTcxZTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtMTM0
OCwyNSArMTM0OCwxNCBAQCBzdGF0aWMgaW50IHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2Vk
KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG91dF9zZ3MsCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaW5fc2dzLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwKPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdmcF90IGdmcCkKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzYyAqZGVzYykK
PiAgewo+IC0gICAgICAgc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICpkZXNjOwo+ICAgICAgICAg
c3RydWN0IHNjYXR0ZXJsaXN0ICpzZzsKPiAgICAgICAgIHVuc2lnbmVkIGludCBpLCBuLCBlcnJf
aWR4Owo+ICAgICAgICAgdTE2IGhlYWQsIGlkOwo+ICAgICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+
Cj4gICAgICAgICBoZWFkID0gdnEtPnBhY2tlZC5uZXh0X2F2YWlsX2lkeDsKPiAtICAgICAgIGRl
c2MgPSBhbGxvY19pbmRpcmVjdF9wYWNrZWQodG90YWxfc2csIGdmcCk7Cj4gLSAgICAgICBpZiAo
IWRlc2MpCj4gLSAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+IC0KPiAtICAgICAgIGlm
ICh1bmxpa2VseSh2cS0+dnEubnVtX2ZyZWUgPCAxKSkgewo+IC0gICAgICAgICAgICAgICBwcl9k
ZWJ1ZygiQ2FuJ3QgYWRkIGJ1ZiBsZW4gMSAtIGF2YWlsID0gMFxuIik7Cj4gLSAgICAgICAgICAg
ICAgIGtmcmVlKGRlc2MpOwo+IC0gICAgICAgICAgICAgICBFTkRfVVNFKHZxKTsKPiAtICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9TUEM7Cj4gLSAgICAgICB9Cj4KPiAgICAgICAgIGkgPSAwOwo+
ICAgICAgICAgaWQgPSB2cS0+ZnJlZV9oZWFkOwo+IEBAIC0xNDg4LDExICsxNDc3LDE3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92
cSwKPiAgICAgICAgIEJVR19PTih0b3RhbF9zZyA9PSAwKTsKPgo+ICAgICAgICAgaWYgKHZpcnRx
dWV1ZV91c2VfaW5kaXJlY3QodnEsIHRvdGFsX3NnKSkgewo+IC0gICAgICAgICAgICAgICBlcnIg
PSB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZCh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3Nn
cywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW5fc2dzLCBkYXRhLCBnZnApOwo+IC0gICAgICAgICAgICAgICBpZiAoZXJyICE9IC1FTk9NRU0p
IHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBFTkRfVVNFKHZxKTsKPiAtICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZXJyOwo+ICsgICAgICAgICAgICAgICBkZXNjID0gYWxsb2NfaW5k
aXJlY3RfcGFja2VkKHRvdGFsX3NnLCBnZnApOwo+ICsgICAgICAgICAgICAgICBpZiAoZGVzYykg
ewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh2cS0+dnEubnVtX2ZyZWUg
PCAxKSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWcoIkNhbid0
IGFkZCBidWYgbGVuIDEgLSBhdmFpbCA9IDBcbiIpOwo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAga2ZyZWUoZGVzYyk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBF
TkRfVVNFKHZxKTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5P
U1BDOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiArCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHZxLCBzZ3MsIHRvdGFs
X3NnLCBvdXRfc2dzLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBpbl9zZ3MsIGRhdGEsIGRlc2MpOwo+ICAgICAgICAgICAgICAg
ICB9Cj4KPiAgICAgICAgICAgICAgICAgLyogZmFsbCBiYWNrIG9uIGRpcmVjdCAqLwo+IC0tCj4g
Mi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1057C6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 07:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46EE661023;
	Tue, 14 Mar 2023 07:32:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46EE661023
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ln3DuadL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7c2D5a6Da7Nn; Tue, 14 Mar 2023 07:32:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B91D60ACE;
	Tue, 14 Mar 2023 07:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B91D60ACE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74B5DC0035;
	Tue, 14 Mar 2023 07:32:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF3FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87E6460BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87E6460BD0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vgZfDDnGsdQW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:32:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77C9E60ACE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77C9E60ACE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678779154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kx98pGCPJkWizm9B50eRSK4lo2erlQorzNI11w7NYcE=;
 b=Ln3DuadLWMO5bMc+C5AR5fm/0foCJV2RQftPB7YO3BQjV4xyqO/MZJfgfVtavvaHj89Y+M
 SnMHnxx2+eiz7MaaFhW2sE6MBw7wIPs+3+Oei7kj2GZjd1nwncVCrBow4qCJE1YdRzx9c9
 AwuWgsriFf5f/b+RbKQ7qAYj7wpZBGs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-6QLsJw3BNqKV_i777QQKhQ-1; Tue, 14 Mar 2023 03:32:33 -0400
X-MC-Unique: 6QLsJw3BNqKV_i777QQKhQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 n10-20020a4abd0a000000b005253ac653a0so3995300oop.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 00:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678779153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kx98pGCPJkWizm9B50eRSK4lo2erlQorzNI11w7NYcE=;
 b=OAXjSbTbAym32WYR4uzcKoNtF3SHV44SaIcy4JvnP2Exg/UsAi6exgwPtq1Bg+oDEI
 cwlH9IkW7saED8IuShsnHtQlubs/KB56W+jihEocNUlpfTY7gK9ezm/VKbok5w7StjF4
 u3OQqccRAxJdbTUxXp408WgW/MQitcatNUuM4Vh5V/qCWwCTWBSNZ3fg8S/u/W0ZGGMg
 rbXF/vjxfxeZmegxp9YHBdO6gXGs9QkLIrI5tzgxTk2O4UC4p6HLNV5/yME5gPDJMbqd
 5U/U1yG6FIO57hX7IAwP81XQXjQLj3WNZQ4h8p/yqJuPh1x0YUrbcZ37kkRZ2up45RD8
 IBkQ==
X-Gm-Message-State: AO0yUKV4dlu2L487gyf9Fu60vgLgF1EZcPM96FZcdQUmeIeN3VWJ6+t6
 di67sMqc+oULWyaK5yrDhDvGvmvu4E0o9smJwqSIEz1c9wIJbcocCwDinoGyToCqxVv2kpa2HpX
 uAePKxKfKzArdt4Lf+MxhPwdOcWQx9U24NqfFhGEKBbFh6oS7KUnci8s5iA==
X-Received: by 2002:a05:6870:1341:b0:177:ca1c:2ca8 with SMTP id
 1-20020a056870134100b00177ca1c2ca8mr1498802oac.9.1678779152711; 
 Tue, 14 Mar 2023 00:32:32 -0700 (PDT)
X-Google-Smtp-Source: AK7set9zu0/Tf3iImytbgpJbUGSarxYNSrTs9cEdCzaRlL+D2EVJK1aNpMtfPzLJadrnP4lmjDIRjReikHPdRKhPB/s=
X-Received: by 2002:a05:6870:1341:b0:177:ca1c:2ca8 with SMTP id
 1-20020a056870134100b00177ca1c2ca8mr1498798oac.9.1678779152460; Tue, 14 Mar
 2023 00:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308064443.50639-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 15:32:21 +0800
Message-ID: <CACGkMEunz23S83ROPrXq5sYbMCq+j5BaqYPdTaYMH5atWZ4TpA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 04/12] virtio_ring: split: support premapped
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

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAyOjQ04oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiB2aXJ0aW8gY29yZSBvbmx5IHN1cHBvcnRzIHZpcnR1
YWwgYWRkcmVzc2VzLCBkbWEgaXMgY29tcGxldGVkIGluIHZpcnRpbwo+IGNvcmUuCj4KPiBJbiBz
b21lIHNjZW5hcmlvcyAoc3VjaCBhcyB0aGUgQUZfWERQKSwgdGhlIG1lbW9yeSBpcyBhbGxvY2F0
ZWQKPiBhbmQgRE1BIGlzIGNvbXBsZXRlZCBpbiBhZHZhbmNlLCBzbyBpdCBpcyBuZWNlc3Nhcnkg
Zm9yIHVzIHRvIHN1cHBvcnQKClNob3VsZCBiZSAiRE1BIG1hcHBpbmcgaXMgY29tcGxldGVkIi4K
Cj4gcGFzc2luZyB0aGUgRE1BIGFkZHJlc3MgdG8gdmlydGlvIGNvcmUuCj4KPiBEcml2ZXMgY2Fu
IHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyB0aGUgbWFwcGVkIGRtYSBhZGRyZXNzIHRvIHZp
cnRpbwo+IGNvcmUuIElmIG9uZSBzZy0+ZG1hX2FkZHJlc3MgaXMgdXNlZCB0aGVuIGFsbCBzZ3Mg
bXVzdCB1c2Ugc2ctPgo+IGRtYV9hZGRyZXNzLCBvdGhlcndpc2UgYWxsIGRtYV9hZGRyZXNzIG11
c3QgYmUgbnVsbC4KCiJtdXN0IGJlIG51bGwgd2hlbiBwYXNzaW5nIGl0IHRvIHZpcnRxdWV1ZV9h
ZGRfc2dzKCkiPwoKPgo+IE9uIHRoZSBub24taW5kaXJlY3QgcGF0aCwKClNob3VsZCBpdCBiZSAi
ZGlyZWN0IGRlc2MgcGF0aCI/Cgo+IGlmIGRtYV9hZGRyZXNzIGlzIHVzZWQsIGV4dHJhLmFkZHIg
d2lsbCBiZQo+IHNldCB0byBETUFfTUFQUElOR19FUlJPUi4gU28gd2hlbiBkbyB1bm1hcCwgd2Ug
Y2FuIHBhc3MgaXQuCgpJIGRvbid0IGdldCB0aGUgbWVhbmluZyBvZiAicGFzcyIgaGVyZS4gT3Ig
ZG8geW91IG1lYW4KRE1BX01BUElOR19FUlJPUiBpcyBhIGhpbnQgdGhhdCB0aGUgZGVzYyBpcyBt
YXBwZWQgYnkgdGhlIHVwcGVyIGxheWVyCmluc3RlYWQgb2YgdGhlIHZpcnRpbyBjb3JlPwoKPgo+
IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4g
LS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyMiArKysrKysrKysrKysrKy0t
LS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggMjIxZmY1NGZlNThiLi42MWRlYWYwYTRmYWYg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtNDU3LDYgKzQ1Nyw5IEBAIHN0YXRpYyB1bnNp
Z25lZCBpbnQgdnJpbmdfdW5tYXBfb25lX3NwbGl0KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChmbGFncyAmIFZSSU5H
X0RFU0NfRl9XUklURSkgPwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9G
Uk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+ICAgICAgICAgfSBlbHNlIHsKPiArICAgICAg
ICAgICAgICAgaWYgKGV4dHJhW2ldLmFkZHIgPT0gRE1BX01BUFBJTkdfRVJST1IpCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gKwo+ICAgICAgICAgICAgICAgICBkbWFfdW5t
YXBfcGFnZSh2cmluZ19kbWFfZGV2KHZxKSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZXh0cmFbaV0uYWRkciwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXh0cmFb
aV0ubGVuLAo+IEBAIC00OTcsNyArNTAwLDggQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQg
dmlydHF1ZXVlX2FkZF9kZXNjX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IGFk
ZHIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGludCBsZW4sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHUxNiBmbGFncywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpbmRpcmVjdCkKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBpbmRpcmVjdCwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBkb19t
YXApCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZyaW5nID0gdG9fdnZx
KHZxKTsKPiAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjX2V4dHJhICpleHRyYSA9IHZyaW5nLT5z
cGxpdC5kZXNjX2V4dHJhOwo+IEBAIC01MTEsNyArNTE1LDcgQEAgc3RhdGljIGlubGluZSB1bnNp
Z25lZCBpbnQgdmlydHF1ZXVlX2FkZF9kZXNjX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+
ICAgICAgICAgICAgICAgICBuZXh0ID0gZXh0cmFbaV0ubmV4dDsKPiAgICAgICAgICAgICAgICAg
ZGVzY1tpXS5uZXh0ID0gY3B1X3RvX3ZpcnRpbzE2KHZxLT52ZGV2LCBuZXh0KTsKPgo+IC0gICAg
ICAgICAgICAgICBleHRyYVtpXS5hZGRyID0gYWRkcjsKPiArICAgICAgICAgICAgICAgZXh0cmFb
aV0uYWRkciA9IGRvX21hcCA/IGFkZHIgOiBETUFfTUFQUElOR19FUlJPUjsKCkFueSByZWFzb24g
d2UgZG9uJ3QgbmVlZCB0byBkbyB0aGUgc2FtZSBmb3IgaW5kaXJlY3QgZGVzY3JpcHRvcnM/CgpU
aGFua3MKCj4gICAgICAgICAgICAgICAgIGV4dHJhW2ldLmxlbiA9IGxlbjsKPiAgICAgICAgICAg
ICAgICAgZXh0cmFbaV0uZmxhZ3MgPSBmbGFnczsKPiAgICAgICAgIH0gZWxzZQo+IEBAIC02MDQs
NyArNjA4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEsCj4gICAgICAgICBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnOwo+ICAgICAg
ICAgc3RydWN0IHZyaW5nX2Rlc2MgKmRlc2M7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgaSwgbiwg
YXZhaWwsIGRlc2NzX3VzZWQsIHByZXY7Cj4gLSAgICAgICBib29sIGluZGlyZWN0Owo+ICsgICAg
ICAgYm9vbCBpbmRpcmVjdCwgZG9fbWFwOwo+ICAgICAgICAgaW50IGhlYWQ7Cj4KPiAgICAgICAg
IFNUQVJUX1VTRSh2cSk7Cj4gQEAgLTY1Nyw3ICs2NjEsOCBAQCBzdGF0aWMgaW5saW5lIGludCB2
aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9TUEM7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIGlmICh2aXJ0cXVldWVf
bWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKSkKPiArICAgICAgIGRv
X21hcCA9ICFzZ3NbMF0tPmRtYV9hZGRyZXNzOwo+ICsgICAgICAgaWYgKGRvX21hcCAmJiB2aXJ0
cXVldWVfbWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKSkKPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4KPiAgICAgICAgIGZvciAobiA9IDA7IG4gPCBv
dXRfc2dzOyBuKyspIHsKPiBAQCAtNjcwLDcgKzY3NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZp
cnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ctPmRtYV9hZGRyZXNzLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ct
Pmxlbmd0aCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZSSU5HX0RFU0NfRl9ORVhULAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgaW5kaXJlY3QpOwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5kaXJlY3QsIGRvX21hcCk7Cj4gICAg
ICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPiAgICAgICAgIGZvciAoOyBuIDwgKG91dF9zZ3Mg
KyBpbl9zZ3MpOyBuKyspIHsKPiBAQCAtNjg0LDcgKzY4OSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50
IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2ctPmxlbmd0aCwKPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZSSU5H
X0RFU0NfRl9ORVhUIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFZSSU5HX0RFU0NfRl9XUklURSwKPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZGlyZWN0KTsKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZGlyZWN0LCBkb19tYXAp
Owo+ICAgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4gICAgICAgICAvKiBMYXN0IG9uZSBk
b2Vzbid0IGNvbnRpbnVlLiAqLwo+IEBAIC03MDUsNyArNzEwLDcgQEAgc3RhdGljIGlubGluZSBp
bnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZWFkLCBhZGRyLAo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdG90YWxfc2cgKiBzaXplb2Yoc3RydWN0IHZy
aW5nX2Rlc2MpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlJJ
TkdfREVTQ19GX0lORElSRUNULAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZmFsc2UpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZmFsc2UsIHRydWUpOwo+ICAgICAgICAgfQo+Cj4gICAgICAgICAvKiBXZSdyZSB1c2luZyBzb21l
IGJ1ZmZlcnMgZnJvbSB0aGUgZnJlZSBsaXN0LiAqLwo+IEBAIC03NDgsNyArNzUzLDggQEAgc3Rh
dGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEs
Cj4gICAgICAgICByZXR1cm4gMDsKPgo+ICB1bm1hcF9yZWxlYXNlOgo+IC0gICAgICAgdmlydHF1
ZXVlX3VubWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKTsKPiArICAg
ICAgIGlmIChkb19tYXApCj4gKyAgICAgICAgICAgICAgIHZpcnRxdWV1ZV91bm1hcF9zZ3ModnEs
IHNncywgdG90YWxfc2csIG91dF9zZ3MsIGluX3Nncyk7Cj4KPiAgICAgICAgIGlmIChpbmRpcmVj
dCkKPiAgICAgICAgICAgICAgICAga2ZyZWUoZGVzYyk7Cj4gLS0KPiAyLjMyLjAuMy5nMDExOTVj
ZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==

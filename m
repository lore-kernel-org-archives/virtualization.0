Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5EFC001DB
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 03:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8689607FE;
	Thu, 10 Aug 2023 03:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8689607FE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=agw26+RB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxf_AYK4aJIO; Thu, 10 Aug 2023 03:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6239A60AC1;
	Thu, 10 Aug 2023 03:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6239A60AC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3927CC0072;
	Thu, 10 Aug 2023 03:49:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84B40C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 467F981CA0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 467F981CA0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=agw26+RB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eqEGjoh9uUMC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:49:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7798881C2F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 03:49:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7798881C2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691639359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJ+2CJS5gcoBjnfl47+AqcZq3EUUKPpL818dVO/zupQ=;
 b=agw26+RBLGZaBmlgUB6qBqRhxE7ruHdLUO6ake6Mk2ZUAXmKtRQYyNt8Y6hFySvL+Q0JCY
 wnvxQfy7ixRClGM/9RoXe1k+8SagbwySOn9vmnevouTaqrT7wEaijcZ+CEFE93+h9eZq5W
 XEVtjFwh0ZSFzYUdMYhLZehiOUaM7XI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-TZOIbzx5P7OpeRVbhV8I3A-1; Wed, 09 Aug 2023 23:49:18 -0400
X-MC-Unique: TZOIbzx5P7OpeRVbhV8I3A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b9ce397ef1so5069051fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 20:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691639356; x=1692244156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJ+2CJS5gcoBjnfl47+AqcZq3EUUKPpL818dVO/zupQ=;
 b=jSQNebtCHtTV4QJ/xkBYPe/KcQZ+58TFlv5zZxoUurlHfw9bN/K5tL7u3wmCersh7k
 nd+Wvt1f8I2aX9LKhslKVCs9BTmNzKcEWEJE0YjcQ/gSbBE2pBQmaoXQcx2ho60NMaWL
 +OcN89OktRgidsZBKqep+yQKbhnrJEsIWzGHebfztblf2uU1sWbeCJNkWkraCvB6ngNR
 7ezvhcOYDovoJ8Q7XbEl1vrae8utON0iUF10LQyDidxdm67uwOilEwjgEPbWtGfNr61G
 ET50m2OJ8bnPLMq0C+l0jOOa1smYdmhEo7jFyebfSAc3gvPh2LS5j2VY3MwXmZfiREEQ
 dNvQ==
X-Gm-Message-State: AOJu0YxtPmYVsHUh43T1Z3zr7umpX/WVW9JOBvyNuKnokdOaxX+LrVE0
 B9n80sToFKxwojpYI3e3tAF3r+Uy5cJGT0PkfSEh/Af48/+TyaGuLdOVgj+zlXwnirnS1U57Y2y
 yQKscX3Hp+4x9caH2hhspdaTjWbzADOulIvA3cQyOmYK8Oyyoid3fTPaSfg==
X-Received: by 2002:a2e:9447:0:b0:2b6:cd6a:17f7 with SMTP id
 o7-20020a2e9447000000b002b6cd6a17f7mr796091ljh.20.1691639356363; 
 Wed, 09 Aug 2023 20:49:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ1oMbRJqF9jAY1CZ7ly+XJPjKRSO+vdG/xmlQ7r9TVMGUjUiz08qN//Hr7ZecO1K+IwRe9oHmzhpqbdhTj4Y=
X-Received: by 2002:a2e:9447:0:b0:2b6:cd6a:17f7 with SMTP id
 o7-20020a2e9447000000b002b6cd6a17f7mr796077ljh.20.1691639356075; Wed, 09 Aug
 2023 20:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <1691585683-3948-1-git-send-email-si-wei.liu@oracle.com>
 <1691585683-3948-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1691585683-3948-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 11:49:05 +0800
Message-ID: <CACGkMEsUM9d2QHtKUDSKO+qMJjRYhKy2w7J_RgwywrOv2tcJTw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] vhost-vdpa: introduce descriptor group backend
 feature
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

T24gV2VkLCBBdWcgOSwgMjAyMyBhdCA4OjU24oCvUE0gU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBv
cmFjbGUuY29tPiB3cm90ZToKPgo+IFVzZXJzcGFjZSBrbm93cyBpZiB0aGUgZGV2aWNlIGhhcyBk
ZWRpY2F0ZWQgZGVzY3JpcHRvciBncm91cCBvciBub3QKPiBieSBjaGVja2luZyB0aGlzIGZlYXR1
cmUgYml0Lgo+Cj4gSXQncyBvbmx5IGV4cG9zZWQgaWYgdGhlIHZkcGEgZHJpdmVyIGJhY2tlbmQg
aW1wbGVtZW50cyB0aGUKPiAuZ2V0X3ZxX2Rlc2NfZ3JvdXAoKSBvcGVyYXRpb24gY2FsbGJhY2su
IFVzZXJzcGFjZSB0cnlpbmcgdG8gbmVnb3RpYXRlCj4gdGhpcyBmZWF0dXJlIHdoZW4gaXQgb3Ig
dGhlIGRlcGVuZGVudCBfRl9JT1RMQl9BU0lEIGZlYXR1cmUgaGFzbid0Cj4gYmVlbiBleHBvc2Vk
IHdpbGwgcmVzdWx0IGluIGFuIGVycm9yLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8
c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAg
ICAgICAgICB8IDE3ICsrKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvdWFwaS9saW51eC92aG9z
dF90eXBlcy5oIHwgIDUgKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3Zk
cGEuYwo+IGluZGV4IGI0M2U4NjguLmYyZTVkY2UgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0zODksNiArMzg5LDE0
IEBAIHN0YXRpYyBib29sIHZob3N0X3ZkcGFfY2FuX3Jlc3VtZShjb25zdCBzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdikKPiAgICAgICAgIHJldHVybiBvcHMtPnJlc3VtZTsKPiAgfQo+Cj4gK3N0YXRpYyBi
b29sIHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEgKnYp
Cj4gK3sKPiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gKyAg
ICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4g
Kwo+ICsgICAgICAgcmV0dXJuIG9wcy0+Z2V0X3ZxX2Rlc2NfZ3JvdXA7Cj4gK30KPiArCj4gIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1
NjQgX191c2VyICpmZWF0dXJlcCkKPiAgewo+ICAgICAgICAgc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhID0gdi0+dmRwYTsKPiBAQCAtNjc5LDYgKzY4Nyw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3Zk
cGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ICAgICAgICAgICAgICAgICBp
ZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1cmVzLCBmZWF0dXJlcCwgc2l6ZW9mKGZlYXR1cmVzKSkp
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FRkFVTFQ7Cj4gICAgICAgICAgICAg
ICAgIGlmIChmZWF0dXJlcyAmIH4oVkhPU1RfVkRQQV9CQUNLRU5EX0ZFQVRVUkVTIHwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9ERVND
X0FTSUQpIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NU
X0JBQ0tFTkRfRl9TVVNQRU5EKSB8Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSkpCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+IEBAIC02ODgsNiArNjk3LDEyIEBAIHN0YXRpYyBsb25n
IHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+ICAgICAgICAg
ICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSkg
JiYKPiAgICAgICAgICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9jYW5fcmVzdW1lKHYpKQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPiArICAgICAgICAgICAg
ICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCkpICYm
Cj4gKyAgICAgICAgICAgICAgICAgICAhKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5E
X0ZfSU9UTEJfQVNJRCkpKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Owo+ICsgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5E
X0ZfREVTQ19BU0lEKSkgJiYKPiArICAgICAgICAgICAgICAgICAgICAhdmhvc3RfdmRwYV9oYXNf
ZGVzY19ncm91cCh2KSkKPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNV
UFA7Cj4gICAgICAgICAgICAgICAgIHZob3N0X3NldF9iYWNrZW5kX2ZlYXR1cmVzKCZ2LT52ZGV2
LCBmZWF0dXJlcyk7Cj4gICAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgICAgfQo+IEBA
IC03NDEsNiArNzU2LDggQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChz
dHJ1Y3QgZmlsZSAqZmlsZXAsCj4gICAgICAgICAgICAgICAgICAgICAgICAgZmVhdHVyZXMgfD0g
QklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfU1VTUEVORCk7Cj4gICAgICAgICAgICAgICAgIGlmICh2
aG9zdF92ZHBhX2Nhbl9yZXN1bWUodikpCj4gICAgICAgICAgICAgICAgICAgICAgICAgZmVhdHVy
ZXMgfD0gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKTsKPiArICAgICAgICAgICAgICAg
aWYgKHZob3N0X3ZkcGFfaGFzX2Rlc2NfZ3JvdXAodikpCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZmVhdHVyZXMgfD0gQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKTsKPiAgICAg
ICAgICAgICAgICAgaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZlYXR1cmVzLCBzaXplb2Yo
ZmVhdHVyZXMpKSkKPiAgICAgICAgICAgICAgICAgICAgICAgICByID0gLUVGQVVMVDsKPiAgICAg
ICAgICAgICAgICAgYnJlYWs7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9z
dF90eXBlcy5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKPiBpbmRleCBkM2Fh
ZDEyYS4uMDg1NmY4NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlw
ZXMuaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oCj4gQEAgLTE4MSw1
ICsxODEsMTAgQEAgc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZSB7Cj4gICNkZWZpbmUgVkhP
U1RfQkFDS0VORF9GX1NVU1BFTkQgIDB4NAo+ICAvKiBEZXZpY2UgY2FuIGJlIHJlc3VtZWQgKi8K
PiAgI2RlZmluZSBWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FICAweDUKPiArLyogRGV2aWNlIG1heSBl
eHBvc2UgdGhlIGRlc2NyaXB0b3IgdGFibGUsIGF2YWlsIGFuZCB1c2VkIHJpbmcgaW4gYQo+ICsg
KiBkaWZmZXJlbnQgZ3JvdXAgZm9yIEFTSUQgYmluZGluZyB0aGFuIHRoZSBidWZmZXJzIGl0IGNv
bnRhaW5zLgoKTml0OgoKcy9hIGRpZmZlcmVudCBncm91cC9kaWZmZXJlbnQgZ3JvdXBzLz8KCkJ0
dywgbm90IGEgbmF0aXZlIHNwZWFrZXIgYnV0IEkgdGhpbmsgImRlc2NyaXB0b3IiIG1pZ2h0IGJl
IGNvbmZ1c2luZwpzaW5jZSBhcyB5b3UgZXhwbGFpbmVkIGFib3ZlLCBpdCBjb250YWlucyBtb3Jl
IHRoYW4ganVzdCBhIGRlc2NyaXB0b3IKdGFibGUuCgpUaGFua3MKCj4gKyAqIFJlcXVpcmVzIFZI
T1NUX0JBQ0tFTkRfRl9JT1RMQl9BU0lELgo+ICsgKi8KPiArI2RlZmluZSBWSE9TVF9CQUNLRU5E
X0ZfREVTQ19BU0lEICAgIDB4Ngo+Cj4gICNlbmRpZgo+IC0tCj4gMS44LjMuMQo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

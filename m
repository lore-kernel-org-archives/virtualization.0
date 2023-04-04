Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC0AC6FD1D
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 05:09:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2E2D81831;
	Tue,  4 Apr 2023 05:09:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2E2D81831
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfMQ2h0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EkrnpScXtUV6; Tue,  4 Apr 2023 05:09:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56806817A6;
	Tue,  4 Apr 2023 05:09:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56806817A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1ED61C0037;
	Tue,  4 Apr 2023 05:09:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0364C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 05:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CACCB60C01
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 05:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CACCB60C01
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZfMQ2h0D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NZT9ssFL82yx
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 05:09:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1F0660B29
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1F0660B29
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 05:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680584968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DtSmCOb+v6Aja8Snz6cRh8a5xQ73rU+y+MxUvmoB5w=;
 b=ZfMQ2h0D1BN+2xTt1RnXkpZ/TmDIuc6B1tYw/6mgqDZ4Z7MsjrgbTr4TvuriSGVWjlKY9G
 a42PTtWmVjsafg+AT2pa5+VAXRa+3Xfpsji1sKDkreX17SIo9gqnSD4wHfOfasiOpZ/ic6
 HSbqBgrdia/uckqArKb4MOEi1sjYRdg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-p0XShPHAPbW4Ro9OA6gV4g-1; Tue, 04 Apr 2023 01:09:27 -0400
X-MC-Unique: p0XShPHAPbW4Ro9OA6gV4g-1
Received: by mail-oo1-f70.google.com with SMTP id
 h10-20020a4a420a000000b0053685955a14so8295228ooj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 22:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680584966; x=1683176966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DtSmCOb+v6Aja8Snz6cRh8a5xQ73rU+y+MxUvmoB5w=;
 b=KITKD8cU4AnLQLTfgBcN1bTZ2fY1JZNjdy9eJsDWs5jp1eWGQf9kWxtOJX8WO0nbQH
 bnZb6Gw6yQ55eFCy2aLfFhuPD2yP70nGRmIckuD47thf/pF+4TYwDEKiQ6dEYsjPMI9h
 FYb+JeYYN5RslKqIFlEqmv2nj/5w4RaV1tH7Ay1ciuDTJyRQotdW1WIzIMIqu8MyXbhc
 5JE9tSWqg3n0cowpiXgMcaxOSYTf8eL1/KzCtcio/enEfSbCSUi0yrRxylwlX082lYp0
 7/iUbkRmQJJEKGi0R2VVgcu+7DlH2UKjfaWy7q0WWgxlSGPx5FXhmIFKSKHNtHTcXLCl
 9tOg==
X-Gm-Message-State: AAQBX9fhYaVoGV9VuMF/rsFL7D7U14LEXTlmdk3Zq2TlURd9oKLhfn8u
 rCQFc+Iyi6iHKFeCmDpxMzFoP8lWBRDd/pdk3xWnL9ALTyx+d9Lu+ikPgxcmJk5sqtjxLl+HST1
 FDtIx1Y8lsTfFLd2dTtAQ79Qo7pGoWegPFk4Y78On01gNVwc+RqLEWa9uJQ==
X-Received: by 2002:a9d:6ac9:0:b0:698:f988:7c30 with SMTP id
 m9-20020a9d6ac9000000b00698f9887c30mr464116otq.2.1680584966443; 
 Mon, 03 Apr 2023 22:09:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aToN5Ty4ARZswBJi573g8x6To+0D8j5yMs4eaikuT4iv5JrVIRglWxiK9LuTjI6EH/6L0UcA7gizeZHXTeyQA=
X-Received: by 2002:a9d:6ac9:0:b0:698:f988:7c30 with SMTP id
 m9-20020a9d6ac9000000b00698f9887c30mr464113otq.2.1680584966204; Mon, 03 Apr
 2023 22:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Apr 2023 13:09:15 +0800
Message-ID: <CACGkMEuQo+ojjtjH=Ne0e5wESERUPmSvCDgTXwepz=TR7fO8RQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 viktor@daynix.com, mst@redhat.com
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

T24gU3VuLCBBcHIgMiwgMjAyMyBhdCA0OjEw4oCvUE0gQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fy
c3pAc29saWQtcnVuLmNvbT4gd3JvdGU6Cj4KPiBBZGQgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RB
VEEgc3VwcG9ydCBmb3IgdkRQQSB0cmFuc3BvcnQuCj4gSWYgdGhpcyBmZWF0dXJlIGlzIG5lZ290
aWF0ZWQsIHRoZSBkcml2ZXIgcGFzc2VzIGV4dHJhIGRhdGEgd2hlbiBraWNraW5nCj4gYSB2aXJ0
cXVldWUuCj4KPiBBIGRldmljZSB0aGF0IG9mZmVycyB0aGlzIGZlYXR1cmUgbmVlZHMgdG8gaW1w
bGVtZW50IHRoZQo+IGtpY2tfdnFfd2l0aF9kYXRhIGNhbGxiYWNrLgo+Cj4ga2lja192cV93aXRo
X2RhdGEgcmVjZWl2ZXMgdGhlIHZEUEEgZGV2aWNlIGFuZCBkYXRhLgo+IGRhdGEgaW5jbHVkZXMg
dGhlIHZxbiwgbmV4dF9vZmYgYW5kIG5leHRfd3JhcCBmb3IgcGFja2VkIHZpcnRxdWV1ZXMuCj4K
PiBUaGlzIHBhdGNoIGZvbGxvd3MgYSBwYXRjaCBbMV0gYnkgVmlrdG9yIFBydXR5YW5vdiB3aGlj
aCBhZGRzIHN1cHBvcnQKPiBmb3IgdGhlIE1NSU8sIGNoYW5uZWwgSS9PIGFuZCBtb2Rlcm4gUENJ
IHRyYW5zcG9ydHMuCj4KPiBUaGlzIHBhdGNoIG5lZWRzIHRvIGJlIGFwcGxpZWQgb24gdG9wIG9m
IFZpa3RvcidzIHBhdGNoLgo+Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MzAzMjQxOTUwMjkuMjQxMDUwMy0xLXZpa3RvckBkYXluaXguY29tLwo+Cj4gU2lnbmVkLW9mZi1i
eTogQWx2YXJvIEthcnN6IDxhbHZhcm8ua2Fyc3pAc29saWQtcnVuLmNvbT4KPiAtLS0KPiAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDIwICsrKysrKysrKysrKysrKysrKy0tCj4gIGlu
Y2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgfCAgNiArKysrKysKPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4g
aW5kZXggZDdmNWFmNjJkZGEuLmJkYWYzMGY3ZmJmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmly
dGlvL3ZpcnRpb192ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4g
QEAgLTExMiw2ICsxMTIsMTcgQEAgc3RhdGljIGJvb2wgdmlydGlvX3ZkcGFfbm90aWZ5KHN0cnVj
dCB2aXJ0cXVldWUgKnZxKQo+ICAgICAgICAgcmV0dXJuIHRydWU7Cj4gIH0KPgo+ICtzdGF0aWMg
Ym9vbCB2aXJ0aW9fdmRwYV9ub3RpZnlfd2l0aF9kYXRhKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+
ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2ZF9nZXRfdmRwYSh2cS0+
dmRldik7Cj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBh
LT5jb25maWc7Cj4gKyAgICAgICB1MzIgZGF0YSA9IHZyaW5nX25vdGlmaWNhdGlvbl9kYXRhKHZx
KTsKPiArCj4gKyAgICAgICBvcHMtPmtpY2tfdnFfd2l0aF9kYXRhKHZkcGEsIGRhdGEpOwo+ICsK
PiArICAgICAgIHJldHVybiB0cnVlOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaXJxcmV0dXJuX3Qgdmly
dGlvX3ZkcGFfY29uZmlnX2NiKHZvaWQgKnByaXZhdGUpCj4gIHsKPiAgICAgICAgIHN0cnVjdCB2
aXJ0aW9fdmRwYV9kZXZpY2UgKnZkX2RldiA9IHByaXZhdGU7Cj4gQEAgLTEzOCw2ICsxNDksNyBA
QCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWdu
ZWQgaW50IGluZGV4LAo+ICAgICAgICAgc3RydWN0IGRldmljZSAqZG1hX2RldjsKPiAgICAgICAg
IGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiAgICAg
ICAgIHN0cnVjdCB2aXJ0aW9fdmRwYV92cV9pbmZvICppbmZvOwo+ICsgICAgICAgYm9vbCAoKm5v
dGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEpOwo+ICAgICAgICAgc3RydWN0IHZkcGFfY2FsbGJh
Y2sgY2I7Cj4gICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiAgICAgICAgIHU2NCBkZXNj
X2FkZHIsIGRyaXZlcl9hZGRyLCBkZXZpY2VfYWRkcjsKPiBAQCAtMTU0LDYgKzE2NiwxMSBAQCB2
aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQg
aW50IGluZGV4LAo+ICAgICAgICAgaWYgKGluZGV4ID49IHZkcGEtPm52cXMpCj4gICAgICAgICAg
ICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+Cj4gKyAgICAgICBpZiAoX192aXJ0aW9f
dGVzdF9iaXQodmRldiwgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEpKQo+ICsgICAgICAgICAg
ICAgICBub3RpZnkgPSB2aXJ0aW9fdmRwYV9ub3RpZnlfd2l0aF9kYXRhOwo+ICsgICAgICAgZWxz
ZQo+ICsgICAgICAgICAgICAgICBub3RpZnkgPSB2aXJ0aW9fdmRwYV9ub3RpZnk7Cj4gKwo+ICAg
ICAgICAgLyogUXVldWUgc2hvdWxkbid0IGFscmVhZHkgYmUgc2V0IHVwLiAqLwo+ICAgICAgICAg
aWYgKG9wcy0+Z2V0X3ZxX3JlYWR5KHZkcGEsIGluZGV4KSkKPiAgICAgICAgICAgICAgICAgcmV0
dXJuIEVSUl9QVFIoLUVOT0VOVCk7Cj4gQEAgLTE4Myw4ICsyMDAsNyBAQCB2aXJ0aW9fdmRwYV9z
ZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IGluZGV4LAo+
ICAgICAgICAgICAgICAgICBkbWFfZGV2ID0gdmRwYV9nZXRfZG1hX2Rldih2ZHBhKTsKPiAgICAg
ICAgIHZxID0gdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9kbWEoaW5kZXgsIG1heF9udW0sIGFsaWdu
LCB2ZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0cnVlLCBt
YXlfcmVkdWNlX251bSwgY3R4LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2aXJ0aW9fdmRwYV9ub3RpZnksIGNhbGxiYWNrLAo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBuYW1lLCBkbWFfZGV2KTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbm90aWZ5LCBjYWxsYmFjaywgbmFtZSwgZG1hX2Rldik7Cj4g
ICAgICAgICBpZiAoIXZxKSB7Cj4gICAgICAgICAgICAgICAgIGVyciA9IC1FTk9NRU07Cj4gICAg
ICAgICAgICAgICAgIGdvdG8gZXJyb3JfbmV3X3ZpcnRxdWV1ZTsKPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IGluZGV4IDQzZjU5ZWYx
MGNjLi5hODNiYjA1MDFjNSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsr
KyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTE0Myw2ICsxNDMsMTEgQEAgc3RydWN0IHZk
cGFfbWFwX2ZpbGUgewo+ICAgKiBAa2lja192cTogICAgICAgICAgICAgICAgICAgS2ljayB0aGUg
dmlydHF1ZXVlCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBk
ZXZpY2UKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBpZHg6IHZpcnRxdWV1ZSBp
bmRleAo+ICsgKiBAa2lja192cV93aXRoX2RhdGE6ICAgICAgICAgS2ljayB0aGUgdmlydHF1ZXVl
IGFuZCBzdXBwbHkgZXh0cmEgZGF0YQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KG9ubHkgaWYgVklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEgaXMgbmVnb3RpYXRlZCkKPiArICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+ICsgKiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQGRhdGE6IGluY2x1ZGVzIHZxbiwgbmV4dF9vZmYgYW5k
IG5leHRfd3JhcCBmb3IKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhY2tlZCB2
aXJ0cXVldWVzCgpUaGlzIG5lZWRzIHNvbWUgdHdlYWtpbmcsIFZJUlRJT19GX05PVElGSUNBVElP
Tl9EQVRBIHdvcmtzIGZvciBzcGxpdAp2aXJ0cXVldWUgYXMgd2VsbC4KClRoYW5rcwoKPiAgICog
QHNldF92cV9jYjogICAgICAgICAgICAgICAgIFNldCB0aGUgaW50ZXJydXB0IGNhbGxiYWNrIGZ1
bmN0aW9uIGZvcgo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYSB2aXJ0cXVldWUK
PiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2OiB2ZHBhIGRldmljZQo+IEBA
IC0zMDAsNiArMzA1LDcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdTY0IGRldmljZV9hcmVhKTsKPiAgICAgICAgIHZvaWQgKCpzZXRf
dnFfbnVtKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIHUzMiBudW0pOwo+ICAg
ICAgICAgdm9pZCAoKmtpY2tfdnEpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCk7
Cj4gKyAgICAgICB2b2lkICgqa2lja192cV93aXRoX2RhdGEpKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdTMyIGRhdGEpOwo+ICAgICAgICAgdm9pZCAoKnNldF92cV9jYikoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHZkcGFfY2FsbGJhY2sgKmNiKTsKPiAgICAgICAgIHZvaWQgKCpzZXRfdnFfcmVhZHkpKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgYm9vbCByZWFkeSk7Cj4gLS0KPiAyLjM0LjEK
PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u

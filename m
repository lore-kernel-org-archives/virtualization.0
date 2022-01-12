Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBD1C433F5
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 15:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2B70640A46;
	Wed, 12 Jan 2022 15:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOfrXXWai-RN; Wed, 12 Jan 2022 15:02:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76B3D40A28;
	Wed, 12 Jan 2022 15:02:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BFDDC0030;
	Wed, 12 Jan 2022 15:02:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD2FC001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 15:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 267EA40A4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 15:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YZYHqQu2ZaA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 15:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B23840A48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 15:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641999734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7f6mTNt7YaUSpPXZZCZPgQVj1/ZDxnN/2snqOElACbM=;
 b=SNEVa/I7+0zWG45IVIOi8FpSaV80EoLNAyc0S5YljveNY07179xo7W1CBoDmKD1M66Xs09
 I3BO/Tf028rwGwPOG7PvfdeNr2Kd78WlgHXMDGWaBrB4BcNz2nRQ/W9WKf5lm/9lYf8Db7
 YgoAq8MUV1bFFt+tCXN2eOQDZD3Jd2c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-YyfxmTuePOeBg41RHqe_ew-1; Wed, 12 Jan 2022 10:02:13 -0500
X-MC-Unique: YyfxmTuePOeBg41RHqe_ew-1
Received: by mail-ed1-f69.google.com with SMTP id
 v18-20020a056402349200b003f8d3b7ee8dso2458104edc.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 07:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7f6mTNt7YaUSpPXZZCZPgQVj1/ZDxnN/2snqOElACbM=;
 b=pqdYSE6csY7AeB3v4ISAnsOF3nFswXQoIqDtw/bVgmacn7T/0LEs/o5Uwake2nX5ov
 Gfngq5+MtlRDZ6eOm/pKTTUfRBDPPp08WZrVcMk5TX+wgpvX2DnIG/vXRa2PQV0mDJXx
 DgWwg9Don/I3X8AKBTcPLEPULgrIhHGco25kAt2VLTGQTgTsXjyV960QuKGDjPn6LZTS
 /0oaoKHoS1oJOmZfbfD/ZHLk5Bi7l9NRJExiskkk5xlK8o8ybvt4gH2yVRUYgFwOjIjd
 Aj3yHQJmGDytT8JxCBuyPKA6pz2bi6Nw6f4cmR3vFe6xUKiiYCdz4NtOQRWwXKAEbhRF
 P3DA==
X-Gm-Message-State: AOAM530a9d2dsswtlag9X7qRCjE7xzt6y17TGRDzkN6xwH4FrDA6puEJ
 tQ6rhrn2rFF82qf1cNWkN1q5zEWvZtL4BnxPUpQlxQFKl+tdPHyG3jLnAN10IZYjoM8IuuG+YwL
 K0arONfZZutPgq0fSaxFlopSS4+oqQ1bNpup1qi8vpQ==
X-Received: by 2002:a05:6402:190d:: with SMTP id
 e13mr54965edz.414.1641999728542; 
 Wed, 12 Jan 2022 07:02:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQRAl2uTikFNex8JGdk4/ia/gTryowOeWKg0HXYHyybKohwCELxbZl+CxPAksdmOkmMm7hQw==
X-Received: by 2002:a05:6402:190d:: with SMTP id
 e13mr54945edz.414.1641999728332; 
 Wed, 12 Jan 2022 07:02:08 -0800 (PST)
Received: from redhat.com ([2.55.132.148])
 by smtp.gmail.com with ESMTPSA id h13sm16749edl.96.2022.01.12.07.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jan 2022 07:02:07 -0800 (PST)
Date: Wed, 12 Jan 2022 10:02:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
Message-ID: <20220112100006-mutt-send-email-mst@kernel.org>
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
 <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
 <20220112013018-mutt-send-email-mst@kernel.org>
 <tencent_18F8A88D22E327230EF313BE@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_18F8A88D22E327230EF313BE@qq.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

Ck9uIFdlZCwgSmFuIDEyLCAyMDIyIGF0IDA0OjQ0OjA4UE0gKzA4MDAsIOadjuS4nOWNhyB3cm90
ZToKPiBJbmRlZWQsIHRoZXJlIGFyZSBoaWRkZW4gZGFuZ2VycyBmb3Igc3RvcmFnZSBkZXZpY2Vz
Lgo+IFNvIG1heWJlIHdlIGNhbiBicmVhayB0aGUgZGV2aWNlIGJlZm9yZSB2aXJ0aW9fbmV0IHVu
cmVnaXN0ZXJfbmV0ZGV2IGFuZCBiZWZvcmUKPiB2aXJ0aW9fYmxrIHJlc2V0Cj4gCj4gVW5saWtl
IHBjaSBkZXZpY2UsIHRoZXJlIGlzIGEgbWFudWZhY3R1cmVyLWRyaXZlbiBleGlzdGVuY2UgYmV0
d2VlbiB2aXJ0aW8gdmRwYQo+IGFuZCBoYXJkd2FyZSBkZXZpY2VzLCAKPiB1bmxlc3MgdGhlIG1h
bnVmYWN0dXJlciBwcm92aWRlcyBhIHN0YXRlIGludGVyZmFjZSwgdmlydGlvIHZkcGEgYW5kCj4g
aGlnaGVyLWxldmVsIGRyaXZlcnMgY2Fubm90IG9idGFpbiB0aGUgcmVhbCBoYXJkd2FyZSBzdGF0
ZS4KCkkgdGhpbmsgZm9yIHN1cnByaXNlIHJlbW92YWwgeW91IG5lZWQgdG8gcHJvcGFnYXRlIHRo
ZSBwcmVzZW5jZSBzdGF0dXMgdXAuCk5vIHdheSBhcm91bmQgdGhhdCBpbWhvLgoKPiAKPiAtLS0t
LS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tCj4gRnJvbTogICJtc3Qi
PG1zdEByZWRoYXQuY29tPjsKPiBEYXRlOiAgV2VkLCBKYW4gMTIsIDIwMjIgMDI6MzAgUE0KPiBU
bzogICJqYXNvd2FuZyI8amFzb3dhbmdAcmVkaGF0LmNvbT47Cj4gQ2M6ICAi5p2O5Lic5Y2HIjxs
aWRvbmdzaGVuZ0BkYXl1ZHB1LmNvbT47ICJ2aXJ0dWFsaXphdGlvbiIKPiA8dmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc+OyAibGludXgta2VybmVsIgo+IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsKPiBTdWJqZWN0OiAgUmU6IFtQQVRDSF0gdmlydGlvX3Zk
cGE6IFN1cHBvcnQgc3VycHJpc2UgcmVtb3ZhbCBvZiB2aXJ0aW8gdmRwYQo+IGRldmljZQo+ICAK
PiBPbiBXZWQsIEphbiAxMiwgMjAyMiBhdCAxMDoyMzowN0FNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gT24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgNzo1MiBQTSBNaWNoYWVsIFMuIFRzaXJr
aW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gVHVlLCBKYW4gMTEsIDIw
MjIgYXQgMTE6MzY6NDJBTSArMDgwMCwg5p2O5Lic5Y2HIHdyb3RlOgo+ID4gPiA+IFdoZW4gdmly
dGlvIHZkcGEgZGV2aWNlIHJlbW92ZWQsIHRoZSBhYm5vcm1hbCBkYW1hZ2Ugb2YgdGhlIGRldmlj
ZSBjYW5ub3QKPiBiZQo+ID4gPiA+IHBlcmNlaXZlZCBub3JtYWxseSwgd2hpY2ggd2lsbCBjYXVz
ZSBwcm9ibGVtcyBzaW1pbGFyIHRvOgo+ID4gPiA+Cj4gPiA+ID4gNDNiYjQwYzViOTI2Cj4gPiA+
Cj4gPiA+Cj4gPiA+IFNob3VsZCBpbmNsdWRlIHRoZSBzdWJqZWN0IG9mIHRoZSBwYXRjaCB0b28u
Cj4gPiA+Cj4gPiA+ID4gSGVuY2UsIGFkZCB0aGUgYWJpbGl0eSB0byBhYm9ydCB0aGUgY29tbWFu
ZCBvbiBzdXJwcmlzZSByZW1vdmFsCj4gPiA+ID4KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBkb25n
c2hlbmcgbGkgPGxpZG9uZ3NoZW5nQGRheXVkcHUuY29tPgo+ID4gPgo+ID4gPiBXaGVuIHJlbW92
aW5nIGdyYWNlZnVsbHksCj4gPiA+IEkgYW0gbm90IHN1cmUgd2Ugc2hvdWxkIGJyZWFrIGRldmlj
ZSB1bmNvbmRpdGlvbmFsbHkgbGlrZSB0aGlzCj4gPiA+IGJlZm9yZSBnaXZpbmcgZHJpdmVycyBh
IGNoYW5jZSB0byBjbGVhbiB1cC4KPiA+ID4gU2hvdWxkIHdlIGp1c3QgZG8gaXQgZm9yIHN1cnBy
aXNlIHJlbW92YWw/Cj4gPgo+ID4gVGhhdCByZXF1aXJlcyBhIG5ldyBtZXRob2QgdG8gcXVlcnkg
d2hldGhlciBpdCdzIGEgc3VycHJpc2UgcmVtb3ZhbC4KPiA+Cj4gPiBUaGFua3MKPiAKPiBXZSBj
YW4gY2hlY2sgcGNpX2RldmljZV9pc19wcmVzZW50IGxpa2UgdmlydGlvIGRvZXMuCj4gCj4gPiA+
Cj4gPiA+ID4gLS0tCj4gPiA+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAxICsK
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPiA+ID4KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb192ZHBhLmMKPiA+ID4gPiBpbmRleCA0YTlkZGI0NGIyYTcuLmZkOTMwNDA5ZDE5MCAx
MDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiA+ID4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gPiA+IEBAIC0zNzQsNiArMzc0
LDcgQEAgc3RhdGljIHZvaWQgdmlydGlvX3ZkcGFfcmVtb3ZlKHN0cnVjdCB2ZHBhX2RldmljZQo+
ICp2ZHBhKQo+ID4gPiA+ICB7Cj4gPiA+ID4gICBzdHJ1Y3QgdmlydGlvX3ZkcGFfZGV2aWNlICp2
ZF9kZXYgPSB2ZHBhX2dldF9kcnZkYXRhKHZkcGEpOwo+ID4gPiA+Cj4gPiA+ID4gKyB2aXJ0aW9f
YnJlYWtfZGV2aWNlKHZkX2Rldi0+dmRldik7Cj4gPiA+ID4gICB1bnJlZ2lzdGVyX3ZpcnRpb19k
ZXZpY2UoJnZkX2Rldi0+dmRldik7Cj4gPiA+ID4gIH0KPiA+ID4gPgo+ID4gPiA+IC0tCj4gPiA+
ID4gMi4xNy4xCj4gPiA+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

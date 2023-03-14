Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE53AC6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 03:40:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 098C14182F;
	Tue, 14 Mar 2023 03:40:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 098C14182F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXxkpK9X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ducikaxUkZel; Tue, 14 Mar 2023 03:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4325441823;
	Tue, 14 Mar 2023 03:39:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4325441823
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1909EC0071;
	Tue, 14 Mar 2023 03:39:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5237C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8066940286
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8066940286
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PXxkpK9X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YNYklQnp-1aY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:39:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F7694012E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F7694012E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 03:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678765195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+KhYBy1SbrL35uZcxmV9N94m0DcgNaM+uqRNvBlRXOo=;
 b=PXxkpK9XrIAKlAAXdjb7p7PZa2EMiViPOpmzm3ohR1Uh7ARJEaHm7wLqN92F2Zci6nDJ1b
 MLnNSTk0nryczqFvyAYw7xE3LUt1L1jy3Lb/0vv8WKtPtZYS310Zr5eMW7aXfYhhUrGBkr
 ui3ddoFk0OOxgKxtc0Bu/dcyr9EYpWg=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-AF03AJlZPOSjluGwUGbcYQ-1; Mon, 13 Mar 2023 23:39:54 -0400
X-MC-Unique: AF03AJlZPOSjluGwUGbcYQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1768297308eso8399806fac.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Mar 2023 20:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678765193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KhYBy1SbrL35uZcxmV9N94m0DcgNaM+uqRNvBlRXOo=;
 b=feP9bPTCCN/nh9CW55yDCunVtbZ+8LEEUNYaFKjxPpJDGoFj8bYlhWxMEAnFzNR33z
 N2/JaihRWxU7ePJrcsHflCwCdNuZTxD/ng2JPsZyOv03SWUj7hcsLmzRcgId2OozJIm7
 vIM+QFXvNL7YVs3rUB3g9sDPCZn2GInKRqXPpfcpLDL5pGVXqIEYE3qwBC3mSV49U9I1
 afc3KvqYyApM2P5/tKI0bD6qaF4DwVFLGNFPFZkHGyGPV7ftHShENPuN0ULbhc4tlqDr
 deCLHw1ZSdApPaFQsyGtZxPPrbIUfYKJIYSUy96ve7/ZrvmmVcBfs7zHMAHOWnBny/gS
 PuWA==
X-Gm-Message-State: AO0yUKW3fu8sLYvBPnj0ZazIIkcxFuOawK+bzw4zsM1/8iwh3LLHhfoa
 3JtmFDsMUTCg7TpIP9Cgu3vP/eXfBs+VtsUvATxX8DYww6UbcoCXRwd93MUCq/YUK8tnR3EhOdW
 5Pmtkdkhod+Q1Op+kb0J2lzxmPeN9jr3vAdw8lc/aP/OviQ4Ws0UNdiSHpg==
X-Received: by 2002:a05:6871:2315:b0:177:c2fb:8cec with SMTP id
 sf21-20020a056871231500b00177c2fb8cecmr1799908oab.9.1678765193356; 
 Mon, 13 Mar 2023 20:39:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set+cFgrKo8wDV2ck1Qw5dHYFA97psqjJwMF030XPXaImHObBym9NO6DrXVSlK3PnFCXSfBC5voQVIZy0kLV1jCI=
X-Received: by 2002:a05:6871:2315:b0:177:c2fb:8cec with SMTP id
 sf21-20020a056871231500b00177c2fb8cecmr1799898oab.9.1678765193106; Mon, 13
 Mar 2023 20:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-2-sgarzare@redhat.com>
In-Reply-To: <20230302113421.174582-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 11:39:42 +0800
Message-ID: <CACGkMEv24Zw-OUbBBSne21pF7=4XCZ6JGj7Y_cC7cMFYTjbF1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] vdpa: add bind_mm/unbind_mm callbacks
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjM04oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPiB3cm90ZToKPgo+IFRoZXNlIG5ldyBvcHRpb25hbCBjYWxsYmFja3Mg
aXMgdXNlZCB0byBiaW5kL3VuYmluZCB0aGUgZGV2aWNlIHRvCj4gYSBzcGVjaWZpYyBhZGRyZXNz
IHNwYWNlIHNvIHRoZSB2RFBBIGZyYW1ld29yayBjYW4gdXNlIFZBIHdoZW4KPiB0aGVzZSBjYWxs
YmFja3MgYXJlIGltcGxlbWVudGVkLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KCk9uZSB0aGluZyB0aGF0IGNhbWUgaW50byBteSBtaW5k
IGlzIHRoYXQgYWZ0ZXIgdGhpcyBjb21taXQ6Cgpjb21taXQgNWNlOTk1ZjMxM2NlNTZjMGM2MjQy
NWMzZGRjMzdjNWM1MGZjMzNkYgpBdXRob3I6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+CkRhdGU6ICAgRnJpIE1heSAyOSAxNjowMjo1OSAyMDIwICswODAwCgogICAgdmhvc3Q6IHVz
ZSBtbWdyYWIoKSBpbnN0ZWFkIG9mIG1tZ2V0KCkgZm9yIG5vbiB3b3JrZXIgZGV2aWNlCgogICAg
Rm9yIHRoZSBkZXZpY2UgdGhhdCBkb2Vzbid0IHVzZSB2aG9zdCB3b3JrZXIgYW5kIHVzZV9tbSgp
LCBtbWdldCgpIGlzCiAgICB0b28gaGVhdnkgd2VpZ2h0IGFuZCBpdCBtYXkgYnJpbmdzIHRyb3Vi
bGVzIGZvciBpbXBsZW1lbnRpbmcgbW1hcCgpCiAgICBzdXBwb3J0IGZvciB2RFBBIGRldmljZS4K
CldlIGRvbid0IGhvbGQgdGhlIGFkZHJlc3Mgc3BhY2UgYWZ0ZXIgdGhpcyBjb21taXQsIHNvIHRo
ZSB1c2Vyc3BhY2UKbWFwcGluZyBjb3VsZCBiZSBpbnZhbGlkIGlmIHRoZSBvd25lciBleGl0cz8K
ClRoYW5rcwoKPgo+IE5vdGVzOgo+ICAgICB2MjoKPiAgICAgLSByZW1vdmVkIGBzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKm93bmVyYCBwYXJhbSAodW51c2VkIGZvciBub3csIG1heWJlCj4gICAgICAgdXNl
ZnVsIHRvIHN1cHBvcnQgY2dyb3VwcykgW0phc29uXQo+ICAgICAtIGFkZCB1bmJpbmRfbW0gY2Fs
bGJhY2sgW0phc29uXQo+Cj4gIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgMTAgKysrKysrKysrKwo+
ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCA0M2Y1OWVmMTBj
YzkuLjM2OWMyMTM5NDI4NCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsr
KyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTI5MCw2ICsyOTAsMTQgQEAgc3RydWN0IHZk
cGFfbWFwX2ZpbGUgewo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZk
cGEgZGV2aWNlCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaWR4OiB2aXJ0cXVl
dWUgaW5kZXgKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJldHVybnMgcG9pbnRl
ciB0byBzdHJ1Y3R1cmUgZGV2aWNlIG9yIGVycm9yIChOVUxMKQo+ICsgKiBAYmluZF9tbTogICAg
ICAgICAgICAgICAgICAgQmluZCB0aGUgZGV2aWNlIHRvIGEgc3BlY2lmaWMgYWRkcmVzcyBzcGFj
ZQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc28gdGhlIHZEUEEgZnJhbWV3b3Jr
IGNhbiB1c2UgVkEgd2hlbiB0aGlzCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
YWxsYmFjayBpcyBpbXBsZW1lbnRlZC4gKG9wdGlvbmFsKQo+ICsgKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBAbW06IGFkZHJlc3Mgc3BhY2UgdG8gYmluZAo+ICsgKiBAdW5iaW5kX21tOiAgICAg
ICAgICAgICAgICAgVW5iaW5kIHRoZSBkZXZpY2UgZnJvbSB0aGUgYWRkcmVzcyBzcGFjZQo+ICsg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm91bmQgdXNpbmcgdGhlIGJpbmRfbW0gY2Fs
bGJhY2suIChvcHRpb25hbCkKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEB2ZGV2
OiB2ZHBhIGRldmljZQo+ICAgKiBAZnJlZTogICAgICAgICAgICAgICAgICAgICAgRnJlZSByZXNv
dXJjZXMgdGhhdCBiZWxvbmdzIHRvIHZEUEEgKG9wdGlvbmFsKQo+ICAgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAqLwo+IEBAIC0zNTEsNiArMzU5
LDggQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4gICAgICAgICBpbnQgKCpzZXRfZ3JvdXBf
YXNpZCkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgZ3JvdXAsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFzaWQpOwo+ICAgICAgICAg
c3RydWN0IGRldmljZSAqKCpnZXRfdnFfZG1hX2Rldikoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LCB1MTYgaWR4KTsKPiArICAgICAgIGludCAoKmJpbmRfbW0pKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgc3RydWN0IG1tX3N0cnVjdCAqbW0pOwo+ICsgICAgICAgdm9pZCAoKnVuYmluZF9tbSko
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPgo+ICAgICAgICAgLyogRnJlZSBkZXZpY2UgcmVz
b3VyY2VzICovCj4gICAgICAgICB2b2lkICgqZnJlZSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
KTsKPiAtLQo+IDIuMzkuMgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

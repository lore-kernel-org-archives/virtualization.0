Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF433C77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 05:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68397403FF;
	Mon, 15 May 2023 05:02:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68397403FF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsQNi6Eg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNm_DK5BGv_U; Mon, 15 May 2023 05:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CE0D44013D;
	Mon, 15 May 2023 05:02:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE0D44013D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1C5AC0036;
	Mon, 15 May 2023 05:02:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0926FC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:02:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C318E83EC8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:02:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C318E83EC8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bsQNi6Eg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iTiDIHFcx23a
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:02:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E904C83EC7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E904C83EC7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 05:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684126937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0zykRHSym2wUsyz7uvj72KV38qh10+aeWx/77S+cEo=;
 b=bsQNi6EgNKA/MLVgjBhroqcbRXlh5eNMNwGZ5zpaLQFpbalyqYBbPdVvB3nzMIjxj6zT7t
 0w0ps6vZRBoxEwrB/SoXKgq5iwxSJ3tz0kz8yNceVv/MHbwqHg1+UqBVPb5qakcmjBAWYW
 Wmz9CRJ3uxmnWwQPdlnZY5jgmHwgI1I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-S9AtLTo1Pyqx79JHiSZkfw-1; Mon, 15 May 2023 01:02:16 -0400
X-MC-Unique: S9AtLTo1Pyqx79JHiSZkfw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f12f45d0b1so7199279e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 22:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684126934; x=1686718934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0zykRHSym2wUsyz7uvj72KV38qh10+aeWx/77S+cEo=;
 b=DX39wKxUelXg/4t+Ct72gMyiNfyFhFTiUTNoO6j3DXzZMeCXZp9wH8nkRLUvEA6iq+
 /ui9DgPnRdAcW9jKvOJr1TjU2C37wslXVpVrVU23cdKA7EqJoexTxXCsoeCYSVMrKN5s
 +nVkBapTtZ4G+Aev4wEGcIJDwHIIsEzxOE070UON+TgNU3t8uU9fNoGL//EOH+GJJ1ZF
 Ohs+0Qa+pPcidMicR3pJ1kq3oqe+RO5a/OKeQ7VYoHg0TCYxaIHP0pS/owmV+XMfS4X+
 kyRqHueRltJ2D1bqaYxhHb4gzgbJ6Opw+vwJ4hBqYf1f4yGULUzVty0eF4DfMLNI2CVZ
 c0ag==
X-Gm-Message-State: AC+VfDxFbJ4tnCR0thq8M7YJh2nSUpXhdRlfR2H5O5itSfj1OVYRzJu5
 duQChBosq6Q7+7yjUA3J4vNrak9LIzLNFzZaD7xNKsITunkpZeA+p2EpBlmXWD19kKty9AAgL9m
 rsdrndxOIGwxxWLOxavN3z2IrwE7IyDT5TaRVRe6axDkMeA595LZ/vFTd+A==
X-Received: by 2002:a05:6512:11e7:b0:4ec:8e7e:46f1 with SMTP id
 p7-20020a05651211e700b004ec8e7e46f1mr5363899lfs.66.1684126934677; 
 Sun, 14 May 2023 22:02:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lhIqlhQd6lLls7n0zaA85UdEqq4xQ/62YJVC6WCw3PxLJHBNU0JhKeQPjII4KXKrbIFS9BZCGF7Xkj2fsH9s=
X-Received: by 2002:a05:6512:11e7:b0:4ec:8e7e:46f1 with SMTP id
 p7-20020a05651211e700b004ec8e7e46f1mr5363886lfs.66.1684126934331; Sun, 14 May
 2023 22:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230503181240.14009-1-shannon.nelson@amd.com>
 <20230503181240.14009-11-shannon.nelson@amd.com>
In-Reply-To: <20230503181240.14009-11-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 13:02:03 +0800
Message-ID: <CACGkMEuytKwDp3GLcaQmU1CtWSmb2RZRaGdgFyXoCqveruJBpA@mail.gmail.com>
Subject: Re: [PATCH v5 virtio 10/11] pds_vdpa: subscribe to the pds_core events
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, simon.horman@corigine.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 drivers@pensando.io
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

T24gVGh1LCBNYXkgNCwgMjAyMyBhdCAyOjEz4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4gUmVnaXN0ZXIgZm9yIHRoZSBwZHNfY29yZSdzIG5v
dGlmaWNhdGlvbiBldmVudHMsIHByaW1hcmlseSB0bwo+IGZpbmQgb3V0IHdoZW4gdGhlIEZXIGhh
cyBiZWVuIHJlc2V0IHNvIHdlIGNhbiBwYXNzIHRoaXMgb24KPiBiYWNrIHVwIHRoZSBjaGFpbi4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29t
Pgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgfCA2OCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystCj4gIGRyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYuaCB8
ICAxICsKPiAgMiBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jIGIvZHJpdmVycy92
ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gaW5kZXggOTk3MDY1N2NkYjNkLi4zNzdlZWZjMmZhMWUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gQEAgLTIxLDYgKzIxLDYxIEBAIHN0YXRpYyBzdHJ1Y3QgcGRz
X3ZkcGFfZGV2aWNlICp2ZHBhX3RvX3Bkc3Yoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikK
PiAgICAgICAgIHJldHVybiBjb250YWluZXJfb2YodmRwYV9kZXYsIHN0cnVjdCBwZHNfdmRwYV9k
ZXZpY2UsIHZkcGFfZGV2KTsKPiAgfQo+Cj4gK3N0YXRpYyBpbnQgcGRzX3ZkcGFfbm90aWZ5X2hh
bmRsZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwKPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZWNvZGUsCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICpkYXRhKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgcGRzX3ZkcGFf
ZGV2aWNlICpwZHN2ID0gY29udGFpbmVyX29mKG5iLCBzdHJ1Y3QgcGRzX3ZkcGFfZGV2aWNlLCBu
Yik7Cj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRzdi0+dmRwYV9hdXgtPnBhZGV2
LT5hdXhfZGV2LmRldjsKPiArCj4gKyAgICAgICBkZXZfZGJnKGRldiwgIiVzOiBldmVudCBjb2Rl
ICVsdVxuIiwgX19mdW5jX18sIGVjb2RlKTsKPiArCj4gKyAgICAgICAvKiBHaXZlIHRoZSB1cHBl
ciBsYXllcnMgYSBoaW50IHRoYXQgc29tZXRoaW5nIGludGVyZXN0aW5nCj4gKyAgICAgICAgKiBt
YXkgaGF2ZSBoYXBwZW5lZC4gIEl0IHNlZW1zIHRoYXQgdGhlIG9ubHkgdGhpbmcgdGhpcwo+ICsg
ICAgICAgICogdHJpZ2dlcnMgaW4gdGhlIHZpcnRpby1uZXQgZHJpdmVycyBhYm92ZSB1cyBpcyBh
IGNoZWNrCj4gKyAgICAgICAgKiBvZiBsaW5rIHN0YXR1cy4KPiArICAgICAgICAqCj4gKyAgICAg
ICAgKiBXZSBkb24ndCBzZXQgdGhlIE5FRURTX1JFU0VUIGZsYWcgZm9yIEVWRU5UX1JFU0VUCj4g
KyAgICAgICAgKiBiZWNhdXNlIHdlJ3JlIGxpa2VseSBnb2luZyB0aHJvdWdoIGEgcmVjb3Zlcnkg
b3IKPiArICAgICAgICAqIGZ3X3VwZGF0ZSBhbmQgd2lsbCBiZSBiYWNrIHVwIGFuZCBydW5uaW5n
IHNvb24uCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChlY29kZSA9PSBQRFNfRVZFTlRfUkVT
RVQgfHwgZWNvZGUgPT0gUERTX0VWRU5UX0xJTktfQ0hBTkdFKSB7CgpUaGUgY29kZSBoZXJlIHNl
ZW1zIHRvIGNvbmZsaWN0IHdpdGggdGhlIGNvbW1lbnQgYWJvdmUuIElmIHdlIGRvbid0CnNldCBO
RUVEU19SRVNFVCwgdGhlcmUncyBubyBuZWVkIGZvciB0aGUgY29uZmlnIGNhbGxiYWNrPwoKVGhh
bmtzCgo+ICsgICAgICAgICAgICAgICBpZiAocGRzdi0+Y29uZmlnX2NiLmNhbGxiYWNrKQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHBkc3YtPmNvbmZpZ19jYi5jYWxsYmFjayhwZHN2LT5jb25m
aWdfY2IucHJpdmF0ZSk7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30K
PiArCj4gK3N0YXRpYyBpbnQgcGRzX3ZkcGFfcmVnaXN0ZXJfZXZlbnRfaGFuZGxlcihzdHJ1Y3Qg
cGRzX3ZkcGFfZGV2aWNlICpwZHN2KQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYg
PSAmcGRzdi0+dmRwYV9hdXgtPnBhZGV2LT5hdXhfZGV2LmRldjsKPiArICAgICAgIHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqbmIgPSAmcGRzdi0+bmI7Cj4gKyAgICAgICBpbnQgZXJyOwo+ICsKPiAr
ICAgICAgIGlmICghbmItPm5vdGlmaWVyX2NhbGwpIHsKPiArICAgICAgICAgICAgICAgbmItPm5v
dGlmaWVyX2NhbGwgPSBwZHNfdmRwYV9ub3RpZnlfaGFuZGxlcjsKPiArICAgICAgICAgICAgICAg
ZXJyID0gcGRzY19yZWdpc3Rlcl9ub3RpZnkobmIpOwo+ICsgICAgICAgICAgICAgICBpZiAoZXJy
KSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgbmItPm5vdGlmaWVyX2NhbGwgPSBOVUxMOwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHJlZ2lzdGVy
IHBkcyBldmVudCBoYW5kbGVyOiAlcHNcbiIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFUlJfUFRSKGVycikpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOwo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgIGRldl9kYmcoZGV2LCAi
cGRzIGV2ZW50IGhhbmRsZXIgcmVnaXN0ZXJlZFxuIik7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAg
ICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHBkc192ZHBhX3VucmVnaXN0ZXJf
ZXZlbnRfaGFuZGxlcihzdHJ1Y3QgcGRzX3ZkcGFfZGV2aWNlICpwZHN2KQo+ICt7Cj4gKyAgICAg
ICBpZiAocGRzdi0+bmIubm90aWZpZXJfY2FsbCkgewo+ICsgICAgICAgICAgICAgICBwZHNjX3Vu
cmVnaXN0ZXJfbm90aWZ5KCZwZHN2LT5uYik7Cj4gKyAgICAgICAgICAgICAgIHBkc3YtPm5iLm5v
dGlmaWVyX2NhbGwgPSBOVUxMOwo+ICsgICAgICAgfQo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHBk
c192ZHBhX3NldF92cV9hZGRyZXNzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUxNiBx
aWQsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1NjQgZGVzY19hZGRyLCB1
NjQgZHJpdmVyX2FkZHIsIHU2NCBkZXZpY2VfYWRkcikKPiAgewo+IEBAIC01MjIsNiArNTc3LDEy
IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRl
diwgY29uc3QgY2hhciAqbmFtZSwKPgo+ICAgICAgICAgcGRzdi0+dmRwYV9kZXYubWRldiA9ICZ2
ZHBhX2F1eC0+dmRwYV9tZGV2Owo+Cj4gKyAgICAgICBlcnIgPSBwZHNfdmRwYV9yZWdpc3Rlcl9l
dmVudF9oYW5kbGVyKHBkc3YpOwo+ICsgICAgICAgaWYgKGVycikgewo+ICsgICAgICAgICAgICAg
ICBkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZWdpc3RlciBmb3IgUERTIGV2ZW50czogJXBlXG4i
LCBFUlJfUFRSKGVycikpOwo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl91bm1hcDsKPiArICAg
ICAgIH0KPiArCj4gICAgICAgICAvKiBXZSB1c2UgdGhlIF92ZHBhX3JlZ2lzdGVyX2RldmljZSgp
IGNhbGwgcmF0aGVyIHRoYW4gdGhlCj4gICAgICAgICAgKiB2ZHBhX3JlZ2lzdGVyX2RldmljZSgp
IHRvIGF2b2lkIGEgZGVhZGxvY2sgYmVjYXVzZSBvdXIKPiAgICAgICAgICAqIGRldl9hZGQoKSBp
cyBjYWxsZWQgd2l0aCB0aGUgdmRwYV9kZXZfbG9jayBhbHJlYWR5IHNldAo+IEBAIC01MzAsMTMg
KzU5MSwxNSBAQCBzdGF0aWMgaW50IHBkc192ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9k
ZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gICAgICAgICBlcnIgPSBfdmRwYV9yZWdpc3Rl
cl9kZXZpY2UoJnBkc3YtPnZkcGFfZGV2LCBwZHN2LT5udW1fdnFzKTsKPiAgICAgICAgIGlmIChl
cnIpIHsKPiAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIg
dG8gdkRQQSBidXM6ICVwZVxuIiwgRVJSX1BUUihlcnIpKTsKPiAtICAgICAgICAgICAgICAgZ290
byBlcnJfdW5tYXA7Cj4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyX3VuZXZlbnQ7Cj4gICAgICAg
ICB9Cj4KPiAgICAgICAgIHBkc192ZHBhX2RlYnVnZnNfYWRkX3ZkcGFkZXYodmRwYV9hdXgpOwo+
Cj4gICAgICAgICByZXR1cm4gMDsKPgo+ICtlcnJfdW5ldmVudDoKPiArICAgICAgIHBkc192ZHBh
X3VucmVnaXN0ZXJfZXZlbnRfaGFuZGxlcihwZHN2KTsKPiAgZXJyX3VubWFwOgo+ICAgICAgICAg
cHV0X2RldmljZSgmcGRzdi0+dmRwYV9kZXYuZGV2KTsKPiAgICAgICAgIHZkcGFfYXV4LT5wZHN2
ID0gTlVMTDsKPiBAQCAtNTQ2LDggKzYwOSwxMSBAQCBzdGF0aWMgaW50IHBkc192ZHBhX2Rldl9h
ZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsIGNvbnN0IGNoYXIgKm5hbWUsCj4gIHN0YXRp
YyB2b2lkIHBkc192ZHBhX2Rldl9kZWwoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+
ICB7Cj4gKyAgICAgICBzdHJ1Y3QgcGRzX3ZkcGFfZGV2aWNlICpwZHN2ID0gdmRwYV90b19wZHN2
KHZkcGFfZGV2KTsKPiAgICAgICAgIHN0cnVjdCBwZHNfdmRwYV9hdXggKnZkcGFfYXV4Owo+Cj4g
KyAgICAgICBwZHNfdmRwYV91bnJlZ2lzdGVyX2V2ZW50X2hhbmRsZXIocGRzdik7Cj4gKwo+ICAg
ICAgICAgdmRwYV9hdXggPSBjb250YWluZXJfb2YobWRldiwgc3RydWN0IHBkc192ZHBhX2F1eCwg
dmRwYV9tZGV2KTsKPiAgICAgICAgIF92ZHBhX3VucmVnaXN0ZXJfZGV2aWNlKHZkcGFfZGV2KTsK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggYi9kcml2ZXJzL3Zk
cGEvcGRzL3ZkcGFfZGV2LmgKPiBpbmRleCBhMjE1OTZmNDM4YzEuLjE2NTBhMmIwODg0NSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmgKPiArKysgYi9kcml2ZXJzL3Zk
cGEvcGRzL3ZkcGFfZGV2LmgKPiBAQCAtNDAsNiArNDAsNyBAQCBzdHJ1Y3QgcGRzX3ZkcGFfZGV2
aWNlIHsKPiAgICAgICAgIHU4IHZkcGFfaW5kZXg7ICAgICAgICAgICAgICAgICAgLyogcnN2ZCBm
b3IgZnV0dXJlIHN1YmRldmljZSB1c2UgKi8KPiAgICAgICAgIHU4IG51bV92cXM7ICAgICAgICAg
ICAgICAgICAgICAgLyogbnVtIHZxcyBpbiB1c2UgKi8KPiAgICAgICAgIHN0cnVjdCB2ZHBhX2Nh
bGxiYWNrIGNvbmZpZ19jYjsKPiArICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsKPiAg
fTsKPgo+ICBpbnQgcGRzX3ZkcGFfZ2V0X21nbXRfaW5mbyhzdHJ1Y3QgcGRzX3ZkcGFfYXV4ICp2
ZHBhX2F1eCk7Cj4gLS0KPiAyLjE3LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

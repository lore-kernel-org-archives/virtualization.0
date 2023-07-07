Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7CFEB64DA
	for <virtualization@archiver.kernel.org>; Fri,  7 Jul 2023 07:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F76641548;
	Fri,  7 Jul 2023 07:57:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F76641548
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBhYLDDz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iv0C5C68WRpl; Fri,  7 Jul 2023 07:57:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A88EC409E6;
	Fri,  7 Jul 2023 07:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A88EC409E6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F50CC0071;
	Fri,  7 Jul 2023 07:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55477C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2959682792
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2959682792
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IBhYLDDz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uEQeEbz9U7Yd
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:57:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBC3E82640
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBC3E82640
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jul 2023 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688716663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEpZPyCmaGemnrfXXAJXbPLd9RqjcNfujXNkxU7uJgg=;
 b=IBhYLDDzQRub0whU6+OBnu4vczD9vw8FjIcDqLmhA6B6zDU/f+co3vuf063kGsWJ5cV9eB
 JA6NnKU5jezL1sK06asTagjJwGv293g/xOmnPqW6ZduSBcJX6bHLbHxR2UU4gB7IEJVY3J
 uNo3bbtlZsYch/38HbeFpa7ezHNdCCo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-hWQUDqQ_NX-H8LcnNUfvhw-1; Fri, 07 Jul 2023 03:57:42 -0400
X-MC-Unique: hWQUDqQ_NX-H8LcnNUfvhw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b70bfc97e4so6634851fa.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Jul 2023 00:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688716660; x=1691308660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEpZPyCmaGemnrfXXAJXbPLd9RqjcNfujXNkxU7uJgg=;
 b=gGY1Z0DQI4feq1prVfH/zCb44vg5QEXmlJ00zp4r4Qi73iVCA912rVzy3VhCNWsyke
 hrDTKc6qbUGg5L7OCEnNZ7SL1kiX5uggsCV2I8k1wlzdKGolTcTBcRw75+ISQGAdJrqY
 oMLrFfXjUURhGhmMzAX06ZRpw4/KRiC1ffD4ML4F+hCQP+nRUvrxSlRXiwWqO+31A8AL
 xvrSaes52d8bop2ihqDH60pFwtaRpoB3tN+kE/aySIXdSD9lm4y0Z5A8+8IXLmDD4BQk
 NKj8ikmnp04290t1OHUSj9vSLi1Unsz75LoQQm8wY1mKMz2Lt042B7Jz95SwHHzGYKxU
 oWsw==
X-Gm-Message-State: ABy/qLYtR/NFgWYRZ8WoONC3nUYIFLS63SW5CvQ/NHs/4DAKxxgCYIqY
 OLpUeRB2Jh3ccB82m0yMHuiQwThpsKX51tnah+xu05WaF4DCtnkS2UzyBZYN4fVdp9IwM2slqVM
 v36SUqsTHAMyBMTTiOSk83RqvT+BDDUssltGBuM4qek7Qse5+e3uarUfVCQ==
X-Received: by 2002:a2e:b44f:0:b0:2b6:f1ad:d535 with SMTP id
 o15-20020a2eb44f000000b002b6f1add535mr2897784ljm.14.1688716660602; 
 Fri, 07 Jul 2023 00:57:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGG1fs3IIGzeB+qQfUMI3hhjxPEwbtguF4w2sYwc43PKBLjt1WFHJckiuIlLy+s/ff9+yqeexlrDuimTasM8Xc=
X-Received: by 2002:a2e:b44f:0:b0:2b6:f1ad:d535 with SMTP id
 o15-20020a2eb44f000000b002b6f1add535mr2897771ljm.14.1688716660214; Fri, 07
 Jul 2023 00:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230703142218.362549-1-eperezma@redhat.com>
 <20230703105022-mutt-send-email-mst@kernel.org>
 <CAJaqyWf2F_yBLBjj1RiPeJ92_zfq8BSMz8Pak2Vg6QinN8jS1Q@mail.gmail.com>
 <20230704063646-mutt-send-email-mst@kernel.org>
 <CAJaqyWfdPpkD5pY4tfzQdOscLBcrDBhBqzWjMbY_ZKsoyiqGdA@mail.gmail.com>
 <20230704114159-mutt-send-email-mst@kernel.org>
 <CACGkMEtWjOMtsbgQ2sx=e1BkuRSyDmVfXDccCm-QSiSbacQyCA@mail.gmail.com>
 <20230705043940-mutt-send-email-mst@kernel.org>
 <CACGkMEufNZGvWMN9Shh6NPOZOe-vf0RomfS1DX6DtxJjvO7fNA@mail.gmail.com>
 <CAJaqyWcqNkzJXxsoz_Lk_X0CvNW24Ay2Ki6q02EB8iR=qpwsfg@mail.gmail.com>
 <CACGkMEvDsZcyTDBhS8ekXHyv-kiipyHizewpM2+=0XgSYMsmbw@mail.gmail.com>
 <CACGkMEuKNXCSWWqDTZQpogHqT1K=rsQMFAYxL6OC8OL=XeU3-g@mail.gmail.com>
 <CAJaqyWdv_DFdxghHQPoUE4KZ7pqmaR__=JyHFONRuard3KBtSQ@mail.gmail.com>
In-Reply-To: <CAJaqyWdv_DFdxghHQPoUE4KZ7pqmaR__=JyHFONRuard3KBtSQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 15:57:28 +0800
Message-ID: <CACGkMEsv3vyupAbmiq=MtQozq_7O=JKok9sB-Ka9A2PdEgNLag@mail.gmail.com>
Subject: Re: [PATCH] vdpa: reject F_ENABLE_AFTER_DRIVER_OK if backend does not
 support it
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

T24gVGh1LCBKdWwgNiwgMjAyMyBhdCA1OjM54oCvUE0gRXVnZW5pbyBQZXJleiBNYXJ0aW4gPGVw
ZXJlem1hQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgNiwgMjAyMyBhdCAxMDow
M+KAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9u
IFRodSwgSnVsIDYsIDIwMjMgYXQgMzo1NeKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBUaHUsIEp1bCA2LCAyMDIzIGF0IDM6MDbigK9Q
TSBFdWdlbmlvIFBlcmV6IE1hcnRpbiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4KPiA+ID4gPiBPbiBUaHUsIEp1bCA2LCAyMDIzIGF0IDM6NTXigK9BTSBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBXZWQsIEp1
bCA1LCAyMDIzIGF0IDQ6NDHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gT24gV2VkLCBKdWwgMDUsIDIwMjMgYXQg
MDM6NDk6NThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBUdWUs
IEp1bCA0LCAyMDIzIGF0IDExOjQ14oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gT24gVHVlLCBKdWwg
MDQsIDIwMjMgYXQgMDE6MzY6MTFQTSArMDIwMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6
Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDQsIDIwMjMgYXQgMTI6MzjigK9QTSBNaWNo
YWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgSnVsIDA0LCAyMDIzIGF0IDEyOjI1OjMyUE0g
KzAyMDAsIEV1Z2VuaW8gUGVyZXogTWFydGluIHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
T24gTW9uLCBKdWwgMywgMjAyMyBhdCA0OjUy4oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IE9uIE1vbiwgSnVsIDAzLCAyMDIzIGF0IDA0OjIyOjE4UE0gKzAyMDAsIEV1Z2Vu
aW8gUMOpcmV6IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFdpdGggdGhlIGN1cnJl
bnQgY29kZSBpdCBpcyBhY2NlcHRlZCBhcyBsb25nIGFzIHVzZXJsYW5kIHNlbmQgaXQuCj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBBbHRob3VnaCB1
c2VybGFuZCBzaG91bGQgbm90IHNldCBhIGZlYXR1cmUgZmxhZyB0aGF0IGhhcyBub3QgYmVlbgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IG9mZmVyZWQgdG8gaXQgd2l0aCBWSE9TVF9HRVRfQkFD
S0VORF9GRUFUVVJFUywgdGhlIGN1cnJlbnQgY29kZSB3aWxsIG5vdAo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+IGNvbXBsYWluIGZvciBpdC4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpbmNlIHRoZXJlIGlzIG5vIHNwZWNpZmljIHJlYXNvbiBm
b3IgYW55IHBhcmVudCB0byByZWplY3QgdGhhdCBiYWNrZW5kCj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gZmVhdHVyZSBiaXQgd2hlbiBpdCBoYXMgYmVlbiBwcm9wb3NlZCwgbGV0J3MgY29udHJv
bCBpdCBhdCB2ZHBhIGZyb250ZW5kCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gbGV2ZWwuIEZ1
dHVyZSBwYXRjaGVzIG1heSBtb3ZlIHRoaXMgY29udHJvbCB0byB0aGUgcGFyZW50IGRyaXZlci4K
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEZpeGVz
OiA5Njc4MDBkMmQ1MmUgKCJ2ZHBhOiBhY2NlcHQgVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRF
Ul9EUklWRVJfT0sgYmFja2VuZCBmZWF0dXJlIikKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFdWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4KPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gUGxlYXNlIGRvIHNlbmQg
djMuIEFuZCBhZ2FpbiwgSSBkb24ndCB3YW50IHRvIHNlbmQgImFmdGVyIGRyaXZlciBvayIgaGFj
awo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiB1cHN0cmVhbSBhdCBhbGwsIEkgbWVyZ2VkIGl0IGlu
IG5leHQganVzdCB0byBnaXZlIGl0IHNvbWUgdGVzdGluZy4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gV2Ugd2FudCBSSU5HX0FDQ0VTU19BRlRFUl9LSUNLIG9yIHNvbWUgc3VjaC4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiBDdXJyZW50IGRldmljZXMgZG8gbm90IHN1cHBvcnQgdGhhdCBzZW1hbnRpYy4KPiA+ID4gPiA+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IFdoaWNoIGRldmljZXMgc3BlY2lmaWNhbGx5
IGFjY2VzcyB0aGUgcmluZyBhZnRlciBEUklWRVJfT0sgYnV0IGJlZm9yZQo+ID4gPiA+ID4gPiA+
ID4gPiA+IGEga2ljaz8KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiBQcmV2aW91cyB2ZXJzaW9ucyBvZiB0aGUgUUVNVSBMTSBzZXJpZXMgZGlk
IGEgc3B1cmlvdXMga2ljayB0byBzdGFydAo+ID4gPiA+ID4gPiA+ID4gPiB0cmFmZmljIGF0IHRo
ZSBMTSBkZXN0aW5hdGlvbiBbMV0uIFdoZW4gaXQgd2FzIHByb3Bvc2VkLCB0aGF0IHNwdXJpb3Vz
Cj4gPiA+ID4gPiA+ID4gPiA+IGtpY2sgd2FzIHJlbW92ZWQgZnJvbSB0aGUgc2VyaWVzIGJlY2F1
c2UgdG8gY2hlY2sgZm9yIGRlc2NyaXB0b3JzCj4gPiA+ID4gPiA+ID4gPiA+IGFmdGVyIGRyaXZl
cl9vaywgZXZlbiB3aXRob3V0IGEga2ljaywgd2FzIGNvbnNpZGVyZWQgd29yayBvZiB0aGUKPiA+
ID4gPiA+ID4gPiA+ID4gcGFyZW50IGRyaXZlci4KPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gSSdtIG9rIHRvIGdvIGJhY2sgdG8gdGhpcyBzcHVyaW91cyBraWNrLCBidXQgSSdt
IG5vdCBzdXJlIGlmIHRoZSBodwo+ID4gPiA+ID4gPiA+ID4gPiB3aWxsIHJlYWQgdGhlIHJpbmcg
YmVmb3JlIHRoZSBraWNrIGFjdHVhbGx5LiBJIGNhbiBhc2suCj4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+IFRoYW5rcyEKPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+
ID4gWzFdIGh0dHBzOi8vbGlzdHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8y
MDIzLTAxL21zZzAyNzc1Lmh0bWwKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBMZXQn
cyBmaW5kIG91dC4gV2UgbmVlZCB0byBjaGVjayBmb3IgRU5BQkxFX0FGVEVSX0RSSVZFUl9PSyB0
b28sIG5vPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyBb
MV0gYXNzdW1pbmcgQUNDRVNTX0FGVEVSX0tJQ0suIFRoaXMgc2VlbXMKPiA+ID4gPiA+ID4gPiBz
dWItb3B0aW1hbCB0aGFuIGFzc3VtaW5nIEVOQUJMRV9BRlRFUl9EUklWRVJfT0suCj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiBCdXQgdGhpcyByZW1pbmRzIG1lIG9uZSB0aGluZywgYXMgdGhl
IHRocmVhZCBpcyBnb2luZyB0b28gbG9uZywgSQo+ID4gPiA+ID4gPiA+IHdvbmRlciBpZiB3ZSBz
aW1wbHkgYXNzdW1lIEVOQUJMRV9BRlRFUl9EUklWRVJfT0sgaWYgUklOR19SRVNFVCBpcwo+ID4g
PiA+ID4gPiA+IHN1cHBvcnRlZD8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFRoYW5rcwo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIGRvbid0IHNlZSB3aGF0IGRvZXMgb25lIGhhdmUgdG8g
ZG8gd2l0aCBhbm90aGVyIC4uLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIHRoaW5rIHdpdGgg
UklOR19SRVNFVCB3ZSBoYWQgYW5vdGhlciBzb2x1dGlvbiwgZW5hYmxlIHJpbmdzCj4gPiA+ID4g
PiA+IG1hcHBpbmcgdGhlbSB0byBhIHplcm8gcGFnZSwgdGhlbiByZXNldCBhbmQgcmUtZW5hYmxl
IGxhdGVyLgo+ID4gPiA+ID4KPiA+ID4gPiA+IEFzIGRpc2N1c3NlZCBiZWZvcmUsIHRoaXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIHByb2JsZW1zOgo+ID4gPiA+ID4KPiA+ID4gPiA+IDEpIFRoZSBiZWhh
dmlvdXIgaXMgbm90IGNsYXJpZmllZCBpbiB0aGUgZG9jdW1lbnQKPiA+ID4gPiA+IDIpIHplcm8g
aXMgYSB2YWxpZCBJT1ZBCj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gSSB0aGluayB3ZSdyZSBu
b3Qgb24gdGhlIHNhbWUgcGFnZSBoZXJlLgo+ID4gPiA+Cj4gPiA+ID4gQXMgSSB1bmRlcnN0b29k
LCByaW5ncyBtYXBwZWQgdG8gYSB6ZXJvIHBhZ2UgbWVhbnMgZXNzZW50aWFsbHkgYW4KPiA+ID4g
PiBhdmFpbCByaW5nIHdob3NlIGF2YWlsX2lkeCBpcyBhbHdheXMgMCwgb2ZmZXJlZCB0byB0aGUg
ZGV2aWNlIGluc3RlYWQKPiA+ID4gPiBvZiB0aGUgZ3Vlc3QncyByaW5nLiBPbmNlIGFsbCBDVlEg
Y29tbWFuZHMgYXJlIHByb2Nlc3NlZCwgd2UgdXNlCj4gPiA+ID4gUklOR19SRVNFVCB0byBzd2l0
Y2ggdG8gdGhlIHJpZ2h0IHJpbmcsIGJlaW5nIGd1ZXN0J3Mgb3IgU1ZRIHZyaW5nLgo+ID4gPgo+
ID4gPiBJIGdldCB0aGlzLiBUaGlzIHNlZW1zIG1vcmUgY29tcGxpY2F0ZWQgaW4gdGhlIGRlc3Rp
bmF0aW9uOiBzaGFkb3cgdnEgKyBBU0lEPwo+ID4KPiA+IFNvIGl0J3Mgc29tZXRoaW5nIGxpa2U6
Cj4gPgo+ID4gMSkgc2V0IGFsbCB2cSBBU0lEIHRvIHNoYWRvdyB2aXJ0cXVldWUKPiA+IDIpIGRv
IG5vdCBhZGQgYW55IGJ1ZnMgdG8gZGF0YSBxcCAoc3RpY2sgMCBhcyBhdmFpbCBpbmRleCkKPiA+
IDMpIHN0YXJ0IHRvIHJlc3RvcmUgc3RhdGVzIHZpYSBjdnEKPiA+IDQpIHJpbmdfcmVzdCBmb3Ig
ZGF0YXFwCj4gPiA1KSBzZXRfdnFfc3RhdGUgZm9yIGRhdGFxcAo+ID4gNikgcmUtaW5pdGlhbGl6
ZSBkYXRhcXAgYWRkcmVzcyBldGMKPiA+IDcpIHNldCBkYXRhIFFQIEFTSUQgdG8gZ3Vlc3QKPiA+
IDgpIHNldCBxdWV1ZV9lbmFibGUKPiA+Cj4gPiA/Cj4gPgo+Cj4gSSB0aGluayB0aGUgY2hhbmdl
IG9mIEFTSUQgaXMgbm90IG5lZWRlZCwgYXMgdGhlIGd1ZXN0IGNhbm5vdCBhY2Nlc3MKPiB0aGUg
ZGV2aWNlIGluIHRoYXQgdGltZWZyYW1lIGFueXdheS4KClllcyBidXQgYWZ0ZXIgdGhlIHJlc3Rv
cmUsIHdlIHN0aWxsIHdhbnQgdG8gc2hhZG93IGN2cSwgc28gQVNJRCBpcyBzdGlsbCBuZWVkZWQ/
CgpUaGFua3MKCj4gTW9yZW92ZXIsIGl0IG1heSByZXF1aXJlIEhXCj4gc3VwcG9ydC4gU28gc3Rl
cHMgMSBhbmQgNyBhcmUgbm90IG5lZWRlZC4KPgo+IEFwYXJ0IGZyb20gdGhhdCwgdGhlIHByb2Nl
c3MgaXMgcmlnaHQuCj4KPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4K
PiA+ID4gPgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IE15IHBsYW4gd2FzIHRvIGNvbnZlcnQKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+IGl0IGluIHZwX3ZkcGEgaWYgbmVlZGVkLCBhbmQgcmV1c2UgdGhlIGN1cnJlbnQgdmRw
YSBvcHMuIFNvcnJ5IGlmIEkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IHdhcyBub3QgZXhwbGljaXQg
ZW5vdWdoLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFRoZSBv
bmx5IHNvbHV0aW9uIEkgY2FuIHNlZSB0byB0aGF0IGlzIHRvIHRyYXAgJiBlbXVsYXRlIGluIHRo
ZSB2ZHBhCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAocGFyZW50PykgZHJpdmVyLCBhcyB0YWxrZWQg
aW4gdmlydGlvLWNvbW1lbnQuIEJ1dCB0aGF0IGNvbXBsaWNhdGVzCj4gPiA+ID4gPiA+ID4gPiA+
ID4gPiB0aGUgYXJjaGl0ZWN0dXJlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKiBPZmZlciBWSE9T
VF9CQUNLRU5EX0ZfUklOR19BQ0NFU1NfQUZURVJfS0lDSwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
KiBTdG9yZSB2cSBlbmFibGUgc3RhdGUgc2VwYXJhdGVseSwgYXQKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IHZkcGEtPmNvbmZpZy0+c2V0X3ZxX3JlYWR5KHRydWUpLCBidXQgbm90IHRyYW5zbWl0IHRo
YXQgZW5hYmxlIHRvIGh3Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiAqIFN0b3JlIHRoZSBkb29yYmVs
bCBzdGF0ZSBzZXBhcmF0ZWx5LCBidXQgZG8gbm90IGNvbmZpZ3VyZSBpdCB0byB0aGUKPiA+ID4g
PiA+ID4gPiA+ID4gPiA+IGRldmljZSBkaXJlY3RseS4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiBCdXQgaG93IHRvIHJlY292ZXIgaWYgdGhlIGRldmljZSBjYW5u
b3QgY29uZmlndXJlIHRoZW0gYXQga2ljayB0aW1lLAo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gZm9y
IGV4YW1wbGU/Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gTWF5
YmUgd2UgY2FuIGp1c3QgZmFpbCBpZiB0aGUgcGFyZW50IGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0
IGVuYWJsaW5nCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiB0aGUgdnEgYWZ0ZXIgRFJJVkVSX09LPyBU
aGF0IHdheSBubyBuZXcgZmVhdHVyZSBmbGFnIGlzIG5lZWRlZC4KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBUaGFua3MhCj4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IC0tLQo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNlbnQgd2l0aCBGaXhlczogdGFnIHBvaW50aW5nIHRvIGdp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tc3QKPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ID4gPiBjb21taXQuIFBsZWFzZSBsZXQgbWUga25vdyBpZiBJIHNob3VsZCBzZW5kIGEg
djMgb2YgWzFdIGluc3RlYWQuCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIzMDYwOTEy
MTI0NC1tdXR0LXNlbmQtZW1haWwtbXN0QGtlcm5lbC5vcmcvVC8KPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgZHJpdmVycy92aG9zdC92ZHBh
LmMgfCA3ICsrKysrLS0KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zk
cGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gaW5k
ZXggZTFhYmYyOWZlZDViLi5hN2U1NTQzNTIzNTEgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IEBA
IC02ODEsMTggKzY4MSwyMSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxlcCwKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgewo+ID4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0gZmlsZXAtPnBy
aXZhdGVfZGF0YTsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkID0gJnYtPnZkZXY7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdi0+dmRwYS0+Y29uZmlnOwo+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gPiA+ICAgICAgIHZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191c2VyICop
YXJnOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIHU2NCBfX3VzZXIgKmZlYXR1cmVw
ID0gYXJncDsKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAtICAgICB1NjQgZmVhdHVyZXM7Cj4g
PiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgdTY0IGZlYXR1cmVzLCBwYXJlbnRfZmVhdHVy
ZXMgPSAwOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgIGxvbmcgciA9IDA7Cj4gPiA+
ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAgICBpZiAo
Y21kID09IFZIT1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTKSB7Cj4gPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoJmZlYXR1cmVzLCBmZWF0dXJl
cCwgc2l6ZW9mKGZlYXR1cmVzKSkpCj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOwo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgaWYgKG9wcy0+Z2V0X2JhY2tlbmRfZmVhdHVyZXMpCj4gPiA+ID4gPiA+ID4g
PiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBhcmVudF9mZWF0dXJlcyA9IG9wcy0+
Z2V0X2JhY2tlbmRfZmVhdHVyZXModi0+dmRwYSk7Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
ICAgICAgICAgICAgICBpZiAoZmVhdHVyZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJF
UyB8Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX1NVU1BFTkQpIHwKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNL
RU5EX0ZfUkVTVU1FKSB8Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0VOQUJMRV9BRlRFUl9EUklW
RVJfT0spKSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcGFyZW50X2ZlYXR1cmVzKSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX1NVU1BFTkQpKSAmJgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAhdmhvc3RfdmRwYV9jYW5fc3VzcGVuZCh2KSkKPiA+ID4gPiA+ID4gPiA+ID4gPiA+ID4g
PiAtLQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gPiA+IDIuMzkuMwo+ID4gPiA+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4KPiA+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC16C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A913964D87
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A913964D87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FCAF6F663
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 14:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wsGVs3N3aMLA for <virtualization@archiver.kernel.org>;
	Wed, 10 Feb 2021 14:42:45 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 3E88E6F6CF; Wed, 10 Feb 2021 14:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EC816F74F;
	Wed, 10 Feb 2021 14:41:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D872C0174;
	Wed, 10 Feb 2021 14:41:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF2E4C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 14:41:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BE0C787308
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 14:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tSmMLN4jrOD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 14:41:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D059A872CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 14:41:21 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id a9so4686577ejr.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 06:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lX1gJvsaJMOE2HAb4oPWo/N+8MXFPja4wdxtivXDiE4=;
 b=gWUQ0Ou+JJ8cIRNFgEVYrux2Oy3TDrho0YHS7FImAisolJ0Z1/S28JztOc4+pkui1+
 ImoTy/GFmtTdCKrqw8R/L5eqN5aerrrj1wL0bzeB6PSvj+2d7p60YNxIjwnJkwTH4LCr
 jbglhhbLOxaIIXodeK9NCxIPRfZhguxNn1pUCCChfKBH9fNmlzh4TXRXSHcLLxwrs8WC
 FjF77qdCZCrxbFTzLua4JEvafEP/rRTfbFfMsjwvrR2DlhIW7VBA1xWgx5IyT6qj+slp
 blLC36BrDBK1sa6xQdTOBrlg1Ql7Jeys088g8mUHjtHETm7vy+53GzemovL2sxi/F6z5
 X9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lX1gJvsaJMOE2HAb4oPWo/N+8MXFPja4wdxtivXDiE4=;
 b=JZjUHOb0UCWAmB6NkKCaagEfKvc7PutNmBBbiT9ksKnyZ6dygOdzsOxQS5M/XsWuG2
 JYdTkslqRlORDoz/zEQZqKNcaAtm3ICRy5dym19WXsheu2JvblfoIawuanc/N7+VY6wd
 C2oJR3RWOEFFfS986jeF66OgIJQ1WB3+8R73S7Bga917fa5eLbn3IGXHDWxIcLFGGDTv
 OZor/+hpiHBhOW+Ha33z5T7lyB9GHrJdfCiQuOjWFOCkgdFAN5YNFno6Zri8d0KkpgSl
 5971tWQ8ldUxSeGMayFAVuAO8XkaUqxWgnXCfbyUuuyP2ux6qPAMv3XE0oGWEHDzqrSh
 Tyrw==
X-Gm-Message-State: AOAM5315Htl9bbubEoaDm8C01arb227f/cZrTCl6w0zcr+zbr/zOU4FW
 dey3MVp6th8IZVQLS9il7XW1NOxFLiX/D1mUn5U=
X-Google-Smtp-Source: ABdhPJyXpW27MAdu1Z1p13czrxpyX4vFJ5nzDgxwB80JNQc9NcYuG8eufXyFt15QOni3kyaVA04ja5i9wD+Vz35J+Q0=
X-Received: by 2002:a17:906:4dc5:: with SMTP id
 f5mr3211802ejw.11.1612968080427; 
 Wed, 10 Feb 2021 06:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <20210208185558.995292-4-willemdebruijn.kernel@gmail.com>
 <6bfdf48d-c780-bc65-b0b9-24a33f18827b@redhat.com>
 <20210209113643-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lw7LKypTLEfQmcqR9SwcL6f9wH=_yjQdyGak4ORegRug@mail.gmail.com>
 <af5b16fb-8b22-f081-3aa0-92839b7153d6@redhat.com>
In-Reply-To: <af5b16fb-8b22-f081-3aa0-92839b7153d6@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 10 Feb 2021 09:40:44 -0500
Message-ID: <CAF=yD-JLcuaRckKGJSt9Oi-_7W2=1t9FLR6=Thdh5krh6+L9sw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] virtio-net: support transmit timestamp
To: Jason Wang <jasowang@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Willem de Bruijn <willemb@google.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBGZWIgOSwgMjAyMSBhdCAxMToxNSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMS8yLzEwIOS4iuWNiDEwOjM2LCBXaWxsZW0gZGUg
QnJ1aWpuIHdyb3RlOgo+ID4gT24gVHVlLCBGZWIgOSwgMjAyMSBhdCAxMTozOSBBTSBNaWNoYWVs
IFMuIFRzaXJraW48bXN0QHJlZGhhdC5jb20+ICB3cm90ZToKPiA+PiBPbiBUdWUsIEZlYiAwOSwg
MjAyMSBhdCAwMTo0NToxMVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4+PiBPbiAyMDIx
LzIvOSDkuIrljYgyOjU1LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+Pj4gRnJvbTogV2ls
bGVtIGRlIEJydWlqbjx3aWxsZW1iQGdvb2dsZS5jb20+Cj4gPj4+Pgo+ID4+Pj4gQWRkIG9wdGlv
bmFsIFBUUCBoYXJkd2FyZSB0eCB0aW1lc3RhbXAgb2ZmbG9hZCBmb3IgdmlydGlvLW5ldC4KPiA+
Pj4+Cj4gPj4+PiBBY2N1cmF0ZSBSVFQgbWVhc3VyZW1lbnQgcmVxdWlyZXMgdGltZXN0YW1wcyBj
bG9zZSB0byB0aGUgd2lyZS4KPiA+Pj4+IEludHJvZHVjZSB2aXJ0aW8gZmVhdHVyZSBWSVJUSU9f
TkVUX0ZfVFhfVFNUQU1QLCB0aGUgdHJhbnNtaXQKPiA+Pj4+IGVxdWl2YWxlbnQgdG8gVklSVElP
X05FVF9GX1JYX1RTVEFNUC4KPiA+Pj4+Cj4gPj4+PiBUaGUgZHJpdmVyIHNldHMgVklSVElPX05F
VF9IRFJfRl9UU1RBTVAgdG8gcmVxdWVzdCBhIHRpbWVzdGFtcAo+ID4+Pj4gcmV0dXJuZWQgb24g
Y29tcGxldGlvbi4gSWYgdGhlIGZlYXR1cmUgaXMgbmVnb3RpYXRlZCwgdGhlIGRldmljZQo+ID4+
Pj4gZWl0aGVyIHBsYWNlcyB0aGUgdGltZXN0YW1wIG9yIGNsZWFycyB0aGUgZmVhdHVyZSBiaXQu
Cj4gPj4+Pgo+ID4+Pj4gVGhlIHRpbWVzdGFtcCBzdHJhZGRsZXMgKHZpcnR1YWwpIGhhcmR3YXJl
IGRvbWFpbnMuIExpa2UgUFRQLCB1c2UKPiA+Pj4+IGludGVybmF0aW9uYWwgYXRvbWljIHRpbWUg
KENMT0NLX1RBSSkgYXMgZ2xvYmFsIGNsb2NrIGJhc2UuIFRoZSBkcml2ZXIKPiA+Pj4+IG11c3Qg
c3luYyB3aXRoIHRoZSBkZXZpY2UsIGUuZy4sIHRocm91Z2gga3ZtLWNsb2NrLgo+ID4+Pj4KPiA+
Pj4+IE1vZGlmeSBjYW5fcHVzaCB0byBlbnN1cmUgdGhhdCBvbiB0eCBjb21wbGV0aW9uIHRoZSBo
ZWFkZXIsIGFuZCB0aHVzCj4gPj4+PiB0aW1lc3RhbXAsIGlzIGluIGEgcHJlZGljYXRhYmxlIGxv
Y2F0aW9uIGF0IHNrYl92bmV0X2hkci4KPiA+Pj4+Cj4gPj4+PiBSRkM6IHRoaXMgaW1wbGVtZW50
YXRpb24gcmVsaWVzIG9uIHRoZSBkZXZpY2Ugd3JpdGluZyB0byB0aGUgYnVmZmVyLgo+ID4+Pj4g
VGhhdCBicmVha3MgRE1BX1RPX0RFVklDRSBzZW1hbnRpY3MuIEZvciBub3csIGRpc2FibGUgd2hl
biBETUEgaXMgb24uCj4gPj4+PiBUaGUgdmlydGlvIGNoYW5nZXMgc2hvdWxkIGJlIGEgc2VwYXJh
dGUgcGF0Y2ggYXQgdGhlIGxlYXN0Lgo+ID4+Pj4KPiA+Pj4+IFRlc3RlZDogbW9kaWZpZWQgdHh0
aW1lc3RhbXAuYyB0byB3aXRoIGgvdyB0aW1lc3RhbXBpbmc6Cj4gPj4+PiAgICAgLSAgICAgICBz
b2NrX29wdCA9IFNPRl9USU1FU1RBTVBJTkdfU09GVFdBUkUgfAo+ID4+Pj4gICAgICsgICAgICAg
c29ja19vcHQgPSBTT0ZfVElNRVNUQU1QSU5HX1JBV19IQVJEV0FSRSB8Cj4gPj4+PiAgICAgKyBk
b190ZXN0KGZhbWlseSwgU09GX1RJTUVTVEFNUElOR19UWF9IQVJEV0FSRSk7Cj4gPj4+Pgo+ID4+
Pj4gU2lnbmVkLW9mZi1ieTogV2lsbGVtIGRlIEJydWlqbjx3aWxsZW1iQGdvb2dsZS5jb20+Cj4g
Pj4+PiAtLS0KPiA+Pj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAgICAgICAgfCA2MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0KPiA+Pj4+ICAgIGRyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgICAgfCAgMyArLQo+ID4+Pj4gICAgaW5jbHVkZS9saW51eC92aXJ0aW8u
aCAgICAgICAgICB8ICAxICsKPiA+Pj4+ICAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0
LmggfCAgMSArCj4gPj4+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDEw
IGRlbGV0aW9ucygtKQo+ID4+Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+Pj4+IGluZGV4IGFjNDRjNWVm
YTBiYy4uZmM4ZWNkM2EzMzNhIDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+Pj4+IEBAIC0y
MTAsNiArMjEwLDEyIEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ID4+Pj4gICAgICAvKiBEZXZp
Y2Ugd2lsbCBwYXNzIHJ4IHRpbWVzdGFtcC4gUmVxdWlyZXMgaGFzX3J4X3RzdGFtcCAqLwo+ID4+
Pj4gICAgICBib29sIGVuYWJsZV9yeF90c3RhbXA7Cj4gPj4+PiArICAgLyogRGV2aWNlIGNhbiBw
YXNzIENMT0NLX1RBSSB0cmFuc21pdCB0aW1lIHRvIHRoZSBkcml2ZXIgKi8KPiA+Pj4+ICsgICBi
b29sIGhhc190eF90c3RhbXA7Cj4gPj4+PiArCj4gPj4+PiArICAgLyogRGV2aWNlIHdpbGwgcGFz
cyB0eCB0aW1lc3RhbXAuIFJlcXVpcmVzIGhhc190eF90c3RhbXAgKi8KPiA+Pj4+ICsgICBib29s
IGVuYWJsZV90eF90c3RhbXA7Cj4gPj4+PiArCj4gPj4+PiAgICAgIC8qIEhhcyBjb250cm9sIHZp
cnRxdWV1ZSAqLwo+ID4+Pj4gICAgICBib29sIGhhc19jdnE7Cj4gPj4+PiBAQCAtMTQwMSw2ICsx
NDA3LDIwIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZWNlaXZlKHN0cnVjdCByZWNlaXZlX3F1ZXVl
ICpycSwgaW50IGJ1ZGdldCwKPiA+Pj4+ICAgICAgcmV0dXJuIHN0YXRzLnBhY2tldHM7Cj4gPj4+
PiAgICB9Cj4gPj4+PiArc3RhdGljIHZvaWQgdmlydG5ldF9yZWNvcmRfdHhfdHN0YW1wKGNvbnN0
IHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwKPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBza19idWZmICpza2IpCj4gPj4+PiArewo+ID4+Pj4gKyAgIGNvbnN0IHN0
cnVjdCB2aXJ0aW9fbmV0X2hkcl9oYXNoX3RzICpoID0gc2tiX3ZuZXRfaGRyX2h0KHNrYik7Cj4g
Pj4+PiArICAgY29uc3Qgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBzcS0+dnEtPnZkZXYtPnBy
aXY7Cj4gPj4+PiArICAgc3RydWN0IHNrYl9zaGFyZWRfaHd0c3RhbXBzIHRzOwo+ID4+Pj4gKwo+
ID4+Pj4gKyAgIGlmIChoLT5oZHIuZmxhZ3MgJiBWSVJUSU9fTkVUX0hEUl9GX1RTVEFNUCAmJgo+
ID4+Pj4gKyAgICAgICB2aS0+ZW5hYmxlX3R4X3RzdGFtcCkgewo+ID4+Pj4gKyAgICAgICAgICAg
dHMuaHd0c3RhbXAgPSBuc190b19rdGltZShsZTY0X3RvX2NwdShoLT50c3RhbXApKTsKPiA+Pj4+
ICsgICAgICAgICAgIHNrYl90c3RhbXBfdHgoc2tiLCAmdHMpOwo+ID4+PiBUaGlzIHByb2JhYmx5
IHdvbid0IHdvcmsgc2luY2UgdGhlIGJ1ZmZlciBpcyByZWFkLW9ubHkgZnJvbSB0aGUgZGV2aWNl
LiAoU2VlCj4gPj4+IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKCkpLgo+ID4+Pgo+ID4+PiBBbm90aGVy
IGlzc3VlIHRoYXQgSSB2YWd1ZWx5IHJlbWVtYmVyIHRoYXQgdGhlIHZpcnRpbyBzcGVjIGZvcmJp
ZHMgb3V0Cj4gPj4+IGJ1ZmZlciBhZnRlciBpbiBidWZmZXIuCj4gPj4gQm90aCBEcml2ZXIgUmVx
dWlyZW1lbnRzOiBNZXNzYWdlIEZyYW1pbmcgYW5kIERyaXZlciBSZXF1aXJlbWVudHM6IFNjYXR0
ZXItR2F0aGVyIFN1cHBvcnQKPiA+PiBoYXZlIHRoaXMgc3RhdGVtZW50Ogo+ID4+Cj4gPj4gICAg
ICAgICAgVGhlIGRyaXZlciBNVVNUIHBsYWNlIGFueSBkZXZpY2Utd3JpdGFibGUgZGVzY3JpcHRv
ciBlbGVtZW50cyBhZnRlciBhbnkgZGV2aWNlLXJlYWRhYmxlIGRlc2NyaXB0b3IgZWxlLQo+ID4+
ICAgICAgICAgIG1lbnRzLgo+ID4+Cj4gPj4KPiA+PiBzaW1pbGFybHkKPiA+Pgo+ID4+IERldmlj
ZSBSZXF1aXJlbWVudHM6IFRoZSBWaXJ0cXVldWUgRGVzY3JpcHRvciBUYWJsZQo+ID4+ICAgICAg
ICAgIEEgZGV2aWNlIE1VU1QgTk9UIHdyaXRlIHRvIGEgZGV2aWNlLXJlYWRhYmxlIGJ1ZmZlciwg
YW5kIGEgZGV2aWNlIFNIT1VMRCBOT1QgcmVhZCBhIGRldmljZS13cml0YWJsZQo+ID4+ICAgICAg
ICAgIGJ1ZmZlci4KPiA+IFRoYW5rcy4gVGhhdCdzIGNsZWFyLiBTbyB0aGUgY2xlYW4gc29sdXRp
b24gd291bGQgYmUgdG8gYWRkIGEKPiA+IGRldmljZS13cml0YWJsZSBkZXNjcmlwdG9yIGFmdGVy
IHRoZSBleGlzdGluZyBkZXZpY2UtcmVhZGFibGUgb25lcy4KPgo+Cj4gSSB0aGluayBzbywgYnV0
IGEgcXVlc3Rpb24gaXMgdGhlIGZvcm1hdCBmb3IgdGhpcyB0YWlsZXIuIEkgdGhpbmsgaXQKPiBt
aWdodCBiZSBiZXR0ZXIgdG8gcG9zdCBhIHNwZWMgcGF0Y2ggdG8gZGlzY3Vzcy4KCk9rYXkgSSds
bCBkbyB0aGF0LiBJIHdhbnQgdG8gZ2V0IHNvbWV0aGluZyB0aGF0IHdvcmtzIGZpcnN0LCB0byBt
YWtlCnN1cmUgdGhhdCB3aGF0ZXZlciBJIHByb3Bvc2UgaW4gc3BlYyBpcyBhY3R1YWxseSBpbXBs
ZW1lbnRhYmxlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE90CC6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 02:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95C9341DA5;
	Thu, 23 Mar 2023 02:56:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95C9341DA5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=duBuT/d+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1mjeFc19MJtL; Thu, 23 Mar 2023 02:56:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88F4B41D72;
	Thu, 23 Mar 2023 02:56:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 88F4B41D72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68E59C0071;
	Thu, 23 Mar 2023 02:56:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A505CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72A0240C27
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72A0240C27
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=duBuT/d+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZZ7baBHuNRJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9960340C43
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9960340C43
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679540176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZATnWfQd4IdFZee4zz9EZ8nlpw3YfSUMSvYlTUABmSA=;
 b=duBuT/d+8rjMsTAnH+MgFATL6hmzJ6/iZV3gKwekHgu51Z+Yyh8ku0EXtaZW0fuNwwKu1P
 4MJvJ0mqO094vHdTQPL2vt2FUrheeEFwsMxYT1QZiy34br2k2Fu6rv/+oj0Zw7RPylgYqC
 IR3suCaNL1qlyFm2ATCcu3wNLi+kkC4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-wP4we77AMN2OExvhCHUBNQ-1; Wed, 22 Mar 2023 22:56:15 -0400
X-MC-Unique: wP4we77AMN2OExvhCHUBNQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 z133-20020a4a498b000000b0053b5c4e33c5so2529821ooa.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 19:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679540174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZATnWfQd4IdFZee4zz9EZ8nlpw3YfSUMSvYlTUABmSA=;
 b=E1yu+WplN7/nmce8KkNaT04R1VE/47XxeZ9I7o3nPGEYETrwWi4tvKbFVzTT9xkV1Q
 Gt5dxi72WhFD2pC6iyXMo3Tew57uszRK62FJkpn2h1NwgBlBpdOSEIKwYAuzXj7etoKK
 PANJ+uRqrFsIQ+F8qi3otsyH96FdqQxQNtzEdvBduYxkNJNQGUo/aJdtDsBdqaezT/ZD
 YTl4JAgOaYDldc7Yzkhu0krqzg5HI+FdUGj2MLyac/OIy+PADb2N+LH4Es780Tm74IcX
 AVxHUPNE2YJAhiCCdVir64GB/IF9gIJ0a8ykqDhPMMbkAjI9poV7IaVqTJS7Ayd+5mkH
 ieCw==
X-Gm-Message-State: AO0yUKW1nj2K57aw5k5cDqnh2uR3S9TaqVUc1U28F2HWiF2IczK7cit+
 qbRDqnf/DOOWde7aokszvku2DU68a1SRRcYL45kkIpHpo+6iB4P9votcZkHYtMJT98n1u+FHuZ8
 +iaBnzu0gVCOg5lQNnq3QknoQuZmBiCWvo8419qh91eEDcmTQbUqPlO/xEw==
X-Received: by 2002:a9d:5a01:0:b0:698:f988:7c30 with SMTP id
 v1-20020a9d5a01000000b00698f9887c30mr1752776oth.2.1679540174652; 
 Wed, 22 Mar 2023 19:56:14 -0700 (PDT)
X-Google-Smtp-Source: AK7set/X65186pHBZqm0/gsYUnLlUcm+wgRP8gz4d4t1usiYhzDtgWqIi7jvc+HS9KXSgBESety1p5Wbowl5Pavv2gg=
X-Received: by 2002:a9d:5a01:0:b0:698:f988:7c30 with SMTP id
 v1-20020a9d5a01000000b00698f9887c30mr1752770oth.2.1679540174418; Wed, 22 Mar
 2023 19:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
 <20230322025701.2955-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230322025701.2955-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 10:56:03 +0800
Message-ID: <CACGkMEvSVGEdJt1kAjEzDqbSk5fqTCbTVwbzCR-0kK=14kO1yg@mail.gmail.com>
Subject: Re: [PATCH vhost v4 04/11] virtio_ring: split: support premapped
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

T24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgMTA6NTfigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IHZpcnRpbyBjb3JlIG9ubHkgc3VwcG9ydHMgdmly
dHVhbCBhZGRyZXNzZXMsIGRtYSBpcyBjb21wbGV0ZWQgaW4gdmlydGlvCj4gY29yZS4KPgo+IElu
IHNvbWUgc2NlbmFyaW9zIChzdWNoIGFzIHRoZSBBRl9YRFApLCB0aGUgbWVtb3J5IGlzIGFsbG9j
YXRlZAo+IGFuZCBETUEgbWFwcGluZyBpcyBjb21wbGV0ZWQgaW4gYWR2YW5jZSwgc28gaXQgaXMg
bmVjZXNzYXJ5IGZvciB1cyB0bwo+IHN1cHBvcnQgcGFzc2luZyB0aGUgRE1BIGFkZHJlc3MgdG8g
dmlydGlvIGNvcmUuCj4KPiBEcml2ZXMgY2FuIHVzZSBzZy0+ZG1hX2FkZHJlc3MgdG8gcGFzcyB0
aGUgbWFwcGVkIGRtYSBhZGRyZXNzIHRvIHZpcnRpbwo+IGNvcmUuIElmIG9uZSBzZy0+ZG1hX2Fk
ZHJlc3MgaXMgdXNlZCB0aGVuIGFsbCBzZ3MgbXVzdCB1c2UKPiBzZy0+ZG1hX2FkZHJlc3MsIG90
aGVyd2lzZSBhbGwgbXVzdCBiZSBudWxsIHdoZW4gcGFzc2luZyBpdCB0byB0aGUgQVBJcwo+IG9m
IHZpcnRpby4KPgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyNyArKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBjOGVkNGFlZjk0
NjIuLmEyYTc3YTBkYWZlNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC03MCw2ICs3MCw3
IEBACj4gIHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0IHsKPiAgICAgICAgIHZvaWQgKmRh
dGE7ICAgICAgICAgICAgICAgICAgICAgLyogRGF0YSBmb3IgY2FsbGJhY2suICovCj4gICAgICAg
ICBzdHJ1Y3QgdnJpbmdfZGVzYyAqaW5kaXJfZGVzYzsgIC8qIEluZGlyZWN0IGRlc2NyaXB0b3Is
IGlmIGFueS4gKi8KPiArICAgICAgIGJvb2wgZG1hX21hcF9pbnRlcm5hbDsgICAgICAgICAgLyog
RG8gZG1hIG1hcCBpbnRlcm5hbGx5LiAqLwoKV2hpbGUgYXQgdGhpcywgSSB3b25kZXIgaWYgaXQn
cyBiZXR0ZXIgdG8gaGF2ZSBhbiB1bnNpZ25lZCBsb25nIGZsYWcKaW5zdGVhZCBvZiBkb2luZyBw
YWRkaW5nIGJ5IHRoZSBjb21waWxlcj8gVGhpcyBtYXkgc2ltcGxpZnkgZnV0dXJlCmV4dGVuc2lv
bnMuCgpPdGhlcnMgbG9vayBnb29kLgoKVGhhbmtzCgoKCgo+ICB9Owo+Cj4gIHN0cnVjdCB2cmlu
Z19kZXNjX3N0YXRlX3BhY2tlZCB7Cj4gQEAgLTQ0OCw3ICs0NDksNyBAQCBzdGF0aWMgdm9pZCB2
cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4gIH0KPgo+ICBzdGF0aWMgdW5zaWduZWQgaW50IHZyaW5nX3VubWFwX29uZV9zcGxp
dChjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaSkKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaSwgYm9vbCBkbWFfbWFwX2lu
dGVybmFsKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqZXh0cmEgPSB2
cS0+c3BsaXQuZGVzY19leHRyYTsKPiAgICAgICAgIHUxNiBmbGFnczsKPiBAQCAtNDY1LDYgKzQ2
Niw5IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgdnJpbmdfdW5tYXBfb25lX3NwbGl0KGNvbnN0IHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChmbGFncyAmIFZSSU5HX0RFU0NfRl9XUklURSkgPwo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIERNQV9GUk9NX0RFVklDRSA6IERNQV9UT19ERVZJQ0UpOwo+ICAgICAgICAg
fSBlbHNlIHsKPiArICAgICAgICAgICAgICAgaWYgKCFkbWFfbWFwX2ludGVybmFsKQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ICsKPiAgICAgICAgICAgICAgICAgZG1hX3Vu
bWFwX3BhZ2UodnJpbmdfZG1hX2Rldih2cSksCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGV4dHJhW2ldLmFkZHIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV4dHJh
W2ldLmxlbiwKPiBAQCAtNjE1LDcgKzYxOSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1
ZV9hZGRfc3BsaXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZzsKPiAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjICpkZXNjOwo+ICAgICAgICAg
dW5zaWduZWQgaW50IGksIG4sIGF2YWlsLCBkZXNjc191c2VkLCBwcmV2Owo+IC0gICAgICAgYm9v
bCBpbmRpcmVjdDsKPiArICAgICAgIGJvb2wgaW5kaXJlY3QsIGRtYV9tYXBfaW50ZXJuYWw7Cj4g
ICAgICAgICBpbnQgaGVhZDsKPgo+ICAgICAgICAgU1RBUlRfVVNFKHZxKTsKPiBAQCAtNjY4LDcg
KzY3Miw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0IHZp
cnRxdWV1ZSAqX3ZxLAo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT1NQQzsKPiAgICAgICAg
IH0KPgo+IC0gICAgICAgaWYgKHZpcnRxdWV1ZV9tYXBfc2dzKHZxLCBzZ3MsIHRvdGFsX3NnLCBv
dXRfc2dzLCBpbl9zZ3MpKQo+ICsgICAgICAgZG1hX21hcF9pbnRlcm5hbCA9ICFzZ3NbMF0tPmRt
YV9hZGRyZXNzOwo+ICsgICAgICAgaWYgKGRtYV9tYXBfaW50ZXJuYWwgJiYgdmlydHF1ZXVlX21h
cF9zZ3ModnEsIHNncywgdG90YWxfc2csIG91dF9zZ3MsIGluX3NncykpCj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOwo+Cj4gICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3Nnczsg
bisrKSB7Cj4gQEAgLTczNCw2ICs3MzksNyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVf
YWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgICAgICAgICAgdnEtPnNw
bGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYyA9IGRlc2M7Cj4gICAgICAgICBlbHNlCj4g
ICAgICAgICAgICAgICAgIHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBj
dHg7Cj4gKyAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5kbWFfbWFwX2ludGVybmFs
ID0gZG1hX21hcF9pbnRlcm5hbDsKPgo+ICAgICAgICAgLyogUHV0IGVudHJ5IGluIGF2YWlsYWJs
ZSBhcnJheSAoYnV0IGRvbid0IHVwZGF0ZSBhdmFpbC0+aWR4IHVudGlsIHRoZXkKPiAgICAgICAg
ICAqIGRvIHN5bmMpLiAqLwo+IEBAIC03NTksNyArNzY1LDggQEAgc3RhdGljIGlubGluZSBpbnQg
dmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAgICByZXR1
cm4gMDsKPgo+ICB1bm1hcF9yZWxlYXNlOgo+IC0gICAgICAgdmlydHF1ZXVlX3VubWFwX3Nncyh2
cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKTsKPiArICAgICAgIGlmIChkbWFfbWFw
X2ludGVybmFsKQo+ICsgICAgICAgICAgICAgICB2aXJ0cXVldWVfdW5tYXBfc2dzKHZxLCBzZ3Ms
IHRvdGFsX3NnLCBvdXRfc2dzLCBpbl9zZ3MpOwo+Cj4gICAgICAgICBpZiAoaW5kaXJlY3QpCj4g
ICAgICAgICAgICAgICAgIGtmcmVlKGRlc2MpOwo+IEBAIC04MDQsMjAgKzgxMSwyMiBAQCBzdGF0
aWMgdm9pZCBkZXRhY2hfYnVmX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLCB1bnNp
Z25lZCBpbnQgaGVhZCwKPiAgewo+ICAgICAgICAgdW5zaWduZWQgaW50IGksIGo7Cj4gICAgICAg
ICBfX3ZpcnRpbzE2IG5leHRmbGFnID0gY3B1X3RvX3ZpcnRpbzE2KHZxLT52cS52ZGV2LCBWUklO
R19ERVNDX0ZfTkVYVCk7Cj4gKyAgICAgICBib29sIGRtYV9tYXBfaW50ZXJuYWw7Cj4KPiAgICAg
ICAgIC8qIENsZWFyIGRhdGEgcHRyLiAqLwo+ICAgICAgICAgdnEtPnNwbGl0LmRlc2Nfc3RhdGVb
aGVhZF0uZGF0YSA9IE5VTEw7Cj4gKyAgICAgICBkbWFfbWFwX2ludGVybmFsID0gdnEtPnNwbGl0
LmRlc2Nfc3RhdGVbaGVhZF0uZG1hX21hcF9pbnRlcm5hbDsKPgo+ICAgICAgICAgLyogUHV0IGJh
Y2sgb24gZnJlZSBsaXN0OiB1bm1hcCBmaXJzdC1sZXZlbCBkZXNjcmlwdG9ycyBhbmQgZmluZCBl
bmQgKi8KPiAgICAgICAgIGkgPSBoZWFkOwo+Cj4gICAgICAgICB3aGlsZSAodnEtPnNwbGl0LnZy
aW5nLmRlc2NbaV0uZmxhZ3MgJiBuZXh0ZmxhZykgewo+IC0gICAgICAgICAgICAgICB2cmluZ191
bm1hcF9vbmVfc3BsaXQodnEsIGkpOwo+ICsgICAgICAgICAgICAgICB2cmluZ191bm1hcF9vbmVf
c3BsaXQodnEsIGksIGRtYV9tYXBfaW50ZXJuYWwpOwo+ICAgICAgICAgICAgICAgICBpID0gdnEt
PnNwbGl0LmRlc2NfZXh0cmFbaV0ubmV4dDsKPiAgICAgICAgICAgICAgICAgdnEtPnZxLm51bV9m
cmVlKys7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdCh2cSwg
aSk7Cj4gKyAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXQodnEsIGksIGRtYV9tYXBfaW50ZXJu
YWwpOwo+ICAgICAgICAgdnEtPnNwbGl0LmRlc2NfZXh0cmFbaV0ubmV4dCA9IHZxLT5mcmVlX2hl
YWQ7Cj4gICAgICAgICB2cS0+ZnJlZV9oZWFkID0gaGVhZDsKPgo+IEBAIC04MzksOCArODQ4LDEw
IEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEsIHVuc2lnbmVkIGludCBoZWFkLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VlJJTkdfREVTQ19GX0lORElSRUNUKSk7Cj4gICAgICAgICAgICAgICAgIEJVR19PTihsZW4gPT0g
MCB8fCBsZW4gJSBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpKTsKPgo+IC0gICAgICAgICAgICAg
ICBmb3IgKGogPSAwOyBqIDwgbGVuIC8gc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKTsgaisrKQo+
IC0gICAgICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9pbmRpcmVjdCh2
cSwgJmluZGlyX2Rlc2Nbal0pOwo+ICsgICAgICAgICAgICAgICBpZiAoZG1hX21hcF9pbnRlcm5h
bCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZW4gLyBzaXpl
b2Yoc3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QodnEsICZpbmRpcl9kZXNjW2pdKTsK
PiArICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAgIGtmcmVlKGluZGlyX2Rlc2Mp
Owo+ICAgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRpcl9kZXNj
ID0gTlVMTDsKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

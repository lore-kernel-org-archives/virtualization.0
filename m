Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C25DC4332F
	for <virtualization@archiver.kernel.org>; Tue, 31 Oct 2023 01:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EBED82218;
	Tue, 31 Oct 2023 01:25:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EBED82218
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iDpALcAj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NzJDcxL85wuk; Tue, 31 Oct 2023 01:25:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC48682192;
	Tue, 31 Oct 2023 01:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC48682192
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6F98C0071;
	Tue, 31 Oct 2023 01:25:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C45A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 01:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A039B82216
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 01:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A039B82216
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hw_4dm8n06aA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 01:25:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2E6482192
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Oct 2023 01:25:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2E6482192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698715522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o31v5GZG9TcPdikJNjmUFZp5YmRhl08i97z1mloYIzw=;
 b=iDpALcAjp98yvbkt69DNyYg0urKxRRBXn1/eXnNbfSbx4lVahdfGFnu+RUeQ0pIVBMArXJ
 LFXl5SgTQjqLATMil7ZBu9kH/Ka2x8Hi/DiYIHZGIgJLiagbFrTsrOTDGUbhAeZmtIfH3Z
 3B2t8APGg1FYaYo7LAoq8IkBubO+w08=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-Ldg3CRjsM7WR9n3FLtiLTA-1; Mon, 30 Oct 2023 21:25:21 -0400
X-MC-Unique: Ldg3CRjsM7WR9n3FLtiLTA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5098fe88bso35858751fa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Oct 2023 18:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698715519; x=1699320319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o31v5GZG9TcPdikJNjmUFZp5YmRhl08i97z1mloYIzw=;
 b=CC7cbqHWtoc8qq6AxjrJtT4XGQfbfo9LeuIEteDPfOU0WrquvYHjCrZ8H1fmslB9Fo
 4iKH971l7ccz98Pr9G8Ek9ZY4pt3mXnJZiwWtRqDAz/aoMA6K4DZzrBErBKBg6d5nx2p
 81Dx8WoIE30/koFEScoJPRbiDA+pq9n7+B9MiHpCkzfI4rganqc8NsXVKVFcOFG6ZFrO
 M9uFfZzuXaw9/yqnI/6XDPQNohC9PO56m8O3NYxPZGy3yeqWXLfafP4wtOeBJRzSD9QS
 aqeFPgdjaKyq+YjlG4WqPXI9yg9SFFEue2dGF9sCKDbOfK0L062czfv7NA3aFhsfI5YE
 rrVA==
X-Gm-Message-State: AOJu0YxY4PLrHCiZCAaCTv39wzyfZ4inWuXXdSvNaJ62Brx1r33ylUjb
 h4hvR3B/5r1o0XMLPt2MjVJ7GJ0/LOImPzxSh9XwIh1SCDjq3iwQCwiTx2cYDoZ0Ow/T+II51p8
 pgAXknNhrji4yP8rqz9AaVjbHqoLhoBvKGYW0huyLOQzsn1lte6brnpG9cQ==
X-Received: by 2002:a19:a40f:0:b0:509:1eca:4ae2 with SMTP id
 q15-20020a19a40f000000b005091eca4ae2mr360831lfc.16.1698715519646; 
 Mon, 30 Oct 2023 18:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeai5LJ8RYz/4lU5unyi1wyO3RJWvByf6J/J2Epj9d2rm9T2A3D6AJvt2Snb2kBIb7yUnQ+HV7FU3UcPY9IkU=
X-Received: by 2002:a19:a40f:0:b0:509:1eca:4ae2 with SMTP id
 q15-20020a19a40f000000b005091eca4ae2mr360825lfc.16.1698715519287; Mon, 30 Oct
 2023 18:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <1698350834-415881-1-git-send-email-steven.sistare@oracle.com>
 <CACGkMEuO6o3Ys9NcHJpa9w5EiS-ugsiaBbBKEHKHpPSrKBKJow@mail.gmail.com>
 <de5e15c0-0dcb-4cf1-bd4b-bd48c3c59c80@oracle.com>
In-Reply-To: <de5e15c0-0dcb-4cf1-bd4b-bd48c3c59c80@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 31 Oct 2023 09:25:07 +0800
Message-ID: <CACGkMEvo5-Pj2WUWiJ5RoESA3h7hN6eOErGiNO0DYRnBS5aPhg@mail.gmail.com>
Subject: Re: [RFC] vdpa/mlx5: preserve CVQ vringh index
To: Steven Sistare <steven.sistare@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBPY3QgMzAsIDIwMjMgYXQgMTA6MDbigK9QTSBTdGV2ZW4gU2lzdGFyZQo8c3RldmVu
LnNpc3RhcmVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4KPiBPbiAxMC8yNy8yMDIzIDI6MzEgQU0sIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBGcmksIE9jdCAyNywgMjAyMyBhdCA0OjA34oCvQU0gU3Rl
dmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBt
bHg1X3ZkcGEgZG9lcyBub3QgcHJlc2VydmUgdXNlcmxhbmQncyB2aWV3IG9mIHZyaW5nIGJhc2Ug
Zm9yIHRoZSBjb250cm9sCj4gPj4gcXVldWUgaW4gdGhlIGZvbGxvd2luZyBzZXF1ZW5jZToKPiA+
Pgo+ID4+IGlvY3RsIFZIT1NUX1NFVF9WUklOR19CQVNFCj4gPj4gaW9jdGwgVkhPU1RfVkRQQV9T
RVRfU1RBVFVTIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sKPiA+PiAgIG1seDVfdmRwYV9zZXRf
c3RhdHVzKCkKPiA+PiAgICAgc2V0dXBfY3ZxX3ZyaW5nKCkKPiA+PiAgICAgICB2cmluZ2hfaW5p
dF9pb3RsYigpCj4gPj4gICAgICAgICB2cmluZ2hfaW5pdF9rZXJuKCkKPiA+PiAgICAgICAgICAg
dnJoLT5sYXN0X2F2YWlsX2lkeCA9IDA7Cj4gPj4gaW9jdGwgVkhPU1RfR0VUX1ZSSU5HX0JBU0UK
PiA+Pgo+ID4+IFRvIGZpeCwgcmVzdG9yZSB0aGUgdmFsdWUgb2YgY3ZxLT52cmluZy5sYXN0X2F2
YWlsX2lkeCBhZnRlciBjYWxsaW5nCj4gPj4gdnJpbmdoX2luaXRfaW90bGIuCj4gPj4KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPgo+
ID4+IC0tLQo+ID4+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAgNyArKysr
KystCj4gPj4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMgICAgICAgICAgICB8IDMwICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+ID4+ICBpbmNsdWRlL2xpbnV4L3ZyaW5naC5oICAgICAg
ICAgICAgfCAgMiArKwo+ID4+ICAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+PiBpbmRl
eCA5NDY0ODhiODk4OWYuLmY2NDc1ODE0MzExNSAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiA+PiBAQCAtMjc5NSwxMyArMjc5NSwxOCBAQCBzdGF0aWMgaW50IHNldHVw
X2N2cV92cmluZyhzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpCj4gPj4gICAgICAgICBzdHJ1
Y3QgbWx4NV9jb250cm9sX3ZxICpjdnEgPSAmbXZkZXYtPmN2cTsKPiA+PiAgICAgICAgIGludCBl
cnIgPSAwOwo+ID4+Cj4gPj4gLSAgICAgICBpZiAobXZkZXYtPmFjdHVhbF9mZWF0dXJlcyAmIEJJ
VF9VTEwoVklSVElPX05FVF9GX0NUUkxfVlEpKQo+ID4+ICsgICAgICAgaWYgKG12ZGV2LT5hY3R1
YWxfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19ORVRfRl9DVFJMX1ZRKSkgewo+ID4+ICsgICAg
ICAgICAgICAgICB1MTYgbGFzdF9hdmFpbF9pZHggPSBjdnEtPnZyaW5nLmxhc3RfYXZhaWxfaWR4
Owo+ID4+ICsKPiA+PiAgICAgICAgICAgICAgICAgZXJyID0gdnJpbmdoX2luaXRfaW90bGIoJmN2
cS0+dnJpbmcsIG12ZGV2LT5hY3R1YWxfZmVhdHVyZXMsCj4gPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIE1MWDVfQ1ZRX01BWF9FTlQsIGZhbHNlLAo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0IHZyaW5nX2Rlc2MgKiko
dWludHB0cl90KWN2cS0+ZGVzY19hZGRyLAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAoc3RydWN0IHZyaW5nX2F2YWlsICopKHVpbnRwdHJfdCljdnEtPmRyaXZl
cl9hZGRyLAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoc3Ry
dWN0IHZyaW5nX3VzZWQgKikodWludHB0cl90KWN2cS0+ZGV2aWNlX2FkZHIpOwo+ID4+Cj4gPj4g
KyAgICAgICAgICAgICAgIGlmICghZXJyKQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHZy
aW5naF9zZXRfYmFzZV9pb3RsYigmY3ZxLT52cmluZywgbGFzdF9hdmFpbF9pZHgpOwo+ID4KPiA+
IEJ0dywgdnJpbmdoX3NldF9iYXNlX2lvdGxiKCkgZGVzZXJ2ZXMgYW4gaW5kZXBlbmRlbnQgcGF0
Y2ggYW5kIGl0Cj4gPiBzZWVtcyBpdCBpcyBub3Qgc3BlY2lmaWMgdG8gSU9UTEIsCj4KPiBBZ3Jl
ZWQgb24gYm90aC4gIEkgaW5pdGlhbGx5IHN1Ym1pdHRlZCB0aGUgc21hbGxlc3QgY2hhbmdlIG5l
ZWRlZCB0byBzaG93IHRoZSBwcm9ibGVtLgo+Cj4gc28gd2UgcHJvYmFibHkgbmVlZCBhbiBpbmRp
cmVjdGlvbgo+ID4gdG8gaGF2ZSB2cmluZ2hfc2V0X2Jhc2UoKSBmaXJzdC4KPgo+IE5vdCBzdXJl
IHdoYXQgeW91IG1lYW4uICBJIGhhdmUgZGVmaW5lZDoKPgo+ICAgICBzdGF0aWMgaW5saW5lIGlu
dCBfX3ZyaW5naF9zZXRfYmFzZSgpIC4uLgo+Cj4gICAgIGludCB2cmluZ2hfc2V0X2Jhc2VfaW90
bGIoKQo+ICAgICAgICAgcmV0dXJuIF9fdnJpbmdoX3NldF9iYXNlKHZyaCwgaWR4LCBwdXR1MTZf
aW90bGIpOwo+Cj4gdG8gd2hpY2ggSSB3b3VsZCBhZGQ6Cj4KPiAgICAgaW50IHZyaW5naF9zZXRf
YmFzZV91c2VyKCkKPiAgICAgICAgIHJldHVybiBfX3ZyaW5naF9zZXRfYmFzZSh2cmgsIGlkeCwg
cHV0dTE2X3VzZXIpOwo+Cj4gICAgIGludCB2cmluZ2hfc2V0X2Jhc2Vfa2VybigpCj4gICAgICAg
ICByZXR1cm4gX192cmluZ2hfc2V0X2Jhc2UodnJoLCBpZHgsIHB1dHUxNl9rZXJuOwo+Cj4gYWxs
IGluIHRoZSBzYW1lIHBhdGNoLgo+Cj4gVGhlIGNhbGwgc2l0ZSBpbiBtbHg1X3ZuZXQuYyB3b3Vs
ZCBiZSBhIDJuZCBwYXRjaC4KClJpZ2h0LCBzbyB3ZSBqdXN0IG5lZWQgdG8gc3BsaXQgaXQuCgo+
Cj4gLSBTdGV2ZQo+Cj4gPiBPciBJIHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBqdXN0IGludHJv
ZHVjZSBhIG5ldyBwYXJhbWV0ZXIgdG8KPiA+IHZyaW5naF9pbml0X2lvdGxiKCkuLi4KPgo+IEkg
Y29uc2lkZXJlZCB0aGF0LCBidXQgSU1PIHRoZSBwYXJhbWV0ZXIgbGlzdCB0aGVyZSBpcyBhbHJl
YWR5IGxhcmdlLCBhbmQgaXQgd291bGQKPiBiZSBzdHJhbmdlIHRvIGFkZCBhIHBhcmFtZXRlciBm
b3IgdGhlIGluaXRpYWwgdmFsdWUgb2YgYXZhaWwsIGJ1dCBub3QgZm9yIHVzZWQsIGFuZAo+IG5v
IG9uZSBuZWVkcyB0aGUgbGF0dGVyLgoKRmluZS4KClRoYW5rcwoKPgo+IC0gU3RldmUKPgo+ID4+
ICsgICAgICAgfQo+ID4+ICAgICAgICAgcmV0dXJuIGVycjsKPiA+PiAgfQo+ID4+Cj4gPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5j
Cj4gPj4gaW5kZXggN2I4ZmQ5NzdmNzFjLi43OTk3NjJjODMwMDcgMTAwNjQ0Cj4gPj4gLS0tIGEv
ZHJpdmVycy92aG9zdC92cmluZ2guYwo+ID4+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMK
PiA+PiBAQCAtNTk1LDYgKzU5NSwyNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX192cmluZ2hfbm90
aWZ5X2Rpc2FibGUoc3RydWN0IHZyaW5naCAqdnJoLAo+ID4+ICAgICAgICAgfQo+ID4+ICB9Cj4g
Pj4KPiA+PiArc3RhdGljIGlubGluZSBpbnQgX192cmluZ2hfc2V0X2Jhc2Uoc3RydWN0IHZyaW5n
aCAqdnJoLCB1MTYgaWR4LAo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgKCpw
dXR1MTYpKGNvbnN0IHN0cnVjdCB2cmluZ2ggKnZyaCwKPiA+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF9fdmlydGlvMTYgKnAsIHUxNiB2YWwpKQo+ID4+ICt7Cj4gPj4gKyAgICBp
bnQgcmV0Owo+ID4+ICsKPiA+PiArICAgIHJldCA9IHB1dHUxNih2cmgsICZ2cmgtPnZyaW5nLmF2
YWlsLT5pZHgsIGlkeCk7Cj4gPj4gKyAgICBpZiAocmV0KQo+ID4+ICsgICAgICAgIHJldHVybiBy
ZXQ7Cj4gPj4gKwo+ID4+ICsgICAgcmV0ID0gcHV0dTE2KHZyaCwgJnZyaC0+dnJpbmcudXNlZC0+
aWR4LCBpZHgpOwo+ID4+ICsgICAgaWYgKHJldCkKPiA+PiArICAgICAgICByZXR1cm4gcmV0Owo+
ID4+ICsKPiA+PiArICAgIHZyaC0+bGFzdF9hdmFpbF9pZHggPSB2cmgtPmxhc3RfdXNlZF9pZHgg
PSBpZHg7Cj4gPj4gKyAgICByZXR1cm4gMDsKPiA+PiArfQo+ID4+ICsKPiA+PiAgLyogVXNlcnNw
YWNlIGFjY2VzcyBoZWxwZXJzOiBpbiB0aGlzIGNhc2UsIGFkZHJlc3NlcyBhcmUgcmVhbGx5IHVz
ZXJzcGFjZS4gKi8KPiA+PiAgc3RhdGljIGlubGluZSBpbnQgZ2V0dTE2X3VzZXIoY29uc3Qgc3Ry
dWN0IHZyaW5naCAqdnJoLCB1MTYgKnZhbCwgY29uc3QgX192aXJ0aW8xNiAqcCkKPiA+PiAgewo+
ID4+IEBAIC0xNDU2LDYgKzE0NzQsMTggQEAgdm9pZCB2cmluZ2hfc2V0X2lvdGxiKHN0cnVjdCB2
cmluZ2ggKnZyaCwgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPiA+PiAgfQo+ID4+ICBFWFBP
UlRfU1lNQk9MKHZyaW5naF9zZXRfaW90bGIpOwo+ID4+Cj4gPj4gKy8qKgo+ID4+ICsgKiB2cmlu
Z2hfc2V0X2Jhc2VfaW90bGIgLSBzZXQgYXZhaWxfaWR4IGFuZCB1c2VkX2lkeAo+ID4+ICsgKiBA
dnJoOiB0aGUgdnJpbmcKPiA+PiArICogQGlkeDogdGhlIHZhbHVlIHRvIHNldAo+ID4+ICsgKi8K
PiA+PiAraW50IHZyaW5naF9zZXRfYmFzZV9pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgsIHUxNiBp
ZHgpCj4gPj4gK3sKPiA+PiArICAgIHJldHVybiBfX3ZyaW5naF9zZXRfYmFzZSh2cmgsIGlkeCwg
cHV0dTE2X2lvdGxiKTsKPiA+PiArfQo+ID4+ICtFWFBPUlRfU1lNQk9MKHZyaW5naF9zZXRfYmFz
ZV9pb3RsYik7Cj4gPj4gKwo+ID4+ICsKPiA+PiAgLyoqCj4gPj4gICAqIHZyaW5naF9nZXRkZXNj
X2lvdGxiIC0gZ2V0IG5leHQgYXZhaWxhYmxlIGRlc2NyaXB0b3IgZnJvbSByaW5nIHdpdGgKPiA+
PiAgICogSU9UTEIuCj4gPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdnJpbmdoLmggYi9p
bmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4gPj4gaW5kZXggYzNhODExN2RhYmU4Li5lOWI4YWY0ZTZh
NWUgMTAwNjQ0Cj4gPj4gLS0tIGEvaW5jbHVkZS9saW51eC92cmluZ2guaAo+ID4+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvdnJpbmdoLmgKPiA+PiBAQCAtMzA2LDYgKzMwNiw4IEBAIGludCB2cmluZ2hf
aW5pdF9pb3RsYl92YShzdHJ1Y3QgdnJpbmdoICp2cmgsIHU2NCBmZWF0dXJlcywKPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZyaW5nX2F2YWlsICphdmFpbCwKPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZyaW5nX3VzZWQgKnVzZWQpOwo+ID4+Cj4gPj4g
K2ludCB2cmluZ2hfc2V0X2Jhc2VfaW90bGIoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaWR4KTsK
PiA+PiArCj4gPj4gIGludCB2cmluZ2hfZ2V0ZGVzY19pb3RsYihzdHJ1Y3QgdnJpbmdoICp2cmgs
Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ2hfa2lvdiAqcmlvdiwK
PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZyaW5naF9raW92ICp3aW92LAo+
ID4+IC0tCj4gPj4gMi4zOS4zCj4gPj4KPiA+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

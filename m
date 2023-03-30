Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B875C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 03:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97B2441F56;
	Thu, 30 Mar 2023 03:24:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 97B2441F56
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VZ5js+Rx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQaePth01jhj; Thu, 30 Mar 2023 03:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD21F41EBB;
	Thu, 30 Mar 2023 03:24:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD21F41EBB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F67AC0036;
	Thu, 30 Mar 2023 03:24:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A244AC002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7509841F4F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:24:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7509841F4F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jjbgVjkRCzIo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3806341EBB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3806341EBB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 03:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680146682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7uFfI1fsGCC/n/5t6QQvqawvrwGbuPsvHs1UC6idrw=;
 b=VZ5js+Rxwi8JT4gjyS/iYYH1JMIi74VGXB84AMm+ZeRMc9bdhNbPFHmlMy371J2ckCeYz5
 XYpuMjOP8JqZCk9+bYqcu2sWb4leptAYyCaKLi/vWSwslNSepINOQi3G4BMYhX+sldtR0V
 680alVRD5Hx6dPB3YR72ZffMAYS76iQ=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-8jjLlGyEOsWLuc6mxveX1g-1; Wed, 29 Mar 2023 23:24:40 -0400
X-MC-Unique: 8jjLlGyEOsWLuc6mxveX1g-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-17afa2c993cso9191524fac.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Mar 2023 20:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680146679; x=1682738679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7uFfI1fsGCC/n/5t6QQvqawvrwGbuPsvHs1UC6idrw=;
 b=LbyUy1o7cAhTbyqPPTBN3MItsLsiyAYtUu5pobWPuACAR12fLRNeCh7yoPWia7YRmF
 hl446cZRmLVLD+r5nNtVwXsph41C8ntjcJXsc4d/Q9kzwYgzHh0hpkk5BozcI+GbkDMo
 fr9PPJIuRUD959D5+tUWHocLmKjbk/QvMZ+f1NS81OEeZlxeuyCBiMrSeRcMpiRU2EbB
 R09SmhrIEoKe8d3O0fv/DNWdPK+yrPxx06qa3umkCAA1+rH0V10/HDXTFWme1N81h66V
 bevGa0jZEhaeT/XHOcnAPlDK25MVcggsmzuPR/ytFfmatJcMDWcBx6fwhqiBi1ck7WKi
 DJ6A==
X-Gm-Message-State: AO0yUKX/URSl1PrrO01wdNwSd8zZbcEYuCNuOxTa7v5F1rjRQBwCv3i6
 mdCExCmPKVJdkvpz4q4WAmTvFgNErG2izfkEmBRSE9i5gWLvJv5OByB9/hgggmw7W4cu41nh/H4
 8lqAKp7+Qb4Xj2HAd+SQVaKhmsG5T+3oiv7MjvVpFx0vvNfRDKSsPGRjM2w==
X-Received: by 2002:a05:6808:2093:b0:36e:f6f5:604c with SMTP id
 s19-20020a056808209300b0036ef6f5604cmr5185626oiw.9.1680146679325; 
 Wed, 29 Mar 2023 20:24:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set8EftVQXuCal8ybd7Qlu1fk08yAwpMbgwZQQQbRD2dkPI3Xpzujy35jtlaImIxct3d+mB5laCqF0wYNwYQzrUM=
X-Received: by 2002:a05:6808:2093:b0:36e:f6f5:604c with SMTP id
 s19-20020a056808209300b0036ef6f5604cmr5185617oiw.9.1680146679072; Wed, 29 Mar
 2023 20:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160321.187176-1-sgarzare@redhat.com>
In-Reply-To: <20230329160321.187176-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Mar 2023 11:24:27 +0800
Message-ID: <CACGkMEvWcuMnU-t4tNpC6uS_mtSzg=DYkVRDqVQDg3bMYS5Gcw@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_net: complete the initialization before register
 the device
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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

T24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMTI6MDPigK9BTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNn
YXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gSW5pdGlhbGl6YXRpb24gbXVzdCBiZSBjb21w
bGV0ZWQgYmVmb3JlIGNhbGxpbmcgX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCkKPiBzaW5jZSBpdCBj
YW4gY29ubmVjdCB0aGUgZGV2aWNlIHRvIHRoZSB2RFBBIGJ1cywgc28gcmVxdWVzdHMgY2FuIGFy
cml2ZQo+IGFmdGVyIHRoYXQgY2FsbC4KPgo+IFNvIGZvciBleGFtcGxlIHZkcGFzaW1fbmV0X3dv
cmsoKSwgd2hpY2ggdXNlcyB0aGUgbmV0LT4qX3N0YXRzIHZhcmlhYmxlcywKPiBjYW4gYmUgc2No
ZWR1bGVkIGJlZm9yZSB0aGV5IGFyZSBpbml0aWFsaXplZC4KPgo+IExldCdzIG1vdmUgX3ZkcGFf
cmVnaXN0ZXJfZGV2aWNlKCkgdG8gdGhlIGVuZCBvZiB2ZHBhc2ltX25ldF9kZXZfYWRkKCkKPiBh
bmQgYWRkIGEgY29tbWVudCB0byBhdm9pZCBmdXR1cmUgaXNzdWVzLgo+Cj4gRml4ZXM6IDA4OTk3
NzRjYjM2MCAoInZkcGFfc2ltX25ldDogdmVuZG9yIHNhdGlzdGljcyIpCj4gU2lnbmVkLW9mZi1i
eTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGlzIGlzIG5lZWRlZCBmb3IgLXN0YWJs
ZS4KClRoYW5rcwoKPiAtLS0KPgo+IE5vdGVzOgo+ICAgICBJIGRvbid0IGhhdmUgYSByZXByb2R1
Y2VyLCBidXQgSSBiZWNhbWUgYXdhcmUgb2YgdGhpcyBwcm9ibGVtIHdoaWxlCj4gICAgIEkgd2Fz
IGNoYW5naW5nIHRoZSBidWZmZXIgYWxsb2NhdGlvbi4KPgo+ICAgICBJbiB0aGUgYmxvY2sgZGV2
aWNlLCBhcyBzb29uIGFzIHRoZSBkZXZpY2UgaXMgcmVnaXN0ZXJlZCwgdGhlIGRyaXZlcgo+ICAg
ICBzZW5kcyBzZXZlcmFsIHJlcXVlc3RzLCBhbmQgSSBndWVzcyB0aGlzIG1pZ2h0IGhhcHBlbiBm
b3IgdGhlIG5ldAo+ICAgICBkZXZpY2UgYXMgd2VsbC4KPgo+ICAgICBUaGFua3MsCj4gICAgIFN0
ZWZhbm8KPgo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCAxMyArKysr
KysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5j
IGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jCj4gaW5kZXggODYyZjQwNTM2
MmRlLi5kZmUyY2UzNDE4MDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltX25ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5j
Cj4gQEAgLTQ2NiwxNiArNDY2LDIxIEBAIHN0YXRpYyBpbnQgdmRwYXNpbV9uZXRfZGV2X2FkZChz
dHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPgo+ICAgICAgICAg
dmRwYXNpbV9uZXRfc2V0dXBfY29uZmlnKHNpbWRldiwgY29uZmlnKTsKPgo+IC0gICAgICAgcmV0
ID0gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZzaW1kZXYtPnZkcGEsIFZEUEFTSU1fTkVUX1ZRX05V
TSk7Cj4gLSAgICAgICBpZiAocmV0KQo+IC0gICAgICAgICAgICAgICBnb3RvIHJlZ19lcnI7Cj4g
LQo+ICAgICAgICAgbmV0ID0gc2ltX3RvX25ldChzaW1kZXYpOwo+Cj4gICAgICAgICB1NjRfc3Rh
dHNfaW5pdCgmbmV0LT50eF9zdGF0cy5zeW5jcCk7Cj4gICAgICAgICB1NjRfc3RhdHNfaW5pdCgm
bmV0LT5yeF9zdGF0cy5zeW5jcCk7Cj4gICAgICAgICB1NjRfc3RhdHNfaW5pdCgmbmV0LT5jcV9z
dGF0cy5zeW5jcCk7Cj4KPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBJbml0aWFsaXphdGlvbiBt
dXN0IGJlIGNvbXBsZXRlZCBiZWZvcmUgdGhpcyBjYWxsLCBzaW5jZSBpdCBjYW4KPiArICAgICAg
ICAqIGNvbm5lY3QgdGhlIGRldmljZSB0byB0aGUgdkRQQSBidXMsIHNvIHJlcXVlc3RzIGNhbiBh
cnJpdmUgYWZ0ZXIKPiArICAgICAgICAqIHRoaXMgY2FsbC4KPiArICAgICAgICAqLwo+ICsgICAg
ICAgcmV0ID0gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZzaW1kZXYtPnZkcGEsIFZEUEFTSU1fTkVU
X1ZRX05VTSk7Cj4gKyAgICAgICBpZiAocmV0KQo+ICsgICAgICAgICAgICAgICBnb3RvIHJlZ19l
cnI7Cj4gKwo+ICAgICAgICAgcmV0dXJuIDA7Cj4KPiAgcmVnX2VycjoKPiAtLQo+IDIuMzkuMgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

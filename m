Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BEFC6FD1F
	for <virtualization@archiver.kernel.org>; Tue, 14 Mar 2023 07:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42EE0402E8;
	Tue, 14 Mar 2023 07:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42EE0402E8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y8/C7QP6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nfb-_i8saJJT; Tue, 14 Mar 2023 07:57:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 30B5D4029B;
	Tue, 14 Mar 2023 07:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30B5D4029B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9566C0035;
	Tue, 14 Mar 2023 07:57:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89FC9C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:57:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5004361034
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:57:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5004361034
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y8/C7QP6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_3I6E9CgEIn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:57:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5391260FF6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5391260FF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678780640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3fJaQkszaHlGSWitBTNA1qZVdWROwtyzdHNlHD2NCtg=;
 b=Y8/C7QP6/SgHsDm7o8OpZO1XCJxzpnOM2pXoRhnJLRcot0mmgAZF3XmkVP0roQ+7/nkavb
 F8TGgdJE2werNIWVUF/QhKEHONiIRxga7jN/4BMOtHMI42RS+kDrtztT8qWhGApdUZoRJs
 CbY5bBF6TsLceOhPB3U4kTHwXce6QNo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-zN586882OeatyM5vzAdJxw-1; Tue, 14 Mar 2023 03:57:18 -0400
X-MC-Unique: zN586882OeatyM5vzAdJxw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-177c2fb86b7so2383578fac.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Mar 2023 00:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678780638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3fJaQkszaHlGSWitBTNA1qZVdWROwtyzdHNlHD2NCtg=;
 b=w6cWcprgmiTH9qefROT7Bh9nuxVFo407R866erkWgkW9RTEBPwEqQ+z3rdEc7XtmOU
 GgnYaPkQ5PfskrHVNATwTlMs/Lc2IPwWQqmQQnWpdXQZhum1wvCSvcLezThV+DbKUdPk
 xfGlTOguTDWHxOzUzc3bxddeYqlmyU+SVO5wthTQR6LX9W2RRXLAVkNv2S/0lEQx/oXE
 hJT7Hm2On9lh6y2GnnaBnQ/mC9//7UggQhG3UyTPGnr3hHiRatBD5U+CX4NSsDhiSPzr
 8UKvj0IQ31QTXPa0nT8MoH3r7Acrq43HzRRptn9FuCMV99DGrInQGqZUJt/++y4PVvM4
 5oOA==
X-Gm-Message-State: AO0yUKUnnD2Gw8QUYb90VZ5H0XlSol/3acVh9veaUJyticArhYR2Dk1o
 phSbP+T5fWs648lZ/BnAgXNBXbBbjhrwBeX0ODN39yg57pMgkUksRL23jC55Kfpz4YrfjMliiPi
 uzkad2K5yNYZC+x/G7w9ALSK+2xPXMcrt5hks/4TvjIXRJrqAXLCkyqzKxw==
X-Received: by 2002:aca:1708:0:b0:37f:9a01:f661 with SMTP id
 j8-20020aca1708000000b0037f9a01f661mr10576585oii.9.1678780637714; 
 Tue, 14 Mar 2023 00:57:17 -0700 (PDT)
X-Google-Smtp-Source: AK7set8OkP0WLmaIyVnK5ZiYesnaV4H6kdgb3TcepyCr2RlSe9YhLWrOAIR8pQY/JaCl9obLpwdmueBsVzZ/2tsRVGY=
X-Received: by 2002:aca:1708:0:b0:37f:9a01:f661 with SMTP id
 j8-20020aca1708000000b0037f9a01f661mr10576581oii.9.1678780637348; Tue, 14 Mar
 2023 00:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
 <20230308064443.50639-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308064443.50639-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Mar 2023 15:57:06 +0800
Message-ID: <CACGkMEs0bGAVhawHLbR_f1NupAGJfVdo_jVSNx2i74b6Y4nJ=Q@mail.gmail.com>
Subject: Re: [PATCH vhost v2 06/12] virtio_ring: split-indirect: support
 premapped
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

T24gV2VkLCBNYXIgOCwgMjAyMyBhdCAyOjQ04oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiB2aXJ0aW8gY29yZSBvbmx5IHN1cHBvcnRzIHZpcnR1
YWwgYWRkcmVzc2VzLCBkbWEgaXMgY29tcGxldGVkIGluIHZpcnRpbwo+IGNvcmUuCj4KPiBJbiBz
b21lIHNjZW5hcmlvcyAoc3VjaCBhcyB0aGUgQUZfWERQKSwgdGhlIG1lbW9yeSBpcyBhbGxvY2F0
ZWQKPiBhbmQgRE1BIGlzIGNvbXBsZXRlZCBpbiBhZHZhbmNlLCBzbyBpdCBpcyBuZWNlc3Nhcnkg
Zm9yIHVzIHRvIHN1cHBvcnQKPiBwYXNzaW5nIHRoZSBETUEgYWRkcmVzcyB0byB2aXJ0aW8gY29y
ZS4KPgo+IERyaXZlcyBjYW4gdXNlIHNnLT5kbWFfYWRkcmVzcyB0byBwYXNzIHRoZSBtYXBwZWQg
ZG1hIGFkZHJlc3MgdG8gdmlydGlvCj4gY29yZS4gSWYgb25lIHNnLT5kbWFfYWRkcmVzcyBpcyB1
c2VkIHRoZW4gYWxsIHNncyBtdXN0IHVzZSBzZy0+ZG1hX2FkZHJlc3MsCj4gb3RoZXJ3aXNlIGFs
bCBkbWFfYWRkcmVzcyBtdXN0IGJlIG51bGwuCj4KPiBPbiB0aGUgaW5kaXJlY3QgcGF0aCwgaWYg
ZG1hX2FkZHJlc3MgaXMgdXNlZCwgZGVzY19zdGF0ZS5pbmRpcl9kZXNjIHdpbGwKPiBiZSBtaXhl
ZCB3aXRoIFZSSU5HX0lORElSRUNUX1BSRU1BUFBFRC4gU28gd2hlbiBkbyB1bm1hcCwgd2UgY2Fu
IHBhc3MgaXQuCgpJdCdzIGJldHRlciB0byBtZW50aW9uIHdoeSBpbmRpcmVjdCBkZXNjcmlwdG9y
cyBjYW4ndCBiZSBkb25lIGluIHRoZQpzYW1lIHdheSB3aXRoIGRpcmVjdCBkZXNjcmlwdG9ycy4K
CkJ0dywgaWYgd2UgY2hhbmdlIHRoZSBzZW1hbnRpY3Mgb2YgZGVzY19leHRyYS5kbWFfYWRkciBh
bmQKZGVzY19zdGF0ZS5pbmRpcl9kZXNjLCB3ZSBzaG91bGQgYWRkIGNvbW1lbnRzIHRvIGRlZmlu
aXRpb25zIG9mIHRob3NlCnN0cnVjdHVyZXMuCgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyB8IDI4ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPiBpbmRleCA2NmEwNzFlM2JkZWYuLjExODI3ZDJlNTZhOCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYwo+IEBAIC0yMzEsNiArMjMxLDE4IEBAIHN0YXRpYyB2b2lkIHZyaW5nX2ZyZWUoc3RydWN0
IHZpcnRxdWV1ZSAqX3ZxKTsKPiAgICogSGVscGVycy4KPiAgICovCj4KPiArI2RlZmluZSBWUklO
R19JTkRJUkVDVF9QUkVNQVBQRUQgIEJJVCgwKQo+ICsKPiArI2RlZmluZSBkZXNjX21peF9kbWFf
bWFwKGRvX21hcCwgZGVzYykgXAo+ICsgICAgICAgKGRvX21hcCA/IGRlc2MgOiAodHlwZW9mKGRl
c2MpKSgodW5zaWduZWQgbG9uZykoZGVzYykgfCBWUklOR19JTkRJUkVDVF9QUkVNQVBQRUQpKQo+
ICsKPiArI2RlZmluZSBkZXNjX3JtX2RtYV9tYXAoZGVzYykgXAo+ICsgICAgICAgKCh0eXBlb2Yo
ZGVzYykpKCh1bnNpZ25lZCBsb25nKShkZXNjKSAmIH5WUklOR19JTkRJUkVDVF9QUkVNQVBQRUQp
KQo+ICsKPiArI2RlZmluZSBkZXNjX21hcF9pbnRlcihkZXNjKSBcCj4gKyAgICAgICAhKCh1bnNp
Z25lZCBsb25nKShkZXNjKSAmIFZSSU5HX0lORElSRUNUX1BSRU1BUFBFRCkKPiArCj4gKwo+ICAj
ZGVmaW5lIHRvX3Z2cShfdnEpIGNvbnRhaW5lcl9vZihfdnEsIHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUsIHZxKQo+Cj4gIHN0YXRpYyBpbmxpbmUgYm9vbCB2aXJ0cXVldWVfdXNlX2luZGlyZWN0KHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+IEBAIC03MjUsNyArNzM3LDcgQEAgc3RhdGljIGlu
bGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAg
ICAgICAvKiBTdG9yZSB0b2tlbiBhbmQgaW5kaXJlY3QgYnVmZmVyIHN0YXRlLiAqLwo+ICAgICAg
ICAgdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uZGF0YSA9IGRhdGE7Cj4gICAgICAgICBpZiAo
aW5kaXJlY3QpCj4gLSAgICAgICAgICAgICAgIHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmlu
ZGlyX2Rlc2MgPSBkZXNjOwo+ICsgICAgICAgICAgICAgICB2cS0+c3BsaXQuZGVzY19zdGF0ZVto
ZWFkXS5pbmRpcl9kZXNjID0gZGVzY19taXhfZG1hX21hcChkb19tYXAsIGRlc2MpOwoKU28gdXNp
bmcgaW5kaXJfZGVzYyBpcyBraW5kIG9mIGhhY2t5IChzaW5jZSB3ZSBkb24ndCB1c2UgaW5kaXJl
Y3QgZm9yCnJ4IHdpdGggZXh0cmEgY29udGV4dCkuCgpCdXQgYXQgbGVhc3QgSSB0aGluayB3ZSBz
aG91bGQgc2Vla2Egd2F5IHRvIHVzZSB0aGUgc2FtZSBtZXRhZGF0YSBmb3IKYm90aCBkaXJlY3Qg
YW5kIGluZGlyZWN0IGRlc2NyaXB0b3JzLgoKRS5nIGNhbiB3ZSBtYWtlIHRoZW0gYWxsIHRvIHVz
ZSBpbmRpcl9kZXNjPwoKVGhhbmtzCgo+ICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICB2
cS0+c3BsaXQuZGVzY19zdGF0ZVtoZWFkXS5pbmRpcl9kZXNjID0gY3R4Owo+Cj4gQEAgLTgyMCwy
MiArODMyLDI2IEBAIHN0YXRpYyB2b2lkIGRldGFjaF9idWZfc3BsaXQoc3RydWN0IHZyaW5nX3Zp
cnRxdWV1ZSAqdnEsIHVuc2lnbmVkIGludCBoZWFkLAo+ICAgICAgICAgdnEtPnZxLm51bV9mcmVl
Kys7Cj4KPiAgICAgICAgIGlmICh2cS0+aW5kaXJlY3QpIHsKPiAtICAgICAgICAgICAgICAgc3Ry
dWN0IHZyaW5nX2Rlc2MgKmluZGlyX2Rlc2MgPQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdnEtPnNwbGl0LmRlc2Nfc3RhdGVbaGVhZF0uaW5kaXJfZGVzYzsKPiArICAgICAgICAg
ICAgICAgc3RydWN0IHZyaW5nX2Rlc2MgKm1peCA9IHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRd
LmluZGlyX2Rlc2M7Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19kZXNjICppbmRpcl9k
ZXNjOwo+ICAgICAgICAgICAgICAgICB1MzIgbGVuOwo+Cj4gICAgICAgICAgICAgICAgIC8qIEZy
ZWUgdGhlIGluZGlyZWN0IHRhYmxlLCBpZiBhbnksIG5vdyB0aGF0IGl0J3MgdW5tYXBwZWQuICov
Cj4gLSAgICAgICAgICAgICAgIGlmICghaW5kaXJfZGVzYykKPiArICAgICAgICAgICAgICAgaWYg
KCFtaXgpCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOwo+Cj4gKyAgICAgICAgICAg
ICAgIGluZGlyX2Rlc2MgPSBkZXNjX3JtX2RtYV9tYXAobWl4KTsKPiArCj4gICAgICAgICAgICAg
ICAgIGxlbiA9IHZxLT5zcGxpdC5kZXNjX2V4dHJhW2hlYWRdLmxlbjsKPgo+ICAgICAgICAgICAg
ICAgICBCVUdfT04oISh2cS0+c3BsaXQuZGVzY19leHRyYVtoZWFkXS5mbGFncyAmCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBWUklOR19ERVNDX0ZfSU5ESVJFQ1QpKTsKPiAgICAg
ICAgICAgICAgICAgQlVHX09OKGxlbiA9PSAwIHx8IGxlbiAlIHNpemVvZihzdHJ1Y3QgdnJpbmdf
ZGVzYykpOwo+Cj4gLSAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZW4gLyBzaXplb2Yo
c3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gLSAgICAgICAgICAgICAgICAgICAgICAgdnJpbmdf
dW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmaW5kaXJfZGVzY1tqXSk7Cj4gKyAgICAgICAg
ICAgICAgIGlmIChkZXNjX21hcF9pbnRlcihtaXgpKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgZm9yIChqID0gMDsgaiA8IGxlbiAvIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyk7IGorKykK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZyaW5nX3VubWFwX29uZV9zcGxpdF9p
bmRpcmVjdCh2cSwgJmluZGlyX2Rlc2Nbal0pOwo+ICsgICAgICAgICAgICAgICB9Cj4KPiAgICAg
ICAgICAgICAgICAga2ZyZWUoaW5kaXJfZGVzYyk7Cj4gICAgICAgICAgICAgICAgIHZxLT5zcGxp
dC5kZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2MgPSBOVUxMOwo+IC0tCj4gMi4zMi4wLjMuZzAx
MTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E9EC07545
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 01:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46A6270720;
	Wed, 25 Oct 2023 01:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46A6270720
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oj1DXXNn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eJktC4LW5to1; Wed, 25 Oct 2023 01:16:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD86E70722;
	Wed, 25 Oct 2023 01:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD86E70722
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EAEDC0071;
	Wed, 25 Oct 2023 01:16:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB02FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 963FA84B28
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:16:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 963FA84B28
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oj1DXXNn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r3-F-x217BN2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:16:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 208FE84B1F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 208FE84B1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698196567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8jUxLPVqEyy0fSEb+M8GkdqTmhs4mSjWm/V02VT7Yo0=;
 b=Oj1DXXNncuVk+xCzX119dkcrKUb+mCNHzVgNCQXmCEKK2zsQuZI4KvoKIN8f9CVer8SrjP
 dU5Ba1jtPZ4fzshJ8TeGD9MgmDkvIm815qBnK7LsG615y4wWAtvXb9jCsXwjuKjnPf92UW
 nMaRlT0949FFUzeFhyy3ZX1XN8tQVrA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-9zlLp16CPoWa4SCzuJ2IKw-1; Tue, 24 Oct 2023 21:16:05 -0400
X-MC-Unique: 9zlLp16CPoWa4SCzuJ2IKw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ba1949656bso43097881fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 18:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196563; x=1698801363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jUxLPVqEyy0fSEb+M8GkdqTmhs4mSjWm/V02VT7Yo0=;
 b=ZknzA+0NLR9IKT4elDpoARxrwK0Cv2vb82HQUrEtW4PFKeXVZn1YFAwNMBGqYUwYNW
 fvDtACNnPG+CtqxqNx8PkGYVX9wuKBhkDXz9YYkgN+/QDkcX1jrsfZ34D8KoSW0Vpsjf
 MEZMVDSOZUjl5m12zRIqjUlGOHxZ3ghqKhcE3nnp+OyV3lDqSysjLn9uDdl2ujWDY1E7
 FT3QjrVtdXN0RrRuX+ifCzWsxALppzphKe6YWR4A+FnSycXG+LSOPJdf6q+BNPqk87wa
 Bd/UXEsU8egV9RtNqLXBKBtTB619mNve085wqNLQKYEgfucOAhBpRpUauBBL1ahBELWk
 JK1Q==
X-Gm-Message-State: AOJu0YzsIBaKtq8I+FyWH6SFkcnEz9RUiyiIRlucGPj7xSt4UXzFr6KO
 W6yoLVZ3ya+pnvrSdNUVm/A0MP/18b/kDSrd3AEXstNnZGCJhHBPYXlD7sYKMp0RxSDXM96oVwg
 0199xl6yH9K7iLpwxnP4JaQygYuPkhY0ODu04wqFcJMbaREjScDnnPkiL2g==
X-Received: by 2002:ac2:4ac7:0:b0:503:1bb0:a658 with SMTP id
 m7-20020ac24ac7000000b005031bb0a658mr9946577lfp.32.1698196563755; 
 Tue, 24 Oct 2023 18:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExm9Uf2zsy/hZpGxWLnOCxtCose/TBcuAkczdQUH0lDOPqoFYvLt0aSeiH4mtO8PF5JKM0yYpPP5oCZtx+v84=
X-Received: by 2002:ac2:4ac7:0:b0:503:1bb0:a658 with SMTP id
 m7-20020ac24ac7000000b005031bb0a658mr9946570lfp.32.1698196563385; Tue, 24 Oct
 2023 18:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <1697880319-4937-6-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEun7pnq5zMBH=_X+H9p_=HK6+5WHRp9A2prRe2Na-qmvQ@mail.gmail.com>
 <0ad99060-119b-4465-b611-868f693aea02@oracle.com>
 <d71dc008-9920-463d-948a-0375c5754810@oracle.com>
In-Reply-To: <d71dc008-9920-463d-948a-0375c5754810@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 25 Oct 2023 09:15:52 +0800
Message-ID: <CACGkMEtXOzqP_FY_UmmZZoDnOBg4MXS-EoE-vKC_=MM3cgKnmQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] vhost-vdpa: clean iotlb map during reset for older
 userspace
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

T24gV2VkLCBPY3QgMjUsIDIwMjMgYXQgMTI6MjXigK9BTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1
QG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDEwLzI0LzIwMjMgOToyMSBBTSwgU2ktV2Vp
IExpdSB3cm90ZToKPiA+Cj4gPgo+ID4gT24gMTAvMjMvMjAyMyAxMDo0NSBQTSwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+PiBPbiBTYXQsIE9jdCAyMSwgMjAyMyBhdCA1OjI44oCvUE0gU2ktV2VpIExp
dSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4+IHdyb3RlOgo+ID4+PiBVc2luZyAuY29tcGF0
X3Jlc2V0IG9wIGZyb20gdGhlIHByZXZpb3VzIHBhdGNoLCB0aGUgYnVnZ3kgLnJlc2V0Cj4gPj4+
IGJlaGF2aW91ciBjYW4gYmUga2VwdCBhcy1pcyBvbiBvbGRlciB1c2Vyc3BhY2UgYXBwcywgd2hp
Y2ggZG9uJ3QgYWNrCj4gPj4+IHRoZQo+ID4+PiBJT1RMQl9QRVJTSVNUIGJhY2tlbmQgZmVhdHVy
ZS4gQXMgdGhpcyBjb21wYXRpYmlsaXR5IHF1aXJrIGlzCj4gPj4+IGxpbWl0ZWQgdG8KPiA+Pj4g
dGhvc2UgZHJpdmVycyB0aGF0IHVzZWQgdG8gYmUgYnVnZ3kgaW4gdGhlIHBhc3QsIGl0IHdvbid0
IGFmZmVjdCBjaGFuZ2UKPiA+Pj4gdGhlIGJlaGF2aW91ciBvciBhZmZlY3QgQUJJIG9uIHRoZSBz
ZXR1cHMgd2l0aCBBUEkgY29tcGxpYW50IGRyaXZlci4KPiA+Pj4KPiA+Pj4gVGhlIHNlcGFyYXRp
b24gb2YgLmNvbXBhdF9yZXNldCBmcm9tIHRoZSByZWd1bGFyIC5yZXNldCBhbGxvd3MKPiA+Pj4g
dmhvc3QtdmRwYSBhYmxlIHRvIGtub3cgd2hpY2ggZHJpdmVyIGhhZCBicm9rZW4gYmVoYXZpb3Vy
IGJlZm9yZSwgc28gaXQKPiA+Pj4gY2FuIGFwcGx5IHRoZSBjb3JyZXNwb25kaW5nIGNvbXBhdGli
aWxpdHkgcXVpcmsgdG8gdGhlIGluZGl2aWR1YWwKPiA+Pj4gZHJpdmVyCj4gPj4+IHdoZW5ldmVy
IG5lZWRlZC4gIENvbXBhcmVkIHRvIG92ZXJsb2FkaW5nIHRoZSBleGlzdGluZyAucmVzZXQgd2l0
aAo+ID4+PiBmbGFncywgLmNvbXBhdF9yZXNldCB3b24ndCBjYXVzZSBhbnkgZXh0cmEgYnVyZGVu
IHRvIHRoZSBpbXBsZW1lbnRhdGlvbgo+ID4+PiBvZiBldmVyeSBjb21wbGlhbnQgZHJpdmVyLgo+
ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5j
b20+Cj4gPj4+IC0tLQo+ID4+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgfCAxNyAr
KysrKysrKysrKysrLS0tLQo+ID4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMgfCAg
MiArLQo+ID4+PiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgfCAgNyArKysrKy0tCj4g
Pj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+
ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+ID4+PiBpbmRleCBhY2M3Yzc0YmE3ZDYuLjljZTQwMDAzNzkzYiAxMDA2NDQK
PiA+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+Pj4gKysrIGIvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiA+Pj4gQEAgLTIyNywxMyArMjI3LDIyIEBAIHN0YXRpYyB2b2lkIHZob3N0X3Zk
cGFfdW5zZXR1cF92cV9pcnEoc3RydWN0Cj4gPj4+IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4g
Pj4+IGlycV9ieXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2Vy
KTsKPiA+Pj4gICB9Cj4gPj4+Cj4gPj4+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVzZXQoc3Ry
dWN0IHZob3N0X3ZkcGEgKnYpCj4gPj4+ICtzdGF0aWMgaW50IF9jb21wYXRfdmRwYV9yZXNldChz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiA+Pj4gICB7Cj4gPj4+ICAgICAgICAgIHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gPj4+ICsgICAgICAgdTMyIGZsYWdzID0gMDsKPiA+
Pj4KPiA+Pj4gLSAgICAgICB2LT5pbl9iYXRjaCA9IDA7Cj4gPj4+ICsgICAgICAgZmxhZ3MgfD0g
IXZob3N0X2JhY2tlbmRfaGFzX2ZlYXR1cmUodi0+dmRldi52cXNbMF0sCj4gPj4+ICsgVkhPU1Rf
QkFDS0VORF9GX0lPVExCX1BFUlNJU1QpID8KPiA+Pj4gKyAgICAgICAgICAgICAgICBWRFBBX1JF
U0VUX0ZfQ0xFQU5fTUFQIDogMDsKPiA+Pj4gKwo+ID4+PiArICAgICAgIHJldHVybiB2ZHBhX3Jl
c2V0KHZkcGEsIGZsYWdzKTsKPiA+Pj4gK30KPiA+Pj4KPiA+Pj4gLSAgICAgICByZXR1cm4gdmRw
YV9yZXNldCh2ZHBhKTsKPiA+Pj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9yZXNldChzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdikKPiA+Pj4gK3sKPiA+Pj4gKyAgICAgICB2LT5pbl9iYXRjaCA9IDA7Cj4g
Pj4+ICsgICAgICAgcmV0dXJuIF9jb21wYXRfdmRwYV9yZXNldCh2KTsKPiA+Pj4gICB9Cj4gPj4+
Cj4gPj4+ICAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9iaW5kX21tKHN0cnVjdCB2aG9zdF92ZHBh
ICp2KQo+ID4+PiBAQCAtMzEyLDcgKzMyMSw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0
X3N0YXR1cyhzdHJ1Y3QKPiA+Pj4gdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+
ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgdmhvc3RfdmRwYV91bnNldHVwX3ZxX2lycSh2
LCBpKTsKPiA+Pj4KPiA+Pj4gICAgICAgICAgaWYgKHN0YXR1cyA9PSAwKSB7Cj4gPj4+IC0gICAg
ICAgICAgICAgICByZXQgPSB2ZHBhX3Jlc2V0KHZkcGEpOwo+ID4+PiArICAgICAgICAgICAgICAg
cmV0ID0gX2NvbXBhdF92ZHBhX3Jlc2V0KHYpOwo+ID4+PiAgICAgICAgICAgICAgICAgIGlmIChy
ZXQpCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Owo+ID4+PiAgICAg
ICAgICB9IGVsc2UKPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBh
LmMKPiA+Pj4gYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPj4+IGluZGV4IDA2Y2U2
ZDhjMmUwMC4uOGQ2M2U1OTIzZDI0IDEwMDY0NAo+ID4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fdmRwYS5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+
Pj4gQEAgLTEwMCw3ICsxMDAsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fdmRwYV9yZXNldChzdHJ1
Y3QKPiA+Pj4gdmlydGlvX2RldmljZSAqdmRldikKPiA+Pj4gICB7Cj4gPj4+ICAgICAgICAgIHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHZkX2dldF92ZHBhKHZkZXYpOwo+ID4+Pgo+ID4+PiAt
ICAgICAgIHZkcGFfcmVzZXQodmRwYSk7Cj4gPj4+ICsgICAgICAgdmRwYV9yZXNldCh2ZHBhLCAw
KTsKPiA+Pj4gICB9Cj4gPj4+Cj4gPj4+ICAgc3RhdGljIGJvb2wgdmlydGlvX3ZkcGFfbm90aWZ5
KHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92
ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4+PiBpbmRleCA2YjhjYmY3NTcxMmQuLmRi
MTVhYzA3ZjhhNiAxMDA2NDQKPiA+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+Pj4g
KysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+Pj4gQEAgLTUxOSwxNCArNTE5LDE3IEBAIHN0
YXRpYyBpbmxpbmUgc3RydWN0IGRldmljZQo+ID4+PiAqdmRwYV9nZXRfZG1hX2RldihzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYpCj4gPj4+ICAgICAgICAgIHJldHVybiB2ZGV2LT5kbWFfZGV2Owo+
ID4+PiAgIH0KPiA+Pj4KPiA+Pj4gLXN0YXRpYyBpbmxpbmUgaW50IHZkcGFfcmVzZXQoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2KQo+ID4+PiArc3RhdGljIGlubGluZSBpbnQgdmRwYV9yZXNldChz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUzMiBmbGFncykKPiA+Pj4gICB7Cj4gPj4+ICAgICAg
ICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPiA+
Pj4gICAgICAgICAgaW50IHJldDsKPiA+Pj4KPiA+Pj4gICAgICAgICAgZG93bl93cml0ZSgmdmRl
di0+Y2ZfbG9jayk7Cj4gPj4+ICAgICAgICAgIHZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gZmFsc2U7
Cj4gPj4+IC0gICAgICAgcmV0ID0gb3BzLT5yZXNldCh2ZGV2KTsKPiA+Pj4gKyAgICAgICBpZiAo
b3BzLT5jb21wYXRfcmVzZXQgJiYgZmxhZ3MpCj4gPj4+ICsgICAgICAgICAgICAgICByZXQgPSBv
cHMtPmNvbXBhdF9yZXNldCh2ZGV2LCBmbGFncyk7Cj4gPj4+ICsgICAgICAgZWxzZQo+ID4+PiAr
ICAgICAgICAgICAgICAgcmV0ID0gb3BzLT5yZXNldCh2ZGV2KTsKPiA+PiBJbnN0ZWFkIG9mIGlu
dmVudGluZyBhIG5ldyBBUEkgdGhhdCBjYXJyaWVzIHRoZSBmbGFncy4gVHdlYWsgdGhlCj4gPj4g
ZXhpc3Rpbmcgb25lIHNlZW1zIHRvIGJlIHNpbXBsZXIgYW5kIGJldHRlcj8KPiA+IFdlbGwsIGFz
IGluZGljYXRlZCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsIHRoaXMgYWxsb3dzIHZob3N0LXZkcGEg
YmUKPiA+IGFibGUgdG8ga25vdyB3aGljaCBkcml2ZXIgaGFkIGJyb2tlbiBiZWhhdmlvciBiZWZv
cmUsIHNvIGl0Cj4gPiBjYW4gYXBwbHkgdGhlIGNvcnJlc3BvbmRpbmcgY29tcGF0aWJpbGl0eSBx
dWlyayB0byB0aGUgaW5kaXZpZHVhbAo+ID4gZHJpdmVyIHdoZW4gaXQncyByZWFsbHkgbmVjZXNz
YXJ5LiBJZiBzZW5kaW5nIGFsbCBmbGFncwo+ID4gdW5jb25kaXRpb25hbGx5IGRvd24gdG8gZXZl
cnkgZHJpdmVyLAoKSXQgZGVwZW5kcyBvbiB3aGV0aGVyIElPVExCX1BFUlNJU1QgaXMgc2V0LgoK
PiBpdCdzIGhhcmQgZm9yIGRyaXZlciB3cml0ZXJzIHRvCj4gPiBkaXN0aW5ndWlzaCB3aGljaCBh
cmUgY29tcGF0aWJpbGl0eSBxdWlya3MgdGhhdCB0aGV5IGNhbiBzYWZlbHkgaWdub3JlCj4gPiBh
bmQgd2hpY2ggYXJlIGZlYXR1cmUgZmxhZ3MgdGhhdCBhcmUgZW5jb3VyYWdlZCB0byBpbXBsZW1l
bnQuIEluIHRoYXQKPiA+IHNlbnNlLCBnYXRpbmcgZmVhdHVyZXMgZnJvbSBiZWluZyBwb2xsdXRl
ZCBieSBjb21wYXRpYmlsaXR5IHF1aXJrcwo+ID4gd2l0aCBhbiBpbXBsaWNpdCBvcAo+IHMvaW1w
bGljaXQvZXhwbGljaXQvCj4gPiB3b3VsZCBiZSBiZXR0ZXIuCgpCb3RoIG9mIHVzIGhhdmUgdGhl
IHBvaW50cywgd2UgY2FuIGxpc3RlbiB0byBNaWNoYWVsIG9yIEV1Z2VuaW8gZm9yIHN1cmUuCgpU
aGFua3MKCj4gPgo+ID4gUmVnYXJkcywKPiA+IC1TaXdlaQo+ID4+Cj4gPj4gQXMgY29tcGF0X3Jl
c2V0KHZkZXYsIDApID09IHJlc2V0KHZkZXYpCj4gPj4KPiA+PiBUaGVuIHlvdSBkb24ndCBuZWVk
IHRoZSBzd2l0Y2ggaW4gdGhlIHBhcmVudCBhcyB3ZWxsCj4gPj4KPiA+PiArc3RhdGljIGludCB2
ZHBhc2ltX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSkKPiA+PiArewo+ID4+ICsgICAg
ICAgcmV0dXJuIHZkcGFzaW1fY29tcGF0X3Jlc2V0KHZkcGEsIDApOwo+ID4+ICt9Cj4gPj4KPiA+
PiBUaGFua3MKPiA+Pgo+ID4+Cj4gPj4+IHVwX3dyaXRlKCZ2ZGV2LT5jZl9sb2NrKTsKPiA+Pj4g
ICAgICAgICAgcmV0dXJuIHJldDsKPiA+Pj4gICB9Cj4gPj4+IC0tCj4gPj4+IDIuMzkuMwo+ID4+
Pgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

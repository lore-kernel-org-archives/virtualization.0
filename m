Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D84C7618A
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 09:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3D026106A;
	Thu, 16 Mar 2023 09:40:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E3D026106A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZs61349
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0OD8uugf8vqK; Thu, 16 Mar 2023 09:40:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4B5B261050;
	Thu, 16 Mar 2023 09:40:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B5B261050
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 019F0C0035;
	Thu, 16 Mar 2023 09:40:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DAEDC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D601B41655
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:40:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D601B41655
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZs61349
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01xa-QZ1v8Gh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:40:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C096E410C9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C096E410C9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678959644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZXIavcup9moQEJGr6LwMTUSPH1Mz9ROwd5wEWBmINU=;
 b=TZs61349kDbjOMDiVjyw5azlytchgM0C/xh6fAZkkE0ZaLGlkAkZQpIRe6AWDYbttdjEG9
 zN6JaDp1mdB76bOAnHqPV8endnU+HGygGFd5H+J9jiwTPYGf+nm/d1EHbPoY7+dwxxpehC
 8KxHfgn+GvVMxAnlyX4zfnhZr19XhmU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-PQUlgFcVO5yVofmrMQz_QQ-1; Thu, 16 Mar 2023 05:40:43 -0400
X-MC-Unique: PQUlgFcVO5yVofmrMQz_QQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-172cafd4245so877630fac.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678959643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZXIavcup9moQEJGr6LwMTUSPH1Mz9ROwd5wEWBmINU=;
 b=nPs/P9DARcddGeAKfZVJXSxpjiEXqiM4nEX4coXaZg9Qi+i4i17VKPUlfNyqPBPrVv
 ub9iCur+KeDiAA482JGQHh1CK7gsB07U2ay7HyaFJPKkUkkMsUkF5qL5+CUltv2bbRrq
 g4X+Xpw1t+o2Cta9X9DGRtpHq44Tu4K8VSML2DZUID2Mpr5dB0nWkRidslVEQWNDHFsi
 gX5pgZL0+FqL674mnv4ekW3nEVObwH5rAWTo99cTW3xodzLqDVMcKVDLZco7d588bT40
 Cfn15nHBLpFDIqeQ5l86JPYv3v1cyWOuUlYohb61H1kUlLeOqSzH2cmiN9jdHmKkATU1
 oi3A==
X-Gm-Message-State: AO0yUKW3q/TG7bNQiqvAaFvWVwHcmAk2eyRrsizo2xNA6buxFgIjQxPh
 B33n8tJYyEExansHfYwy1TmCL3AGP8akBf/IkTKKfoUWrrRlZtnwg+4cN+wEzJv2AmhXz7JoCUV
 uJDzuSmXdjHgK5WZpo4Muo67fCDHArOpZsUMj93rkAH/QuNX9Erd6Rn3w2g==
X-Received: by 2002:a9d:16e:0:b0:69d:23ff:3316 with SMTP id
 101-20020a9d016e000000b0069d23ff3316mr415022otu.2.1678959642829; 
 Thu, 16 Mar 2023 02:40:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set+3P629b9UC4jPBqIK+YY0u7gx3q6xj2A/iPz+xIIJzq2NeXDREDht+EkjELcwvBp5P4Z+NxdttfczVci2LSbg=
X-Received: by 2002:a9d:16e:0:b0:69d:23ff:3316 with SMTP id
 101-20020a9d016e000000b0069d23ff3316mr415018otu.2.1678959642622; Thu, 16 Mar
 2023 02:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-9-xieyongji@bytedance.com>
 <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
In-Reply-To: <f7f30935-afc6-4864-6663-21007524a377@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Mar 2023 17:40:31 +0800
Message-ID: <CACGkMEtx5EyBPdKjJdj9SrBj7fSud+QPsg8j2CYoeh+Rs0P-sg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] vdpa: Add eventfd for the vdpa callback
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de,
 hch@lst.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgNToyNeKAr1BNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMy8yLzI4IDE3OjQxLCBYaWUgWW9uZ2ppIOWG
memBkzoKPiA+IEFkZCBldmVudGZkIGZvciB0aGUgdmRwYSBjYWxsYmFjayBzbyB0aGF0IHVzZXIK
PiA+IGNhbiBzaWduYWwgaXQgZGlyZWN0bHkgaW5zdGVhZCBvZiBydW5uaW5nIHRoZQo+ID4gY2Fs
bGJhY2suIEl0IHdpbGwgYmUgdXNlZCBmb3Igdmhvc3QtdmRwYSBjYXNlLgo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ID4gLS0tCj4g
PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgfCAyICsrCj4gPiAgIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb192ZHBhLmMgfCAxICsKPiA+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAg
ICB8IDMgKysrCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMK
PiA+IGluZGV4IGRjMTJkYmQ1YjQzYi4uYWU4OWMwY2NjMmJiIDEwMDY0NAo+ID4gLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiBAQCAt
NTk5LDkgKzU5OSwxMSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0cnVj
dCB2aG9zdF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+ID4gICAgICAgICAgICAgICBpZiAo
dnEtPmNhbGxfY3R4LmN0eCkgewo+ID4gICAgICAgICAgICAgICAgICAgICAgIGNiLmNhbGxiYWNr
ID0gdmhvc3RfdmRwYV92aXJ0cXVldWVfY2I7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgY2Iu
cHJpdmF0ZSA9IHZxOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNiLmlycV9jdHggPSB2cS0+
Y2FsbF9jdHguY3R4Owo+ID4gICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIGNiLmNhbGxiYWNrID0gTlVMTDsKPiA+ICAgICAgICAgICAgICAgICAgICAgICBj
Yi5wcml2YXRlID0gTlVMTDsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBjYi5pcnFfY3R4ID0g
TlVMTDsKPiA+ICAgICAgICAgICAgICAgfQo+ID4gICAgICAgICAgICAgICBvcHMtPnNldF92cV9j
Yih2ZHBhLCBpZHgsICZjYik7Cj4gPiAgICAgICAgICAgICAgIHZob3N0X3ZkcGFfc2V0dXBfdnFf
aXJxKHYsIGlkeCk7Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiA+IGluZGV4IDllZWU4YWZhYmRhOC4u
YTVjZWNhZmJjMmQxIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEu
Ywo+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+ID4gQEAgLTE5NSw2ICsx
OTUsNyBAQCB2aXJ0aW9fdmRwYV9zZXR1cF92cShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwg
dW5zaWduZWQgaW50IGluZGV4LAo+ID4gICAgICAgLyogU2V0dXAgdmlydHF1ZXVlIGNhbGxiYWNr
ICovCj4gPiAgICAgICBjYi5jYWxsYmFjayA9IGNhbGxiYWNrID8gdmlydGlvX3ZkcGFfdmlydHF1
ZXVlX2NiIDogTlVMTDsKPiA+ICAgICAgIGNiLnByaXZhdGUgPSBpbmZvOwo+ID4gKyAgICAgY2Iu
aXJxX2N0eCA9IE5VTEw7Cj4gPiAgICAgICBvcHMtPnNldF92cV9jYih2ZHBhLCBpbmRleCwgJmNi
KTsKPiA+ICAgICAgIG9wcy0+c2V0X3ZxX251bSh2ZHBhLCBpbmRleCwgdmlydHF1ZXVlX2dldF92
cmluZ19zaXplKHZxKSk7Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5o
IGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+IGluZGV4IDEwYmQyMjM4NzI3Ni4uOTRhN2VjNDk1
ODNhIDEwMDY0NAo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+ICsrKyBiL2luY2x1
ZGUvbGludXgvdmRwYS5oCj4gPiBAQCAtMTMsMTAgKzEzLDEzIEBACj4gPiAgICAqIHN0cnVjdCB2
ZHBhX2NhbGxsYmFjayAtIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPiA+ICAgICogQGNhbGxi
YWNrOiBpbnRlcnJ1cHQgY2FsbGJhY2sgZnVuY3Rpb24KPiA+ICAgICogQHByaXZhdGU6IHRoZSBk
YXRhIHBhc3NlZCB0byB0aGUgY2FsbGJhY2sgZnVuY3Rpb24KPiA+ICsgKiBAaXJxX2N0eDogdGhl
IGV2ZW50ZmQgZm9yIHRoZSBjYWxsYmFjaywgdXNlciBjYW4gc2lnbmFsCj4gPiArICogICAgICAg
ICAgIGl0IGRpcmVjdGx5IGluc3RlYWQgb2YgcnVubmluZyB0aGUgY2FsbGJhY2sKPgo+Cj4gSSdk
IHN1Z2dlc3QgdG8gZG8gbW9yZSB0d2Vha3MgdG8gbWVudGlvbjoKPgo+IDEpIGlycV9jdHggaXMg
b3B0aW9uYWwKPiAyKSB0aGF0IHdoZW4gdGhlIGlycV9jdHggaXMgc2V0LCB0aGUgdkRQQSBkcml2
ZXIgbXVzdCBndWFyYW50ZWUgdGhhdAo+IHNpZ25hbGluZyBpdCBpcyBmdW5jdGlvbmFsIGVxdWl2
YWxlbnQgdG8gdHJpZ2dlcmluZyB0aGUgY2FsbGJhY2suIFdoZW4KPiBzZXQsIHZEUEEgcGFyZW50
IGNhbiBzaWduYWwgaXQgZGlyZWN0bHkgaW5zdGVhZCBvZiB0cmlnZ2VyaW5nIHRoZSBjYWxsYmFj
ay4KPgo+ID4gICAgKi8KPiA+ICAgc3RydWN0IHZkcGFfY2FsbGJhY2sgewo+ID4gICAgICAgaXJx
cmV0dXJuX3QgKCpjYWxsYmFjaykodm9pZCAqZGF0YSk7Cj4gPiAgICAgICB2b2lkICpwcml2YXRl
Owo+ID4gKyAgICAgc3RydWN0IGV2ZW50ZmRfY3R4ICppcnFfY3R4Owo+Cj4KPiBUaGVyZSdzIG5v
IElSUSBjb25jZXB0IGF0IHRoZSB2aXJ0dWFsIHZEUEEgYnVzIGxldmVsLCBzbyBpdCdzIHByb2Jh
Ymx5Cj4gYmV0dGVyIHRvIHJlbmFtZSBpdCBhcyAidHJpZ2dlciIuCj4KPiBCdHcsIHNob3VsZCB3
ZSBzZWxlY3QgRVZFTlRGRCBmb3IgdkRQQT8KCkxvb2tzIGxpa2Ugd2UgYXJlIGZpbmUgaGVyZSBz
aW5jZSB3ZSBvbmx5IHVzZSB0aGUgcG9pbnRlciB0byB0aGUgZXZlbnRmZF9jdHguCgpUaGFua3MK
Cj4KPiBUaGFua3MKPgo+Cj4gPiAgIH07Cj4gPgo+ID4gICAvKioKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

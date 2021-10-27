Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF217C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:03:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738A560F9B
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 06:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 738A560F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 205C44018E;
	Wed, 27 Oct 2021 06:03:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CjDHY61aapbB; Wed, 27 Oct 2021 06:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93C564010F;
	Wed, 27 Oct 2021 06:03:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4578AC0012;
	Wed, 27 Oct 2021 06:03:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56E51C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5352C4026E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4adFSfGL17B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:03:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 266314026B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 06:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635314591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnZrLkCBaK5wFXfWCooWz6upe3zDfgRxQCNxNm3vRdE=;
 b=T5pjQEFks6xZb9xo1lZtKDa5x5tui86vYH18andxiAEkzppf0u6DwJ6t2jR+8MQEyt+WMl
 0a7AtrdMoqGqEUJZBKrPeEjBOofVZ1Wt103j6dmo/BISYMzvkLwRBDC3uz3SAv+wHGv9uV
 kVn+kKxfL4OlQOw7O3SIjrADG2FY+9A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Wdm2hbQxPvCH0gSwAtPd0A-1; Wed, 27 Oct 2021 02:03:09 -0400
X-MC-Unique: Wdm2hbQxPvCH0gSwAtPd0A-1
Received: by mail-lf1-f71.google.com with SMTP id
 c41-20020a05651223a900b003fdb648a156so874877lfv.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 23:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dnZrLkCBaK5wFXfWCooWz6upe3zDfgRxQCNxNm3vRdE=;
 b=CaNTw0OudGMW7EF97y6cmDjlK4vt5L3/amEYMvQX/ersSADHJzTf+nE8XkiTilpXTP
 8mbmOmNvKfTkcVjszL0vWyRAZshG2VA4tPbtc4AZPk8aa5q2rQfm98wJC+MnsGeH51GK
 T9nlNLCCRWa6XKVXOsJ/FdFqzR/7WNiHOyX/8uC9HCWzOcaJg+epn3V1JYKTUV/Vk5ss
 xf0WhRPq3+Su1+4vmAEg8GeB+q2Rm8DLWEqRnkILrA73rKCSjLRGmWu+jV5EbxN12ziZ
 /p53kzCDcc/sIprr3w0u3ZJ0ORoEfzis2JRppSdxkq8cEOhns+gSEREHPrnlgTWXqqOO
 X0tA==
X-Gm-Message-State: AOAM533h2Qsp3x4XeQicUtYJi7bmitvaYqkTPc4ZcCcpFx0kykWfmerH
 5KCp+o1QhjcqGkxFiwETgPPWfZZVDyairOYOV6ghgl2zB2Uh4cAtZDv0hiZJInnc1XJQGvn5I1O
 Rp8I9JVz0QXOUo8XQ9Cyqc6RYvcBxR6O0MolnksfhdpNTT1CWk/AuH3V91w==
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr9901978lfs.84.1635314587933; 
 Tue, 26 Oct 2021 23:03:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQkkDQClqmU3dFpYeFR2oDSYbiarQrMX+O5rhSz4qv3ql+2LJ9hYbtYwCNezSdtj25uqo2woqP1s/lx/H+m5g=
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr9901948lfs.84.1635314587688; 
 Tue, 26 Oct 2021 23:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <8aee8f07-76bd-f111-bc5f-fc5cad46ce56@redhat.com>
 <4d33b7e1-5efb-3729-ee15-98608704f096@oracle.com>
In-Reply-To: <4d33b7e1-5efb-3729-ee15-98608704f096@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 27 Oct 2021 14:02:56 +0800
Message-ID: <CACGkMEv6_VVFWPT-yxO=35EWvGNz0t9-hopF3+Y7g1ugnPDB4g@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
To: Mike Christie <michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-scsi@vger.kernel.org, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 pbonzini <pbonzini@redhat.com>
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

T24gV2VkLCBPY3QgMjcsIDIwMjEgYXQgMTI6NDkgQU0gPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xl
LmNvbT4gd3JvdGU6Cj4KPiBPbiAxMC8yNi8yMSAxMjozNyBBTSwgSmFzb24gV2FuZyB3cm90ZToK
PiA+Cj4gPiDlnKggMjAyMS8xMC8yMiDkuIvljYgxOjE5LCBNaWtlIENocmlzdGllIOWGmemBkzoK
PiA+PiBUaGlzIHBhdGNoIGFsbG93cyB1c2Vyc3BhY2UgdG8gY3JlYXRlIHdvcmtlcnMgYW5kIGJp
bmQgdGhlbSB0byB2cXMuIFlvdQo+ID4+IGNhbiBoYXZlIE4gd29ya2VycyBwZXIgZGV2IGFuZCBh
bHNvIHNoYXJlIE4gd29ya2VycyB3aXRoIE0gdnFzLgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTog
TWlrZSBDaHJpc3RpZSA8bWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tPgo+ID4KPiA+Cj4gPiBB
IHF1ZXN0aW9uLCB3aG8gaXMgdGhlIGJlc3Qgb25lIHRvIGRldGVybWluZSB0aGUgYmluZGluZz8g
SXMgaXQgdGhlIFZNTSAoUWVtdSBldGMpIG9yIHRoZSBtYW5hZ2VtZW50IHN0YWNrPyBJZiB0aGUg
bGF0dGVyLCBpdCBsb29rcyB0byBtZSBpdCdzIGJldHRlciB0byBleHBvc2UgdGhpcyB2aWEgc3lz
ZnM/Cj4KPiBJIHRob3VnaHQgaXQgd291bGQgYmUgd2hlcmUgeW91IGhhdmUgbWFuYWdlbWVudCBh
cHAgc2V0dGluZ3MsIHRoZW4gdGhlCj4gbWFuYWdlbWVudCBhcHAgdGFsa3MgdG8gdGhlIHFlbXUg
Y29udHJvbCBpbnRlcmZhY2UgbGlrZSBpdCBkb2VzIHdoZW4gaXQKPiBhZGRzIG5ldyBkZXZpY2Vz
IG9uIHRoZSBmbHkuCj4KPiBBIHByb2JsZW0gd2l0aCB0aGUgbWFuYWdlbWVudCBhcHAgZG9pbmcg
aXQgaXMgdG8gaGFuZGxlIHRoZSBSTElNSVRfTlBST0MKPiByZXZpZXcgY29tbWVudCwgdGhpcyBw
YXRjaHNldDoKPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIxMTAwNzIxNDQ0OC42
MjgyLTEtbWljaGFlbC5jaHJpc3RpZUBvcmFjbGUuY29tLwo+Cj4gYmFzaWNhbGx5IGhhcyB0aGUg
a2VybmVsIGRvIGEgY2xvbmUoKSBmcm9tIHRoZSBjYWxsZXIncyBjb250ZXh0LiBTbyBhZGRpbmcK
PiBhIHdvcmtlciBpcyBsaWtlIGRvaW5nIHRoZSBWSE9TVF9TRVRfT1dORVIgaW9jdGwgd2hlcmUg
aXQgc3RpbGwgaGFzIHRvIGJlIGRvbmUKPiBmcm9tIGEgcHJvY2VzcyB5b3UgY2FuIGluaGVyaXQg
dmFsdWVzIGxpa2UgdGhlIG1tLCBjZ3JvdXBzLCBhbmQgbm93IFJMSU1JVHMuCgpSaWdodCwgc28g
YXMgU3RlZmFuIHN1Z2dlc3RlZCwgd2UgcHJvYmFibHkgbmVlZCBuZXcgUU1QIGNvbW1hbmRzIHRo
ZW4KbWFuYWdlbWVudCBjYW4gaGVscCB0aGVyZS4gVGhlbiBpdCBjYW4gc2F0aXNmeSB0aGUgbW9k
ZWwgeW91IGRlc2NyaWJlZAphYm92ZS4KCj4KPgo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvbGludXgvdmhvc3RfdHlwZXMuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5o
Cj4gPj4gaW5kZXggZjdmNmEzYTI4OTc3Li5hZjY1NGUzY2VmMGUgMTAwNjQ0Cj4gPj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKPiA+PiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdmhvc3RfdHlwZXMuaAo+ID4+IEBAIC00Nyw2ICs0NywxOCBAQCBzdHJ1Y3Qgdmhvc3Rf
dnJpbmdfYWRkciB7Cj4gPj4gICAgICAgX191NjQgbG9nX2d1ZXN0X2FkZHI7Cj4gPj4gICB9Owo+
ID4+ICAgKyNkZWZpbmUgVkhPU1RfVlJJTkdfTkVXX1dPUktFUiAtMQo+ID4KPiA+Cj4gPiBEbyB3
ZSBuZWVkIFZIT1NUX1ZSSU5HX0ZSRUVfV09SS0VSPyBBbmQgSSB3b25kZXIgaWYgdXNpbmcgZGVk
aWNhdGVkIGlvY3RscyBhcmUgYmV0dGVyOgo+ID4KPiA+IFZIT1NUX1ZSSU5HX05FVy9GUkVFX1dP
UktFUgo+ID4gVkhPU1RfVlJJTkdfQVRUQUNIX1dPUktFUgo+Cj4KPiBXZSBkaWRuJ3QgbmVlZCBh
IGZyZWUgd29ya2VyLCBiZWNhdXNlIHRoZSBrZXJuZWwgaGFuZGxlcyBpdCBmb3IgdXNlcnNwYWNl
LiBJCj4gdHJpZWQgdG8gbWFrZSBpdCBlYXN5IGZvciB1c2Vyc3BhY2UgYmVjYXVzZSBpbiBzb21l
IGNhc2VzIGl0IG1heSBub3QgYmUgYWJsZQo+IHRvIGRvIHN5c2NhbGxzIGxpa2UgY2xvc2Ugb24g
dGhlIGRldmljZS4gRm9yIGV4YW1wbGUgaWYgcWVtdSBjcmFzaGVzIG9yIGZvcgo+IHZob3N0LXNj
c2kgd2UgZG9uJ3QgZG8gYW4gZXhwbGljaXQgY2xvc2UgZHVyaW5nIFZNIHNodXRkb3duLgo+CgpP
aywgdGhlIG1vdGl2YXRpb24gaXMgdGhhdCBpZiBpbiBzb21lIGNhc2VzIChlLmcgdGhlIGFjdGl2
ZSBudW1iZXIgb2YKcXVldWVzIGFyZSBjaGFuZ2VkKSwgcWVtdSBjYW4gY2hvb3NlIHRvIGZyZWUg
c29tZSByZXNvdXJjZXMuCgo+IFNvIHdlIHN0YXJ0IG9mZiB3aXRoIHRoZSBkZWZhdWx0IHdvcmtl
ciB0aHJlYWQgdGhhdCdzIHVzZWQgYnkgYWxsIHZxcyBsaWtlIHdlIGRvCj4gdG9kYXkuIFVzZXJz
cGFjZSBjYW4gdGhlbiBvdmVycmlkZSBpdCBieSBjcmVhdGluZyBhIG5ldyB3b3JrZXIuIFRoYXQg
YWxzbyB1bmJpbmRzLwo+IGRldGFjaGVzIHRoZSBleGlzdGluZyB3b3JrZXIgYW5kIGRvZXMgYSBw
dXQgb24gdGhlIHdvcmtlcnMgcmVmY291bnQuIFdlIGFsc28gZG8gYQo+IHB1dCBvbiB0aGUgd29y
a2VyIHdoZW4gd2Ugc3RvcCB1c2luZyBpdCBkdXJpbmcgZGV2aWNlIHNodXRkb3duL2Nsb3N1cmUv
cmVsZWFzZS4KPiBXaGVuIHRoZSB3b3JrZXIncyByZWZjb3VudCBnb2VzIHRvIHplcm8gdGhlIGtl
cm5lbCBkZWxldGVzIGl0Lgo+Cj4gSSB0aGluayBzZXBhcmF0aW5nIHRoZSBjYWxscyBjb3VsZCBi
ZSBoZWxwZnVsIHRob3VnaC4KPgoKT2suCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

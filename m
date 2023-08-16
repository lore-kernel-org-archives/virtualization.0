Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C04C001B0
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 01:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24D37605C9;
	Wed, 16 Aug 2023 01:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 24D37605C9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QIVzJv+k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LEF0MKG0RqEK; Wed, 16 Aug 2023 01:48:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A43560594;
	Wed, 16 Aug 2023 01:48:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A43560594
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0BA4C0071;
	Wed, 16 Aug 2023 01:48:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51130C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23FFF82142
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:48:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23FFF82142
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QIVzJv+k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fOAchn7IsYuq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:48:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D453D82141
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 01:48:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D453D82141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692150498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVBkV5dzZAWODtzWnKoi2MILlBe8Jt7Xq72lWn3roK8=;
 b=QIVzJv+kbtkrsqgdPrdU1LU6VJu+6XuPWr/VKQCQ/Zln9vcI9q9Xs1OqpXR06HGSCk7lJd
 AeDeLPN5UEaYfnEgpjKfazNWFRaJfeL7v7uLZXmE2qwYkDXc2GiL6LYVhHEVyKFC8DCt21
 tgfhFVPxj054DaRnbayJx/UoYKoKIak=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207--qb5FzZGMA6WR0yWHT99uA-1; Tue, 15 Aug 2023 21:48:17 -0400
X-MC-Unique: -qb5FzZGMA6WR0yWHT99uA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fe56b43af3so5523919e87.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Aug 2023 18:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150496; x=1692755296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVBkV5dzZAWODtzWnKoi2MILlBe8Jt7Xq72lWn3roK8=;
 b=HW/5LFczTSyaEuvGeIRJ3wgxdpzBMHe6HkCiYfRdtyyxnb7FyYh4aBkwlPxjxINtgP
 ejkun6cXhKjIN8Rtr9XChwANe9tGA+oIoRkWt96++ld5xnlULx6eZ4JQfjf2SDUaT3sc
 599ejCzfRScf05SXEWSOP+hk7FCIjlOVFx8C6KO7/FYuuHj7Mlv7BSXMh0NK7SjY8oc+
 O2vYNukxMy3etrkNol2c5wC9jkPIw1Op3oLcG4gvWAADab2hVJ42pkFw57CQwagHAeQx
 YClGlXM6NwVAvSHc2FU9dpinhjp9CVCQglv2XqI/yb+5zbGHQisTmI7dWkO3Slir+xKY
 21Ag==
X-Gm-Message-State: AOJu0YzUthDQY+Ujnz0/+LzZZOIHsHN1W+e/AezAbBZUkIs3XH83U7W2
 /CEX+F474q03G9VTX17WBHSZy+YI4X8Icm/L9VOwIMBL+y09yW62R0hrEmXl7e/At/yYY7Vq1gK
 8D8qrzQepFLDl0nwO/Fp6XQaoAp6fKQFgGATT5BHNZFNYvodpyxjQgY+etw==
X-Received: by 2002:a05:6512:2342:b0:4ff:8fdd:4be4 with SMTP id
 p2-20020a056512234200b004ff8fdd4be4mr489602lfu.29.1692150495924; 
 Tue, 15 Aug 2023 18:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmh9t4DGDwhiZVL0/RxuMUJJONbpBOZnGAmz9am62b5NR3mpM4FTr9ke8hEnOR5xxPCekRv6EprWABGnAMAg=
X-Received: by 2002:a05:6512:2342:b0:4ff:8fdd:4be4 with SMTP id
 p2-20020a056512234200b004ff8fdd4be4mr489594lfu.29.1692150495563; Tue, 15 Aug
 2023 18:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
In-Reply-To: <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Aug 2023 09:48:04 +0800
Message-ID: <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, gal@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com
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

T24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgNjozMeKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOC8xNC8yMDIzIDc6MjUgUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiBPbiBUdWUsIEF1ZyAxNSwgMjAyMyBhdCA5OjQ14oCvQU0gU2ktV2VpIExp
dSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPiA+PiBTaWduZWQtb2ZmLWJ5OiBTaS1X
ZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL3Zo
b3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDE2ICsrKysrKysrKysrKysrKy0KPiA+PiAgIGluY2x1
ZGUvdWFwaS9saW51eC92aG9zdF90eXBlcy5oIHwgIDIgKysKPiA+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+PiBpbmRleCA2
MmIwYTAxLi43NTA5MmE3IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4g
Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+PiBAQCAtNDA2LDYgKzQwNiwxNCBAQCBz
dGF0aWMgYm9vbCB2aG9zdF92ZHBhX2Nhbl9yZXN1bWUoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEg
KnYpCj4gPj4gICAgICAgICAgcmV0dXJuIG9wcy0+cmVzdW1lOwo+ID4+ICAgfQo+ID4+Cj4gPj4g
K3N0YXRpYyBib29sIHZob3N0X3ZkcGFfaGFzX3BlcnNpc3RlbnRfbWFwKGNvbnN0IHN0cnVjdCB2
aG9zdF92ZHBhICp2KQo+ID4+ICt7Cj4gPj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGEgPSB2LT52ZHBhOwo+ID4+ICsgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAq
b3BzID0gdmRwYS0+Y29uZmlnOwo+ID4+ICsKPiA+PiArICAgICAgIHJldHVybiAoIW9wcy0+c2V0
X21hcCAmJiAhb3BzLT5kbWFfbWFwKSB8fCBvcHMtPnJlc2V0X21hcDsKPiA+IFNvIHRoaXMgbWVh
bnMgdGhlIElPVExCL0lPTU1VIG1hcHBpbmdzIGhhdmUgYWxyZWFkeSBiZWVuIGRlY291cGxlZAo+
ID4gZnJvbSB0aGUgdmRwYSByZXNldC4KPiBOb3QgaW4gdGhlIHNlbnNlIG9mIEFQSSwgaXQnIGJl
ZW4gY291cGxlZCBzaW5jZSBkYXkgb25lIGZyb20gdGhlCj4gaW1wbGVtZW50YXRpb25zIG9mIGV2
ZXJ5IG9uLWNoaXAgSU9NTVUgcGFyZW50IGRyaXZlciwgbmFtZWx5IG1seDVfdmRwYQo+IGFuZCB2
ZHBhX3NpbS4gQmVjYXVzZSBvZiB0aGF0LCBsYXRlciBvbiB0aGUgKGltcHJvcGVyKSBzdXBwb3J0
IGZvcgo+IHZpcnRpby12ZHBhLCBmcm9tIGNvbW1pdCA2ZjUzMTJmODAxODMgKCJ2ZHBhL21seDU6
IEFkZCBzdXBwb3J0IGZvcgo+IHJ1bm5pbmcgd2l0aCB2aXJ0aW9fdmRwYSIpIGFuZCA2YzNkMzI5
ZTY0ODYgKCJ2ZHBhX3NpbTogZ2V0IHJpZCBvZiBETUEKPiBvcHMiKSBtaXN1c2VkIHRoZSAucmVz
ZXQoKSBvcCB0byByZWFsaXplIDE6MSBtYXBwaW5nLCByZW5kZXJpbmcgc3Ryb25nCj4gY291cGxp
bmcgYmV0d2VlbiBkZXZpY2UgcmVzZXQgYW5kIHJlc2V0IG9mIGlvdGxiIG1hcHBpbmdzLiBUaGlz
IHNlcmllcwo+IHRyeSB0byByZWN0aWZ5IHRoYXQgaW1wbGVtZW50YXRpb24gZGVmaWNpZW5jeSwg
d2hpbGUga2VlcCB1c2Vyc3BhY2UKPiBjb250aW51aW5nIHRvIHdvcmsgd2l0aCBvbGRlciBrZXJu
ZWwgYmVoYXZpb3IuCj4KPiA+ICAgU28gaXQgc2hvdWxkIGhhdmUgYmVlbiBub3RpY2VkIGJ5IHRo
ZSB1c2Vyc3BhY2UuCj4gWWVzLCB1c2Vyc3BhY2UgaGFkIG5vdGljZWQgdGhpcyBuby1jaGlwIElP
TU1VIGRpc2NyZXBhbmN5IHNpbmNlIGRheSBvbmUKPiBJIHN1cHBvc2UuIFVuZm9ydHVuYXRlbHkg
dGhlcmUncyBhbHJlYWR5IGNvZGUgaW4gdXNlcnNwYWNlIHdpdGggdGhpcwo+IGFzc3VtcHRpb24g
aW4gbWluZCB0aGF0IHByb2FjdGl2ZWx5IHRlYXJzIGRvd24gYW5kIHNldHMgdXAgaW90bGIgbWFw
cGluZwo+IGFyb3VuZCB2ZHBhIGRldmljZSByZXNldC4uLgo+ID4gSSBndWVzcyB3ZSBjYW4ganVz
dCBmaXggdGhlIHNpbXVsYXRvciBhbmQgbWx4NSB0aGVuIHdlIGFyZSBmaW5lPwo+IE9ubHkgSUYg
d2UgZG9uJ3QgY2FyZSBhYm91dCBydW5uaW5nIG5ldyBRRU1VIG9uIG9sZGVyIGtlcm5lbHMgd2l0
aAo+IGZsYXdlZCBvbi1jaGlwIGlvbW11IGJlaGF2aW9yIGFyb3VuZCByZXNldC4gQnV0IHRoYXQn
cyBhIGJpZyBJRi4uLgoKU28gd2hhdCBJIG1lYW50IGlzOgoKVXNlcnNwYWNlIGRvZXNuJ3Qga25v
dyB3aGV0aGVyIHRoZSB2ZW5kb3Igc3BlY2lmaWMgbWFwcGluZ3MgKHNldF9tYXApCmFyZSByZXF1
aXJlZCBvciBub3QuIEFuZCBpbiB0aGUgaW1wbGVtZW50YXRpb24gb2Ygdmhvc3RfdmRwYSwgaWYK
cGxhdGZvcm0gSU9NTVUgaXMgdXNlZCwgdGhlIG1hcHBpbmdzIGFyZSBkZWNvdXBsZWQgZnJvbSB0
aGUgcmVzZXQuIFNvCmlmIHRoZSBRZW11IHdvcmtzIHdpdGggcGFyZW50cyB3aXRoIHBsYXRmb3Jt
IElPTU1VIGl0IG1lYW5zIFFlbXUgY2FuCndvcmsgaWYgd2UganVzdCBkZWNvdXBsZSB2ZW5kb3Ig
c3BlY2lmaWMgbWFwcGluZ3MgZnJvbSB0aGUgcGFyZW50cwp0aGF0IHVzZXMgc2V0X21hcC4KClRo
YW5rcwoKPgo+IFJlZ2FyZHMsCj4gLVNpd2VpCj4gPgo+ID4gVGhhbmtzCj4gPgo+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

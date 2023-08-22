Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B881BEE4993
	for <virtualization@archiver.kernel.org>; Tue, 22 Aug 2023 08:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DDED408D1;
	Tue, 22 Aug 2023 08:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0DDED408D1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FPJ+yeG7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqID6thumRR5; Tue, 22 Aug 2023 08:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 298D64090C;
	Tue, 22 Aug 2023 08:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 298D64090C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBEA5C0088;
	Tue, 22 Aug 2023 08:55:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF8D3C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D09E61147
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:54:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D09E61147
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FPJ+yeG7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GwVKf3l2t8ld
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:54:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A42E360AE8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 08:54:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A42E360AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692694497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpNZZm0xrOZji3+sFL4gaEKA2aO8eVbYxQuyUN3O8GQ=;
 b=FPJ+yeG7fbwHctYAmePsIVuiyqF9Wj8nsfBjX9N0wfi6DTZNKliXSVHWWqUXOWMyl5UdDN
 z7vcszDaevGRf0nxmqkXrm+afkph2T8vikjL54RL1qWmB+z6V+09vj8X5S/BM4uEe1Qi8Q
 7rDptDDIuGuEUlRUeqdh7yxF4VPFHi0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-7OZe3dyrMY-Zz-QsdAjhCw-1; Tue, 22 Aug 2023 04:54:56 -0400
X-MC-Unique: 7OZe3dyrMY-Zz-QsdAjhCw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bc84f4d7a5so14830651fa.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Aug 2023 01:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692694494; x=1693299294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpNZZm0xrOZji3+sFL4gaEKA2aO8eVbYxQuyUN3O8GQ=;
 b=GOuxJyO7fxWzmq5VVVAjpkhEFIcPKx6WMruGjlAjdfLxCVi7wP3VVwWcC+PdtHKXLx
 Nii/40PN5GEwY2Knt7GBBZA8JBRJBrIn+WyM6/9NhI9vcm6PuUfEsJALusCEnNqpsOib
 uub1LUgfHBaLjAGyd5pIlk7HhnAVqdemStJrZFfF9znJzVJ+qaG6Fy450i0jy5GdKJIm
 0+Og0vraCirQVSjOJQ5H5We7T/mLCftS0hsdUUwEgInQVW0DHSyggJStgnv6YMTIsQiu
 fsATpTaPaWlCoQygnb0z3hpYQiERRsq3Ano0ksfc2hBpvaiG7wcjcIluefWdzi4lSzKd
 4MUA==
X-Gm-Message-State: AOJu0YyEWC0Z5va+SAXJ3HUCOIr5l1EnoFGof5Vj6GADQuCWKNvEC7Jf
 nVDW8g2y4fNcS0+i8g0v7L6+o1gvYtL9T3fjy1Vzn1bqFY+6KNAp9neJ+UjWPQ3DDE9MjnEEKC9
 AorWWB/9YCSHCY+7y8S2HiMfypslOqF+bvJ7wDFFDAlplJKeUoemnuw8PkQ==
X-Received: by 2002:a2e:90cd:0:b0:2bc:c052:25b4 with SMTP id
 o13-20020a2e90cd000000b002bcc05225b4mr1761824ljg.19.1692694494523; 
 Tue, 22 Aug 2023 01:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsgvEvyPuN1nmaPQF0XF6UL0KXVvbjLrlQKHixu27C8/EN+LiH2p4Q7Ehyg4xJLpbfwhFF3ui+1btbYMHi5Z0=
X-Received: by 2002:a2e:90cd:0:b0:2bc:c052:25b4 with SMTP id
 o13-20020a2e90cd000000b002bcc05225b4mr1761812ljg.19.1692694494200; Tue, 22
 Aug 2023 01:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
 <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
 <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
In-Reply-To: <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Aug 2023 16:54:42 +0800
Message-ID: <CACGkMEtNZnGw+O2PkZkCgOd+NiU3kw7asYsGH3EkuOHd=GvCnA@mail.gmail.com>
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

T24gVGh1LCBBdWcgMTcsIDIwMjMgYXQgNzo0NOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOC8xNS8yMDIzIDY6NDggUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiBPbiBXZWQsIEF1ZyAxNiwgMjAyMyBhdCA2OjMx4oCvQU0gU2ktV2VpIExp
dSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPiB3cm90ZToKPiA+Pgo+ID4+Cj4gPj4gT24gOC8xNC8y
MDIzIDc6MjUgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPj4+IE9uIFR1ZSwgQXVnIDE1LCAyMDIz
IGF0IDk6NDXigK9BTSBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdyb3RlOgo+
ID4+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+
ID4+Pj4gLS0tCj4gPj4+PiAgICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgICAgICB8IDE2
ICsrKysrKysrKysrKysrKy0KPiA+Pj4+ICAgIGluY2x1ZGUvdWFwaS9saW51eC92aG9zdF90eXBl
cy5oIHwgIDIgKysKPiA+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+ID4+Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zk
cGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4+PiBpbmRleCA2MmIwYTAxLi43NTA5MmE3
IDEwMDY0NAo+ID4+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+Pj4+ICsrKyBiL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jCj4gPj4+PiBAQCAtNDA2LDYgKzQwNiwxNCBAQCBzdGF0aWMgYm9v
bCB2aG9zdF92ZHBhX2Nhbl9yZXN1bWUoY29uc3Qgc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gPj4+
PiAgICAgICAgICAgcmV0dXJuIG9wcy0+cmVzdW1lOwo+ID4+Pj4gICAgfQo+ID4+Pj4KPiA+Pj4+
ICtzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX2hhc19wZXJzaXN0ZW50X21hcChjb25zdCBzdHJ1Y3Qg
dmhvc3RfdmRwYSAqdikKPiA+Pj4+ICt7Cj4gPj4+PiArICAgICAgIHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSA9IHYtPnZkcGE7Cj4gPj4+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgKm9wcyA9IHZkcGEtPmNvbmZpZzsKPiA+Pj4+ICsKPiA+Pj4+ICsgICAgICAgcmV0dXJu
ICghb3BzLT5zZXRfbWFwICYmICFvcHMtPmRtYV9tYXApIHx8IG9wcy0+cmVzZXRfbWFwOwo+ID4+
PiBTbyB0aGlzIG1lYW5zIHRoZSBJT1RMQi9JT01NVSBtYXBwaW5ncyBoYXZlIGFscmVhZHkgYmVl
biBkZWNvdXBsZWQKPiA+Pj4gZnJvbSB0aGUgdmRwYSByZXNldC4KPiA+PiBOb3QgaW4gdGhlIHNl
bnNlIG9mIEFQSSwgaXQnIGJlZW4gY291cGxlZCBzaW5jZSBkYXkgb25lIGZyb20gdGhlCj4gPj4g
aW1wbGVtZW50YXRpb25zIG9mIGV2ZXJ5IG9uLWNoaXAgSU9NTVUgcGFyZW50IGRyaXZlciwgbmFt
ZWx5IG1seDVfdmRwYQo+ID4+IGFuZCB2ZHBhX3NpbS4gQmVjYXVzZSBvZiB0aGF0LCBsYXRlciBv
biB0aGUgKGltcHJvcGVyKSBzdXBwb3J0IGZvcgo+ID4+IHZpcnRpby12ZHBhLCBmcm9tIGNvbW1p
dCA2ZjUzMTJmODAxODMgKCJ2ZHBhL21seDU6IEFkZCBzdXBwb3J0IGZvcgo+ID4+IHJ1bm5pbmcg
d2l0aCB2aXJ0aW9fdmRwYSIpIGFuZCA2YzNkMzI5ZTY0ODYgKCJ2ZHBhX3NpbTogZ2V0IHJpZCBv
ZiBETUEKPiA+PiBvcHMiKSBtaXN1c2VkIHRoZSAucmVzZXQoKSBvcCB0byByZWFsaXplIDE6MSBt
YXBwaW5nLCByZW5kZXJpbmcgc3Ryb25nCj4gPj4gY291cGxpbmcgYmV0d2VlbiBkZXZpY2UgcmVz
ZXQgYW5kIHJlc2V0IG9mIGlvdGxiIG1hcHBpbmdzLiBUaGlzIHNlcmllcwo+ID4+IHRyeSB0byBy
ZWN0aWZ5IHRoYXQgaW1wbGVtZW50YXRpb24gZGVmaWNpZW5jeSwgd2hpbGUga2VlcCB1c2Vyc3Bh
Y2UKPiA+PiBjb250aW51aW5nIHRvIHdvcmsgd2l0aCBvbGRlciBrZXJuZWwgYmVoYXZpb3IuCj4g
Pj4KPiA+Pj4gICAgU28gaXQgc2hvdWxkIGhhdmUgYmVlbiBub3RpY2VkIGJ5IHRoZSB1c2Vyc3Bh
Y2UuCj4gPj4gWWVzLCB1c2Vyc3BhY2UgaGFkIG5vdGljZWQgdGhpcyBuby1jaGlwIElPTU1VIGRp
c2NyZXBhbmN5IHNpbmNlIGRheSBvbmUKPiA+PiBJIHN1cHBvc2UuIFVuZm9ydHVuYXRlbHkgdGhl
cmUncyBhbHJlYWR5IGNvZGUgaW4gdXNlcnNwYWNlIHdpdGggdGhpcwo+ID4+IGFzc3VtcHRpb24g
aW4gbWluZCB0aGF0IHByb2FjdGl2ZWx5IHRlYXJzIGRvd24gYW5kIHNldHMgdXAgaW90bGIgbWFw
cGluZwo+ID4+IGFyb3VuZCB2ZHBhIGRldmljZSByZXNldC4uLgo+ID4+PiBJIGd1ZXNzIHdlIGNh
biBqdXN0IGZpeCB0aGUgc2ltdWxhdG9yIGFuZCBtbHg1IHRoZW4gd2UgYXJlIGZpbmU/Cj4gPj4g
T25seSBJRiB3ZSBkb24ndCBjYXJlIGFib3V0IHJ1bm5pbmcgbmV3IFFFTVUgb24gb2xkZXIga2Vy
bmVscyB3aXRoCj4gPj4gZmxhd2VkIG9uLWNoaXAgaW9tbXUgYmVoYXZpb3IgYXJvdW5kIHJlc2V0
LiBCdXQgdGhhdCdzIGEgYmlnIElGLi4uCj4gPiBTbyB3aGF0IEkgbWVhbnQgaXM6Cj4gPgo+ID4g
VXNlcnNwYWNlIGRvZXNuJ3Qga25vdyB3aGV0aGVyIHRoZSB2ZW5kb3Igc3BlY2lmaWMgbWFwcGlu
Z3MgKHNldF9tYXApCj4gPiBhcmUgcmVxdWlyZWQgb3Igbm90LiBBbmQgaW4gdGhlIGltcGxlbWVu
dGF0aW9uIG9mIHZob3N0X3ZkcGEsIGlmCj4gPiBwbGF0Zm9ybSBJT01NVSBpcyB1c2VkLCB0aGUg
bWFwcGluZ3MgYXJlIGRlY291cGxlZCBmcm9tIHRoZSByZXNldC4gU28KPiA+IGlmIHRoZSBRZW11
IHdvcmtzIHdpdGggcGFyZW50cyB3aXRoIHBsYXRmb3JtIElPTU1VIGl0IG1lYW5zIFFlbXUgY2Fu
Cj4gPiB3b3JrIGlmIHdlIGp1c3QgZGVjb3VwbGUgdmVuZG9yIHNwZWNpZmljIG1hcHBpbmdzIGZy
b20gdGhlIHBhcmVudHMKPiA+IHRoYXQgdXNlcyBzZXRfbWFwLgo+IEkgd2FzIGF3YXJlIG9mIHRo
aXMsIGFuZCBpZiB5b3UgbWF5IG5vdGljZSBJIGRvbid0IGV2ZW4gb2ZmZXIgYSB3YXkKPiBiYWNr
d2FyZCB0byByZXRhaW4vZW11bGF0ZSB0aGUgZmxhd2VkIHZob3N0LWlvdGxiIHJlc2V0IGJlaGF2
aW9yIGZvcgo+IG9sZGVyIHVzZXJzcGFjZSAtIEkgY29uc2lkZXIgaXQgbW9yZSBvZiBhIGJ1ZyBp
biAuc2V0X21hcCBkcml2ZXIKPiBpbXBsZW1lbnRhdGlvbiBvZiBpdHMgb3duIHJhdGhlciB0aGFu
IHdoYXQgdGhlIHZob3N0LXZkcGEgaW90bGIKPiBhYnN0cmFjdGlvbiB3aXNoZXMgdG8gZXhwb3Nl
IHRvIHVzZXJzcGFjZSBpbiB0aGUgZmlyc3QgcGxhY2UuCgpUaGF0J3MgbXkgdW5kZXJzdGFuZGlu
ZyBhcyB3ZWxsLgoKPgo+IElmIHlvdSBldmVyIGxvb2sgaW50byBRRU1VJ3Mgdmhvc3RfdmRwYV9y
ZXNldF9zdGF0dXMoKSBmdW5jdGlvbiwgeW91IG1heQo+IHNlZSBtZW1vcnlfbGlzdGVuZXJfdW5y
ZWdpc3RlcigpIHdpbGwgYmUgY2FsbGVkIHRvIGV2aWN0IGFsbCBvZiB0aGUKPiBleGlzdGluZyBp
b3RsYiBtYXBwaW5ncyByaWdodCBhZnRlciB2aG9zdF92ZHBhX3Jlc2V0X2RldmljZSgpIGFjcm9z
cwo+IGRldmljZSByZXNldCwgYW5kIGxhdGVyIG9uIGF0IHZob3N0X3ZkcGFfZGV2X3N0YXJ0KCks
Cj4gbWVtb3J5X2xpc3RlbmVyX3JlZ2lzdGVyKCkgd2lsbCBzZXQgdXAgYWxsIGlvdGxiIG1hcHBp
bmdzIGFnYWluLiBJbiBhbgo+IGlkZWFsIHdvcmxkIHdpdGhvdXQgdGhpcyBvbi1jaGlwIGlvbW11
IGRlZmljaWVuY3kgUUVNVSBzaG91bGQgbm90IGhhdmUKPiB0byBiZWhhdmUgdGhpcyB3YXkgLSB0
aGlzIGlzIHdoYXQgSSBtZW50aW9uZWQgZWFybGllciB0aGF0IHVzZXJzcGFjZSBoYWQKPiBhbHJl
YWR5IG5vdGljZWQgdGhlIGRpc2NyZXBhbmN5IGFuZCBpdCBoYXMgdG8gInByb2FjdGl2ZWx5IHRl
YXIgZG93biBhbmQKPiBzZXQgdXAgaW90bGIgbWFwcGluZyBhcm91bmQgdmRwYSBkZXZpY2UgcmVz
ZXQiLiBBcHBhcmVudGx5IGZyb20KPiBmdW5jdGlvbmFsaXR5IHBlcnNwZWN0aXZlIHRoaXMgdHJp
Y2sgd29ya3MgY29tcGxldGVseSBmaW5lIHdpdGggcGxhdGZvcm0KPiBJT01NVSwgaG93ZXZlciwg
aXQncyBzdWItb3B0aW1hbCBpbiB0aGUgcGVyZm9ybWFuY2UgcGVyc3BlY3RpdmUuCgpSaWdodC4K
Cj4KPiBXZSBjYW4ndCBzaW1wbHkgZml4IFFFTVUgYnkgbW92aW5nIHRoaXMgbWVtb3J5X2xpc3Rl
bmVyX3VucmVnaXN0ZXIoKQo+IGNhbGwgb3V0IG9mIHRoZSByZXNldCBwYXRoIHVuY29uZGl0aW9u
YWxseSwgYXMgd2UgZG9uJ3Qgd2FudCB0byBicmVhawo+IHRoZSBhbHJlYWR5LWZ1bmN0aW9uaW5n
IG9sZGVyIGtlcm5lbCBldmVuIHRob3VnaCBpdCdzIHN1Ym9wdGltYWwgaW4KPiBwZXJmb3JtYW5j
ZS4KCkknbSBub3Qgc3VyZSBob3cgdGhpbmdzIGNhbiBiZSBicm9rZW4gaW4gdGhpcyBjYXNlPyBP
ciB3aHkgaXQgaXMKc3BlY2lmaWMgdG8gcGFyZW50IHdpdGggc2V0X21hcC4KCj4gSW5zdGVhZCwg
dG8ga2VlcCBuZXcgUUVNVSBjb250aW51aW5nIHRvIHdvcmsgb24gdG9wIG9mIHRoZQo+IGV4aXN0
aW5nIG9yIG9sZGVyIGtlcm5lbHMsIFFFTVUgaGFzIHRvIGNoZWNrIHRoaXMgSU9UTEJfUEVSU0lT
VCBmZWF0dXJlCj4gZmxhZyB0byBkZWNpZGUgd2hldGhlciBpdCBpcyBzYWZlIG5vdCB0byBib3Ro
ZXIgZmx1c2hpbmcgYW5kIHNldHRpbmcgdXAKPiBpb3RsYiBhY3Jvc3MgcmVzZXQuIEZvciB0aGUg
cGxhdGZvcm0gSU9NTVUgY2FzZSwgdmRwYSBwYXJlbnQgZHJpdmVyCj4gd29uJ3QgaW1wbGVtZW50
IGVpdGhlciB0aGUgLnNldF9tYXAgb3IgLmRtYV9tYXAgb3AsIHNvIGl0IHNob3VsZCBiZQo+IGNv
dmVyZWQgaW4gdGhlIHZob3N0X3ZkcGFfaGFzX3BlcnNpc3RlbnRfbWFwKCkgY2hlY2sgSSBzdXBw
b3NlLgoKSnVzdCB0byBtYWtlIHN1cmUgd2UgYXJlIGF0IHRoZSBzYW1lIHBhZ2UuCgpGcm9tIHRo
ZSB1c2Vyc3BhY2UgcG9pbnQgb2YgdmlldywgdGhlIElPVExCIHBlcnNpc3RzIGFuZCB2aG9zdC12
RFBBCmRvZXNuJ3QgcmVzZXQgdGhlIElPVExCIGR1cmluZyB2RFBBIHJlc2V0LiBCdXQgd2UgaGF2
ZSBhcmUgdHdvIGxldmVscwpvZiB0aGUgY291cGxpbmcgaW4gb3RoZXIgcGxhY2VzOgoKMSkgUWVt
dSBsZXZlbDogbWVtb3J5IGxpc3RlbmVyIGlzIGNvdXBsZWQgd2l0aCBEUklWRVJfT0svcmVzZXQK
MikgdkRQQSBwYXJlbnQgbGV2ZWw6IG1seDUgYnVpbGQvZGVzdHJveSBNUiBkdXJpbmcgRFJJVkVS
X09LL3Jlc2V0CgpJZiBJIHVuZGVyc3RhbmQgeW91IGNvcnJlY3RseSwgc2luY2Ugd2UndmUgY291
cGxlZCBpbiAxKSwgUWVtdSBjYW4ndApiZSBhd2FyZSBvZiB3aGV0aGVyIHRoZSBtYXBwaW5nIGlz
IGNvdXBsZWQgd2l0aCByZXNldCBvciBub3Q/IElmIHdlCnNpbXBseSBkZWNvdXBsZSBpbiAxKSwg
bWVtb3J5IG1hcHBpZ25zIG1pZ2h0IGJlIGxvc3QgZHVyaW5nIHZEUEEgcnNldC4KClRoYW5rcwoK
Pgo+Cj4gVGhhbmtzLAo+IC1TaXdlaQo+ID4gVGhhbmtzCj4gPgo+ID4+IFJlZ2FyZHMsCj4gPj4g
LVNpd2VpCj4gPj4+IFRoYW5rcwo+ID4+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

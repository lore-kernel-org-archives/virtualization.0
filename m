Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC54CA0EC3
	for <virtualization@archiver.kernel.org>; Tue, 12 Sep 2023 07:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C70681F9A;
	Tue, 12 Sep 2023 07:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C70681F9A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2QRl0gO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y-me13dAuwyG; Tue, 12 Sep 2023 07:01:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0137881E3C;
	Tue, 12 Sep 2023 07:01:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0137881E3C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAE11C0071;
	Tue, 12 Sep 2023 07:01:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F257C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:01:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9797401C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9797401C9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2QRl0gO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yjN4xPrvcJuW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:01:53 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C8847400E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 07:01:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8847400E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694502111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gt+EfdOAxwVeGddnh/FAjAdsCbh0z70SYuLfX3bRIAA=;
 b=K2QRl0gOpaHbKOsXla2j0wsAUT3kYPjyNWzO0D9CefYKVWkXhXPFzRKO/xM4TqDBDjcVk9
 1MOP3VaFPtLS8G+xpjLIsfrdWgIlN321eBu+br7cRcO2c+h/LKY2d5WEx5Zbu5aB8IpF7p
 mqhSe7Vuj0Z8K/Yb6OyFpmlvsdU3Exc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-H0bTSld4PNuqkqBi-4EJuA-1; Tue, 12 Sep 2023 03:01:50 -0400
X-MC-Unique: H0bTSld4PNuqkqBi-4EJuA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-500b575b32dso4040231e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Sep 2023 00:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502108; x=1695106908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gt+EfdOAxwVeGddnh/FAjAdsCbh0z70SYuLfX3bRIAA=;
 b=SICR/sbG1ftqUBpeVk+/3rLbkm0PegYr0KNgUpajEqnzsH+cYCBifPL/tfLnB1HF3y
 6L1D5aj1/uHTwaPjRsnO7DvygiFR+oJoHZz8kNCo4JbQEItPXWH5FS6OR6llHeQnuTfx
 DpfyelJpeqxla5g2UCPbY1JVyLGFlP7F3qxnxdsUl7Cao5CTogXBnDq7BqySCuhfqJZR
 jD+IfplCc7iT5J6XGPYD+BNhwFALkV14/TPOd42UzLnp2jo1uR3/kwDTeyivaMo6jK0y
 bbKMZ3wngVuT7zIdCrKzZ9Rqs5aIyV6fZwUBzRtr3DRTQXJTIcdC1yIo+s9oMG60140u
 vVzg==
X-Gm-Message-State: AOJu0YySHWJqM7W+HGxVc4Yn5IZw01xSN+v9E1OzqGpgo0OGFMVFoUT9
 X1EdzDXpl7NIjuVda+8aNuYzRucodqaihuVwA7nsshI0wtn46IN5GN8Cc9Jk3mzixugtRfT1sIT
 wtE7YUCDoNWkd6+2728+tLx1BkIlNR3PClC0v4iwKk4BoPDywPAcAJ2drFw==
X-Received: by 2002:a05:6512:3e08:b0:4f8:586a:d6ca with SMTP id
 i8-20020a0565123e0800b004f8586ad6camr582993lfv.9.1694502108526; 
 Tue, 12 Sep 2023 00:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhORzKMyP5xa+5GODUKyNt9u1DMdczLw+FCBPFU5QUdMxlSS2OZ/l+nwIBHnx4nYhK5XP+MM8t25ly6BstQWY=
X-Received: by 2002:a05:6512:3e08:b0:4f8:586a:d6ca with SMTP id
 i8-20020a0565123e0800b004f8586ad6camr582985lfv.9.1694502108202; Tue, 12 Sep
 2023 00:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <1694267039-718-1-git-send-email-si-wei.liu@oracle.com>
 <1694267039-718-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEu5ey0c-541=ECv7pW7Uj68Pv1Z7TG7Cci1tHfyA4bRqg@mail.gmail.com>
 <edb0415d-efa3-5d5b-bffd-b3ccfc64faa6@oracle.com>
In-Reply-To: <edb0415d-efa3-5d5b-bffd-b3ccfc64faa6@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Sep 2023 15:01:37 +0800
Message-ID: <CACGkMEuKpzO0kTLZgir-JrDVpZFSE75Jm6zhUyrPLNNEzP0sgw@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 xuanzhuo@linux.alibaba.com, mst@redhat.com
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgODoyOOKAr0FNIFNpLVdlaSBMaXUgPHNpLXdlaS5saXVA
b3JhY2xlLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gOS8xMC8yMDIzIDg6NTIgUE0sIEphc29uIFdh
bmcgd3JvdGU6Cj4gPiBPbiBTYXQsIFNlcCA5LCAyMDIzIGF0IDk6NDbigK9QTSBTaS1XZWkgTGl1
IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+IHdyb3RlOgo+ID4+IFVzZXJzcGFjZSBuZWVkcyB0aGlz
IGZlYXR1cmUgZmxhZyB0byBkaXN0aW5ndWlzaCBpZiB2aG9zdC12ZHBhCj4gPj4gaW90bGIgaW4g
dGhlIGtlcm5lbCBzdXBwb3J0cyBwZXJzaXN0ZW50IElPVExCIG1hcHBpbmcgYWNyb3NzCj4gPj4g
ZGV2aWNlIHJlc2V0Lgo+ID4gQXMgZGlzY3Vzc2VkLCB0aGUgSU9UTEIgcGVyc2lzdHMgZm9yIGRl
dmljZXMgd2l0aCBwbGF0Zm9ybSBJT01NVSBhdAo+ID4gbGVhc3QuIFlvdSd2ZSBtZW50aW9uZWQg
dGhhdCB0aGlzIGJlaGF2aW91ciBpcyBjb3ZlcmVkIGJ5IFFlbXUgc2luY2UKPiA+IGl0IHJlc2V0
IElPVExCIG9uIHJlc2V0LiBJIHdvbmRlciB3aGF0IGhhcHBlbnMgaWYgd2Ugc2ltcGx5IGRlY291
cGxlCj4gPiB0aGUgSU9UTEIgcmVzZXQgZnJvbSB2RFBBIHJlc2V0IGluIFFlbXUuIENvdWxkIHdl
IG1lZXQgYnVncyB0aGVyZT8KPiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQuIFNpbXBsZSBkZWNvdXBs
ZSBtZWFuaW5nIHRvIHJlbW92ZSBtZW1vcnlfbGlzdGVuZXIKPiByZWdpc3RyYXRpb24vdW5yZWdp
c3RyYXRpb24gY2FsbHMgKnVuY29uZGl0aW9uYWxseSogZnJvbSB0aGUgdkRQQSBkZXYKPiBzdGFy
dC9zdG9wIHBhdGggaW4gUUVNVSwgb3IgbWFrZSBpdCBjb25kaXRpb25hbCBhcm91bmQgdGhlIGV4
aXN0ZW5jZSBvZgo+IFBFUlNJU1RfSU9UTEI/CgpJZiBteSBtZW1vcnkgaXMgY29ycmVjdCwgY3Vy
cmVudGx5IHRoZSBsaXN0ZW5lcnMgd2VyZQpyZWdpc3RlcmVkL3VucmVnaXN0ZXJlZCBkdXJpbmcg
c3RhcnQvc3RvcC4gSSBtZWFuIHdoYXQgaWYgd2UKcmVnaXN0ZXIvdW5yZWdpc3RlciBkdXJpbmcg
aW5pdC9mcmVlPwoKPiBJZiB1bmNvbmRpdGlvbmFsLCBpdCBicmVha3Mgb2xkZXIgaG9zdCBrZXJu
ZWwsIGFzIHRoZQo+IG9sZGVyIGtlcm5lbCBzdGlsbCBzaWxlbnRseSBkcm9wcyBhbGwgbWFwcGlu
ZyBhY3Jvc3MgdkRQQSByZXNldCAoVk0KPiByZWJvb3QpLAoKT2ssIHJpZ2h0LgoKPiBlbmRpbmcg
dXAgd2l0aCBuZXR3b3JrIGxvc3MgYWZ0ZXJ3YXJkczsgaWYgbWFrZSB0aGUgUUVNVSBjaGFuZ2UK
PiBjb25kaXRpb25hbCBvbiBQRVJTSVNUX0lPVExCIHdpdGhvdXQgdGhlIC5yZXNldF9tYXAgQVBJ
LCBpdCBjYW4ndCBjb3Zlcgo+IHRoZSB2aXJ0aW8tdmRwYSAxOjEgaWRlbnRpdHkgbWFwcGluZyBj
YXNlLgoKT2ssIEkgc2VlLiBMZXQncyBhZGQgdGhlIGFib3ZlIGFuZCBleHBsYWluIHdoeSBpdCBj
YW4ndCBjb3ZlciB0aGUgMToxCm1hcHBpbmcgc29tZXdoZXJlIChwcm9iYWJseSB0aGUgY29tbWl0
IGxvZykgaW4gdGhlIG5leHQgdmVyc2lvbi4KClNvIEkgdGhpbmsgd2UgY2FuIHByb2JhYmx5IGlu
dHJvZHVjZSByZXNldF9tYXAoKSBidXQgbm90IHNheSBpdCdzIGZvcgpvbi1jaGlwIElPTU1VLiBX
ZSBjYW4gcHJvYmFibHkgc2F5LCBpdCdzIGZvciByZXNldHRpbmcgdGhlIHZlbmRvcgpzcGVjaWZp
YyBtYXBwaW5nIGludG8gaW5pdGlhbGl6YXRpb24gc3RhdGU/Cgo+Cj4gPiBCdHcsIGlzIHRoZXJl
IGEgUWVtdSBwYXRjaCBmb3IgcmVmZXJlbmNlIGZvciB0aGlzIG5ldyBmZWF0dXJlPwo+IFRoZXJl
J3MgYSBXSVAgdmVyc2lvbiwgbm90IHJlYWR5IHlldCBmb3IgcmV2aWV3Ogo+Cj4gaHR0cHM6Ly9n
aXRodWIuY29tL3Npd2xpdS1rZXJuZWwvcWVtdQo+IGJyYW5jaDogdmRwYS1zdnEtYXNpZC1wb2MK
Pgo+IFdpbGwgbmVlZCB0byBjbGVhbiB1cCBjb2RlIGFuZCBzcGxpdCB0byBzbWFsbGVyIHBhdGNo
ZXMgYmVmb3JlIEkgY2FuCj4gcG9zdCBpdCwgaWYgdGhlIGtlcm5lbCBwYXJ0IGNhbiBiZSBzZXR0
bGVkLgoKT2suCgpUaGFua3MKCj4KPiBUaGFua3MsCj4gLVNpd2VpCj4KPiA+Cj4gPiBUaGFua3MK
PiA+Cj4gPj4gVGhlcmUgYXJlIHR3byBjYXNlcyB0aGF0IGJhY2tlbmQgbWF5IGNsYWltCj4gPj4g
dGhpcyBmZWF0dXJlIGJpdCBvbjoKPiA+Pgo+ID4+IC0gcGFyZW50IGRldmljZSB0aGF0IGhhcyB0
byB3b3JrIHdpdGggcGxhdGZvcm0gSU9NTVUKPiA+PiAtIHBhcmVudCBkZXZpY2Ugd2l0aCBvbi1j
aGlwIElPTU1VIHRoYXQgaGFzIHRoZSBleHBlY3RlZAo+ID4+ICAgIC5yZXNldF9tYXAgc3VwcG9y
dCBpbiBkcml2ZXIKPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBMaXUgPHNpLXdlaS5s
aXVAb3JhY2xlLmNvbT4KPiA+PiAtLS0KPiA+PiBSRkMgdjIgLT4gdjM6Cj4gPj4gICAgLSBmaXgg
bWlzc2luZyByZXR1cm4gZHVlIHRvIG1lcmdlIGVycm9yCj4gPj4KPiA+PiAtLS0KPiA+PiAgIGRy
aXZlcnMvdmhvc3QvdmRwYS5jICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrKysrLQo+ID4+
ICAgaW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggfCAgMiArKwo+ID4+ICAgMiBmaWxl
cyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPj4KPiA+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ID4+
IGluZGV4IDcxZmJkNTU5Li5iNDA0NTA0IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4gPj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+PiBAQCAtNDE0LDYgKzQx
NCwxNCBAQCBzdGF0aWMgYm9vbCB2aG9zdF92ZHBhX2hhc19kZXNjX2dyb3VwKGNvbnN0IHN0cnVj
dCB2aG9zdF92ZHBhICp2KQo+ID4+ICAgICAgICAgIHJldHVybiBvcHMtPmdldF92cV9kZXNjX2dy
b3VwOwo+ID4+ICAgfQo+ID4+Cj4gPj4gK3N0YXRpYyBib29sIHZob3N0X3ZkcGFfaGFzX3BlcnNp
c3RlbnRfbWFwKGNvbnN0IHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+ID4+ICt7Cj4gPj4gKyAgICAg
ICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+ID4+ICsgICAgICAgY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ID4+ICsKPiA+PiAr
ICAgICAgIHJldHVybiAoIW9wcy0+c2V0X21hcCAmJiAhb3BzLT5kbWFfbWFwKSB8fCBvcHMtPnJl
c2V0X21hcDsKPiA+PiArfQo+ID4+ICsKPiA+PiAgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0
X2ZlYXR1cmVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgX191c2VyICpmZWF0dXJlcCkKPiA+
PiAgIHsKPiA+PiAgICAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+
ID4+IEBAIC03MTYsNyArNzI0LDggQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9p
b2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gPj4gICAgICAgICAgICAgICAgICBpZiAoZmVhdHVy
ZXMgJiB+KFZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUyB8Cj4gPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0RFU0NfQVNJRCkgfAo+
ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCSVRfVUxMKFZIT1NUX0JBQ0tF
TkRfRl9TVVNQRU5EKSB8Cj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQklU
X1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSkpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfUkVTVU1FKSB8Cj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfSU9UTEJf
UEVSU0lTVCkpKQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVPUE5PVFNV
UFA7Cj4gPj4gICAgICAgICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9C
QUNLRU5EX0ZfU1VTUEVORCkpICYmCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICF2aG9zdF92
ZHBhX2Nhbl9zdXNwZW5kKHYpKQo+ID4+IEBAIC03MzAsNiArNzM5LDkgQEAgc3RhdGljIGxvbmcg
dmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gPj4gICAgICAg
ICAgICAgICAgICBpZiAoKGZlYXR1cmVzICYgQklUX1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19B
U0lEKSkgJiYKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgIXZob3N0X3ZkcGFfaGFzX2Rlc2Nf
Z3JvdXAodikpCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQ
UDsKPiA+PiArICAgICAgICAgICAgICAgaWYgKChmZWF0dXJlcyAmIEJJVF9VTEwoVkhPU1RfQkFD
S0VORF9GX0lPVExCX1BFUlNJU1QpKSAmJgo+ID4+ICsgICAgICAgICAgICAgICAgICAgICF2aG9z
dF92ZHBhX2hhc19wZXJzaXN0ZW50X21hcCh2KSkKPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVPUE5PVFNVUFA7Cj4gPj4gICAgICAgICAgICAgICAgICB2aG9zdF9zZXRfYmFj
a2VuZF9mZWF0dXJlcygmdi0+dmRldiwgZmVhdHVyZXMpOwo+ID4+ICAgICAgICAgICAgICAgICAg
cmV0dXJuIDA7Cj4gPj4gICAgICAgICAgfQo+ID4+IEBAIC03ODUsNiArNzk3LDggQEAgc3RhdGlj
IGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VO
RF9GX1JFU1VNRSk7Cj4gPj4gICAgICAgICAgICAgICAgICBpZiAodmhvc3RfdmRwYV9oYXNfZGVz
Y19ncm91cCh2KSkKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZmVhdHVyZXMgfD0gQklU
X1VMTChWSE9TVF9CQUNLRU5EX0ZfREVTQ19BU0lEKTsKPiA+PiArICAgICAgICAgICAgICAgaWYg
KHZob3N0X3ZkcGFfaGFzX3BlcnNpc3RlbnRfbWFwKHYpKQo+ID4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGZlYXR1cmVzIHw9IEJJVF9VTEwoVkhPU1RfQkFDS0VORF9GX0lPVExCX1BFUlNJU1Qp
Owo+ID4+ICAgICAgICAgICAgICAgICAgaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZlYXR1
cmVzLCBzaXplb2YoZmVhdHVyZXMpKSkKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgciA9
IC1FRkFVTFQ7Cj4gPj4gICAgICAgICAgICAgICAgICBicmVhazsKPiA+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhv
c3RfdHlwZXMuaAo+ID4+IGluZGV4IDZhY2M2MDQuLjBmZGI2ZjAgMTAwNjQ0Cj4gPj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKPiA+PiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdmhvc3RfdHlwZXMuaAo+ID4+IEBAIC0xODYsNSArMTg2LDcgQEAgc3RydWN0IHZob3N0
X3ZkcGFfaW92YV9yYW5nZSB7Cj4gPj4gICAgKiBidWZmZXJzIG1heSByZXNpZGUuIFJlcXVpcmVz
IFZIT1NUX0JBQ0tFTkRfRl9JT1RMQl9BU0lELgo+ID4+ICAgICovCj4gPj4gICAjZGVmaW5lIFZI
T1NUX0JBQ0tFTkRfRl9ERVNDX0FTSUQgICAgMHg2Cj4gPj4gKy8qIElPVExCIGRvbid0IGZsdXNo
IG1lbW9yeSBtYXBwaW5nIGFjcm9zcyBkZXZpY2UgcmVzZXQgKi8KPiA+PiArI2RlZmluZSBWSE9T
VF9CQUNLRU5EX0ZfSU9UTEJfUEVSU0lTVCAgMHg3Cj4gPj4KPiA+PiAgICNlbmRpZgo+ID4+IC0t
Cj4gPj4gMS44LjMuMQo+ID4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

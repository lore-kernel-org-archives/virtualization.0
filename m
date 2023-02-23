Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFB3C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 23 Feb 2023 02:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EB9C460B91;
	Thu, 23 Feb 2023 02:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB9C460B91
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eBBYJpWF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PD2bx1p7yCdL; Thu, 23 Feb 2023 02:38:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 68CAA605D8;
	Thu, 23 Feb 2023 02:38:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68CAA605D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43A6EC0033;
	Thu, 23 Feb 2023 02:38:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A398C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EC7F40143
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:38:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EC7F40143
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eBBYJpWF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dcKTiTF67OL1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69D99400D6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69D99400D6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Feb 2023 02:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677119919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ma7/z8WNX1RDXHaIHyV4UxtdHg2TDktAwvW+oBEdYG0=;
 b=eBBYJpWF6H3PmkOiG0f0JpccmwMDDAz8Og9IfJ+kzJcs4e6c4R/xn7wPdZ+O37HHsVWgHo
 1D8wDtqm3u4VipC5abin+0GGNFWXgedJLGaHp8bhIpJeVUHfjDfATscKBYhQRb7wtH5u+X
 5tLslwDSkbCUpGt4BvxSxwyAmRdjxoE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-qU6-9ByCMLuSaDsjxywMOg-1; Wed, 22 Feb 2023 21:38:37 -0500
X-MC-Unique: qU6-9ByCMLuSaDsjxywMOg-1
Received: by mail-pl1-f200.google.com with SMTP id
 t18-20020a170902e85200b0019c91fd0967so3527248plg.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 18:38:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ma7/z8WNX1RDXHaIHyV4UxtdHg2TDktAwvW+oBEdYG0=;
 b=Uktvecvr26Obrk/Clic4hnYDkHiHujqFDuRfryw68v9avTL9KmQzYcpqlpEQtTXP0B
 4ErcnIi91NaWF5t3GNwjGN8ZSCICQq9yS7fakxocYoYJ6swNL225MPdyZLJihN+l5o/M
 ys7Lz2iQ9def2Dmt64f01zRoox4uJDEQecINpvlML+DXYSWOGrGCRzeq/IZs33CWMqrb
 1eei8ScCFj2BEXiaCZGsha/XjVPHUh7uDiZA3UrNsvDXFJS/83JTLmSUYOcKBZ55aGP8
 WFZWxtGqerf07VCYjhedUZ9tN2MJOF5PH3Z2zNHqmVKDPrgR5JCAXm86UJF2BQvLpsIF
 ud8A==
X-Gm-Message-State: AO0yUKVqM24bSlLyk6Qb12TT6iOw4/1bop/rsf7NSh15QVdNSiq2yhDy
 PjpYphEpe0WITSG1GxuZU2t1ifACj0LKbHq0921xWB+grLXzqClRuf68z1aMRo1+wAr9oD+XCVA
 tMn4jCl6+yvZt2CwVEsUB7SFZsFlrx0a7JaTkb85QFg==
X-Received: by 2002:a17:90b:4d0d:b0:237:39b1:7cb1 with SMTP id
 mw13-20020a17090b4d0d00b0023739b17cb1mr5553322pjb.19.1677119916627; 
 Wed, 22 Feb 2023 18:38:36 -0800 (PST)
X-Google-Smtp-Source: AK7set8A3Ap4rPUmFf9SKVabNxcAIPB0FfhoQXmkuFsFqQA/M31SHHFeOwKXaPxz01ezpX7ik2VoBg==
X-Received: by 2002:a17:90b:4d0d:b0:237:39b1:7cb1 with SMTP id
 mw13-20020a17090b4d0d00b0023739b17cb1mr5553293pjb.19.1677119916297; 
 Wed, 22 Feb 2023 18:38:36 -0800 (PST)
Received: from [10.72.13.176] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a17090abd8a00b0022bb3ee9b68sm4776210pjr.13.2023.02.22.18.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Feb 2023 18:38:35 -0800 (PST)
Message-ID: <81762a3b-b01f-2c3a-be63-531ac5b6976c@redhat.com>
Date: Thu, 23 Feb 2023 10:38:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 11/13] vdpa: block migration if dev does not have
 _F_SUSPEND
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20230208094253.702672-1-eperezma@redhat.com>
 <20230208094253.702672-12-eperezma@redhat.com>
 <c8d6ecc3-87f6-986e-e78d-003000e8a51e@redhat.com>
 <CAJaqyWdhK7QEHECP7qJP9tPA69e8uTuJtqLPNq_mUUhRDG_2Aw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWdhK7QEHECP7qJP9tPA69e8uTuJtqLPNq_mUUhRDG_2Aw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Lei Yang <leiyang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 longpeng2@huawei.com, Shannon Nelson <snelson@pensando.io>,
 Liuxiangdong <liuxiangdong5@huawei.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIzLzIvMjIgMjI6MjUsIEV1Z2VuaW8gUGVyZXogTWFydGluIOWGmemBkzoKPiBPbiBX
ZWQsIEZlYiAyMiwgMjAyMyBhdCA1OjA1IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgo+Pgo+PiDlnKggMjAyMy8yLzggMTc6NDIsIEV1Z2VuaW8gUMOpcmV6IOWGmemB
kzoKPj4+IE5leHQgcGF0Y2hlcyBlbmFibGUgZGV2aWNlcyB0byBiZSBtaWdyYXRlZCBldmVuIGlm
IHZkcGEgbmV0ZGV2IGhhcyBub3QKPj4+IGJlZW4gc3RhcnRlZCB3aXRoIHgtc3ZxLiBIb3dldmVy
LCBub3QgYWxsIGRldmljZXMgYXJlIG1pZ3JhdGFibGUsIHNvIHdlCj4+PiBuZWVkIHRvIGJsb2Nr
IG1pZ3JhdGlvbiBpZiB3ZSBkZXRlY3QgdGhhdC4KPj4+Cj4+PiBCbG9jayB2aG9zdC12ZHBhIGRl
dmljZSBtaWdyYXRpb24gaWYgaXQgZG9lcyBub3Qgb2ZmZXIgX0ZfU1VTUEVORCBhbmQgaXQKPj4+
IGhhcyBub3QgYmVlbiBzdGFydGVkIHdpdGggeC1zdnEuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTog
RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAgIGh3L3Zp
cnRpby92aG9zdC12ZHBhLmMgfCAyMSArKysrKysrKysrKysrKysrKysrKysKPj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRp
by92aG9zdC12ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+PiBpbmRleCA4NGE2Yjk2
OTBiLi45ZDMwY2Y5YjNjIDEwMDY0NAo+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+
Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4gQEAgLTQ0Miw2ICs0NDIsMjcgQEAg
c3RhdGljIGludCB2aG9zdF92ZHBhX2luaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LCB2b2lkICpv
cGFxdWUsIEVycm9yICoqZXJycCkKPj4+ICAgICAgICAgICAgcmV0dXJuIDA7Cj4+PiAgICAgICAg
fQo+Pj4KPj4+ICsgICAgLyoKPj4+ICsgICAgICogSWYgZGV2LT5zaGFkb3dfdnFzX2VuYWJsZWQg
YXQgaW5pdGlhbGl6YXRpb24gdGhhdCBtZWFucyB0aGUgZGV2aWNlIGhhcwo+Pj4gKyAgICAgKiBi
ZWVuIHN0YXJ0ZWQgd2l0aCB4LXN2cT1vbiwgc28gZG9uJ3QgYmxvY2sgbWlncmF0aW9uCj4+PiAr
ICAgICAqLwo+Pj4gKyAgICBpZiAoZGV2LT5taWdyYXRpb25fYmxvY2tlciA9PSBOVUxMICYmICF2
LT5zaGFkb3dfdnFzX2VuYWJsZWQpIHsKPj4+ICsgICAgICAgIHVpbnQ2NF90IGJhY2tlbmRfZmVh
dHVyZXM7Cj4+PiArCj4+PiArICAgICAgICAvKiBXZSBkb24ndCBoYXZlIGRldi0+YmFja2VuZF9m
ZWF0dXJlcyB5ZXQgKi8KPj4+ICsgICAgICAgIHJldCA9IHZob3N0X3ZkcGFfY2FsbChkZXYsIFZI
T1NUX0dFVF9CQUNLRU5EX0ZFQVRVUkVTLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZiYWNrZW5kX2ZlYXR1cmVzKTsKPj4+ICsgICAgICAgIGlmICh1bmxpa2VseShyZXQpKSB7
Cj4+PiArICAgICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LCAiQ291bGQgbm90
IGdldCBiYWNrZW5kIGZlYXR1cmVzIik7Cj4+PiArICAgICAgICAgICAgcmV0dXJuIHJldDsKPj4+
ICsgICAgICAgIH0KPj4+ICsKPj4+ICsgICAgICAgIGlmICghKGJhY2tlbmRfZmVhdHVyZXMgJiBC
SVRfVUxMKFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EKSkpIHsKPj4+ICsgICAgICAgICAgICBlcnJv
cl9zZXRnKCZkZXYtPm1pZ3JhdGlvbl9ibG9ja2VyLAo+Pj4gKyAgICAgICAgICAgICAgICAidmhv
c3QtdmRwYSBiYWNrZW5kIGxhY2tzIFZIT1NUX0JBQ0tFTkRfRl9TVVNQRU5EIGZlYXR1cmUuIik7
Cj4+PiArICAgICAgICB9Cj4+Cj4+IEkgd29uZGVyIHdoeSBub3QgbGV0IHRoZSBkZXZpY2UgdG8g
ZGVjaWRlPyBGb3IgbmV0d29ya2luZyBkZXZpY2UsIHdlIGNhbgo+PiBsaXZlIHdpdGhvdXQgc3Vz
cGVuZCBwcm9iYWJseS4KPj4KPiBSaWdodCwgYnV0IGhvdyBjYW4gd2Uga25vdyBpZiB0aGlzIGlz
IGEgbmV0IGRldmljZSBpbiBpbml0PyBJIGRvbid0Cj4gdGhpbmsgYSBzd2l0Y2ggKHZob3N0X3Zk
cGFfZ2V0X2RldmljZV9pZChkZXYpKSBpcyBlbGVnYW50LgoKCkkgbWVhbnQgdGhlIGNhbGxlciBv
ZiB2aG9zdF92ZHBhX2luaXQoKSB3aGljaCBpcyBuZXRfaW5pdF92aG9zdF92ZHBhKCkuCgpUaGFu
a3MKCgo+Cj4gSWYgdGhlIHBhcmVudCBkZXZpY2UgZG9lcyBub3QgbmVlZCB0byBiZSBzdXNwZW5k
ZWQgaSdkIGdvIHdpdGgKPiBleHBvc2luZyBhIHN1c3BlbmQgaW9jdGwgYnV0IGRvIG5vdGhpbmcg
aW4gdGhlIHBhcmVudCBkZXZpY2UuIEFmdGVyCj4gdGhhdCwgaXQgY291bGQgZXZlbiBjaG9vc2Ug
dG8gcmV0dXJuIGFuIGVycm9yIGZvciBHRVRfVlJJTkdfQkFTRS4KPgo+IElmIHdlIHdhbnQgdG8g
aW1wbGVtZW50IGl0IGFzIGEgZmFsbGJhY2sgaW4gcWVtdSwgSSdkIGdvIGZvcgo+IGltcGxlbWVu
dGluZyBpdCBvbiB0b3Agb2YgdGhpcyBzZXJpZXMuIFRoZXJlIGFyZSBhIGZldyBvcGVyYXRpb25z
IHdlCj4gY291bGQgbW92ZSB0byBhIGRldmljZS1raW5kIHNwZWNpZmljIG9wcy4KPgo+IFdvdWxk
IGl0IG1ha2Ugc2Vuc2UgdG8geW91Pwo+Cj4gVGhhbmtzIQo+Cj4KPj4gVGhhbmtzCj4+Cj4+Cj4+
PiArICAgIH0KPj4+ICsKPj4+ICAgICAgICAvKgo+Pj4gICAgICAgICAqIFNpbWlsYXIgdG8gVkZJ
Tywgd2UgZW5kIHVwIHBpbm5pbmcgYWxsIGd1ZXN0IG1lbW9yeSBhbmQgaGF2ZSB0bwo+Pj4gICAg
ICAgICAqIGRpc2FibGUgZGlzY2FyZGluZyBvZiBSQU0uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:50:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A8664D99
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A8664D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2F1728671C;
	Thu, 18 Feb 2021 05:50:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEuoF+O620If; Thu, 18 Feb 2021 05:50:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 281088649A;
	Thu, 18 Feb 2021 05:50:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F29B1C000E;
	Thu, 18 Feb 2021 05:50:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 005A3C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DC3CC86FA5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vopg4wZIcxf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:50:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7498787262
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613627409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1fy9S2r504yXagwrrD+x53jLzsYNs8ax8mmvB90Hdo=;
 b=N6coqrO93UAmqB8bi97QbUpSQHIoKuLKSFMIHhj/Ke4QArmEGnURf7bTLrYr5zVrSN/toK
 diTyBa2nsvENTWhc/w+gwFJrIYS3ZHC2YacGDYgxSAvwCeAzspVTloiMkU0bhDhzTGS/Jr
 1BQRtRuRo0vljLaOTlxZz96mhQ8/Gh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-I0FBjGjFNySTrBwKIyiRQA-1; Thu, 18 Feb 2021 00:50:07 -0500
X-MC-Unique: I0FBjGjFNySTrBwKIyiRQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DFFC107ACE8;
 Thu, 18 Feb 2021 05:50:06 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAD565D72F;
 Thu, 18 Feb 2021 05:50:00 +0000 (UTC)
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210209091916-mutt-send-email-mst@kernel.org>
 <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
 <20210210073404-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9d7e0477-9ccf-e516-9825-50523ac9d64a@redhat.com>
Date: Thu, 18 Feb 2021 13:49:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210073404-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: shahafs@mellanox.com, lulu@redhat.com, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8xMCDkuIvljYg4OjM1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBGZWIgMTAsIDIwMjEgYXQgMTI6NDQ6MDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAyMS8yLzkg5LiL5Y2IMTA6MjAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIE1vbiwgSmFuIDA0LCAyMDIxIGF0IDAyOjU1OjAwUE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
Pj4+PiAtLS0KPj4+PiAgICBkcml2ZXJzL3ZpcnRpby9LY29uZmlnICAgICAgICAgICAgICAgICB8
ICAxMCArLQo+Pj4+ICAgIGRyaXZlcnMvdmlydGlvL01ha2VmaWxlICAgICAgICAgICAgICAgIHwg
ICAxICsKPj4+PiAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oICAgICB8ICAy
NyArLQo+Pj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgICAgIHwgNjE3
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+PiAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX21vZGVybl9kZXYuYyB8IDU5OSArKysrKysrKysrKysrKysrKysrKysrKysKPj4+PiAgICBp
bmNsdWRlL2xpbnV4L3ZpcnRpb19wY2lfbW9kZXJuLmggICAgICB8IDExMSArKysrKwo+Pj4+ICAg
IDYgZmlsZXMgY2hhbmdlZCwgNzIxIGluc2VydGlvbnMoKyksIDY0NCBkZWxldGlvbnMoLSkKPj4+
PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5f
ZGV2LmMKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC92aXJ0aW9fcGNp
X21vZGVybi5oCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vS2NvbmZpZyBi
L2RyaXZlcnMvdmlydGlvL0tjb25maWcKPj4+PiBpbmRleCA3YjQxMTMwZDNmMzUuLjZiOWI4MWY0
YjhjMiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby9LY29uZmlnCj4+Pj4gKysrIGIv
ZHJpdmVycy92aXJ0aW8vS2NvbmZpZwo+Pj4+IEBAIC0xMiw2ICsxMiwxNCBAQCBjb25maWcgQVJD
SF9IQVNfUkVTVFJJQ1RFRF9WSVJUSU9fTUVNT1JZX0FDQ0VTUwo+Pj4+ICAgIAkgIFRoaXMgb3B0
aW9uIGlzIHNlbGVjdGVkIGlmIHRoZSBhcmNoaXRlY3R1cmUgbWF5IG5lZWQgdG8gZW5mb3JjZQo+
Pj4+ICAgIAkgIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STQo+Pj4+ICtjb25maWcgVklSVElPX1BD
SV9NT0RFUk4KPj4+PiArCXRyaXN0YXRlICJNb2Rlcm4gVmlydGlvIFBDSSBEZXZpY2UiCj4+Pj4g
KwlkZXBlbmRzIG9uIFBDSQo+Pj4+ICsJaGVscAo+Pj4+ICsJICBNb2Rlcm4gUENJIGRldmljZSBp
bXBsZW1lbnRhdGlvbi4gVGhpcyBtb2R1bGUgaW1wbGVtZW50cyB0aGUKPj4+PiArCSAgYmFzaWMg
cHJvYmUgYW5kIGNvbnRyb2wgZm9yIGRldmljZXMgd2hpY2ggYXJlIGJhc2VkIG9uIG1vZGVybgo+
Pj4+ICsJICBQQ0kgZGV2aWNlIHdpdGggcG9zc2libGUgdmVuZG9yIHNwZWNpZmljIGV4dGVuc2lv
bnMuCj4+Pj4gKwo+Pj4+ICAgIG1lbnVjb25maWcgVklSVElPX01FTlUKPj4+PiAgICAJYm9vbCAi
VmlydGlvIGRyaXZlcnMiCj4+Pj4gICAgCWRlZmF1bHQgeQo+Pj4+IEBAIC0yMCw3ICsyOCw3IEBA
IGlmIFZJUlRJT19NRU5VCj4+Pj4gICAgY29uZmlnIFZJUlRJT19QQ0kKPj4+PiAgICAJdHJpc3Rh
dGUgIlBDSSBkcml2ZXIgZm9yIHZpcnRpbyBkZXZpY2VzIgo+Pj4+IC0JZGVwZW5kcyBvbiBQQ0kK
Pj4+PiArCWRlcGVuZHMgb24gVklSVElPX1BDSV9NT0RFUk4KPj4+PiAgICAJc2VsZWN0IFZJUlRJ
Two+Pj4+ICAgIAloZWxwCj4+Pj4gICAgCSAgVGhpcyBkcml2ZXIgcHJvdmlkZXMgc3VwcG9ydCBm
b3IgdmlydGlvIGJhc2VkIHBhcmF2aXJ0dWFsIGRldmljZQo+Pj4gTG9va3MgbGlrZSBWSVJUSU9f
UENJX01PREVSTiBpcyBhY3R1YWxseSBqdXN0IGEgbGlicmFyeSB0aGF0Cj4+PiB2aXJ0aW8gcGNp
IHVzZXMuIElzIHRoYXQgcmlnaHQ/Cj4+Cj4+IFJpZ2h0Lgo+Pgo+Pgo+Pj4gSW4gdGhhdCBjYXNl
IGp1c3Qgc2VsZWN0IGl0Cj4+PiBhdXRvbWF0aWNhbGx5LCBsZXQncyBub3QgbWFrZSB1c2VycyBl
bmFibGUgaXQgbWFudWFsbHkuCj4+Cj4+IEkndmUgY29uc2lkZXJlZCB0byBkbyB0aGlzIGJ1dCB0
aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBtb2R1bGUgZGVwZW5kcyBvbiBQQ0kKPj4gc28gaXQgY2Fu
J3QgYmUgc2VsZWN0ZWQgSSB0aGluay4KPiBEcm9wIHRoZSBkZXBlbmRlbmN5LCBkb2N1bWVudCB0
aGF0IHdob2V2ZXIgc2VsZWN0cyBpdCBtdXN0IGRlcGVuZCBvbiBQQ0kuCgoKRmluZSB3aXRoIG1l
LiBXaWxsIHBvc3QgYSBwYXRjaC4KClRoYW5rcwoKCj4KPj4gVGhhbmtzCj4+Cj4+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

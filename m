Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A38C433E0
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:38:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C90D64E25
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C90D64E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CF68485E7C;
	Wed, 10 Feb 2021 04:38:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TsPmmU7oLdq9; Wed, 10 Feb 2021 04:38:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 457318367E;
	Wed, 10 Feb 2021 04:38:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26892C0174;
	Wed, 10 Feb 2021 04:38:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A033C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 403D3871E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:38:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3XiPsh56k8nA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:38:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7EFFA871B0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612931934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OTZsXH2tD0HeIgH/lI8h+bZrxEF7HhE4ZNU7vfxtAk=;
 b=Tf5KBnboQJ5qtvco2SMComO6P3SklBQ+Q240vxgDfAy3uzepRI0GD/BgEu5xuhXFmoX21R
 CagjaXtew6Ucmq1OHkBnvZaneI9q6TN6kmilG1ov/rQcGki0vTWeh3g3lsnKbkYXSnhsWk
 x7uxqMXc/aPpzn1k/kvLKnInqt6CX6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-f0srScS3Nb6YY6KHfMJKew-1; Tue, 09 Feb 2021 23:38:50 -0500
X-MC-Unique: f0srScS3Nb6YY6KHfMJKew-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B3C3100A8FC;
 Wed, 10 Feb 2021 04:38:48 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA6B460C4D;
 Wed, 10 Feb 2021 04:38:35 +0000 (UTC)
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
To: Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <CA+G9fYteUN=s5Mp+BhdMPZt96B3qDa+2HwudmWgEmmrDELLPdw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9cc9d649-e891-8bcc-e5f8-cec7c0d40077@redhat.com>
Date: Wed, 10 Feb 2021 12:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYteUN=s5Mp+BhdMPZt96B3qDa+2HwudmWgEmmrDELLPdw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: shahafs@mellanox.com, Arnd Bergmann <arnd@arndb.de>, lulu@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, virtualization@lists.linux-foundation.org,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Ck9uIDIwMjEvMi85IOS4i+WNiDY6MTUsIE5hcmVzaCBLYW1ib2p1IHdyb3RlOgo+IEhpIEphc29u
LAo+Cj4gT24gTW9uLCA0IEphbiAyMDIxIGF0IDEyOjI4LCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAg
ICAgICAgfCAgMTAgKy0KPj4gICBkcml2ZXJzL3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAgICAg
ICB8ICAgMSArCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCAgICAgfCAg
MjcgKy0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jICAgICB8IDYxNyAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9t
b2Rlcm5fZGV2LmMgfCA1OTkgKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAgaW5jbHVkZS9s
aW51eC92aXJ0aW9fcGNpX21vZGVybi5oICAgICAgfCAxMTEgKysrKysKPj4gICA2IGZpbGVzIGNo
YW5nZWQsIDcyMSBpbnNlcnRpb25zKCspLCA2NDQgZGVsZXRpb25zKC0pCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vS2NvbmZpZyBiL2RyaXZlcnMvdmlydGlvL0tjb25m
aWcKPj4gaW5kZXggN2I0MTEzMGQzZjM1Li42YjliODFmNGI4YzIgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL0tjb25maWcKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZwo+PiBA
QCAtMTIsNiArMTIsMTQgQEAgY29uZmlnIEFSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9S
WV9BQ0NFU1MKPj4gICAgICAgICAgICBUaGlzIG9wdGlvbiBpcyBzZWxlY3RlZCBpZiB0aGUgYXJj
aGl0ZWN0dXJlIG1heSBuZWVkIHRvIGVuZm9yY2UKPj4gICAgICAgICAgICBWSVJUSU9fRl9BQ0NF
U1NfUExBVEZPUk0KPj4KPj4gK2NvbmZpZyBWSVJUSU9fUENJX01PREVSTgo+PiArICAgICAgIHRy
aXN0YXRlICJNb2Rlcm4gVmlydGlvIFBDSSBEZXZpY2UiCj4+ICsgICAgICAgZGVwZW5kcyBvbiBQ
Q0kKPj4gKyAgICAgICBoZWxwCj4+ICsgICAgICAgICBNb2Rlcm4gUENJIGRldmljZSBpbXBsZW1l
bnRhdGlvbi4gVGhpcyBtb2R1bGUgaW1wbGVtZW50cyB0aGUKPj4gKyAgICAgICAgIGJhc2ljIHBy
b2JlIGFuZCBjb250cm9sIGZvciBkZXZpY2VzIHdoaWNoIGFyZSBiYXNlZCBvbiBtb2Rlcm4KPj4g
KyAgICAgICAgIFBDSSBkZXZpY2Ugd2l0aCBwb3NzaWJsZSB2ZW5kb3Igc3BlY2lmaWMgZXh0ZW5z
aW9ucy4KPj4gKwo+PiAgIG1lbnVjb25maWcgVklSVElPX01FTlUKPj4gICAgICAgICAgYm9vbCAi
VmlydGlvIGRyaXZlcnMiCj4+ICAgICAgICAgIGRlZmF1bHQgeQo+PiBAQCAtMjAsNyArMjgsNyBA
QCBpZiBWSVJUSU9fTUVOVQo+Pgo+PiAgIGNvbmZpZyBWSVJUSU9fUENJCj4+ICAgICAgICAgIHRy
aXN0YXRlICJQQ0kgZHJpdmVyIGZvciB2aXJ0aW8gZGV2aWNlcyIKPj4gLSAgICAgICBkZXBlbmRz
IG9uIFBDSQo+PiArICAgICAgIGRlcGVuZHMgb24gVklSVElPX1BDSV9NT0RFUk4KPiBXaGlsZSBi
b290aW5nIExpbnV4IG5leHQgdGFnIDIwMjEwMjA4IGtlcm5lbCBvbiBxZW11X2FybTY0IGFuZCBx
ZW11X2FybQo+IG1vdW50IHJvb3RmcyBmYWlsZWQuICBUaGUgcm9vdCBjYXVzZSBzZWVtcyB0byBi
ZSBkdWUgdG8gbWlzc2luZyBjb25maWdzCj4gQ09ORklHX1ZJUlRJT19QQ0k9eQo+IENPTkZJR19W
SVJUSU9fUENJX0xFR0FDWT15Cj4KPiBSZXBvcnRlZC1ieTogTmFyZXNoIEthbWJvanUgPG5hcmVz
aC5rYW1ib2p1QGxpbmFyby5vcmc+Cj4KPiBUaGVuIEkgaGF2ZSB0byBmb3JjZSB0byBlbmFibGUg
dGhpcyBNT0RFUk4gY29uZmlnCj4gQ09ORklHX1ZJUlRJT19QQ0lfTU9ERVJOPXkKPiBhbmQgd2hp
Y2ggZW5hYmxlZAo+IENPTkZJR19WSVJUSU9fUENJPXkKPiBDT05GSUdfVklSVElPX1BDSV9MRUdB
Q1k9eQo+Cj4gYW5kIHRoZSBxZW11X2FybTY0IGFuZCBxZW11X2FybSBib290IHBhc3MuCj4KPgo+
IE5ldyBidWlsZCBsaW5rLAo+IGh0dHBzOi8vYnVpbGRzLnR1eGJ1aWxkLmNvbS8xb0VzZTRFRnNv
UXIxRmtLQmZpTG1oTUNlN2ovCgoKVGhhbmtzIGZvciB0aGUgcmVwb3J0aW5nLgoKSSB3aWxsIHBv
c3QgYSBwYXRjaCB0byBmaXggdGhlIGRlZiBjb25maWcgdG8gZW5hYmxlIFZJUlRJT19QQ0lfTU9E
RVJOLgoKVGhhbmtzCgoKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

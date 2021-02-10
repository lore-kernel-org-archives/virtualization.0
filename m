Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E10C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:44:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA5364E25
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA5364E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1CD386788;
	Wed, 10 Feb 2021 04:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ilmq8yvMlDE; Wed, 10 Feb 2021 04:44:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2833F86730;
	Wed, 10 Feb 2021 04:44:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E842FC0174;
	Wed, 10 Feb 2021 04:44:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08911C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:44:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D55676F558
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:44:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtRmu4Qe5hK4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:44:16 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 173516F57E; Wed, 10 Feb 2021 04:44:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85AEB6F558
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612932253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34e+K3bIAHZ2pffqYYmkrbH3MIGZjfK+/+CoC5oZ8Qk=;
 b=fRBhF7Po+YdhyXBr+GvC4Amf5e12LyzUfqiDBTmQPyzgqtT+t6xa2F/TxgSELgCB973lXx
 8UEF1+PDELMi1SKoGRS1gPIL+DISUQFkxr0g1lZTON2YcunWi9DGsQjBZQDNbo0D4hxoxN
 Li67zwyxbLfZ4H0crvlcnP2QAZTSF84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-moaQdiKINfSIGndpbArQsg-1; Tue, 09 Feb 2021 23:44:11 -0500
X-MC-Unique: moaQdiKINfSIGndpbArQsg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA941005501;
 Wed, 10 Feb 2021 04:44:10 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9DD10013D7;
 Wed, 10 Feb 2021 04:44:04 +0000 (UTC)
Subject: Re: [PATCH V3 16/19] virtio-pci: introduce modern device module
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-17-jasowang@redhat.com>
 <20210209091916-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <721bf1dc-0b06-7f2a-9685-064a7c281366@redhat.com>
Date: Wed, 10 Feb 2021 12:44:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209091916-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjEvMi85IOS4i+WNiDEwOjIwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
TW9uLCBKYW4gMDQsIDIwMjEgYXQgMDI6NTU6MDBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4gLS0t
Cj4+ICAgZHJpdmVycy92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgMTAgKy0KPj4g
ICBkcml2ZXJzL3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgMSArCj4+ICAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uaCAgICAgfCAgMjcgKy0KPj4gICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jICAgICB8IDYxNyAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCA1OTkg
KysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9fcGNpX21v
ZGVybi5oICAgICAgfCAxMTEgKysrKysKPj4gICA2IGZpbGVzIGNoYW5nZWQsIDcyMSBpbnNlcnRp
b25zKCspLCA2NDQgZGVsZXRpb25zKC0pCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuX2Rldi5jCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vS2NvbmZpZyBiL2RyaXZlcnMvdmlydGlvL0tjb25maWcKPj4gaW5kZXggN2I0MTEz
MGQzZjM1Li42YjliODFmNGI4YzIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL0tjb25m
aWcKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vS2NvbmZpZwo+PiBAQCAtMTIsNiArMTIsMTQgQEAg
Y29uZmlnIEFSQ0hfSEFTX1JFU1RSSUNURURfVklSVElPX01FTU9SWV9BQ0NFU1MKPj4gICAJICBU
aGlzIG9wdGlvbiBpcyBzZWxlY3RlZCBpZiB0aGUgYXJjaGl0ZWN0dXJlIG1heSBuZWVkIHRvIGVu
Zm9yY2UKPj4gICAJICBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0KPj4gICAKPj4gK2NvbmZpZyBW
SVJUSU9fUENJX01PREVSTgo+PiArCXRyaXN0YXRlICJNb2Rlcm4gVmlydGlvIFBDSSBEZXZpY2Ui
Cj4+ICsJZGVwZW5kcyBvbiBQQ0kKPj4gKwloZWxwCj4+ICsJICBNb2Rlcm4gUENJIGRldmljZSBp
bXBsZW1lbnRhdGlvbi4gVGhpcyBtb2R1bGUgaW1wbGVtZW50cyB0aGUKPj4gKwkgIGJhc2ljIHBy
b2JlIGFuZCBjb250cm9sIGZvciBkZXZpY2VzIHdoaWNoIGFyZSBiYXNlZCBvbiBtb2Rlcm4KPj4g
KwkgIFBDSSBkZXZpY2Ugd2l0aCBwb3NzaWJsZSB2ZW5kb3Igc3BlY2lmaWMgZXh0ZW5zaW9ucy4K
Pj4gKwo+PiAgIG1lbnVjb25maWcgVklSVElPX01FTlUKPj4gICAJYm9vbCAiVmlydGlvIGRyaXZl
cnMiCj4+ICAgCWRlZmF1bHQgeQo+PiBAQCAtMjAsNyArMjgsNyBAQCBpZiBWSVJUSU9fTUVOVQo+
PiAgIAo+PiAgIGNvbmZpZyBWSVJUSU9fUENJCj4+ICAgCXRyaXN0YXRlICJQQ0kgZHJpdmVyIGZv
ciB2aXJ0aW8gZGV2aWNlcyIKPj4gLQlkZXBlbmRzIG9uIFBDSQo+PiArCWRlcGVuZHMgb24gVklS
VElPX1BDSV9NT0RFUk4KPj4gICAJc2VsZWN0IFZJUlRJTwo+PiAgIAloZWxwCj4+ICAgCSAgVGhp
cyBkcml2ZXIgcHJvdmlkZXMgc3VwcG9ydCBmb3IgdmlydGlvIGJhc2VkIHBhcmF2aXJ0dWFsIGRl
dmljZQo+IExvb2tzIGxpa2UgVklSVElPX1BDSV9NT0RFUk4gaXMgYWN0dWFsbHkganVzdCBhIGxp
YnJhcnkgdGhhdAo+IHZpcnRpbyBwY2kgdXNlcy4gSXMgdGhhdCByaWdodD8KCgpSaWdodC4KCgo+
IEluIHRoYXQgY2FzZSBqdXN0IHNlbGVjdCBpdAo+IGF1dG9tYXRpY2FsbHksIGxldCdzIG5vdCBt
YWtlIHVzZXJzIGVuYWJsZSBpdCBtYW51YWxseS4KCgpJJ3ZlIGNvbnNpZGVyZWQgdG8gZG8gdGhp
cyBidXQgdGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgbW9kdWxlIGRlcGVuZHMgb24gClBDSSBzbyBp
dCBjYW4ndCBiZSBzZWxlY3RlZCBJIHRoaW5rLgoKVGhhbmtzCgoKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

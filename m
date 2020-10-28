Return-Path: <SRS0=GUxp=ED=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785E4C388F9
	for <virtualization@archiver.kernel.org>; Wed, 28 Oct 2020 01:55:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE67122258
	for <virtualization@archiver.kernel.org>; Wed, 28 Oct 2020 01:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUk1PAhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE67122258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 44BE986B72;
	Wed, 28 Oct 2020 01:55:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xB7erQQ0wopG; Wed, 28 Oct 2020 01:55:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C6B586B6E;
	Wed, 28 Oct 2020 01:55:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 500A7C088B;
	Wed, 28 Oct 2020 01:55:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0961C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 01:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2C2AE873DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 01:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oEojMqIQ6q7E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 01:55:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C1E96873DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 01:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603850131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fsp+qw7VQilYqGlRCGG49/rRdIH2EMX83NOPrIacuxk=;
 b=PUk1PAhQPklbKMINtrlCi/8dfgoJD4SuqHwHTB8tPl435INOFqVU/dYpyVpbjNVgM95KiU
 JbI2YiZ+0cUtXUFZ2fAo5MZOF+LZbuLOa5JvugZlJrnyVyU3S4icsmgzOnCaP8JxMgPQzh
 VCpkp+BPGGcCtH4vc+/f6y24F6j0dOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-UfFOzHHINp27BE-bRy8Obw-1; Tue, 27 Oct 2020 21:55:27 -0400
X-MC-Unique: UfFOzHHINp27BE-bRy8Obw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D994F1868401;
 Wed, 28 Oct 2020 01:55:25 +0000 (UTC)
Received: from [10.72.13.38] (ovpn-13-38.pek2.redhat.com [10.72.13.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 759D35D9E8;
 Wed, 28 Oct 2020 01:55:17 +0000 (UTC)
Subject: Re: [PATCH 07/17] vhost scsi: support delayed IO vq creation
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, mst@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
References: <1603326903-27052-1-git-send-email-michael.christie@oracle.com>
 <1603326903-27052-8-git-send-email-michael.christie@oracle.com>
 <9e97ea2a-bc57-d4aa-4711-35dba20b3b9e@redhat.com>
 <49c2fc29-348c-06db-4823-392f7476d318@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <adcaeb64-b1da-2195-6656-ecc19f12e5ed@redhat.com>
Date: Wed, 28 Oct 2020 09:55:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <49c2fc29-348c-06db-4823-392f7476d318@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjAvMTAvMjcg5LiL5Y2IMTo0NywgTWlrZSBDaHJpc3RpZSB3cm90ZToKPiBPbiAxMC8y
NS8yMCAxMDo1MSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4KPj4gT24gMjAyMC8xMC8yMiDkuIrl
jYg4OjM0LCBNaWtlIENocmlzdGllIHdyb3RlOgo+Pj4gRWFjaCB2aG9zdC1zY3NpIGRldmljZSB3
aWxsIG5lZWQgYSBldnQgYW5kIGN0bCBxdWV1ZSwgYnV0IHRoZSBudW1iZXIKPj4+IG9mIElPIHF1
ZXVlcyBkZXBlbmRzIG9uIHdoYXRldmVyIHRoZSB1c2VyIGhhcyBjb25maWd1cmVkIGluIHVzZXJz
cGFjZS4KPj4+IFRoaXMgcGF0Y2ggaGFzIHZob3N0LXNjc2kgY3JlYXRlIHRoZSBldnQsIGN0bCBh
bmQgb25lIElPIHZxIGF0IGRldmljZQo+Pj4gb3BlbiB0aW1lLiBXZSB0aGVuIGNyZWF0ZSB0aGUg
b3RoZXIgSU8gdnFzIHdoZW4gdXNlcnNwYWNlIHN0YXJ0cyB0bwo+Pj4gc2V0IHRoZW0gdXAuIFdl
IHN0aWxsIHdhc3RlIHNvbWUgbWVtIG9uIHRoZSB2cSBhbmQgc2NzaSB2cSBzdHJ1Y3RzLAo+Pj4g
YnV0IHdlIGRvbid0IHdhc3RlIG1lbSBvbiBpb3ZlYyByZWxhdGVkIGFycmF5cyBhbmQgZm9yIGxh
dGVyIHBhdGNoZXMKPj4+IHdlIGtub3cgd2hpY2ggcXVldWVzIGFyZSB1c2VkIGJ5IHRoZSBkZXYt
Pm52cXMgdmFsdWUuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWlrZSBDaHJpc3RpZSA8bWljaGFl
bC5jaHJpc3RpZUBvcmFjbGUuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL3Zob3N0L3Njc2ku
YyB8IDE5ICsrKysrKysrKysrKysrKy0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Pgo+Pgo+PiBOb3QgZmFtaWxpYXIgd2l0aCBTQ1NJ
LiBCdXQgSSB3b25kZXIgaWYgaXQgY291bGQgYmVoYXZlIGxpa2Ugdmhvc3QtbmV0Lgo+Pgo+PiBF
LmcgdXNlcnNwYWNlIHNob3VsZCBrbm93biB0aGUgbnVtYmVyIG9mIHZpcnRxdWV1ZXMgc28gaXQg
Y2FuIGp1c3QgCj4+IG9wZW4gYW5kIGNsb3NlIG11bHRpcGxlIHZob3N0LXNjc2kgZmlsZSBkZXNj
cmlwdG9ycy4KPj4KPgo+IE9uZSBoaWNjdXAgSSdtIGhpdHRpbmcgaXMgdGhhdCB3ZSBtaWdodCBl
bmQgdXAgY3JlYXRpbmcgYWJvdXQgM3ggbW9yZSAKPiB2cXMgdGhhbiB3ZSBuZWVkLiBUaGUgcHJv
YmxlbSBpcyB0aGF0IGZvciBzY3NpIGVhY2ggdmhvc3QgZGV2aWNlIGhhczoKPgo+IHZxPTA6IHNw
ZWNpYWwgY29udHJvbCB2cQo+IHZxPTE6IGV2ZW50IHZxCj4gdnE9MiBhbmQgYWJvdmU6IFNDU0kg
Q01EL0lPIHZxcy4gV2Ugd2FudCB0byBjcmVhdGUgTiBvZiB0aGVzZS4KPgo+IFRvZGF5IHdlIGRv
Ogo+Cj4gVWVyc3BhY2UgZG9lcyBvcGVuKC9kZXYvdmhvc3Qtc2NzaSkKPiDCoMKgwqDCoMKgwqDC
oCB2aG9zdF9kZXZfaW5pdChjcmVhdGUgMTI4IHZxcyBhbmQgdGhlbiBsYXRlciB3ZSBzZXR1cCBh
bmQgdXNlIAo+IE4gb2YgdGhlbSk7Cj4KPiBRZW11IGRvZXMgaW9jdGwoVkhPU1RfU0VUX09XTkVS
KQo+IMKgwqDCoMKgwqDCoMKgIHZob3N0X2Rldl9zZXRfb3duZXIoKQo+Cj4gRm9yIE4gdnFzIHVz
ZXJzcGFjZSBkb2VzOgo+IMKgwqDCoMKgwqDCoMKgIC8vIHZpcnRxdWV1ZSBzZXR1cCByZWxhdGVk
IGlvY3Rscwo+Cj4gUWVtdSBkb2VzIGlvY3RsKFZIT1NUX1NDU0lfU0VUX0VORFBPSU5UKQo+IMKg
wqDCoMKgwqDCoMKgIC0gbWF0Y2ggTElPL3RhcmdldCBwb3J0IHRvIHZob3N0X2Rldgo+Cj4KPiBT
byB3ZSBjb3VsZCBjaGFuZ2UgdGhhdCB0bzoKPgo+IEZvciBOIElPIHZxcyB1c2Vyc3BhY2UgZG9l
cwo+IMKgwqDCoMKgwqDCoMKgIG9wZW4oL2Rldi92aG9zdC1zY3NpKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2aG9zdF9kZXZfaW5pdChjcmVhdGUgSU8sIGV2dCwgYW5kIGN0bCk7
Cj4KPiBmb3IgTiBJTyB2cXMgUWVtdSBkb2VzOgo+IMKgwqDCoMKgwqDCoMKgIGlvY3RsKFZIT1NU
X1NFVF9PV05FUikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmhvc3RfZGV2X3Nl
dF9vd25lcigpCj4KPiBmb3IgTiBJTyB2cXMgUWVtdSBkb2VzOgo+IMKgwqDCoMKgwqDCoMKgIC8v
IHZpcnRxdWV1ZSBzZXR1cCByZWxhdGVkIGlvY3Rscwo+Cj4gZm9yIE4gSU8gdnFzIFFlbXUgZG9l
czoKPiDCoMKgwqDCoMKgwqDCoCBpb2N0bChWSE9TVF9TQ1NJX1NFVF9FTkRQT0lOVCkKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBtYXRjaCBMSU8vdGFyZ2V0IHBvcnQgdG8gdmhv
c3RfZGV2IGFuZCBhc3NlbWJsZSB0aGUgCj4gbXVsdGlwbGUgdmhvc3RfZGV2IGRldmljZS4KPgo+
IFRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2ZSB0byBzZXR1cCBzb21lIG9mIHRoZSBldnQvY3Rs
IHNwZWNpZmljIAo+IHBhcnRzIGF0IG9wZW4oKSB0aW1lIHdoZW4gdmhvc3RfZGV2X2luaXQgZG9l
cyB2aG9zdF9wb2xsX2luaXQgZm9yIAo+IGV4YW1wbGUuCj4KPiAtIEF0IG9wZW4gdGltZSwgd2Ug
ZG9uJ3Qga25vdyBpZiB0aGlzIHZob3N0X2RldiBpcyBnb2luZyB0byBiZSBwYXJ0IG9mIAo+IGEg
bXVsdGlwbGUgdmhvc3RfZGV2aWNlIGRldmljZSBvciBhIHNpbmdsZSBvbmUgc28gd2UgbmVlZCB0
byBjcmVhdGUgYXQgCj4gbGVhc3QgMyBvZiB0aGVtCj4gLSBJZiBpdCBpcyBhIG11bHRpcGxlIGRl
dmljZSB3ZSBkb24ndCBrbm93IGlmIGl0cyB0aGUgZmlyc3QgZGV2aWNlIAo+IGJlaW5nIGNyZWF0
ZWQgZm9yIHRoZSBkZXZpY2Ugb3IgdGhlIE4ndGgsIHNvIHdlIGRvbid0IGtub3cgaWYgdGhlIAo+
IGRldidzIHZxcyB3aWxsIGJlIHVzZWQgZm9yIElPIG9yIGN0bHMvZXZ0cywgc28gd2UgaGF2ZSB0
byBjcmVhdGUgYWxsIDMuCj4KPiBXaGVuIHdlIGdldCB0aGUgZmlyc3QgVkhPU1RfU0NTSV9TRVRf
RU5EUE9JTlQgY2FsbCBmb3IgYSBuZXcgc3R5bGUgCj4gbXVsdGlwbGUgdmhvc3RfZGV2IGRldmlj
ZSwgd2UgY2FuIHVzZSB0aGF0IGRldidzIGV2dC9jdGwgdnFzIGZvciAKPiBldmVudHMvY29udHJv
bHMgcmVxdWVzdHMuIFdoZW4gd2UgZ2V0IHRoZSBvdGhlciAKPiBWSE9TVF9TQ1NJX1NFVF9FTkRQ
T0lOVCBjYWxscyBmb3IgdGhlIG11bHRpcGxlIHZob3N0X2RldiBkZXZpY2UgdGhlbiAKPiB0aG9z
ZSBkZXYncyBldnQvY3RsIHZxcyB3aWxsIGJlIGlnbm9yZWQgYW5kIHdlIHdpbGwgb25seSB1c2Ug
dGhlaXIgSU8gCj4gdnFzLiBTbyB3ZSBlbmQgdXAgd2l0aCBhIGxvdCBvZiBleHRyYSB2cXMuCgoK
UmlnaHQsIHNvIGluIHRoaXMgY2FzZSB3ZSBjYW4gdXNlIHRoaXMgcGF0Y2ggdG8gYWRkcmVzcyB0
aGlzIGlzc3VlIApwcm9iYWJseS4gSWYgZXZ0L2N0bCB2cSBpcyBub3QgdXNlZCwgd2Ugd29uJ3Qg
ZXZlbiBjcmVhdGUgdGhlbS4KCgo+Cj4KPiBPbmUgb3RoZXIgcXVlc3Rpb24vaXNzdWUgSSBoYXZl
IGlzIHRoYXQgcWVtdSBjYW4gb3BlbiB0aGUgCj4gL2Rldi92aG9zdC1zY3NpIGRldmljZSBvciBp
dCBhbGxvd3MgdG9vbHMgbGlrZSBsaWJ2aXJ0ZCB0byBvcGVuIHRoZSAKPiBkZXZpY2UgYW5kIHBh
c3MgaW4gdGhlIGZkIHRvIHVzZS4KCgpJdCBhbGxvd3MgbGlidmlydCB0byBvcGVuIGFuZCBwYXNz
IGZkcyB0byBxZW11LiBUaGlzIGlzIGhvdyBtdWx0aWUtcXVldWUgCnZpcnRpby1uZXQgaXMgZG9u
ZSwgbGlidmlydCBpcyBpbiBjaGFyZ2Ugb2Ygb3BlbmluZyBtdWx0aXBsZSBmaWxlIApkZXNjcmlw
dG9ycyBhbmQgcGFzcyB0aGVtIHRvIHFlbXUuCgoKPiBGb3IgdGhlIGxhdHRlciBjYXNlLCB3b3Vs
ZCB3ZSBjb250aW51ZSB0byBoYXZlIHRob3NlIHRvb2xzIHBhc3MgaW4gdGhlIAo+IGxlYWRpbmcg
ZmQsIHRoZW4gaGF2ZSBxZW11IGRvIHRoZSBvdGhlciBudW1fcXVldWVzIC0gMSAKPiBvcGVuKC9k
ZXYvdmhvc3Qtc2NzaSkgY2FsbHM/IE9yIGRvIHRoZXNlIGFwcHMgdGhhdCBwYXNzIGluIHRoZSBm
ZCBuZWVkIAo+IHRvIGtub3cgYWJvdXQgYWxsIG9mIHRoZSBmZHMgZm9yIHNvbWUgbWFuYWdlbWVu
dCByZWFzb24/CgoKVXN1YWxseSBxZW11IGlzIHJ1bm5pbmcgd2l0aG91dCBwcml2aWxlZ2UuIFNv
IGl0IGRlcGVuZHMgb24gdGhlIAptYW5hZ2VtZW50IHRvIG9wZW4gdGhlIGRldmljZS4KCk5vdGUg
dGhhdCBJJ20gbm90IG9iamVjdCB5b3VyIHByb3Bvc2FsLCBqdXN0IHdhbnQgdG8gc2VlIGlmIGl0
IGNvdWxkIGJlIApkb25lIHZpYSBhIG1vcmUgZWFzeSB3YXkuIER1cmluZyB0aGUgZGV2ZWxvcG1l
bnQgaWYgbXVsdGlxdWV1ZSAKdmlyaXRvLW5ldCwgc29tZXRoaW5nIHNpbWlsYXIgYXMgeW91J3Zl
IGRvbmUgd2FzIHByb3Bvc2VkIGJ1dCB3ZSBlbmQgdXAgCndpdGggdGhlIG11bHRpcGxlIHZob3N0
LW5ldCBmZCBtb2RlbCB3aGljaCBrZWVwcyBrZXJuZWwgY29kZSB1bmNoYW5nZWQuCgpUaGFua3MK
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u

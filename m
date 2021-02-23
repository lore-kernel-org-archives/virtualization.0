Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E1C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:46:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6081164E02
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6081164E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F4ED82DDE;
	Tue, 23 Feb 2021 09:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4R-qGBzc5C0j; Tue, 23 Feb 2021 09:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C067282DD6;
	Tue, 23 Feb 2021 09:46:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9864BC000B;
	Tue, 23 Feb 2021 09:46:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2C07C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B9D0D85C6F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5spdbaX4oDoW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:46:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0BAE685BD8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614073591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ua870MbcBKf1L7a60gclNoUI6ARWuqH3V7P7cCW35M=;
 b=Vhri+l9SDkfcK0P3xYVE+Jk3p7SanQ9TxTmsuEPRdRJ/xMs6r2qeYys9JuEuYKxK7zTdNu
 1SMw2mTCO8NKcuJWtxdYlzwr8kbrB/gVcbNjtlnTi6P4jUnio10mJcIl0B36SqmQ5thU1n
 izndZW0hjy1Tn3U5d0XqWeXpyqLEO3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-VR4YQnlkPE2T6Czu-kVUpg-1; Tue, 23 Feb 2021 04:46:29 -0500
X-MC-Unique: VR4YQnlkPE2T6Czu-kVUpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5646A100B3B4;
 Tue, 23 Feb 2021 09:46:28 +0000 (UTC)
Received: from [10.72.13.6] (ovpn-13-6.pek2.redhat.com [10.72.13.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B49619C45;
 Tue, 23 Feb 2021 09:46:22 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
Date: Tue, 23 Feb 2021 17:46:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210223041740-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, elic@nvidia.com, virtio-dev@lists.oasis-open.org,
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

Ck9uIDIwMjEvMi8yMyDkuIvljYg1OjI1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
TW9uLCBGZWIgMjIsIDIwMjEgYXQgMDk6MDk6MjhBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToK
Pj4KPj4gT24gMi8yMS8yMDIxIDg6MTQgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAyMDIx
LzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4gQ29tbWl0IDQ1MjYzOWE2
NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+Pj4+IGZvciBs
ZWdhY3kiKSBtYWRlIGFuIGV4Y2VwdGlvbiBmb3IgbGVnYWN5IGd1ZXN0cyB0byByZXNldAo+Pj4+
IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2VkIGJlZm9yZSBmZWF0
dXJlcwo+Pj4+IGFyZSBzZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1
cmVzKCkgY2hlY2sKPj4+PiBhbmQgYWxsb3cgZmVhdHVyZXMgcmVzZXQgdG8gMCBmb3IgdGhpcyBj
YXNlLgo+Pj4+Cj4+Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vl
c3RzIGNvdWxkIGFjY2Vzcwo+Pj4+IGNvbmZpZyBzcGFjZSBiZWZvcmUgZmVhdHVyZXMgYXJlIHNl
dC4gRm9yIGluc3RhbmNlLCB3aGVuCj4+Pj4gZmVhdHVyZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFk
dmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4+Pj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFuZCB2
YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+Pj4+IHNwYWNlIGJlZm9yZSB2
aXJ0aW8gZmVhdHVyZXMgYXJlIHNldC4KPj4+Cj4+PiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVjIHZp
b2xhdGlvbjoKPj4+Cj4+PiAiCj4+Pgo+Pj4gVGhlIGZvbGxvd2luZyBkcml2ZXItcmVhZC1vbmx5
IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPj4+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0LiBU
aGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRoZQo+Pj4gZHJpdmVyIHRv
IHVzZS4KPj4+ICIKPj4+Cj4+PiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/
Cj4+IElzbid0IHRoZSBjb21taXQgNDUyNjM5YTY0YWQ4IGl0c2VsZiBpcyBhIHdvcmthcm91bmQg
Zm9yIGxlZ2FjeSBndWVzdD8KPj4KPj4gSSB0aGluayB0aGUgcG9pbnQgaXMsIHNpbmNlIHRoZXJl
J3MgbGVnYWN5IGd1ZXN0IHdlJ2QgaGF2ZSB0byBzdXBwb3J0LCB0aGlzCj4+IGhvc3Qgc2lkZSB3
b3JrYXJvdW5kIGlzIHVuYXZvaWRhYmxlLiBBbHRob3VnaCBJIGFncmVlIHRoZSB2aW9sYXRpbmcg
ZHJpdmVyCj4+IHNob3VsZCBiZSBmaXhlZCAoeWVzLCBpdCdzIGluIHRvZGF5J3MgdXBzdHJlYW0g
a2VybmVsIHdoaWNoIGV4aXN0cyBmb3IgYQo+PiB3aGlsZSBub3cpLgo+IE9oICB5b3UgYXJlIHJp
Z2h0Ogo+Cj4KPiBzdGF0aWMgaW50IHZpcnRuZXRfdmFsaWRhdGUoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYpCj4gewo+ICAgICAgICAgIGlmICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPiAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoJnZkZXYtPmRldiwgIiVzIGZhaWx1cmU6IGNvbmZpZyBhY2Nl
c3MgZGlzYWJsZWRcbiIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsKPiAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICAgICAgICAgIH0KPgo+ICAgICAgICAg
IGlmICghdmlydG5ldF92YWxpZGF0ZV9mZWF0dXJlcyh2ZGV2KSkKPiAgICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOwo+Cj4gICAgICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2
LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewo+ICAgICAgICAgICAgICAgICAgaW50IG10dSA9IHZpcnRp
b19jcmVhZDE2KHZkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLAo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10dSkpOwo+ICAgICAgICAgICAgICAg
ICAgaWYgKG10dSA8IE1JTl9NVFUpCj4gICAgICAgICAgICAgICAgICAgICAgICAgIF9fdmlydGlv
X2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKCgpJIHdvbmRlciB3aHkgbm90IHNp
bXBseSBmYWlsIGhlcmU/CgoKPiAgICAgICAgICB9Cj4KPiAgICAgICAgICByZXR1cm4gMDsKPiB9
Cj4KPiBBbmQgdGhlIHNwZWMgc2F5czoKPgo+Cj4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlz
IHNlcXVlbmNlIHRvIGluaXRpYWxpemUgYSBkZXZpY2U6Cj4gMS4gUmVzZXQgdGhlIGRldmljZS4K
PiAyLiBTZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90
aWNlZCB0aGUgZGV2aWNlLgo+IDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVz
dCBPUyBrbm93cyBob3cgdG8gZHJpdmUgdGhlIGRldmljZS4KPiA0LiBSZWFkIGRldmljZSBmZWF0
dXJlIGJpdHMsIGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29k
IGJ5IHRoZSBPUyBhbmQgZHJpdmVyIHRvIHRoZQo+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0
aGUgZHJpdmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lm
aWMgY29uZmlndXJhdGlvbgo+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRo
ZSBkZXZpY2UgYmVmb3JlIGFjY2VwdGluZyBpdC4KPiA1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0
YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldyBmZWF0dXJlIGJpdHMgYWZ0
ZXIgdGhpcyBzdGVwLgo+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZF
QVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5v
dAo+IHN1cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJlcyBhbmQgdGhlIGRldmljZSBpcyB1bnVz
YWJsZS4KPiA3LiBQZXJmb3JtIGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2Nv
dmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVw
LAo+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNv
bmZpZ3VyYXRpb24gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4gOC4gU2V0
IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2ludCB0aGUgZGV2aWNlIGlzIOKA
nGxpdmXigJ0uCj4KPgo+IEl0ZW0gNCBvbiB0aGUgbGlzdCBleHBsaWNpdGx5IGFsbG93cyByZWFk
aW5nIGNvbmZpZyBzcGFjZSBiZWZvcmUKPiBGRUFUVVJFU19PSy4KPgo+IEkgY29uY2x1ZGUgdGhh
dCBWSVJUSU9fTkVUX0ZfTVRVIGlzIHNldCBtZWFucyAic2V0IGluIGRldmljZSBmZWF0dXJlcyIu
CgoKU28gdGhpcyBwcm9iYWJseSBuZWVkIHNvbWUgY2xhcmlmaWNhdGlvbi4gImlzIHNldCIgaXMg
dXNlZCBtYW55IHRpbWVzIGluIAp0aGUgc3BlYyB0aGF0IGhhcyBkaWZmZXJlbnQgaW1wbGljYXRp
b25zLgoKVGhhbmtzCgoKPgo+IEdlbmVyYWxseSBpdCBpcyB3b3J0aCBnb2luZyBvdmVyIGZlYXR1
cmUgZGVwZW5kZW50IGNvbmZpZyBmaWVsZHMKPiBhbmQgY2hlY2tpbmcgd2hldGhlciB0aGV5IHNo
b3VsZCBiZSBwcmVzZW50IHdoZW4gZGV2aWNlIGZlYXR1cmUgaXMgc2V0Cj4gb3Igd2hlbiBmZWF0
dXJlIGJpdCBoYXMgYmVlbiBuZWdvdGlhdGVkLCBhbmQgbWFraW5nIHRoaXMgY2xlYXIuCj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==

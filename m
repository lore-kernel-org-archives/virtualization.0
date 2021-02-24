Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA76C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:53:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F421B64D99
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F421B64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CEF083C0F;
	Wed, 24 Feb 2021 06:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J5zfVwyLgIa1; Wed, 24 Feb 2021 06:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0223E83BFD;
	Wed, 24 Feb 2021 06:53:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CED7CC000A;
	Wed, 24 Feb 2021 06:53:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF221C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B05546F5CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Etk64CzgLvuE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:53:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF73A6F5C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614149600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQWfD1uf2lc8vmVNj+8WjAGKIJv21YHDtDIFmZj0Gyo=;
 b=jRcqH01xdlZg4upnX63V2/vnK6PhF2sjVHZxRP1/aNcSBR6ZfDuOeR7vjTcpTH7JQc3N7V
 oII8d50z9A2fx9ND/J+Rny+35ErhTk67EOxVVAhzz0OIQJO/HR9aFzUGMNCrl7dx+MF8F+
 yTh00ZUoqkgAfHzoiOlwt0qeenUDKzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-qikExCaEPSeSp338RKXPFQ-1; Wed, 24 Feb 2021 01:53:16 -0500
X-MC-Unique: qikExCaEPSeSp338RKXPFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24F4B801977;
 Wed, 24 Feb 2021 06:53:15 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B0D19C46;
 Wed, 24 Feb 2021 06:53:09 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
Date: Wed, 24 Feb 2021 14:53:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224014232-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
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

Ck9uIDIwMjEvMi8yNCAyOjQ2IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgRmViIDI0LCAyMDIxIGF0IDAyOjA0OjM2UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjEvMi8yNCAxOjA0IOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4gT24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMTE6MzU6NTdBTSAtMDgwMCwgU2ktV2VpIExpdSB3
cm90ZToKPj4+PiBPbiAyLzIzLzIwMjEgNToyNiBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+Pj4+PiBPbiBUdWUsIEZlYiAyMywgMjAyMSBhdCAxMDowMzo1N0FNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+Pj4+Pj4gT24gMjAyMS8yLzIzIDk6MTIg5LiK5Y2ILCBTaS1XZWkgTGl1IHdy
b3RlOgo+Pj4+Pj4+IE9uIDIvMjEvMjAyMSAxMTozNCBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdy
b3RlOgo+Pj4+Pj4+PiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAxMjoxNDoxN1BNICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+Pj4gT24gMjAyMS8yLzE5IDc6NTQg5LiL5Y2ILCBTaS1X
ZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+Pj4+IENvbW1pdCA0NTI2MzlhNjRhZDggKCJ2ZHBhOiBtYWtl
IHN1cmUgc2V0X2ZlYXR1cmVzIGlzIGludm9rZWQKPj4+Pj4+Pj4+PiBmb3IgbGVnYWN5IikgbWFk
ZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8gcmVzZXQKPj4+Pj4+Pj4+PiBmZWF0
dXJlcyB0byAwLCB3aGVuIGNvbmZpZyBzcGFjZSBpcyBhY2Nlc3NlZCBiZWZvcmUgZmVhdHVyZXMK
Pj4+Pj4+Pj4+PiBhcmUgc2V0LiBXZSBzaG91bGQgcmVsaWV2ZSB0aGUgdmVyaWZ5X21pbl9mZWF0
dXJlcygpIGNoZWNrCj4+Pj4+Pj4+Pj4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9y
IHRoaXMgY2FzZS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEl0J3Mgd29ydGggbm90aW5nIHRoYXQg
bm90IGp1c3QgbGVnYWN5IGd1ZXN0cyBjb3VsZCBhY2Nlc3MKPj4+Pj4+Pj4+PiBjb25maWcgc3Bh
Y2UgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+Pj4+Pj4+Pj4+
IGZlYXR1cmUgVklSVElPX05FVF9GX01UVSBpcyBhZHZlcnRpc2VkIHNvbWUgbW9kZXJuIGRyaXZl
cgo+Pj4+Pj4+Pj4+IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVz
ZW50IGluIHRoZSBjb25maWcKPj4+Pj4+Pj4+PiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVz
IGFyZSBzZXQuCj4+Pj4+Pj4+PiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlvbjoKPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+PiAiCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gVGhlIGZvbGxvd2luZyBkcml2
ZXItcmVhZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPj4+Pj4+Pj4+IFZJUlRJT19O
RVRfRl9NVFUgaXMKPj4+Pj4+Pj4+IHNldC4KPj4+Pj4+Pj4+IFRoaXMgZmllbGQgc3BlY2lmaWVz
IHRoZSBtYXhpbXVtIE1UVSBmb3IgdGhlIGRyaXZlciB0byB1c2UuCj4+Pj4+Pj4+PiAiCj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4gRG8gd2UgcmVhbGx5IHdhbnQgdG8gd29ya2Fyb3VuZCB0aGlzPwo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+IFRoYW5rcwo+Pj4+Pj4+PiBBbmQgYWxzbzoKPj4+Pj4+Pj4KPj4+Pj4+
Pj4gVGhlIGRyaXZlciBNVVNUIGZvbGxvdyB0aGlzIHNlcXVlbmNlIHRvIGluaXRpYWxpemUgYSBk
ZXZpY2U6Cj4+Pj4+Pj4+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4+Pj4+Pj4+IDIuIFNldCB0aGUg
QUNLTk9XTEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZp
Y2UuCj4+Pj4+Pj4+IDMuIFNldCB0aGUgRFJJVkVSIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBr
bm93cyBob3cgdG8gZHJpdmUgdGhlCj4+Pj4+Pj4+IGRldmljZS4KPj4+Pj4+Pj4gNC4gUmVhZCBk
ZXZpY2UgZmVhdHVyZSBiaXRzLCBhbmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMK
Pj4+Pj4+Pj4gdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUKPj4+Pj4+Pj4g
ZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRoZSBkcml2ZXIgTUFZIHJlYWQgKGJ1dCBNVVNUIE5P
VCB3cml0ZSkKPj4+Pj4+Pj4gdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uCj4+Pj4+
Pj4+IGZpZWxkcyB0byBjaGVjayB0aGF0IGl0IGNhbiBzdXBwb3J0IHRoZSBkZXZpY2UgYmVmb3Jl
IGFjY2VwdGluZyBpdC4KPj4+Pj4+Pj4gNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0dXMgYml0
LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcKPj4+Pj4+Pj4gZmVhdHVyZSBiaXRzIGFm
dGVyIHRoaXMgc3RlcC4KPj4+Pj4+Pj4gNi4gUmUtcmVhZCBkZXZpY2Ugc3RhdHVzIHRvIGVuc3Vy
ZSB0aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDoKPj4+Pj4+Pj4gb3RoZXJ3aXNlLCB0
aGUgZGV2aWNlIGRvZXMgbm90Cj4+Pj4+Pj4+IHN1cHBvcnQgb3VyIHN1YnNldCBvZiBmZWF0dXJl
cyBhbmQgdGhlIGRldmljZSBpcyB1bnVzYWJsZS4KPj4+Pj4+Pj4gNy4gUGVyZm9ybSBkZXZpY2Ut
c3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1ZXVlcwo+Pj4+Pj4+
PiBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVyLWJ1cyBzZXR1cCwKPj4+Pj4+Pj4gcmVhZGlu
ZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlv
bgo+Pj4+Pj4+PiBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPj4+Pj4+Pj4g
OC4gU2V0IHRoZSBEUklWRVJfT0sgc3RhdHVzIGJpdC4gQXQgdGhpcyBwb2ludCB0aGUgZGV2aWNl
IGlzIOKAnGxpdmXigJ0uCj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IHNvIGFjY2Vzc2luZyBj
b25maWcgc3BhY2UgYmVmb3JlIEZFQVRVUkVTX09LIGlzIGEgc3BlYyB2aW9sYXRpb24sIHJpZ2h0
Pwo+Pj4+Pj4+IEl0IGlzLCBidXQgaXQncyBub3QgcmVsZXZhbnQgdG8gd2hhdCB0aGlzIGNvbW1p
dCB0cmllcyB0byBhZGRyZXNzLiBJCj4+Pj4+Pj4gdGhvdWdodCB0aGUgbGVnYWN5IGd1ZXN0IHN0
aWxsIG5lZWRzIHRvIGJlIHN1cHBvcnRlZC4KPj4+Pj4+Pgo+Pj4+Pj4+IEhhdmluZyBzYWlkLCBh
IHNlcGFyYXRlIHBhdGNoIGhhcyB0byBiZSBwb3N0ZWQgdG8gZml4IHRoZSBndWVzdCBkcml2ZXIK
Pj4+Pj4+PiBpc3N1ZSB3aGVyZSB0aGlzIGRpc2NyZXBhbmN5IGlzIGludHJvZHVjZWQgdG8gdmly
dG5ldF92YWxpZGF0ZSgpIChzaW5jZQo+Pj4+Pj4+IGNvbW1pdCBmZTM2Y2JlMDY3KS4gQnV0IGl0
J3Mgbm90IHRlY2huaWNhbGx5IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4KPj4+Pj4+Pgo+Pj4+Pj4+
IC1TaXdlaQo+Pj4+Pj4gSSB0aGluayBpdCdzIGEgYnVnIHRvIHJlYWQgY29uZmlnIHNwYWNlIGlu
IHZhbGlkYXRlLCB3ZSBzaG91bGQgbW92ZSBpdCB0bwo+Pj4+Pj4gdmlydG5ldF9wcm9iZSgpLgo+
Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+PiBJIHRha2UgaXQgYmFjaywgcmVhZGluZyBidXQgbm90
IHdyaXRpbmcgc2VlbXMgdG8gYmUgZXhwbGljaXRseSBhbGxvd2VkIGJ5IHNwZWMuCj4+Pj4+IFNv
IG91ciB3YXkgdG8gZGV0ZWN0IGEgbGVnYWN5IGd1ZXN0IGlzIGJvZ3VzLCBuZWVkIHRvIHRoaW5r
IHdoYXQgaXMKPj4+Pj4gdGhlIGJlc3Qgd2F5IHRvIGhhbmRsZSB0aGlzLgo+Pj4+IFRoZW4gbWF5
YmUgcmV2ZXJ0IGNvbW1pdCBmZTM2Y2JlMDY3IGFuZCBmcmllbmRzLCBhbmQgaGF2ZSBRRU1VIGRl
dGVjdCBsZWdhY3kKPj4+PiBndWVzdD8gU3VwcG9zZWRseSBvbmx5IGNvbmZpZyBzcGFjZSB3cml0
ZSBhY2Nlc3MgbmVlZHMgdG8gYmUgZ3VhcmRlZCBiZWZvcmUKPj4+PiBzZXR0aW5nIEZFQVRVUkVT
X09LLgo+Pj4+Cj4+Pj4gLVNpd2llCj4+PiBEZXRlY3RpbmcgaXQgaXNuJ3QgZW5vdWdoIHRob3Vn
aCwgd2Ugd2lsbCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5vdGlmeQo+Pj4gdGhlIGtlcm5lbCB0aGF0
IGl0J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KAo+Pgo+PiBJJ20gbm90IHN1cmUgSSBnZXQgdGhp
cywgaG93IGNhbiB3ZSBrbm93IGlmIHRoZXJlJ3MgYSBsZWdhY3kgZHJpdmVyIGJlZm9yZQo+PiBz
ZXRfZmVhdHVyZXMoKT8KPiBxZW11IGtub3dzIGZvciBzdXJlLiBJdCBkb2VzIG5vdCBjb21tdW5p
Y2F0ZSB0aGlzIGluZm9ybWF0aW9uIHRvIHRoZQo+IGtlcm5lbCByaWdodCBub3cgdW5mb3J0dW5h
dGVseS4KCgpJIG1heSBtaXNzIHNvbWV0aGluZywgYnV0IEkgc3RpbGwgZG9uJ3QgZ2V0IGhvdyB0
aGUgbmV3IGlvY3RsIGlzIApzdXBwb3NlZCB0byB3b3JrLgoKVGhhbmtzCgoKPgo+PiBBbmQgSSB3
b25kZXIgd2hhdCB3aWxsIGhhcGVlbiBpZiB3ZSBqdXN0IHJldmVydCB0aGUgc2V0X2ZlYXR1cmVz
KDApPwo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+Cj4+Pj4+Pj4+Pj4gUmVqZWN0aW5nIHJlc2V0IHRv
IDAKPj4+Pj4+Pj4+PiBwcmVtYXR1cmVseSBjYXVzZXMgY29ycmVjdCBNVFUgYW5kIGxpbmsgc3Rh
dHVzIHVuYWJsZSB0byBsb2FkCj4+Pj4+Pj4+Pj4gZm9yIHRoZSB2ZXJ5IGZpcnN0IGNvbmZpZyBz
cGFjZSBhY2Nlc3MsIHJlbmRlcmluZyBpc3N1ZXMgbGlrZQo+Pj4+Pj4+Pj4+IGd1ZXN0IHNob3dp
bmcgaW5hY2N1cmF0ZSBNVFUgdmFsdWUsIG9yIGZhaWx1cmUgdG8gcmVqZWN0Cj4+Pj4+Pj4+Pj4g
b3V0LW9mLXJhbmdlIE1UVS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEZpeGVzOiAxYTg2YjM3N2Fh
MjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3IKPj4+Pj4+Pj4+PiBzdXBwb3J0ZWQg
bWx4NSBkZXZpY2VzIikKPj4+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13
ZWkubGl1QG9yYWNsZS5jb20+Cj4+Pj4+Pj4+Pj4gLS0tCj4+Pj4+Pj4+Pj4gICAgwqDCoCBkcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0tLS0KPj4+Pj4+
Pj4+PiAgICDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMTQgZGVsZXRpb25z
KC0pCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPj4+Pj4+Pj4+PiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+Pj4+Pj4+Pj4+
IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4+ICsrKyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4+IEBAIC0xNDkwLDE0
ICsxNDkwLDYgQEAgc3RhdGljIHU2NAo+Pj4+Pj4+Pj4+IG1seDVfdmRwYV9nZXRfZmVhdHVyZXMo
c3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoCByZXR1
cm4gbXZkZXYtPm1seF9mZWF0dXJlczsKPj4+Pj4+Pj4+PiAgICDCoMKgIH0KPj4+Pj4+Pj4+PiAt
c3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diwKPj4+Pj4+Pj4+PiB1NjQgZmVhdHVyZXMpCj4+Pj4+Pj4+Pj4gLXsKPj4+Pj4+Pj4+PiAtwqDC
oMKgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkK
Pj4+Pj4+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FT1BOT1RTVVBQOwo+Pj4+Pj4+Pj4+
IC0KPj4+Pj4+Pj4+PiAtwqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4+Pj4+IC19Cj4+Pj4+Pj4+Pj4g
LQo+Pj4+Pj4+Pj4+ICAgIMKgwqAgc3RhdGljIGludCBzZXR1cF92aXJ0cXVldWVzKHN0cnVjdCBt
bHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4+Pj4+Pj4+ICAgIMKgwqAgewo+Pj4+Pj4+Pj4+ICAgIMKg
wqDCoMKgwqDCoCBpbnQgZXJyOwo+Pj4+Pj4+Pj4+IEBAIC0xNTU4LDE4ICsxNTUwLDEzIEBAIHN0
YXRpYyBpbnQKPj4+Pj4+Pj4+PiBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdTY0Cj4+Pj4+Pj4+Pj4gZmVhdHVyZXMpCj4+Pj4+Pj4+Pj4gICAgwqDCoCB7
Cj4+Pj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9
IHRvX212ZGV2KHZkZXYpOwo+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPj4+Pj4+Pj4+PiAtwqDC
oMKgIGludCBlcnI7Cj4+Pj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgIHByaW50X2ZlYXR1cmVzKG12
ZGV2LCBmZWF0dXJlcywgdHJ1ZSk7Cj4+Pj4+Pj4+Pj4gLcKgwqDCoCBlcnIgPSB2ZXJpZnlfbWlu
X2ZlYXR1cmVzKG12ZGV2LCBmZWF0dXJlcyk7Cj4+Pj4+Pj4+Pj4gLcKgwqDCoCBpZiAoZXJyKQo+
Pj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+Pj4+Pj4+Pj4+IC0KPj4+Pj4+
Pj4+PiAgICDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzID0gZmVhdHVy
ZXMgJgo+Pj4+Pj4+Pj4+IG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlczsKPj4+Pj4+Pj4+PiAgICDC
oMKgwqDCoMKgwqAgbmRldi0+Y29uZmlnLm10dSA9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBu
ZGV2LT5tdHUpOwo+Pj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoCBuZGV2LT5jb25maWcuc3RhdHVz
IHw9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LAo+Pj4+Pj4+Pj4+IFZJUlRJT19ORVRfU19MSU5L
X1VQKTsKPj4+Pj4+Pj4+PiAtwqDCoMKgIHJldHVybiBlcnI7Cj4+Pj4+Pj4+Pj4gK8KgwqDCoCBy
ZXR1cm4gMDsKPj4+Pj4+Pj4+PiAgICDCoMKgIH0KPj4+Pj4+Pj4+PiAgICDCoMKgIHN0YXRpYyB2
b2lkIG1seDVfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZQo+Pj4+Pj4+Pj4+
ICp2ZGV2LCBzdHJ1Y3QgdmRwYV9jYWxsYmFjayAqY2IpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

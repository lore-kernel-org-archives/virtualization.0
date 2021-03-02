Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F4C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:25:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86184601FA
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 04:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86184601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EFDD6067C;
	Tue,  2 Mar 2021 04:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yaz5dUcYZTDt; Tue,  2 Mar 2021 04:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E14260673;
	Tue,  2 Mar 2021 04:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70ECAC000B;
	Tue,  2 Mar 2021 04:25:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30669C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A87A4ED0B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJBGyL9bVJDJ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:25:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A00A4EC8A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 04:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614659121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11wEySU1LIQ+Vtv9yA9xjsI7FlO4u5qMtR9xfRCwT4o=;
 b=izq74CchBBoX8qB3bZJq9jgLC7S07DiYZz5v1L3PgFGrR0zVKAsGhQ/aaooLIuV/aLGxkb
 nOr//rZMKHZdedtH7vFBF+w+4aznCQKdo+fnUaQI6p6lD86lwX9qI6k3lJRrtGdKfPALG9
 UrQDbm56A+Vxh1f+SDMm2IAOKxjznM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-c1fYkVvVPpmZmhtLF5SIMw-1; Mon, 01 Mar 2021 23:25:18 -0500
X-MC-Unique: c1fYkVvVPpmZmhtLF5SIMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F5BE18B9EC3;
 Tue,  2 Mar 2021 04:25:17 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-215.pek2.redhat.com
 [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F3295B4B0;
 Tue,  2 Mar 2021 04:25:05 +0000 (UTC)
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
To: Sean Mooney <smooney@redhat.com>, Adrian Moreno <amorenoz@redhat.com>,
 Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
 <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
 <BY5PR12MB4322917EA142EA37DFAA53EADC9A9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bbed2011-b0f7-82ba-0e85-0ee455595e5e@redhat.com>
 <afe9f219-1247-173f-e93a-cfe083e5cfbd@redhat.com>
 <abc1d3d7cd321620f6ae7f9ac0bb92fcce30a474.camel@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b4ff75a4-c773-fdfa-d056-ec569b0eef69@redhat.com>
Date: Tue, 2 Mar 2021 12:25:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <abc1d3d7cd321620f6ae7f9ac0bb92fcce30a474.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Eli Cohen <elic@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>
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

Ck9uIDIwMjEvMy8xIDg6MDYg5LiL5Y2ILCBTZWFuIE1vb25leSB3cm90ZToKPiBPbiBNb24sIDIw
MjEtMDMtMDEgYXQgMTE6MjggKzAxMDAsIEFkcmlhbiBNb3Jlbm8gd3JvdGU6Cj4+IE9uIDMvMS8y
MSA4OjUwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gT24gMjAyMS8zLzEgMzoyOSDkuIvljYgs
IFBhcmF2IFBhbmRpdCB3cm90ZToKPj4+Pj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPj4+Pj4gU2VudDogTW9uZGF5LCBNYXJjaCAxLCAyMDIxIDk6MjkgQU0KPj4+Pj4K
Pj4+Pj4gT24gMjAyMS8yLzI2IDQ6NTAg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+
Pj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+Pj4+PiBTZW50OiBG
cmlkYXksIEZlYnJ1YXJ5IDI2LCAyMDIxIDE6NTYgUE0KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4g
T24gMjAyMS8yLzI2IDE6MzIg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Pj4+PiBG
cm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+Pj4gU2VudDogV2Vk
bmVzZGF5LCBGZWJydWFyeSAyNCwgMjAyMSAyOjE4IFBNCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gT24g
MjAyMS8yLzI0IDI6MTgg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+Pj4+Pj4gKwo+
Pj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKG5sYV9wdXRfdTE2KG1zZywKPj4+Pj4gVkRQQV9BVFRSX0RF
Vl9ORVRfQ0ZHX01BWF9WUVAsCj4+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29u
ZmlnLT5tYXhfdmlydHF1ZXVlX3BhaXJzKSkKPj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIC1FTVNHU0laRTsKPj4+Pj4+Pj4+IFdlIHByb2JhYmx5IG5lZWQgdG8gY2hlY2sgVklSVElP
X05FVF9GX1JTUyBoZXJlLgo+Pj4+Pj4+PiBZZXMuIFdpbGwgdXNlIGl0IGluIHYyLgo+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKG5sYV9wdXRfdTgobXNnLAo+Pj4+PiBWRFBBX0FUVFJf
REVWX05FVF9DRkdfUlNTX01BWF9LRVlfTEVOLAo+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbmZpZy0+cnNzX21heF9rZXlfc2l6ZSkpCj4+Pj4+Pj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+ICvCoMKg
wqAgcnNzX2ZpZWxkID0gbGUxNl90b19jcHUoY29uZmlnLT5yc3NfbWF4X2tleV9zaXplKTsKPj4+
Pj4+Pj4+PiArwqDCoMKgIGlmIChubGFfcHV0X3UxNihtc2csCj4+Pj4+IFZEUEFfQVRUUl9ERVZf
TkVUX0NGR19SU1NfTUFYX0lUX0xFTiwKPj4+Pj4+Pj4+IHJzc19maWVsZCkpCj4+Pj4+Pj4+Pj4g
K8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRU1TR1NJWkU7Cj4+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4+
ICvCoMKgwqAgaGFzaF90eXBlcyA9IGxlMzJfdG9fY3B1KGNvbmZpZy0+c3VwcG9ydGVkX2hhc2hf
dHlwZXMpOwo+Pj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKG5sYV9wdXRfdTMyKG1zZywKPj4+Pj4gVkRQ
QV9BVFRSX0RFVl9ORVRfQ0ZHX1JTU19IQVNIX1RZUEVTLAo+Pj4+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbmZpZy0+c3VwcG9ydGVkX2hhc2hfdHlwZXMpKQo+Pj4+Pj4+Pj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVNU0dTSVpFOwo+Pj4+Pj4+Pj4+ICvCoMKgwqAgcmV0dXJu
IDA7Cj4+Pj4+Pj4+Pj4gK30KPj4+Pj4+Pj4+PiArCj4+Pj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmRw
YV9kZXZfbmV0X2NvbmZpZ19maWxsKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwKPj4+Pj4+Pj4+
PiArc3RydWN0IHNrX2J1ZmYgKm1zZykgewo+Pj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnIGNvbmZpZyA9IHt9Owo+Pj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4+PiArwqDCoMKg
IHZkZXYtPmNvbmZpZy0+Z2V0X2NvbmZpZyh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmln
KSk7Cj4+Pj4+Pj4+PiBEbyB3ZSBuZWVkIHRvIHN5bmMgd2l0aCBvdGhlciBwb3NzaWJsZSBnZXRf
Y29uZmlnIGNhbGxzIGhlcmU/Cj4+Pj4+Pj4+IFRvIHJlYWRlcnMgb2YgZ2V0X2NvbmZpZygpIGlz
IG9rLiBObyBuZWVkIHRvIHN5bmMuCj4+Pj4+Pj4+IEhvd2V2ZXIsIEkgdGhpbmsgc2V0X2NvbmZp
ZygpIGFuZCBnZXRfY29uZmlnKCkgc2hvdWxkIHN5bmMgb3RoZXJ3aXNlCj4+Pj4+Pj4gZ2V0X2Nv
bmZpZyBjYW4gZ2V0IHBhcnRpYWwgdmFsdWUuCj4+Pj4+Pj4+IFdpbGwgcHJvYmFibHkgaGF2ZSB0
byBhZGQgdmRwYV9kZXZpY2UtPmNvbmZpZ19hY2Nlc3NfbG9jaygpLgo+Pj4+Pj4+IFByb2JhYmx5
LiBBbmQgdGhlIHNldF9jb25maWcoKSBzaG91bGQgYmUgc3luY2hyb25pemVkIHdpdGggdGhlCj4+
Pj4+Pj4gcmVxdXJlc3QgdGhhdCBjb21lcyBmcm9tIHZEUEEgYnVzLgo+Pj4+Pj4gWWVzLCBhIHJ3
IHNlbWFwaG9yZSBpcyBnb29kIGVub3VnaC4KPj4+Pj4+IERldmljZSBjb25maWcgZmllbGRzIGNh
biBiZSBjaGFuZ2UgZnJvbSB0aGUgZGV2aWNlIHNpZGUgYW55d2F5LCBzdWNoIGFzCj4+Pj4+IGxp
bmsgc3RhdHVzIGFueXdheS4KPj4+Pj4+IFN5bmMgdXNpbmcgbG9jayBzaG91bGRu4oCZdCBiZSBw
cm9ibGVtLgo+Pj4+Pj4KPj4+Pj4+PiBUaGlzIG1ha2VzIG1lIHRoaW5rIHdoZXRoZXIgd2Ugc2hv
dWxkIGdvIGJhY2sgdG8gdHdvIHBoYXNlcyBtZXRob2QsCj4+Pj4+Pj4gY3JlYXRlIGFuZCBlbmFi
bGUuCj4+Pj4+Pj4KPj4+Pj4+PiBUaGUgdkRQQSBkZXZpY2UgaXMgb25seSByZWdpc3RyZWQgYWZ0
ZXIgZW5hYmxpbmcsIHRoZW4gdGhlcmUncyBubwo+Pj4+Pj4+IG5lZWQgdG8gc3luYyB3aXRoIHZE
UEEgYnVzLCBhbmQgbWdtdCBpcyBub3QgYWxsb3dlZCB0byBjaGFuZ2UgY29uZmlnCj4+Pj4+IGFm
dGVyIGVuYWxiaW5nPwo+Pj4+Pj4gSW4gdGhhdCBjYXNlIHdlIHNob3VsZCBiZSBhYmxlIHRvIGRp
c2FibGUgaXQgYXMgd2VsbC4gRGlzYWJsZSBzaG91bGQgdGFrZSB0aGUKPj4+Pj4gZGV2aWNlIG9m
IHRoZSBidXMuCj4+Pj4+PiBJIGZpbmQgaXQgd2VpcmQgdG8gaGF2ZSB0aGlzIG1vZGVsIHRvIGxp
bmdlciBhcm91bmQgdGhlIGRldmljZSB3aXRob3V0Cj4+Pj4+IGFuY2hvcmluZyBvbiB0aGUgYnVz
Lgo+Pj4+Pj4gRm9yIGV4YW1wbGUgZGV2aWNlIGlzIG5vdCB5ZXQgZW5hYmxlZCwgc28gaXQgaXMg
bm90IGFuY2hvcmVkIG9uIHRoZSBidXMsIGJ1dAo+Pj4+PiBpdHMgbmFtZSBpcyBzdGlsbCBoYXZl
IHRvIHJlbWFpbiB1bmlxdWUuCj4+Pj4+Cj4+Pj4+Cj4+Pj4+IENhbiB3ZSBkbyBzb21lIHN5bmNo
b3JuaXphdGlvbiBiZXR3ZWVuIHZkcGEgZGV2aWNlIGFsbG9jYXRpb24gYW5kIHZkcGEKPj4+Pj4g
ZGV2aWNlIHJlZ2lzdGllciB0byBzb2x2ZSB0aGUgbmFtaW5nIGlzc3VlPwo+Pj4+IG1nbXQgdG9v
bCBxdWVyeWluZyB0aGUgZGV2aWNlIGNvbmZpZyBzcGFjZSBhZnRlciB2ZHBhIGRldmljZSBpcyBp
biB1c2UgaXMgcmVhbC4KPj4+PiBTbyBJIGRvbid0IHNlZSBzb2x2aW5nIGl0IGFueSBkaWZmZXJl
bnRseS4KPj4+Pgo+Pj4+IE5vdyB1cHBlciBsYXllcnMgb2YgdmRwYSB0byBub3QgYWNjZXNzIHRo
ZSBkZXZpY2Ugb24gdGhlIHBsYWNlZCBvbiB0aGUgdmRwYQo+Pj4+IGJ1cywgY2FuIGJlIHRha2Vu
IGNhcmUgYnkgZXhpc3RpbmcgZHJpdmVyIGNvZGUgdXNpbmcKPj4+PiBlY2hvIDAgPiAvc3lzL2J1
cy92ZHBhL2RyaXZlcnNfYXV0b3Byb2JlCj4+Pj4KPj4+PiBCeSBkZWZhdWx0IHZkcGEgZGV2aWNl
IHBsYWNlZCBvbiB0aGUgYnVzIHdvbnQgYmluZCB0byBhbnkgZHJpdmVyIChuZXQvdmhvc3QgZXRj
KS4KPj4+PiAxLiBEZWNpc2lvbiB0byBiaW5kIHRvIHdoaWNoIGRyaXZlciBpcyBkb25lIGFmdGVy
IGNvbmZpZyBvZiB0aGUgdmRwYSBkZXZpY2UgaXMKPj4+PiBkb25lLgo+Pj4+IDIuIG9yY2hlc3Ry
YXRpb24gc3cgZG9lcyBjcmVhdGUgYW5kIGNvbmZpZyBiZWZvcmUgaXQgYmluZHMgdG8gdGhlIHJp
Z2h0IGRyaXZlcgo+Pj4+IDMuIHdoaWNoIGRyaXZlciB0byBiaW5kIHRvIGRlY2lkZWQgYmFzZWQg
b24gdGhlIHVzZSBjYXNlIG9mIHRoYXQgaW5kaXZpZHVhbAo+Pj4+IHZkcGEgZGV2aWNlCj4+Pj4g
Rm9yIGV4YW1wbGUsCj4+Pj4gKGEpIHZkcGEwIGJpbmRzIHRvIG5ldCBkcml2ZXIgdG8gaGF2ZSBO
ZXRkZXYgZm9yIGNvbnRhaW5lcgo+Pj4+IChiKSB2ZHBhMSBiaW5kcyB0byB2aG9zdCBkcml2ZXIg
dG8gbWFwIHZkcGEgZGV2aWNlIHRvIFZNCj4+Pgo+Pj4gSSB0aGluayBpdCBzaG91bGQgd29yay4K
Pj4+PiBBZGRpbmcgQWRyaWFuLCBNYXhpbWUgYW5kIFNlYW4gZm9yIG1vcmUgY29tbWVudHMuCj4+
IElzIHRoaXMgYSBzdHJvbmcgcmVxdWlyZW1lbnQgb3IganVzdCBhIG9wdGlvbmFsIG9wZXJhdGlv
bj8KCgpTbyBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgc29tZXRoaW5nIG5lZWRzIHRvIGJlIGRv
bmUgdG8gbWFrZSBzdXJlOgoKMSkgdGhlIHZwZGEgZGV2aWNlIGlzIG5vdCBib3VuZCB0byB2aXJ0
aW8tdmRwYQoyKSBjb25maWcgaXMgbm90IGNoYW5nZWQgaWYgaXQgaGFzIGJlZW4gc2V0IGJ5IG1h
bmFnZW1lbnQKCgo+PiBUaGlzIG1pZ2h0IGJyZWFrIHNvbWUgZXhpc3RpbmcgbG9naWMgdGhhdCBl
eHBlY3RzIG5ldGRldiBvciB2aG9zdC12ZHBhIGRldmljZSB0bwo+PiBleGlzdCBiZWZvcmUgdGhl
IHNvbWUgY29uZmlnIChlLmc6bWFjIGFkZHJlc3MpIGlzIHNldC4KPiB0aGUgb3JjZXN0cmF0aW9u
IHNvZnR3YXJlIHNob3VsZCBub3QgcmVxdWlyZSBwZXJtaXNzaW9uIHRvIGRvIGRpcnZlciBiaW5k
aW5nIGFuZCBpbiB0aGUgY2FzZSBvZiBvcGVuc3RhY2sgd2lsbAo+IG5vdCBoYXZlIHRoZSBjYXBh
YmxpdHkgdG8gYmluZCB0aGUgdmRwYSBkZXZpY2UgdG8gYSBkaXJ2aWVyIGluIHRoZSBjdXJyZW50
IHByb3Bvc2VkIGRlc2lnbi4KPiB0aGUgb3JkZXJpbmcgd2UgYXJlIGV4cGVjdGluZyB0byBzdXBw
b3J0IGluIG9wZW5zdGFjayBhdCBsZWFzdCBpbml0YWxseSBpcyB0aGF0IHRoZSBhZG1pbnNpdHJh
dG9yCj4gd2lsbCB1c2UgZWl0aGVyIHN5c3RlbWQgc2VydmljZSBmaWxlcyBvciB1ZGV2IHJ1bGVz
IHRvIGFsbG9jYXRlIHRoZSBWRiBhbmQgdmRwYSBkZXZpY2Ugc3RhaWN0bHkgYXQgYm9vdC4KPgo+
IGluIHRoZSBjYXNlIG9mIG9wZW5zdGFjayB3ZSB3aWxsIGV4cGVjdCBhbGwgdmRwYSBkZXZpZXMg
dGhhdCB3aWxsIGJlIHVzZWQgYnkgb3BlbnN0YWNrKG5vdmEpIGZvciBhc3NpZ25tZW50Cj4gdG8g
dm1zIHdpbGwgYmUgcHJlYm91bmQgYnkgdGhlIGFkbWluc3RyYXRvcnMgdG8gdmhvc3QtdmRwYS4g
b3BlbnN0YWNrIHdpbGwgc2ltcGx5IHRyYWNrIHRoZSAvZGV2L3Zob3N0KiBwYXRocwo+IGNvcmFs
bGF0ZWQgdG8gdGhlIHZkcGEgZGV2aWNlcyB3aG9zZSBwYXJlbnQgVkYgYXJlIGFsbG93ZWQgYnkg
dGhlIHBjaSBwYXNzdGhvdWdoIHdoaXRlbGlzdC4KPgo+IGlmIHRoZSBhZG1pbnN0cmF0b3IgYmlu
ZHMgdGhlIHZkcGEgZGV2aWNlIHRvIHZpcnRpby12ZHBhIHNvIHRoYXQgdmlydGlvLW5ldC1wY2kg
aXMgdXNlZCBvbiB0aGUgaG9zdCBub3ZhIGFuZCBsaWJ2aXJ0Cj4gd2lsbCBub3QgY29ycmVjdCB0
aGF0IGFuZCB0aGUgdm0gYm9vdCB3aWxsIGZhaWwuIGJ1dCBwcm92aWRlZCB5b3UgZG8gbm90IGxp
c3QgdGhhdCBwYXJlbnQgVkYgaW4gdGhlIHdoaXRlbGlzdCBub3ZhCj4gd2lsbCBhbHNvIGlnbm9y
ZSBpdC4gc28gaWYgeW91IHdhbnQgdG8gbWl4IGFuZCBtYXRjaCB0aGUgdmRwYSBkZXZpY2UgZHJp
dmVyIHRoYXQgc2hvdWxkIG5vdCBicmVhayBhbnl0aGluZyBwcm92aWRlZAo+IHlvdSBkbyBub3Qg
bGlzdCBpdHMgcGFyZW50IGluIHRoZSBwY2kgd2hpdGVsaXN0Lgo+Cj4gYnV0IG9uZSB0aGluZyB0
byBrZWVwIGluIG1pbmQgaXMgd2hsaWUgd2UgYXJlIG5vdCBwbGFubmluZyB0byBjcmVhdGUgVkYv
VkRQQSBkZXZpY2VzIGR5bmFtaWNsYWx5IGF0IGxlc2F0IG5vdCBmb3IgdGhlIGluaXRhbGwKPiBp
bXBsZW50YXRpb24gd2UgZG8gZXhwYWN0IHRvIGJlIGFibGUgdG8gY29uZmlndXJlIGF0dGlidXRl
IG9mIHRoZSB2ZHBhIGRldmljZSBhZnRlciB0ZWh5IGFyZSBjcmVhdGUgbGlrZSBhbnkgb3RoZXIg
bmljLgo+IGZvciBleGFtcGxlIHRoZSBtYWMsIG10dSwgbGluay1zdGF0ZSBzaG91bGQgYWxsIGJl
IGNvbmZpZ3VyZWFibGUgYXQgcnVudGltZSB2aWEgbm9ybWFsIGlwIHJvdXRlMiBjb21tYW5kcy4K
CgpTbyBpbiB0aGUgY2FzZSBvZiB2RFBBLCB0aGlzIHRhc2sgaXMgZXhwZWN0ZWQgdG8gYmUgZG9u
ZSBieSB2ZHBhIHRvb2wuIAooVGhlcmUncyBubyBndWFyYW50ZWUgdGhhdCB2RFBBIGlzIGEgVkYp
LgoKCj4KPiBhdCB0aGUgbW9ybWVudCB3ZSBhcmUgZW5jb3VudGVybmcgaXNzdWUgd2l0aCB0aGUg
bWFjIGFkcmVzcyBzcGVjaWZpY2x5IHdoaWNoIHFlbXUgaXMgaG9wZWZ1bGx5IGdvaW5nIHRvIHdv
cmsgYXJvdW5kIHNpbmNlCj4gbGlidmlydCBhbmQgbm92YSBjYW5ub3QgY3VycmVudGx5IGNvbmZp
Z3VyZSB0aGUgbWFjIGFkZHJlc3Mgb2YgYSB2aG9zdC12ZHBhIGRldmljZSBzbyB3ZSBhcmUgcmVs
eWluZyBvbiBxZW11Cj4gdG8gdGFrZSB0aGUgbWFjIGFkcmVzcyBmb3JtIHRoZSBxZW11IGNvbW1h
bmQgbGluZSBzbyB0aGF0IGl0IGRvZXMgbm90IGVuZCB1cCBhcyBhbGwgMCBtYWNzIGluIHRoZSBn
dWVzdC4KCgpOb3RlIHRoYXQgYSBrZXJuZWwgcGF0Y2ggaXMgcG9zdGVkIGJ5IEVsaVsxXSB3aGlj
aCBhc3NpZ24gYSByYW5kb21pemVkIAptYWMuIFRoaXMgc2hvdWxkIHNvbHZlIHRoZSBpc3N1ZSBp
biBhbm90aGVyIHdheS4KCgo+IGFzIHNvbWUgb25lIHRoYXQgd29ya3Mgb24gb3JjZXN0cmF0aW9u
IGxldmVsIGkgd291bGQgaGF2ZSBleHBlY3QgdGhhdCBzZXR0aW5nIHRoZSBtYWMvbXR1IG9uIGVp
dGhlciB0aGUgdmYgb3IgdGhlIG5ldGRldgo+IHJlcHJlc2VudG9yIHRvIG1hdGNoIHRoZSBkZWly
ZWVkIG1hYy9tdHUgaW4gdGhlIGd1ZXN0IHdvdWxkIGhhdmUgYmVlbiBzdWZmaWNlbnQgdG8gYWx0
ZXIgdGhlIHZkcGEgZGV2aWNlIGNvbmZpcnV0YXRpb24uCj4gbGlrZWx5ICB0aGUgbmV0ZGV2IHJl
cHJlc2VudG9yIHdvdWxkIG1ha2UgdGhlIG1vc3Qgc2VuY2UgdG8gYWx0ZXIgdG8gbWF0Y2ggdGhl
IGRlc2lyZWQgbWFjIHNvIHRoYXQgdGhlIG1hYyBhZHJlc3Mgc2VlIG9uIHRoZSBvdnMKPiBicmlk
Z2UgbWF0Y2hlcyB0aGUgbWFjIG9mIHRoZSB2bS4KCgpTcGVha2luZyBmb3IgZ2VucmVhbCB2RFBB
LCBpdCdzIG5vdCBndWFyYW50ZWVkIHRoYXQgdGhlIHZlbmRvciB3aWxsIAppbXBsbWVuZXQgdGhl
IGRldmljZSB3aXRoIGEgcmVwcmVzZW50b3IuIFNvIHZEUEEgdG9vbCBpcyBleHBlY3RlZCB0byBi
ZSAKdGhlIG9ubHkgd2F5IHRvIGNvbmZpZ3VyZSB0aGUgZGV2aWNlLgoKVGhhbmtzCgpbMV0gaHR0
cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtdmlydHVhbGl6YXRpb24vbXNnNDg0NTEu
aHRtbAoKCj4gdGhlIGN1cnJlbnQgY2FzZSB3aGVyZSB0aGUgdmRwYSByZXByZXNlbnRvciBuZXRk
ZXYgc2VhbXMgdG8gaGF2ZSBubyBiYXJlaW5nIG9uIHRoZSB2ZHBhIGRldmljZQo+IGNvbmZpZyBt
YWtlcyBkZWJ1Z2dpbmcgbXVjaCBtb3JlIGRpZmZpY2FsdCBhbmQgaXMgbGlrZWx5IHRvIGNvbmZ1
c2UgbW9uaXRvcmluZyBzb2Z0d2FyZS4gZm9ydHVuZXRseSBvcGVuc3RhY2sgaXMgbm90IG1hdGNo
aW5nIG9uIHRoZSBtYWMKPiBhZGRyZXNzIGluIHRoaXMgc3BlZmljIGNhc2UgdG8gaWRlbnRpZnkg
dGhlIG5ldGRldiByZXByZXNudG9yIHBvcnQgYnV0IHdlIGhhdmUgb3RoZXIgYmFja2VuZCB0aGF0
IGRvIGxvb2sgYXQgdGhlIG1hYy4gaW4gdGhlIGNhc2Ugb2Ygb3ZzCj4gd2Ugc3RvcmUgdGhlIHV1
aWQgb2YgdGhlIG5ldXRyb24gcG9ydCBpbiB0aGUgb3ZzZGIgd2hlbiBhZGRpbmcgYSBwb3J0IHRv
IG92cyBzbyB3ZSByZWx5IG9uIHRoYXQgbm90IHRoZSBtYWMgYnV0ICBmb3IgbGVnYWN5IG1vZGUK
PiBzcmlvdiB3aGljaCB3ZSBob3BlIHRvIHN1cHBvcnQgd2l0aCB2ZHBhIGV2ZW50dWxhbGx5IGFm
dGVyIHdlIGNvbXBsZSB0aGUgaGFyZHdhcmUgb2ZmbG9hZWQgb3ZzIHN1cHBvcnQsIGN1cnJlbmx0
eSByZWx5cyBvbiB0aGUgbWFjIGluIHNvbWUgY2FzZXMuCj4KPiBpIGhvcGUgdGhhdCBhbnN3ZXJl
ZCB5b3VyIHF1ZXN0aW9ucz8KPiB3ZSBhcmUgYXdhcmUgdGhhdCB3ZSBsaWtlbHkgd2lsbCBoYXZl
IHRvIHN1cHBvcnQgdmRwYSBkZXZpY2UgY3JlYXRpb24gYXQgc29tZSBwb2ludCBpZiB3ZSBpbnRl
bmQgdG8gYWRkIHN1cHBvcnQgZm9yIHZkcGEgZGV2aWNlcwo+IGNyZWF0ZWQgZm9ybSBzdWJmdW5j
dGlvbnMgb3IgaW50ZWxzIHNpb3YgaG93dmVyIHRoYXQgd2FzIG5vdCByZWFkeSB3aGVuIHdlIHN0
YXJ0ZWQgdGhpcyB3b3JrIHNvIGl0IHdhcyBkZWNsYXJlZCBvdXQgb2Ygc2NvcGUgYW5kCj4gdGhl
IGN1cmVybnQgc3RhdGljIGFwcHJvY2ggd2FzIHRha2VuIGFzIHRoZSBvbmx5IHBhdGggd2UgY291
bGQgZW5hYmxlIGJlZm9yZSBjb2RlIGZyZWUgaW4gMTAgZGF5cy4KPgo+IHJlZ2FyZHMgc2Vhbi4K
Pgo+Pgo+PiBUaGFua3MKPj4KPgo+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4
LXZpcnR1YWxpemF0aW9uL21zZzQ4NDUxLmh0bWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

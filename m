Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8115C433DB
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 04:06:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C7922583
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 04:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C7922583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1375785C32;
	Tue,  5 Jan 2021 04:06:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNUbysorBKYf; Tue,  5 Jan 2021 04:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 88F5985C28;
	Tue,  5 Jan 2021 04:06:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68E88C0891;
	Tue,  5 Jan 2021 04:06:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 920F5C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 850DF8689B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gKs9Ynfh80nZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:06:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CFC768687D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 04:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609819577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FknucuoRBtp08a5KMu1lf/hlB/0GtImhroWC39pwzVI=;
 b=S8r3hXaDVGGcFiCWzmXfP6TybGOqtr1nTC1zF74hRoJHJBr60NTvNMGb31zulRh3HmXDWa
 3jPI/etOZw/uDVwf7Yebb6XhxgHKSi1fwFTAgwA9L8fnebMbR9lU7ySYJ9MkotADk1u1Vs
 uPZv2OgJ/su82TaRnscDkwO1F+0k3WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-38jVJWLiNc6Ysmr-ZHgCvg-1; Mon, 04 Jan 2021 23:06:16 -0500
X-MC-Unique: 38jVJWLiNc6Ysmr-ZHgCvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BE44192D785;
 Tue,  5 Jan 2021 04:06:13 +0000 (UTC)
Received: from [10.72.13.192] (ovpn-13-192.pek2.redhat.com [10.72.13.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7E295D9C6;
 Tue,  5 Jan 2021 04:06:08 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 7/7] vdpa_sim_net: Add support for user
 supported devices
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
 <20210104033141.105876-8-parav@nvidia.com>
 <ea07c16e-6bc5-0371-4b53-4bf4c75d5af8@redhat.com>
 <BY5PR12MB43227F9431227959051B90B1DCD20@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2e052c52-44e2-a066-3872-0e20805760f2@redhat.com>
Date: Tue, 5 Jan 2021 12:06:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB43227F9431227959051B90B1DCD20@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

Ck9uIDIwMjEvMS80IOS4i+WNiDM6MjEsIFBhcmF2IFBhbmRpdCB3cm90ZToKPgo+PiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PiBTZW50OiBNb25kYXksIEphbnVhcnkg
NCwgMjAyMSAxMjozNSBQTQo+Pgo+PiBPbiAyMDIxLzEvNCDkuIrljYgxMTozMSwgUGFyYXYgUGFu
ZGl0IHdyb3RlOgo+Pj4gICAgc3RhdGljIGludCBfX2luaXQgdmRwYXNpbV9uZXRfaW5pdCh2b2lk
KQo+Pj4gICAgewo+Pj4gICAgCWludCByZXQgPSAwOwo+Pj4gQEAgLTE3Niw2ICsyNjQsOCBAQCBz
dGF0aWMgaW50IF9faW5pdCB2ZHBhc2ltX25ldF9pbml0KHZvaWQpCj4+Pgo+Pj4gICAgCWlmIChk
ZWZhdWx0X2RldmljZSkKPj4+ICAgIAkJcmV0ID0gdmRwYXNpbV9uZXRfZGVmYXVsdF9kZXZfcmVn
aXN0ZXIoKTsKPj4+ICsJZWxzZQo+Pj4gKwkJcmV0ID0gdmRwYXNpbV9uZXRfbWdtdGRldl9pbml0
KCk7Cj4+PiAgICAJcmV0dXJuIHJldDsKPj4+ICAgIH0KPj4+Cj4+PiBAQCAtMTgzLDYgKzI3Myw4
IEBAIHN0YXRpYyB2b2lkIF9fZXhpdCB2ZHBhc2ltX25ldF9leGl0KHZvaWQpCj4+PiAgICB7Cj4+
PiAgICAJaWYgKGRlZmF1bHRfZGV2aWNlKQo+Pj4gICAgCQl2ZHBhc2ltX25ldF9kZWZhdWx0X2Rl
dl91bnJlZ2lzdGVyKCk7Cj4+PiArCWVsc2UKPj4+ICsJCXZkcGFzaW1fbmV0X21nbXRkZXZfY2xl
YW51cCgpOwo+Pj4gICAgfQo+Pj4KPj4+ICAgIG1vZHVsZV9pbml0KHZkcGFzaW1fbmV0X2luaXQp
Owo+Pj4gLS0gMi4yNi4yCj4+Cj4+IEkgd29uZGVyIHdoYXQncyB0aGUgdmFsdWUgb2Yga2VlcGlu
ZyB0aGUgZGVmYXVsdCBkZXZpY2UgdGhhdCBpcyBvdXQgb2YgdGhlCj4+IGNvbnRyb2wgb2YgbWFu
YWdlbWVudCBBUEkuCj4gSSB0aGluayB3ZSBjYW4gcmVtb3ZlIGl0IGxpa2UgaG93IEkgZGlkIGlu
IHRoZSB2MSB2ZXJzaW9uLiBBbmQgYWN0dWFsIHZlbmRvciBkcml2ZXJzIGxpa2UgbWx4NV92ZHBh
IHdpbGwgbGlrZWx5IHNob3VsZCBkbyBvbmx5IHVzZXIgY3JlYXRlZCBkZXZpY2VzLgo+IEkgYWRk
ZWQgb25seSBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBwdXJwb3NlLCBidXQgd2UgY2FuIHJl
bW92ZSB0aGUgZGVmYXVsdCBzaW11bGF0ZWQgdmRwYSBuZXQgZGV2aWNlLgo+IFdoYXQgZG8geW91
IHJlY29tbWVuZD8KCgpJIHRoaW5rIHdlJ2QgYmV0dGVyIG1hbmRhdGUgdGhpcyBtYW5hZ2VtZW50
IEFQSS4gVGhpcyBjYW4gYXZvaWQgdmVuZG9yIApzcGVjaWZpYyBjb25maWd1cmF0aW9uIHRoYXQg
bWF5IGNvbXBsZXggbWFuYWdlbWVudCBsYXllci4KClRoYW5rcwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

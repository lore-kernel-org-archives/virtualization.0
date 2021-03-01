Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C2C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 03:59:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1F360232
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 03:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1F360232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D99F60657;
	Mon,  1 Mar 2021 03:59:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6YfTm5TTeLQy; Mon,  1 Mar 2021 03:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6CD160643;
	Mon,  1 Mar 2021 03:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DC62C000B;
	Mon,  1 Mar 2021 03:59:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51962C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:59:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 38A5B83B77
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JWbEKKuq1G7v
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58C3183B75
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 03:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614571169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgRYeH62Qz4N23XfyL8alI1K0WtmRXqsODe+0oie60o=;
 b=Q0skxgjDaj1a2fZrrDA40CiGuywekVqrFNndm7e7yOp1l5zPqyzdcVkDdbte95UxlrzwKa
 +IitNKTBbIC0Spp7OKCINJjVGn3fOJTIiMePsXejaK6hofuIuOcljZHw9JgsOqpI3lEFCP
 swyUEO8x/E6/HRPQyq83s+xYLDNS5Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-A484O7wmMdGwlnIUPyYcAQ-1; Sun, 28 Feb 2021 22:59:27 -0500
X-MC-Unique: A484O7wmMdGwlnIUPyYcAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F18911935798;
 Mon,  1 Mar 2021 03:59:25 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-164.pek2.redhat.com
 [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0C25D6CF;
 Mon,  1 Mar 2021 03:59:20 +0000 (UTC)
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
 <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
 <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a1836031-9240-b835-13c3-42dab92d06fa@redhat.com>
Date: Mon, 1 Mar 2021 11:59:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322010113CCDCA1BB81F766DC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-GB
Cc: Eli Cohen <elic@nvidia.com>, "mst@redhat.com" <mst@redhat.com>
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

Ck9uIDIwMjEvMi8yNiA0OjUwIOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Cj4+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IEZyaWRheSwgRmVicnVh
cnkgMjYsIDIwMjEgMTo1NiBQTQo+Pgo+Pgo+PiBPbiAyMDIxLzIvMjYgMTozMiDkuIvljYgsIFBh
cmF2IFBhbmRpdCB3cm90ZToKPj4+PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+Pj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjQsIDIwMjEgMjoxOCBQTQo+Pj4+
Cj4+Pj4gT24gMjAyMS8yLzI0IDI6MTgg5LiL5Y2ILCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4+Pj4+
ICsKPj4+Pj4gKwlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFY
X1ZRUCwKPj4+Pj4gKwkJCWNvbmZpZy0+bWF4X3ZpcnRxdWV1ZV9wYWlycykpCj4+Pj4+ICsJCXJl
dHVybiAtRU1TR1NJWkU7Cj4+Pj4gV2UgcHJvYmFibHkgbmVlZCB0byBjaGVjayBWSVJUSU9fTkVU
X0ZfUlNTIGhlcmUuCj4+PiBZZXMuIFdpbGwgdXNlIGl0IGluIHYyLgo+Pj4KPj4+Pj4gKwlpZiAo
bmxhX3B1dF91OChtc2csIFZEUEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfTUFYX0tFWV9MRU4sCj4+
Pj4+ICsJCSAgICAgICBjb25maWctPnJzc19tYXhfa2V5X3NpemUpKQo+Pj4+PiArCQlyZXR1cm4g
LUVNU0dTSVpFOwo+Pj4+PiArCj4+Pj4+ICsJcnNzX2ZpZWxkID0gbGUxNl90b19jcHUoY29uZmln
LT5yc3NfbWF4X2tleV9zaXplKTsKPj4+Pj4gKwlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBBX0FU
VFJfREVWX05FVF9DRkdfUlNTX01BWF9JVF9MRU4sCj4+Pj4gcnNzX2ZpZWxkKSkKPj4+Pj4gKwkJ
cmV0dXJuIC1FTVNHU0laRTsKPj4+Pj4gKwo+Pj4+PiArCWhhc2hfdHlwZXMgPSBsZTMyX3RvX2Nw
dShjb25maWctPnN1cHBvcnRlZF9oYXNoX3R5cGVzKTsKPj4+Pj4gKwlpZiAobmxhX3B1dF91MzIo
bXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX0hBU0hfVFlQRVMsCj4+Pj4+ICsJCQljb25m
aWctPnN1cHBvcnRlZF9oYXNoX3R5cGVzKSkKPj4+Pj4gKwkJcmV0dXJuIC1FTVNHU0laRTsKPj4+
Pj4gKwlyZXR1cm4gMDsKPj4+Pj4gK30KPj4+Pj4gKwo+Pj4+PiArc3RhdGljIGludCB2ZHBhX2Rl
dl9uZXRfY29uZmlnX2ZpbGwoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+Pj4+PiArc3RydWN0
IHNrX2J1ZmYgKm1zZykgewo+Pj4+PiArCXN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyBjb25maWcg
PSB7fTsKPj4+Pj4gKwo+Pj4+PiArCXZkZXYtPmNvbmZpZy0+Z2V0X2NvbmZpZyh2ZGV2LCAwLCAm
Y29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4+Pj4gRG8gd2UgbmVlZCB0byBzeW5jIHdpdGggb3Ro
ZXIgcG9zc2libGUgZ2V0X2NvbmZpZyBjYWxscyBoZXJlPwo+Pj4gVG8gcmVhZGVycyBvZiBnZXRf
Y29uZmlnKCkgaXMgb2suIE5vIG5lZWQgdG8gc3luYy4KPj4+IEhvd2V2ZXIsIEkgdGhpbmsgc2V0
X2NvbmZpZygpIGFuZCBnZXRfY29uZmlnKCkgc2hvdWxkIHN5bmMgb3RoZXJ3aXNlCj4+IGdldF9j
b25maWcgY2FuIGdldCBwYXJ0aWFsIHZhbHVlLgo+Pj4gV2lsbCBwcm9iYWJseSBoYXZlIHRvIGFk
ZCB2ZHBhX2RldmljZS0+Y29uZmlnX2FjY2Vzc19sb2NrKCkuCj4+Cj4+IFByb2JhYmx5LiBBbmQg
dGhlIHNldF9jb25maWcoKSBzaG91bGQgYmUgc3luY2hyb25pemVkIHdpdGggdGhlIHJlcXVyZXN0
IHRoYXQKPj4gY29tZXMgZnJvbSB2RFBBIGJ1cy4KPiBZZXMsIGEgcncgc2VtYXBob3JlIGlzIGdv
b2QgZW5vdWdoLgo+IERldmljZSBjb25maWcgZmllbGRzIGNhbiBiZSBjaGFuZ2UgZnJvbSB0aGUg
ZGV2aWNlIHNpZGUgYW55d2F5LCBzdWNoIGFzIGxpbmsgc3RhdHVzIGFueXdheS4KPiBTeW5jIHVz
aW5nIGxvY2sgc2hvdWxkbuKAmXQgYmUgcHJvYmxlbS4KPgo+PiBUaGlzIG1ha2VzIG1lIHRoaW5r
IHdoZXRoZXIgd2Ugc2hvdWxkIGdvIGJhY2sgdG8KPj4gdHdvIHBoYXNlcyBtZXRob2QsIGNyZWF0
ZSBhbmQgZW5hYmxlLgo+Pgo+PiBUaGUgdkRQQSBkZXZpY2UgaXMgb25seSByZWdpc3RyZWQgYWZ0
ZXIgZW5hYmxpbmcsIHRoZW4gdGhlcmUncyBubyBuZWVkIHRvIHN5bmMKPj4gd2l0aCB2RFBBIGJ1
cywgYW5kIG1nbXQgaXMgbm90IGFsbG93ZWQgdG8gY2hhbmdlIGNvbmZpZyBhZnRlciBlbmFsYmlu
Zz8KPj4KPiBJbiB0aGF0IGNhc2Ugd2Ugc2hvdWxkIGJlIGFibGUgdG8gZGlzYWJsZSBpdCBhcyB3
ZWxsLiBEaXNhYmxlIHNob3VsZCB0YWtlIHRoZSBkZXZpY2Ugb2YgdGhlIGJ1cy4KPiBJIGZpbmQg
aXQgd2VpcmQgdG8gaGF2ZSB0aGlzIG1vZGVsIHRvIGxpbmdlciBhcm91bmQgdGhlIGRldmljZSB3
aXRob3V0IGFuY2hvcmluZyBvbiB0aGUgYnVzLgo+IEZvciBleGFtcGxlIGRldmljZSBpcyBub3Qg
eWV0IGVuYWJsZWQsIHNvIGl0IGlzIG5vdCBhbmNob3JlZCBvbiB0aGUgYnVzLCBidXQgaXRzIG5h
bWUgaXMgc3RpbGwgaGF2ZSB0byByZW1haW4gdW5pcXVlLgoKCkNhbiB3ZSBkbyBzb21lIHN5bmNo
b3JuaXphdGlvbiBiZXR3ZWVuIHZkcGEgZGV2aWNlIGFsbG9jYXRpb24gYW5kIHZkcGEgCmRldmlj
ZSByZWdpc3RpZXIgdG8gc29sdmUgdGhlIG5hbWluZyBpc3N1ZT8KCgo+Cj4gRG8gd2UgaGF2ZSB0
byBhbmNob3IgdmRwYSBkZXZpY2Ugb24gdGhlIGJ1cz8gQ2FuIHZkcGEgYmUgYSBjbGFzcz8KCgpJ
IHRoaW5rIG5vdCwgaXQncyBhIGJ1cyB0aGF0IGlzIGV4cGVjdGVkIHRvIGJlIGJvdW5kIHRvIGRp
ZmZlcmVudCBkcml2ZXIgCmluc3RlYWQgb2YgYSBzdWJzeXN0ZW0uCgpUaGFua3MKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

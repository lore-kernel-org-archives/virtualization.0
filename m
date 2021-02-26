Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDCC433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:26:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E4E64E28
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E4E64E28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF91B4EE8A;
	Fri, 26 Feb 2021 08:26:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hvo_lZ9Ge7mj; Fri, 26 Feb 2021 08:26:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2D7F4EDA6;
	Fri, 26 Feb 2021 08:26:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC58EC000A;
	Fri, 26 Feb 2021 08:26:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8D37C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F4F6840BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-6LqTeNG2Lg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:26:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8F6D683E66
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614327998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUrxrvONH4/EUPWeSCbVhUaNtr2WLSbpkD0Ra+8wDVg=;
 b=fShadM8zIjKTCoIHyRY1kfc6pciXW2GeZ1rLiGdPwaLVQ6WJ2udUrfjbx4HFjv7Xi+5/+t
 dUU7Rr4Jl8+K4Mbxz4g9B1sLHYih7xtwtAI84oIUGDk0vssiGyAAWa3XcdCqLW+ZTe/o/N
 +tmNNdQMITngHbIHbjt3Puwuyspb068=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-lw_CPvaFP-mtwT-kfYzZyQ-1; Fri, 26 Feb 2021 03:26:36 -0500
X-MC-Unique: lw_CPvaFP-mtwT-kfYzZyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C6A107ACE3;
 Fri, 26 Feb 2021 08:26:35 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-20.pek2.redhat.com
 [10.72.12.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70F0510016FF;
 Fri, 26 Feb 2021 08:26:30 +0000 (UTC)
Subject: Re: [PATCH linux-next 2/9] vdpa: Introduce query of device config
 layout
To: Parav Pandit <parav@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-3-parav@nvidia.com>
 <1a9f4f3c-4581-35cc-5d3a-1495bb00257a@redhat.com>
 <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bfb3a5d2-d335-c4f2-20cb-65d53fc4b216@redhat.com>
Date: Fri, 26 Feb 2021 16:26:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4322AF919B1BF71DA31C53FFDC9D9@BY5PR12MB4322.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjEvMi8yNiAxOjMyIOS4i+WNiCwgUGFyYXYgUGFuZGl0IHdyb3RlOgo+Cj4+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+IFNlbnQ6IFdlZG5lc2RheSwgRmVi
cnVhcnkgMjQsIDIwMjEgMjoxOCBQTQo+Pgo+PiBPbiAyMDIxLzIvMjQgMjoxOCDkuIvljYgsIFBh
cmF2IFBhbmRpdCB3cm90ZToKPj4+ICsKPj4+ICsJaWYgKG5sYV9wdXRfdTE2KG1zZywgVkRQQV9B
VFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVAsCj4+PiArCQkJY29uZmlnLT5tYXhfdmlydHF1ZXVlX3Bh
aXJzKSkKPj4+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4+Cj4+IFdlIHByb2JhYmx5IG5lZWQgdG8g
Y2hlY2sgVklSVElPX05FVF9GX1JTUyBoZXJlLgo+IFllcy4gV2lsbCB1c2UgaXQgaW4gdjIuCj4K
Pj4KPj4+ICsJaWYgKG5sYV9wdXRfdTgobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfUlNTX01B
WF9LRVlfTEVOLAo+Pj4gKwkJICAgICAgIGNvbmZpZy0+cnNzX21heF9rZXlfc2l6ZSkpCj4+PiAr
CQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4gKwo+Pj4gKwlyc3NfZmllbGQgPSBsZTE2X3RvX2NwdShj
b25maWctPnJzc19tYXhfa2V5X3NpemUpOwo+Pj4gKwlpZiAobmxhX3B1dF91MTYobXNnLCBWRFBB
X0FUVFJfREVWX05FVF9DRkdfUlNTX01BWF9JVF9MRU4sCj4+IHJzc19maWVsZCkpCj4+PiArCQly
ZXR1cm4gLUVNU0dTSVpFOwo+Pj4gKwo+Pj4gKwloYXNoX3R5cGVzID0gbGUzMl90b19jcHUoY29u
ZmlnLT5zdXBwb3J0ZWRfaGFzaF90eXBlcyk7Cj4+PiArCWlmIChubGFfcHV0X3UzMihtc2csIFZE
UEFfQVRUUl9ERVZfTkVUX0NGR19SU1NfSEFTSF9UWVBFUywKPj4+ICsJCQljb25maWctPnN1cHBv
cnRlZF9oYXNoX3R5cGVzKSkKPj4+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4+PiArCXJldHVybiAw
Owo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW50IHZkcGFfZGV2X25ldF9jb25maWdfZmlsbChz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdAo+Pj4gK3NrX2J1ZmYgKm1zZykgewo+Pj4g
KwlzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcgY29uZmlnID0ge307Cj4+PiArCj4+PiArCXZkZXYt
PmNvbmZpZy0+Z2V0X2NvbmZpZyh2ZGV2LCAwLCAmY29uZmlnLCBzaXplb2YoY29uZmlnKSk7Cj4+
Cj4+IERvIHdlIG5lZWQgdG8gc3luYyB3aXRoIG90aGVyIHBvc3NpYmxlIGdldF9jb25maWcgY2Fs
bHMgaGVyZT8KPiBUbyByZWFkZXJzIG9mIGdldF9jb25maWcoKSBpcyBvay4gTm8gbmVlZCB0byBz
eW5jLgo+IEhvd2V2ZXIsIEkgdGhpbmsgc2V0X2NvbmZpZygpIGFuZCBnZXRfY29uZmlnKCkgc2hv
dWxkIHN5bmMgb3RoZXJ3aXNlIGdldF9jb25maWcgY2FuIGdldCBwYXJ0aWFsIHZhbHVlLgo+IFdp
bGwgcHJvYmFibHkgaGF2ZSB0byBhZGQgdmRwYV9kZXZpY2UtPmNvbmZpZ19hY2Nlc3NfbG9jaygp
LgoKClByb2JhYmx5LiBBbmQgdGhlIHNldF9jb25maWcoKSBzaG91bGQgYmUgc3luY2hyb25pemVk
IHdpdGggdGhlIHJlcXVyZXN0IAp0aGF0IGNvbWVzIGZyb20gdkRQQSBidXMuIFRoaXMgbWFrZXMg
bWUgdGhpbmsgd2hldGhlciB3ZSBzaG91bGQgZ28gYmFjayAKdG8gdHdvIHBoYXNlcyBtZXRob2Qs
IGNyZWF0ZSBhbmQgZW5hYmxlLgoKVGhlIHZEUEEgZGV2aWNlIGlzIG9ubHkgcmVnaXN0cmVkIGFm
dGVyIGVuYWJsaW5nLCB0aGVuIHRoZXJlJ3Mgbm8gbmVlZCAKdG8gc3luYyB3aXRoIHZEUEEgYnVz
LCBhbmQgbWdtdCBpcyBub3QgYWxsb3dlZCB0byBjaGFuZ2UgY29uZmlnIGFmdGVyIAplbmFsYmlu
Zz8KCj4KPj4KPj4+ICsJaWYgKG5sYV9wdXQobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFD
QUREUiwKPj4gc2l6ZW9mKGNvbmZpZy5tYWMpLCBjb25maWcubWFjKSkKPj4+ICsJCXJldHVybiAt
RU1TR1NJWkU7Cj4+PiArCWlmIChubGFfcHV0X3UxNihtc2csIFZEUEFfQVRUUl9ERVZfTkVUX1NU
QVRVUywgY29uZmlnLnN0YXR1cykpCj4+PiArCQlyZXR1cm4gLUVNU0dTSVpFOwo+Pj4gKwlpZiAo
bmxhX3B1dF91MTYobXNnLCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTVRVLCBjb25maWcubXR1KSkK
Pj4+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4+Cj4+IEFuZCBjaGVjayBWSVJUSU9fTkVUX0ZfU1BF
RURfRFVQTEVYLgo+IFllcywgd2lsbCBkby4KPgo+Pgo+Pj4gKwlpZiAobmxhX3B1dF91MzIobXNn
LCBWRFBBX0FUVFJfREVWX05FVF9DRkdfU1BFRUQsCj4+IGNvbmZpZy5zcGVlZCkpCj4+PiArCQly
ZXR1cm4gLUVNU0dTSVpFOwo+Pj4gKwlpZiAobmxhX3B1dF91OChtc2csIFZEUEFfQVRUUl9ERVZf
TkVUX0NGR19EVVBMRVgsCj4+IGNvbmZpZy5kdXBsZXgpKQo+Pj4gKwkJcmV0dXJuIC1FTVNHU0la
RTsKPj4+ICsKPj4+ICsJcmV0dXJuIHZkcGFfZGV2X25ldF9tcV9jb25maWdfZmlsbCh2ZGV2LCBt
c2csICZjb25maWcpOyB9Cj4+PiArCj4+PiArc3RhdGljIGludAo+Pj4gK3ZkcGFfZGV2X2NvbmZp
Z19maWxsKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgc3RydWN0IHNrX2J1ZmYgKm1zZywgdTMy
Cj4+IHBvcnRpZCwgdTMyIHNlcSwKPj4+ICsJCSAgICAgaW50IGZsYWdzLCBzdHJ1Y3QgbmV0bGlu
a19leHRfYWNrICpleHRhY2spIHsKPj4+ICsJdTMyIGRldmljZV9pZDsKPj4+ICsJdm9pZCAqaGRy
Owo+Pj4gKwlpbnQgZXJyOwo+Pj4gKwo+Pj4gKwloZHIgPSBnZW5sbXNnX3B1dChtc2csIHBvcnRp
ZCwgc2VxLCAmdmRwYV9ubF9mYW1pbHksIGZsYWdzLAo+Pj4gKwkJCSAgVkRQQV9DTURfREVWX0NP
TkZJR19HRVQpOwo+Pj4gKwlpZiAoIWhkcikKPj4+ICsJCXJldHVybiAtRU1TR1NJWkU7Cj4+PiAr
Cj4+PiArCWlmIChubGFfcHV0X3N0cmluZyhtc2csIFZEUEFfQVRUUl9ERVZfTkFNRSwgZGV2X25h
bWUoJnZkZXYtCj4+PiBkZXYpKSkgewo+Pj4gKwkJZXJyID0gLUVNU0dTSVpFOwo+Pj4gKwkJZ290
byBtc2dfZXJyOwo+Pj4gKwl9Cj4+PiArCj4+PiArCWRldmljZV9pZCA9IHZkZXYtPmNvbmZpZy0+
Z2V0X2RldmljZV9pZCh2ZGV2KTsKPj4+ICsJaWYgKG5sYV9wdXRfdTMyKG1zZywgVkRQQV9BVFRS
X0RFVl9JRCwgZGV2aWNlX2lkKSkgewo+Pj4gKwkJZXJyID0gLUVNU0dTSVpFOwo+Pj4gKwkJZ290
byBtc2dfZXJyOwo+Pj4gKwl9Cj4+PiArCj4+PiArCXN3aXRjaCAoZGV2aWNlX2lkKSB7Cj4+PiAr
CWNhc2UgVklSVElPX0lEX05FVDoKPj4+ICsJCWVyciA9IHZkcGFfZGV2X25ldF9jb25maWdfZmls
bCh2ZGV2LCBtc2cpOwo+Pj4gKwkJYnJlYWs7Cj4+PiArCWRlZmF1bHQ6Cj4+PiArCQllcnIgPSAt
RU9QTk9UU1VQUDsKPj4+ICsJCWJyZWFrOwo+Pj4gKwl9Cj4+PiArCWlmIChlcnIpCj4+PiArCQln
b3RvIG1zZ19lcnI7Cj4+PiArCj4+PiArCWdlbmxtc2dfZW5kKG1zZywgaGRyKTsKPj4+ICsJcmV0
dXJuIDA7Cj4+PiArCj4+PiArbXNnX2VycjoKPj4+ICsJZ2VubG1zZ19jYW5jZWwobXNnLCBoZHIp
Owo+Pj4gKwlyZXR1cm4gZXJyOwo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW50IHZkcGFfbmxf
Y21kX2Rldl9jb25maWdfZ2V0X2RvaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwKPj4+ICtzdHJ1Y3Qg
Z2VubF9pbmZvICppbmZvKSB7Cj4+PiArCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRldjsKPj4+ICsJ
c3RydWN0IHNrX2J1ZmYgKm1zZzsKPj4+ICsJY29uc3QgY2hhciAqZGV2bmFtZTsKPj4+ICsJc3Ry
dWN0IGRldmljZSAqZGV2Owo+Pj4gKwlpbnQgZXJyOwo+Pj4gKwo+Pj4gKwlpZiAoIWluZm8tPmF0
dHJzW1ZEUEFfQVRUUl9ERVZfTkFNRV0pCj4+PiArCQlyZXR1cm4gLUVJTlZBTDsKPj4+ICsJZGV2
bmFtZSA9IG5sYV9kYXRhKGluZm8tPmF0dHJzW1ZEUEFfQVRUUl9ERVZfTkFNRV0pOwo+Pj4gKwlt
c2cgPSBubG1zZ19uZXcoTkxNU0dfREVGQVVMVF9TSVpFLCBHRlBfS0VSTkVMKTsKPj4+ICsJaWYg
KCFtc2cpCj4+PiArCQlyZXR1cm4gLUVOT01FTTsKPj4+ICsKPj4+ICsJbXV0ZXhfbG9jaygmdmRw
YV9kZXZfbXV0ZXgpOwo+Pj4gKwlkZXYgPSBidXNfZmluZF9kZXZpY2UoJnZkcGFfYnVzLCBOVUxM
LCBkZXZuYW1lLAo+PiB2ZHBhX25hbWVfbWF0Y2gpOwo+Pj4gKwlpZiAoIWRldikgewo+Pj4gKwkJ
TkxfU0VUX0VSUl9NU0dfTU9EKGluZm8tPmV4dGFjaywgImRldmljZSBub3QgZm91bmQiKTsKPj4+
ICsJCWVyciA9IC1FTk9ERVY7Cj4+PiArCQlnb3RvIGRldl9lcnI7Cj4+PiArCX0KPj4+ICsJdmRl
diA9IGNvbnRhaW5lcl9vZihkZXYsIHN0cnVjdCB2ZHBhX2RldmljZSwgZGV2KTsKPj4+ICsJaWYg
KCF2ZGV2LT5tZGV2KSB7Cj4+PiArCQlOTF9TRVRfRVJSX01TR19NT0QoaW5mby0+ZXh0YWNrLCAi
dW5tYW5hZ2VkIHZkcGEKPj4gZGV2aWNlIik7Cj4+PiArCQllcnIgPSAtRUlOVkFMOwo+Pj4gKwkJ
Z290byBtZGV2X2VycjsKPj4+ICsJfQo+Pgo+PiBUaG91Z2ggaXQncyBmaW5lIGJ1dCBpdCBsb29r
cyB0byBtZSBtZGV2IGlzIG5vdCByZXF1aXJlZCB0byB3b3JrIGhlcmUuCj4+Cj4gWWVzLCBtZGV2
IGlzIG5vdCByZXF1aXJlZCBoZXJlLiBIb3dldmVyIGl0IHdhcyBsaXR0bGUgd2VpcmQgdG8gYWxs
b3cgJCB2ZHBhIGRldiBjb25maWcgc2hvdywgYnV0IG5vdCBhbGxvdyAkIHZkcGEgZGV2IHNob3cu
Cj4gSXQgdHJhbnNpdGlvbiBwaGFzZSByaWdodCBub3cuIFN1YnNlcXVlbnRseSB3aWxsIGFibGUg
dG8gYWxsb3cgdGhpcyBhcyB3ZWxsLgo+IEFmdGVyIHRoaXMgc2VyaWVzIG9ubHkgaWZjIGRyaXZl
ciB3aWxsIGJlIGxlZnQgdG8gY29udmVydCB0byB1c2VyIGNyZWF0ZWQgZGV2aWNlcy4KPiBBdCB0
aGF0IHBvaW50LCB0aGlzIGNoZWNrcyB3aWxsIGhhdmUgY2hhbmNlIHRvIHNpbXBsaWZ5LgoKCkkg
YWdyZWUuCgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

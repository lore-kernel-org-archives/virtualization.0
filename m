Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C645C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:40:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DBA64FB3
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DBA64FB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 662E386E97;
	Fri,  5 Feb 2021 03:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7H2AZHAXE97C; Fri,  5 Feb 2021 03:40:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E40C86E84;
	Fri,  5 Feb 2021 03:40:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7165EC07FD;
	Fri,  5 Feb 2021 03:40:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F4DAC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 14DF7869E4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8LlBcJaibwOZ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:40:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 16FB8869DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612496448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxz2nycUsF5YazuV69jbv6bYyk/cSLKkrq0BMnX+Xss=;
 b=dnM4Mxf3F2n5+3GaP1BJmmLMVNk6zzAooL+HoCKqSkqRM5OLlXh+b+d+tTtJrOrZoi6w1z
 aPPyIqBsvbOsuCEob4nwqVyF8Prt079yK65tKqIfSOWwHNskHk92c87j0qTctpsMoUA8oZ
 7FD0FEMhQcjeYlAmsrP6G6gcaFwfqRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-yoJl2KvRPDWP6d1ltDfgvA-1; Thu, 04 Feb 2021 22:40:44 -0500
X-MC-Unique: yoJl2KvRPDWP6d1ltDfgvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ECF2801975;
 Fri,  5 Feb 2021 03:40:43 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C7F75D9D2;
 Fri,  5 Feb 2021 03:40:37 +0000 (UTC)
Subject: Re: [PATCH iproute2-next v3 0/5] Add vdpa device management tool
To: Adrian Moreno <amorenoz@redhat.com>, Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 dsahern@gmail.com, stephen@networkplumber.org, mst@redhat.com
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
 <99106d07-1730-6ed8-c847-0400be0dcd57@redhat.com>
 <1d1ff638-d498-6675-ead5-6e09213af3a8@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0017c3d7-9b04-d26c-94e2-485e4da6a778@redhat.com>
Date: Fri, 5 Feb 2021 11:40:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1d1ff638-d498-6675-ead5-6e09213af3a8@redhat.com>
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

Ck9uIDIwMjEvMi80IOS4i+WNiDc6MTUsIEFkcmlhbiBNb3Jlbm8gd3JvdGU6Cj4gU29ycnkgSSBo
YXZlIG5vdCBmb2xsb3dlZCB0aGlzIHdvcmsgYXMgY2xvc2UgYXMgSSB3b3VsZCBoYXZlIHdhbnRl
ZC4KPiBTb21lIHF1ZXN0aW9ucyBiZWxvdy4KPgo+IE9uIDIvNC8yMSA0OjE2IEFNLCBKYXNvbiBX
YW5nIHdyb3RlOgo+PiBPbiAyMDIxLzIvMiDkuIvljYg2OjM1LCBQYXJhdiBQYW5kaXQgd3JvdGU6
Cj4+PiBMaW51eCB2ZHBhIGludGVyZmFjZSBhbGxvd3MgdmRwYSBkZXZpY2UgbWFuYWdlbWVudCBm
dW5jdGlvbmFsaXR5Lgo+Pj4gVGhpcyBpbmNsdWRlcyBhZGRpbmcsIHJlbW92aW5nLCBxdWVyeWlu
ZyB2ZHBhIGRldmljZXMuCj4+Pgo+Pj4gdmRwYSBpbnRlcmZhY2UgYWxzbyBpbmNsdWRlcyBzaG93
aW5nIHN1cHBvcnRlZCBtYW5hZ2VtZW50IGRldmljZXMKPj4+IHdoaWNoIHN1cHBvcnQgc3VjaCBv
cGVyYXRpb25zLgo+Pj4KPj4+IFRoaXMgcGF0Y2hzZXQgaW5jbHVkZXMga2VybmVsIHVhcGkgaGVh
ZGVycyBhbmQgYSB2ZHBhIHRvb2wuCj4+Pgo+Pj4gZXhhbXBsZXM6Cj4+Pgo+Pj4gJCB2ZHBhIG1n
bXRkZXYgc2hvdwo+Pj4gdmRwYXNpbToKPj4+ICDCoMKgIHN1cHBvcnRlZF9jbGFzc2VzIG5ldAo+
Pj4KPj4+ICQgdmRwYSBtZ210ZGV2IHNob3cgLWpwCj4+PiB7Cj4+PiAgwqDCoMKgwqAgInNob3ci
OiB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoCAidmRwYXNpbSI6IHsKPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgInN1cHBvcnRlZF9jbGFzc2VzIjogWyAibmV0IiBdCj4+PiAgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4+PiAgwqDCoMKgwqAgfQo+Pj4gfQo+Pj4KPiBIb3cgY2FuIGEgdXNlciBlc3Rh
Ymxpc2ggdGhlIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIGEgbWdtdGRldiBhbmQgaXQncyBwYXJlbnQK
PiBkZXZpY2UgKHBjaSB2Ziwgc2YsIGV0Yyk/CgoKUGFyYXYgc2hvdWxkIGtub3cgbW9yZSBidXQg
SSB0cnkgdG8gYW5zd2VyLgoKSSB0aGluayB0aGVyZSBzaG91bGQgYmUgQkRGIGluZm9ybWF0aW9u
IGluIHRoZSBtZ210ZGV2IHNob3cgY29tbWFuZCBpZiAKdGhlIHBhcmVudCBpcyBhIFBDSSBkZXZp
Y2UsIG9yIHdlIGNhbiBzaW1wbHkgc2hvdyB0aGUgcGFyZW50IGhlcmU/CgoKPgo+Pj4gQ3JlYXRl
IGEgdmRwYSBkZXZpY2Ugb2YgdHlwZSBuZXR3b3JraW5nIG5hbWVkIGFzICJmb28yIiBmcm9tCj4+
PiB0aGUgbWFuYWdlbWVudCBkZXZpY2UgdmRwYXNpbV9uZXQ6Cj4+Pgo+Pj4gJCB2ZHBhIGRldiBh
ZGQgbWdtdGRldiB2ZHBhc2ltX25ldCBuYW1lIGZvbzIKPj4+Cj4gSSBndWVzcyB0aGlzIGNvbW1h
bmQgd2lsbCBhY2NlcHQgYSAndHlwZScgcGFyYW1ldGVyIG9uY2UgbW9yZSBzdXBwb3J0ZWRfY2xh
c3Nlcwo+IGFyZSBhZGRlZD8KCgpUaGlzIGNvdWxkIGJlIGV4dGVuZGVkIGluIHRoZSBmdXR1cmUu
CgoKPgo+IEFsc28sIHdpbGwgdGhpcyB0b29sIGFsc28gaGFuZGxlIHRoZSB2ZHBhIGRyaXZlciBi
aW5kaW5nIG9yIHdpbGwgdGhlIHVzZXIgaGFuZGxlCj4gdGhhdCB0aHJvdWdoIHRoZSB2ZHBhIGJ1
cycgc3lzZnMgaW50ZXJmYWNlPwoKCkkgdGhpbmsgbm90LCBpdCdzIHRoZSBjb25maWd1cmF0aW9u
IGJlbG93IHRoZSB2ZHBhIGJ1cy4gVGhlIHN5c2ZzIHNob3VsZCAKYmUgdGhlIG9ubHkgaW50ZXJm
YWNlIGZvciBtYW5hZ2luZyBkcml2ZXIgYmluZGluZy4KClRoYW5rcwoKCj4KPj4+IFNob3cgdGhl
IG5ld2x5IGNyZWF0ZWQgdmRwYSBkZXZpY2UgYnkgaXRzIG5hbWU6Cj4+PiAkIHZkcGEgZGV2IHNo
b3cgZm9vMgo+Pj4gZm9vMjogdHlwZSBuZXR3b3JrIG1nbXRkZXYgdmRwYXNpbV9uZXQgdmVuZG9y
X2lkIDAgbWF4X3ZxcyAyIG1heF92cV9zaXplIDI1Ngo+Pj4KPj4+ICQgdmRwYSBkZXYgc2hvdyBm
b28yIC1qcAo+Pj4gewo+Pj4gIMKgwqDCoMKgICJkZXYiOiB7Cj4+PiAgwqDCoMKgwqDCoMKgwqDC
oCAiZm9vMiI6IHsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInR5cGUiOiAibmV0d29y
ayIsCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtZ210ZGV2IjogInZkcGFzaW1fbmV0
IiwKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgInZlbmRvcl9pZCI6IDAsCj4+PiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtYXhfdnFzIjogMiwKPj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgIm1heF92cV9zaXplIjogMjU2Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiAg
wqDCoMKgwqAgfQo+Pj4gfQo+Pj4KPj4+IERlbGV0ZSB0aGUgdmRwYSBkZXZpY2UgYWZ0ZXIgaXRz
IHVzZToKPj4+ICQgdmRwYSBkZXYgZGVsIGZvbzIKPj4+Cj4+PiBQYXRjaCBzdW1tYXJ5Ogo+Pj4g
UGF0Y2gtMSBhZGRzIGtlcm5lbCBoZWFkZXJzIGZvciB2ZHBhIHN1YnN5c3RlbQo+Pj4gUGF0Y2gt
MiBhZGRzIGxpYnJhcnkgcm91dGluZXMgZm9yIGluZGVudCBoYW5kbGluZwo+Pj4gUGF0Y2gtMyBh
ZGRzIGxpYnJhcnkgcm91dGluZXMgZm9yIGdlbmVyaWMgc29ja2V0IGNvbW11bmljYXRpb24KPj4+
IFBBdGNoLTQgYWRkcyBsaWJyYXJ5IHJvdXRpbmUgZm9yIG51bWJlciB0byBzdHJpbmcgbWFwcGlu
Zwo+Pj4gUGF0Y2gtNSBhZGRzIHZkcGEgdG9vbAo+Pj4KPj4+IEtlcm5lbCBoZWFkZXJzIGFyZSBm
cm9tIHRoZSB2aG9zdCBrZXJuZWwgdHJlZSBbMV0gZnJvbSBicmFuY2ggbGludXgtbmV4dC4KPj4+
Cj4+PiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQv
bXN0L3Zob3N0LmdpdAo+Pj4KPj4+IC0tLQo+Pgo+PiBBZGRpbmcgQWRyaWFuIHRvIHNlZSBpZiB0
aGlzIGxvb2tzIGdvb2QgZm9yIGs4cyBpbnRlZ3JhdGlvbi4KPj4KPj4gVGhhbmtzCj4+Cj4gVGhh
bmtzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=

Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B905C5519F
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 04:10:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A725420729
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 04:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLdSavt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A725420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08FDA8476C;
	Wed, 18 Nov 2020 04:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vU5yVBJLyR1p; Wed, 18 Nov 2020 04:10:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D35DC843E6;
	Wed, 18 Nov 2020 04:10:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0431C0891;
	Wed, 18 Nov 2020 04:10:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CFA3C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:10:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 841E68476C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5i0gCVeTzUhZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:10:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A9BD8843E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 04:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605672611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gc+JivW05LoBOHuQhdw4IUx2HV0L3zkO2d96GO3Ygvw=;
 b=ZLdSavt4Wh3fZ17Yl3nyqmKckIhHl+vazcekVaZdCRddpf0lKs7q1zM3bLZ/nW+OtE2P+W
 B2Ap9KW/Ko2ma+w/Q+HMZYgyth5vX5mdrmX3mg6+RFtKvO0wgYnGvHg/Lf4kRe9QcYGJTx
 kaKjVqqeKaz/RoRbvok9Py7KPARh9do=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-nM_Sl-Y-OIGpsrQa_Lwy9A-1; Tue, 17 Nov 2020 23:10:09 -0500
X-MC-Unique: nM_Sl-Y-OIGpsrQa_Lwy9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B47B11882FAA;
 Wed, 18 Nov 2020 04:10:07 +0000 (UTC)
Received: from [10.72.13.172] (ovpn-13-172.pek2.redhat.com [10.72.13.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F96D5C1A3;
 Wed, 18 Nov 2020 04:10:00 +0000 (UTC)
Subject: Re: netconsole deadlock with virtnet
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
Date: Wed, 18 Nov 2020 12:09:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Ran Rozenstein <ranro@nvidia.com>,
 Itay Aveksis <itayav@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTgg5LiK5Y2IMTE6MTUsIFNlcmdleSBTZW5vemhhdHNreSB3cm90ZToKPiBP
biAoMjAvMTEvMTggMTE6NDYpLCBTZXJnZXkgU2Vub3poYXRza3kgd3JvdGU6Cj4gWy4uXQo+Pj4g
QmVjYXVzZSBJJ20gbm90IHN1cmUgd2hlcmUgdGhlIHhtaXRfbG9jayBpcyB0YWtlbiB3aGlsZSBo
b2xkaW5nIHRoZQo+Pj4gdGFyZ2V0X2xpc3RfbG9jay4KPj4gSSBkb24ndCBzZWUgd2hlcmUgZG9l
cyB0aGlzIGhhcHBlbi4gSXQgc2VlbXMgdG8gbWUgdGhhdCB0aGUgcmVwb3J0Cj4+IGlzIG5vdCBh
Ym91dCBicm9rZW4gbG9ja2luZyBvcmRlciwgYnV0IG1vcmUgYWJvdXQ6Cj4+IC0gc29mdC1pcnEg
Y2FuIGJlIHByZWVtcHRlZCAod2hpbGUgaG9sZGluZyBfeG1pdF9sb2NrKSBieSBhIGhhcmR3YXJl
Cj4+ICAgIGludGVycnVwdCwgdGhhdCB3aWxsIGF0dGVtcHQgdG8gYWNxdWlyZSB0aGUgc2FtZSBf
eG1pdF9sb2NrIGxvY2suCj4+Cj4+ICAgICBDUFUwCj4+ICAgICA8PHNvZnQgSVJRPj4KPj4gICAg
ICB2aXJ0bmV0X3BvbGxfdHgoKQo+PiAgICAgICBfX25ldGlmX3R4X2xvY2soKQo+PiAgICAgICAg
c3Bpbl9sb2NrKF94bWl0X2xvY2spCj4+ICAgICA8PGhhcmQgSVJRPj4KPj4gICAgICBhZGRfaW50
ZXJydXB0X3JhbmRvbW5lc3MoKQo+PiAgICAgICBjcm5nX2Zhc3RfbG9hZCgpCj4+ICAgICAgICBw
cmludGsoKQo+PiAgICAgICAgIGNhbGxfY29uc29sZV9kcml2ZXJzKCkKPj4gICAgICAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJnRhcmdldF9saXN0X2xvY2spCj4+IAkgc3Bpbl9sb2NrKF94bWl0X2xv
Y2spOwo+Pgo+PiBEb2VzIHRoaXMgbWFrZSBzZW5zZT8KPiBIbW0sIGxvY2tkZXAgc2F5cyBzb21l
dGhpbmcgc2ltaWxhciwgYnV0IHRoZXJlIGFyZSAyIHByaW50aygpCj4gaGFwcGVuaW5nIC0gYm90
aCBvbiBsb2NhbCBhbmQgcmVtb3RlIENQVXMuCj4KPiBbICAgMjEuMTQ5NTY0XSAgICAgICAgQ1BV
MCAgICAgICAgICAgICAgICAgICAgQ1BVMQo+IFsgICAyMS4xNDk1NjVdICAgICAgICAtLS0tICAg
ICAgICAgICAgICAgICAgICAtLS0tCj4gWyAgIDIxLjE0OTU2Nl0gICBsb2NrKF94bWl0X0VUSEVS
IzIpOwo+IFsgICAyMS4xNDk1NjldICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2Nh
bF9pcnFfZGlzYWJsZSgpOwo+IFsgICAyMS4xNDk1NzBdICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBsb2NrKGNvbnNvbGVfb3duZXIpOwo+IFsgICAyMS4xNDk1NzJdICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBsb2NrKHRhcmdldF9saXN0X2xvY2spOwo+IFsgICAyMS4xNDk1
NzVdICAgPEludGVycnVwdD4KPiBbICAgMjEuMTQ5NTc2XSAgICAgbG9jayhjb25zb2xlX293bmVy
KTsKPgo+IFRoaXMgQ1BVMCBsb2NrKF94bWl0X0VUSEVSIzIpIC0+IGhhcmQgSVJRIC0+IGxvY2so
Y29uc29sZV9vd25lcikgaXMKPiBiYXNpY2FsbHkKPiAJc29mdCBJUlEgLT4gbG9jayhfeG1pdF9F
VEhFUiMyKSAtPiBoYXJkIElSUSAtPiBwcmludGsoKQo+Cj4gVGhlbiBDUFUxIHNwaW5zIG9uIHht
aXQsIHdoaWNoIGlzIG93bmVkIGJ5IENQVTAsIENQVTAgc3BpbnMgb24KPiBjb25zb2xlX293bmVy
LCB3aGljaCBpcyBvd25lZCBieSBDUFUxPwoKCklmIHRoaXMgaXMgdHJ1ZSwgaXQgbG9va3Mgbm90
IGEgdmlydGlvLW5ldCBzcGVjaWZpYyBpc3N1ZSBidXQgc29tZXdoZXJlIAplbHNlLgoKSSB0aGlu
ayBhbGwgbmV0d29yayBkcml2ZXIgd2lsbCBzeW5jaHJvbml6ZSB0aHJvdWdoIGJoIGluc3RlYWQg
b2YgaGFyZGlycS4KClRoYW5rcwoKCj4KPiBBIHF1aWNrLWFuZC1kaXJ0eSBpZGVhIChpdCBkb2Vz
bid0IGZpeCB0aGUgbG9ja2RlcCByZXBvcnQpIC0gY2FuIHdlCj4gYWRkIHNvbWUgc29ydCBvZiBt
YXhfbG9vcHMgdmFyaWFibGUgdG8gY29uc29sZV90cnlsb2NrX3NwaW5uaW5nKCksCj4gc28gdGhh
dCBpdCB3aWxsIG5vdCBzcGluIGZvcmV2ZXIgaW4gYHdoaWxlIChSRUFEX09OQ0UoY29uc29sZV93
YWl0ZXIpKWAKPiB3YWl0aW5nIGZvciBhIGNvbnNvbGVfb3duZXIgdG8gcGFzcyB0aGUgbG9jaz8K
Pgo+IAktc3MKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

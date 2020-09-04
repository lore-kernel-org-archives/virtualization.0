Return-Path: <SRS0=He06=CN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB04DC43461
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 03:39:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E6B206EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Sep 2020 03:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aof63v4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E6B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 45B382E0ED;
	Fri,  4 Sep 2020 03:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jss+CyVZ3Kje; Fri,  4 Sep 2020 03:39:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B0643228A0;
	Fri,  4 Sep 2020 03:39:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C134C0890;
	Fri,  4 Sep 2020 03:39:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90BC4C0052
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 03:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 86078874E3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 03:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7ArKobUUDSM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 03:39:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9436B874CB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 03:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599190745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EyAiC4eZwNkau3Y8SAq/5Z+4k7VTrQOqY9EtVuiJLAo=;
 b=Aof63v4xlpiRCPZT7F1SyK/5mNrUhbbZWkvbiwnCfc0BrfeqiD5wBSnzizCJzeF4gSw4jG
 mxjsY5fjZx9cVaXgfEPrOg2v/8HdOs1TmRltWyhVd20Ax5AuEFf8RwZTywb4bgOP0tjvaz
 GTDSsbOvXrUAqP4L9mD7pftejEN5u4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-O7FrjF36NT6sUEUv99XNOw-1; Thu, 03 Sep 2020 23:39:00 -0400
X-MC-Unique: O7FrjF36NT6sUEUv99XNOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A117B807344;
 Fri,  4 Sep 2020 03:38:57 +0000 (UTC)
Received: from [10.72.13.157] (ovpn-13-157.pek2.redhat.com [10.72.13.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14FFC7EEBB;
 Fri,  4 Sep 2020 03:38:46 +0000 (UTC)
Subject: Re: [PATCH] i2c: virtio: add a virtio i2c frontend driver
To: Jie Deng <jie.deng@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <0efc2605c8c06b4b1bf68cbad5536c4a900dc019.1599110284.git.jie.deng@intel.com>
 <f3ab5d7d-cce5-b34c-5931-dd5d74f065e7@redhat.com>
 <6517879c-15d4-6265-761c-626cba9c95d6@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <009d829d-907d-8884-ca71-00f78e9d6e2b@redhat.com>
Date: Fri, 4 Sep 2020 11:38:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6517879c-15d4-6265-761c-626cba9c95d6@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, yu1.wang@intel.com, mst@redhat.com, krzk@kernel.org,
 tali.perry1@gmail.com, wsa@kernel.org, wsa+renesas@sang-engineering.com,
 jarkko.nikula@linux.intel.com, rppt@kernel.org, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com, jdelvare@suse.de
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

Ck9uIDIwMjAvOS8zIOS4i+WNiDM6MTksIEppZSBEZW5nIHdyb3RlOgo+Cj4gT24gMjAyMC85LzMg
MTQ6MTIsIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjAvOS8zIOS4i+WNiDE6MzQsIEpp
ZSBEZW5nIHdyb3RlOgo+Pj4gQWRkIGFuIEkyQyBidXMgZHJpdmVyIGZvciB2aXJ0aW8gcGFyYS12
aXJ0dWFsaXphdGlvbi4KPj4+Cj4+PiBUaGUgY29udHJvbGxlciBjYW4gYmUgZW11bGF0ZWQgYnkg
dGhlIGJhY2tlbmQgZHJpdmVyIGluCj4+PiBhbnkgZGV2aWNlIG1vZGVsIHNvZnR3YXJlIGJ5IGZv
bGxvd2luZyB0aGUgdmlydGlvIHByb3RvY29sLgo+Pj4KPj4+IFRoaXMgZHJpdmVyIGNvbW11bmlj
YXRlcyB3aXRoIHRoZSBiYWNrZW5kIGRyaXZlciB0aHJvdWdoIGEKPj4+IHZpcnRpbyBJMkMgbWVz
c2FnZSBzdHJ1Y3R1cmUgd2hpY2ggaW5jbHVkZXMgZm9sbG93aW5nIHBhcnRzOgo+Pj4KPj4+IC0g
SGVhZGVyOiBpMmNfbXNnIGFkZHIsIGZsYWdzLCBsZW4uCj4+PiAtIERhdGEgYnVmZmVyOiB0aGUg
cG9pbnRlciB0byB0aGUgaTJjIG1zZyBkYXRhLgo+Pj4gLSBTdGF0dXM6IHRoZSBwcm9jZXNzaW5n
IHJlc3VsdCBmcm9tIHRoZSBiYWNrZW5kLgo+Pj4KPj4+IFBlb3BsZSBtYXkgaW1wbGVtZW50IGRp
ZmZlcmVudCBiYWNrZW5kIGRyaXZlcnMgdG8gZW11bGF0ZQo+Pj4gZGlmZmVyZW50IGNvbnRyb2xs
ZXJzIGFjY29yZGluZyB0byB0aGVpciBuZWVkcy4gQSBiYWNrZW5kCj4+PiBleGFtcGxlIGNhbiBi
ZSBmb3VuZCBpbiB0aGUgZGV2aWNlIG1vZGVsIG9mIHRoZSBvcGVuIHNvdXJjZQo+Pj4gcHJvamVj
dCBBQ1JOLiBGb3IgbW9yZSBpbmZvcm1hdGlvbiwgcGxlYXNlIHJlZmVyIHRvCj4+PiBodHRwczov
L3Byb2plY3RhY3JuLm9yZy4KPj4KPj4KPj4gTWF5IEkga25vdyB0aGUgcmVhc29uIHdoeSBkb24n
dCB5b3UgdXNlIGkyYyBvciB2aXJ0aW8gZGlyZWN0bHk/Cj4+Cj4gV2UgZG9uJ3Qgd2FudCB0byBh
ZGQgdmlydGlvIGRyaXZlcnMgZm9yIGV2ZXJ5IEkyQyBkZXZpY2VzIGluIHRoZSBndWVzdHMuCj4g
VGhpcyBidXMgZHJpdmVyIGlzIGRlc2lnbmVkIHRvIHByb3ZpZGUgYSB3YXkgdG8gZmxleGlibHkg
ZXhwb3NlIHRoZSAKPiBwaHlzaWNhbAo+IEkyQyBzbGF2ZSBkZXZpY2VzIHRvIHRoZSBndWVzdCB3
aXRob3V0IGFkZGluZyBvciBjaGFuZ2luZyB0aGUgZHJpdmVycyAKPiBvZiB0aGUKPiBJMkMgc2xh
dmUgZGV2aWNlcyBpbiB0aGUgZ3Vlc3QgT1MuCgoKT2ssIGlmIEkgdW5kZXJzdGFuZCB0aGlzIGNv
cnJlY3RseSwgdGhpcyBpcyB2aXJ0aW8gdHJhbnNwb3J0IG9mIGkyYyAKbWVzc2FnZSAoc2ltaWxh
ciB0byB2aXJ0aW8tc2NzaSkuCgoKPgo+Cj4+Cj4+Pgo+Pj4gVGhlIHZpcnRpbyBkZXZpY2UgSUQg
MzQgaXMgdXNlZCBmb3IgdGhpcyBJMkMgYWRwdGVyIHNpbmNlIElEcwo+Pj4gYmVmb3JlIDM0IGhh
dmUgYmVlbiByZXNlcnZlZCBieSBvdGhlciB2aXJ0aW8gZGV2aWNlcy4KPj4KPj4KPj4gSXMgdGhl
cmUgYSBsaW5rIHRvIHRoZSBzcGVjIHBhdGNoPwo+Pgo+PiBUaGFua3MKPj4KPiBJIGhhdmVuJ3Qg
c3VibWl0dGVkIHRoZSBwYXRjaCB0byByZXNlcnZlIHRoZSBJRCBpbiBzcGVjIHlldC4KPiBJIHdy
aXRlIHRoZSBJRCBoZXJlIGJlY2F1c2UgSSB3YW50IHRvIHNlZSB5b3VyIG9waW5pb25zIGZpcnN0
LgoKCkl0IHdvdWxkIGJlIGhlbHBmdWwgdG8gc2VuZCBhIHNwZWMgZHJhZnQgZm9yIGVhcmx5IHJl
dmlldy4KClRoYW5rcwoKCj4KPiBUaGFua3MKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

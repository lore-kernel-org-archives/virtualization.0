Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9AC5519F
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 06:22:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E268020BED
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 06:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+d1VFAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E268020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 397EC87369;
	Wed, 25 Nov 2020 06:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5I5ta+ugL+I; Wed, 25 Nov 2020 06:22:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 80DA687364;
	Wed, 25 Nov 2020 06:22:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7850CC0891;
	Wed, 25 Nov 2020 06:22:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6252EC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 556682046E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NhywO+m7x1ip
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 4058B1FB6B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 06:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606285331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSLDibXdDhyTDavCf11nSYFrrSbOyY/Z0MxYwfAK1NU=;
 b=d+d1VFAEv/L148ZtiOn+bciJVCDjFlqZjv8sG5do+OSMAknfkC8w3+dey8fQDV+doAjeBt
 eDNrD4bIcWnt7sjnBBHL6z2WfCeYHLvuXlMaLJAIBAeCb5QtoN/+DR89TRAAIsq7OQAsAL
 2U2OdG03IX3Ck+7d4ZQKP6Zi4RubeqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-caX8nhwhOEiiRcw5KnoPAQ-1; Wed, 25 Nov 2020 01:22:06 -0500
X-MC-Unique: caX8nhwhOEiiRcw5KnoPAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C346E8A2A22;
 Wed, 25 Nov 2020 06:21:44 +0000 (UTC)
Received: from [10.72.13.165] (ovpn-13-165.pek2.redhat.com [10.72.13.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D6485B4AE;
 Wed, 25 Nov 2020 06:21:13 +0000 (UTC)
Subject: Re: netconsole deadlock with virtnet
To: Jakub Kicinski <kuba@kernel.org>
References: <20201117102341.GR47002@unreal>
 <20201117093325.78f1486d@gandalf.local.home>
 <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home> <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201123140934.38748be3@gandalf.local.home>
 <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
 <20201124082035.3e658fa4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6e55048e-53ed-c196-729d-f7a5ab3c82fe@redhat.com>
Date: Wed, 25 Nov 2020 14:21:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201124082035.3e658fa4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, Amit Shah <amit@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjUg5LiK5Y2IMTI6MjAsIEpha3ViIEtpY2luc2tpIHdyb3RlOgo+IE9uIFR1
ZSwgMjQgTm92IDIwMjAgMTE6MjI6MDMgKzA4MDAgSmFzb24gV2FuZyB3cm90ZToKPj4+PiBQZXJo
YXBzIHlvdSBuZWVkIHRoZSB0cnlsb2NrIGluIHZpcnRuZXRfcG9sbF90eCgpPwo+Pj4gVGhhdCBj
b3VsZCB3b3JrLiBCZXN0IGlmIHdlIHVzZWQgbm9ybWFsIGxvY2sgaWYgISFidWRnZXQsIGFuZCB0
cnlsb2NrCj4+PiB3aGVuIGJ1ZGdldCBpcyAwLiBCdXQgbWF5YmUgdGhhdCdzIHRvbyBoYWlyeS4K
Pj4gSWYgd2UgdXNlIHRyeWxvY2ssIHdlIHByb2JhYmx5IGxvc2Uob3IgZGVsYXkpIHR4IG5vdGlm
aWNhdGlvbiB0aGF0IG1heQo+PiBoYXZlIHNpZGUgZWZmZWN0cyB0byB0aGUgc3RhY2suCj4gVGhh
dCdzIHdoeSBJIHNhaWQgb25seSB0cnlsb2NrIHdpdGggYnVkZ2V0ID09IDAuIE9ubHkgbmV0cG9s
bCBjYWxscyB3aXRoCj4gYnVkZ2V0ID09IDAsIEFGQUlLLgoKCk9oIHJpZ2h0LgoKU28gSSB0aGlu
ayBtYXliZSB3ZSBjYW4gc3dpdGNoIHRvIHVzZSB0cnlsb2NrIHdoZW4gYnVkZ2V0IGlzIHplcm8g
YW5kIAp0cnkgdG8gc2NoZWR1bGUgYW5vdGhlciBUWCBOQVBJIGlmIHdlIHRyeWxvY2sgZmFpbC4K
Cgo+Cj4+PiBJJ20gYXNzdW1pbmcgYWxsIHRoaXMgdHJpY2tpbmVzcyBjb21lcyBmcm9tIHZpcnRx
dWV1ZV9nZXRfYnVmKCkgbmVlZGluZwo+Pj4gbG9ja2luZyB2cyB0aGUgVFggcGF0aD8gSXQncyBw
cmV0dHkgdW51c3VhbCBmb3IgdGhlIGNvbXBsZXRpb24gcGF0aCB0bwo+Pj4gbmVlZCBsb2NraW5n
IHZzIHhtaXQgcGF0aC4KPj4gVHdvIHJlYXNvbnMgZm9yIGRvaW5nIHRoaXM6Cj4+Cj4+IDEpIEZv
ciBzb21lIGhpc3RvcmljYWwgcmVhc29uLCB3ZSB0cnkgdG8gZnJlZSB0cmFuc21pdHRlZCB0eCBw
YWNrZXRzIGluCj4+IHhtaXQgKHNlZSBmcmVlX29sZF94bWl0X3NrYnMoKSBpbiBzdGFydF94bWl0
KCkpLCB3ZSBjYW4gcHJvYmFibHkgcmVtb3ZlCj4+IHRoaXMgaWYgd2UgcmVtb3ZlIHRoZSBub24g
dHggaW50ZXJydXB0IG1vZGUuCj4+IDIpIHZpcnRpbyBjb3JlIHJlcXVpcmVzIHZpcnRxdWV1ZV9n
ZXRfYnVmKCkgdG8gYmUgc3luY2hyb25pemVkIHdpdGgKPj4gdmlydHF1ZXVlX2FkZCgpLCB3ZSBw
cm9iYWJseSBjYW4gc29sdmUgdGhpcyBidXQgaXQgcmVxdWlyZXMgc29tZSBub24KPj4gdHJpdmlh
bCByZWZhY3RvcmluZyBpbiB0aGUgdmlydGlvIGNvcmUKPj4KPj4gQnR3LCBoYXZlIGEgcXVpY2sg
c2VhcmNoLCB0aGVyZSBhcmUgc2V2ZXJhbCBvdGhlciBkcml2ZXJzIHRoYXQgdXNlcyB0eAo+PiBs
b2NrIGluIHRoZSB0eCBOQVBJLgo+IFVubGVzcyB0aGV5IGRvOgo+Cj4gCW5ldGRldi0+cHJpdl9m
bGFncyB8PSBJRkZfRElTQUJMRV9ORVRQT0xMOwo+Cj4gdGhleSBhcmUgYWxsIGJyb2tlbi4KCgpZ
ZXMuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

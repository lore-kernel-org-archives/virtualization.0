Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B652C56201
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 08:57:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014C22073C
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 08:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eD7NCZxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014C22073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C29B8710B;
	Tue, 24 Nov 2020 08:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CyxR8TgLdq16; Tue, 24 Nov 2020 08:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 07EED8707F;
	Tue, 24 Nov 2020 08:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D976CC163C;
	Tue, 24 Nov 2020 08:57:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D713C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5056A85135
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7x_ZqgsxyRv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AE4A2844D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606208258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJwIP3nSo2Uj/Swvhl1TAV1Y63wZ0HYh6rGKpKJBlYE=;
 b=eD7NCZxbmxC7qf1Spt8mQGCl/9DGZLhTvK8ATAzecjPZrCzPARWpVdKhumZXRYy1PiXatM
 fGtfS+4r7qKilSzBJJXNwxNeypoi7XUvmmhWwqt37b02icgYCcnyUaVqpJvznQMzL9v4z3
 ZnJZCj17+ff4vnnRQWhM1jl2YZL0gKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-AYv1W39-MCqm9Pn8IDBYPw-1; Tue, 24 Nov 2020 03:57:34 -0500
X-MC-Unique: AYv1W39-MCqm9Pn8IDBYPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8383A0BD4;
 Tue, 24 Nov 2020 08:57:31 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D64160C13;
 Tue, 24 Nov 2020 08:57:24 +0000 (UTC)
Subject: Re: netconsole deadlock with virtnet
To: Leon Romanovsky <leon@kernel.org>
References: <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home> <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201123140934.38748be3@gandalf.local.home>
 <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
 <20201124080152.GG3159@unreal>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6f046c51-cdcc-77f9-4859-2508d08126f8@redhat.com>
Date: Tue, 24 Nov 2020 16:57:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201124080152.GG3159@unreal>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev <netdev@vger.kernel.org>,
 Amit Shah <amit@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Ran Rozenstein <ranro@nvidia.com>, Itay Aveksis <itayav@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
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

Ck9uIDIwMjAvMTEvMjQg5LiL5Y2INDowMSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOgo+IE9uIFR1
ZSwgTm92IDI0LCAyMDIwIGF0IDExOjIyOjAzQU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IE9uIDIwMjAvMTEvMjQg5LiK5Y2IMzoyMSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6Cj4+PiBPbiBN
b24sIDIzIE5vdiAyMDIwIDE0OjA5OjM0IC0wNTAwIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+Pj4+
IE9uIE1vbiwgMjMgTm92IDIwMjAgMTA6NTI6NTIgLTA4MDAKPj4+PiBKYWt1YiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPiB3cm90ZToKPj4+Pgo+Pj4+PiBPbiBNb24sIDIzIE5vdiAyMDIwIDA5
OjMxOjI4IC0wNTAwIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCAyMyBOb3Yg
MjAyMCAxMzowODo1NSArMDIwMAo+Pj4+Pj4gTGVvbiBSb21hbm92c2t5IDxsZW9uQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+PiAgICBbICAgMTAuMDI4MDI0XSBDaGFpbiBleGlzdHMg
b2Y6Cj4+Pj4+Pj4gICAgWyAgIDEwLjAyODAyNV0gICBjb25zb2xlX293bmVyIC0tPiB0YXJnZXRf
bGlzdF9sb2NrIC0tPiBfeG1pdF9FVEhFUiMyCj4+Pj4+PiBOb3RlLCB0aGUgcHJvYmxlbSBpcyB0
aGF0IHdlIGhhdmUgYSBsb2NhdGlvbiB0aGF0IGdyYWJzIHRoZSB4bWl0X2xvY2sgd2hpbGUKPj4+
Pj4+IGhvbGRpbmcgdGFyZ2V0X2xpc3RfbG9jayAoYW5kIHBvc3NpYmx5IGNvbnNvbGVfb3duZXIp
Lgo+Pj4+PiBXZWxsLCBpdCB0cnlfbG9ja3MgdGhlIHhtaXRfbG9jay4gRG9lcyBsb2NrZGVwIHVu
ZGVyc3RhbmQgdHJ5LWxvY2tzPwo+Pj4+Pgo+Pj4+PiAobm90IHRoYXQgSSBjb25kb25lIHRoZSBz
aGVuYW5pZ2FucyB0aGF0IGFyZSBnb2luZyBvbiBoZXJlKQo+Pj4+IERvZXMgaXQ/Cj4+Pj4KPj4+
PiAJdmlydG5ldF9wb2xsX3R4KCkgewo+Pj4+IAkJX19uZXRpZl90eF9sb2NrKCkgewo+Pj4+IAkJ
CXNwaW5fbG9jaygmdHhxLT5feG1pdF9sb2NrKTsKPj4+IFVtcGYuIFJpZ2h0LiBJIHdhcyBsb29r
aW5nIGF0IHZpcnRuZXRfcG9sbF9jbGVhbnR4KCkKPj4+Cj4+Pj4gVGhhdCBsb29rcyBsaWtlIHdl
IGNhbiBoYXZlOgo+Pj4+Cj4+Pj4KPj4+PiAJQ1BVMAkJQ1BVMQo+Pj4+IAktLS0tCQktLS0tCj4+
Pj4gICAgICBsb2NrKHhtaXRfbG9jaykKPj4+Pgo+Pj4+IAkJICAgIGxvY2soY29uc29sZSkKPj4+
PiAJCSAgICBsb2NrKHRhcmdldF9saXN0X2xvY2spCj4+Pj4gCQkgICAgX19uZXRpZl90eF9sb2Nr
KCkKPj4+PiAJCSAgICAgICAgbG9jayh4bWl0X2xvY2spOwo+Pj4+Cj4+Pj4gCQkJW0JMT0NLRURd
Cj4+Pj4KPj4+PiAgICAgIDxpbnRlcnJ1cHQ+Cj4+Pj4gICAgICBsb2NrKGNvbnNvbGUpCj4+Pj4K
Pj4+PiAgICAgIFtCTE9DS0VEXQo+Pj4+Cj4+Pj4KPj4+Pgo+Pj4+ICAgIERFQURMT0NLLgo+Pj4+
Cj4+Pj4KPj4+PiBTbyB3aGVyZSBpcyB0aGUgdHJ5bG9jayBoZXJlPwo+Pj4+Cj4+Pj4gUGVyaGFw
cyB5b3UgbmVlZCB0aGUgdHJ5bG9jayBpbiB2aXJ0bmV0X3BvbGxfdHgoKT8KPj4+IFRoYXQgY291
bGQgd29yay4gQmVzdCBpZiB3ZSB1c2VkIG5vcm1hbCBsb2NrIGlmICEhYnVkZ2V0LCBhbmQgdHJ5
bG9jawo+Pj4gd2hlbiBidWRnZXQgaXMgMC4gQnV0IG1heWJlIHRoYXQncyB0b28gaGFpcnkuCj4+
Cj4+IElmIHdlIHVzZSB0cnlsb2NrLCB3ZSBwcm9iYWJseSBsb3NlKG9yIGRlbGF5KSB0eCBub3Rp
ZmljYXRpb24gdGhhdCBtYXkgaGF2ZQo+PiBzaWRlIGVmZmVjdHMgdG8gdGhlIHN0YWNrLgo+Pgo+
Pgo+Pj4gSSdtIGFzc3VtaW5nIGFsbCB0aGlzIHRyaWNraW5lc3MgY29tZXMgZnJvbSB2aXJ0cXVl
dWVfZ2V0X2J1ZigpIG5lZWRpbmcKPj4+IGxvY2tpbmcgdnMgdGhlIFRYIHBhdGg/IEl0J3MgcHJl
dHR5IHVudXN1YWwgZm9yIHRoZSBjb21wbGV0aW9uIHBhdGggdG8KPj4+IG5lZWQgbG9ja2luZyB2
cyB4bWl0IHBhdGguCj4+Cj4+IFR3byByZWFzb25zIGZvciBkb2luZyB0aGlzOgo+Pgo+PiAxKSBG
b3Igc29tZSBoaXN0b3JpY2FsIHJlYXNvbiwgd2UgdHJ5IHRvIGZyZWUgdHJhbnNtaXR0ZWQgdHgg
cGFja2V0cyBpbiB4bWl0Cj4+IChzZWUgZnJlZV9vbGRfeG1pdF9za2JzKCkgaW4gc3RhcnRfeG1p
dCgpKSwgd2UgY2FuIHByb2JhYmx5IHJlbW92ZSB0aGlzIGlmCj4+IHdlIHJlbW92ZSB0aGUgbm9u
IHR4IGludGVycnVwdCBtb2RlLgo+PiAyKSB2aXJ0aW8gY29yZSByZXF1aXJlcyB2aXJ0cXVldWVf
Z2V0X2J1ZigpIHRvIGJlIHN5bmNocm9uaXplZCB3aXRoCj4+IHZpcnRxdWV1ZV9hZGQoKSwgd2Ug
cHJvYmFibHkgY2FuIHNvbHZlIHRoaXMgYnV0IGl0IHJlcXVpcmVzIHNvbWUgbm9uIHRyaXZpYWwK
Pj4gcmVmYWN0b3JpbmcgaW4gdGhlIHZpcnRpbyBjb3JlCj4gU28gaG93IHdpbGwgd2Ugc29sdmUg
b3VyIGxvY2tkZXAgaXNzdWVzPwo+Cj4gVGhhbmtzCgoKSXQncyBub3QgY2xlYXIgdG8gbWUgdGhh
dCB3aGV0aGVyIGl0J3MgYSB2aXJ0aW8tbmV0IHNwZWNpZmljIGlzc3VlLiBFLmcgCnRoZSBhYm92
ZSBkZWFkbG9jayBsb29rcyBsaWtlIGEgZ2VuZXJpYyBpc3N1ZSBzbyB3b3JrYXJvdW5kIGl0IHZp
YSAKdmlydGlvLW5ldCBtYXkgbm90IGhlbHAgZm9yIG90aGVyIGRyaXZlcnMuCgpUaGFua3MKCgo+
Cj4+IEJ0dywgaGF2ZSBhIHF1aWNrIHNlYXJjaCwgdGhlcmUgYXJlIHNldmVyYWwgb3RoZXIgZHJp
dmVycyB0aGF0IHVzZXMgdHggbG9jawo+PiBpbiB0aGUgdHggTkFQSS4KPj4KPj4gVGhhbmtzCj4+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

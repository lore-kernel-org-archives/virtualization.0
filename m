Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D6FC63697
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 03:22:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DD020866
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 03:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REf/QJ7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DD020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B7DDD861F2;
	Tue, 24 Nov 2020 03:22:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGQkhRigAAu5; Tue, 24 Nov 2020 03:22:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2978486108;
	Tue, 24 Nov 2020 03:22:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEB08C0891;
	Tue, 24 Nov 2020 03:22:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51AA6C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 03:22:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 45488861BC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 03:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MU98j9UzVhF6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 03:22:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4B2A986108
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 03:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606188136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/cB4Y6zYi35tKuoN6G4/JIJq3FZA+1nclYd1TtN7K0=;
 b=REf/QJ7N/Z+LI+5V+iVMneubw7Ultt7hF7aby9U9bQc1JadMmQp7EI3tTcUqDqb+cUUni8
 ct86fFDgZGzp0Va4IK41m+z6oMtbwgR55Vdz4AHvrpFdpwDuP3y/oM/je41mYL8WJ487Lv
 PmOO2+9csgasctKZnu3QwzQkKtDSWf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-4hhBCgcnN-6yIxgr9mr-og-1; Mon, 23 Nov 2020 22:22:14 -0500
X-MC-Unique: 4hhBCgcnN-6yIxgr9mr-og-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97F2110066FB;
 Tue, 24 Nov 2020 03:22:12 +0000 (UTC)
Received: from [10.72.13.198] (ovpn-13-198.pek2.redhat.com [10.72.13.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19D43620DE;
 Tue, 24 Nov 2020 03:22:04 +0000 (UTC)
Subject: Re: netconsole deadlock with virtnet
To: Jakub Kicinski <kuba@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
Date: Tue, 24 Nov 2020 11:22:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Petr Mladek <pmladek@suse.com>, Leon Romanovsky <leon@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, Amit Shah <amit@kernel.org>,
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

Ck9uIDIwMjAvMTEvMjQg5LiK5Y2IMzoyMSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6Cj4gT24gTW9u
LCAyMyBOb3YgMjAyMCAxNDowOTozNCAtMDUwMCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToKPj4gT24g
TW9uLCAyMyBOb3YgMjAyMCAxMDo1Mjo1MiAtMDgwMAo+PiBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPiB3cm90ZToKPj4KPj4+IE9uIE1vbiwgMjMgTm92IDIwMjAgMDk6MzE6MjggLTA1
MDAgU3RldmVuIFJvc3RlZHQgd3JvdGU6Cj4+Pj4gT24gTW9uLCAyMyBOb3YgMjAyMCAxMzowODo1
NSArMDIwMAo+Pj4+IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPiB3cm90ZToKPj4+
Pgo+Pj4+ICAgICAgCj4+Pj4+ICAgWyAgIDEwLjAyODAyNF0gQ2hhaW4gZXhpc3RzIG9mOgo+Pj4+
PiAgIFsgICAxMC4wMjgwMjVdICAgY29uc29sZV9vd25lciAtLT4gdGFyZ2V0X2xpc3RfbG9jayAt
LT4gX3htaXRfRVRIRVIjMgo+Pj4+IE5vdGUsIHRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2ZSBh
IGxvY2F0aW9uIHRoYXQgZ3JhYnMgdGhlIHhtaXRfbG9jayB3aGlsZQo+Pj4+IGhvbGRpbmcgdGFy
Z2V0X2xpc3RfbG9jayAoYW5kIHBvc3NpYmx5IGNvbnNvbGVfb3duZXIpLgo+Pj4gV2VsbCwgaXQg
dHJ5X2xvY2tzIHRoZSB4bWl0X2xvY2suIERvZXMgbG9ja2RlcCB1bmRlcnN0YW5kIHRyeS1sb2Nr
cz8KPj4+Cj4+PiAobm90IHRoYXQgSSBjb25kb25lIHRoZSBzaGVuYW5pZ2FucyB0aGF0IGFyZSBn
b2luZyBvbiBoZXJlKQo+PiBEb2VzIGl0Pwo+Pgo+PiAJdmlydG5ldF9wb2xsX3R4KCkgewo+PiAJ
CV9fbmV0aWZfdHhfbG9jaygpIHsKPj4gCQkJc3Bpbl9sb2NrKCZ0eHEtPl94bWl0X2xvY2spOwo+
IFVtcGYuIFJpZ2h0LiBJIHdhcyBsb29raW5nIGF0IHZpcnRuZXRfcG9sbF9jbGVhbnR4KCkKPgo+
PiBUaGF0IGxvb2tzIGxpa2Ugd2UgY2FuIGhhdmU6Cj4+Cj4+Cj4+IAlDUFUwCQlDUFUxCj4+IAkt
LS0tCQktLS0tCj4+ICAgICBsb2NrKHhtaXRfbG9jaykKPj4KPj4gCQkgICAgbG9jayhjb25zb2xl
KQo+PiAJCSAgICBsb2NrKHRhcmdldF9saXN0X2xvY2spCj4+IAkJICAgIF9fbmV0aWZfdHhfbG9j
aygpCj4+IAkJICAgICAgICBsb2NrKHhtaXRfbG9jayk7Cj4+Cj4+IAkJCVtCTE9DS0VEXQo+Pgo+
PiAgICAgPGludGVycnVwdD4KPj4gICAgIGxvY2soY29uc29sZSkKPj4KPj4gICAgIFtCTE9DS0VE
XQo+Pgo+Pgo+Pgo+PiAgIERFQURMT0NLLgo+Pgo+Pgo+PiBTbyB3aGVyZSBpcyB0aGUgdHJ5bG9j
ayBoZXJlPwo+Pgo+PiBQZXJoYXBzIHlvdSBuZWVkIHRoZSB0cnlsb2NrIGluIHZpcnRuZXRfcG9s
bF90eCgpPwo+IFRoYXQgY291bGQgd29yay4gQmVzdCBpZiB3ZSB1c2VkIG5vcm1hbCBsb2NrIGlm
ICEhYnVkZ2V0LCBhbmQgdHJ5bG9jawo+IHdoZW4gYnVkZ2V0IGlzIDAuIEJ1dCBtYXliZSB0aGF0
J3MgdG9vIGhhaXJ5LgoKCklmIHdlIHVzZSB0cnlsb2NrLCB3ZSBwcm9iYWJseSBsb3NlKG9yIGRl
bGF5KSB0eCBub3RpZmljYXRpb24gdGhhdCBtYXkgCmhhdmUgc2lkZSBlZmZlY3RzIHRvIHRoZSBz
dGFjay4KCgo+Cj4gSSdtIGFzc3VtaW5nIGFsbCB0aGlzIHRyaWNraW5lc3MgY29tZXMgZnJvbSB2
aXJ0cXVldWVfZ2V0X2J1ZigpIG5lZWRpbmcKPiBsb2NraW5nIHZzIHRoZSBUWCBwYXRoPyBJdCdz
IHByZXR0eSB1bnVzdWFsIGZvciB0aGUgY29tcGxldGlvbiBwYXRoIHRvCj4gbmVlZCBsb2NraW5n
IHZzIHhtaXQgcGF0aC4KCgpUd28gcmVhc29ucyBmb3IgZG9pbmcgdGhpczoKCjEpIEZvciBzb21l
IGhpc3RvcmljYWwgcmVhc29uLCB3ZSB0cnkgdG8gZnJlZSB0cmFuc21pdHRlZCB0eCBwYWNrZXRz
IGluIAp4bWl0IChzZWUgZnJlZV9vbGRfeG1pdF9za2JzKCkgaW4gc3RhcnRfeG1pdCgpKSwgd2Ug
Y2FuIHByb2JhYmx5IHJlbW92ZSAKdGhpcyBpZiB3ZSByZW1vdmUgdGhlIG5vbiB0eCBpbnRlcnJ1
cHQgbW9kZS4KMikgdmlydGlvIGNvcmUgcmVxdWlyZXMgdmlydHF1ZXVlX2dldF9idWYoKSB0byBi
ZSBzeW5jaHJvbml6ZWQgd2l0aCAKdmlydHF1ZXVlX2FkZCgpLCB3ZSBwcm9iYWJseSBjYW4gc29s
dmUgdGhpcyBidXQgaXQgcmVxdWlyZXMgc29tZSBub24gCnRyaXZpYWwgcmVmYWN0b3JpbmcgaW4g
dGhlIHZpcnRpbyBjb3JlCgpCdHcsIGhhdmUgYSBxdWljayBzZWFyY2gsIHRoZXJlIGFyZSBzZXZl
cmFsIG90aGVyIGRyaXZlcnMgdGhhdCB1c2VzIHR4IApsb2NrIGluIHRoZSB0eCBOQVBJLgoKVGhh
bmtzCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=

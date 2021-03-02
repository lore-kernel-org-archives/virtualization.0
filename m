Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF4C433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 08:18:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147196148E
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 08:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147196148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 788D76F699;
	Tue,  2 Mar 2021 08:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gwv1p-EY7B6x; Tue,  2 Mar 2021 08:18:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B0A036F65C;
	Tue,  2 Mar 2021 08:18:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54F1AC000B;
	Tue,  2 Mar 2021 08:18:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE042C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 08:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA3934EDD5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 08:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L94n0heHvgnT
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 08:17:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B9164EDD1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 08:17:57 +0000 (UTC)
IronPort-SDR: yKC5eFKL271KqhqjkywOOVBJik1kYBESz0D9+C0+00KwefYwmV/MXWnfe4XyO+TOhdYaj+Jysf
 P2tGvlCJTpkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250778437"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="250778437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2021 00:17:56 -0800
IronPort-SDR: Zk/qHBoeVuRAu6KOKJGR9bqTbUrVEs9uQYZ5/TOXES1oPZbRbHVpCa6l/96qY+eBWB24cU8XmB
 cSSzrX/ee9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444649690"
Received: from unknown (HELO [10.239.154.55]) ([10.239.154.55])
 by orsmga001.jf.intel.com with ESMTP; 02 Mar 2021 00:17:49 -0800
Subject: Re: [PATCH v5] i2c: virtio: add a virtio i2c frontend driver
To: Viresh Kumar <viresh.kumar@linaro.org>
References: <00f826ffe1b6b4f5fb41de2b55ad6b8783b7ff45.1614579846.git.jie.deng@intel.com>
 <20210301115441.a4s5xzwm6d6ohz7f@vireshk-i7>
 <16efea9f-d606-4cf9-9213-3c1cf9b1a906@intel.com>
 <20210302034323.gkqymzngyqofrdsr@vireshk-i7>
 <b99b18e1-06a5-f526-a885-dc663da3612b@intel.com>
 <20210302072431.ml4veczbelyjbhkt@vireshk-i7>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <720f5c0a-032c-b7af-4ca6-cd5adca77c37@intel.com>
Date: Tue, 2 Mar 2021 16:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210302072431.ml4veczbelyjbhkt@vireshk-i7>
Content-Language: en-US
Cc: Sergey.Semin@baikalelectronics.ru, bjorn.andersson@linaro.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com, yu1.wang@intel.com,
 arnd@arndb.de, mst@redhat.com, shuo.a.liu@intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, wsa+renesas@sang-engineering.com,
 Paolo Bonzini <pbonzini@redhat.com>, jarkko.nikula@linux.intel.com,
 linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 kblaiech@mellanox.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, rppt@kernel.org
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

Ck9uIDIwMjEvMy8yIDE1OjI0LCBWaXJlc2ggS3VtYXIgd3JvdGU6Cj4gT24gMDItMDMtMjEsIDE0
OjI0LCBKaWUgRGVuZyB3cm90ZToKPj4gTm90IGZvciB0aGUgZnVsbCBkdXBsZXguIEFzIFBhb2xv
IGV4cGxhaW5lZCBpbiB0aG9zZSBsaW5rcy4KPj4gV2UgZGVmaW5lZCBhIGNvbWJpbmVkIHJlcXVl
c3QgY2FsbGVkICJ3cml0ZS1yZWFkIHJlcXVlc3QiCj4+Cj4+ICIKPj4gVGhpcyBpcyB3aGVuIGEg
d3JpdGUgaXMgZm9sbG93ZWQgYnkgYSByZWFkOiB0aGUgbWFzdGVyCj4+IHN0YXJ0cyBvZmYgdGhl
IHRyYW5zbWlzc2lvbiB3aXRoIGEgd3JpdGUsIHRoZW4gc2VuZHMgYSBzZWNvbmQgU1RBUlQsCj4+
IHRoZW4gY29udGludWVzIHdpdGggYSByZWFkIGZyb20gdGhlIHNhbWUgYWRkcmVzcy4KPiBJIHRo
aW5rIGFib3ZlIHRhbGtzIGFib3V0IHRoZSByZWFsIEkyQyBwcm90b2NvbCBhdCBidXMgbGV2ZWwg
Pwo+Cj4+IEluIHRoZW9yeSB0aGVyZSdzIG5vIGRpZmZlcmVuY2UgYmV0d2VlbiBvbmUgbXVsdGkt
c2VnbWVudCB0cmFuc2FjdGlvbgo+PiBhbmQgbWFueSBzaW5nbGUtc2VnbWVudCB0cmFuc2FjdGlv
bnMgX2luIGEgc2luZ2xlLW1hc3RlciBzY2VuYXJpb18uCj4+Cj4+IEhvd2V2ZXIsIGl0IGlzIGEg
cGxhdXNpYmxlIGNvbmZpZ3VyYXRpb24gdG8gaGF2ZSBtdWx0aXBsZSBndWVzdHMgc2hhcmluZwo+
PiBhbiBJMkMgaG9zdCBkZXZpY2UgYXMgaWYgdGhleSB3ZXJlIG11bHRpcGxlIG1hc3Rlci4KPj4K
Pj4gU28gdGhlIHNwZWMgc2hvdWxkIHByb3ZpZGUgYSB3YXkgYXQgbGVhc3QgdG8gc3VwcG9ydCBm
b3IgdHJhbnNhY3Rpb25zIHdpdGgKPj4gMSB3cml0ZSBhbmQgMSByZWFkIHNlZ21lbnQgaW4gb25l
IHJlcXVlc3QgdG8gdGhlIHNhbWUgYWRkcmVzcy4KPj4gIgo+PiAgRnJvbSB0aGUgcGVyc3BlY3Rp
dmUgb2Ygc3BlY2lmaWNhdGlvbiBkZXNpZ24sIGl0IGhvcGVzIHRvIHByb3ZpZGUgbW9yZQo+PiBj
aG9pY2VzCj4+IHdoaWxlIGZyb20gdGhlIHBlcnNwZWN0aXZlIG9mIHNwZWNpZmljIGltcGxlbWVu
dGF0aW9uLCB3ZSBjYW4gY2hvb3NlIHdoYXQgd2UKPj4gbmVlZAo+PiBhcyBsb25nIGFzIGl0IGRv
ZXMgbm90IHZpb2xhdGUgdGhlIHNwZWNpZmljYXRpb24uCj4gVGhhdCBpcyBmaW5lLCBidXQgd2hh
dCBJIHdhcyBub3QgYWJsZSB0byB1bmRlcnN0YW5kIHdhcyBob3cgZG8gd2UgZ2V0Cj4gdG8ga25v
dyBpZiB3ZSBzaG91bGQgZXhwZWN0IGJvdGggd3JpdGUgYW5kIHJlYWQgYnVmcyBhZnRlciB0aGUg
b3V0Cj4gaGVhZGVyIG9yIG9ubHkgb25lIG9mIHRoZW0gPwo+Cj4gSSB0aGluayBJIGhhdmUgdW5k
ZXJzdG9vZCB0aGF0IHBhcnQgbm93LCB3ZSBuZWVkIHRvIGxvb2sgYXQgaW5jbnQgYW5kCj4gb3V0
Y250IGFuZCBtYWtlIG91dCB3aGF0IGtpbmQgb2YgdHJhbnNmZXIgd2UgbmVlZCB0byBkby4KPgo+
IC0gSWYgb3V0Y250ID09IDEgYW5kIGluY250ID09IDIsIHRoZW4gaXQgaXMgcmVhZCBvcGVyYXRp
b24uCj4gLSBJZiBvdXRjbnQgPT0gMiBhbmQgaW5jbnQgPT0gMSwgdGhlbiBpdCBpcyB3cml0ZSBv
cGVyYXRpb24uCj4gLSBJZiBvdXRjbnQgPT0gMiBhbmQgaW5jbnQgPT0gMiwgdGhlbiBpdCBpcyBy
ZWFkLXdyaXRlIG9wZXJhdGlvbi4KPgo+IEFueXRoaW5nIGVsc2UgaXMgaW52YWxpZC4gSXMgbXkg
dW5kZXJzdGFuZGluZyBjb3JyZWN0IGhlcmUgPwpDb3JyZWN0LsKgIEJ5IGNoZWNraW5nIHRoZSBz
ZXF1ZW5jZXMgb2YgZGVzY3JpcHRvcidzIFIvVyBpbiB0aGUgdmlydHF1ZXVlLApZb3UgY2FuIGtu
b3cgdGhlIHR5cGUgb2YgcmVxdWVzdC4gQSBzaW1wbGUgc3RhdGUgbWFjaGluZSBjYW4gYmUgdXNl
ZCB0bwpjbGFzc2lmeSBpbiB0aGlzIGNhc2UuCgpPIEnCoCBJIMKgIDogcmVhZCByZXF1ZXN0LgoK
TyBPIEnCoCA6IHdyaXRlIHJlcXVlc3QuCgpPIE8gSSBJIDogcmVhZC13cml0ZSByZXF1ZXN0LgoK
QnV0IGlmIG9ubHkgdXNpbmcgdGhlIGZpcnN0IHR3byB0eXBlcyBsaWtlIGluIHRoaXMgZHJpdmVy
LCB0aGUgYmFja2VuZCAKd2lsbCBiZSBtdWNoIGVhc2llciB0bwppbXBsZW1lbnQgc2luY2UgdGhl
IHJlcXVlc3QgaXMgZml4ZWQgdG8gMyBkZXNjcmlwdG9ycyBhbmQgd2Ugb25seSBuZWVkIAp0byBj
aGVjayB0aGUgc2Vjb25kCmRlc2NyaXB0b3IgdG8ga25vdyB0aGUgdHlwZS4KPgo+PiBTaW5jZSB0
aGUgY3VycmVudCBMaW51eCBkcml2ZXIgZG9lc24ndCB1c2UgdGhpcyBtZWNoYW5pc20uIEknbSBj
b25zaWRlcmluZwo+PiB0byBtb3ZlCj4+IHRoZSAic3RydWN0IHZpcnRpb19pMmNfcmVxIiBpbnRv
IHRoZSBkcml2ZXIgYW5kIHVzZSBvbmUgImJ1ZiIgaW5zdGVhZC4KPiBMaW51eCBjYW4gdmVyeSBt
dWNoIGhhdmUgaXRzIG93biBkZWZpbml0aW9uIG9mIHRoZSBzdHJ1Y3R1cmUgYW5kIHNvIEkKPiBh
bSBub3QgaW4gZmF2b3Igb2YgYW55IHN1Y2ggc3RydWN0dXJlIGluIHRoZSBzcGVjIGFzIHdlbGws
IGl0IGNvbmZ1c2VzCj4gcGVvcGxlIChsaWtlIG1lKSA6KS4KPgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

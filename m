Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B077EC433E1
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:58:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 897902177B
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQjMvGzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 897902177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 616DA8868B;
	Fri,  7 Aug 2020 03:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VD6XIMkSwPKC; Fri,  7 Aug 2020 03:58:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E8FC88688;
	Fri,  7 Aug 2020 03:58:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA9B2C0050;
	Fri,  7 Aug 2020 03:58:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC1A5C004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BF50286D4C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:58:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7f2-BCXOjMuX
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:58:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E379B86CF9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596772714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trd6XzNAFWlVlhnF00AGLAJ//+tyUA5NEjUQzobqU08=;
 b=MQjMvGzyHpIfecOASrhi8Mr9viyxzrBMZ/IPaCWFcM2i8HBb2Q5mISn3zlYlSnK6lTLOYU
 1jYariUWLjlOA/Oeikrlqcs0ExtRaJiPcVZsk/UhCh5D8JaPxGncHQQ/ekFfvIHRl6i3Wj
 LN4+TFHR/6cW6XsFDG3nfJTcBIe6VvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-fVW1eGtFPm-D5zEmWHR_nA-1; Thu, 06 Aug 2020 23:58:30 -0400
X-MC-Unique: fVW1eGtFPm-D5zEmWHR_nA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974998017FB;
 Fri,  7 Aug 2020 03:58:29 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12EA15F1EF;
 Fri,  7 Aug 2020 03:58:23 +0000 (UTC)
Subject: Re: [PATCH][next] vdpa/mlx5: fix memory allocation failure checks
To: Colin King <colin.king@canonical.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Parav Pandit <parav@mellanox.com>, virtualization@lists.linux-foundation.org
References: <20200806160828.90463-1-colin.king@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bca8c1ef-1e21-cd05-4a91-ca136de5ae1e@redhat.com>
Date: Fri, 7 Aug 2020 11:58:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806160828.90463-1-colin.king@canonical.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvOC83IOS4iuWNiDEyOjA4LCBDb2xpbiBLaW5nIHdyb3RlOgo+IEZyb206IENvbGlu
IElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4KPiBUaGUgbWVtb3J5IGFsbG9j
YXRpb24gZmFpbHVyZSBjaGVja2luZyBmb3IgaW4gYW5kIG91dCBpcyBjdXJyZW50bHkKPiBjaGVj
a2luZyBpZiB0aGUgcG9pbnRlcnMgYXJlIHZhbGlkIHJhdGhlciB0aGFuIHRoZSBjb250ZW50cyBv
ZiB3aGF0Cj4gdGhleSBwb2ludCB0by4gSGVuY2UgdGhlIG51bGwgY2hlY2sgb24gZmFpbGVkIG1l
bW9yeSBhbGxvY2F0aW9ucyBpcwo+IGluY29ycmVjdC4gIEZpeCB0aGlzIGJ5IGFkZGluZyB0aGUg
bWlzc2luZyBpbmRpcmVjdGlvbiBpbiB0aGUgY2hlY2suCj4gQWxzbyBmb3IgdGhlIGRlZmF1bHQg
Y2FzZSwganVzdCBzZXQgdGhlICppbiBhbmQgKm91dCB0byBudWxsIGFzCj4gdGhlc2UgZG9uJ3Qg
aGF2ZSBhbnkgdGhpbmcgYWxsb2NhdGVkIHRvIGtmcmVlLiBGaW5hbGx5IHJlbW92ZSB0aGUKPiBy
ZWR1bmRhbnQgKmluIGFuZCAqb3V0IGNoZWNrIGFzIHRoZXNlIGhhdmUgYmVlbiBhbHJlYWR5IGRv
bmUgb24gZWFjaAo+IGFsbG9jYXRpb24gaW4gdGhlIGNhc2Ugc3RhdGVtZW50Lgo+Cj4gQWRkcmVz
c2VzLUNvdmVyaXR5OiAoIk51bGwgcG9pbnRlciBkZXJlZmVyZW5jZSIpCj4gRml4ZXM6IDFhODZi
Mzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBk
ZXZpY2VzIikKPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5v
bmljYWwuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxMyArKysrKyst
LS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDNlYzQ0YTRmMGU0NS4uNTVi
YzU4ZTFkYWU5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC04NjcsNyAr
ODY3LDcgQEAgc3RhdGljIHZvaWQgYWxsb2NfaW5vdXQoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYsIGludCBjbWQsIHZvaWQgKippbiwgaW50ICppbmwKPiAgIAkJKm91dGxlbiA9IE1MWDVfU1Rf
U1pfQllURVMocXBfMnJzdF9vdXQpOwo+ICAgCQkqaW4gPSBremFsbG9jKCppbmxlbiwgR0ZQX0tF
Uk5FTCk7Cj4gICAJCSpvdXQgPSBremFsbG9jKCpvdXRsZW4sIEdGUF9LRVJORUwpOwo+IC0JCWlm
ICghaW4gfHwgIW91dCkKPiArCQlpZiAoISppbiB8fCAhKm91dCkKPiAgIAkJCWdvdG8gb3V0ZXJy
Owo+ICAgCj4gICAJCU1MWDVfU0VUKHFwXzJyc3RfaW4sICppbiwgb3Bjb2RlLCBjbWQpOwo+IEBA
IC04NzksNyArODc5LDcgQEAgc3RhdGljIHZvaWQgYWxsb2NfaW5vdXQoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYsIGludCBjbWQsIHZvaWQgKippbiwgaW50ICppbmwKPiAgIAkJKm91dGxlbiA9
IE1MWDVfU1RfU1pfQllURVMocnN0MmluaXRfcXBfb3V0KTsKPiAgIAkJKmluID0ga3phbGxvYygq
aW5sZW4sIEdGUF9LRVJORUwpOwo+ICAgCQkqb3V0ID0ga3phbGxvYyhNTFg1X1NUX1NaX0JZVEVT
KHJzdDJpbml0X3FwX291dCksIEdGUF9LRVJORUwpOwo+IC0JCWlmICghaW4gfHwgIW91dCkKPiAr
CQlpZiAoISppbiB8fCAhKm91dCkKPiAgIAkJCWdvdG8gb3V0ZXJyOwo+ICAgCj4gICAJCU1MWDVf
U0VUKHJzdDJpbml0X3FwX2luLCAqaW4sIG9wY29kZSwgY21kKTsKPiBAQCAtODk2LDcgKzg5Niw3
IEBAIHN0YXRpYyB2b2lkIGFsbG9jX2lub3V0KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBp
bnQgY21kLCB2b2lkICoqaW4sIGludCAqaW5sCj4gICAJCSpvdXRsZW4gPSBNTFg1X1NUX1NaX0JZ
VEVTKGluaXQycnRyX3FwX291dCk7Cj4gICAJCSppbiA9IGt6YWxsb2MoKmlubGVuLCBHRlBfS0VS
TkVMKTsKPiAgIAkJKm91dCA9IGt6YWxsb2MoTUxYNV9TVF9TWl9CWVRFUyhpbml0MnJ0cl9xcF9v
dXQpLCBHRlBfS0VSTkVMKTsKPiAtCQlpZiAoIWluIHx8ICFvdXQpCj4gKwkJaWYgKCEqaW4gfHwg
ISpvdXQpCj4gICAJCQlnb3RvIG91dGVycjsKPiAgIAo+ICAgCQlNTFg1X1NFVChpbml0MnJ0cl9x
cF9pbiwgKmluLCBvcGNvZGUsIGNtZCk7Cj4gQEAgLTkxNCw3ICs5MTQsNyBAQCBzdGF0aWMgdm9p
ZCBhbGxvY19pbm91dChzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgaW50IGNtZCwgdm9pZCAq
KmluLCBpbnQgKmlubAo+ICAgCQkqb3V0bGVuID0gTUxYNV9TVF9TWl9CWVRFUyhydHIycnRzX3Fw
X291dCk7Cj4gICAJCSppbiA9IGt6YWxsb2MoKmlubGVuLCBHRlBfS0VSTkVMKTsKPiAgIAkJKm91
dCA9IGt6YWxsb2MoTUxYNV9TVF9TWl9CWVRFUyhydHIycnRzX3FwX291dCksIEdGUF9LRVJORUwp
Owo+IC0JCWlmICghaW4gfHwgIW91dCkKPiArCQlpZiAoISppbiB8fCAhKm91dCkKPiAgIAkJCWdv
dG8gb3V0ZXJyOwo+ICAgCj4gICAJCU1MWDVfU0VUKHJ0cjJydHNfcXBfaW4sICppbiwgb3Bjb2Rl
LCBjbWQpOwo+IEBAIC05MjcsMTYgKzkyNywxNSBAQCBzdGF0aWMgdm9pZCBhbGxvY19pbm91dChz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgaW50IGNtZCwgdm9pZCAqKmluLCBpbnQgKmlubAo+
ICAgCQlNTFg1X1NFVChxcGMsIHFwYywgcm5yX3JldHJ5LCA3KTsKPiAgIAkJYnJlYWs7Cj4gICAJ
ZGVmYXVsdDoKPiAtCQlnb3RvIG91dGVycjsKPiArCQlnb3RvIG91dGVycl9udWxsaWZ5Owo+ICAg
CX0KPiAtCWlmICghKmluIHx8ICEqb3V0KQo+IC0JCWdvdG8gb3V0ZXJyOwo+ICAgCj4gICAJcmV0
dXJuOwo+ICAgCj4gICBvdXRlcnI6Cj4gICAJa2ZyZWUoKmluKTsKPiAgIAlrZnJlZSgqb3V0KTsK
PiArb3V0ZXJyX251bGxpZnk6Cj4gICAJKmluID0gTlVMTDsKPiAgIAkqb3V0ID0gTlVMTDsKPiAg
IH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

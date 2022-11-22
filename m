Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23EDC4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Nov 2022 17:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68DE6415E1;
	Tue, 22 Nov 2022 17:03:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 68DE6415E1
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=lGNG+NpU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17lLbsre3DaL; Tue, 22 Nov 2022 17:03:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95AD540554;
	Tue, 22 Nov 2022 17:03:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95AD540554
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60F83C0032;
	Tue, 22 Nov 2022 17:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E47E1C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B8E2A40B6D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8E2A40B6D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=lGNG+NpU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nhOJPDlGNWQm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39704400CB
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39704400CB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
 :Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=6OthWer9O3aM/7vfA9iZRVn/4cj/z/1mGdO9oyoM7xk=; b=lGNG+NpUCWZ0YKzSVCDfkpJka5
 iXQMJ/hXxvOeh84RrUGrLBSDfCblA21i8IWVAYnTKN/+uHtaN77LJZHAQ2YnGIRXx23lR4VAEqtFW
 fNYMAvt4kvy8CN2ktj83WwKqeIgHXYAAy6TnSghbN/0gw9vXjPrPciNgcCkUMkVqat7263IFEMoZ9
 wp2sfYK8G455k9gv1vZgFwngJvYz/TV1zCCUKGb8c5Hda7eqVaLzbo/a3HXVyIF94emcGa4uPObul
 sIG2gNVo2FsnpKymuD/AgXCE28FFNWlcj3qlkuP8ksfjzSCQToxwmhH+8cjf6Nhmrjy3Bxtvmd3Sy
 jAXCyGaw==;
Received: from [54.239.6.185] (helo=[192.168.10.109])
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oxWfq-003W9O-Fg; Tue, 22 Nov 2022 17:03:06 +0000
Message-ID: <6293fd7d415950979c55c3f09254a6f52eba708b.camel@infradead.org>
Subject: Re: [PATCH v2] virtio_console: Introduce an ID allocator for
 virtual console numbers
From: Amit Shah <amit@infradead.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Amit Shah
 <amit@kernel.org>
Date: Tue, 22 Nov 2022 18:03:05 +0100
In-Reply-To: <20221114173811.1977367-1-clg@kaod.org>
References: <20221114173811.1977367-1-clg@kaod.org>
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCAyMDIyLTExLTE0IGF0IDE4OjM4ICswMTAwLCBDw6lkcmljIExlIEdvYXRlciB3cm90
ZToKPiBXaGVuIGEgdmlydGlvIGNvbnNvbGUgcG9ydCBpcyBpbml0aWFsaXplZCwgaXQgaXMgcmVn
aXN0ZXJlZCBhcyBhbiBodmMKPiBjb25zb2xlIHVzaW5nIGEgdmlydHVhbCBjb25zb2xlIG51bWJl
ci4gSWYgYSBLVk0gZ3Vlc3QgaXMgc3RhcnRlZCB3aXRoCj4gbXVsdGlwbGUgdmlydGlvIGNvbnNv
bGUgZGV2aWNlcywgdGhlIHNhbWUgdnRlcm1ubyAob3IgdmlydHVhbCBjb25zb2xlCj4gbnVtYmVy
KSBjYW4gYmUgdXNlZCB0byBhbGxvY2F0ZSBkaWZmZXJlbnQgaHZjIGNvbnNvbGVzLCB3aGljaCBs
ZWFkcyB0bwo+IHZhcmlvdXMgY29tbXVuaWNhdGlvbiBwcm9ibGVtcyBsYXRlciBvbi4KPiAKPiBU
aGlzIGlzIGFsc28gcmVwb3J0ZWQgaW4gZGVidWdmcyA6Cj4gCj4gICAjIGdyZXAgdnRlcm1ubyAv
c3lzL2tlcm5lbC9kZWJ1Zy92aXJ0aW8tcG9ydHMvKgo+ICAgL3N5cy9rZXJuZWwvZGVidWcvdmly
dGlvLXBvcnRzL3Zwb3J0MXAxOmNvbnNvbGVfdnRlcm1ubzogMQo+ICAgL3N5cy9rZXJuZWwvZGVi
dWcvdmlydGlvLXBvcnRzL3Zwb3J0MnAxOmNvbnNvbGVfdnRlcm1ubzogMQo+ICAgL3N5cy9rZXJu
ZWwvZGVidWcvdmlydGlvLXBvcnRzL3Zwb3J0M3AxOmNvbnNvbGVfdnRlcm1ubzogMgo+ICAgL3N5
cy9rZXJuZWwvZGVidWcvdmlydGlvLXBvcnRzL3Zwb3J0NHAxOmNvbnNvbGVfdnRlcm1ubzogMwo+
IAo+IFJlcGxhY2UgdGhlIG5leHRfdnRlcm1ubyBnbG9iYWwgd2l0aCBhbiBJRCBhbGxvY2F0b3Ig
YW5kIHN0YXJ0IHRoZQo+IGFsbG9jYXRpb24gYXQgMSBhcyBpdCBpcyB0b2RheS4gQWxzbyByZWN5
Y2xlIElEcyB3aGVuIGEgY29uc29sZSBwb3J0Cj4gaXMgcmVtb3ZlZC4KCldoZW4gdGhlIG9yaWdp
bmFsIHZpcnRpb19jb25zb2xlIG1vZHVsZSB3YXMgd3JpdHRlbiwgaXQgZGlkbid0IGhhdmUKc3Vw
cG9ydCBmb3IgbXVsdGlwbGUgcG9ydHMgdG8gYmUgdXNlZCB0aGlzIHdheS4gIFNvIHRoZSBvZGRp
dHkgeW91J3JlCnNlZWluZyBpcyBsZWZ0IHRoZXJlIGRlbGliZXJhdGVseTogVk1NcyBzaG91bGQg
bm90IGJlIGluc3RhbnRpYXRpbmcKY29uc29sZSBwb3J0cyB0aGlzIHdheS4KCkkgZG9uJ3Qga25v
dyBpZiB3ZSBzaG91bGQgdGFrZSBpbiB0aGlzIGNoYW5nZSwgYnV0IGNhbiB5b3Ugd2FsayB0aHJv
dWdoCmFsbCBjb21iaW5hdGlvbnMgb2YgbmV3L29sZCBndWVzdCBhbmQgbmV3L29sZCBoeXBlcnZp
c29yIGFuZCBlbnN1cmUKbm90aGluZydzIGdvaW5nIHRvIGJyZWFrIC0tIGFuZCBjb25maXJtIHdp
dGggdGhlIHNwZWMgdGhpcyBpcyBzdGlsbCBPSwp0byBkbz8gIEl0IG1heSBub3QgYmUgYSBnb2Fs
IHRvIHN0aWxsIGVuc3VyZSBsYXVuY2hlcyBvZiBhIG5ldyBndWVzdCBvbgphIHZlcnkgb2xkIChz
YXkpIENlbnRvczUgZ3Vlc3Qgc3RpbGwgd29ya3MgLS0gYnV0IHRoYXQgd2FzIHRoZSBwb2ludCBv
ZgptYWludGFpbmluZyBiYWNrd2FyZCBjb21wYXQuLi4KCgoJCUFtaXQKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

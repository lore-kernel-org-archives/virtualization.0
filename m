Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7FBC2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 09:26:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25152073C
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 09:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2eMylOdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25152073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 37857204D4;
	Tue, 24 Nov 2020 09:26:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qQ3gVOgAhawX; Tue, 24 Nov 2020 09:26:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A0576203DB;
	Tue, 24 Nov 2020 09:26:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83D63C163C;
	Tue, 24 Nov 2020 09:26:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72F3AC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4E478204D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:26:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xoBgzcuIrb4L
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:26:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 6042E203DB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 09:26:26 +0000 (UTC)
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EA8D32076B;
 Tue, 24 Nov 2020 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606209985;
 bh=eIrBvn6VIWhITdI4WjRtSSOqgfi0NiymQmtvmzBl3bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2eMylOdZtU6X8AOAcTgyLTdXy6WLXnN6oFZXs+DEEh9lpjzgjqVVx5O2kZb2bStkN
 /Q4/xCyLcpBQdykEOebV/RwfSRBioFTCqzqqYbkqO5SQMnsW7CPmMYoT3x0DymRzA9
 SCGa6Kc6oWnyChsjbERzLAa4UZhhhDNBNgGf2v60=
Date: Tue, 24 Nov 2020 11:26:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201124092621.GH3159@unreal>
References: <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home>
 <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201123140934.38748be3@gandalf.local.home>
 <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
 <20201124080152.GG3159@unreal>
 <6f046c51-cdcc-77f9-4859-2508d08126f8@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f046c51-cdcc-77f9-4859-2508d08126f8@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMDQ6NTc6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+IE9uIDIwMjAvMTEvMjQg5LiL5Y2INDowMSwgTGVvbiBSb21hbm92c2t5IHdyb3RlOgo+
ID4gT24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMTE6MjI6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPiA+ID4gT24gMjAyMC8xMS8yNCDkuIrljYgzOjIxLCBKYWt1YiBLaWNpbnNraSB3cm90
ZToKPiA+ID4gPiBPbiBNb24sIDIzIE5vdiAyMDIwIDE0OjA5OjM0IC0wNTAwIFN0ZXZlbiBSb3N0
ZWR0IHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCAyMyBOb3YgMjAyMCAxMDo1Mjo1MiAtMDgwMAo+
ID4gPiA+ID4gSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBPbiBNb24sIDIzIE5vdiAyMDIwIDA5OjMxOjI4IC0wNTAwIFN0ZXZlbiBS
b3N0ZWR0IHdyb3RlOgo+ID4gPiA+ID4gPiA+IE9uIE1vbiwgMjMgTm92IDIwMjAgMTM6MDg6NTUg
KzAyMDAKPiA+ID4gPiA+ID4gPiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4gd3Jv
dGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ICAgIFsgICAxMC4wMjgwMjRdIENoYWlu
IGV4aXN0cyBvZjoKPiA+ID4gPiA+ID4gPiA+ICAgIFsgICAxMC4wMjgwMjVdICAgY29uc29sZV9v
d25lciAtLT4gdGFyZ2V0X2xpc3RfbG9jayAtLT4gX3htaXRfRVRIRVIjMgo+ID4gPiA+ID4gPiA+
IE5vdGUsIHRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2ZSBhIGxvY2F0aW9uIHRoYXQgZ3JhYnMg
dGhlIHhtaXRfbG9jayB3aGlsZQo+ID4gPiA+ID4gPiA+IGhvbGRpbmcgdGFyZ2V0X2xpc3RfbG9j
ayAoYW5kIHBvc3NpYmx5IGNvbnNvbGVfb3duZXIpLgo+ID4gPiA+ID4gPiBXZWxsLCBpdCB0cnlf
bG9ja3MgdGhlIHhtaXRfbG9jay4gRG9lcyBsb2NrZGVwIHVuZGVyc3RhbmQgdHJ5LWxvY2tzPwo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiAobm90IHRoYXQgSSBjb25kb25lIHRoZSBzaGVuYW5pZ2Fu
cyB0aGF0IGFyZSBnb2luZyBvbiBoZXJlKQo+ID4gPiA+ID4gRG9lcyBpdD8KPiA+ID4gPiA+Cj4g
PiA+ID4gPiAJdmlydG5ldF9wb2xsX3R4KCkgewo+ID4gPiA+ID4gCQlfX25ldGlmX3R4X2xvY2so
KSB7Cj4gPiA+ID4gPiAJCQlzcGluX2xvY2soJnR4cS0+X3htaXRfbG9jayk7Cj4gPiA+ID4gVW1w
Zi4gUmlnaHQuIEkgd2FzIGxvb2tpbmcgYXQgdmlydG5ldF9wb2xsX2NsZWFudHgoKQo+ID4gPiA+
Cj4gPiA+ID4gPiBUaGF0IGxvb2tzIGxpa2Ugd2UgY2FuIGhhdmU6Cj4gPiA+ID4gPgo+ID4gPiA+
ID4KPiA+ID4gPiA+IAlDUFUwCQlDUFUxCj4gPiA+ID4gPiAJLS0tLQkJLS0tLQo+ID4gPiA+ID4g
ICAgICBsb2NrKHhtaXRfbG9jaykKPiA+ID4gPiA+Cj4gPiA+ID4gPiAJCSAgICBsb2NrKGNvbnNv
bGUpCj4gPiA+ID4gPiAJCSAgICBsb2NrKHRhcmdldF9saXN0X2xvY2spCj4gPiA+ID4gPiAJCSAg
ICBfX25ldGlmX3R4X2xvY2soKQo+ID4gPiA+ID4gCQkgICAgICAgIGxvY2soeG1pdF9sb2NrKTsK
PiA+ID4gPiA+Cj4gPiA+ID4gPiAJCQlbQkxPQ0tFRF0KPiA+ID4gPiA+Cj4gPiA+ID4gPiAgICAg
IDxpbnRlcnJ1cHQ+Cj4gPiA+ID4gPiAgICAgIGxvY2soY29uc29sZSkKPiA+ID4gPiA+Cj4gPiA+
ID4gPiAgICAgIFtCTE9DS0VEXQo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gICAgREVBRExPQ0suCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFNvIHdoZXJlIGlz
IHRoZSB0cnlsb2NrIGhlcmU/Cj4gPiA+ID4gPgo+ID4gPiA+ID4gUGVyaGFwcyB5b3UgbmVlZCB0
aGUgdHJ5bG9jayBpbiB2aXJ0bmV0X3BvbGxfdHgoKT8KPiA+ID4gPiBUaGF0IGNvdWxkIHdvcmsu
IEJlc3QgaWYgd2UgdXNlZCBub3JtYWwgbG9jayBpZiAhIWJ1ZGdldCwgYW5kIHRyeWxvY2sKPiA+
ID4gPiB3aGVuIGJ1ZGdldCBpcyAwLiBCdXQgbWF5YmUgdGhhdCdzIHRvbyBoYWlyeS4KPiA+ID4K
PiA+ID4gSWYgd2UgdXNlIHRyeWxvY2ssIHdlIHByb2JhYmx5IGxvc2Uob3IgZGVsYXkpIHR4IG5v
dGlmaWNhdGlvbiB0aGF0IG1heSBoYXZlCj4gPiA+IHNpZGUgZWZmZWN0cyB0byB0aGUgc3RhY2su
Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gSSdtIGFzc3VtaW5nIGFsbCB0aGlzIHRyaWNraW5lc3MgY29t
ZXMgZnJvbSB2aXJ0cXVldWVfZ2V0X2J1ZigpIG5lZWRpbmcKPiA+ID4gPiBsb2NraW5nIHZzIHRo
ZSBUWCBwYXRoPyBJdCdzIHByZXR0eSB1bnVzdWFsIGZvciB0aGUgY29tcGxldGlvbiBwYXRoIHRv
Cj4gPiA+ID4gbmVlZCBsb2NraW5nIHZzIHhtaXQgcGF0aC4KPiA+ID4KPiA+ID4gVHdvIHJlYXNv
bnMgZm9yIGRvaW5nIHRoaXM6Cj4gPiA+Cj4gPiA+IDEpIEZvciBzb21lIGhpc3RvcmljYWwgcmVh
c29uLCB3ZSB0cnkgdG8gZnJlZSB0cmFuc21pdHRlZCB0eCBwYWNrZXRzIGluIHhtaXQKPiA+ID4g
KHNlZSBmcmVlX29sZF94bWl0X3NrYnMoKSBpbiBzdGFydF94bWl0KCkpLCB3ZSBjYW4gcHJvYmFi
bHkgcmVtb3ZlIHRoaXMgaWYKPiA+ID4gd2UgcmVtb3ZlIHRoZSBub24gdHggaW50ZXJydXB0IG1v
ZGUuCj4gPiA+IDIpIHZpcnRpbyBjb3JlIHJlcXVpcmVzIHZpcnRxdWV1ZV9nZXRfYnVmKCkgdG8g
YmUgc3luY2hyb25pemVkIHdpdGgKPiA+ID4gdmlydHF1ZXVlX2FkZCgpLCB3ZSBwcm9iYWJseSBj
YW4gc29sdmUgdGhpcyBidXQgaXQgcmVxdWlyZXMgc29tZSBub24gdHJpdmlhbAo+ID4gPiByZWZh
Y3RvcmluZyBpbiB0aGUgdmlydGlvIGNvcmUKPiA+IFNvIGhvdyB3aWxsIHdlIHNvbHZlIG91ciBs
b2NrZGVwIGlzc3Vlcz8KPiA+Cj4gPiBUaGFua3MKPgo+Cj4gSXQncyBub3QgY2xlYXIgdG8gbWUg
dGhhdCB3aGV0aGVyIGl0J3MgYSB2aXJ0aW8tbmV0IHNwZWNpZmljIGlzc3VlLiBFLmcgdGhlCj4g
YWJvdmUgZGVhZGxvY2sgbG9va3MgbGlrZSBhIGdlbmVyaWMgaXNzdWUgc28gd29ya2Fyb3VuZCBp
dCB2aWEgdmlydGlvLW5ldAo+IG1heSBub3QgaGVscCBmb3Igb3RoZXIgZHJpdmVycy4KCkl0IGlz
IGhhcmQgdG8gc2F5LCBubyBvbmUgZWxzZSBjb21wbGFpbmVkIGV4Y2VwdCBtZSB3aG8gaXMgdXNp
bmcgdmlydGlvIDopLgoKVGhhbmtzCgo+Cj4gVGhhbmtzCj4KPgo+ID4KPiA+ID4gQnR3LCBoYXZl
IGEgcXVpY2sgc2VhcmNoLCB0aGVyZSBhcmUgc2V2ZXJhbCBvdGhlciBkcml2ZXJzIHRoYXQgdXNl
cyB0eCBsb2NrCj4gPiA+IGluIHRoZSB0eCBOQVBJLgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4K
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

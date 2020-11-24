Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75844C56201
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 08:02:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73B0206D9
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 08:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qL2nio79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73B0206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 49CBB8584A;
	Tue, 24 Nov 2020 08:02:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4Y7BAnbSVE6; Tue, 24 Nov 2020 08:01:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B4F13857BE;
	Tue, 24 Nov 2020 08:01:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99166C0891;
	Tue, 24 Nov 2020 08:01:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90EB4C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:01:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8CA1186661
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dbPCUBtKPWki
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:01:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EF3C186655
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 08:01:57 +0000 (UTC)
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 45C6C206B2;
 Tue, 24 Nov 2020 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606204917;
 bh=EDmGqKWfP1BJURlqQVKhMsODP0f5WK2V4tGKfcjOcDQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qL2nio79sg3EzZoAagtmOiIAhR1f8ajLOHlC1OrlrNAgo3PeLE1uGQ635+QqZmxxD
 yEvTUaPsZzukOViVUSaz/ygqzQNCIDrBr917OGFojSaT7KvlJ3tA25kebvPWb+ktdd
 cE3pDIIU4XO7Arori1ub69q0B4lCh757Sg+TFmCU=
Date: Tue, 24 Nov 2020 10:01:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: netconsole deadlock with virtnet
Message-ID: <20201124080152.GG3159@unreal>
References: <X7SK9l0oZ+RTivwF@jagdpanzerIV.localdomain>
 <X7SRxB6C+9Bm+r4q@jagdpanzerIV.localdomain>
 <93b42091-66f2-bb92-6822-473167b2698d@redhat.com>
 <20201118091257.2ee6757a@gandalf.local.home>
 <20201123110855.GD3159@unreal>
 <20201123093128.701cf81b@gandalf.local.home>
 <20201123105252.1c295138@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20201123140934.38748be3@gandalf.local.home>
 <20201123112130.759b9487@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1133f1a4-6772-8aa3-41dd-edbc1ee76cee@redhat.com>
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

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMTE6MjI6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+IE9uIDIwMjAvMTEvMjQg5LiK5Y2IMzoyMSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6Cj4g
PiBPbiBNb24sIDIzIE5vdiAyMDIwIDE0OjA5OjM0IC0wNTAwIFN0ZXZlbiBSb3N0ZWR0IHdyb3Rl
Ogo+ID4gPiBPbiBNb24sIDIzIE5vdiAyMDIwIDEwOjUyOjUyIC0wODAwCj4gPiA+IEpha3ViIEtp
Y2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPgo+ID4gPiA+IE9uIE1vbiwgMjMg
Tm92IDIwMjAgMDk6MzE6MjggLTA1MDAgU3RldmVuIFJvc3RlZHQgd3JvdGU6Cj4gPiA+ID4gPiBP
biBNb24sIDIzIE5vdiAyMDIwIDEzOjA4OjU1ICswMjAwCj4gPiA+ID4gPiBMZW9uIFJvbWFub3Zz
a3kgPGxlb25Aa2VybmVsLm9yZz4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gPiAgIFsgICAx
MC4wMjgwMjRdIENoYWluIGV4aXN0cyBvZjoKPiA+ID4gPiA+ID4gICBbICAgMTAuMDI4MDI1XSAg
IGNvbnNvbGVfb3duZXIgLS0+IHRhcmdldF9saXN0X2xvY2sgLS0+IF94bWl0X0VUSEVSIzIKPiA+
ID4gPiA+IE5vdGUsIHRoZSBwcm9ibGVtIGlzIHRoYXQgd2UgaGF2ZSBhIGxvY2F0aW9uIHRoYXQg
Z3JhYnMgdGhlIHhtaXRfbG9jayB3aGlsZQo+ID4gPiA+ID4gaG9sZGluZyB0YXJnZXRfbGlzdF9s
b2NrIChhbmQgcG9zc2libHkgY29uc29sZV9vd25lcikuCj4gPiA+ID4gV2VsbCwgaXQgdHJ5X2xv
Y2tzIHRoZSB4bWl0X2xvY2suIERvZXMgbG9ja2RlcCB1bmRlcnN0YW5kIHRyeS1sb2Nrcz8KPiA+
ID4gPgo+ID4gPiA+IChub3QgdGhhdCBJIGNvbmRvbmUgdGhlIHNoZW5hbmlnYW5zIHRoYXQgYXJl
IGdvaW5nIG9uIGhlcmUpCj4gPiA+IERvZXMgaXQ/Cj4gPiA+Cj4gPiA+IAl2aXJ0bmV0X3BvbGxf
dHgoKSB7Cj4gPiA+IAkJX19uZXRpZl90eF9sb2NrKCkgewo+ID4gPiAJCQlzcGluX2xvY2soJnR4
cS0+X3htaXRfbG9jayk7Cj4gPiBVbXBmLiBSaWdodC4gSSB3YXMgbG9va2luZyBhdCB2aXJ0bmV0
X3BvbGxfY2xlYW50eCgpCj4gPgo+ID4gPiBUaGF0IGxvb2tzIGxpa2Ugd2UgY2FuIGhhdmU6Cj4g
PiA+Cj4gPiA+Cj4gPiA+IAlDUFUwCQlDUFUxCj4gPiA+IAktLS0tCQktLS0tCj4gPiA+ICAgICBs
b2NrKHhtaXRfbG9jaykKPiA+ID4KPiA+ID4gCQkgICAgbG9jayhjb25zb2xlKQo+ID4gPiAJCSAg
ICBsb2NrKHRhcmdldF9saXN0X2xvY2spCj4gPiA+IAkJICAgIF9fbmV0aWZfdHhfbG9jaygpCj4g
PiA+IAkJICAgICAgICBsb2NrKHhtaXRfbG9jayk7Cj4gPiA+Cj4gPiA+IAkJCVtCTE9DS0VEXQo+
ID4gPgo+ID4gPiAgICAgPGludGVycnVwdD4KPiA+ID4gICAgIGxvY2soY29uc29sZSkKPiA+ID4K
PiA+ID4gICAgIFtCTE9DS0VEXQo+ID4gPgo+ID4gPgo+ID4gPgo+ID4gPiAgIERFQURMT0NLLgo+
ID4gPgo+ID4gPgo+ID4gPiBTbyB3aGVyZSBpcyB0aGUgdHJ5bG9jayBoZXJlPwo+ID4gPgo+ID4g
PiBQZXJoYXBzIHlvdSBuZWVkIHRoZSB0cnlsb2NrIGluIHZpcnRuZXRfcG9sbF90eCgpPwo+ID4g
VGhhdCBjb3VsZCB3b3JrLiBCZXN0IGlmIHdlIHVzZWQgbm9ybWFsIGxvY2sgaWYgISFidWRnZXQs
IGFuZCB0cnlsb2NrCj4gPiB3aGVuIGJ1ZGdldCBpcyAwLiBCdXQgbWF5YmUgdGhhdCdzIHRvbyBo
YWlyeS4KPgo+Cj4gSWYgd2UgdXNlIHRyeWxvY2ssIHdlIHByb2JhYmx5IGxvc2Uob3IgZGVsYXkp
IHR4IG5vdGlmaWNhdGlvbiB0aGF0IG1heSBoYXZlCj4gc2lkZSBlZmZlY3RzIHRvIHRoZSBzdGFj
ay4KPgo+Cj4gPgo+ID4gSSdtIGFzc3VtaW5nIGFsbCB0aGlzIHRyaWNraW5lc3MgY29tZXMgZnJv
bSB2aXJ0cXVldWVfZ2V0X2J1ZigpIG5lZWRpbmcKPiA+IGxvY2tpbmcgdnMgdGhlIFRYIHBhdGg/
IEl0J3MgcHJldHR5IHVudXN1YWwgZm9yIHRoZSBjb21wbGV0aW9uIHBhdGggdG8KPiA+IG5lZWQg
bG9ja2luZyB2cyB4bWl0IHBhdGguCj4KPgo+IFR3byByZWFzb25zIGZvciBkb2luZyB0aGlzOgo+
Cj4gMSkgRm9yIHNvbWUgaGlzdG9yaWNhbCByZWFzb24sIHdlIHRyeSB0byBmcmVlIHRyYW5zbWl0
dGVkIHR4IHBhY2tldHMgaW4geG1pdAo+IChzZWUgZnJlZV9vbGRfeG1pdF9za2JzKCkgaW4gc3Rh
cnRfeG1pdCgpKSwgd2UgY2FuIHByb2JhYmx5IHJlbW92ZSB0aGlzIGlmCj4gd2UgcmVtb3ZlIHRo
ZSBub24gdHggaW50ZXJydXB0IG1vZGUuCj4gMikgdmlydGlvIGNvcmUgcmVxdWlyZXMgdmlydHF1
ZXVlX2dldF9idWYoKSB0byBiZSBzeW5jaHJvbml6ZWQgd2l0aAo+IHZpcnRxdWV1ZV9hZGQoKSwg
d2UgcHJvYmFibHkgY2FuIHNvbHZlIHRoaXMgYnV0IGl0IHJlcXVpcmVzIHNvbWUgbm9uIHRyaXZp
YWwKPiByZWZhY3RvcmluZyBpbiB0aGUgdmlydGlvIGNvcmUKClNvIGhvdyB3aWxsIHdlIHNvbHZl
IG91ciBsb2NrZGVwIGlzc3Vlcz8KClRoYW5rcwoKPgo+IEJ0dywgaGF2ZSBhIHF1aWNrIHNlYXJj
aCwgdGhlcmUgYXJlIHNldmVyYWwgb3RoZXIgZHJpdmVycyB0aGF0IHVzZXMgdHggbG9jawo+IGlu
IHRoZSB0eCBOQVBJLgo+Cj4gVGhhbmtzCj4KPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

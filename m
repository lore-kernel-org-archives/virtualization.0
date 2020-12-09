Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0882EC2BB48
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9522E23B31
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 14:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9522E23B31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2025587199;
	Wed,  9 Dec 2020 14:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1T-LpIU47oNm; Wed,  9 Dec 2020 14:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE7308718B;
	Wed,  9 Dec 2020 14:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E6B9C0893;
	Wed,  9 Dec 2020 14:02:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD742C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BC6F78753B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pqmyNdQiwdcH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:02:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BD8E382146
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 14:02:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAFD31FB;
 Wed,  9 Dec 2020 06:02:31 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 067D13F66B;
 Wed,  9 Dec 2020 06:02:28 -0800 (PST)
Date: Wed, 9 Dec 2020 14:02:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Message-ID: <20201209140221.GA9087@C02TD0UTHF1T.local>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
 <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
 <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
 <20201209132710.GA8566@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201209132710.GA8566@C02TD0UTHF1T.local>
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDE6Mjc6MTBQTSArMDAwMCwgTWFyayBSdXRsYW5kIHdy
b3RlOgo+IE9uIFN1biwgTm92IDIyLCAyMDIwIGF0IDAxOjQ0OjUzUE0gLTA4MDAsIEFuZHkgTHV0
b21pcnNraSB3cm90ZToKPiA+IE9uIFNhdCwgTm92IDIxLCAyMDIwIGF0IDEwOjU1IFBNIErDvHJn
ZW4gR3Jvw58gPGpncm9zc0BzdXNlLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIDIwLjExLjIwIDEyOjU5
LCBQZXRlciBaaWpsc3RyYSB3cm90ZToKPiA+ID4gPiBJZiBzb21lb25lIHdlcmUgdG8gd3JpdGUg
aG9ycmlibGUgY29kZSBsaWtlOgo+ID4gPiA+Cj4gPiA+ID4gICAgICAgbG9jYWxfaXJxX2Rpc2Fi
bGUoKTsKPiA+ID4gPiAgICAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7Cj4gPiA+ID4gICAgICAg
bG9jYWxfaXJxX2VuYWJsZSgpOwo+ID4gPiA+ICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdz
KTsKPiA+ID4gPgo+ID4gPiA+IHdlJ2QgYmUgdXAgc29tZSBjcmVlayB3aXRob3V0IGEgcGFkZGxl
Li4uIG5vdyBJIGRvbid0IF90aGlua18gd2UgaGF2ZQo+ID4gPiA+IGdlbml1cyBjb2RlIGxpa2Ug
dGhhdCwgYnV0IEknZCBmZWVsIHNhdmVyIGlmIHdlIGNhbiBoYXogYW4gYXNzZXJ0aW9uIGluCj4g
PiA+ID4gdGhlcmUgc29tZXdoZXJlLi4uCgo+IEkgd2FzIGp1c3QgdGFsa2luZyB0byBQZXRlciBv
biBJUkMgYWJvdXQgaW1wbGVtZW50aW5nIHRoZSBzYW1lIHRoaW5nIGZvcgo+IGFybTY0LCBzbyBj
b3VsZCB3ZSBwdXQgdGhpcyBpbiB0aGUgZ2VuZXJpYyBpcnFmbGFncyBjb2RlPyBJSVVDIHdlIGNh
bgo+IHVzZSByYXdfaXJxc19kaXNhYmxlZCgpIHRvIGRvIHRoZSBjaGVjay4KPiAKPiBBcyB0aGlz
IGlzbid0IHJlYWxseSBlbnRyeSBzcGVjaWZpYyAoYW5kIElJVUMgdGhlIGNhc2VzIHRoaXMgc2hv
dWxkCj4gY2F0Y2ggd291bGQgYnJlYWsgbG9ja2RlcCB0b2RheSksIG1heWJlIHdlIHNob3VsZCBh
ZGQgYSBuZXcKPiBERUJVR19JUlFGTEFHUyBmb3IgdGhpcywgdGhhdCBERUJVR19MT0NLREVQIGNh
biBhbHNvIHNlbGVjdD8KPiAKPiBTb21ldGhpbmcgbGlrZToKPiAKPiAjZGVmaW5lIGxvY2FsX2ly
cV9yZXN0b3JlKGZsYWdzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gICAgICAg
IGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAo+ICAgICAgICAgICAgICAgIGlmICghcmF3X2lycXNfZGlzYWJsZWRfZmxhZ3MoZmxhZ3MpKSB7
ICAgICAgICAgIFwKPiAgICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX2hhcmRpcnFzX29uKCk7
ICAgICAgICAgICAgICAgICAgICBcCj4gICAgICAgICAgICAgICAgfSBlbHNlIGlmIChJU19FTkFC
TEVEKENPTkZJR19ERUJVR19JUlFGTEFHUykgeyAgXAo+ICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHVubGlrZWx5KHJhd19pcnFzX2Rpc2FibGVkKCkpICAgICAgIFwKCldob29wczsgdGhhdCBz
aG91bGQgYmUgIXJhd19pcnFzX2Rpc2FibGVkKCkuCgo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB3YXJuX2JvZ3VzX2lycXJlc3RvcmUoKTsgICAgICAgIFwKPiAgICAgICAgICAgICAg
ICB9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gICAg
ICAgICAgICAgICAgcmF3X2xvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsgICAgICAgICAgICAgICAg
ICAgXAo+ICAgICAgICAgfSB3aGlsZSAoMCkKPiAKPiAuLi4gcGVyaGFwcz8gKGlnbm9yaW5nIGhv
d2V2ZXIgd2UgZGVhbCB3aXRoIG9uY2UtbmVzcykuCgpJZiBuby1vbmUgc2hvdXRzIGluIHRoZSBu
ZXh0IGRheSBvciB0d28gSSdsbCBzcGluIHRoaXMgYXMgaXRzIG93biBwYXRjaC4KCk1hcmsuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==

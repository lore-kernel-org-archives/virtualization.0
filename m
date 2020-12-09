Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB8C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 13:27:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ED823BC7
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 13:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED823BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ACB8087864;
	Wed,  9 Dec 2020 13:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6X+h62nkEZa; Wed,  9 Dec 2020 13:27:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC736877D5;
	Wed,  9 Dec 2020 13:27:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2AC9C0893;
	Wed,  9 Dec 2020 13:27:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E401AC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 13:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DFDA786329
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 13:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PzMitFLWNEKz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 13:27:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D4A73861F6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 13:27:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6032831B;
 Wed,  9 Dec 2020 05:27:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.26.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7983F66B;
 Wed,  9 Dec 2020 05:27:17 -0800 (PST)
Date: Wed, 9 Dec 2020 13:27:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Message-ID: <20201209132710.GA8566@C02TD0UTHF1T.local>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
 <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
 <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
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

T24gU3VuLCBOb3YgMjIsIDIwMjAgYXQgMDE6NDQ6NTNQTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOgo+IE9uIFNhdCwgTm92IDIxLCAyMDIwIGF0IDEwOjU1IFBNIErDvHJnZW4gR3Jvw58g
PGpncm9zc0BzdXNlLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gMjAuMTEuMjAgMTI6NTksIFBldGVy
IFppamxzdHJhIHdyb3RlOgo+ID4gPiBPbiBGcmksIE5vdiAyMCwgMjAyMCBhdCAxMjo0NjoyM1BN
ICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOgo+ID4gPj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxp
bmUgdm9pZCBhcmNoX2xvY2FsX2lycV9yZXN0b3JlKHVuc2lnbmVkIGxvbmcgZmxhZ3MpCj4gPiA+
PiArewo+ID4gPj4gKyAgICBpZiAoIWFyY2hfaXJxc19kaXNhYmxlZF9mbGFncyhmbGFncykpCj4g
PiA+PiArICAgICAgICAgICAgYXJjaF9sb2NhbF9pcnFfZW5hYmxlKCk7Cj4gPiA+PiArfQo+ID4g
Pgo+ID4gPiBJZiBzb21lb25lIHdlcmUgdG8gd3JpdGUgaG9ycmlibGUgY29kZSBsaWtlOgo+ID4g
Pgo+ID4gPiAgICAgICBsb2NhbF9pcnFfZGlzYWJsZSgpOwo+ID4gPiAgICAgICBsb2NhbF9pcnFf
c2F2ZShmbGFncyk7Cj4gPiA+ICAgICAgIGxvY2FsX2lycV9lbmFibGUoKTsKPiA+ID4gICAgICAg
bG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwo+ID4gPgo+ID4gPiB3ZSdkIGJlIHVwIHNvbWUgY3Jl
ZWsgd2l0aG91dCBhIHBhZGRsZS4uLiBub3cgSSBkb24ndCBfdGhpbmtfIHdlIGhhdmUKPiA+ID4g
Z2VuaXVzIGNvZGUgbGlrZSB0aGF0LCBidXQgSSdkIGZlZWwgc2F2ZXIgaWYgd2UgY2FuIGhheiBh
biBhc3NlcnRpb24gaW4KPiA+ID4gdGhlcmUgc29tZXdoZXJlLi4uCj4gPiA+Cj4gPiA+IE1heWJl
IHNvbWV0aGluZyBsaWtlOgo+ID4gPgo+ID4gPiAjaWZkZWYgQ09ORklHX0RFQlVHX0VOVFJZIC8v
IGZvciBsYWNrIG9mIHNvbWV0aGluZyBzYW5lcgo+ID4gPiAgICAgICBXQVJOX09OX09OQ0UoKGFy
Y2hfbG9jYWxfc2F2ZV9mbGFncygpIF4gZmxhZ3MpICYgWDg2X0VGTEFHU19JRik7Cj4gPiA+ICNl
bmRpZgo+ID4gPgo+ID4gPiBBdCB0aGUgZW5kPwo+ID4KPiA+IEknZCBsaWtlIHRvLCBidXQgdXNp
bmcgV0FSTl9PTl9PTkNFKCkgaW4gaW5jbHVkZS9hc20vaXJxZmxhZ3MuaCBzb3VuZHMKPiA+IGxp
a2UgYSBwZXJmZWN0IHJlY2VpcHQgZm9yIGluY2x1ZGUgZGVwZW5kZW5jeSBoZWxsLgo+ID4KPiA+
IFdlIGNvdWxkIHVzZSBhIHBsYWluIGFzbSgidWQyIikgaW5zdGVhZC4KPiAKPiBIb3cgYWJvdXQg
b3V0LW9mLWxpbmluZyBpdDoKPiAKPiAjaWZkZWYgQ09ORklHX0RFQlVHX0VOVFJZCj4gZXh0ZXJu
IHZvaWQgd2Fybl9ib2d1c19pcnFyZXN0b3JlKCk7Cj4gI2VuZGlmCj4gCj4gc3RhdGljIF9fYWx3
YXlzX2lubGluZSB2b2lkIGFyY2hfbG9jYWxfaXJxX3Jlc3RvcmUodW5zaWduZWQgbG9uZyBmbGFn
cykKPiB7Cj4gICAgICAgIGlmICghYXJjaF9pcnFzX2Rpc2FibGVkX2ZsYWdzKGZsYWdzKSkgewo+
ICAgICAgICAgICAgICAgIGFyY2hfbG9jYWxfaXJxX2VuYWJsZSgpOwo+ICAgICAgICB9IGVsc2Ug
ewo+ICNpZmRlZiBDT05GSUdfREVCVUdfRU5UUlkKPiAgICAgICAgICAgICAgICBpZiAodW5saWtl
bHkoYXJjaF9sb2NhbF9pcnFfc2F2ZSgpICYgWDg2X0VGTEFHU19JRikpCj4gICAgICAgICAgICAg
ICAgICAgICB3YXJuX2JvZ3VzX2lycXJlc3RvcmUoKTsKPiAjZW5kaWYKPiB9CgpJIHdhcyBqdXN0
IHRhbGtpbmcgdG8gUGV0ZXIgb24gSVJDIGFib3V0IGltcGxlbWVudGluZyB0aGUgc2FtZSB0aGlu
ZyBmb3IKYXJtNjQsIHNvIGNvdWxkIHdlIHB1dCB0aGlzIGluIHRoZSBnZW5lcmljIGlycWZsYWdz
IGNvZGU/IElJVUMgd2UgY2FuCnVzZSByYXdfaXJxc19kaXNhYmxlZCgpIHRvIGRvIHRoZSBjaGVj
ay4KCkFzIHRoaXMgaXNuJ3QgcmVhbGx5IGVudHJ5IHNwZWNpZmljIChhbmQgSUlVQyB0aGUgY2Fz
ZXMgdGhpcyBzaG91bGQKY2F0Y2ggd291bGQgYnJlYWsgbG9ja2RlcCB0b2RheSksIG1heWJlIHdl
IHNob3VsZCBhZGQgYSBuZXcKREVCVUdfSVJRRkxBR1MgZm9yIHRoaXMsIHRoYXQgREVCVUdfTE9D
S0RFUCBjYW4gYWxzbyBzZWxlY3Q/CgpTb21ldGhpbmcgbGlrZToKCiNkZWZpbmUgbG9jYWxfaXJx
X3Jlc3RvcmUoZmxhZ3MpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgIGRv
IHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAog
ICAgICAgICAgICAgICBpZiAoIXJhd19pcnFzX2Rpc2FibGVkX2ZsYWdzKGZsYWdzKSkgeyAgICAg
ICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgdHJhY2VfaGFyZGlycXNfb24oKTsgICAgICAg
ICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgfSBlbHNlIGlmIChJU19FTkFCTEVEKENPTkZJ
R19ERUJVR19JUlFGTEFHUykgeyAgXAogICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2Vs
eShyYXdfaXJxc19kaXNhYmxlZCgpKSAgICAgICBcCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB3YXJuX2JvZ3VzX2lycXJlc3RvcmUoKTsgICAgICAgIFwKICAgICAgICAgICAgICAgfSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAogICAgICAgICAg
ICAgICByYXdfbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOyAgICAgICAgICAgICAgICAgICBcCiAg
ICAgICAgfSB3aGlsZSAoMCkKCi4uLiBwZXJoYXBzPyAoaWdub3JpbmcgaG93ZXZlciB3ZSBkZWFs
IHdpdGggb25jZS1uZXNzKS4KClRoYW5rcywKTWFyay4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

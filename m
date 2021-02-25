Return-Path: <SRS0=rmzs=H3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF94DC433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 12:13:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE88601FE
	for <virtualization@archiver.kernel.org>; Thu, 25 Feb 2021 12:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE88601FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AEC854322A;
	Thu, 25 Feb 2021 12:13:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FjE5wkDkwR02; Thu, 25 Feb 2021 12:13:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 469BD43127;
	Thu, 25 Feb 2021 12:13:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 178D3C000A;
	Thu, 25 Feb 2021 12:13:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F20C0C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEE3A4D19D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:13:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4pLRvhuUVmT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:13:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 108754B524
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 12:13:12 +0000 (UTC)
Received: from zn.tnic (p200300ec2f03dc0059e4821217d1e808.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f03:dc00:59e4:8212:17d1:e808])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD79C1EC052A;
 Thu, 25 Feb 2021 13:13:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1614255189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uowjjR43yhHROzZrr8+GTPAe1G0Z7p+VXIsXmHZT/DI=;
 b=C7l6RDM9UJMC40fLu4YLfez5BF6dXTtgOjtsFeZ/yBsJes9E+fS6f7NKObR7VNz8+enqge
 oZxlN/KVgnpBzKfk8dFfgDpWPFElVwVzwKnICt6v34WSqLKFNRlg3fvdIsUv7gp7wsl9Lr
 BQe/61MPSqaoFWiR09QP9VR+WflWms8=
Date: Thu, 25 Feb 2021 13:13:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/7] x86/boot/compressed/64: Add 32-bit boot #VC handler
Message-ID: <20210225121308.GB380@zn.tnic>
References: <20210210102135.30667-1-joro@8bytes.org>
 <20210210102135.30667-5-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210210102135.30667-5-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

T24gV2VkLCBGZWIgMTAsIDIwMjEgYXQgMTE6MjE6MzJBTSArMDEwMCwgSm9lcmcgUm9lZGVsIHdy
b3RlOgo+IEZyb206IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPgo+IAo+IEFkZCBhICNW
QyBleGNlcHRpb24gaGFuZGxlciB3aGljaCBpcyB1c2VkIHdoZW4gdGhlIGtlcm5lbCBzdGlsbCBl
eGVjdXRlcwo+IGluIHByb3RlY3RlZCBtb2RlLiBUaGlzIGJvb3QtcGF0aCBhbHJlYWR5IHVzZXMg
Q1BVSUQsIHdoaWNoIHdpbGwgY2F1c2UgI1ZDCj4gZXhjZXB0aW9ucyBpbiBhbiBTRVYtRVMgZ3Vl
c3QuCj4gCj4gU2lnbmVkLW9mZi1ieTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4g
LS0tCj4gIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9oZWFkXzY0LlMgICAgIHwgIDYgKysKPiAg
YXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL21lbV9lbmNyeXB0LlMgfCA3NyArKysrKysrKysrKysr
KysrKysrKysrKysrLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2hlYWRf
NjQuUyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9oZWFkXzY0LlMKPiBpbmRleCA4ZGVlZWM3
OGNkYjQuLmVhZGFhMGEwODJiOCAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNz
ZWQvaGVhZF82NC5TCj4gKysrIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2hlYWRfNjQuUwo+
IEBAIC0zNCw2ICszNCw3IEBACj4gICNpbmNsdWRlIDxhc20vYXNtLW9mZnNldHMuaD4KPiAgI2lu
Y2x1ZGUgPGFzbS9ib290cGFyYW0uaD4KPiAgI2luY2x1ZGUgPGFzbS9kZXNjX2RlZnMuaD4KPiAr
I2luY2x1ZGUgPGFzbS90cmFwbnIuaD4KPiAgI2luY2x1ZGUgInBndGFibGUuaCIKPiAgCj4gIC8q
Cj4gQEAgLTg1Niw2ICs4NTcsMTEgQEAgU1lNX0ZVTkNfU1RBUlQoc3RhcnR1cDMyX3NldF9pZHRf
ZW50cnkpCj4gIFNZTV9GVU5DX0VORChzdGFydHVwMzJfc2V0X2lkdF9lbnRyeSkKPiAgCj4gIFNZ
TV9GVU5DX1NUQVJUKHN0YXJ0dXAzMl9sb2FkX2lkdCkKPiArCS8qICNWQyBoYW5kbGVyICovCj4g
KwlsZWFsICAgIHJ2YShzdGFydHVwMzJfdmNfaGFuZGxlcikoJWVicCksICVlYXgKPiArCW1vdmwg
ICAgJFg4Nl9UUkFQX1ZDLCAlZWR4Cj4gKwljYWxsICAgIHN0YXJ0dXAzMl9zZXRfaWR0X2VudHJ5
Cj4gKwo+ICAJLyogTG9hZCBJRFQgKi8KPiAgCWxlYWwJcnZhKGJvb3QzMl9pZHQpKCVlYnApLCAl
ZWF4Cj4gIAltb3ZsCSVlYXgsIHJ2YShib290MzJfaWR0X2Rlc2MrMikoJWVicCkKPiBkaWZmIC0t
Z2l0IGEvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL21lbV9lbmNyeXB0LlMgYi9hcmNoL3g4Ni9i
b290L2NvbXByZXNzZWQvbWVtX2VuY3J5cHQuUwo+IGluZGV4IGFhNTYxNzk1ZWZkMS4uMzUwZWNi
NTZjN2U0IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9tZW1fZW5jcnlw
dC5TCj4gKysrIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL21lbV9lbmNyeXB0LlMKPiBAQCAt
NjcsMTAgKzY3LDg1IEBAIFNZTV9GVU5DX1NUQVJUKGdldF9zZXZfZW5jcnlwdGlvbl9iaXQpCj4g
IAlyZXQKPiAgU1lNX0ZVTkNfRU5EKGdldF9zZXZfZW5jcnlwdGlvbl9iaXQpCj4gIAo+ICsvKgo+
ICsgKiBFbWl0IGNvZGUgdG8gcmVxdWVzdCBhbiBDUFVJRCByZWdpc3RlciBmcm9tIHRoZSBIeXBl
cnZpc29yIHVzaW5nCj4gKyAqIHRoZSBNU1ItYmFzZWQgcHJvdG9jb2wuCj4gKyAqCj4gKyAqIGZu
OiBUaGUgcmVnaXN0ZXIgY29udGFpbmluZyB0aGUgQ1BVSUQgZnVuY3Rpb24KPiArICogcmVnOiBS
ZWdpc3RlciByZXF1ZXN0ZWQKPiArICoJMSA9IEVBWAo+ICsgKgkyID0gRUJYCj4gKyAqCTMgPSBF
Q1gKPiArICoJNCA9IEVEWAo+ICsgKgo+ICsgKiBSZXN1bHQgaXMgaW4gRURYLiBKdW1wcyB0byAu
TGZhaWwgb24gZXJyb3IKPiArICovCj4gKy5tYWNybwlTRVZfRVNfUkVRX0NQVUlEIGZuOnJlcSBy
ZWc6cmVxCgpJJ20gd29uZGVyaW5nIC0gaW5zdGVhZCBvZiByZXBsaWNhdGluZyB0aGlzIDQgdGlt
ZXMsIGNhbiB0aGlzIGJlIGEKZnVuY3Rpb24gd2hpY2ggeW91IENBTEw/IFlvdSBkbyBoYXZlIGEg
c3RhY2sgc28geW91IHNob3VsZCBiZSBhYmxlIHRvLgoKPiArCS8qIFJlcXVlc3QgQ1BVSURbJWVi
eF0uRUFYICovCj4gKwltb3ZsCSRccmVnLCAlZWF4Cj4gKwlzaGxsCSQzMCwgJWVheAo+ICsJb3Js
CSQweDAwMDAwMDA0LCAlZWF4Cj4gKwltb3ZsCVxmbiwgJWVkeAo+ICsJbW92bAkkTVNSX0FNRDY0
X1NFVl9FU19HSENCLCAlZWN4Cj4gKwl3cm1zcgo+ICsJcmVwOyB2bW1jYWxsCj4gKwlyZG1zcgo+
ICsJLyogQ2hlY2sgcmVzcG9uc2UgY29kZSAqLwoKQmVmb3JlIHlvdSBkbyB0aGF0LCBJIGd1ZXNz
IHlvdSB3YW5uYSBjaGVjazoKCkdIQ0JEYXRhWzI5OjEyXSDigJMgUmVzZXJ2ZWQsIG11c3QgYmUg
emVybwoKaW4gdGhlIEhWIHJlc3BvbnNlLgoKVGh4LgoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBC
b3Jpcy4KCmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVl
dHRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

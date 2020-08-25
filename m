Return-Path: <SRS0=1X+q=CD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E74C433E3
	for <virtualization@archiver.kernel.org>; Tue, 25 Aug 2020 06:24:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFC4120782
	for <virtualization@archiver.kernel.org>; Tue, 25 Aug 2020 06:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC4120782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 66721226F5;
	Tue, 25 Aug 2020 06:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hdoj6y431rY; Tue, 25 Aug 2020 06:24:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D1F7320458;
	Tue, 25 Aug 2020 06:24:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB81DC016F;
	Tue, 25 Aug 2020 06:24:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF87BC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 06:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DDF5D87D36
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 06:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OHtnud2NOVC8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 06:24:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 329C787CCB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 06:24:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A98B5AC23;
 Tue, 25 Aug 2020 06:24:57 +0000 (UTC)
Date: Tue, 25 Aug 2020 08:24:23 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Mike Stunes <mstunes@vmware.com>
Subject: Re: [PATCH v6 00/76] x86: SEV-ES Guest Support
Message-ID: <20200825062423.GS3354@suse.de>
References: <20200824085511.7553-1-joro@8bytes.org>
 <D0B35ACA-7220-45DD-B524-0AFD6BE7BA3D@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D0B35ACA-7220-45DD-B524-0AFD6BE7BA3D@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
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

SGkgTWlrZSwKCk9uIFR1ZSwgQXVnIDI1LCAyMDIwIGF0IDEyOjIxOjAzQU0gKzAwMDAsIE1pa2Ug
U3R1bmVzIHdyb3RlOgo+IFRoYW5rcyBmb3IgdGhlIG5ldyB1cGRhdGUhIEkgc3RpbGwgc2VlIHRo
ZSBzYW1lIEZTR1NCQVNFIGJlaGF2aW9yIG9uIG91ciBwbGF0Zm9ybS4KPiAKPiBUaGF0IGlzLCBB
UHMgY29tZSB1cCBvZmZsaW5lOyBtYXNraW5nIG91dCBlaXRoZXIgRlNHU0JBU0Ugb3IgUkRQSUQg
ZnJvbSB0aGUKPiBndWVzdCdzIENQVUlEIHJlc3VsdHMgaW4gYWxsIENQVXMgb25saW5lLgo+IAo+
IElzIHRoYXQgc3RpbGwgZXhwZWN0ZWQgd2l0aCB0aGlzIHBhdGNoIHNldD8gKEFzIHlvdSBtZW50
aW9uZWQgaW4gYW4gZWFybGllciByZXBseSwKPiBJ4oCZbSB0ZXN0aW5nIG9uIGEgUm9tZSBzeXN0
ZW0uKQoKVGhlIFJEUElEIGZpeCAocmVtb3ZpbmcgUkRQSUQgdXNhZ2UgZnJvbSBwYXJhbm9pZF9l
bnRyeSkgaXMgcHJvYmFibHkgbm90CnlldCBtZXJnZWQgaW50byB0aGUgYmFzZSB5b3UgaGF2ZSBi
ZWVuIHVzaW5nLiBCdXQgcmVtb3ZpbmcgUkRQSUQgZnJvbQpDUFVJRCBzaG91bGQgbWFrZSB0aGlu
Z3Mgd29yayB1bnRpbCB0aGUgZml4IGlzIG1lcmdlZC4KClJlZ2FyZHMsCgoJSm9lcmcKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u

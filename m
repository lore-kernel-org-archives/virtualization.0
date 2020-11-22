Return-Path: <SRS0=d/Rn=E4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FADC63697
	for <virtualization@archiver.kernel.org>; Sun, 22 Nov 2020 21:45:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE7720782
	for <virtualization@archiver.kernel.org>; Sun, 22 Nov 2020 21:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2o1jrHuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE7720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C094C85C54;
	Sun, 22 Nov 2020 21:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JdKCt3X1e4CC; Sun, 22 Nov 2020 21:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A13FA85B0D;
	Sun, 22 Nov 2020 21:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DACDC0891;
	Sun, 22 Nov 2020 21:45:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D62DC0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Nov 2020 21:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2250A867BD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Nov 2020 21:45:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 34RZ1NWX47pE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Nov 2020 21:45:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8FF4A867BC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Nov 2020 21:45:08 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B80AF20789
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Nov 2020 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606081508;
 bh=j8kQr1sqydOsvjEY9shLB0wmUrzUic9iCe1dNmPahV0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2o1jrHuQqj+owOO+c9Zeqxrd9M6szemlUmJSqcWPhibowyO6pXzhHfe+VU2CVHSEx
 6i9l1pH/OrjB/ycgmevivnDyFQfhPd0sDLvyPdoRmGLzLfeZdce65//c9hJPyiAb0C
 IF/2dwA3JwvzN2WhaDRzodNq4IxJJOJIIJXD3gjA=
Received: by mail-wm1-f44.google.com with SMTP id w24so15582190wmi.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Nov 2020 13:45:07 -0800 (PST)
X-Gm-Message-State: AOAM5333ucQynVVQXyS4GjNJLneFRJTjNRILhawN4l7TybceS0K/nWy9
 N0qWLzfbf+sSNiftZHp+ZoVsunMAHIJ5R8jB+D3jXw==
X-Google-Smtp-Source: ABdhPJwifakpgwUVTLbeDBYdoVmnAfRpiEVwGa2XrrCKUuyY/SYxT6I31Kv43oa6WFJkbjZ+4GFZn5n4pemXbXWt+C8=
X-Received: by 2002:a1c:2781:: with SMTP id n123mr3937832wmn.49.1606081506352; 
 Sun, 22 Nov 2020 13:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net>
 <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
In-Reply-To: <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 22 Nov 2020 13:44:53 -0800
X-Gmail-Original-Message-ID: <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
Message-ID: <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andrew Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel <xen-devel@lists.xenproject.org>,
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

T24gU2F0LCBOb3YgMjEsIDIwMjAgYXQgMTA6NTUgUE0gSsO8cmdlbiBHcm/DnyA8amdyb3NzQHN1
c2UuY29tPiB3cm90ZToKPgo+IE9uIDIwLjExLjIwIDEyOjU5LCBQZXRlciBaaWpsc3RyYSB3cm90
ZToKPiA+IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDEyOjQ2OjIzUE0gKzAxMDAsIEp1ZXJnZW4g
R3Jvc3Mgd3JvdGU6Cj4gPj4gK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBhcmNoX2xvY2Fs
X2lycV9yZXN0b3JlKHVuc2lnbmVkIGxvbmcgZmxhZ3MpCj4gPj4gK3sKPiA+PiArICAgIGlmICgh
YXJjaF9pcnFzX2Rpc2FibGVkX2ZsYWdzKGZsYWdzKSkKPiA+PiArICAgICAgICAgICAgYXJjaF9s
b2NhbF9pcnFfZW5hYmxlKCk7Cj4gPj4gK30KPiA+Cj4gPiBJZiBzb21lb25lIHdlcmUgdG8gd3Jp
dGUgaG9ycmlibGUgY29kZSBsaWtlOgo+ID4KPiA+ICAgICAgIGxvY2FsX2lycV9kaXNhYmxlKCk7
Cj4gPiAgICAgICBsb2NhbF9pcnFfc2F2ZShmbGFncyk7Cj4gPiAgICAgICBsb2NhbF9pcnFfZW5h
YmxlKCk7Cj4gPiAgICAgICBsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7Cj4gPgo+ID4gd2UnZCBi
ZSB1cCBzb21lIGNyZWVrIHdpdGhvdXQgYSBwYWRkbGUuLi4gbm93IEkgZG9uJ3QgX3RoaW5rXyB3
ZSBoYXZlCj4gPiBnZW5pdXMgY29kZSBsaWtlIHRoYXQsIGJ1dCBJJ2QgZmVlbCBzYXZlciBpZiB3
ZSBjYW4gaGF6IGFuIGFzc2VydGlvbiBpbgo+ID4gdGhlcmUgc29tZXdoZXJlLi4uCj4gPgo+ID4g
TWF5YmUgc29tZXRoaW5nIGxpa2U6Cj4gPgo+ID4gI2lmZGVmIENPTkZJR19ERUJVR19FTlRSWSAv
LyBmb3IgbGFjayBvZiBzb21ldGhpbmcgc2FuZXIKPiA+ICAgICAgIFdBUk5fT05fT05DRSgoYXJj
aF9sb2NhbF9zYXZlX2ZsYWdzKCkgXiBmbGFncykgJiBYODZfRUZMQUdTX0lGKTsKPiA+ICNlbmRp
Zgo+ID4KPiA+IEF0IHRoZSBlbmQ/Cj4KPiBJJ2QgbGlrZSB0bywgYnV0IHVzaW5nIFdBUk5fT05f
T05DRSgpIGluIGluY2x1ZGUvYXNtL2lycWZsYWdzLmggc291bmRzCj4gbGlrZSBhIHBlcmZlY3Qg
cmVjZWlwdCBmb3IgaW5jbHVkZSBkZXBlbmRlbmN5IGhlbGwuCj4KPiBXZSBjb3VsZCB1c2UgYSBw
bGFpbiBhc20oInVkMiIpIGluc3RlYWQuCgpIb3cgYWJvdXQgb3V0LW9mLWxpbmluZyBpdDoKCiNp
ZmRlZiBDT05GSUdfREVCVUdfRU5UUlkKZXh0ZXJuIHZvaWQgd2Fybl9ib2d1c19pcnFyZXN0b3Jl
KCk7CiNlbmRpZgoKc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGFyY2hfbG9jYWxfaXJxX3Jl
c3RvcmUodW5zaWduZWQgbG9uZyBmbGFncykKewogICAgICAgaWYgKCFhcmNoX2lycXNfZGlzYWJs
ZWRfZmxhZ3MoZmxhZ3MpKSB7CiAgICAgICAgICAgICAgIGFyY2hfbG9jYWxfaXJxX2VuYWJsZSgp
OwogICAgICAgfSBlbHNlIHsKI2lmZGVmIENPTkZJR19ERUJVR19FTlRSWQogICAgICAgICAgICAg
ICBpZiAodW5saWtlbHkoYXJjaF9sb2NhbF9pcnFfc2F2ZSgpICYgWDg2X0VGTEFHU19JRikpCiAg
ICAgICAgICAgICAgICAgICAgd2Fybl9ib2d1c19pcnFyZXN0b3JlKCk7CiNlbmRpZgp9Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==

Return-Path: <SRS0=KpU2=E5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E20C56202
	for <virtualization@archiver.kernel.org>; Mon, 23 Nov 2020 15:41:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51602080A
	for <virtualization@archiver.kernel.org>; Mon, 23 Nov 2020 15:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="yVT8mRm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51602080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 579FB866FB;
	Mon, 23 Nov 2020 15:41:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kDjwMHTB6P+g; Mon, 23 Nov 2020 15:41:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C5F7866AB;
	Mon, 23 Nov 2020 15:41:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CF66C0891;
	Mon, 23 Nov 2020 15:41:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A03CC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E7511866EF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:41:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HzibbgFk-Zkq
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:41:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 15FBD866AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 15:41:17 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id e8so3338764pfh.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Nov 2020 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amacapital-net.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=9/7B9fYOBF3iBNDP75oo3XjDT3J214mKbuz8gALB4vU=;
 b=yVT8mRm3Z3LX4kK+1gmW0OdDkKPQsxQqCiNqqyao3OeXSp3AeU/oUDBO2LFha72Ykg
 hfakFOwwGzMWTxhbJ9u4ZRrLs9E+AUi3bUdWX7FF9C1AL9DI7uzuPx703IMYlUpEfQ0R
 cKbQk2gp7fkskTTopdejNkIPV40k3NdJdEWpv8NlYlb+lwXNFQ7m4QTsPwnXAY41XDjo
 ie2xHVuANYQFTwR5JV4GsFGoOojFILHnydRahEGFMrSdyzuTcX1MyaggfyX5GhzN48f7
 dxYqGPnL5YK+lGPBgsFICbFcJ3HdWvHqDNfvP4QmHS7Z6Td+jfStdZ8S8kzdPOmMP3XW
 IYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=9/7B9fYOBF3iBNDP75oo3XjDT3J214mKbuz8gALB4vU=;
 b=cHBGcTC/kSGO4qqk4cxQygRiaLwxQq7Dw5FTWn3Bscva6QIIMlip7ekEw1ZnoRAZvb
 RQ6UP9DMm6rCU2hO/oCUFFXZPx9LLRvAxsuI+fkPrpcHKQd+ifkQtI1g/EUHddJhCJQ4
 9mKs4Ftu9ci5EaZdCEj5U4pqb9hY4+xMLIT376HnCqEaQ205JevoBIeFOZDdEl7CxYVt
 6KjO5rsjb0Q1MzYTHf0H1telfZued4QYF1WmgljB6So4ldKNbpecxXWPxZtDgfCtsOJG
 jgMIL3oS1bYnSEsXjVqaKseNgvlEvnyB9ffgQMsNl1w+mE7uDT0kdXt++dkg6gmbihoj
 PkQA==
X-Gm-Message-State: AOAM5322ribrhRJPTQRSZUgx3t0y7iOCxM+bH1fNcU9uz5NOCL5VGbSr
 LZljoeEctDz26HT9kLlsQkBfoKodQozj4yNI
X-Google-Smtp-Source: ABdhPJzPXkVRGeAzX8ONsYwMK6/RMdfFNxyslupj1imDDyoMb4VPUrwfTY+HgnKVxxx/unH4Oe4Vhw==
X-Received: by 2002:a17:902:d207:b029:da:13cb:e182 with SMTP id
 t7-20020a170902d207b02900da13cbe182mr1831784ply.69.1606144520547; 
 Mon, 23 Nov 2020 07:15:20 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:344b:912a:a361:223f?
 ([2601:646:c200:1ef2:344b:912a:a361:223f])
 by smtp.gmail.com with ESMTPSA id g3sm3460848pfr.145.2020.11.23.07.15.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2020 07:15:19 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use
 popf
Date: Mon, 23 Nov 2020 07:15:18 -0800
Message-Id: <DD12CB44-457E-4FE1-8240-B334B785A93C@amacapital.net>
References: <894a4cec-8426-4152-d391-474711040c5b@suse.com>
In-Reply-To: <894a4cec-8426-4152-d391-474711040c5b@suse.com>
To: =?utf-8?Q?J=C3=BCrgen_Gro=C3=9F?= <jgross@suse.com>
X-Mailer: iPhone Mail (18B92)
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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

CgoKCj4gT24gTm92IDIyLCAyMDIwLCBhdCA5OjIyIFBNLCBKw7xyZ2VuIEdyb8OfIDxqZ3Jvc3NA
c3VzZS5jb20+IHdyb3RlOgo+IAo+IO+7v09uIDIyLjExLjIwIDIyOjQ0LCBBbmR5IEx1dG9taXJz
a2kgd3JvdGU6Cj4+PiBPbiBTYXQsIE5vdiAyMSwgMjAyMCBhdCAxMDo1NSBQTSBKw7xyZ2VuIEdy
b8OfIDxqZ3Jvc3NAc3VzZS5jb20+IHdyb3RlOgo+Pj4gCj4+PiBPbiAyMC4xMS4yMCAxMjo1OSwg
UGV0ZXIgWmlqbHN0cmEgd3JvdGU6Cj4+Pj4gT24gRnJpLCBOb3YgMjAsIDIwMjAgYXQgMTI6NDY6
MjNQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToKPj4+Pj4gK3N0YXRpYyBfX2Fsd2F5c19p
bmxpbmUgdm9pZCBhcmNoX2xvY2FsX2lycV9yZXN0b3JlKHVuc2lnbmVkIGxvbmcgZmxhZ3MpCj4+
Pj4+ICt7Cj4+Pj4+ICsgICAgaWYgKCFhcmNoX2lycXNfZGlzYWJsZWRfZmxhZ3MoZmxhZ3MpKQo+
Pj4+PiArICAgICAgICAgICAgYXJjaF9sb2NhbF9pcnFfZW5hYmxlKCk7Cj4+Pj4+ICt9Cj4+Pj4g
Cj4+Pj4gSWYgc29tZW9uZSB3ZXJlIHRvIHdyaXRlIGhvcnJpYmxlIGNvZGUgbGlrZToKPj4+PiAK
Pj4+PiAgICAgICBsb2NhbF9pcnFfZGlzYWJsZSgpOwo+Pj4+ICAgICAgIGxvY2FsX2lycV9zYXZl
KGZsYWdzKTsKPj4+PiAgICAgICBsb2NhbF9pcnFfZW5hYmxlKCk7Cj4+Pj4gICAgICAgbG9jYWxf
aXJxX3Jlc3RvcmUoZmxhZ3MpOwo+Pj4+IAo+Pj4+IHdlJ2QgYmUgdXAgc29tZSBjcmVlayB3aXRo
b3V0IGEgcGFkZGxlLi4uIG5vdyBJIGRvbid0IF90aGlua18gd2UgaGF2ZQo+Pj4+IGdlbml1cyBj
b2RlIGxpa2UgdGhhdCwgYnV0IEknZCBmZWVsIHNhdmVyIGlmIHdlIGNhbiBoYXogYW4gYXNzZXJ0
aW9uIGluCj4+Pj4gdGhlcmUgc29tZXdoZXJlLi4uCj4+Pj4gCj4+Pj4gTWF5YmUgc29tZXRoaW5n
IGxpa2U6Cj4+Pj4gCj4+Pj4gI2lmZGVmIENPTkZJR19ERUJVR19FTlRSWSAvLyBmb3IgbGFjayBv
ZiBzb21ldGhpbmcgc2FuZXIKPj4+PiAgICAgICBXQVJOX09OX09OQ0UoKGFyY2hfbG9jYWxfc2F2
ZV9mbGFncygpIF4gZmxhZ3MpICYgWDg2X0VGTEFHU19JRik7Cj4+Pj4gI2VuZGlmCj4+Pj4gCj4+
Pj4gQXQgdGhlIGVuZD8KPj4+IAo+Pj4gSSdkIGxpa2UgdG8sIGJ1dCB1c2luZyBXQVJOX09OX09O
Q0UoKSBpbiBpbmNsdWRlL2FzbS9pcnFmbGFncy5oIHNvdW5kcwo+Pj4gbGlrZSBhIHBlcmZlY3Qg
cmVjZWlwdCBmb3IgaW5jbHVkZSBkZXBlbmRlbmN5IGhlbGwuCj4+PiAKPj4+IFdlIGNvdWxkIHVz
ZSBhIHBsYWluIGFzbSgidWQyIikgaW5zdGVhZC4KPj4gSG93IGFib3V0IG91dC1vZi1saW5pbmcg
aXQ6Cj4+ICNpZmRlZiBDT05GSUdfREVCVUdfRU5UUlkKPj4gZXh0ZXJuIHZvaWQgd2Fybl9ib2d1
c19pcnFyZXN0b3JlKCk7Cj4+ICNlbmRpZgo+PiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQg
YXJjaF9sb2NhbF9pcnFfcmVzdG9yZSh1bnNpZ25lZCBsb25nIGZsYWdzKQo+PiB7Cj4+ICAgICAg
ICBpZiAoIWFyY2hfaXJxc19kaXNhYmxlZF9mbGFncyhmbGFncykpIHsKPj4gICAgICAgICAgICAg
ICAgYXJjaF9sb2NhbF9pcnFfZW5hYmxlKCk7Cj4+ICAgICAgICB9IGVsc2Ugewo+PiAjaWZkZWYg
Q09ORklHX0RFQlVHX0VOVFJZCj4+ICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShhcmNoX2xv
Y2FsX2lycV9zYXZlKCkgJiBYODZfRUZMQUdTX0lGKSkKPj4gICAgICAgICAgICAgICAgICAgICB3
YXJuX2JvZ3VzX2lycXJlc3RvcmUoKTsKPj4gI2VuZGlmCj4+IH0KPiAKPiBUaGlzIGNvdWxkbid0
IGJlIGEgV0FSTl9PTl9PTkNFKCkgdGhlbiAob3IgaXQgd291bGQgYmUgYSBjYXRjaCBhbGwpLgoK
SWYgeW91IHB1dCB0aGUgV0FSTl9PTl9PTkNFIGluIHRoZSBvdXQtb2YtbGluZSBoZWxwZXIsIGl0
IHNob3VsZCB3b3JrIHJlYXNvbmFibHkgd2VsbC4KCj4gQW5vdGhlciBhcHByb2FjaCBtaWdodCBi
ZSB0byBvcGVuLWNvZGUgdGhlIFdBUk5fT05fT05DRSgpLCBsaWtlOgo+IAo+ICNpZmRlZiBDT05G
SUdfREVCVUdfRU5UUlkKPiBleHRlcm4gdm9pZCB3YXJuX2JvZ3VzX2lycXJlc3RvcmUoYm9vbCAq
b25jZSk7Cj4gI2VuZGlmCj4gCj4gc3RhdGljIF9fYWx3YXlzX2lubGluZSB2b2lkIGFyY2hfbG9j
YWxfaXJxX3Jlc3RvcmUodW5zaWduZWQgbG9uZyBmbGFncykKPiB7Cj4gICAgaWYgKCFhcmNoX2ly
cXNfZGlzYWJsZWRfZmxhZ3MoZmxhZ3MpKQo+ICAgICAgICBhcmNoX2xvY2FsX2lycV9lbmFibGUo
KTsKPiAjaWZkZWYgQ09ORklHX0RFQlVHX0VOVFJZCj4gICAgewo+ICAgICAgICBzdGF0aWMgYm9v
bCBvbmNlOwo+IAo+ICAgICAgICBpZiAodW5saWtlbHkoYXJjaF9sb2NhbF9pcnFfc2F2ZSgpICYg
WDg2X0VGTEFHU19JRikpCj4gICAgICAgICAgICB3YXJuX2JvZ3VzX2lycXJlc3RvcmUoJm9uY2Up
Owo+ICAgIH0KPiAjZW5kaWYKPiB9Cj4gCgpJIGRvbuKAmXQga25vdyBwcmVjaXNlbHkgd2hhdCBh
IHN0YXRpYyB2YXJpYWJsZSBpbiBhbiBfX2Fsd2F5c19pbmxpbmUgZnVuY3Rpb24gd2lsbCBkbywg
YnV0IEkgaW1hZ2luZSBpdCB3aWxsIGJlLCBhdCBiZXN0LCBlcnJhdGljLCBlc3BlY2lhbGx5IHdo
ZW4gbW9kdWxlcyBhcmUgaW52b2x2ZWQuCgo+IAo+IEp1ZXJnZW4KPiA8T3BlblBHUF8weEIwREU5
REQ2MjhCRjEzMkYuYXNjPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

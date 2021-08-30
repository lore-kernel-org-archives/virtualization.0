Return-Path: <SRS0=/Kss=NV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3482C432BE
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 05:11:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6A660F44
	for <virtualization@archiver.kernel.org>; Mon, 30 Aug 2021 05:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C6A660F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40968403EC;
	Mon, 30 Aug 2021 05:11:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYCvkN48bhp0; Mon, 30 Aug 2021 05:11:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1B274041F;
	Mon, 30 Aug 2021 05:11:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8428EC001A;
	Mon, 30 Aug 2021 05:11:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 611CCC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46D8A80EBA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oiYfoG0DR2tp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:11:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D66C80E88
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:11:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="218248921"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; d="scan'208";a="218248921"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2021 22:11:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; d="scan'208";a="497257549"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.238.58])
 ([10.212.238.58])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2021 22:11:47 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
Date: Sun, 29 Aug 2021 22:11:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829181635-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-arch <linux-arch@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-alpha@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
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

Ck9uIDgvMjkvMjAyMSAzOjI2IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24gU3Vu
LCBBdWcgMjksIDIwMjEgYXQgMDk6MTc6NTNBTSAtMDcwMCwgQW5kaSBLbGVlbiB3cm90ZToKPj4g
QWxzbyBJIGNoYW5naW5nIHRoaXMgc2luZ2xlIGNhbGwgcmVhbGx5IHRoYXQgYmFkPyBJdCdzIG5v
dCB0aGF0IHdlIGNoYW5naW5nCj4+IGFueXRoaW5nIGRyYXN0aWMgaGVyZSwganVzdCBnaXZlIHRo
ZSBsb3cgbGV2ZWwgc3Vic3lzdGVtIGEgYmV0dGVyIGhpbnQgYWJvdXQKPj4gdGhlIGludGVudGlv
bi4gSWYgeW91IGRvbid0IGxpa2UgdGhlIGZ1bmN0aW9uIG5hbWUsIGNvdWxkIG1ha2UgaXQgYW4K
Pj4gYXJndW1lbnQgaW5zdGVhZD8KPiBNeSBwb2ludCBob3dldmVyIGlzIHRoYXQgdGhlIEFQSSBz
aG91bGQgc2F5IHRoYXQgdGhlCj4gZHJpdmVyIGhhcyBiZWVuIGF1ZGl0ZWQsCgpXZSBoYXZlIHRo
YXQgc3RhdHVzIGluIHRoZSBzdHJ1Y3QgZGV2aWNlLiBJZiB5b3Ugd2FudCB0byB0aWUgdGhlIGlv
cmVtYXAgCnRvIHRoYXQgd2UgY291bGQgZGVmaW5lIGEgaW9yZW1hcF9kZXZpY2UoKSB3aXRoIGEg
ZGV2aWNlIGFyZ3VtZW50IGFuZCAKZGVjaWRlIGJhc2VkIG9uIHRoYXQuCgpPciB3ZSBjYW4gYWRk
IF9hdWRpdGVkIHRvIHRoZSBuYW1lLiBpb3JlbWFwX3NoYXJlZF9hdWRpdGVkPwoKPiBub3QgdGhh
dCB0aGUgbWFwcGluZyBoYXMgYmVlbgo+IGRvbmUgaW4gc29tZSBzcGVjaWFsIHdheS4gRm9yIGV4
YW1wbGUgdGhlIG1hcHBpbmcgY2FuIGJlCj4gaW4gc29tZSBraW5kIG9mIHdyYXBwZXIsIG5vdCBk
aXJlY3RseSBpbiB0aGUgZHJpdmVyLgo+IEhvd2V2ZXIgeW91IHdhbnQgdGhlIGRyaXZlciB2YWxp
ZGF0ZWQsIG5vdCB0aGUgd3JhcHBlci4KPgo+IEhlcmUncyBhbiBpZGVhOgoKCkkgZG9uJ3QgdGhp
bmsgbWFnaWMgZGlmZmVyZW5jZXMgb2YgQVBJIGJlaGF2aW9yIGJhc2VkIG9uIHNvbWUgZGVmaW5l
IGFyZSAKYSBnb29kIGlkZWEuwqAgVGhhdCdzIGVhc3kgdG8gbWlzcy4KClRoYXQncyBhICJDT01F
IEZST00iIGluIEFQSSBkZXNpZ24uCgpBbHNvIGl0IHdvdWxkbid0IGhhbmRsZSB0aGUgY2FzZSB0
aGF0IGEgZHJpdmVyIGhhcyBib3RoIHByaXZhdGUgYW5kIApzaGFyZWQgaW9yZW1hcHMsIGUuZy4g
Zm9yIEJJT1Mgc3RydWN0dXJlcy4KCkFuZCB3ZSd2ZSBiZWVuIGF2b2lkaW5nIHRoYXQgZHJpdmVy
cyBjYW4gc2VsZiBkZWNsYXJlIGF1ZGl0aW5nLCB3ZSd2ZSAKYmVlbiB0cnlpbmcgdG8gaGF2ZSBh
IHNlcGFyYXRlIGNlbnRyYWxpemVkIGxpc3Qgc28gdGhhdCBpdCdzIGVhc2llciB0byAKZW5mb3Jj
ZSBhbmQgYXZvaWRzIGFueSBjdXQnbidwYXN0ZSBtaXN0YWtlcy4KCi1BbmRpCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=

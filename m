Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24542C433DF
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 18:43:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E996722B4E
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 18:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E996722B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8AD892035B;
	Mon, 10 Aug 2020 18:43:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQ5l5mR-4lr9; Mon, 10 Aug 2020 18:42:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E5F1F2014B;
	Mon, 10 Aug 2020 18:42:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B048DC013C;
	Mon, 10 Aug 2020 18:42:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24EDCC004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 18:42:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E7AA42035B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 18:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qV0IXpQ8MWsz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 18:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 9C9FA2014B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 18:42:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D34E6AB55;
 Mon, 10 Aug 2020 18:43:12 +0000 (UTC)
Subject: Re: [PATCH v3 4/7] x86/paravirt: remove 32-bit support from
 PARAVIRT_XXL
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-5-jgross@suse.com>
 <a1073b86-ebd5-68b6-7761-99669dd93e1c@oracle.com>
 <4c5fb964-6acb-6bb8-4eff-0bcb67d922f2@suse.com>
 <8506b0cd-6f7e-7505-d9b9-e1468cefa4ec@oracle.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c0917f5a-ffec-d422-bf8b-8c8859ea4312@suse.com>
Date: Mon, 10 Aug 2020 20:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8506b0cd-6f7e-7505-d9b9-e1468cefa4ec@oracle.com>
Content-Language: en-US
Cc: Stefano Stabellini <sstabellini@kernel.org>, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gMTAuMDguMjAgMTg6NTMsIEJvcmlzIE9zdHJvdnNreSB3cm90ZToKPiBPbiA4LzEwLzIwIDEy
OjM5IEFNLCBKw7xyZ2VuIEdyb8OfIHdyb3RlOgo+PiBPbiAwOS4wOC4yMCAwNDozNCwgQm9yaXMg
T3N0cm92c2t5IHdyb3RlOgo+Pj4gT24gOC83LzIwIDQ6MzggQU0sIEp1ZXJnZW4gR3Jvc3Mgd3Jv
dGU6Cj4+Pj4gQEAgLTM3NywxMCArMzczLDcgQEAgc3RhdGljIGlubGluZSBwdGVfdCBfX3B0ZShw
dGV2YWxfdCB2YWwpCj4+Pj4gIMKgIHsKPj4+PiAgwqDCoMKgwqDCoCBwdGV2YWxfdCByZXQ7Cj4+
Pj4gIMKgIC3CoMKgwqAgaWYgKHNpemVvZihwdGV2YWxfdCkgPiBzaXplb2YobG9uZykpCj4+Pj4g
LcKgwqDCoMKgwqDCoMKgIHJldCA9IFBWT1BfQ0FMTEVFMihwdGV2YWxfdCwgbW11Lm1ha2VfcHRl
LCB2YWwsICh1NjQpdmFsID4+Cj4+Pj4gMzIpOwo+Pj4+IC3CoMKgwqAgZWxzZQo+Pj4+IC3CoMKg
wqDCoMKgwqDCoCByZXQgPSBQVk9QX0NBTExFRTEocHRldmFsX3QsIG1tdS5tYWtlX3B0ZSwgdmFs
KTsKPj4+PiArwqDCoMKgIHJldCA9IFBWT1BfQ0FMTEVFMShwdGV2YWxfdCwgbW11Lm1ha2VfcHRl
LCB2YWwpOwo+Pj4+ICDCoCDCoMKgwqDCoMKgIHJldHVybiAocHRlX3QpIHsgLnB0ZSA9IHJldCB9
Owo+Pj4KPj4+Cj4+PiBDYW4gdGhpcyBub3cgc2ltcGx5IHJldHVybiAocHRlX3QpIHJldD8KPj4K
Pj4gSSBkb24ndCB0aGluayBzbywgYnV0IEkgY2FuIHR1cm4gaXQgaW50bwo+Pgo+PiAgwqAgcmV0
dXJuIG5hdGl2ZV9tYWtlX3B0ZShQVk9QX0NBTExFRTEoLi4uKSk7Cj4gCj4gCj4gSSB0aG91Z2h0
IHRoYXQgc2luY2Ugbm93IHRoaXMgaXMgb25seSBidWlsdCBmb3IgNjQtYml0IHdlIGRvbid0IGhh
dmUgdG8KPiB3b3JyeSBhYm91dCBkaWZmZXJlbnQgcHRlX3QgZGVmaW5pdGlvbnMgYW5kIGNhbiBk
byB3aGF0IHdlIGRvIGZvcgo+IGV4YW1wbGUsIGZvciBfX3BnZCgpPwoKWWVzLCBJIGRpZCB0aGF0
OgoKICByZXR1cm4gKHB0ZV90KSB7IHJldCB9OwoKCkp1ZXJnZW4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C8C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 14:14:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6964564FE5
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 14:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6964564FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2240883EE4;
	Wed, 10 Mar 2021 14:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Be8pBeT--LLF; Wed, 10 Mar 2021 14:14:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id B825983EFA;
	Wed, 10 Mar 2021 14:14:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A9DCC000A;
	Wed, 10 Mar 2021 14:14:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41A6FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 14:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A3AE83F1A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 14:14:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NF9B_VyK8UhZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 14:14:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FA9E83EE4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 14:14:04 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0a9900452923910729ca7d.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0a:9900:4529:2391:729:ca7d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AE4BD1EC026F;
 Wed, 10 Mar 2021 15:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1615385641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TkMrmSK/gpY6OtMDP3bCzeW/KsANAPjk+GubcA0SiVk=;
 b=E5tIxCfbxV1QtJ7+kVylOOkptdMD5POD0M28l1YoZoIW5BjvRtSO1DgTJyfsd3pCigHb73
 FLUR0E5MOJBdgkckOwBZ5WRAvXqEU6lsD2TQRaNJRsdp9MwWTl+mpMOE9fP7avOddwZqi+
 MMqMSC4Aom3dQrDOqhVRCmy5BqdUCF4=
Date: Wed, 10 Mar 2021 15:13:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH v6 02/12] x86/paravirt: switch time pvops functions to
 use static_call()
Message-ID: <20210310141347.GF23521@zn.tnic>
References: <20210309134813.23912-1-jgross@suse.com>
 <20210309134813.23912-3-jgross@suse.com>
 <20210309185737.GE699@zn.tnic>
 <e06cc359-6300-a26b-c307-9ef8d963b0c1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e06cc359-6300-a26b-c307-9ef8d963b0c1@suse.com>
Cc: linux-hyperv@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, "VMware, Inc." <pv-drivers@vmware.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMDg6NTE6MjJBTSArMDEwMCwgSsO8cmdlbiBHcm/DnyB3
cm90ZToKPiBJdCBpcyBjb21iaW5pbmcgdGhlIHR3byBuZWVkZWQgYWN0aW9uczogdXBkYXRlIHRo
ZSBzdGF0aWMgY2FsbCBhbmQKPiBzZXQgdGhlIHBhcmF2aXJ0X3VzaW5nX25hdGl2ZV9zY2hlZF9j
bG9jayBib29sZWFuLgoKSSBhY3R1YWxseSBtZWFudCB3aGF0IHRoZSBwb2ludCBvZiB1c2luZ19u
YXRpdmVfc2NoZWRfY2xvY2soKSBpcyBidXQgcHV0CnRoaXMgY29tbWVudCBhdCB0aGUgd3Jvbmcg
cGxhY2UsIHNvcnJ5LgoKPiBKdXN0IGhhZCBhbm90aGVyIGlkZWE6IEkgY291bGQgYWRkIGEgZnVu
Y3Rpb24gdG8gc3RhdGljX2NhbGwuaCBmb3IKPiBxdWVyeWluZyB0aGUgY3VycmVudCBmdW5jdGlv
bi4gVGhpcyB3b3VsZCBhdm9pZCB0aGUgZG91YmxlIGJvb2sga2VlcGluZwo+IGFuZCBjb3VsZCBw
cm9iYWJseSBiZSB1c2VkIGxhdGVyIHdoZW4gc3dpdGNoaW5nIG90aGVyIHB2X29wcyBjYWxscyB0
bwo+IHN0YXRpY19jYWxsLCB0b28gKGUuZy4gcHZfaXNfbmF0aXZlX3NwaW5fdW5sb2NrKCkpLgo+
IAo+IFdoYXQgZG8geW91IHRoaW5rPwoKWWFwLCB0aGF0IG1ha2VzIHNlbnNlLiBBbHRlcm5hdGl2
ZWx5LCB5b3UgY291bGQgZXZlbiBhZGQgYSBiaXRmaWVsZCB0bwpwdl9vcHMgd2hpY2ggY2Fycmll
cyB0aGF0IGluZm8gYW5kIHNpbmNlIHB2X29wcyBpcyBnbG9iYWwuLi4KCkJ1dCB5ZWFoLCB0aGUg
bGVzcyBib29ra2VlcGluZyB0aGUgYmV0dGVyLgoKVGh4LgoKLS0gClJlZ2FyZHMvR3J1c3MsCiAg
ICBCb3Jpcy4KCmh0dHBzOi8vcGVvcGxlLmtlcm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRp
cXVldHRlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==

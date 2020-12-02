Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D297C64E7B
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 17:08:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77668217A0
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 17:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77668217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B299C2E288;
	Wed,  2 Dec 2020 17:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hv5nKEWj-raN; Wed,  2 Dec 2020 17:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id AB63C2E17D;
	Wed,  2 Dec 2020 17:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7439DC0859;
	Wed,  2 Dec 2020 17:08:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24545C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 17:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0AF0986F89
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 17:08:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hRgkPZNHb6AY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 17:08:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8F16386F37
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 17:08:30 +0000 (UTC)
Received: from zn.tnic (p200300ec2f161b00329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f16:1b00:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88AA91EC0445;
 Wed,  2 Dec 2020 18:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1606928907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ySegBj5bw98Dubr8StQaVFXEi9kv05WveRbfqUYjPM=;
 b=nupJKD0sLAJ4R4UUPVoZaW60JPZLoqvGYStCVadIUPeYcxQBDe1TC8TasvCIz+cBpUSJMI
 dbbQFVbpPp5/4n1DfFyfcTn82NsC40ZfhEmqPlVJx0HXns7PsZW4zbP9lny+lXVOb5CUuO
 WZuBUXZ7PtfjieBd/pKYBpU6ZLcKRCA=
Date: Wed, 2 Dec 2020 18:08:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH v2 04/12] x86/xen: drop USERGS_SYSRET64 paravirt call
Message-ID: <20201202170823.GF2951@zn.tnic>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-5-jgross@suse.com>
 <20201202123235.GD2951@zn.tnic>
 <6be0d1a5-0079-5d90-0c38-85fe4471f1b8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6be0d1a5-0079-5d90-0c38-85fe4471f1b8@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, peterz@infradead.org,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, "VMware,
 Inc." <pv-drivers@vmware.com>, Ingo Molnar <mingo@redhat.com>, luto@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
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

T24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDM6NDg6MjFQTSArMDEwMCwgSsO8cmdlbiBHcm/DnyB3
cm90ZToKPiBJIHdhbnRlZCB0byBhdm9pZCB0aGUgYWRkaXRpb25hbCBOT1BzIGZvciB0aGUgYmFy
ZSBtZXRhbCBjYXNlLgoKWWVhaCwgaW4gdGhhdCBjYXNlIGl0IGdldHMgb3B0aW1pemVkIHRvIGEg
c2luZ2xlIE5PUDoKClsgICAgMC4xNzY2OTJdIFNNUCBhbHRlcm5hdGl2ZXM6IGZmZmZmZmZmODFh
MDAwNjg6IFswOjUpIG9wdGltaXplZCBOT1BzOiAwZiAxZiA0NCAwMCAwMAoKd2hpY2ggaXMgbm9w
bCAweDAoJXJheCwlcmF4LDEpIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQncyBub3RpY2VhYmxlIG9u
Cm1vZGVybiBDUFVzIHdoZXJlIGEgTk9QIGlzIGJhc2ljYWxseSBhIHJJUCBpbmNyZW1lbnQgb25s
eSBhbmQgdGhhdCBnb2VzCmRvd24gdGhlIHBpcGUgYWxtb3N0IGZvciBmcmVlLiA6LSkKCj4gSWYg
eW91IGRvbid0IG1pbmQgdGhlbSBJIGNhbiBkbyBhcyB5b3UgYXJlIHN1Z2dlc3RpbmcuCgpZZXMg
cGxzLCBJIHRoaW5rIGFzbSByZWFkYWJpbGl0eSBpcyBtb3JlIGltcG9ydGFudCB0aGFuIGEgNS1i
eXRlIE5PUC4KClRoeC4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9yaXMuCgpodHRwczovL3Bl
b3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

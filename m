Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F330C433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 22:24:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FEE64F0F
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 22:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FEE64F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4F174EBE4;
	Mon, 15 Mar 2021 22:24:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qKQdEfolDCSq; Mon, 15 Mar 2021 22:24:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 052E24EBCA;
	Mon, 15 Mar 2021 22:24:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDCF3C000B;
	Mon, 15 Mar 2021 22:24:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CD6CC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 22:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EC626F5E4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 22:24:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BB4HOM8QCOBY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 22:24:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from EX13-EDG-OU-001.vmware.com (ex13-edg-ou-001.vmware.com
 [208.91.0.189])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC07360653
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 22:24:45 +0000 (UTC)
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Mon, 15 Mar 2021 15:24:43 -0700
Received: from [10.200.196.160] (unknown [10.200.196.160])
 by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 323722050D;
 Mon, 15 Mar 2021 15:24:44 -0700 (PDT)
MIME-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] x86/vmware: avoid TSC recalibration
From: Alexey Makhalov <amakhalov@vmware.com>
In-Reply-To: <87im8bildr.fsf@vitty.brq.redhat.com>
Date: Mon, 15 Mar 2021 15:24:43 -0700
Message-ID: <84F586C5-EECE-4EE5-8988-64D8E0325D7A@vmware.com>
References: <20210105004752.131069-1-amakhalov@vmware.com>
 <87im8bildr.fsf@vitty.brq.redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Received-SPF: None (EX13-EDG-OU-001.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 tglx@linutronix.de
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

SGkgVml0YWx5LAoKSSBiZWxpZXZlLCBpdCBpcyByZXNwb25zaWJpbGl0eSBvZiBlYWNoIGd1ZXN0
IGNvZGUgdG8gc2V0IFg4Nl9GRUFUVVJFX1RTQ19LTk9XTl9GUkVRIGNhcC4KUmVnYXJkaW5nIFZN
d2FyZSBndWVzdCwgdGhlcmUgaXMgYSBjYXNlIHdoZXJlIHZtd2FyZV90c2Nfa2h6IGlzIHplcm8g
KG5vdCBwcm92aWRlZCBieSBoeXBlcnZpc29yKQphbmQgVFNDIGZyZXF1ZW5jeSBzaG91bGQgYmUg
Y2FsY3VsYXRlZC4KClNvcnJ5IGZvciBsYXRlIHJlc3BvbnNlLgoKUmVnYXJkcywK4oCUQWxleGV5
Cgo+IE9uIEphbiA1LCAyMDIxLCBhdCA1OjA2IEFNLCBWaXRhbHkgS3V6bmV0c292IDx2a3V6bmV0
c0ByZWRoYXQuY29tPiB3cm90ZToKPiAKPiBBbGV4ZXkgTWFraGFsb3YgPGFtYWtoYWxvdkB2bXdh
cmUuY29tPiB3cml0ZXM6Cj4gCj4+IFdoZW4gVFNDIGZyZXF1ZW5jeSBpcyBrbm93biAocmV0cmll
dmVkIGZyb20gaHlwZXJ2aXNvciksIHdlIHNob3VsZCBza2lwCj4+IFRTQyByZWZpbmVkIGNhbGli
cmF0aW9uIGJ5IHNldHRpbmcgWDg2X0ZFQVRVUkVfVFNDX0tOT1dOX0ZSRVEuCj4+IAo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4ZXkgTWFraGFsb3YgPGFtYWtoYWxvdkB2bXdhcmUuY29tPgo+PiAtLS0K
Pj4gYXJjaC94ODYva2VybmVsL2NwdS92bXdhcmUuYyB8IDIgKysKPj4gMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUv
dm13YXJlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Ztd2FyZS5jCj4+IGluZGV4IGM2ZWRlM2Iz
ZDMwMi4uODMxNjQxMTBjY2M1IDEwMDY0NAo+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Zt
d2FyZS5jCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvdm13YXJlLmMKPj4gQEAgLTM3OCw2
ICszNzgsOCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgdm13YXJlX3NldF9jYXBhYmlsaXRpZXModm9p
ZCkKPj4gewo+PiAJc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVBVFVSRV9DT05TVEFOVF9UU0Mp
Owo+PiAJc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVBVFVSRV9UU0NfUkVMSUFCTEUpOwo+PiAr
CWlmICh2bXdhcmVfdHNjX2toeikKPj4gKwkJc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVBVFVS
RV9UU0NfS05PV05fRlJFUSk7Cj4+IAlpZiAodm13YXJlX2h5cGVyY2FsbF9tb2RlID09IENQVUlE
X1ZNV0FSRV9GRUFUVVJFU19FQ1hfVk1DQUxMKQo+PiAJCXNldHVwX2ZvcmNlX2NwdV9jYXAoWDg2
X0ZFQVRVUkVfVk1DQUxMKTsKPj4gCWVsc2UgaWYgKHZtd2FyZV9oeXBlcmNhbGxfbW9kZSA9PSBD
UFVJRF9WTVdBUkVfRkVBVFVSRVNfRUNYX1ZNTUNBTEwpCj4gCj4gVGhlIHNhbWUgdHJpY2sgaXMg
YmVpbmcgdXNlZCBpbiBYZW4vSmFpbGhvdXNlL0tWTSBjb2RlIGFscmVhZHkgYW5kCj4gSHlwZXIt
ViBvdmVyd3JpdGVzIHg4Nl9wbGF0Zm9ybS5jYWxpYnJhdGVfdHNjL3g4Nl9wbGF0Zm9ybS5jYWxp
YnJhdGVfY3B1Cj4gaG9va3MgdG8gYmFzaWNhbGx5IGFjaGl2ZSB0aGUgc2FtZSBnb2FsLiBTaG91
bGQgd2UgbWF5YmUgaW50cm9kdWNlIGEKPiBmbGFnIGluICdzdHJ1Y3QgaHlwZXJ2aXNvcl94ODYn
IG9yIHNvbWV0aGluZyBsaWtlIHRoYXQgdG8gdW5pZnkgYWxsCj4gdGhpcz8KPiAKPiBKdXN0IGEg
c3VnZ2VzdGlvbi4KPiAKPiAtLSAKPiBWaXRhbHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

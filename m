Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6319EC433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A410664EC6
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 19:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410664EC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 658A48562D;
	Mon,  1 Feb 2021 19:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llRjQQ9nEpww; Mon,  1 Feb 2021 19:48:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 278B885621;
	Mon,  1 Feb 2021 19:48:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A60C0FA7;
	Mon,  1 Feb 2021 19:48:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA9FC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1563420773
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r0IWCsDX1VhW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:48:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by silver.osuosl.org (Postfix) with ESMTPS id 867B420764
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 19:48:33 +0000 (UTC)
Received: from zn.tnic (p200300ec2f06fe00e55f3102cc5eb27e.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f06:fe00:e55f:3102:cc5e:b27e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26BD61EC0253;
 Mon,  1 Feb 2021 20:48:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1612208910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOkZrEeAn9oVnNn743NqAyVIKQ3k9/Lp3V74SDhkd64=;
 b=EM+rZpLJ9tNc2VbuYUaopFlP03mUsRMmq8qq/pgZ3JJsI6Y/KowJvU44oGPkeeGAD2qPsa
 j3K801BVFENduL2KRFMJ4dbHjY93xQqSdkCzV0oRKi2WduQAxPNz6//O0rJUMn7L41a83g
 pwy9/FLLvDRay4tdxWs6a0Sjt8mlIoM=
Date: Mon, 1 Feb 2021 20:48:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v4 07/15] x86/paravirt: switch time pvops functions to
 use static_call()
Message-ID: <20210201194828.GB14590@zn.tnic>
References: <20210120135555.32594-1-jgross@suse.com>
 <20210120135555.32594-8-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210120135555.32594-8-jgross@suse.com>
Cc: linux-hyperv@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org, "VMware,
 Inc." <pv-drivers@vmware.com>, virtualization@lists.linux-foundation.org,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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

T24gV2VkLCBKYW4gMjAsIDIwMjEgYXQgMDI6NTU6NDdQTSArMDEwMCwgSnVlcmdlbiBHcm9zcyB3
cm90ZToKPiBUaGUgdGltZSBwdm9wcyBmdW5jdGlvbnMgYXJlIHRoZSBvbmx5IG9uZXMgbGVmdCB3
aGljaCBtaWdodCBiZQo+IHVzZWQgaW4gMzItYml0IG1vZGUgYW5kIHdoaWNoIHJldHVybiBhIDY0
LWJpdCB2YWx1ZS4KPiAKPiBTd2l0Y2ggdGhlbSB0byB1c2UgdGhlIHN0YXRpY19jYWxsKCkgbWVj
aGFuaXNtIGluc3RlYWQgb2YgcHZvcHMsIGFzCj4gdGhpcyBhbGxvd3MgcXVpdGUgc29tZSBzaW1w
bGlmaWNhdGlvbiBvZiB0aGUgcHZvcHMgaW1wbGVtZW50YXRpb24uCj4gCj4gU2lnbmVkLW9mZi1i
eTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPgo+IC0tLQo+IFY0Ogo+IC0gZHJvcCBw
YXJhdmlydF90aW1lLmggYWdhaW4KPiAtIGRvbid0IG1vdmUgSHlwZXItViBjb2RlIChNaWNoYWVs
IEtlbGxleSkKPiAtLS0KPiAgYXJjaC94ODYvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICB8
ICAxICsKPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCAgICAgICB8ICAyICstCj4g
IGFyY2gveDg2L2luY2x1ZGUvYXNtL3BhcmF2aXJ0LmggICAgICAgfCAxNyArKysrKysrKysrKysr
Ky0tLQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydF90eXBlcy5oIHwgIDYgLS0tLS0t
Cj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvdm13YXJlLmMgICAgICAgICAgfCAgNSArKystLQo+ICBh
cmNoL3g4Ni9rZXJuZWwva3ZtLmMgICAgICAgICAgICAgICAgIHwgIDIgKy0KPiAgYXJjaC94ODYv
a2VybmVsL2t2bWNsb2NrLmMgICAgICAgICAgICB8ICAyICstCj4gIGFyY2gveDg2L2tlcm5lbC9w
YXJhdmlydC5jICAgICAgICAgICAgfCAxNiArKysrKysrKysrKystLS0tCj4gIGFyY2gveDg2L2tl
cm5lbC90c2MuYyAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBhcmNoL3g4Ni94ZW4vdGltZS5j
ICAgICAgICAgICAgICAgICAgIHwgMTEgKysrKy0tLS0tLS0KPiAgZHJpdmVycy9jbG9ja3NvdXJj
ZS9oeXBlcnZfdGltZXIuYyAgICB8ICA1ICsrKy0tCj4gIGRyaXZlcnMveGVuL3RpbWUuYyAgICAg
ICAgICAgICAgICAgICAgfCAgMiArLQo+ICAxMiBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25z
KCspLCAyOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvS2NvbmZpZyBi
L2FyY2gveDg2L0tjb25maWcKPiBpbmRleCAyMWY4NTExNzlmZjAuLjdjY2Q0YTgwNzg4YyAxMDA2
NDQKPiAtLS0gYS9hcmNoL3g4Ni9LY29uZmlnCj4gKysrIGIvYXJjaC94ODYvS2NvbmZpZwo+IEBA
IC03NzEsNiArNzcxLDcgQEAgaWYgSFlQRVJWSVNPUl9HVUVTVAo+ICAKPiAgY29uZmlnIFBBUkFW
SVJUCj4gIAlib29sICJFbmFibGUgcGFyYXZpcnR1YWxpemF0aW9uIGNvZGUiCj4gKwlkZXBlbmRz
IG9uIEhBVkVfU1RBVElDX0NBTEwKPiAgCWhlbHAKPiAgCSAgVGhpcyBjaGFuZ2VzIHRoZSBrZXJu
ZWwgc28gaXQgY2FuIG1vZGlmeSBpdHNlbGYgd2hlbiBpdCBpcyBydW4KPiAgCSAgdW5kZXIgYSBo
eXBlcnZpc29yLCBwb3RlbnRpYWxseSBpbXByb3ZpbmcgcGVyZm9ybWFuY2Ugc2lnbmlmaWNhbnRs
eQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaAo+IGluZGV4IDMwZjc2Yjk2Njg1Ny4uYjRlZTMzMWQy
OWE3IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgKPiArKysg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVydi5oCj4gQEAgLTYzLDcgKzYzLDcgQEAgdHlw
ZWRlZiBpbnQgKCpoeXBlcnZfZmlsbF9mbHVzaF9saXN0X2Z1bmMpKAo+ICBzdGF0aWMgX19hbHdh
eXNfaW5saW5lIHZvaWQgaHZfc2V0dXBfc2NoZWRfY2xvY2sodm9pZCAqc2NoZWRfY2xvY2spCj4g
IHsKPiAgI2lmZGVmIENPTkZJR19QQVJBVklSVAo+IC0JcHZfb3BzLnRpbWUuc2NoZWRfY2xvY2sg
PSBzY2hlZF9jbG9jazsKPiArCXBhcmF2aXJ0X3NldF9zY2hlZF9jbG9jayhzY2hlZF9jbG9jayk7
Cj4gICNlbmRpZgo+ICB9Cj4gIAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9w
YXJhdmlydC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaAo+IGluZGV4IDRhYmYx
MTBlMjI0My4uMWU0NWI0NmZhZTg0IDEwMDY0NAo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3BhcmF2aXJ0LmgKPiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oCj4gQEAg
LTE1LDExICsxNSwyMiBAQAo+ICAjaW5jbHVkZSA8bGludXgvYnVnLmg+Cj4gICNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPgo+ICAjaW5jbHVkZSA8bGludXgvY3B1bWFzay5oPgo+ICsjaW5jbHVkZSA8
bGludXgvc3RhdGljX2NhbGxfdHlwZXMuaD4KPiAgI2luY2x1ZGUgPGFzbS9mcmFtZS5oPgo+ICAK
PiAtc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGxvbmcgcGFyYXZpcnRfc2NoZWRfY2xvY2so
dm9pZCkKPiArdTY0IGR1bW15X3N0ZWFsX2Nsb2NrKGludCBjcHUpOwo+ICt1NjQgZHVtbXlfc2No
ZWRfY2xvY2sodm9pZCk7Cj4gKwo+ICtERUNMQVJFX1NUQVRJQ19DQUxMKHB2X3N0ZWFsX2Nsb2Nr
LCBkdW1teV9zdGVhbF9jbG9jayk7Cj4gK0RFQ0xBUkVfU1RBVElDX0NBTEwocHZfc2NoZWRfY2xv
Y2ssIGR1bW15X3NjaGVkX2Nsb2NrKTsKCkRpZCB5b3UgYnVpbGQgdGhpcyBiZWZvcmUgc2VuZGlu
Zz8KCkknbSB0ZXN0LWFwcGx5aW5nIHRoaXMgb24gcmM2ICsgdGlwL21hc3RlciBzbyBJIHByb2Jh
Ymx5IGFtIHVzaW5nIGEKZGlmZmVyZW50IHRyZWUgc28gaXQgbG9va3MgbGlrZSBzb21ldGhpbmcg
aGFzIGNoYW5nZWQgaW4gdGhlIG1lYW50aW1lLgotcmM2IGhhcyBhIGNvdXBsZSBvZiBYZW4gY2hh
bmdlcyB3aGljaCBtYWRlIGFwcGx5aW5nIHRob3NlIHRvIG5lZWQgc29tZQp3aWdnbGluZyBpbi4u
LgoKTWF5YmUgeW91IHNob3VsZCByZWRvIHRoZW0gb250b3Agb2YgdGlwL21hc3Rlci4gVGhhdCBp
cywgKmlmKiB0aGV5J3JlCmdvaW5nIHRvIGV2ZW50dWFsbHkgZ28gdGhyb3VnaCB0aXAuIFRoZSBk
aWZmc3RhdCBoYXMgWGVuIHN0dWZmIHRvbyBzbyB3ZQptaWdodCBuZWVkIHNvbWUgc3luY2hyb25p
emF0aW9uIGhlcmUgd2hhdCBnb2VzIHdoZXJlIGhvdy4uLgoKLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9wYXJhdmlydC5oOjI0OjE6IHdhcm5pbmc6IGRhdGEgZGVmaW5pdGlvbiBoYXMgbm8gdHlwZSBv
ciBzdG9yYWdlIGNsYXNzCiAgIDI0IHwgREVDTEFSRV9TVEFUSUNfQ0FMTChwdl9zdGVhbF9jbG9j
aywgZHVtbXlfc3RlYWxfY2xvY2spOwogICAgICB8IF5+fn5+fn5+fn5+fn5+fn5+fn4KLi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oOjI0OjE6IGVycm9yOiB0eXBlIGRlZmF1bHRzIHRv
IOKAmGludOKAmSBpbiBkZWNsYXJhdGlvbiBvZiDigJhERUNMQVJFX1NUQVRJQ19DQUxM4oCZIFst
V2Vycm9yPWltcGxpY2l0LWludF0KLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oOjI0
OjE6IHdhcm5pbmc6IHBhcmFtZXRlciBuYW1lcyAod2l0aG91dCB0eXBlcykgaW4gZnVuY3Rpb24g
ZGVjbGFyYXRpb24KLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oOjI1OjE6IHdhcm5p
bmc6IGRhdGEgZGVmaW5pdGlvbiBoYXMgbm8gdHlwZSBvciBzdG9yYWdlIGNsYXNzCiAgIDI1IHwg
REVDTEFSRV9TVEFUSUNfQ0FMTChwdl9zY2hlZF9jbG9jaywgZHVtbXlfc2NoZWRfY2xvY2spOwog
ICAgICB8IF5+fn5+fn5+fn5+fn5+fn5+fn4KLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmly
dC5oOjI1OjE6IGVycm9yOiB0eXBlIGRlZmF1bHRzIHRvIOKAmGludOKAmSBpbiBkZWNsYXJhdGlv
biBvZiDigJhERUNMQVJFX1NUQVRJQ19DQUxM4oCZIFstV2Vycm9yPWltcGxpY2l0LWludF0KLi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oOjI1OjE6IHdhcm5pbmc6IHBhcmFtZXRlciBu
YW1lcyAod2l0aG91dCB0eXBlcykgaW4gZnVuY3Rpb24gZGVjbGFyYXRpb24KLi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9wYXJhdmlydC5oOiBJbiBmdW5jdGlvbiDigJhwYXJhdmlydF9zY2hlZF9jbG9j
a+KAmToKLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oOjMzOjk6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhzdGF0aWNfY2FsbOKAmSBbLVdlcnJvcj1p
bXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgMzMgfCAgcmV0dXJuIHN0YXRpY19jYWxs
KHB2X3NjaGVkX2Nsb2NrKSgpOwogICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn4KLi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9wYXJhdmlydC5oOjMzOjIxOiBlcnJvcjog4oCYcHZfc2NoZWRfY2xvY2vi
gJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g
4oCYZHVtbXlfc2NoZWRfY2xvY2vigJk/CiAgIDMzIHwgIHJldHVybiBzdGF0aWNfY2FsbChwdl9z
Y2hlZF9jbG9jaykoKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICBkdW1teV9zY2hlZF9jbG9jawouL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3BhcmF2aXJ0Lmg6MzM6MjE6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVu
dGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJz
IGluCi4vYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaDogSW4gZnVuY3Rpb24g4oCYcGFy
YXZpcnRfc3RlYWxfY2xvY2vigJk6Ci4vYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyYXZpcnQuaDo0
NzoyMTogZXJyb3I6IOKAmHB2X3N0ZWFsX2Nsb2Nr4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBp
biB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuIOKAmGR1bW15X3N0ZWFsX2Nsb2Nr4oCZPwog
ICA0NyB8ICByZXR1cm4gc3RhdGljX2NhbGwocHZfc3RlYWxfY2xvY2spKGNwdSk7CiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgZHVtbXlfc3RlYWxfY2xvY2sKY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDoxMTc6IGFyY2gv
eDg2L2tlcm5lbC9hc20tb2Zmc2V0cy5zXSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIw
MDogcHJlcGFyZTBdIEVycm9yIDIKClRoeC4KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9yaXMu
CgpodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=

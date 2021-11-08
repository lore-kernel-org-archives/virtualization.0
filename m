Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8CC433EF
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 14:45:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B74661207
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 14:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B74661207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6FB2402DF;
	Mon,  8 Nov 2021 14:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkPL_SoAaZcv; Mon,  8 Nov 2021 14:45:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A51AD401AE;
	Mon,  8 Nov 2021 14:45:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B936C0019;
	Mon,  8 Nov 2021 14:45:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3819CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 14:45:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 18FF340292
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 14:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=shutemov-name.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lK2TnKcSZikZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 14:45:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97C4140297
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 14:45:07 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id o18so36696856lfu.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Nov 2021 06:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=o8ACBTFUs1u+Tu+HSqZ/Bgtc3Mxdv1DOZfd1HtE9MhI=;
 b=SSMxAUf89rUnNVbNGy3A336IliPjR+Nql1b6FMZQ3CAZAPpyiWnTasF0SnwZXgmc1y
 BqbNPEbtGA99ppTCaKfBe89qdo0lA/IduTOv4VSHUD8jdmS5ur5ig5kmaE0Nx/uaMvqp
 kNWhbwFpv4ozrVRf/1IWb7YdNwcBO1HQE2ii7ChI+tlnP86Yj7MxEN0Fe5tkdJJn++qm
 KdixhE51YAtCPJF1p9jcDxFgtq8vSQ/vRTWOBeN0v8lEd0O0BxHPje9OJMxpE+5B5fOo
 huY0AOns10N09ELwQXu4jbcwD1g0DXpMv87v/nUS1HrouSwNHFQNDOybGK9W8+qNEivA
 avsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=o8ACBTFUs1u+Tu+HSqZ/Bgtc3Mxdv1DOZfd1HtE9MhI=;
 b=hyJmRujvPm5psjczczRcfU/VT42LqmFpQu5JuOvkS3/SqJ8QfsH/3aoWGbIgj3OZcs
 N7EUO+n3Zxl9KHBZg/RcOiWYHlU1lhDl044qymxUV+wx5yX/NfMBLpUC85dhgAeLyz+w
 E9PLzieWBT0eTdORCLZZmSPSx9an117NdRwYoQwgIZ/6ukashTRfhI2ETxGIqDrhzBc+
 E1a/ygbkQ4ACIZE63HT+y/MhANQ5kmkwk7mSfReVvhfkQou383O+2/8bedokxHWbOt8g
 E788NqOJUYxkXjjZIa619hegmlrCJJX+Xu37mJBEFQO1UEEjW+44m2YemyyGr81HUslF
 HQEg==
X-Gm-Message-State: AOAM532tlsrBQ7ETkosRYujRQBz8dzMtO6xCBY2ZXKuLpLXW54FttLcS
 qRPog1u5KahMQ45V3GgBZQfS3A==
X-Google-Smtp-Source: ABdhPJzyLniPUCEsE0z/ygrYUi5HbWdGlisrZNzen5mCC1grWOhH8f4dxQ7pTSdWId8QL2qzkXju6w==
X-Received: by 2002:a19:c706:: with SMTP id x6mr18874044lff.113.1636382705340; 
 Mon, 08 Nov 2021 06:45:05 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
 by smtp.gmail.com with ESMTPSA id o23sm1572844ljg.70.2021.11.08.06.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 06:45:04 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
 id E8C4C1034BA; Mon,  8 Nov 2021 17:45:05 +0300 (+03)
Date: Mon, 8 Nov 2021 17:45:05 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v5 03/16] x86/tdx: Exclude Shared bit from physical_mask
Message-ID: <20211108144505.fz3p4fw4q2efj32r@box.shutemov.name>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YYWsJFP31vpCAVFg@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYWsJFP31vpCAVFg@google.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-pci@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Andi Kleen <ak@linux.intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Ingo Molnar <mingo@redhat.com>, linux-arch@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 "David S . Miller" <davem@davemloft.net>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBOb3YgMDUsIDIwMjEgYXQgMTA6MTE6NDhQTSArMDAwMCwgU2VhbiBDaHJpc3RvcGhl
cnNvbiB3cm90ZToKPiBPbiBGcmksIE9jdCAwOCwgMjAyMSwgS3VwcHVzd2FteSBTYXRoeWFuYXJh
eWFuYW4gd3JvdGU6Cj4gPiBGcm9tOiAiS2lyaWxsIEEuIFNodXRlbW92IiA8a2lyaWxsLnNodXRl
bW92QGxpbnV4LmludGVsLmNvbT4KPiA+IAo+ID4gSnVzdCBsaWtlIE1LVE1FLCBURFggcmVhc3Np
Z25zIGJpdHMgb2YgdGhlIHBoeXNpY2FsIGFkZHJlc3MgZm9yCj4gPiBtZXRhZGF0YS4gIE1LVE1F
IHVzZWQgc2V2ZXJhbCBiaXRzIGZvciBhbiBlbmNyeXB0aW9uIEtleUlELiBURFgKPiA+IHVzZXMg
YSBzaW5nbGUgYml0IGluIGd1ZXN0cyB0byBjb21tdW5pY2F0ZSB3aGV0aGVyIGEgcGh5c2ljYWwg
cGFnZQo+ID4gc2hvdWxkIGJlIHByb3RlY3RlZCBieSBURFggYXMgcHJpdmF0ZSBtZW1vcnkgKGJp
dCBzZXQgdG8gMCkgb3IKPiA+IHVucHJvdGVjdGVkIGFuZCBzaGFyZWQgd2l0aCB0aGUgVk1NIChi
aXQgc2V0IHRvIDEpLgo+ID4gCj4gPiBBZGQgYSBoZWxwZXIsIHRkeF9zaGFyZWRfbWFzaygpIHRv
IGdlbmVyYXRlIHRoZSBtYXNrLiAgVGhlIHByb2Nlc3Nvcgo+ID4gZW51bWVyYXRlcyBpdHMgcGh5
c2ljYWwgYWRkcmVzcyB3aWR0aCB0byBpbmNsdWRlIHRoZSBzaGFyZWQgYml0LCB3aGljaAo+ID4g
bWVhbnMgaXQgZ2V0cyBpbmNsdWRlZCBpbiBfX1BIWVNJQ0FMX01BU0sgYnkgZGVmYXVsdC4KPiAK
PiBUaGlzIGlzIGluY29ycmVjdC4gIFRoZSBzaGFyZWQgYml0IF9tYXlfIGJlIGEgbGVnYWwgUEEg
Yml0LCBidXQgQUlVSSBpdCdzIG5vdCBhCj4gaGFyZCByZXF1aXJlbWVudC4KCkdvb2QgcG9pbnQs
IHdpbGwgZml4LgoKPiA+IFJlbW92ZSB0aGUgc2hhcmVkIG1hc2sgZnJvbSAncGh5c2ljYWxfbWFz
aycgc2luY2UgYW55IGJpdHMgaW4KPiA+IHRkeF9zaGFyZWRfbWFzaygpIGFyZSBub3QgdXNlZCBm
b3IgcGh5c2ljYWwgYWRkcmVzc2VzIGluIHBhZ2UgdGFibGUKPiA+IGVudHJpZXMuCj4gCj4gLi4u
Cj4gCj4gPiBAQCAtOTQsNiArMTAwLDkgQEAgc3RhdGljIHZvaWQgdGR4X2dldF9pbmZvKHZvaWQp
Cj4gPiAgCj4gPiAgCXRkX2luZm8uZ3BhX3dpZHRoID0gb3V0LnJjeCAmIEdFTk1BU0soNSwgMCk7
Cj4gPiAgCXRkX2luZm8uYXR0cmlidXRlcyA9IG91dC5yZHg7Cj4gPiArCj4gPiArCS8qIEV4Y2x1
ZGUgU2hhcmVkIGJpdCBmcm9tIHRoZSBfX1BIWVNJQ0FMX01BU0sgKi8KPiA+ICsJcGh5c2ljYWxf
bWFzayAmPSB+dGR4X3NoYXJlZF9tYXNrKCk7Cj4gCj4gVGhpcyBpcyBpbnN1ZmZpY2llbnQsIHRo
b3VnaCBpdCdzIG5vdCByZWFsbHkgdGhlIGZhdWx0IG9mIHRoaXMgcGF0Y2gsIHRoZSBzcGVjcwo+
IHRoZW1zZWx2ZXMgYm90Y2ggdGhpcyB3aG9sZSB0aGluZy4KPiAKPiBUaGUgVERYIE1vZHVsZSBz
cGVjIGV4cGxpY2l0bHkgc3RhdGVzIHRoYXQgR1BBcyBhYm92ZSBHUEFXIGFyZSBjb25zaWRlcmVk
IHJlc2VydmVkLgo+IAo+ICAgICAxMC4xMS4xLiBHUEFXLVJlbGF0ZSBFUFQgVmlvbGF0aW9ucwo+
ICAgICBHUEEgYml0cyBoaWdoZXIgdGhhbiB0aGUgU0hBUkVEIGJpdCBhcmUgY29uc2lkZXJlZCBy
ZXNlcnZlZCBhbmQgbXVzdCBiZSAwLgo+ICAgICBBZGRyZXNzIHRyYW5zbGF0aW9uIHdpdGggYW55
IG9mIHRoZSByZXNlcnZlZCBiaXRzIHNldCB0byAxIGNhdXNlIGEgI1BGIHdpdGgKPiAgICAgUEZF
QyAoUGFnZSBGYXVsdCBFcnJvciBDb2RlKSBSU1ZEIGJpdCBzZXQuCj4gCj4gQnV0IHRoaXMgaXMg
Y29udHJhZGljdGVkIGJ5IHRoZSBhcmNoaXRlY3R1cmFsIGV4dGVuc2lvbnMgc3BlYywgd2hpY2gg
c3RhdGVzIHRoYXQKPiBhIEdQQSB0aGF0IHNhdGlzZmllcyBNQVhQQSA+PSBHUEEgPiBHUEFXICJj
YW4iIGNhdXNlIGFuIEVQVCB2aW9sYXRpb24sIG5vdCAjUEYuCj4gTm90ZSwgdGhpcyBzZWN0aW9u
IGFsc28gYXBwZWFycyB0byBoYXZlIGEgYnVnLCBhcyBpdCBzdGF0ZXMgdGhhdCBHUEEgYml0IDQ3
IGlzCj4gYm90aCB0aGUgU0hBUkVEIGJpdCBhbmQgcmVzZXJ2ZWQuICBJIGFzc3VtZSB0aGF0IGJs
dXJiIGlzIGludGVuZGVkIHRvIGNsYXJpZnkKPiB0aGF0IGJpdCA0NyBfd291bGRfIGJlIHJlc2Vy
dmVkIGlmIGl0IHdlcmVuJ3QgdGhlIFNIQVJFRCBiaXQsIGJ1dCBiZWNhdXNlIGl0J3MKPiB0aGUg
c2hhcmVkIGJpdCBpdCdzIG9rIHRvIGFjY2Vzcy4KPiAKPiAgICAgMS40LjIKPiAgICAgR3Vlc3Qg
UGh5c2ljYWwgQWRkcmVzcyBUcmFuc2xhdGlvbgo+ICAgICBJZiB0aGUgQ1BVJ3MgbWF4aW11bSBw
aHlzaWNhbC1hZGRyZXNzIHdpZHRoIChNQVhQQSkgaXMgNTIgYW5kIHRoZSBndWVzdCBwaHlzaWNh
bAo+ICAgICBhZGRyZXNzIHdpZHRoIGlzIGNvbmZpZ3VyZWQgdG8gYmUgNDgsIGFjY2Vzc2VzIHdp
dGggR1BBIGJpdHMgNTE6NDggbm90IGFsbCBiZWluZwo+ICAgICAwIGNhbiBjYXVzZSBhbiBFUFQt
dmlvbGF0aW9uLCB3aGVyZSBzdWNoIEVQVC12aW9sYXRpb25zIGFyZSBub3QgbXV0YXRlZCB0byAj
VkUsCj4gICAgIGV2ZW4gaWYgdGhlIOKAnEVQVC12aW9sYXRpb25zICNWReKAnSBleGVjdXRpb24g
Y29udHJvbCBpcyAxLgo+IAo+ICAgICBJZiB0aGUgQ1BVJ3MgcGh5c2ljYWwtYWRkcmVzcyB3aWR0
aCAoTUFYUEEpIGlzIGxlc3MgdGhhbiA0OCBhbmQgdGhlIFNIQVJFRCBiaXQKPiAgICAgaXMgY29u
ZmlndXJlZCB0byBiZSBpbiBiaXQgcG9zaXRpb24gNDcsIEdQQSBiaXQgNDcgd291bGQgYmUgcmVz
ZXJ2ZWQsIGFuZCBHUEEKPiAgICAgICAgXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4gICAgICAgICAgICAgICAgICAgIAo+ICAg
ICBiaXRzIDQ2Ok1BWFBBIHdvdWxkIGJlIHJlc2VydmVkLiBPbiBzdWNoIENQVXMsIHNldHRpbmcg
Yml0cyA1MTo0OCBvciBiaXRzCj4gICAgIDQ2Ok1BWFBBIGluIGFueSBwYWdpbmcgc3RydWN0dXJl
IGNhbiBjYXVzZSBhIHJlc2VydmVkIGJpdCBwYWdlIGZhdWx0IG9uIGFjY2Vzcy4KPiAKPiBUaGUg
TW9kdWxlIHNwZWMgYWxzbyBjYWxscyBvdXQgdGhhdCB0aGUgZWZmZWN0aXZlIEdQQSBpcyBub3Qg
dG8gYmUgY29uZnVzZWQgd2l0aAo+IE1BWFBBLCB3aGljaCBjb21iaW5lZCB3aXRoIHRoZSBhYm92
ZSBibHVyYiBhYm91dCBNQVhQQSA8IEdQQVcsIHN1Z2dlc3RzIHRoYXQgTUFYUEEKPiBpcyBlbnVt
ZXJhdGVkIHNlcGFyYXRlbHkgYnkgZGVzaWduIHNvIHRoYXQgdGhlIGd1ZXN0IGRvZXNuJ3QgaW5j
b3JyZWN0bHkgdGhpbmsKPiA0NjpNQVhQQSBhcmUgdXNhYmxlLiAgQnV0IHRoYXQgaXMgcHJvYmxl
bWF0aWMgZm9yIHRoZSBjYXNlIHdoZXJlIE1BWFBBID4gR1BBVy4KPiAKPiAgICAgVGhlIGVmZmVj
dGl2ZSBHUEEgd2lkdGggKGluIGJpdHMpIGZvciB0aGlzIFREIChkbyBub3QgY29uZnVzZSB3aXRo
IE1BWFBBKS4KPiAgICAgU0hBUkVEIGJpdCBpcyBhdCBHUEEgYml0IEdQQVctMS4KPiAKPiBJIGNh
bid0IGZpbmQgdGhlIGV4YWN0IHJlZmVyZW5jZSwgYnV0IHRoZSBURFggbW9kdWxlIGFsd2F5cyBw
YXNzZXMgdGhyb3VnaCBob3N0J3MKPiBNQVhQSFlBRERSLiAgQXMgaXQgcGVydGFpbnMgdG8gdGhp
cyBwYXRjaCwganVzdCBkb2luZwo+IAo+IAlwaHlzaWNhbF9tYXNrICY9IH50ZHhfc2hhcmVkX21h
c2soKQo+IAo+IG1lYW5zIHRoYXQgYSBndWVzdCBydW5uaW5nIHdpdGggR1BBVz0wIGFuZCBNQVhQ
SFlBRERSPjQ4IHdpbGwgaGF2ZSBhIGRpc2NvbnRpZ3VvdXMKPiBwaHlzaWNhbF9tYXNrLCBhbmQg
Y291bGQgYWNjZXNzICJyZXNlcnZlZCIgbWVtb3J5LiAgSWYgdGhlIFZNTSBkZWZpbmVzIGxlZ2Fs
IG1lbW9yeQo+IHdpdGggYml0cyBbTUFYUEhZQUREUjo0OF0hPTAsIGV4cGxvc2lvbnMgbWF5IGVu
c3VlLiAgVGhhdCdzIGFyZ3VhYmx5IGEgVk1NIGJ1ZywgYnV0Cj4gZ2l2ZW4gdGhhdCB0aGUgVk1N
IGlzIHVudHJ1c3RlZCBJIHRoaW5rIHRoZSBndWVzdCBzaG91bGQgYmUgcGFyYW5vaWQgd2hlbiBo
YW5kbGluZwo+IHRoZSBTSEFSRUQgYml0LiAgSSBhbHNvIGRvbid0IGtub3cgdGhhdCB0aGUga2Vy
bmVsIHdpbGwgcGxheSBuaWNlIHdpdGggYSBkaXNjb250aWd1b3VzCj4gbWFzay4KCkkgZXhwZWN0
IGl0IHRvIGJlIGJ1Z2d5LgoKPiBTcGVjcyBhc2lkZSwgdW5sZXNzIEludGVsIG1ha2VzIGEgaGFy
ZHdhcmUgY2hhbmdlIHRvIHRyZWF0IEdQQVcgYXMgZ3Vlc3QuTUFYUEhZQUREUiwKPiBvciB0aGUg
VERYIE1vZHVsZSBlbXVsYXRlcyBvbiBFUFQgdmlvbGF0aW9ucyB0byBpbmplY3QgI1BGKFJTVkQp
IHdoZW4gYXBwcm9wcmlhdGUsCj4gdGhpcyBtZXNzIGlzbid0IGdvaW5nIHRvIGJlIHRydWx5IGZp
eGVkIGZyb20gdGhlIGd1ZXN0IHBlcnNwZWN0aXZlLgo+IAo+IFNvLCBJTU8gYWxsIGJpdHMgPj0g
R1BBVyBzaG91bGQgYmUgY2xlYXJlZCwgYW5kIHRoZSBrZXJuZWwgc2hvdWxkIHdhcm4gYW5kL29y
Cj4gcmVmdXNlIHRvIGJvb3QgaWYgdGhlIGhvc3QgaGFzIGRlZmluZWQgbGVnYWwgbWVtb3J5IGlu
IHRoYXQgcmFuZ2UuCgpSaWdodC4gQnV0IG9ubHkgPj0gR1BBVy0xIGFzIHNoYXJlZCBiaXQgaXMg
dGhlIE1TQiB3aXRoaW4gR1BBVzoKCglwaHlzaWNhbF9tYXNrICY9IEdFTk1BU0tfVUxMKHRkX2lu
Zm8uZ3BhX3dpZHRoIC0gMiwgMCk7CgonMicgaGVyZSBzbWVsbHMgYmFkLCBidXQgd2VsbC4uLgoK
R2l2ZW4gdGhhdCBwaHlzaWNhbF9tYXNrIGlzIG5vdyBjb250aWd1b3VzIHdlIGNhbiB0cnVuY2F0
ZSBhbnl0aGluZyBmcm9tCmU4MjAgdGhhdCBjYW5ub3QgYmUgYWRkcmVzc2VkIHdpdGggYWRqdXN0
ZWQgX19QSFlTSUNBTF9NQVNLOgoKaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2U4MjAuYyBi
L2FyY2gveDg2L2tlcm5lbC9lODIwLmMKaW5kZXggYmMwNjU3ZjBkZWVkLi4xNmQ1N2E4NzY5ZTgg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9lODIwLmMKKysrIGIvYXJjaC94ODYva2VybmVs
L2U4MjAuYwpAQCAtODMzLDYgKzgzMyw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIF9faW5pdCBl
ODIwX2VuZF9wZm4odW5zaWduZWQgbG9uZyBsaW1pdF9wZm4sIGVudW0gZTgyMF90eXBlCiAJdW5z
aWduZWQgbG9uZyBsYXN0X3BmbiA9IDA7CiAJdW5zaWduZWQgbG9uZyBtYXhfYXJjaF9wZm4gPSBN
QVhfQVJDSF9QRk47CgorCWlmIChtYXhfYXJjaF9wZm4gPiBQSFlTX1BGTihfX1BIWVNJQ0FMX01B
U0sgKyAxKSkKKwkJbWF4X2FyY2hfcGZuID0gUEhZU19QRk4oX19QSFlTSUNBTF9NQVNLICsgMSk7
CisKIAlmb3IgKGkgPSAwOyBpIDwgZTgyMF90YWJsZS0+bnJfZW50cmllczsgaSsrKSB7CiAJCXN0
cnVjdCBlODIwX2VudHJ5ICplbnRyeSA9ICZlODIwX3RhYmxlLT5lbnRyaWVzW2ldOwogCQl1bnNp
Z25lZCBsb25nIHN0YXJ0X3BmbjsKCkRvZXMgaXQgbG9vayByZWFzb25hYmxlPwoKPiBGV0lXLCBm
cm9tIGEgVk1NIHBlcnNwZWN0aXZlLCBJJ20gcHJldHR5IHN1cmUgdGhlIG9ubHkgc2FuZSBhcHBy
b2FjaCBpcyB0byBmb3JjZQo+IEdQQVc9MSwgYS5rLmEuIFNIQVJFRCBiaXQgPT0gNTEsIGlmIGhv
c3QuTUFYUEhZQUREUj49NDkuICBCdXQgb24gdGhlIGd1ZXN0IHNpZGUsCj4gSSB0aGluayB3ZSBz
aG91bGQgYmUgcGFyYW5vaWQuCgotLSAKIEtpcmlsbCBBLiBTaHV0ZW1vdgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

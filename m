Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392637C930
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312819; cv=none; b=Dsynk8bK/pN3x2gfEEt+KRVZsqR7bYGFhUqJl7TI+FKoD06emmWKKM9rqsFP9fxrljxTgiy5yNS7hW0puzwtEUgV3TnrFquMhTq/wxpu4PWUXIfL9WpeA6o7GEvjrJdy3mTwTFWyJmZUcoD7Tv2CFxCpznN84eCkQ+xZa4p+V2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312819; c=relaxed/simple;
	bh=LZSsn4W0FsDL+gHozCZFUr2SRc1gslr4/bysNvveKJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S6bi12vMp9avJ1eNtgI2REEVP8EjveSGxqJ/G9QacsYnZ0tUUkq8qsaZBu5gsPhDtss7QOJQcRlXzYHYQjZPoP1yw7R+HsyZvj0uK3W2FCOc3JgovcI47dImPctb7OKrSXl9PpRHzOT2JD5r98NGXlX4zhFfXpxhIwh1KxvKrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaG+QH0V; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaG+QH0V"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8291230235so8468984a12.2
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779312816; x=1779917616; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZSsn4W0FsDL+gHozCZFUr2SRc1gslr4/bysNvveKJE=;
        b=TaG+QH0VE1DEmu/xwBFm74iZTNIYP3rcQeN3kRFnVFLhqxu3B46ZXjYRKQvgP+xCLu
         G2DDluBi50sJU5irCDK0q/CQIek8qYctPnQqhIK7NmCQPXly5puSZl0AxWqK1nOwbWOW
         3Y1m0Q/ZT+0+EnLPsAElYqoLSyjuLbmldw29E434hiezZf2sm/8N4APO5H8oDkf4Q+Ki
         79Uoy4vcJYruQK9N5Fw+fr0j/sJo4F8UBLgE4iPqQC6ZQWH+z8ExBFZB+y7GLDg5nURK
         noFVNdErzXw5O3iNgdcwlu281ml747twsH4DXzqLN6IUHLxjlj+Y69vkuAl+LH5yq56t
         lNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312816; x=1779917616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZSsn4W0FsDL+gHozCZFUr2SRc1gslr4/bysNvveKJE=;
        b=VuQARh8f+ThgMi96V142Y7oUDZURijosSyK6P8I65D4HiaMoqdBY5DJGw6412xlI7/
         O7aw2QOzBghIQT2Gm2d1owyqBhmLyb+Ovyu3jdLqG83cT6GnhcCzNTrjy6WGy+AHJqJT
         /OBMgHM+0Mhi+xii7lL9uKmsHstX6XK0FJ2gZxgGSMSEwD4skWRBEkJZ14vrqVZjwRsB
         g/oSOsn8Bj2ZCXy5IAHpgUhcpPcHjcTww/3eLeaWFzwwZQRwSumQw1TDwp14Q2tlsRVQ
         wVknKyuY6PQdlhSTaMGWiD1fyG1tMFACDahdJ3M5DO6JPgcf3u29qN16EdQ0bbUJOzyz
         rNtw==
X-Forwarded-Encrypted: i=1; AFNElJ+8F1Ow0TmV4v7OI2HvqMexNhYhcFcpBB9nsa2g6yFm05Mco90CUhS7c/thkw38m9G3kyIGBA4NduwudKOk1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2N2sX0fdKz8nQtYJhq7UF8Yo5jNPZIYUPOjQ3aEdjk2WWw+UB
	C/uXUM6ydO9ufwW1CBvwQj9qdy3TU8jxRggC4rpw74lgDUOZkxASrayXP9wuGUO70wWCnS3DucB
	tTL1B8Q==
X-Received: from pgdh5.prod.google.com ([2002:a05:6a02:5185:b0:c79:7107:a67a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa8:b0:3a0:b65a:5dd1
 with SMTP id adf61e73a8af0-3b3081bfb61mr164633637.0.1779312816324; Wed, 20
 May 2026 14:33:36 -0700 (PDT)
Date: Wed, 20 May 2026 14:33:35 -0700
In-Reply-To: <621e10bdc9e297c6c600b561d8fa25c3b62968bc.camel@infradead.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com> <20260515191942.1892718-3-seanjc@google.com>
 <44e0d60548d317fd59895f18bd17220dfb2f834b.camel@infradead.org>
 <ag4dMc2B3JQi4vxU@google.com> <621e10bdc9e297c6c600b561d8fa25c3b62968bc.camel@infradead.org>
Message-ID: <ag4or9-9c6VZxqya@google.com>
Subject: Re: [PATCH v3 02/41] x86/tsc: Add helper to register CPU and TSC freq
 calibration routines
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBNYXkgMjAsIDIwMjYsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToKPiBPbiBXZWQsIDIw
MjYtMDUtMjAgYXQgMTM6NDQgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gPiAK
PiA+ICvCoMKgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIElmIHRoZSBUU0MgY291
bnRzIGF0IGEgY29uc3RhbnQgZnJlcXVlbmN5IGFjcm9zcyBQL1Qgc3RhdGVzLCBjb3VudHMKPiA+
ICvCoMKgwqDCoMKgwqDCoCAqIGluIGRlZXAgQy1zdGF0ZXMsIGFuZCB0aGUgVFNDIGhhc24ndCBi
ZWVuIG1hcmtlZCB1bnN0YWJsZSwgdHJlYXQgdGhlCj4gPiArwqDCoMKgwqDCoMKgwqAgKiBUU0Mg
cmVsaWFibGUsIGFzIGd1YXJhbnRlZWQgYnkgS1ZNLsKgIE5vdGUsIHRoZSBUU0MgdW5zdGFibGUg
Y2hlY2sKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIGV4aXN0cyBwdXJlbHkgdG8gaG9ub3IgdGhlIFRT
QyBiZWluZyBtYXJrZWQgdW5zdGFibGUgdmlhIGNvbW1hbmQKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IGxpbmUsIGFueSBydW50aW1lIGRldGVjdGlvbiBvZiBhbiB1bnN0YWJsZSB3aWxsIGhhcHBlbiBh
ZnRlciB0aGlzLgo+ID4gK8KgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgIGlmIChi
b290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfQ09OU1RBTlRfVFNDKSAmJgo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgIGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9OT05TVE9QX1RTQykgJiYKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoCAhY2hlY2tfdHNjX3Vuc3RhYmxlKCkpCj4gICAgIHsgCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2NfcHJvcGVydGllcyA9IFRTQ19GUkVRX0tO
T1dOX0FORF9SRUxJQUJMRTsKPiAKPiAgICAga3ZtY2xvY2sgPSAwOyAvKiBXaHkgdXNlIGl0IGlm
IHRoZSBUU0Mgd29ya3M/IFRoZSBrdm1jbG9jayBleGlzdHMKPiAgICAgICAgICAgICAgICAgICAg
ICAqcHVyZWx5KiB0byB3b3JrIGFyb3VuZCBhIFRTQyB3aGljaCAqZG9lc24ndCoKPiAgICAgICAg
ICAgICAgICAgICAgICBoYXZlIHRob3NlIHByb3BlcnRpZXMgY2hlY2tlZCBhYm92ZS4gKi8KCmt2
bWNsb2NrIHN0aWxsIHByb3ZpZGVzIFNZU1RFTV9USU1FIGFuZCBXQUxMX0NMT0NLIDotLwoKPiAg
ICAgfQo+IAo+IEkgd2FzIGdvaW5nIHRvIHNheSBQVkNMT0NLX1RTQ19TVEFCTEVfQklULCBhbmQg
bWF5YmUgd2Ugc2hvdWxkIGNoZWNrCj4gdGhhdCAqdG9vKiBmb3IgcGFyYW5vaWE/CgpObz8gUFZD
TE9DS19UU0NfU1RBQkxFIGlzIHByb3BlcnR5IG9mIGt2bWNsb2NrIG1vcmUgdGhhbiBpdCdzIGEg
cHJvcGVydHkgb2YgdGhlClRTQyBpdHNlbGYuICBBbmQgZm9yIHRoZSBuby1rdm1jbG9jayBjYXNl
LCB3ZSBtb3N0IGRlZmluaXRlbHkgZG9uJ3Qgd2FudCB0byBzZXR1cAprdm1jbG9jayBqdXN0IHRv
IHF1ZXJ5IHRoYXQgZmxhZy4KCj4gQnV0IGhvcGVmdWxseSB0aGUgY2hlY2tzIHlvdSBoYXZlIGFi
b3ZlIGFyZSBlcXVpdmFsZW50PwoKVGhleSBhcmVuJ3QgYXMgcGFyYW5vaWQsIGJ1dCBpZiB0aGUg
aG9zdCBlbnVtZXJhdGVzIENPTlNUQU5UK05PTlNUT1AgVFNDIGRlc3BpdGUKS1ZNLXRoZS1ob3N0
IG5vdCBiZWluZyBhYmxlIHRvIGFkdmVydGlzZSBQVkNMT0NLX1RTQ19TVEFCTEVfQklULCB0aGVu
IHRoZSBWTU0gZG9uZQptZXNzZWQgdXAuCgo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBrdm1fdHNj
X2toel9jcHVpZCA9IGt2bV9wYXJhX3RzY19raHooKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqAg
LyoKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIElmIHByb3ZpZGVkLCB1c2UgdGhlIFRTQyAoYW5kIEFQ
SUMgYnVzKSBmcmVxdWVuY3kgcHJvdmlkZWQgaW4gS1ZNJ3MKPiA+ICvCoMKgwqDCoMKgwqDCoCAq
IFBWIENQVUlEIGxlYWYgZXZlbiBpZiBrdm1jbG9jayBpdHNlbGYgaXMgZGlzYWJsZWQgdmlhIGNv
bW1hbmQgbGluZS4KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSBQViBDUFVJRCBpbmZvcm1hdGlv
biBpc24ndCBkZXBlbmRlbnQgb24ga3ZtY2xvY2sgaW4gYW55IHdheSwgYW5kCj4gPiArwqDCoMKg
wqDCoMKgwqAgKiBpbiBmYWN0IHVzaW5nIHRoZSBwcmVjaXNlIGluZm9ybWF0aW9uIGlzICptb3Jl
KiBpbXBvcnRhbnQgd2hlbiB0aGUKPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHVzZXIgaGFzIGV4cGxp
Y2l0bHkgZGlzYWJsZWQga3ZtY2xvY2sgdG8gZm9yY2UgdGhlIGtlcm5lbCB0byB1c2UgdGhlCj4g
PiArwqDCoMKgwqDCoMKgwqAgKiBUU0MgYXMgaXRzIGNsb2Nrc291cmNlLgo+ID4gK8KgwqDCoMKg
wqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgIGlmICgha3ZtY2xvY2spIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChrdm1fdHNjX2toel9jcHVpZCkKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c2NfcmVnaXN0ZXJfY2FsaWJy
YXRpb25fcm91dGluZXMoa3ZtX2dldF90c2Nfa2h6LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAga3ZtX2dldF9jcHVfa2h6LAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dHNjX3Byb3BlcnRpZXMpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
Owo+ID4gK8KgwqDCoMKgwqDCoCB9Cj4gPiArCj4gCj4gCj4gUmVnYXJkbGVzcyBvZiB0aGUgYWJv
dmUsIHdoeSBub3QganVzdCByZWdpc3RlciB0aGVzZSBoZXJlCj4gdW5jb25kaXRpb25hbGx5LCBh
bmQgcmVtb3ZlIHRoZSBsYXRlciBjYWxsIHRoYXQgZG9lcyB0aGUgc2FtZT8KCkJlY2F1c2UgaWYg
a3ZtY2xvY2s9biwgaXQncyBvbmx5IHNhZmUgdG8gY2FsbCBrdm1fZ2V0X3RzY19raHooKSBpZiBr
dm1fdHNjX2toel9jcHVpZAppcyBub24temVybywgb3RoZXIgd2lzZSB0aGUgImVsc2UiIHBhdGgg
d2lsbCBoaXQgYSBOVUxMIHBvaW50ZXIgZGVyZWYgd2hlbiB0cnlpbmcKdG8gZ2V0IHRoZSBmcmVx
dWVuY3kgZnJvbSB0aGUgUFYgY2xvY2sgc3RydWN0OgoKCXJldHVybiBrdm1fdHNjX2toel9jcHVp
ZCA/IDogcHZjbG9ja190c2Nfa2h6KHRoaXNfY3B1X3B2dGkoKSk7Cg==

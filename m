Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4C8C7EE2A
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 08:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6AD5822E7;
	Mon, 22 May 2023 08:21:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6AD5822E7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jUgVhx6K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ilmAMet3madT; Mon, 22 May 2023 08:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4A1CE822E8;
	Mon, 22 May 2023 08:21:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A1CE822E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2007DC0036;
	Mon, 22 May 2023 08:21:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4346DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 08:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E79A405DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 08:21:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E79A405DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jUgVhx6K
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KcWDnq7YQSZT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 08:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32096402F7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32096402F7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 08:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684743685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Wu/XGI/Cw3LL7Rh46pg9C16OYUTDksjb0N1uf2C+4U=;
 b=jUgVhx6KxSQqAHNbaXwkyMfew+hHUZG17BslBzN7sXTwsTz7YBiKTclnBLKWxn/BdHFNW9
 mn0nG9kA4a72G1tbDRZ5hmiSOiuHlvDgX3jpJ/zpSVZB/2sl27NEtcNzIxYx+EXqajTYyc
 ngtbqwU7Tj56dk73pCU1Y+Q6ySAu+pA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ZlWsGG1iOOyUXBlriYSQAg-1; Mon, 22 May 2023 04:21:16 -0400
X-MC-Unique: ZlWsGG1iOOyUXBlriYSQAg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so13495515e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 01:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684743675; x=1687335675;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Wu/XGI/Cw3LL7Rh46pg9C16OYUTDksjb0N1uf2C+4U=;
 b=hDjTQ6MzbiYY9oH6b/sl1TOiGhHnAWfRJkHEwrBu1LO5hGTulNPsMqLM2GHy0Tjva+
 5+X0Atm4b0oPKAI3YtrJfaOC/YQXmSDXLL6l/gEZKh2BzgEgrdheAhupvcxjoBxT8PAh
 f3IJ3vV80ozcBA+7JmI4ZAAod7cpskYwTTAVRg6yjbB+/lBurnUybyG7dr+6EUl+ea5A
 N/NdNAeFYW37Cywk54AK11Rt/+1GDk+GPNxcEVTsBDS/77oeD5B6zgKrlcYZNmFRwbSM
 XT7XX8/dLwgEUejS7wUnpxG0ybeNIYECDukDcnSS58Na3KLDpOXEx0VRZj3yHprcqHLf
 Gsgg==
X-Gm-Message-State: AC+VfDykQwh/xOhmzrO2xKZ/FPDDgHbZH4pZV+G1sfxhICvWWTOzwAV8
 8SME/rWI7hxH8gtX5h/0yXExdm2pJHA7LODBzG8rrmjQvKrS7Ye8SD5GU140DH1WLCKcmcI4IDI
 DMfWwhNsTcHkUZzmgsgqudDUpsWGo04NjYQkEabNODA==
X-Received: by 2002:a1c:f70e:0:b0:3f4:2b1a:553b with SMTP id
 v14-20020a1cf70e000000b003f42b1a553bmr6741837wmh.28.1684743675399; 
 Mon, 22 May 2023 01:21:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6mG7l4xGGoGOdmClG/pwLidLadfZoXsxEEQrH052zzBQHncEp4Wz9Jql141DWAS4jQSBmoww==
X-Received: by 2002:a1c:f70e:0:b0:3f4:2b1a:553b with SMTP id
 v14-20020a1cf70e000000b003f42b1a553bmr6741816wmh.28.1684743675017; 
 Mon, 22 May 2023 01:21:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558?
 (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de.
 [2003:cb:c742:c800:d74f:aec6:f8ac:558])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05600c021000b003f50d6ee334sm7400593wmi.47.2023.05.22.01.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 01:21:14 -0700 (PDT)
Message-ID: <c7e3152b-4fdd-cb93-a4f0-06502eab59b1@redhat.com>
Date: Mon, 22 May 2023 10:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org,
 Anshuman Khandual <anshuman.khandual@arm.com>
References: <20230512145737.985671-1-bjorn@kernel.org>
 <9aa7d030-19b5-01df-70c0-86d8d6ab86a6@redhat.com>
 <87zg62eqm4.fsf@all.your.base.are.belong.to.us>
 <87lehikpu6.fsf@all.your.base.are.belong.to.us>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 0/7] riscv: Memory Hot(Un)Plug support
In-Reply-To: <87lehikpu6.fsf@all.your.base.are.belong.to.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, linux@rivosinc.com,
 linux-kernel@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Oscar Salvador <osalvador@suse.de>
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

T24gMjEuMDUuMjMgMTE6MTUsIEJqw7ZybiBUw7ZwZWwgd3JvdGU6Cj4gSGkgRGF2aWQgYW5kIEFu
c2h1bWFuIQo+IAo+IEJqw7ZybiBUw7ZwZWwgPGJqb3JuQGtlcm5lbC5vcmc+IHdyaXRlczoKPiAK
Pj4gRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyaXRlczoKPj4KPj4+IE9u
IDEyLjA1LjIzIDE2OjU3LCBCasO2cm4gVMO2cGVsIHdyb3RlOgo+Pj4+IEZyb206IEJqw7ZybiBU
w7ZwZWwgPGJqb3JuQHJpdm9zaW5jLmNvbT4KPj4+Pgo+Pj4+IE1lbW9yeSBIb3QoVW4pUGx1ZyBz
dXBwb3J0IGZvciB0aGUgUklTQy1WIHBvcnQKPj4+PiA9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09Cj4+Cj4+IFsuLi5dCj4+Cj4+Pgo+Pj4gQ29vbCBzdHVmZiEg
SSdtIGZhaXJseSBidXN5IHJpZ2h0IG5vdywgc28gc29tZSBoaWdoLWxldmVsIHF1ZXN0aW9ucyB1
cGZyb250Ogo+Pgo+PiBObyB3b3JyaWVzLCBhbmQgbm8gcnVzaCEgSSdkIHNheSB0aGUgdjEgc2Vy
aWVzIHdhcyBtYWlubHkgZm9yIHRoZSBSSVNDLVYKPj4gZm9sa3MsIGFuZCBJJ3ZlIGdvdCB0b25z
IG9mIChvZmZsaW5lKSBjb21tZW50cyBmcm9tIEFsZXggLS0gYW5kIHdpdGgKPj4geW91ciBjb21t
ZW50cyBiZWxvdyBzb21lIG1vcmUgZGV0YWlscyB0byBmaWd1cmUgb3V0Lgo+IAo+IE9uZSBvZiB0
aGUgbWFqb3IgaXNzdWVzIHdpdGggbXkgdjEgcGF0Y2ggaXMgYXJvdW5kIGluaXRfbW0gcGFnZSB0
YWJsZQo+IHN5bmNocm9uaXphdGlvbiwgYW5kIHRoYXQnbGwgYmUgcGFydCBvZiB0aGUgdjIuCj4g
Cj4gSSd2ZSBub3RpY2VkIHRoZXJlJ3MgYSBxdWl0ZSBhIGRpZmZlcmVuY2UgYmV0d2VlbiB4ODYt
NjQgYW5kIGFybTY0IGluCj4gdGVybXMgb2YgbG9ja2luZywgd2hlbiB1cGRhdGluZyAoYWRkL3Jl
bW92ZSkgdGhlIGluaXRfbW0gdGFibGUuIHg4Ni02NAo+IHVzZXMgdGhlIHVzdWFsIHBhZ2UgdGFi
bGUgbG9ja2luZyBtZWNoYW5pc21zICh1c2VkIGJ5IHRoZSBnZW5lcmljCj4ga2VybmVsIGZ1bmN0
aW9ucyksIHdoZXJlYXMgYXJtNjQgZG9lcyBub3QuCj4gCj4gSG93IGRvZXMgYXJtNjQgbWFuYWdl
IHRvIG1peCB0aGUgImxvY2stbGVzcyIgdXBkYXRlcyAoUkVBRC9XUklURV9PTkNFLAo+IGFuZCBm
ZW5jZXMgaW4gc2V0X3A/ZCtmcmllbmRzKSwgd2l0aCB0aGUgZ2VuZXJpYyBrZXJuZWwgb25lcyB0
aGF0IHVzZXMKPiB0aGUgcmVndWxhciBwYWdlIGxvY2tpbmcgbWVjaGFuaXNtPwo+IAo+IEknbSBv
YnZpb3VzbHkgbWlzc2luZyBzb21ldGhpbmcgYWJvdXQgdGhlIGxvY2tpbmcgcnVsZXMgZm9yIG1l
bW9yeSBob3QKPiBhZGQvcmVtb3ZlLi4uIEkndmUgYmVlbiByZWFkaW5nIHRoZSBhcm02NCBtZW1v
cnkgaG90IGFkZC9yZW1vdmUKPiBzZXJpZXMsIGJ1dCBub25lIHRoZSB3aXNlciEgOy0pCgpJbiBn
ZW5lcmFsLCBtZW1vcnkgaG90KHVuKXBsdWcgaXMgc2VyaWFsaXplZCBvbiBhIGhpZ2ggbGV2ZWwg
dXNpbmcgdGhlIAptZW1faG90cGx1Z19sb2NrLiBGb3IgZXhhbXBsZSwgaW4gcGFnZW1hcF9yYW5n
ZSgpIG9yIGluIAphZGRfbWVtb3J5X3Jlc291cmNlKCksIHdlIGdyYWIgdGhhdCBsb2NrIGluIHdy
aXRlIG1vZGUuIFNvIHdlJ2xsIG5ldmVyIApzZWUgbWVtb3J5IGdldHRpbmcgYWRkZWQvcmVtb3Zl
ZCBjb25jdXJyZW50bHkgZnJvbSB0aGUgZGlyZWN0IG1hcC4KCiBGcm9tIHdoYXQgSSByZWNhbGws
IHRoZSBsb2NraW5nIG9uIHRoZSBhcmNoIGxldmVsIGlzIHJlcXVpcmVkIGZvciAKY29uY3VycmVu
dCAoZGlyZWN0IG1hcHBpbmcpIHBhZ2UgdGFibGUgbW9kaWZpY2F0aW9ucyB0aGF0IHRhcmdldCB2
aXJ0dWFsIAphZGRyZXNzIHJhbmdlcyBhZGphY2VudCB0byB0aGUgcmFuZ2VzIHdlIGhvdCh1bilw
bHVnOgpDT05GSUdfQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVAgYW5kIHZtYWxsb2MgY29tZSB0byBt
aW5kLgoKRm9yIGV4YW1wbGUsIGlmIGEgcmFuZ2Ugd291bGQgYmUgbWFwcGVkIHVzaW5nIGEgbGFy
Z2UgUFVELCBidXQgd2UgaGF2ZSAKdG8gdW5wbHVnIGl0IHBhcnRpYWxseSAodW5wbHVnZ2luZyBt
ZW1vcnkgcGFydCBvZiBib290bWVtKSwgd2UnZCBoYXZlIHRvIApyZXBsYWNlIHRoZSBsYXJnZSBQ
VUQgYnkgYSBQTUQgdGFibGUgZmlyc3QuIFRoYXQgY2hhbmdlICh0aGF0IGNvdWxkIAphZmZlY3Qg
b3RoZXIgY29uY3VycmVudCBwYWdlIHRhYmxlIHdhbGtlcnMvb3BlcmF0aW9ucykgaGFzIHRvIGJl
IApzeW5jaHJvbml6ZWQuCgpJIGd1ZXNzIHRvIHdoaWNoIGRlZ3JlZSB0aGlzIGFwcGxpZXMgdG8g
cmlzY3YgZGVwZW5kcyBvbiB0aGUgdmlydHVhbCAKbWVtb3J5IGxheW91dCwgZGlyZWN0IG1hcHBp
bmcgZ3JhbnVsYXJpdHkgYW5kIGZlYXR1cmVzIChlLmcuLCAKQ09ORklHX0FSQ0hfSEFTX1NFVF9E
SVJFQ1RfTUFQKS4KCgpPbmUgdHJpY2sgdGhhdCBhcm02NCBpbXBsZW1lbnRzIGlzLCB0aGF0IGl0
IG9ubHkgYWxsb3dzIGhvdHVucGx1Z2dpbmcgCm1lbW9yeSB0aGF0IHdhcyBob3RwbHVnZ2VkIChz
ZWUgcHJldmVudF9ib290bWVtX3JlbW92ZV9ub3RpZmllcigpKS4gVGhhdCAKbWlnaHQganVzdCBy
dWxlIG91dCBzdWNoIHByb2JsZW1hdGljIGNhc2VzIHRoYXQgcmVxdWlyZSBsb2NraW5nIApjb21w
bGV0ZWx5LCBhbmQgdGhlIGhpZ2gtbGV2ZWwgbWVtX2hvdHBsdWdfbG9jayBzdWZmaWNpZW50LgoK
LS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

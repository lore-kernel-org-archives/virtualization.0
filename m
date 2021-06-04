Return-Path: <SRS0=Cwtm=K6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679BBC47096
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:46:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314E561407
	for <virtualization@archiver.kernel.org>; Fri,  4 Jun 2021 01:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314E561407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB8E740100;
	Fri,  4 Jun 2021 01:46:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BpQMod05iBMT; Fri,  4 Jun 2021 01:46:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B65440156;
	Fri,  4 Jun 2021 01:46:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDCCC0022;
	Fri,  4 Jun 2021 01:46:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90500C0001;
 Fri,  4 Jun 2021 01:46:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E59A8432F;
 Fri,  4 Jun 2021 01:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ByAoZuYj8_KM; Fri,  4 Jun 2021 01:46:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5E35583CD6;
 Fri,  4 Jun 2021 01:46:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8EF49613FF;
 Fri,  4 Jun 2021 01:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622771168;
 bh=Lpi5gmvDUTHrxYBJ0AOqlt011SOYDrHyNVmLe5HdGy8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ZuyAvsMb4lFdlwmcPxUZP9zxROGdeedSPDV7yiU+Jdix88lBjlybEKKWTJfDEehta
 Laah6xJkGs+MM9Kdy93FpC6ZQKRoENJX3yqvv+deRKewPHTiDNpeTowmCsvqGdDBer
 bLab3XnKzHTMFLhlCXFOZehxjyeutpnEeVbkaGGSXBfQdtsMOYQdqK3PAmHSEauX5k
 iP31NEOcqDyeXWHpqrHeeRa3t123whXOsexrTWJZ2s83u7vVGdp3ikBbdpgcUXDOj2
 7CzUK19NjFOAGn65bgG0nIP8udLpMi6hnDBZ8Cc2Lc07rDrLkyaoOitruCGj6gcdhq
 wd09XZC21d/cw==
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
 <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
 <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
From: Andy Lutomirski <luto@kernel.org>
Message-ID: <308e7187-1ea7-49a7-1083-84cf8654f52a@kernel.org>
Date: Thu, 3 Jun 2021 18:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
Content-Language: en-US
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Josh Poimboeuf <jpoimboe@redhat.com>, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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

T24gNi8zLzIxIDQ6MzIgUE0sIEFuZGkgS2xlZW4gd3JvdGU6Cj4gCj4+IFdlIGRvIG5vdCBuZWVk
IGFuIGluY3JlYXNpbmcgcGlsZSBvZiBrbHVkZ2VzCj4gCj4gRG8geW91IG1lYW4gZGlzYWJsaW5n
IGZlYXR1cmVzIGlzIGEga2x1ZGdlPwo+IAo+IElmIHllcyBJIGRpc2FncmVlIHdpdGggdGhhdCBj
aGFyYWN0ZXJpemF0aW9uLgo+IAo+IAo+PiB0byBtYWtlIFREWCBhbmQgU0VWIOKAnHNlY3VyZeKA
nS7CoCBXZSBuZWVkIHRoZSBhY3R1YWwgbG9hZGVkIGRyaXZlciB0byBiZQo+PiBzZWN1cmUuwqAg
VGhlIHZpcnRpbyBhcmNoaXRlY3R1cmUgaXMgZnVsbCBvZiBsZWdhY3kgbm9uc2Vuc2UsCj4+IGFu
ZCB0aGVyZSBpcyBubyBnb29kIHJlYXNvbiBmb3IgU0VWIGFuZCBURFggdG8gYmUgYSBnaWFudCBz
cGVjaWFsIGNhc2UuCj4gCj4gSSBkb24ndCBrbm93IHdoZXJlIHlvdSBzZWUgYSAiZ2lhbnQgc3Bl
Y2lhbCBjYXNlIi4gRXhjZXB0IGZvciB0aGUKPiBsaW1pdGVkIGZlYXR1cmUgbmVnb3RpYXRpb24g
YWxsIHRoZSBjaGFuZ2VzIGFyZSBjb21tb24sIGFuZCB0aGUKPiBkaXNhYmxpbmcgb2YgZmVhdHVy
ZXMgKHdoaWNoIGlzIG5vdCBuZXcgQlRXLCBidXQgYWxyZWFkeSBkb25lIGUuZy4gd2l0aAo+IGZv
cmNpbmcgRE1BIEFQSSBpbiBzb21lIGNhc2VzKSBjYW4gYmUgb2YgY291cnNlIHVzZWQgYnkgYWxs
IHRoZXNlIG90aGVyCj4gdGVjaG5vbG9naWVzIHRvby4gQnV0IGl0IGp1c3QgY2Fubm90IGJlIGRv
bmUgYnkgZGVmYXVsdCBmb3IgZXZlcnl0aGluZwo+IGJlY2F1c2UgaXQgd291bGQgYnJlYWsgY29t
cGF0aWJpbGl0eS4gU28gZXZlcnkgdGVjaG5vbG9neSB3aXRoIHN1Y2gKPiByZXF1aXJlbWVudHMg
aGFzIHRvIGV4cGxpY2l0bHkgb3B0LWluLgo+IAo+IAo+Pgo+PiBBcyBJIHNhaWQgYmVmb3JlLCBy
ZWFsIFBDSWUgKFRodW5kZXJib2x0L1VTQi1DIG9yIGFueXRoaW5nIGVsc2UpIGhhcwo+PiB0aGUg
ZXhhY3Qgc2FtZSBwcm9ibGVtLsKgIFRoZSBmYWN0IHRoYXQgVERYIGhhcyBlbmNyeXB0ZWQgbWVt
b3J5IGlzLCBhdAo+PiBiZXN0LCBhIHBvb3IgcHJveHkgZm9yIHRoZSBhY3R1YWwgY29uZGl0aW9u
LsKgIFRoZSBhY3R1YWwgY29uZGl0aW9uIGlzCj4+IHRoYXQgdGhlIGhvc3QgZG9lcyBub3QgdHJ1
c3QgdGhlIGRldmljZSB0byBpbXBsZW1lbnQgdGhlIHZpcnRpbwo+PiBwcm90b2NvbCBjb3JyZWN0
bHkuCj4gCj4gUmlnaHQgdGhleSBjYW4gZG8gc2ltaWxhciBsaW1pdGF0aW9ucyBvZiBmZWF0dXJl
IHNldHMuIEJ1dCBhZ2FpbiBpdAo+IGNhbm5vdCBiZSBkZWZhdWx0LgoKTGV0IG1lIHRyeSBhZ2Fp
bi4KCkZvciBtb3N0IExpbnV4IGRyaXZlcnMsIGEgcmVwb3J0IHRoYXQgYSBtaXNiZWhhdmluZyBk
ZXZpY2UgY2FuIGNvcnJ1cHQKaG9zdCBtZW1vcnkgaXMgYSBidWcsIG5vdCBhIGZlYXR1cmUuICBJ
ZiBhIFVTQiBkZXZpY2UgY2FuIGNvcnJ1cHQga2VybmVsCm1lbW9yeSwgdGhhdCdzIGEgc2VyaW91
cyBidWcuICBJZiBhIFVTQi1DIGRldmljZSBjYW4gY29ycnVwdCBrZXJuZWwKbWVtb3J5LCB0aGF0
J3MgYWxzbyBhIHNlcmlvdXMgYnVnLCBhbHRob3VnaCwgc2FkbHksIHdlIHByb2JhYmx5IGhhdmUK
bG90cyBvZiB0aGVzZSBidWdzLiAgSWYgYSBGaXJld2lyZSBkZXZpY2UgY2FuIGNvcnJ1cHQga2Vy
bmVsIG1lbW9yeSwKbmV3cyBhdCAxMS4gIElmIGEgQmx1ZXRvb3RoIG9yIFdpRmkgcGVlciBjYW4g
Y29ycnVwdCBrZXJuZWwgbWVtb3J5LApwZW9wbGUgd3JpdGUgc29ubmV0cyBhYm91dCBpdCBhbmQg
Z2l2ZSBpdCBjbGV2ZXIgbmFtZXMuICBXaHkgaXMgdmlydGlvCnNwZWNpYWw/CgpJZiwgZm9yIHNv
bWUgcmVhc29uLCB0aGUgdmlydGlvIGRyaXZlciBjYW5ub3QgYmUgZml4ZWQgc28gdGhhdCBpdCBp
cwpzZWN1cmUgYW5kIGNvbXBhdGlibGUgWzFdLCB0aGVuIEkgdGhpbmsgdGhhdCB0aGUgbGltaXRl
ZCBjYXNlcyB0aGF0IGFyZQpzZWN1cmUgc2hvdWxkIGJlIGFjY2Vzc2libGUgdG8gYW55b25lLCB3
aXRoIG9yIHdpdGhvdXQgVERYLiAgSGF2ZSBhCnZpcnRpby5zZWN1cmVfbW9kZSBtb2R1bGUgb3B0
aW9uIG9yIGEgdWRldi1jb250cm9sbGFibGUgcGFyYW1ldGVyIG9yIGFuCmFsdGVybmF0aXZlIGRy
aXZlciBuYW1lIG9yICpzb21ldGhpbmcqLiAgQW4gYWx0ZXJuYXRpdmUgZHJpdmVyIG5hbWUKd291
bGQgYWxsb3cgdXNlcnNwYWNlIHRvIHByZXZlbnQgdGhlIGluc2VjdXJlIG1vZGUgZnJvbSBhdXRv
LWJpbmRpbmcgdG8KZGV2aWNlcy4gIEFuZCBtYWtlIHdoYXRldmVyIHN5c3RlbSBjb25maWd1cmVz
IGVuY3J5cHRlZCBndWVzdHMgZm9yCnNlY3VyaXR5IHVzZSB0aGlzIG1vZGUuICAoTGludXggaXMg
bm90IGdvaW5nIHRvIGJlIG1hZ2ljYWxseSBzZWN1cmUganVzdApieSBib290aW5nIGl0IGluIFRE
WC4gIFRoZXJlJ3MgYSB3aG9sZSBwcm9jZXNzIG9mIHVuc2VhbGluZyBvciByZW1vdGUKYXR0ZXN0
YXRpb24sIHNvbWV0aGluZyBuZWVkcyB0byBwcmV2ZW50IHRoZSBoeXBlcnZpc29yIGZyb20gY29u
bmVjdGluZyBhCnZpcnR1YWwga2V5Ym9hcmQgYW5kIHR5cGluZyBpbml0PS9iaW4vYmFzaCwgc29t
ZXRoaW5nIG5lZWRzIHRvIHByb3Zpc2lvbgphbiBTU0gga2V5LCBldGMuKQoKSW4gbXkgb3Bpbmlv
biwgaXQgaXMgbm90IHNvIGdyZWF0IHRvIGlkZW50aWZ5IGJ1Z3MgaW4gdGhlIGRyaXZlciBhbmQK
dGhlbiBzYXkgdGhhdCB0aGV5J3JlIG9ubHkgYmVpbmcgZml4ZWQgZm9yIFREWCBhbmQgU0VWLgoK
S2VlcCBpbiBtaW5kIHRoYXQsIGFzIEkgdW5kZXJzdGFuZCBpdCwgdGhlcmUgaXMgbm90aGluZyB2
aXJ0IHNwZWNpZmljCmFib3V0IHZpcnRpby4gIFRoZXJlIGFyZSByZWFsIHBoeXNpY2FsIGRldmlj
ZXMgdGhhdCBzcGVhayB2aXJ0aW8uCgpbMV0gVGhlIERNQSBxdWlyayBpcyBuYXN0eS4gIEZvcnR1
bmF0ZWx5LCBpdCdzIHRoZSBvbmx5IGNhc2UgSSdtIGF3YXJlCm9mIGluIHdoaWNoIHRoZSB2aXJ0
aW8gZHJpdmVyIGdlbnVpbmVseSBjYW5ub3QgYmUgbWFkZSBzZWN1cmUgYW5kCmNvbXBhdGlibGUg
YXQgdGhlIHNtYWUgdGltZS4gIEFsc28sIGZvcnR1bmF0ZWx5LCBtb3N0IHJlYWwgZGVwbG95bWVu
dHMKZXhjZXB0IG9uIHBvd2VycGMgd29yayBqdXN0IGZpbmUgd2l0aCB0aGUgRE1BIHF1aXJrIHVu
cXVpcmtlZC4KCj4gCj4gCj4+Cj4+Pgo+Pj4gVERYIGFuZCBTRVYgdXNlIHRoZSBhcmNoIGhvb2sg
dG8gZW5mb3JjZSBETUEgQVBJLCBzbyB0aGF0IHBhcnQgaXMgYWxzbwo+Pj4gc29sdmVkLgo+Pj4K
Pj4gQ2FuIHlvdSBwb2ludCBtZSB0byB0aGUgY29kZSB5b3XigJlyZSByZWZlcnJpbmcgdG8/Cj4g
Cj4gU2VlIDQvOCBpbiB0aGlzIHBhdGNoIGtpdC4gSXQgdXNlcyBhbiBleGlzdGluZyBob29rIHdo
aWNoIGlzIGFscmVhZHkKPiB1c2VkIGluIHRyZWUgYnkgczM5MC4KClRoaXMgb25lOgoKaW50IGFy
Y2hfaGFzX3Jlc3RyaWN0ZWRfdmlydGlvX21lbW9yeV9hY2Nlc3Modm9pZCkKK3sKKwlyZXR1cm4g
aXNfdGR4X2d1ZXN0KCk7Cit9CgpJJ20gbG9va2luZyBhdCBhIGZhaXJseSByZWNlbnQga2VybmVs
LCBhbmQgSSBkb24ndCBzZWUgYW55dGhpbmcgZm9yIHMzOTAKd2lyZWQgdXAgaW4gdnJpbmdfdXNl
X2RtYV9hcGkuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=

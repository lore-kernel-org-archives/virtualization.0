Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEB9C4361A
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 17:08:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84F9E22B3B
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 17:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F9E22B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27C7E87E54;
	Fri,  4 Dec 2020 17:08:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wz8nk9Ze0+UL; Fri,  4 Dec 2020 17:08:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B56087916;
	Fri,  4 Dec 2020 17:08:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18CEBC0FA8;
	Fri,  4 Dec 2020 17:08:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86113C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 73AF387D22
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bLIoPLj1IPiQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:08:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7FE6287D23
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 17:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607101702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bJC4mvE44d2tsq5NOZBG+niQorIGdoMkDibEH0VVAX0=;
 b=WF+2o4PxPsTOnOxG9d2GC/gbCuaMaUI8f+okZO84VtrSLs5TdRZqL+ts+ZgLxcTqqUts+r
 0XOqIs0mIz9NWDYncagChfPyLwyZcckKrL8iXtau+Scbc53FOth6U5vKpRSho6ae5O1K1L
 56seTKDS/LM5QGZPt2lkEyxINOx/mS8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-oIRTdh9ZM9mIHtp61I1sEw-1; Fri, 04 Dec 2020 12:08:17 -0500
X-MC-Unique: oIRTdh9ZM9mIHtp61I1sEw-1
Received: by mail-ed1-f72.google.com with SMTP id dc6so2583739edb.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 04 Dec 2020 09:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bJC4mvE44d2tsq5NOZBG+niQorIGdoMkDibEH0VVAX0=;
 b=lfOLmAoXb9gQQbAUbdoAiRMflolOI4aZcr4M2jTZkqBh5JO8s5B6Hm2Ys0xR80snWn
 BWO6rbS6rz+Ps6Qx+DuHxMzmvzY558HhzG1ARrzidmSraMjOmZSispoxEutBosWo4nRk
 NNNS0yHUl2dFkk5TuhAumbGQlw5A6vGnNMXYuXkKDwgrIxpr/mGOOvyFjKfMCtxYtBFX
 5k+U17ZCLKezBfhJG0sSDe/VVm68Od+vEszJQMYEbThzGQgGHd6QJqtciNeCsBCy6Ufp
 R1HmOn5UHdII8iVxYHaIX3n4FVnzxkgd8ziMARm+7rHMHIFUDATLHRDuU/sT/zZn4HM1
 jIIg==
X-Gm-Message-State: AOAM530/jr8z9BsM+9hoekYXmWrByNuRK8qbV5pczugCbhdJ64XU0+Nl
 dmkFqOgWAR17MIJN0H+tg+d0PpdBcDNp9t1wPQkNyIe03IudGtpZUsfBN8fOSKZY+lmKSA/v0DX
 u0cHXMl4iDzd1bPwQnUWx2g19uOyHNJx1GT2m0z3TYA==
X-Received: by 2002:a50:fc8b:: with SMTP id f11mr8619715edq.11.1607101695794; 
 Fri, 04 Dec 2020 09:08:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlThmZUI57vW3KxIu7u8q5x2MUMq+MpfrShE4TQuVtlbHO9ZY1dP69sAeG/4NiTeBY0Zgf4A==
X-Received: by 2002:a50:fc8b:: with SMTP id f11mr8619692edq.11.1607101695613; 
 Fri, 04 Dec 2020 09:08:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t8sm3642431eju.69.2020.12.04.09.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Dec 2020 09:08:14 -0800 (PST)
To: Sasha Levin <sashal@kernel.org>
References: <20201129041314.GO643756@sasha-vm>
 <7a4c3d84-8ff7-abd9-7340-3a6d7c65cfa7@redhat.com>
 <20201129210650.GP643756@sasha-vm>
 <e499986d-ade5-23bd-7a04-fa5eb3f15a56@redhat.com>
 <20201130173832.GR643756@sasha-vm>
 <238cbdd1-dabc-d1c1-cff8-c9604a0c9b95@redhat.com>
 <9ec7dff6-d679-ce19-5e77-f7bcb5a63442@oracle.com>
 <4c1b2bc7-cf50-4dcd-bfd4-be07e515de2a@redhat.com>
 <20201130235959.GS643756@sasha-vm>
 <6c49ded5-bd8f-f219-0c51-3500fd751633@redhat.com>
 <20201204154911.GZ643756@sasha-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.9 22/33] vhost scsi: add lun parser helper
Message-ID: <d071d714-3ebd-6929-3f3b-c941cce109f8@redhat.com>
Date: Fri, 4 Dec 2020 18:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201204154911.GZ643756@sasha-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

T24gMDQvMTIvMjAgMTY6NDksIFNhc2hhIExldmluIHdyb3RlOgo+IE9uIEZyaSwgRGVjIDA0LCAy
MDIwIGF0IDA5OjI3OjI4QU0gKzAxMDAsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4+IE9uIDAxLzEy
LzIwIDAwOjU5LCBTYXNoYSBMZXZpbiB3cm90ZToKPj4+Cj4+PiBJdCdzIHF1aXRlIGVhc3kgdG8g
TkFLIGEgcGF0Y2ggdG9vLCBqdXN0IHJlcGx5IHNheWluZyAibm8iIGFuZCBpdCdsbCBiZQo+Pj4g
ZHJvcHBlZCAoanVzdCBsaWtlIHRoaXMgcGF0Y2ggd2FzIGRyb3BwZWQgcmlnaHQgYWZ0ZXIgeW91
ciBmaXJzdCByZXBseSkKPj4+IHNvIHRoZSBidXJkZW4gb24gbWFpbnRhaW5lcnMgaXMgbWluaW1h
bC4KPj4KPj4gVGhlIG1haW50YWluZXJzIGFyZSBfYWxyZWFkeV8gbWFya2luZyBwYXRjaGVzIHdp
dGggIkNjOiBzdGFibGUiLsKgIFRoYXQgCj4gCj4gVGhleSdyZSBub3QsIHRob3VnaC4gU29tZSBm
b3JnZXQsIHNvbWUgc3Vic3lzdGVtcyBkb24ndCBtYXJrIGFueXRoaW5nLAo+IHNvbWUgZG9uJ3Qg
bWFyayBpdCBhcyBpdCdzIG5vdCBzdGFibGUgbWF0ZXJpYWwgd2hlbiBpdCBsYW5kcyBpbiB0aGVp
cgo+IHRyZWUgYnV0IHRoZW4gaXQgdHVybnMgb3V0IHRvIGJlIG9uZSBpZiBpdCBzaXRzIHRoZXJl
IGZvciB0b28gbG9uZy4KClRoYXQgbWVhbnMgc29tZSBzdWJzeXN0ZW1zIHdpbGwgYmUgd29yc2Ug
YXMgZmFyIGFzIHN0YWJsZSByZWxlYXNlIApzdXBwb3J0IGdvZXMuICBUaGF0J3Mgbm90IGEgcHJv
YmxlbToKCi0gc29tZSBzdWJzeXN0ZW1zIGhhdmUgcGVvcGxlIHBhaWQgdG8gZG8gYmFja3BvcnRz
IHRvIExUUyByZWxlYXNlcyB3aGVuIApwYXRjaGVzIGRvbid0IGFwcGx5OyBvdGhlcnMgZG9uJ3Qs
IGlmIHRoZSBwYXRjaCBkb2Vzbid0IGFwcGx5IHRoZSBidWcgaXMgCnNpbXBseSBub3QgZml4ZWQg
aW4gTFRTIHJlbGVhc2VzCgotIHNvbWUgc3Vic3lzdGVtcyBhcmUgd29yc2UgdGhhbiBvdGhlcnMg
ZXZlbiBpbiAibm9ybWFsIiByZWxlYXNlcyA6KQoKPj4gKHBsdXMgYmFja3BvcnRzKSBpcyB3aGVy
ZSB0aGUgYnVyZGVuIG9uIG1haW50YWluZXJzIHNob3VsZCBzdGFydCBhbmQgCj4+IGVuZC7CoCBJ
IGRvbid0IHNlZSB0aGUgbmVlZCB0byBzZWNvbmQgZ3Vlc3MgdGhlbS4KPiAKPiBUaGlzIGlzIHNp
bWlsYXIgdG8gZGVzY3JpYmluZyBvdXIgQ0kgaW5mcmFzdHJ1Y3R1cmUgYXMgInNlY29uZAo+IGd1
ZXNzaW5nIjogd2h5IGFyZSB3ZSBzZWNvbmQgZ3Vlc3NpbmcgYXV0aG9ycyBhbmQgbWFpbnRhaW5l
cnMgd2hvIGFyZQo+IG9idmlvdXNseSBkb2luZyB0aGUgcmlnaHQgdGhpbmcgYnkgdGVzdGluZyB0
aGVpciBwYXRjaGVzIGFuZCByZXBvcnRpbmcKPiBpc3N1ZXMgdG8gdGhlbT8KCk5vLCBpdCdzIG5v
dCB0aGUgc2FtZS4gIENJIGhlbHBzIGZpbmRpbmcgYnVncyBiZWZvcmUgeW91IGhhdmUgdG8gd2Fz
dGUgCnRpbWUgc3BlbmRpbmcgYmlzZWN0aW5nIHJlZ3Jlc3Npb25zIGFjcm9zcyB0aG91c2FuZHMg
b2YgY29tbWl0cy4gIFRoZSAKbGFjayBvZiBzdGFibGUgdGFncyBfY2FuXyBjZXJ0YWlubHkgYmUg
YSBwcm9ibGVtLCBidXQgaXQgc29sdmVzIGl0c2VsZiAKc29vbmVyIG9yIGxhdGVyIHdoZW4gcGVv
cGxlIHVwZ3JhZGUgdGhlaXIga2VybmVsLgoKPiBBcmUgeW91IHNheWluZyB0aGF0IHlvdSBoYXZl
IGFsd2F5cyBnb3R0ZW4gc3RhYmxlIHRhZ3MgcmlnaHQ/IG5ldmVyCj4gbWlzc2VkIGEgc3RhYmxl
IHRhZyB3aGVyZSBvbmUgc2hvdWxkIGdvPwoKT2YgY291cnNlIEkgZGlkLCBqdXN0IGxpa2UgSSBo
YXZlIGludHJvZHVjZWQgYnVncy4gIEJ1dCBhdCBsZWFzdCBJIHRyeSAKdG8gZG8gbXkgYmVzdCBi
b3RoIGF0IGFkZGluZyBzdGFibGUgdGFncyBhbmQgYXQgbm90IGludHJvZHVjaW5nIGJ1Z3MuCgpQ
YW9sbwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

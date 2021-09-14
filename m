Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770BAC433EF
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:20:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18056610F9
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 02:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18056610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5C16607AD;
	Tue, 14 Sep 2021 02:20:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XrXJMjeIzBlE; Tue, 14 Sep 2021 02:20:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 63BD36073D;
	Tue, 14 Sep 2021 02:20:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B911C0011;
	Tue, 14 Sep 2021 02:20:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA295C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DF15402C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dubb954kphS2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:20:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 577EC400C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 02:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631586036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rcYJHx/4UcJXZGKmDo86svliqJbYFIRBfH+q9c03jV8=;
 b=K/tQ/2mZ6iDR1Sy0/wtJtFmz9pEtYRwr03GpbyP2+q26mIhN/mtp88RYh01ddfZUTonu8R
 DJaWV03hkG6+r46m1BJOVPGANUALBHtAeRxp7CrqwupcCxnaIV+Bfsu2Lw8BCeWJMGKnLV
 BjH6S9vl9aAcbNzciYqBpaKZ1Ly78zg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-SmTGOHFcNgW367xWbRaQOA-1; Mon, 13 Sep 2021 22:20:34 -0400
X-MC-Unique: SmTGOHFcNgW367xWbRaQOA-1
Received: by mail-pg1-f198.google.com with SMTP id
 t28-20020a63461c000000b00252078b83e4so8512370pga.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 19:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rcYJHx/4UcJXZGKmDo86svliqJbYFIRBfH+q9c03jV8=;
 b=QoUMKO/DO6MJXaZErd7RZUF5Jj1iaSF0tb3leDcfRADxDst2QbYUm/9k3KuMlKg+mD
 edsYz5qVpDCCFuLcJqIjEN0bnCZYf9NiGRaCOagJnira+i80gmsDL8fcsQpPmoBwQZML
 Pvg9CMFpzq1fHLDtb9X2QQdpUdZ3lSXZislUjC5wV+tS5JGwcIwWQpFQztirphP8S7ep
 GL5IqrsTUHTN85LjJcxAp/iQUtTnCBAvlnfPUQvZ2RXFQj8JSaCcLGQGDYJHoyUSGJoy
 RZLo1GEqgVxgzGdbFNxcqDvi/b+hXmsI45Ascg5VzBwMg+6cYTJ6T63K7UtQwG1NmBS9
 36ng==
X-Gm-Message-State: AOAM532T9tQ5XpfXT0Zxb3MW2aGx8m3jLcbByDasFdTx4YVgmxQpWqni
 caZNEb8sOeF4VhreHsOom3ShMG7GN4bVnyloGj6tltWAPkkaTVhpbzOaef1cSkmL/mqSx4Zo8ev
 xnNXCWf/PHHGl667djHEVWV5gL09PWBOiKBLvBsU8RA==
X-Received: by 2002:a17:902:bcc6:b0:138:d3ca:c356 with SMTP id
 o6-20020a170902bcc600b00138d3cac356mr12957338pls.6.1631586033277; 
 Mon, 13 Sep 2021 19:20:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTi2t9kwRmgzAkZOi4siQl5/JqG3e4HK5NmMFCXfex3BVoLj5jj59CSw0hkzWSUkEcyY9uOw==
X-Received: by 2002:a17:902:bcc6:b0:138:d3ca:c356 with SMTP id
 o6-20020a170902bcc600b00138d3cac356mr12957317pls.6.1631586033012; 
 Mon, 13 Sep 2021 19:20:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g3sm7944621pjm.22.2021.09.13.19.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 19:20:32 -0700 (PDT)
Subject: Re: [PATCH 6/9] virtio_pci: harden MSI-X interrupts
To: Thomas Gleixner <tglx@linutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-7-jasowang@redhat.com>
 <20210913015711-mutt-send-email-mst@kernel.org>
 <CACGkMEva2j57tG=-QYG7NdgEV28i-gpBReRR+UX7YwrHzRWydw@mail.gmail.com>
 <20210913022257-mutt-send-email-mst@kernel.org>
 <CACGkMEsWJq0SMMfTBdoOxVa1_=k9nZkrRu2wYZo7WO-01p_sgQ@mail.gmail.com>
 <20210913023626-mutt-send-email-mst@kernel.org>
 <20210913024153-mutt-send-email-mst@kernel.org>
 <CACGkMEu+HPBTV81EHOc6zWP7tTgTf4nDaXViUeejmT-Bhp0PEA@mail.gmail.com>
 <87bl4wfeq1.ffs@tglx> <20210913164934-mutt-send-email-mst@kernel.org>
 <87sfy8ds53.ffs@tglx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <98ddcf92-b0c8-77c3-d1ca-9855896a2600@redhat.com>
Date: Tue, 14 Sep 2021 10:20:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87sfy8ds53.ffs@tglx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <knsathya@kernel.org>, "kaplan,
 david" <david.kaplan@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 James E J Bottomley <James.Bottomley@hansenpartnership.com>,
 Dave Hansen <dave.hansen@intel.com>, Peter H Anvin <hpa@zytor.com>,
 Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Hetzelt,
 Felicitas" <f.hetzelt@tu-berlin.de>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Richard Henderson <rth@twiddle.net>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, pbonzini <pbonzini@redhat.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOS8xNCDJz87nNjozMSwgVGhvbWFzIEdsZWl4bmVyINC0tcA6Cj4gT24gTW9uLCBT
ZXAgMTMgMjAyMSBhdCAxNjo1NCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Cj4+IE9uIE1v
biwgU2VwIDEzLCAyMDIxIGF0IDA5OjM4OjMwUE0gKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90
ZToKPj4+IE9uIE1vbiwgU2VwIDEzIDIwMjEgYXQgMTU6MDcsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4gT24gTW9uLCBTZXAgMTMsIDIwMjEgYXQgMjo1MCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IEJ1dCBkb2VuJ3QgImlycSBpcyBkaXNhYmxlZCIg
YmFzaWNhbGx5IG1lYW4gIndlIHRvbGQgdGhlIGh5cGVydmlzb3IKPj4+Pj4+IHRvIGRpc2FibGUg
dGhlIGlycSI/ICBXaGF0IGV4dHJhY3RseSBwcmV2ZW50cyBoeXBlcnZpc29yIGZyb20KPj4+Pj4+
IHNlbmRpbmcgdGhlIGlycSBldmVuIGlmIGd1ZXN0IHRoaW5rcyBpdCBkaXNhYmxlZCBpdD8KPj4+
Pj4gTW9yZSBnZW5lcmFsbHksIGNhbid0IHdlIGZvciBleGFtcGxlIGJsb3cgYXdheSB0aGUKPj4+
Pj4gaW5kaXJfZGVzYyBhcnJheSB0aGF0IHdlIHVzZSB0byBrZWVwIHRoZSBjdHggcG9pbnRlcnM/
Cj4+Pj4+IFdvbid0IHRoYXQgYmUgZW5vdWdoPwo+Pj4+IEknbSBub3Qgc3VyZSBob3cgaXQgaXMg
cmVsYXRlZCB0byB0aGUgaW5kaXJlY3QgZGVzY3JpcHRvciBidXQgYW4KPj4+PiBleGFtcGxlIGlz
IHRoYXQgYWxsIHRoZSBjdXJyZW50IGRyaXZlciB3aWxsIGFzc3VtZToKPj4+Pgo+Pj4+IDEpIHRo
ZSBpbnRlcnJ1cHQgd29uJ3QgYmUgcmFpc2VkIGJlZm9yZSB2aXJ0aW9fZGV2aWNlX3JlYWR5KCkK
Pj4+PiAyKSB0aGUgaW50ZXJydXB0IHdvbid0IGJlIHJhaXNlZCBhZnRlciByZXNldCgpCj4+PiBJ
ZiB0aGF0IGFzc3VtcHRpb24gZXhpc3RzLCB0aGVuIHlvdSBiZXR0ZXIga2VlcCB0aGUgaW50ZXJy
dXB0IGxpbmUKPj4+IGRpc2FibGVkIHVudGlsIHZpcnRpb19kZXZpY2VfcmVhZHkoKSBoYXMgY29t
cGxldGVkCj4+IHN0YXJ0ZWQgbm90IGNvbXBsZXRlZC4gZGV2aWNlIGlzIGFsbG93ZWQgdG8gc2Vu
ZAo+PiBjb25maWcgaW50ZXJydXB0cyByaWdodCBhZnRlciBEUklWRVJfT0sgc3RhdHVzIGlzIHNl
dCBieQo+PiB2aXJ0aW9fZGV2aWNlX3JlYWR5Lgo+IFdoYXRldmVyOgo+Cj4gICAqIERlZmluZSB0
aGUgZXhhY3QgcG9pbnQgZnJvbSB3aGljaCBvbiB0aGUgZHJpdmVyIGlzIGFibGUgdG8gaGFuZGxl
IHRoZQo+ICAgICBpbnRlcnJ1cHQgYW5kIHB1dCB0aGUgZW5hYmxlIGFmdGVyIHRoYXQgcG9pbnQK
Pgo+ICAgKiBEZWZpbmUgdGhlIGV4YWN0IHBvaW50IGZyb20gd2hpY2ggb24gdGhlIGRyaXZlciBp
cyB1bmFibGUgdG8gaGFuZGxlCj4gICAgIHRoZSBpbnRlcnJ1cHQgYW5kIHB1dCB0aGUgZGlzYWJs
ZSBiZWZvcmUgdGhhdCBwb2ludAoKClllcywgdGhpcyBpcyBleGFjdGx5IHdoYXQgdGhpcyBwYXRj
aCAoYW5kIElOVFggcGF0Y2gpIHdhbnQgdG8gYWNoaWV2ZS4gClRoZSBkcml2ZXIgc2hvdWxkIG9u
bHkgYWJsZSB0byBoYW5kbGUgdGhlIGludGVycnVwdCBhZnRlciAKdmlydGlvX2RldmljZV9yZWFk
eSgpIGJ1dCBiZWZvcmUgcmVzZXQoKS4KClRoYW5rcwoKCj4KPiBUaGUgYWJvdmUgaXMgYmx1cnku
Cj4KPj4+IGFuZCBkaXNhYmxlIGl0IGFnYWluCj4+PiBiZWZvcmUgcmVzZXQoKSBpcyBpbnZva2Vk
LiBUaGF0J3MgYSBxdWVzdGlvbiBvZiBnZW5lcmFsIHJvYnVzdG5lc3MgYW5kCj4+PiBub3QgcmVh
bGx5IGEgcXVlc3Rpb24gb2YgdHJ1c3RlZCBoeXBlcnZpc29ycyBhbmQgZW5jcnlwdGVkIGd1ZXN0
cy4KPj4gV2UgY2FuIGRvIHRoaXMgZm9yIHNvbWUgTVNJWCBpbnRlcnJ1cHRzLCBzdXJlLiBOb3Qg
Zm9yIHNoYXJlZCBpbnRlcnJ1cHRzIHRob3VnaC4KPiBTZWUgbXkgcmVwbHkgdG8gdGhlIG5leHQg
cGF0Y2guIFRoZSBwcm9ibGVtIGlzIHRoZSBzYW1lOgo+Cj4gICAqIERlZmluZSB0aGUgZXhhY3Qg
cG9pbnQgZnJvbSB3aGljaCBvbiB0aGUgZHJpdmVyIGlzIGFibGUgdG8gaGFuZGxlIHRoZQo+ICAg
ICBpbnRlcnJ1cHQgYW5kIGFsbG93IHRoZSBoYW5kbGVyIHRvIHByb2NlZWQgYWZ0ZXIgdGhhdCBw
b2ludAo+Cj4gICAqIERlZmluZSB0aGUgZXhhY3QgcG9pbnQgZnJvbSB3aGljaCBvbiB0aGUgZHJp
dmVyIGlzIHVuYWJsZSB0byBoYW5kbGUKPiAgICAgdGhlIGludGVycnVwdCBhbmQgZW5zdXJlIHRo
YXQgdGhlIGhhbmRsZXIgZGVuaWVzIHRvIHByb2NlZWQgYmVmb3JlCj4gICAgIHRoYXQgcG9pbnQK
Pgo+IFNhbWUgc3RvcnkganVzdCBhIGRpZmZlcmVudCBtZWNoYW5pc20uCj4KPiBUaGFua3MsCj4K
PiAgICAgICAgICB0Z2x4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

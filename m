Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B352C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 11:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B564F813A1;
	Thu, 28 Apr 2022 11:06:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P04A7gwIRiiP; Thu, 28 Apr 2022 11:06:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 31D328131B;
	Thu, 28 Apr 2022 11:06:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05C7CC0032;
	Thu, 28 Apr 2022 11:06:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CACC4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A3EA781343
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:06:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zxynKFfz1jLe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:06:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C96B78131B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651144003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOu5am8KOe0yhknijbWSc9nIgISI1EHhtzqNkNPo72Q=;
 b=cXYCUjrVQV2poKkZRipFWB7Q2oPad6PQCxXdAKYhf9w8/YEjGuM0FOf+hKp3gw4G5x+vLs
 af1HCaCuSOwl1OXuJkjuOX47sCqAoXUq0Zvfwbn5t3tlkKgBGJitpNAUuRJ8LYibvmRoKQ
 a8UaPmdpaRTAwSyC9MdELtnjYxwjFao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-1sBsL9QMNYSIWX32t643lw-1; Thu, 28 Apr 2022 07:06:41 -0400
X-MC-Unique: 1sBsL9QMNYSIWX32t643lw-1
Received: by mail-wr1-f70.google.com with SMTP id
 y13-20020adfc7cd000000b0020ac7c7bf2eso1797942wrg.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=fOu5am8KOe0yhknijbWSc9nIgISI1EHhtzqNkNPo72Q=;
 b=vXLRpPYVrS0XX18SkG+mS0zrvINwZzKPeu5BvL/Jvcw2zmevkRiBuukv8daGFI5Fgs
 dtzytNmWuc7+0dwPHE0DVsTwX3tGYJtiQ/uycKkJjKYG2oXHii7rfBtpnNhvqI6jKY3M
 KWQBfbXVceFKms9NwB4QplGuMPSQ1EAPiu82iy4aJhhWF+zPUVUA0jYudTvISUBZ/tAo
 xpQbUBF7Rfo/7rxXhNVgqX676HNxys5YJbMaUd9zBCcSrjw4V3rbrnydfgoCo+C17s4P
 fj9ZvAaCqv4inWpHpiJzoTOco86eBSyZWjdaAS9Bh7QrhLzJ+mQExVZHH9DUE7nAABDP
 mf2w==
X-Gm-Message-State: AOAM531X0kPLDKeG8PNpUOF7tyJ3OHpcQ6Dxsf5GEKlm1w2BUwUT0p61
 x7stqmcPCSxP3BenTVfrf2XZvPEbhsu81NgE/egkk6mi4pH0Ot6fLzAxXq/RC3PTQBJi2qDA8bt
 szCeGv8Xs5kKjwR2aA0xegwKx1/1rRjnanx+trvse8g==
X-Received: by 2002:a1c:5459:0:b0:394:1191:a1ff with SMTP id
 p25-20020a1c5459000000b003941191a1ffmr2210270wmi.96.1651144000698; 
 Thu, 28 Apr 2022 04:06:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEuh7RPsaIpF9AUu/qCwpZ+jPB//bHxmrpwyPaS8uUDyhj5LkvVK/8+RDdhQEUo0XlzAiVfg==
X-Received: by 2002:a1c:5459:0:b0:394:1191:a1ff with SMTP id
 p25-20020a1c5459000000b003941191a1ffmr2210246wmi.96.1651144000472; 
 Thu, 28 Apr 2022 04:06:40 -0700 (PDT)
Received: from redhat.com ([2.53.18.16]) by smtp.gmail.com with ESMTPSA id
 17-20020a05600c021100b00393faf12859sm4258790wmi.18.2022.04.28.04.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 04:06:39 -0700 (PDT)
Date: Thu, 28 Apr 2022 07:06:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
Subject: Re: [PATCH 3/3] virtio-pci: Use cpumask_available to fix compilation
 error
Message-ID: <20220428070620-mutt-send-email-mst@kernel.org>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-4-dinechin@redhat.com>
 <20220415044657-mutt-send-email-mst@kernel.org>
 <3D264F7F-624D-4E9D-A139-F1DB0CC6045C@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3D264F7F-624D-4E9D-A139-F1DB0CC6045C@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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

T24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTE6NDg6MDFBTSArMDIwMCwgQ2hyaXN0b3BoZSBNYXJp
ZSBGcmFuY29pcyBEdXBvbnQgZGUgRGluZWNoaW4gd3JvdGU6Cj4gCj4gCj4gPiBPbiAxNSBBcHIg
MjAyMiwgYXQgMTA6NDgsIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+ID4gCj4gPiBPbiBUaHUsIEFwciAxNCwgMjAyMiBhdCAwNTowODo1NVBNICswMjAwLCBDaHJp
c3RvcGhlIGRlIERpbmVjaGluIHdyb3RlOgo+ID4+IFdpdGggR0NDIDEyIGFuZCBkZWZjb25maWcs
IHdlIGdldCB0aGUgZm9sbG93aW5nIGVycm9yOgo+ID4+IAo+ID4+IHwgICBDQyAgICAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLm8KPiA+PiB8IGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfY29tbW9uLmM6IEluIGZ1bmN0aW9uIOKAmHZwX2RlbF92cXPigJk6Cj4gPj4gfCBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jOjI1NzoyOTogZXJyb3I6IHRoZSBjb21wYXJp
c29uIHdpbGwKPiA+PiB8ICBhbHdheXMgZXZhbHVhdGUgYXMg4oCYdHJ1ZeKAmSBmb3IgdGhlIHBv
aW50ZXIgb3BlcmFuZCBpbgo+ID4+IHwgIOKAmHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrcyAr
IChzaXpldHlwZSkoKGxvbmcgdW5zaWduZWQgaW50KWkgKiA4KeKAmQo+ID4+IHwgIG11c3Qgbm90
IGJlIE5VTEwgWy1XZXJyb3I9YWRkcmVzc10KPiA+PiB8ICAgMjU3IHwgICAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSkKPiA+PiB8ICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgo+ID4+IAo+ID4+IFRoaXMgaGFw
cGVucyBpbiB0aGUgY2FzZSB3aGVyZSBDT05GSUdfQ1BVTUFTS19PRkZTVEFDSyBpcyBub3QgZGVm
aW5lZCwKPiA+PiBzaW5jZSB3ZSB0eXBlZGVmIGNwdW1hc2tfdmFyX3QgYXMgYW4gYXJyYXkuIFRo
ZSBjb21waWxlciBpcyBlc3NlbnRpYWxseQo+ID4+IGNvbXBsYWluaW5nIHRoYXQgYW4gYXJyYXkg
cG9pbnRlciBjYW5ub3QgYmUgTlVMTC4gVGhpcyBpcyBub3QgYSB2ZXJ5Cj4gPj4gaW1wb3J0YW50
IHdhcm5pbmcsIGJ1dCB0aGVyZSBpcyBhIGZ1bmN0aW9uIGNhbGxlZCBjcHVtYXNrX2F2YWlsYWJs
ZSB0aGF0Cj4gPj4gc2VlbXMgdG8gYmUgZGVmaW5lZCBqdXN0IGZvciB0aGF0IGNhc2UsIHNvIHRo
ZSBmaXggaXMgZWFzeS4KPiA+PiAKPiA+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIGRlIERp
bmVjaGluIDxjaHJpc3RvcGhlQGRpbmVjaGluLm9yZz4KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RvcGhlIGRlIERpbmVjaGluIDxkaW5lY2hpbkByZWRoYXQuY29tPgo+ID4gCj4gPiBUaGVyZSB3
YXMgYW4gYWx0ZXJuYXRlIHBhdGNoIHByb3Bvc2VkIGZvciB0aGlzIGJ5Cj4gPiBNdXJpbG8gT3Bz
ZmVsZGVyIEFyYXVqby4gV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhhdCBhcHByb2FjaD8KPiAK
PiBJIHJlc3BvbmRlZCBvbiB0aGUgb3RoZXIgdGhyZWFkLCBidXQgbGV0IG1lIHNoYXJlIHRoZSBy
ZXNwb25zZSBoZXJlOgo+IAo+IFt0byBtdXJpbG9vQGxpbnV4LmlibS5jb21dCj4gQXBvbG9naWVz
IGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uZGluZywgYnJva2VuIGxhcHRvcOKApgo+IAo+IEluIHRo
ZSBjYXNlIHdoZXJlIENPTkZJR19DUFVNQVNLX09GRlNUQUNLIGlzIG5vdCBkZWZpbmVkLCB3ZSBo
YXZlOgo+IAo+IAl0eXBlZGVmIHN0cnVjdCBjcHVtYXNrIGNwdW1hc2tfdmFyX3RbMV07Cj4gCj4g
U28gdGhhdCB2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0gaXMgc3RhdGljYWxseSBub3Qg
bnVsbCAodGhhdOKAmXMgdGhlIHdhcm5pbmcpCj4gYnV0IGFsc28gYSBzdGF0aWMgcG9pbnRlciwg
c28gbm90IGtmcmVlLXNhZmUgSU1PLgoKCk5vdCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBh
cmUgc2F5aW5nIGhlcmUuCgo+ID4gCj4gPiAKPiA+PiAtLS0KPiA+PiBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2NvbW1vbi5jIHwgMiArLQo+ID4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+ID4+IAo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
Ywo+ID4+IGluZGV4IGQ3MjRmNjc2NjA4Yi4uNWM0NGEyZjEzYzkzIDEwMDY0NAo+ID4+IC0tLSBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPiA+PiArKysgYi9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4gPj4gQEAgLTI1NCw3ICsyNTQsNyBAQCB2b2lkIHZw
X2RlbF92cXMoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPj4gCj4gPj4gCWlmICh2cF9k
ZXYtPm1zaXhfYWZmaW5pdHlfbWFza3MpIHsKPiA+PiAJCWZvciAoaSA9IDA7IGkgPCB2cF9kZXYt
Pm1zaXhfdmVjdG9yczsgaSsrKQo+ID4+IC0JCQlpZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21h
c2tzW2ldKQo+ID4+ICsJCQlpZiAoY3B1bWFza19hdmFpbGFibGUodnBfZGV2LT5tc2l4X2FmZmlu
aXR5X21hc2tzW2ldKSkKPiA+PiAJCQkJZnJlZV9jcHVtYXNrX3Zhcih2cF9kZXYtPm1zaXhfYWZm
aW5pdHlfbWFza3NbaV0pOwo+ID4+IAl9Cj4gPj4gCj4gPj4gLS0gCj4gPj4gMi4zNS4xCj4gPiAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

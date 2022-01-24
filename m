Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF27BC433EF
	for <virtualization@archiver.kernel.org>; Mon, 24 Jan 2022 11:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 371AA40351;
	Mon, 24 Jan 2022 11:08:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yKbilmNo7HkU; Mon, 24 Jan 2022 11:08:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBA5E4030F;
	Mon, 24 Jan 2022 11:08:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8721CC0039;
	Mon, 24 Jan 2022 11:08:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9441FC0039
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 877198281A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gF-EsyolFQEc
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:08:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0826814B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643022482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3OfjbybQhhjg38hxkb3LOYjXJwz/mjLMPdefaFIE4qY=;
 b=QvhFrR+Yt8IYvLSHiEkH01rxlsPRT59qLY0xPNYGjeRIPfxH8Bu6FLQ/vnakVFNXT8qHH9
 7cShd3YsnyF0m7DTNZN8zadqKDxVdDsIMFb9r+hDCajiqM11VYaN3gea0Bzdx/NQLJjFYF
 92ogMH/1/NJ66vPtDo9sZAbGzfZ4y4c=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-hI8-23hXPvqh6hNE22cYWg-1; Mon, 24 Jan 2022 06:08:00 -0500
X-MC-Unique: hI8-23hXPvqh6hNE22cYWg-1
Received: by mail-pj1-f71.google.com with SMTP id
 i8-20020a17090a718800b001b35ee7ac29so11788847pjk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 03:08:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3OfjbybQhhjg38hxkb3LOYjXJwz/mjLMPdefaFIE4qY=;
 b=D5Xwmm3U5xayL9H128uvkq0r3BCtrVGv98N23FUwugxBlSCimVZT/pQhvlOjy3TzFF
 dM9oWIIU0d/Z+OBkwpWyPnMfd68p3MMG7z9kW24bx2at3LzFvEMVLF+ALK+VaB1hGn3h
 UmreBCkRLc/EIBBpqJxHZCExB4Vjv/W/r6+CLp1MTf8oQIKYP3B9s71WKcRK2io70Jbo
 zejgzCMDSu4t/VL/eD1Nx9iukrpEcMkvJGX559IPqVWplyfmagpJrvvqha0f8n2beVDl
 2fIB7v5/KxQ9Mx5uI5BhFItowZop4BD4zKwJ96Sb9IgRhzwfC3O4r6DcdHuriiiJYxKe
 /dMA==
X-Gm-Message-State: AOAM530/iSjB2JCGgOmXxbREQc45Qx9+DXU6xh0ToYAz8oCgzchEKqAi
 F97AT54orjfI2oLksM3xGCIMFqhWtWq+5ZyHb8zjxaBLas99S5ePz3gtWVERUSSyhdZxnWmrsOR
 uVMYGOsnFkjuA1f8wbU8ooz+J//bEBYU+fyIm06vnlg==
X-Received: by 2002:a17:902:dac9:b0:14a:52d1:a266 with SMTP id
 q9-20020a170902dac900b0014a52d1a266mr13446883plx.161.1643022479178; 
 Mon, 24 Jan 2022 03:07:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9+7YNHi/g2m7Mhl9qkD+p0twt4AoQ/T+tqXBDwszEC6eVuSyIg54W0jPFZ/lBNL4HefQQZg==
X-Received: by 2002:a17:902:dac9:b0:14a:52d1:a266 with SMTP id
 q9-20020a170902dac900b0014a52d1a266mr13446851plx.161.1643022478883; 
 Mon, 24 Jan 2022 03:07:58 -0800 (PST)
Received: from xz-m1.local ([94.177.118.73])
 by smtp.gmail.com with ESMTPSA id x25sm15388443pfu.91.2022.01.24.03.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 03:07:58 -0800 (PST)
Date: Mon, 24 Jan 2022 19:07:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH 21/31] util: Add iova_tree_alloc
Message-ID: <Ye6IhLCe6NDKO6+E@xz-m1.local>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-22-eperezma@redhat.com>
 <Ye4r7tKFhP9VaT5/@xz-m1.local>
 <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

T24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgMTA6MjA6NTVBTSArMDEwMCwgRXVnZW5pbyBQZXJleiBN
YXJ0aW4gd3JvdGU6Cj4gT24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgNTozMyBBTSBQZXRlciBYdSA8
cGV0ZXJ4QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIEZyaSwgSmFuIDIxLCAyMDIyIGF0
IDA5OjI3OjIzUE0gKzAxMDAsIEV1Z2VuaW8gUMOpcmV6IHdyb3RlOgo+ID4gPiAraW50IGlvdmFf
dHJlZV9hbGxvYyhJT1ZBVHJlZSAqdHJlZSwgRE1BTWFwICptYXAsIGh3YWRkciBpb3ZhX2JlZ2lu
LAo+IAo+IEkgZm9yZ290IHRvIHMvaW92YV90cmVlX2FsbG9jL2lvdmFfdHJlZV9hbGxvY19tYXAv
IGhlcmUuCj4gCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhX2xhc3QpCj4g
PiA+ICt7Cj4gPiA+ICsgICAgY29uc3QgRE1BTWFwSW50ZXJuYWwgKmxhc3QsICppOwo+ID4gPiAr
Cj4gPiA+ICsgICAgYXNzZXJ0KGlvdmFfYmVnaW4gPCBpb3ZhX2xhc3QpOwo+ID4gPiArCj4gPiA+
ICsgICAgLyoKPiA+ID4gKyAgICAgKiBGaW5kIGEgdmFsaWQgaG9sZSBmb3IgdGhlIG1hcHBpbmcK
PiA+ID4gKyAgICAgKgo+ID4gPiArICAgICAqIFRPRE86IFJlcGxhY2UgYWxsIHRoaXMgd2l0aCBn
X3RyZWVfbm9kZV9maXJzdC9uZXh0L2xhc3Qgd2hlbiBhdmFpbGFibGUKPiA+ID4gKyAgICAgKiAo
ZnJvbSBnbGliIHNpbmNlIDIuNjgpLiBVc2luZyBhIHNlcHBhcmF0ZWQgUVRBSUxRIGNvbXBsaWNh
dGVzIGNvZGUuCj4gPiA+ICsgICAgICoKPiA+ID4gKyAgICAgKiBUcnkgdG8gYWxsb2NhdGUgZmly
c3QgYXQgdGhlIGVuZCBvZiB0aGUgbGlzdC4KPiA+ID4gKyAgICAgKi8KPiA+ID4gKyAgICBsYXN0
ID0gUVRBSUxRX0xBU1QoJnRyZWUtPmxpc3QpOwo+ID4gPiArICAgIGlmIChpb3ZhX3RyZWVfYWxs
b2NfbWFwX2luX2hvbGUobGFzdCwgTlVMTCwgaW92YV9iZWdpbiwgaW92YV9sYXN0LAo+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFwLT5zaXplKSkgewo+ID4gPiAr
ICAgICAgICBnb3RvIGFsbG9jOwo+ID4gPiArICAgIH0KPiA+ID4gKwo+ID4gPiArICAgIC8qIExv
b2sgZm9yIGlubmVyIGhvbGUgKi8KPiA+ID4gKyAgICBsYXN0ID0gTlVMTDsKPiA+ID4gKyAgICBm
b3IgKGkgPSBRVEFJTFFfRklSU1QoJnRyZWUtPmxpc3QpOyBpOwo+ID4gPiArICAgICAgICAgbGFz
dCA9IGksIGkgPSBRVEFJTFFfTkVYVChpLCBlbnRyeSkpIHsKPiA+ID4gKyAgICAgICAgaWYgKGlv
dmFfdHJlZV9hbGxvY19tYXBfaW5faG9sZShsYXN0LCBpLCBpb3ZhX2JlZ2luLCBpb3ZhX2xhc3Qs
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFwLT5zaXpl
KSkgewo+ID4gPiArICAgICAgICAgICAgZ290byBhbGxvYzsKPiA+ID4gKyAgICAgICAgfQo+ID4g
PiArICAgIH0KPiA+ID4gKwo+ID4gPiArICAgIHJldHVybiBJT1ZBX0VSUl9OT01FTTsKPiA+ID4g
Kwo+ID4gPiArYWxsb2M6Cj4gPiA+ICsgICAgbWFwLT5pb3ZhID0gbGFzdCA/IGxhc3QtPm1hcC5p
b3ZhICsgbGFzdC0+bWFwLnNpemUgKyAxIDogaW92YV9iZWdpbjsKPiA+ID4gKyAgICByZXR1cm4g
aW92YV90cmVlX2luc2VydCh0cmVlLCBtYXApOwo+ID4gPiArfQo+ID4KPiA+IEhpLCBFdWdlbmlv
LAo+ID4KPiA+IEhhdmUgeW91IHRyaWVkIHdpdGggd2hhdCBKYXNvbiBzdWdnZXN0ZWQgcHJldmlv
dXNseT8KPiA+Cj4gPiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FDR2tN
RXRaQVBkOXhRVFBfUjR3Mjk2Tl9RejdWdVYxRkxuYjU0NGZFVm9ZTzBvZitnQG1haWwuZ21haWwu
Y29tLwo+ID4KPiA+IFRoYXQgc29sdXRpb24gc3RpbGwgc291bmRzIHZlcnkgc2Vuc2libGUgdG8g
bWUgZXZlbiB3aXRob3V0IHRoZSBuZXdseQo+ID4gaW50cm9kdWNlZCBsaXN0IGluIHByZXZpb3Vz
IHR3byBwYXRjaGVzLgo+ID4KPiA+IElNSE8gd2UgY291bGQgbW92ZSAiRE1BTWFwICpwcmV2aW91
cywgKnRoaXMiIGludG8gdGhlIElPVkFUcmVlQWxsb2NBcmdzKgo+ID4gc3R1Y3R1cmUgdGhhdCB3
YXMgcGFzc2VkIGludG8gdGhlIHRyYXZlcnNlIGZ1bmMgdGhvdWdoLCBzbyBpdCdsbCBuYXR1cmFs
bHkgd29yawo+ID4gd2l0aCB0aHJlYWRpbmcuCj4gPgo+ID4gT3IgaXMgdGhlcmUgYW55IGJsb2Nr
ZXIgZm9yIGl0Pwo+ID4KPiAKPiBIaSBQZXRlciwKPiAKPiBJIGNhbiB0cnkgdGhhdCBzb2x1dGlv
biBhZ2FpbiwgYnV0IHRoZSBtYWluIHByb2JsZW0gd2FzIHRoZSBzcGVjaWFsCj4gY2FzZXMgb2Yg
dGhlIGJlZ2lubmluZyBhbmQgZW5kaW5nLgo+IAo+IEZvciB0aGUgZnVuY3Rpb24gdG8gbG9jYXRl
IGEgaG9sZSwgRE1BTWFwIGZpcnN0ID0gey5pb3ZhID0gMCwgLnNpemUgPQo+IDB9IG1lYW5zIHRo
YXQgaXQgY2Fubm90IGFjY291bnQgMCBmb3IgdGhlIGhvbGUuCj4gCj4gSW4gb3RoZXIgd29yZHMs
IHdpdGggdGhhdCBhbGdvcml0aG0sIGlmIHRoZSBvbmx5IHZhbGlkIGhvbGUgaXMgWzAsIE4pCj4g
YW5kIHdlIHRyeSB0byBhbGxvY2F0ZSBhIGJsb2NrIG9mIHNpemUgTiwgaXQgd291bGQgZmFpbC4K
PiAKPiBTYW1lIGhhcHBlbnMgd2l0aCBpb3ZhX2VuZCwgYWx0aG91Z2ggaW4gcHJhY3RpY2UgaXQg
c2VlbXMgdGhhdCBJT01NVQo+IGhhcmR3YXJlIGlvdmEgdXBwZXIgbGltaXQgaXMgbmV2ZXIgVUlO
VDY0X01BWC4KPiAKPiBNYXliZSB3ZSBjb3VsZCB0cmVhdCAuc2l6ZSA9IDAgYXMgYSBzcGVjaWFs
IGNhc2U/IEkgc2VlIGNsZWFuZXIgZWl0aGVyCj4gdG8gYnVpbGQgdGhlIGxpc3QgKGJ1dCBpbnNl
cnQgbmVlZHMgdG8gdGFrZSB0aGUgbGlzdCBpbnRvIGFjY291bnQpIG9yCj4gdG8gZXhwbGljaXRs
eSB0ZWxsIHRoYXQgcHJldiA9PSBOVUxMIG1lYW5zIHRvIHVzZSBpb3ZhX2ZpcnN0LgoKU291bmRz
IGdvb2QgdG8gbWUuICBJIGRpZG4ndCBtZWFuIHRvIGNvcHktcGFzdGUgSmFzb24ncyBjb2RlLCBi
dXQgSU1ITyB3aGF0Ckphc29uIHdhbnRlZCB0byBzaG93IGlzIHRoZSBnZW5lcmFsIGNvbmNlcHQg
LSBJT1csIHRoZSBmdW5kYW1lbnRhbCBpZGVhICh0byBtZSkKaXMgdGhhdCB0aGUgdHJlZSB3aWxs
IGJlIHRyYXZlcnNlZCBpbiBvcmRlciwgaGVuY2UgbWFpbnRhaW5pbmcgYW5vdGhlciBsaXN0CnN0
cnVjdHVyZSBpcyByZWR1bmRhbnQuCgo+IAo+IEFub3RoZXIgc29sdXRpb24gdGhhdCBjb21lcyB0
byBteSBtaW5kOiB0byBhZGQgYm90aCBleGNlcHRpb25zIG91dHNpZGUKPiBvZiB0cmFuc3ZlcnNl
IGZ1bmN0aW9uLCBhbmQgc2tpcCB0aGUgZmlyc3QgaXRlcmF0aW9uIHdpdGggc29tZXRoaW5nCj4g
bGlrZToKPiAKPiBpZiAocHJldiA9PSBOVUxMKSB7Cj4gICBwcmV2ID0gdGhpczsKPiAgIHJldHVy
biBmYWxzZSAvKiBjb250aW51ZSAqLwo+IH0KPiAKPiBTbyB0aGUgdHJhbnN2ZXJzZSBjYWxsYmFj
ayBoYXMgd2F5IGxlc3MgY29kZSBwYXRocy4gV291bGQgaXQgd29yayBmb3IKPiB5b3UgaWYgSSBz
ZW5kIGEgc2VwYXJhdGUgUkZDIGZyb20gU1ZRIG9ubHkgdG8gdmFsaWRhdGUgdGhpcz8KClN1cmUu
IDotKQoKSWYgeW91IHdhbnQsIGltaG8geW91IGNhbiBhbHNvIGF0dGFjaCB0aGUgcGF0Y2ggd2hl
biByZXBseSwgdGhlbiB0aGUgZGlzY3Vzc2lvbgpjb250ZXh0IHdvbid0IGJlIGxvc3QgdG9vLgoK
LS0gClBldGVyIFh1CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

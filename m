Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D91CC433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 11:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCC6660E95;
	Thu, 28 Apr 2022 11:53:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubfnnxuxa_ri; Thu, 28 Apr 2022 11:53:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC7C560E87;
	Thu, 28 Apr 2022 11:53:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA5ADC0039;
	Thu, 28 Apr 2022 11:53:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22D2EC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A91F60E93
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:53:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ucVwT5sDLmTu
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:53:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEB1F60A6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651146782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRRcxcFojNMX3WKw/sfDV3iW9J8bW/U3L9VGVbzYvI0=;
 b=GsEwO3I5p1WE4wlm60a0lD95kYmGP0lo3R61oOb1Gi7tK/I/WAdssJqPbP+K9NemP/9g6m
 GOEoHLNkMx/blJEIDNwS/R9oFBKGs2JtvwJ61Vd5+rnvJCOrSWtHdEzENhMYPtwybIb1xU
 005wFhM5lxrnRQCQGJ0/hHNnz2iRiSA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-ZhAS8Hl8M2SqznjSFp6nKw-1; Thu, 28 Apr 2022 07:52:59 -0400
X-MC-Unique: ZhAS8Hl8M2SqznjSFp6nKw-1
Received: by mail-wm1-f70.google.com with SMTP id
 h65-20020a1c2144000000b0038e9ce3b29cso4284244wmh.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 04:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=m4wuSSXz7Bc2R5yzgoXp3lpJ6Gq5vjadLf49SvnLISA=;
 b=LJuE7p5vpuc2OTtVhc47FUJy+GjsQUgGrFoEQlDZ0qOsC1Eme/8TnKRN28N84e8eOy
 8KDYDCdEvLtsPrKn7Q0Yp0k5LMcQCf+QqHnvR/T7rF2OrWKQAtwBPkWGXdOANfN2nN6D
 iVdxHFwDXb31CGsVOPkNYnW/dmSqGdUDwkjUMD75xAVE3hQ97ZA1F6rdOHuajccAVm9D
 ohEaATrT+BMeFaAL8U5mQmqSxFUdXMrgLt1FmyqSGznRyPHGuxxyGnj7xHtgopKx9wFx
 5ZUWIAv9TyC9Rr6P5SVCa9umG989704taQbYDljh2cLbi8EOCqUSsVEKdq4Gfeu8wVXK
 ucVg==
X-Gm-Message-State: AOAM533/U/lddywXJd1GfpyKO+JqtygseUTTQy5fEVuk560XijFDZF/v
 sKNb7Hcsl8NUhx8gMhoGYhgbByMj916JikQ5HSgTBooSl5pTHBWJdp8Yscq0NQTxHw5UvU1Z/Q+
 SvtXYZgj0tRXqBr0ySsreL+O6Py8tmqLv1f4Ecp7PhQ==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id
 v189-20020a1cacc6000000b0038eb1847721mr30429298wme.94.1651146778350; 
 Thu, 28 Apr 2022 04:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdXJHhuyonjHZZ5DuMT8VJ7tfpq1xfdkYBSxE+jsnntHiHGLuJGR6oIIiNOw4qdCLHwrqj1Q==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id
 v189-20020a1cacc6000000b0038eb1847721mr30429276wme.94.1651146778091; 
 Thu, 28 Apr 2022 04:52:58 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:5160:7495:6b8e:3f15])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a05600c4ecd00b00393ec8be5cfsm4113111wmq.24.2022.04.28.04.52.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Apr 2022 04:52:57 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20220428070345-mutt-send-email-mst@kernel.org>
Date: Thu, 28 Apr 2022 13:52:56 +0200
Message-Id: <0ADDC136-7BAA-4D66-97A7-31747284BE2B@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
 <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
 <2F2EFFE9-5174-49A8-A71F-EE134D387E07@redhat.com>
 <20220428070345-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Christophe de Dinechin <dinechin@redhat.com>
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

W1Jlc2VuZCwgc3RpbGwgc3RydWdnbGluZyB3aXRoIG5ldyBsYXB0b3AgZW1haWwgc2V0dGluZ3Nd
Cgo+IE9uIDI4IEFwciAyMDIyLCBhdCAxMzowMywgTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gCj4gT24gVGh1LCBBcHIgMjgsIDIwMjIgYXQgMTE6NTU6MzFBTSAr
MDIwMCwgQ2hyaXN0b3BoZSBNYXJpZSBGcmFuY29pcyBEdXBvbnQgZGUgRGluZWNoaW4gd3JvdGU6
Cj4+IAo+PiAKPj4+IE9uIDI4IEFwciAyMDIyLCBhdCAxMTo1MSwgQ2hyaXN0b3BoZSBNYXJpZSBG
cmFuY29pcyBEdXBvbnQgZGUgRGluZWNoaW4gPGNkdXBvbnRkQHJlZGhhdC5jb20+IHdyb3RlOgo+
Pj4gCj4+PiAKPj4+IAo+Pj4+IE9uIDI4IEFwciAyMDIyLCBhdCAxMTo0NiwgQ2hyaXN0b3BoZSBN
YXJpZSBGcmFuY29pcyBEdXBvbnQgZGUgRGluZWNoaW4gPGNkdXBvbnRkQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pj4+IAo+Pj4+IAo+Pj4+IAo+Pj4+PiBPbiAxNSBBcHIgMjAyMiwgYXQgMDU6NTEsIE11
cmlsbyBPcHNmZWxkZXIgQXJhw7pqbyA8bXVyaWxvb0BsaW51eC5pYm0uY29tPiB3cm90ZToKPj4+
Pj4gCj4+Pj4+IE9uIDQvMTQvMjIgMjM6MzAsIE11cmlsbyBPcHNmZWxkZXIgQXJhdWpvIHdyb3Rl
Ogo+Pj4+Pj4gR0NDIDEyIGVuaGFuY2VkIC1XYWRkcmVzcyB3aGVuIGNvbXBhcmluZyBhcnJheSBh
ZGRyZXNzIHRvIG51bGwgWzBdLAo+Pj4+Pj4gd2hpY2ggd2FybnM6Cj4+Pj4+PiBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jOiBJbiBmdW5jdGlvbiDigJh2cF9kZWxfdnFz4oCZOgo+
Pj4+Pj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYzoyNTc6Mjk6IHdhcm5pbmc6
IHRoZSBjb21wYXJpc29uIHdpbGwgYWx3YXlzIGV2YWx1YXRlIGFzIOKAmHRydWXigJkgZm9yIHRo
ZSBwb2ludGVyIG9wZXJhbmQgaW4g4oCYdnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzICsgKHNp
emV0eXBlKSgobG9uZyB1bnNpZ25lZCBpbnQpaSAqIDI1NinigJkgbXVzdCBub3QgYmUgTlVMTCBb
LVdhZGRyZXNzXQo+Pj4+Pj4gMjU3IHwgaWYgKHZwX2Rldi0+bXNpeF9hZmZpbml0eV9tYXNrc1tp
XSkKPj4+Pj4+IHwgXn5+fn5+Cj4+Pj4+PiBJbiBmYWN0LCB0aGUgdmVyaWZpY2F0aW9uIGlzIGNv
bXBhcmluZyB0aGUgcmVzdWx0IG9mIGEgcG9pbnRlcgo+Pj4+Pj4gYXJpdGhtZXRpYywgdGhlIGFk
ZHJlc3MgIm1zaXhfYWZmaW5pdHlfbWFza3MgKyBpIiwgd2hpY2ggd2lsbCBhbHdheXMKPj4+Pj4+
IGV2YWx1YXRlIHRvIHRydWUuCj4+Pj4+PiBVbmRlciB0aGUgaG9vZCwgZnJlZV9jcHVtYXNrX3Zh
cigpIGNhbGxzIGtmcmVlKCksIHdoaWNoIGlzIHNhZmUgdG8gcGFzcwo+Pj4+Pj4gTlVMTCwgbm90
IHJlcXVpcmluZyBub24tbnVsbCB2ZXJpZmljYXRpb24uIFNvIHJlbW92ZSB0aGUgdmVyaWZpY2F0
aW9uCj4+Pj4+PiB0byBtYWtlIGNvbXBpbGVyIGhhcHB5IChoYXBweSBjb21waWxlciwgaGFwcHkg
bGlmZSkuCj4+Pj4+PiBbMF0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5j
Z2k/aWQ9MTAyMTAzCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNdXJpbG8gT3BzZmVsZGVyIEFyYXVq
byA8bXVyaWxvb0BsaW51eC5pYm0uY29tPgo+Pj4+Pj4gLS0tCj4+Pj4+PiBkcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgMyArLS0KPj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uYwo+Pj4+Pj4gaW5kZXggZDcyNGY2NzY2MDhiLi41MDQ2ZWZjZmZiNGMgMTAwNjQ0Cj4+Pj4+
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+Pj4+PiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+Pj4+PiBAQCAtMjU0LDggKzI1NCw3
IEBAIHZvaWQgdnBfZGVsX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+Pj4+IAlp
ZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzKSB7Cj4+Pj4+PiAJCWZvciAoaSA9IDA7IGkg
PCB2cF9kZXYtPm1zaXhfdmVjdG9yczsgaSsrKQo+Pj4+Pj4gLQkJCWlmICh2cF9kZXYtPm1zaXhf
YWZmaW5pdHlfbWFza3NbaV0pCj4+Pj4+PiAtCQkJCWZyZWVfY3B1bWFza192YXIodnBfZGV2LT5t
c2l4X2FmZmluaXR5X21hc2tzW2ldKTsKPj4+Pj4+ICsJCQlmcmVlX2NwdW1hc2tfdmFyKHZwX2Rl
di0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSk7Cj4+Pj4+PiAJfQo+Pj4+Pj4gCWlmICh2cF9kZXYt
Pm1zaXhfZW5hYmxlZCkgewo+Pj4+PiAKPj4+Pj4gQWZ0ZXIgSSBzZW50IHRoaXMgbWVzc2FnZSwg
SSByZWFsaXplZCB0aGF0IENocmlzdG9waGUgKGNvcGllZCBoZXJlKQo+Pj4+PiBoYWQgYWxyZWFk
eSBwcm9wb3NlZCBhIGZpeDoKPj4+Pj4gCj4+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xr
bWwvMjAyMjA0MTQxNTA4NTUuMjQwNzEzNy00LWRpbmVjaGluQHJlZGhhdC5jb20vCj4+Pj4+IAo+
Pj4+PiBDaHJpc3RvcGhlLAo+Pj4+PiAKPj4+Pj4gU2luY2UgZnJlZV9jcHVtYXNrX3ZhcigpIGNh
bGxzIGtmcmVlKCkgYW5kIGtmcmVlKCkgaXMgbnVsbC1zYWZlLAo+Pj4+PiBjYW4gd2UganVzdCBk
cm9wIHRoaXMgbnVsbCB2ZXJpZmljYXRpb24gYW5kIGNhbGwgZnJlZV9jcHVtYXNrX3ZhcigpIHJp
Z2h0IGF3YXk/Cj4+Pj4gCj4+Pj4gQXBvbG9naWVzIGZvciB0aGUgZGVsYXkgaW4gcmVzcG9uZGlu
ZywgYnJva2VuIGxhcHRvcOKApgo+Pj4+IAo+Pj4+IEluIHRoZSBjYXNlIHdoZXJlIENPTkZJR19D
UFVNQVNLX09GRlNUQUNLIGlzIG5vdCBkZWZpbmVkLCB3ZSBoYXZlOgo+Pj4+IAo+Pj4+IAl0eXBl
ZGVmIHN0cnVjdCBjcHVtYXNrIGNwdW1hc2tfdmFyX3RbMV07Cj4+Pj4gCj4+Pj4gU28gdGhhdCB2
cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0gaXMgc3RhdGljYWxseSBub3QgbnVsbCAodGhh
dOKAmXMgdGhlIHdhcm5pbmcpCj4+Pj4gYnV0IGFsc28gYSBzdGF0aWMgcG9pbnRlciwgc28gbm90
IGtmcmVlLXNhZmUgSU1PLgo+Pj4gCj4+PiDigKYgd2hpY2ggYWxzbyByZW5kZXJzIG15IG93biBw
YXRjaCBpbnZhbGlkIDotLwo+Pj4gCj4+PiBDb21waWxlciB3YXJuaW5ncyBhcmUgZ29vZC4gQ2xl
YXJseSBub3Qgc3VmZmljaWVudC4KPj4gCj4+IEFoLCBJIGp1c3Qgbm90aWNlZCB0aGF0IGZyZWVf
Y3B1bWFza192YXIgaXMgYSBub29wIGluIHRoYXQgY2FzZS4KPj4gCj4+IFNvIHllcywgeW91ciBm
aXggaXMgYmV0dGVyIDotKQo+IAo+IEFDSyB0aGVuPwoKWWVzLgoKQWNrZWQtYnk6IENocmlzdG9w
aGUgZGUgRGluZWNoaW4gPGRpbmVjaGluQHJlZGhhdC5jb20+Cgo+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

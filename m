Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120B5C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Apr 2022 09:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A09640B53;
	Thu, 28 Apr 2022 09:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gj7EUFzE5yA3; Thu, 28 Apr 2022 09:51:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2AEE3400C1;
	Thu, 28 Apr 2022 09:51:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEFF0C0039;
	Thu, 28 Apr 2022 09:51:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F4BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63A2841714
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T4OLEvR4dkwJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:51:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 219FF4088D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651139504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GW+KseKkRXSohY0ecTkNhGe6ZdfCwHiB1iMs9e18pvM=;
 b=L4rBvnPe7egJOcxQR83PUPFdNxp292wF7mKtm9ZUHHQr6xCUKgXurZTin4ykmOsXSBSoDq
 B4NVOnVl03pa10R5eCN8c/8R9YzferZTQYLjwZUAMZvqJ8ulrQfxdzVi6HqJ6PHK9TL93H
 +54acgqtfZZPKZxiOOqCtfMSUpwOuuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-UixQUGWSMEW8zO9WjCuHMQ-1; Thu, 28 Apr 2022 05:51:43 -0400
X-MC-Unique: UixQUGWSMEW8zO9WjCuHMQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 g3-20020a7bc4c3000000b0039409519611so1174772wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 02:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=HE3ta4HpBI6INhoQobpRyVvmn/Cv0Jx2r+Mpva9zKrg=;
 b=XsYqK0Dx/YgX1p0w7XHMz/Vhqi57cFrQGRXme9IbUZHckoVgRu8chC69UrAZyaomTt
 S9ZmW2XUBZTIGU3TnZdPj1iSy2uV3lUsX109HtebxtgwJ9ut/Km/h2IiFjHJPEB0+h6j
 fLgQUW+tO8UkRNHfUzbaSaWTaY4BFBUZzDEduXHOO8DInIDfsT9fLIifx61XCJtNVdV6
 +Ygir0cYSVHVLGM5HeiUAsVtCZBgFqwzygRQXc0kxES/7S4FQG/gQEvmgbk9PI9ORyWi
 Xz08KJQCwjkkmNdLuXGQc08CateN+EP+Zr832Jdj2NVB1ZLm4MVHoAlr9R0ZM70b0Jzf
 Izkw==
X-Gm-Message-State: AOAM531P7EEOwAzQZBQ+yF1NLDXc2cf7oDHP1mIEnbMRfxB7Wp+xmXco
 tYIMIyjUpFBubfpro86N+ZUKBN1T/gua1ZS3O3ZveFlXmKrlDn+le/IHRh/JwtmGugb+xvJym7W
 sSSX+/I1g34MRs/KrF76JKZTIrOhjRwg7r8pUTRWe+Q==
X-Received: by 2002:a5d:4744:0:b0:20a:ea5a:dc39 with SMTP id
 o4-20020a5d4744000000b0020aea5adc39mr8250813wrs.236.1651139502543; 
 Thu, 28 Apr 2022 02:51:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlt0WIxWYGUM3TXXA+zF5EJSKUPgDy28wndaEJHSCE7Dd7DqM6ReTuGFqvoCetntmepG+mHQ==
X-Received: by 2002:a5d:4744:0:b0:20a:ea5a:dc39 with SMTP id
 o4-20020a5d4744000000b0020aea5adc39mr8250795wrs.236.1651139502237; 
 Thu, 28 Apr 2022 02:51:42 -0700 (PDT)
Received: from smtpclient.apple ([2a01:e0a:834:5aa0:80d7:8022:3692:b311])
 by smtp.gmail.com with ESMTPSA id
 n5-20020adf8b05000000b00207a4fd0185sm15653955wra.7.2022.04.28.02.51.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Apr 2022 02:51:41 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] virtio-pci: Remove wrong address verification in
 vp_del_vqs()
From: Christophe Marie Francois Dupont de Dinechin <cdupontd@redhat.com>
In-Reply-To: <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
Date: Thu, 28 Apr 2022 11:51:40 +0200
Message-Id: <B954A683-EE43-4469-B57A-EB8C6B671BEC@redhat.com>
References: <20220415023002.49805-1-muriloo@linux.ibm.com>
 <e8620e70-16bb-639c-9446-68dcd199253f@linux.ibm.com>
 <A5CD1C91-F5D0-4109-9894-824184362B5C@redhat.com>
To: muriloo@linux.ibm.com
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cdupontd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mopsfelder@gmail.com,
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

Cgo+IE9uIDI4IEFwciAyMDIyLCBhdCAxMTo0NiwgQ2hyaXN0b3BoZSBNYXJpZSBGcmFuY29pcyBE
dXBvbnQgZGUgRGluZWNoaW4gPGNkdXBvbnRkQHJlZGhhdC5jb20+IHdyb3RlOgo+IAo+IAo+IAo+
PiBPbiAxNSBBcHIgMjAyMiwgYXQgMDU6NTEsIE11cmlsbyBPcHNmZWxkZXIgQXJhw7pqbyA8bXVy
aWxvb0BsaW51eC5pYm0uY29tPiB3cm90ZToKPj4gCj4+IE9uIDQvMTQvMjIgMjM6MzAsIE11cmls
byBPcHNmZWxkZXIgQXJhdWpvIHdyb3RlOgo+Pj4gR0NDIDEyIGVuaGFuY2VkIC1XYWRkcmVzcyB3
aGVuIGNvbXBhcmluZyBhcnJheSBhZGRyZXNzIHRvIG51bGwgWzBdLAo+Pj4gd2hpY2ggd2FybnM6
Cj4+PiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jOiBJbiBmdW5jdGlvbiDigJh2
cF9kZWxfdnFz4oCZOgo+Pj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYzoyNTc6
Mjk6IHdhcm5pbmc6IHRoZSBjb21wYXJpc29uIHdpbGwgYWx3YXlzIGV2YWx1YXRlIGFzIOKAmHRy
dWXigJkgZm9yIHRoZSBwb2ludGVyIG9wZXJhbmQgaW4g4oCYdnBfZGV2LT5tc2l4X2FmZmluaXR5
X21hc2tzICsgKHNpemV0eXBlKSgobG9uZyB1bnNpZ25lZCBpbnQpaSAqIDI1NinigJkgbXVzdCBu
b3QgYmUgTlVMTCBbLVdhZGRyZXNzXQo+Pj4gMjU3IHwgaWYgKHZwX2Rldi0+bXNpeF9hZmZpbml0
eV9tYXNrc1tpXSkKPj4+IHwgXn5+fn5+Cj4+PiBJbiBmYWN0LCB0aGUgdmVyaWZpY2F0aW9uIGlz
IGNvbXBhcmluZyB0aGUgcmVzdWx0IG9mIGEgcG9pbnRlcgo+Pj4gYXJpdGhtZXRpYywgdGhlIGFk
ZHJlc3MgIm1zaXhfYWZmaW5pdHlfbWFza3MgKyBpIiwgd2hpY2ggd2lsbCBhbHdheXMKPj4+IGV2
YWx1YXRlIHRvIHRydWUuCj4+PiBVbmRlciB0aGUgaG9vZCwgZnJlZV9jcHVtYXNrX3ZhcigpIGNh
bGxzIGtmcmVlKCksIHdoaWNoIGlzIHNhZmUgdG8gcGFzcwo+Pj4gTlVMTCwgbm90IHJlcXVpcmlu
ZyBub24tbnVsbCB2ZXJpZmljYXRpb24uIFNvIHJlbW92ZSB0aGUgdmVyaWZpY2F0aW9uCj4+PiB0
byBtYWtlIGNvbXBpbGVyIGhhcHB5IChoYXBweSBjb21waWxlciwgaGFwcHkgbGlmZSkuCj4+PiBb
MF0gaHR0cHM6Ly9nY2MuZ251Lm9yZy9idWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9MTAyMTAzCj4+
PiBTaWduZWQtb2ZmLWJ5OiBNdXJpbG8gT3BzZmVsZGVyIEFyYXVqbyA8bXVyaWxvb0BsaW51eC5p
Ym0uY29tPgo+Pj4gLS0tCj4+PiBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwg
MyArLS0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkK
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24uYwo+Pj4gaW5kZXggZDcyNGY2NzY2MDhiLi41
MDQ2ZWZjZmZiNGMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2Nv
bW1vbi5jCj4+PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4+PiBA
QCAtMjU0LDggKzI1NCw3IEBAIHZvaWQgdnBfZGVsX3ZxcyhzdHJ1Y3QgdmlydGlvX2RldmljZSAq
dmRldikKPj4+IAlpZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tzKSB7Cj4+PiAJCWZvciAo
aSA9IDA7IGkgPCB2cF9kZXYtPm1zaXhfdmVjdG9yczsgaSsrKQo+Pj4gLQkJCWlmICh2cF9kZXYt
Pm1zaXhfYWZmaW5pdHlfbWFza3NbaV0pCj4+PiAtCQkJCWZyZWVfY3B1bWFza192YXIodnBfZGV2
LT5tc2l4X2FmZmluaXR5X21hc2tzW2ldKTsKPj4+ICsJCQlmcmVlX2NwdW1hc2tfdmFyKHZwX2Rl
di0+bXNpeF9hZmZpbml0eV9tYXNrc1tpXSk7Cj4+PiAJfQo+Pj4gCWlmICh2cF9kZXYtPm1zaXhf
ZW5hYmxlZCkgewo+PiAKPj4gQWZ0ZXIgSSBzZW50IHRoaXMgbWVzc2FnZSwgSSByZWFsaXplZCB0
aGF0IENocmlzdG9waGUgKGNvcGllZCBoZXJlKQo+PiBoYWQgYWxyZWFkeSBwcm9wb3NlZCBhIGZp
eDoKPj4gCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjA0MTQxNTA4NTUuMjQw
NzEzNy00LWRpbmVjaGluQHJlZGhhdC5jb20vCj4+IAo+PiBDaHJpc3RvcGhlLAo+PiAKPj4gU2lu
Y2UgZnJlZV9jcHVtYXNrX3ZhcigpIGNhbGxzIGtmcmVlKCkgYW5kIGtmcmVlKCkgaXMgbnVsbC1z
YWZlLAo+PiBjYW4gd2UganVzdCBkcm9wIHRoaXMgbnVsbCB2ZXJpZmljYXRpb24gYW5kIGNhbGwg
ZnJlZV9jcHVtYXNrX3ZhcigpIHJpZ2h0IGF3YXk/Cj4gCj4gQXBvbG9naWVzIGZvciB0aGUgZGVs
YXkgaW4gcmVzcG9uZGluZywgYnJva2VuIGxhcHRvcOKApgo+IAo+IEluIHRoZSBjYXNlIHdoZXJl
IENPTkZJR19DUFVNQVNLX09GRlNUQUNLIGlzIG5vdCBkZWZpbmVkLCB3ZSBoYXZlOgo+IAo+IAl0
eXBlZGVmIHN0cnVjdCBjcHVtYXNrIGNwdW1hc2tfdmFyX3RbMV07Cj4gCj4gU28gdGhhdCB2cF9k
ZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0gaXMgc3RhdGljYWxseSBub3QgbnVsbCAodGhhdOKA
mXMgdGhlIHdhcm5pbmcpCj4gYnV0IGFsc28gYSBzdGF0aWMgcG9pbnRlciwgc28gbm90IGtmcmVl
LXNhZmUgSU1PLgoK4oCmIHdoaWNoIGFsc28gcmVuZGVycyBteSBvd24gcGF0Y2ggaW52YWxpZCA6
LS8KCkNvbXBpbGVyIHdhcm5pbmdzIGFyZSBnb29kLiBDbGVhcmx5IG5vdCBzdWZmaWNpZW50LgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

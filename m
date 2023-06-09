Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1856FC7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 16:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8BA5C419EF;
	Fri,  9 Jun 2023 16:02:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BA5C419EF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LNz60wmH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iDmVaxLQyHWq; Fri,  9 Jun 2023 16:02:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 03A7540292;
	Fri,  9 Jun 2023 16:02:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03A7540292
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF057C0037;
	Fri,  9 Jun 2023 16:02:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB5CC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 947748423D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:02:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 947748423D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LNz60wmH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58BuxMnb9GzS
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:02:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A0C384238
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A0C384238
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686326570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDPqvNvCKDaRoxVabZXpCEaO3eFktyKlsug6+VBWhkY=;
 b=LNz60wmHEHP3XVs46mBWVyTrn6mmNXMPQfStHszHsqDzjCwDoZ7dg6j9oWT9BIdbaw8+xo
 0E/h1izYqkrfF9Wjb7deE4gdGfH6yUagNhIkdRYAVbCfg3uo9hpygdav7TOe6i/4z40Rsz
 pf4FjyNfh1A4S/Hl0jVK/mzFKvMMxxE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-7HUE9k7ZMc-ZFBn7M3RQzg-1; Fri, 09 Jun 2023 12:02:43 -0400
X-MC-Unique: 7HUE9k7ZMc-ZFBn7M3RQzg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f73283f6c7so13420245e9.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 09:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686326560; x=1688918560;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDPqvNvCKDaRoxVabZXpCEaO3eFktyKlsug6+VBWhkY=;
 b=O5PJ+iAl2FSSLb+kUo8OZus5EcIZXXAPrlX/TkldnCME0A7vNlXyGOl7awPJ5FLFw+
 OxX5/dPJOwQVN5R6uPBIzvqfeyPwvpiIUOvrdMCPYtJlFO3lKS+3UhHxoy9uZUEfdc5l
 r6fBbfli16c7j4kgldGbOHcP+nHqPm7Nr3OTa+q1rr3RQtTksu3YsOQuYsV512HRlxBS
 PWT9PVe63y899S/1IdeGI6ASkI13USPNarK9yr5DLHhSp+zJSXHO0OIeIcLsrW6zit0x
 dJRijo7d0oMsTCAzaLMoqPv5NTlAJqAKg+KBx0IJI0IM0dc/BGpC0+D918lb/rL/W/CQ
 Srjg==
X-Gm-Message-State: AC+VfDxfDw1ritOzzuAgRYnJx3tnm4Pz0Kc8TnnUC6JLt4ckEB+n2HHE
 lBY4lsQfsh/ie6bAI7cYvAekpL3tcaohCx2Um3A+lJO9aJgHGCyNl23coEvj5twD+N6jdBUhkuO
 vC2oMB6uUWvPaxZjk3toMkWpmB4R0j9U1YHNHc1jnpA==
X-Received: by 2002:a05:600c:2041:b0:3f6:1b7:11f0 with SMTP id
 p1-20020a05600c204100b003f601b711f0mr1872762wmg.7.1686326560746; 
 Fri, 09 Jun 2023 09:02:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+cTGEsumPbrhQKIm8DZ1NuiAlUbhAlNIbDxc4Q5231NUq4aWWlHrRMiiaodCaJ/J+lriS5Q==
X-Received: by 2002:a05:600c:2041:b0:3f6:1b7:11f0 with SMTP id
 p1-20020a05600c204100b003f601b711f0mr1872735wmg.7.1686326560330; 
 Fri, 09 Jun 2023 09:02:40 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7403:2800:22a6:7656:500:4dab])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a1c6a10000000b003f60fb2addbsm3062327wmc.44.2023.06.09.09.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 09:02:39 -0700 (PDT)
Date: Fri, 9 Jun 2023 12:02:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <20230609115840-mutt-send-email-mst@kernel.org>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <2023060924-skinning-reset-e256@gregkh>
 <2023060940-wrongdoer-wince-5701@gregkh>
 <91aa6ce0-e8a3-21ac-d29e-b2a47f6386d1@linux.alibaba.com>
 <2023060924-onion-armhole-803e@gregkh>
MIME-Version: 1.0
In-Reply-To: <2023060924-onion-armhole-803e@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 amit@kernel.org, Xianting Tian <xianting.tian@linux.alibaba.com>,
 marcel@holtmann.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 Xianting Tian <tianxianting.txt@alibaba-inc.com>, linux-crypto@vger.kernel.org,
 luiz.dentz@gmail.com, davem@davemloft.net, johan.hedberg@gmail.com
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

T24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMDQ6MDU6NTdQTSArMDIwMCwgR3JlZyBLSCB3cm90ZToK
PiBPbiBGcmksIEp1biAwOSwgMjAyMyBhdCAwOTo0OTozOVBNICswODAwLCBYaWFudGluZyBUaWFu
IHdyb3RlOgo+ID4gCj4gPiDlnKggMjAyMy82Lzkg5LiL5Y2IOTo0MSwgR3JlZyBLSCDlhpnpgZM6
Cj4gPiA+IE9uIEZyaSwgSnVuIDA5LCAyMDIzIGF0IDAzOjM5OjI0UE0gKzAyMDAsIEdyZWcgS0gg
d3JvdGU6Cj4gPiA+ID4gT24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMDk6MTg6MTVQTSArMDgwMCwg
WGlhbnRpbmcgVGlhbiB3cm90ZToKPiA+ID4gPiA+IEZyb206IFhpYW50aW5nIFRpYW4gPHRpYW54
aWFudGluZy50eHRAYWxpYmFiYS1pbmMuY29tPgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBDcHUgc3Rh
bGwgaXNzdWUgbWF5IGhhcHBlbiBpZiBkZXZpY2UgaXMgY29uZmlndXJlZCB3aXRoIG11bHRpIHF1
ZXVlcwo+ID4gPiA+ID4gYW5kIGxhcmdlIHF1ZXVlIGRlcHRoLCBzbyBmaXggaXQuCj4gPiA+ID4g
PiAKPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5nIFRpYW4gPHhpYW50aW5nLnRpYW5A
bGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ICAgZHJpdmVycy9jcnlw
dG8vdmlydGlvL3ZpcnRpb19jcnlwdG9fY29yZS5jIHwgMSArCj4gPiA+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9jcnlwdG8vdmlydGlvL3ZpcnRpb19jcnlwdG9fY29yZS5jIGIvZHJpdmVycy9jcnlw
dG8vdmlydGlvL3ZpcnRpb19jcnlwdG9fY29yZS5jCj4gPiA+ID4gPiBpbmRleCAxMTk4YmQzMDYz
NjUuLjk0ODQ5ZmEzYmQ3NCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY3J5cHRvL3Zp
cnRpby92aXJ0aW9fY3J5cHRvX2NvcmUuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9jcnlwdG8v
dmlydGlvL3ZpcnRpb19jcnlwdG9fY29yZS5jCj4gPiA+ID4gPiBAQCAtNDgwLDYgKzQ4MCw3IEBA
IHN0YXRpYyB2b2lkIHZpcnRjcnlwdG9fZnJlZV91bnVzZWRfcmVxcyhzdHJ1Y3QgdmlydGlvX2Ny
eXB0byAqdmNyeXB0bykKPiA+ID4gPiA+ICAgCQkJa2ZyZWUodmNfcmVxLT5yZXFfZGF0YSk7Cj4g
PiA+ID4gPiAgIAkJCWtmcmVlKHZjX3JlcS0+c2dzKTsKPiA+ID4gPiA+ICAgCQl9Cj4gPiA+ID4g
PiArCQljb25kX3Jlc2NoZWQoKTsKPiA+ID4gPiB0aGF0J3Mgbm90ICJmaXhpbmcgYSBzdGFsbCIs
IGl0IGlzICJjYWxsIHRoZSBzY2hlZHVsZXIgYmVjYXVzZSB3ZSBhcmUKPiA+ID4gPiB0YWtpbmcg
dG9vIGxvbmciLiAgVGhlIENQVSBpc24ndCBzdGFsbGVkIGF0IGFsbCwganVzdCBidXN5Lgo+ID4g
PiA+IAo+ID4gPiA+IEFyZSB5b3Ugc3VyZSB0aGlzIGlzbid0IGp1c3QgYSBidWcgaW4gdGhlIGNv
ZGU/ICBXaHkgaXMgdGhpcyBjb2RlIHRha2luZwo+ID4gPiA+IHNvIGxvbmcgdGhhdCB5b3UgaGF2
ZSB0byBmb3JjZSB0aGUgc2NoZWR1bGVyIHRvIHJ1bj8gIFRoaXMgaXMgYWxtb3N0Cj4gPiA+ID4g
YWx3YXlzIGEgc2lnbiB0aGF0IHNvbWV0aGluZyBlbHNlIG5lZWRzIHRvIGJlIGZpeGVkIGluc3Rl
YWQuCj4gPiA+IEFuZCBzYW1lIGNvbW1lbnQgb24gdGhlIG90aGVyIDIgcGF0Y2hlcywgcGxlYXNl
IGZpeCB0aGlzIHByb3Blcmx5Lgo+ID4gPiAKPiA+ID4gQWxzbywgdGhpcyBpcyBhIHRpZ2h0IGxv
b3AgdGhhdCBpcyBqdXN0IGZyZWVpbmcgbWVtb3J5LCB3aHkgaXMgaXQgdGFraW5nCj4gPiA+IHNv
IGxvbmc/ICBXaHkgZG8geW91IHdhbnQgaXQgdG8gdGFrZSBsb25nZXIgKHdoaWNoIGlzIHdoYXQg
eW91IGFyZSBkb2luZwo+ID4gPiBoZXJlKSwgaWRlYWxseSBpdCB3b3VsZCBiZSBmYXN0ZXIsIG5v
dCBzbG93ZXIsIHNvIHlvdSBhcmUgbm93IHNsb3dpbmcKPiA+ID4gZG93biB0aGUgc3lzdGVtIG92
ZXJhbGwgd2l0aCB0aGlzIHBhdGNoc2V0LCByaWdodD8KPiA+IAo+ID4geWVzLCBpdCBpcyB0aGUg
c2ltaWxhciBmaXggd2l0aCBvbmUgZm9yIHZpcnRpby1uZXQKPiA+IAo+ID4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2Nv
bW1pdC9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM/aD12Ni40LXJjNSZpZD1mOGJiNTEwNDM5NDU2
MGUyOTAxN2MyNWJjYWRlNGM2YjdhYWJkMTA4IDxodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2RyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYz9oPXY2LjQtcmM1JmlkPWY4YmI1MTA0Mzk0NTYwZTI5MDE3YzI1YmNhZGU0
YzZiN2FhYmQxMDg+CgpXZWxsIHRoYXQgb25lIGFjdHVhbGx5IGF0IGxlYXN0IGRlc2NyaWJlcyB0
aGUgY29uZmlndXJhdGlvbjoKCgoJRm9yIG11bHRpLXF1ZXVlIGFuZCBsYXJnZSByaW5nLXNpemUg
dXNlIGNhc2UsIHRoZSBmb2xsb3dpbmcgZXJyb3IKCW9jY3VycmVkIHdoZW4gZnJlZV91bnVzZWRf
YnVmczoKCXJjdTogSU5GTzogcmN1X3NjaGVkIHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gQ1BVLgoK
U28gYSBzaW1pbGFyIGZpeCBidXQgbm90IGEgc2ltaWxhciBjb21taXQgbG9nLCB0aGlzIG9uZSBs
YWNrcyBGaXhlcyB0YWcgYW5kCmRlc2NyaXB0aW9uIG9mIHdoYXQgdGhlIHByb2JsZW0gaXMgYW5k
IHdoZW4gZG9lcyBpdCB0cmlnZ2VyLgoKPiBJIHdvdWxkIGFyZ3VlIHRoYXQgdGhpcyB0b28gaXMg
aW5jb3JyZWN0LCBiZWNhdXNlIHdoeSBkb2VzIGZyZWVpbmcKPiBtZW1vcnkgdGFrZSBzbyBsb25n
PwoKWW91IGFyZSBjb3JyZWN0IHRoYXQgZXZlbiB0aGF0IG9uZSBsYWNrcyBkZXRhaWxlZCBleHBs
YW5hdGlvbgp3aHkgZG9lcyB0aGUgcGF0Y2ggaGVscC4KCkFuZCB0aGUgZXhwbGFuYXRpb24gd2h5
IGl0IHRha2VzIHNvIGxvbmcgaXMgZXhhY3RseSB0aGF0CndlIGhhdmUgdmVyeSBkZWVwIHF1ZXVl
cyBhbmQgYSB2ZXJ5IGxhcmdlIG51bWJlciBvZiBxdWV1ZXMuCldoYXQgdGhlIHBhdGNoIGRvZXMg
aXMgZ2l2ZXMgc2NoZWR1bGVyIGEgY2hhbmNlCnRvIGRvIHNvbWUgd29yayBiZXR3ZWVuIHRoZSBx
dWV1ZXMuCgoKCgoKPiAgQW5kIGFnYWluLCB5b3UgYXJlIG1ha2luZyBpdCB0YWtlIGxvbmdlciwg
aXMgdGhhdAo+IG9rPwo+IAo+IHRoYW5rcywKPiAKPiBncmVnIGstaAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DC8C83003
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 14:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5955E84230;
	Fri,  9 Jun 2023 14:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5955E84230
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vNr7hdLC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 592sebLjcBE9; Fri,  9 Jun 2023 14:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DDDC283CC3;
	Fri,  9 Jun 2023 14:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDDC283CC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0BB6C0037;
	Fri,  9 Jun 2023 14:06:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A0BCC0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 14:06:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7043040B9D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 14:06:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7043040B9D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=vNr7hdLC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SzYr-h7CQ7oi
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 14:06:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87058403BE
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87058403BE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 14:06:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C918460D24;
 Fri,  9 Jun 2023 14:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE9C433D2;
 Fri,  9 Jun 2023 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1686319560;
 bh=kgO/2c+NjKZyd1iafWHrG8i9N2lcKWxvnLxiKEZHcSk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vNr7hdLCTjdv+lb2+2bCz4KNEEQE5RmUFO5PbsMtBT8H2HIcsXYBO2yM/9F9Z2p6/
 skSGokOV3XQInW2ZGGlBV+KxWCR2Vw4Uyg3cyriHxIXjgA49ZhucK1ZJ0VPCMGGzeS
 hHJqu9C8XrumksEs6l06A2a92jJQzlea8JD6aFVk=
Date: Fri, 9 Jun 2023 16:05:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH 1/3] virtio-crypto: fixup potential cpu stall when free
 unused bufs
Message-ID: <2023060924-onion-armhole-803e@gregkh>
References: <20230609131817.712867-1-xianting.tian@linux.alibaba.com>
 <20230609131817.712867-2-xianting.tian@linux.alibaba.com>
 <2023060924-skinning-reset-e256@gregkh>
 <2023060940-wrongdoer-wince-5701@gregkh>
 <91aa6ce0-e8a3-21ac-d29e-b2a47f6386d1@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <91aa6ce0-e8a3-21ac-d29e-b2a47f6386d1@linux.alibaba.com>
Cc: xuanzhuo@linux.alibaba.com, herbert@gondor.apana.org.au, arnd@arndb.de,
 mst@redhat.com, amit@kernel.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-bluetooth@vger.kernel.org,
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

T24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMDk6NDk6MzlQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiAKPiDlnKggMjAyMy82Lzkg5LiL5Y2IOTo0MSwgR3JlZyBLSCDlhpnpgZM6Cj4gPiBP
biBGcmksIEp1biAwOSwgMjAyMyBhdCAwMzozOToyNFBNICswMjAwLCBHcmVnIEtIIHdyb3RlOgo+
ID4gPiBPbiBGcmksIEp1biAwOSwgMjAyMyBhdCAwOToxODoxNVBNICswODAwLCBYaWFudGluZyBU
aWFuIHdyb3RlOgo+ID4gPiA+IEZyb206IFhpYW50aW5nIFRpYW4gPHRpYW54aWFudGluZy50eHRA
YWxpYmFiYS1pbmMuY29tPgo+ID4gPiA+IAo+ID4gPiA+IENwdSBzdGFsbCBpc3N1ZSBtYXkgaGFw
cGVuIGlmIGRldmljZSBpcyBjb25maWd1cmVkIHdpdGggbXVsdGkgcXVldWVzCj4gPiA+ID4gYW5k
IGxhcmdlIHF1ZXVlIGRlcHRoLCBzbyBmaXggaXQuCj4gPiA+ID4gCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbT4KPiA+
ID4gPiAtLS0KPiA+ID4gPiAgIGRyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2Nv
cmUuYyB8IDEgKwo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4gPiA+
ID4gCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5
cHRvX2NvcmUuYyBiL2RyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2NvcmUuYwo+
ID4gPiA+IGluZGV4IDExOThiZDMwNjM2NS4uOTQ4NDlmYTNiZDc0IDEwMDY0NAo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2NvcmUuYwo+ID4gPiA+ICsr
KyBiL2RyaXZlcnMvY3J5cHRvL3ZpcnRpby92aXJ0aW9fY3J5cHRvX2NvcmUuYwo+ID4gPiA+IEBA
IC00ODAsNiArNDgwLDcgQEAgc3RhdGljIHZvaWQgdmlydGNyeXB0b19mcmVlX3VudXNlZF9yZXFz
KHN0cnVjdCB2aXJ0aW9fY3J5cHRvICp2Y3J5cHRvKQo+ID4gPiA+ICAgCQkJa2ZyZWUodmNfcmVx
LT5yZXFfZGF0YSk7Cj4gPiA+ID4gICAJCQlrZnJlZSh2Y19yZXEtPnNncyk7Cj4gPiA+ID4gICAJ
CX0KPiA+ID4gPiArCQljb25kX3Jlc2NoZWQoKTsKPiA+ID4gdGhhdCdzIG5vdCAiZml4aW5nIGEg
c3RhbGwiLCBpdCBpcyAiY2FsbCB0aGUgc2NoZWR1bGVyIGJlY2F1c2Ugd2UgYXJlCj4gPiA+IHRh
a2luZyB0b28gbG9uZyIuICBUaGUgQ1BVIGlzbid0IHN0YWxsZWQgYXQgYWxsLCBqdXN0IGJ1c3ku
Cj4gPiA+IAo+ID4gPiBBcmUgeW91IHN1cmUgdGhpcyBpc24ndCBqdXN0IGEgYnVnIGluIHRoZSBj
b2RlPyAgV2h5IGlzIHRoaXMgY29kZSB0YWtpbmcKPiA+ID4gc28gbG9uZyB0aGF0IHlvdSBoYXZl
IHRvIGZvcmNlIHRoZSBzY2hlZHVsZXIgdG8gcnVuPyAgVGhpcyBpcyBhbG1vc3QKPiA+ID4gYWx3
YXlzIGEgc2lnbiB0aGF0IHNvbWV0aGluZyBlbHNlIG5lZWRzIHRvIGJlIGZpeGVkIGluc3RlYWQu
Cj4gPiBBbmQgc2FtZSBjb21tZW50IG9uIHRoZSBvdGhlciAyIHBhdGNoZXMsIHBsZWFzZSBmaXgg
dGhpcyBwcm9wZXJseS4KPiA+IAo+ID4gQWxzbywgdGhpcyBpcyBhIHRpZ2h0IGxvb3AgdGhhdCBp
cyBqdXN0IGZyZWVpbmcgbWVtb3J5LCB3aHkgaXMgaXQgdGFraW5nCj4gPiBzbyBsb25nPyAgV2h5
IGRvIHlvdSB3YW50IGl0IHRvIHRha2UgbG9uZ2VyICh3aGljaCBpcyB3aGF0IHlvdSBhcmUgZG9p
bmcKPiA+IGhlcmUpLCBpZGVhbGx5IGl0IHdvdWxkIGJlIGZhc3Rlciwgbm90IHNsb3dlciwgc28g
eW91IGFyZSBub3cgc2xvd2luZwo+ID4gZG93biB0aGUgc3lzdGVtIG92ZXJhbGwgd2l0aCB0aGlz
IHBhdGNoc2V0LCByaWdodD8KPiAKPiB5ZXMsIGl0IGlzIHRoZSBzaW1pbGFyIGZpeCB3aXRoIG9u
ZSBmb3IgdmlydGlvLW5ldAo+IAo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jP2g9djYuNC1yYzUmaWQ9ZjhiYjUxMDQzOTQ1NjBlMjkwMTdjMjViY2FkZTRjNmI3YWFi
ZDEwOCA8aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmM/aD12Ni40LXJj
NSZpZD1mOGJiNTEwNDM5NDU2MGUyOTAxN2MyNWJjYWRlNGM2YjdhYWJkMTA4PgoKSSB3b3VsZCBh
cmd1ZSB0aGF0IHRoaXMgdG9vIGlzIGluY29ycmVjdCwgYmVjYXVzZSB3aHkgZG9lcyBmcmVlaW5n
Cm1lbW9yeSB0YWtlIHNvIGxvbmc/ICBBbmQgYWdhaW4sIHlvdSBhcmUgbWFraW5nIGl0IHRha2Ug
bG9uZ2VyLCBpcyB0aGF0Cm9rPwoKdGhhbmtzLAoKZ3JlZyBrLWgKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D4C4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 12:54:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB31613F0
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 12:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB31613F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD8FA60AAD;
	Wed,  2 Jun 2021 12:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9TPL2wb__KT; Wed,  2 Jun 2021 12:54:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D1CB60AB2;
	Wed,  2 Jun 2021 12:54:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00030C000E;
	Wed,  2 Jun 2021 12:54:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50BE6C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:54:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 290B883C62
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:54:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rSiNPVIw365
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A82983C5A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 12:54:13 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2042161359;
 Wed,  2 Jun 2021 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622638452;
 bh=Q3i434w1bmGmD1vtai1MkkJTr+dgXvu2ulIVLc9vZy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OABGGpJ71fVScwcSSNGLlSEa9pB0Pdt3q3rH0+DgibprO8Ghk0xcNnm4+FmHvRmqZ
 5b7Sz0Jn6zHV+zcCdZhp+0I0j2MIh8zph71MhoTl2CsHYhgFnXkTRoghzlZ9e445qc
 9JN/trpBUAmwxegcjW0cQmWMqdtOLcvSE+BFKjPGkeWwqMoS1kbKIN1NAjajlvzHu8
 FCU/NwCg4Xj4gU2lj3fr7dSZN3hrew7Zt6IManYGjaFsaiuAIlfshNyg69v9u+54eM
 VVZSmcwhfVViwZRvqbE/Ds/kndDgfXciR+3On2xeUndj4UV21bWoW1JN7ooqwpuaMv
 0OBkTiIaREp4Q==
Date: Wed, 2 Jun 2021 15:54:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_net: Remove BUG() to aviod machine dead
Message-ID: <YLd/cdL5F964G+Sb@unreal>
References: <a351fbe1-0233-8515-2927-adc826a7fb94@linux.alibaba.com>
 <20210518055336-mutt-send-email-mst@kernel.org>
 <4aaf5125-ce75-c72a-4b4a-11c91cb85a72@linux.alibaba.com>
 <72f284c6-b2f5-a395-a68f-afe801eb81be@redhat.com>
 <YLcePtKhnt9gXq8E@unreal>
 <b80a2841-32aa-02ff-b2cc-f2fb3eeed9a1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b80a2841-32aa-02ff-b2cc-f2fb3eeed9a1@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xianting Tian <xianting.tian@linux.alibaba.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, davem@davemloft.net
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

T24gV2VkLCBKdW4gMDIsIDIwMjEgYXQgMDM6MTQ6NTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS82LzIg5LiL5Y2IMTo1OSwgTGVvbiBSb21hbm92c2t5IOWGmemBkzoK
PiA+IE9uIFR1ZSwgTWF5IDI1LCAyMDIxIGF0IDAyOjE5OjAzUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6Cj4gPiA+IOWcqCAyMDIxLzUvMTkg5LiL5Y2IMTA6MTgsIFhpYW50aW5nIFRpYW4g5YaZ
6YGTOgo+ID4gPiA+IHRoYW5rcywgSSBzdWJtaXQgdGhlIHBhdGNoIGFzIGNvbW1lbnRlZCBieSBB
bmRyZXcKPiA+ID4gPiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMS81LzE4LzI1Ngo+ID4gPiA+
IAo+ID4gPiA+IEFjdHVhbGx5LCBpZiB4bWl0X3NrYigpIHJldHVybnMgZXJyb3IsIGJlbG93IGNv
ZGUgd2lsbCBnaXZlIGEgd2FybmluZwo+ID4gPiA+IHdpdGggZXJyb3IgY29kZS4KPiA+ID4gPiAK
PiA+ID4gPiAgwqDCoMKgwqAvKiBUcnkgdG8gdHJhbnNtaXQgKi8KPiA+ID4gPiAgwqDCoMKgwqBl
cnIgPSB4bWl0X3NrYihzcSwgc2tiKTsKPiA+ID4gPiAKPiA+ID4gPiAgwqDCoMKgwqAvKiBUaGlz
IHNob3VsZCBub3QgaGFwcGVuISAqLwo+ID4gPiA+ICDCoMKgwqDCoGlmICh1bmxpa2VseShlcnIp
KSB7Cj4gPiA+ID4gIMKgwqDCoMKgwqDCoMKgIGRldi0+c3RhdHMudHhfZmlmb19lcnJvcnMrKzsK
PiA+ID4gPiAgwqDCoMKgwqDCoMKgwqAgaWYgKG5ldF9yYXRlbGltaXQoKSkKPiA+ID4gPiAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfd2FybigmZGV2LT5kZXYsCj4gPiA+ID4gIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJVbmV4cGVjdGVkIFRYUSAoJWQpIHF1ZXVlIGZhaWx1
cmU6ICVkXG4iLAo+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxbnVt
LCBlcnIpOwo+ID4gPiA+ICDCoMKgwqDCoMKgwqDCoCBkZXYtPnN0YXRzLnR4X2Ryb3BwZWQrKzsK
PiA+ID4gPiAgwqDCoMKgwqDCoMKgwqAgZGV2X2tmcmVlX3NrYl9hbnkoc2tiKTsKPiA+ID4gPiAg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5FVERFVl9UWF9PSzsKPiA+ID4gPiAgwqDCoMKgwqB9Cj4g
PiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4g5ZyoIDIw
MjEvNS8xOCDkuIvljYg1OjU0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+ID4g
dHlwbyBpbiBzdWJqZWN0Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9uIFR1ZSwgTWF5IDE4LCAyMDIx
IGF0IDA1OjQ2OjU2UE0gKzA4MDAsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gPiA+ID4gPiA+IFdo
ZW4gbWV0IGVycm9yLCB3ZSBvdXRwdXQgYSBwcmludCB0byBhdm9pZCBhIEJVRygpLgo+ID4gPiAK
PiA+ID4gU28geW91IGRvbid0IGV4cGxhaW4gd2h5IHlvdSBuZWVkIHRvIHJlbW92ZSBCVUcoKS4g
SSB0aGluayBpdCBkZXNlcnZlIGEKPiA+ID4gQlVHKCkuCj4gPiBCVUcoKSB3aWxsIGNyYXNoIHRo
ZSBtYWNoaW5lIGFuZCB2aXJ0aW9fbmV0IGlzIG5vdCBrZXJuZWwgY29yZQo+ID4gZnVuY3Rpb25h
bGl0eSB0aGF0IG11c3Qgc3RvcCB0aGUgbWFjaGluZSB0byBwcmV2ZW50IGFueXRoaW5nIHRydWx5
Cj4gPiBoYXJtZnVsIGFuZCBiYXNpYy4KPiAKPiAKPiBOb3RlIHRoYXQgdGhlIEJVRygpIGhlcmUg
aXMgbm90IGZvciB2aXJ0aW8tbmV0IGl0c2VsZi4gSXQgdGVsbHMgdXMgdGhhdCBhCj4gYnVnIHdh
cyBmb3VuZCBieSB2aXJ0aW8tbmV0Lgo+IAo+IFRoYXQgaXMsIHRoZSBvbmUgdGhhdCBwcm9kdWNl
cyB0aGUgc2tiIGhhcyBhIGJ1ZywgdXN1YWxseSBpdCdzIHRoZSBuZXR3b3JrCj4gY29yZS4KPiAK
PiBUaGVyZSBjb3VsZCBhbHNvIGJlIHRoZSBpc3N1ZSBvZiB0aGUgcGFja2V0IGZyb20gdW50cnVz
dGVkIHNvdXJjZSAodXNlcnNwYWNlCj4gbGlrZSBUQVAgb3IgcGFja2V0IHNvY2tldCkgYnV0IHRo
ZXkgc2hvdWxkIGJlIHZhbGlkYXRlZCB0aGVyZS4KClNvIGl0IGlzIGV2ZW4gd29yc2UgdGhhbiBJ
IHRob3VnaHQuIFlvdSBhcmUgc2F5aW5nIHRoYXQgaW4gdGhlb3J5IHVudHJ1c3RlZApyZW1vdGUg
aG9zdCBjYW4gY3Jhc2ggc3lzdGVtLiBJTUhPLCBJdCBpcyBkZWZpbml0ZWx5IG5vdCB0aGUgcGxh
Y2UgdG8gcHV0IEJVRygpLgoKSSByZW1pbmQgeW91IHRoYXQgaW4ta2VybmVsIEFQSSBpcyBidWls
ZCBvbiB0aGUgcHJvbWlzZSB0aGF0IGRhdGEgcGFzc2VkCmJldHdlZW4gYW5kIGNhbGxzIGFyZSBz
YWZlIGFuZCBhbHJlYWR5IGNoZWNrZWQuIFlvdSBkb24ndCBuZWVkIHRvIHNldCBhCnByb3RlY3Rp
b24gZnJvbSB0aGUgbmV0L2NvcmUuCgpUaGFua3MKCj4gCj4gVGhhbmtzCj4gCj4gCj4gPiAKPiA+
IEkgd291bGQgYXJndWUgdGhhdCBjb2RlIGluIGRyaXZlcnMvKiBzaG91bGRuJ3QgY2FsbCBCVUco
KSBtYWNyb3MgYXQgYWxsLgo+ID4gCj4gPiBJZiBpdCBpcyBpbXBvc3NpYmxlLCBkb24ndCBjaGVj
ayBmb3IgdGhhdCBvciBhZGQgV0FSTl9PTigpIGFuZCByZWNvdmVyLAo+ID4gYnV0IGRvbid0IGNy
YXNoIHdob2xlIHN5c3RlbS4KPiA+IAo+ID4gVGhhbmtzCj4gPiAKPiAKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

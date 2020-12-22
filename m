Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B9FC433E0
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 02:45:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2345D22B2B
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2345D22B2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AE6648729E;
	Tue, 22 Dec 2020 02:45:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fanJX+u+51pF; Tue, 22 Dec 2020 02:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C7C9287297;
	Tue, 22 Dec 2020 02:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF95C1787;
	Tue, 22 Dec 2020 02:45:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E053AC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 02:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D2749860BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 02:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dDndxoFF2DUP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 02:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7D406860A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 02:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608605105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtrZTTJIr7oR1Tjy1htJ8dmZVuN7yGZCQoQCqS0N9aA=;
 b=EJK+6NckXsJJxHXtW0EKCVTGh6mNbWoaW7y1CDlol/7XBRwkCc5Lj459X467LG0ichvhjK
 KUKm3TMZFbBc+FZh8rYZHZ4E2plFSYFvIgqsJC0jXUX3cKXydTCmRUDNQ//0kvlJfBSMqx
 x6LbcxwEjt2gf3vnv3d/JXK1+Bdt5cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-SL4XcIw9NsKPmHr7FDGARw-1; Mon, 21 Dec 2020 21:45:00 -0500
X-MC-Unique: SL4XcIw9NsKPmHr7FDGARw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D26801817;
 Tue, 22 Dec 2020 02:44:59 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E66F5D6D1;
 Tue, 22 Dec 2020 02:44:49 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
Date: Tue, 22 Dec 2020 10:44:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221111423.sestfroiw2dgpluc@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTIvMjEg5LiL5Y2INzoxNCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9u
IE1vbiwgRGVjIDIxLCAyMDIwIGF0IDExOjE2OjU0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Cj4+IE9uIDIwMjAvMTIvMTgg5LiL5Y2INzozOCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pj4gT24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTE6Mzc6NDhBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4+Pgo+Pj4+IE9uIDIwMjAvMTEvMTMg5LiL5Y2IOTo0NywgU3RlZmFubyBHYXJ6
YXJlbGxhIHdyb3RlOgo+Pj4+PiBUaGFua3MgdG8gTWF4IHRoYXQgc3RhcnRlZCB0aGlzIHdvcmsh
Cj4+Pj4+IEkgdG9vayBoaXMgcGF0Y2hlcywgYW5kIGV4dGVuZGVkIHRoZSBibG9jayBzaW11bGF0
b3IgYSBiaXQuCj4+Pj4+Cj4+Pj4+IFRoaXMgc2VyaWVzIG1vdmVzIHRoZSBuZXR3b3JrIGRldmlj
ZSBzaW11bGF0b3IgaW4gYSBuZXcgbW9kdWxlCj4+Pj4+ICh2ZHBhX3NpbV9uZXQpIGFuZCBsZWF2
ZXMgdGhlIGdlbmVyaWMgZnVuY3Rpb25zIGluIHRoZSB2ZHBhX3NpbSBjb3JlCj4+Pj4+IG1vZHVs
ZSwgYWxsb3dpbmcgdGhlIHBvc3NpYmlsaXR5IHRvIGFkZCBuZXcgdkRQQSBkZXZpY2Ugc2ltdWxh
dG9ycy4KPj4+Pj4gVGhlbiB3ZSBhZGRlZCBhIG5ldyB2ZHBhX3NpbV9ibGsgbW9kdWxlIHRvIHNp
bXVsYXRlIGEgYmxvY2sgZGV2aWNlLgo+Pj4+Pgo+Pj4+PiBJJ20gbm90IHN1cmUgYWJvdXQgcGF0
Y2ggMTEgKCJ2cmluZ2g6IGFsbG93IHZyaW5naF9pb3ZfeGZlcigpIHRvIHNraXAKPj4+Pj4gYnl0
ZXMgd2hlbiBwdHIgaXMgTlVMTCIpLCBtYXliZSB3ZSBjYW4gYWRkIGEgbmV3IGZ1bmN0aW9ucyBp
bnN0ZWFkIG9mCj4+Pj4+IG1vZGlmeSB2cmluZ2hfaW92X3hmZXIoKS4KPj4+Pj4KPj4+Pj4gQXMg
TWF4IHJlcG9ydGVkLCBJJ20gYWxzbyBzZWVpbmcgZXJyb3JzIHdpdGggdmRwYV9zaW1fYmxrIHJl
bGF0ZWQgdG8KPj4+Pj4gaW90bGIgYW5kIHZyaW5naCB3aGVuIHRoZXJlIGlzIGhpZ2ggbG9hZCwg
dGhlc2UgYXJlIHNvbWUgb2YgdGhlIGVycm9yCj4+Pj4+IG1lc3NhZ2VzIEkgY2FuIHNlZSByYW5k
b21seToKPj4+Pj4KPj4+Pj4gwqAgdnJpbmdoOiBGYWlsZWQgdG8gYWNjZXNzIGF2YWlsIGlkeCBh
dCAwMDAwMDAwMGU4ZGViMmNjCj4+Pj4+IMKgIHZyaW5naDogRmFpbGVkIHRvIHJlYWQgaGVhZDog
aWR4IDYyODkgYWRkcmVzcyAwMDAwMDAwMGUxYWQxZDUwCj4+Pj4+IMKgIHZyaW5naDogRmFpbGVk
IHRvIGdldCBmbGFncyBhdCAwMDAwMDAwMDY2MzVkN2EzCj4+Pj4+Cj4+Pj4+IMKgIHZpcnRpb192
ZHBhIHZkcGEwOiB2cmluZ2hfaW92X3B1c2hfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDogwqAg
Cj4+Pj4+IDB4Mjg0MDAwMCBsZW46IDB4MjAwMDAKPj4+Pj4gwqAgdmlydGlvX3ZkcGEgdmRwYTA6
IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigpIGVycm9yOiAtMTQgb2Zmc2V0OiDCoCAKPj4+Pj4gMHg1
OGVlMDAwIGxlbjogMHgzMDAwCj4+Pj4+Cj4+Pj4+IFRoZXNlIGVycm9ycyBzaG91bGQgYWxsIGJl
IHJlbGF0ZWQgdG8gdGhlIGZhY3QgdGhhdCBpb3RsYl90cmFuc2xhdGUoKQo+Pj4+PiBmYWlscyB3
aXRoIC1FSU5WQUwsIHNvIGl0IHNlZW1zIHRoYXQgd2UgbWlzcyBzb21lIG1hcHBpbmcuCj4+Pj4K
Pj4+Pgo+Pj4+IElzIHRoaXMgb25seSByZXByb2R1Y2libGUgd2hlbiB0aGVyZSdzIG11bHRpcGxl
IGNvLWN1cnJlbnQgCj4+Pj4gYWNjZXNzaW5nIG9mIElPVExCPyBJZiB5ZXMsIGl0J3MgcHJvYmFi
bHkgYSBoaW50IHRoYXQgc29tZSBraW5kIG9mIAo+Pj4+IHN5bmNocm9uaXphdGlvbiBpcyBzdGls
bCBtaXNzZWQgc29tZXdoZXJlLgo+Pj4+Cj4+Pj4gSXQgbWlnaHQgYmUgdXNlZnVsIHRvIGxvZyB0
aGUgZG1hX21hcC91bm1wIGluIGJvdGggdmlydGlvX3JpbmcgYW5kIAo+Pj4+IHZyaW5naCB0byBz
ZWUgd2hvIGlzIG1pc3NpbmcgdGhlIG1hcC4KPj4+Pgo+Pj4KPj4+IEp1c3QgYW4gdXBkYXRlIGFi
b3V0IHRoZXNlIGlzc3VlcyB3aXRoIHZkcGEtc2ltLWJsay4KPj4+IEkndmUgYmVlbiBmb2N1c2lu
ZyBhIGxpdHRsZSBiaXQgb24gdGhlc2UgZmFpbHVyZXMgb3ZlciB0aGUgbGFzdCBmZXcgCj4+PiBk
YXlzIGFuZCBoYXZlIGZvdW5kIHR3byBpc3N1ZXMgcmVsYXRlZCB0byB0aGUgSU9UTEIvSU9NTVU6
Cj4+Pgo+Pj4gMS4gU29tZSByZXF1ZXN0cyBjb21pbmcgZnJvbSB0aGUgYmxvY2sgbGF5ZXIgZmls
bHMgdGhlIFNHIGxpc3Qgd2l0aCAKPj4+IG11bHRpcGxlIGJ1ZmZlcnMgdGhhdCBoYWQgdGhlIHNh
bWUgcGh5c2ljYWwgYWRkcmVzcy4gVGhpcyBoYXBwZW5zIAo+Pj4gZm9yIGV4YW1wbGUgd2hpbGUg
dXNpbmcgJ21rZnMnLCBhdCBzb21lIHBvaW50cyBtdWx0aXBsZSBzZWN0b3JzIGFyZSAKPj4+IHpl
cm9lZCBzbyBtdWx0aXBsZSBTRyBlbGVtZW50cyBwb2ludCB0byB0aGUgc2FtZSBwaHlzaWNhbCBw
YWdlIHRoYXQgCj4+PiBpcyB6ZXJvZWQuCj4+PiBTaW5jZSB3ZSBhcmUgdXNpbmcgdmhvc3RfaW90
bGJfZGVsX3JhbmdlKCkgaW4gdGhlIAo+Pj4gdmRwYXNpbV91bm1hcF9wYWdlKCksIHRoaXMgcmVt
b3ZlcyBhbGwgdGhlIG92ZXJsYXBwZWQgcmFuZ2VzLiBJIAo+Pj4gZml4ZWQgcmVtb3ZpbmcgYSBz
aW5nbGUgbWFwIGluIHZkcGFzaW1fdW5tYXBfcGFnZSgpLCBidXQgaGFzIGFuIAo+Pj4gYWx0ZXJu
YXRpdmUgd2UgY2FuIGltcGxlbWVudCBzb21lIGtpbmQgb2YgcmVmZXJlbmNlIGNvdW50cy4KPj4K
Pj4KPj4gSSB0aGluayB3ZSBuZWVkIHRvIGRvIHdoYXQgaGFyZHdhcmUgZG8uIFNvIHVzaW5nIHJl
ZmNvdW50IGlzIHByb2JhYmx5IAo+PiBub3QgYSBnb29kIGlkYS4KPgo+IE9rYXksIHNvIHNpbmNl
IHdlIGFyZSB1c2luZyBmb3Igc2ltcGxpY2l0eSBhbiBpZGVudGljYWwgbWFwcGluZywgd2UgCj4g
YXJlIGFzc2lnbmluZyB0aGUgc2FtZSBkbWFfYWRkciB0byBtdWx0aXBsZSBwYWdlcy4KCgpJIHRo
aW5rIEkgZ2V0IHlvdSBub3cuIFRoYXQncyB0aGUgcm9vdCBjYXVzZSBmb3IgdGhlIGZhaWx1cmUu
CgpUaGVuIEkgdGhpbmsgd2UgbmVlZCBhbiBzaW1wbGUgaW92YSBhbGxvY2F0b3IgZm9yIHZkcGEg
c2ltdWxhdG9yLCBhbmQgaXQgCm1pZ2h0IGJlIHVzZWZ1bCBmb3IgVkRVU0UgYXMgd2VsbC4KClRo
YW5rcwoKCj4KPiBTbywgaXQgc2hvdWxkIGJlIG9rYXkgdG8gcmVtb3ZlIGEgc2luZ2xlIG1hcHBp
bmcgY2hlY2tpbmcgdGhlIG90aGVycyAKPiBwYXJhbWV0ZXJzIChpLmUuIGRpciwgc2l6ZSkuCj4K
PiBJJ2xsIHNlbmQgYSBwYXRjaCwgc28gd2l0aCB0aGUgY29kZSBpdCBzaG91bGQgYmUgZWFzaWVy
IDotKQo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgo+Pgo+Pgo+Pj4KPj4+IDIuIFRoZXJlIHdhcyBh
IHJhY2UgYmV0d2VlbiBkbWFfbWFwL3VubWFwIGFuZCB0aGUgd29ya2VyIHRocmVhZCwgCj4+PiBz
aW5jZSBib3RoIGFyZSBhY2Nlc3NpbmcgdGhlIElPTU1VLiBUYWtpbmcgdGhlIGlvbW11X2xvY2sg
d2hpbGUgCj4+PiB1c2luZyB2aG9zdF9pb3RsYl8qIEFQSSBpbiB0aGUgd29ya2VyIHRocmVhZCBm
aXhlcyB0aGUgInZyaW5naDogCj4+PiBGYWlsZWQgdG8gKiIgaXNzdWVzLgo+Pj4KPj4+IFdoaXQg
dGhlc2UgaXNzdWVzIGZpeGVkIHRoZSB2ZHBhLWJsayBzaW11bGF0b3Igc2VlbXMgdG8gd29yayB3
ZWxsLgo+Pj4gSSdsbCBzZW5kIHRoZSBwYXRjaGVzIG5leHQgd2VlayBvciBhZnRlciB0aGUgYnJl
YWsuCj4+Cj4+Cj4+IEdvb2QgdG8ga25vdyB0aGlzLgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+Cj4+
PiBUaGFua3MsCj4+PiBTdGVmYW5vCj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

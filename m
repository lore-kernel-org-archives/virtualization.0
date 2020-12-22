Return-Path: <SRS0=Q5yb=F2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A3C433DB
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 12:29:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB592312D
	for <virtualization@archiver.kernel.org>; Tue, 22 Dec 2020 12:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB592312D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C1E7273D3;
	Tue, 22 Dec 2020 12:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eAyL7HCoEdCc; Tue, 22 Dec 2020 12:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C4BD272F7;
	Tue, 22 Dec 2020 12:29:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A20C1825;
	Tue, 22 Dec 2020 12:29:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E88CC0893
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 720A185F90
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00WdQKxppcYh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A810485CD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608640176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QvPHQ8PtpFiatjHXDcnf/N48TY86yEtQF2kSghWz0cg=;
 b=Yhvy56fQkGy7OwEtW95r+TvW5ZSoCMWrH0Kp1snfEpdIOdhMo5QSYwFFThxX54zc+HMWo1
 fqdO4/jndBK+LEfWJqX1hqdjyDMVmSBzYdzIro5drbEa5Xf5fmCBiCYFJPoe0w1Vn95wg4
 5edM7ueWZZQfjbF5iqEz/Vj0mrMY1Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-TYnFGRoWOBKqln82OvSxaA-1; Tue, 22 Dec 2020 07:29:34 -0500
X-MC-Unique: TYnFGRoWOBKqln82OvSxaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F39951081;
 Tue, 22 Dec 2020 12:29:33 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE925B4CE;
 Tue, 22 Dec 2020 12:29:22 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
 <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
 <20201222105733.4f6oou7lshi35qvc@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cc913954-135d-da5a-1acd-38c3ecb77dfa@redhat.com>
Date: Tue, 22 Dec 2020 20:29:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222105733.4f6oou7lshi35qvc@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvMTIvMjIg5LiL5Y2INjo1NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IE9u
IFR1ZSwgRGVjIDIyLCAyMDIwIGF0IDEwOjQ0OjQ4QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+Cj4+IE9uIDIwMjAvMTIvMjEg5LiL5Y2INzoxNCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pj4gT24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6MTY6NTRBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4+Pgo+Pj4+IE9uIDIwMjAvMTIvMTgg5LiL5Y2INzozOCwgU3RlZmFubyBHYXJ6
YXJlbGxhIHdyb3RlOgo+Pj4+PiBPbiBNb24sIE5vdiAxNiwgMjAyMCBhdCAxMTozNzo0OEFNICsw
ODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+IE9uIDIwMjAvMTEvMTMg5LiL5Y2I
OTo0NywgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4+Pj4+IFRoYW5rcyB0byBNYXggdGhh
dCBzdGFydGVkIHRoaXMgd29yayEKPj4+Pj4+PiBJIHRvb2sgaGlzIHBhdGNoZXMsIGFuZCBleHRl
bmRlZCB0aGUgYmxvY2sgc2ltdWxhdG9yIGEgYml0Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhpcyBzZXJp
ZXMgbW92ZXMgdGhlIG5ldHdvcmsgZGV2aWNlIHNpbXVsYXRvciBpbiBhIG5ldyBtb2R1bGUKPj4+
Pj4+PiAodmRwYV9zaW1fbmV0KSBhbmQgbGVhdmVzIHRoZSBnZW5lcmljIGZ1bmN0aW9ucyBpbiB0
aGUgdmRwYV9zaW0gCj4+Pj4+Pj4gY29yZQo+Pj4+Pj4+IG1vZHVsZSwgYWxsb3dpbmcgdGhlIHBv
c3NpYmlsaXR5IHRvIGFkZCBuZXcgdkRQQSBkZXZpY2Ugc2ltdWxhdG9ycy4KPj4+Pj4+PiBUaGVu
IHdlIGFkZGVkIGEgbmV3IHZkcGFfc2ltX2JsayBtb2R1bGUgdG8gc2ltdWxhdGUgYSBibG9jayBk
ZXZpY2UuCj4+Pj4+Pj4KPj4+Pj4+PiBJJ20gbm90IHN1cmUgYWJvdXQgcGF0Y2ggMTEgKCJ2cmlu
Z2g6IGFsbG93IHZyaW5naF9pb3ZfeGZlcigpIHRvIAo+Pj4+Pj4+IHNraXAKPj4+Pj4+PiBieXRl
cyB3aGVuIHB0ciBpcyBOVUxMIiksIG1heWJlIHdlIGNhbiBhZGQgYSBuZXcgZnVuY3Rpb25zIAo+
Pj4+Pj4+IGluc3RlYWQgb2YKPj4+Pj4+PiBtb2RpZnkgdnJpbmdoX2lvdl94ZmVyKCkuCj4+Pj4+
Pj4KPj4+Pj4+PiBBcyBNYXggcmVwb3J0ZWQsIEknbSBhbHNvIHNlZWluZyBlcnJvcnMgd2l0aCB2
ZHBhX3NpbV9ibGsgCj4+Pj4+Pj4gcmVsYXRlZCB0bwo+Pj4+Pj4+IGlvdGxiIGFuZCB2cmluZ2gg
d2hlbiB0aGVyZSBpcyBoaWdoIGxvYWQsIHRoZXNlIGFyZSBzb21lIG9mIHRoZSAKPj4+Pj4+PiBl
cnJvcgo+Pj4+Pj4+IG1lc3NhZ2VzIEkgY2FuIHNlZSByYW5kb21seToKPj4+Pj4+Pgo+Pj4+Pj4+
IMKgIHZyaW5naDogRmFpbGVkIHRvIGFjY2VzcyBhdmFpbCBpZHggYXQgMDAwMDAwMDBlOGRlYjJj
Ywo+Pj4+Pj4+IMKgIHZyaW5naDogRmFpbGVkIHRvIHJlYWQgaGVhZDogaWR4IDYyODkgYWRkcmVz
cyAwMDAwMDAwMGUxYWQxZDUwCj4+Pj4+Pj4gwqAgdnJpbmdoOiBGYWlsZWQgdG8gZ2V0IGZsYWdz
IGF0IDAwMDAwMDAwNjYzNWQ3YTMKPj4+Pj4+Pgo+Pj4+Pj4+IMKgIHZpcnRpb192ZHBhIHZkcGEw
OiB2cmluZ2hfaW92X3B1c2hfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDogCj4+Pj4+Pj4gwqAg
MHgyODQwMDAwIGxlbjogMHgyMDAwMAo+Pj4+Pj4+IMKgIHZpcnRpb192ZHBhIHZkcGEwOiB2cmlu
Z2hfaW92X3B1bGxfaW90bGIoKSBlcnJvcjogLTE0IG9mZnNldDogCj4+Pj4+Pj4gwqAgMHg1OGVl
MDAwIGxlbjogMHgzMDAwCj4+Pj4+Pj4KPj4+Pj4+PiBUaGVzZSBlcnJvcnMgc2hvdWxkIGFsbCBi
ZSByZWxhdGVkIHRvIHRoZSBmYWN0IHRoYXQgCj4+Pj4+Pj4gaW90bGJfdHJhbnNsYXRlKCkKPj4+
Pj4+PiBmYWlscyB3aXRoIC1FSU5WQUwsIHNvIGl0IHNlZW1zIHRoYXQgd2UgbWlzcyBzb21lIG1h
cHBpbmcuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IElzIHRoaXMgb25seSByZXByb2R1Y2libGUgd2hl
biB0aGVyZSdzIG11bHRpcGxlIGNvLWN1cnJlbnQgCj4+Pj4+PiBhY2Nlc3Npbmcgb2YgSU9UTEI/
IElmIHllcywgaXQncyBwcm9iYWJseSBhIGhpbnQgdGhhdCBzb21lIGtpbmQgCj4+Pj4+PiBvZiBz
eW5jaHJvbml6YXRpb24gaXMgc3RpbGwgbWlzc2VkIHNvbWV3aGVyZS4KPj4+Pj4+Cj4+Pj4+PiBJ
dCBtaWdodCBiZSB1c2VmdWwgdG8gbG9nIHRoZSBkbWFfbWFwL3VubXAgaW4gYm90aCB2aXJ0aW9f
cmluZyAKPj4+Pj4+IGFuZCB2cmluZ2ggdG8gc2VlIHdobyBpcyBtaXNzaW5nIHRoZSBtYXAuCj4+
Pj4+Pgo+Pj4+Pgo+Pj4+PiBKdXN0IGFuIHVwZGF0ZSBhYm91dCB0aGVzZSBpc3N1ZXMgd2l0aCB2
ZHBhLXNpbS1ibGsuCj4+Pj4+IEkndmUgYmVlbiBmb2N1c2luZyBhIGxpdHRsZSBiaXQgb24gdGhl
c2UgZmFpbHVyZXMgb3ZlciB0aGUgbGFzdCAKPj4+Pj4gZmV3IGRheXMgYW5kIGhhdmUgZm91bmQg
dHdvIGlzc3VlcyByZWxhdGVkIHRvIHRoZSBJT1RMQi9JT01NVToKPj4+Pj4KPj4+Pj4gMS4gU29t
ZSByZXF1ZXN0cyBjb21pbmcgZnJvbSB0aGUgYmxvY2sgbGF5ZXIgZmlsbHMgdGhlIFNHIGxpc3Qg
Cj4+Pj4+IHdpdGggbXVsdGlwbGUgYnVmZmVycyB0aGF0IGhhZCB0aGUgc2FtZSBwaHlzaWNhbCBh
ZGRyZXNzLiBUaGlzIAo+Pj4+PiBoYXBwZW5zIGZvciBleGFtcGxlIHdoaWxlIHVzaW5nICdta2Zz
JywgYXQgc29tZSBwb2ludHMgbXVsdGlwbGUgCj4+Pj4+IHNlY3RvcnMgYXJlIHplcm9lZCBzbyBt
dWx0aXBsZSBTRyBlbGVtZW50cyBwb2ludCB0byB0aGUgc2FtZSAKPj4+Pj4gcGh5c2ljYWwgcGFn
ZSB0aGF0IGlzIHplcm9lZC4KPj4+Pj4gU2luY2Ugd2UgYXJlIHVzaW5nIHZob3N0X2lvdGxiX2Rl
bF9yYW5nZSgpIGluIHRoZSAKPj4+Pj4gdmRwYXNpbV91bm1hcF9wYWdlKCksIHRoaXMgcmVtb3Zl
cyBhbGwgdGhlIG92ZXJsYXBwZWQgcmFuZ2VzLiBJIAo+Pj4+PiBmaXhlZCByZW1vdmluZyBhIHNp
bmdsZSBtYXAgaW4gdmRwYXNpbV91bm1hcF9wYWdlKCksIGJ1dCBoYXMgYW4gCj4+Pj4+IGFsdGVy
bmF0aXZlIHdlIGNhbiBpbXBsZW1lbnQgc29tZSBraW5kIG9mIHJlZmVyZW5jZSBjb3VudHMuCj4+
Pj4KPj4+Pgo+Pj4+IEkgdGhpbmsgd2UgbmVlZCB0byBkbyB3aGF0IGhhcmR3YXJlIGRvLiBTbyB1
c2luZyByZWZjb3VudCBpcyAKPj4+PiBwcm9iYWJseSBub3QgYSBnb29kIGlkYS4KPj4+Cj4+PiBP
a2F5LCBzbyBzaW5jZSB3ZSBhcmUgdXNpbmcgZm9yIHNpbXBsaWNpdHkgYW4gaWRlbnRpY2FsIG1h
cHBpbmcsIHdlIAo+Pj4gYXJlIGFzc2lnbmluZyB0aGUgc2FtZSBkbWFfYWRkciB0byBtdWx0aXBs
ZSBwYWdlcy4KPj4KPj4KPj4gSSB0aGluayBJIGdldCB5b3Ugbm93LiBUaGF0J3MgdGhlIHJvb3Qg
Y2F1c2UgZm9yIHRoZSBmYWlsdXJlLgo+Cj4gWWVzLCBzb3JyeSwgSSBkaWRuJ3QgZXhwbGFpbiB3
ZWxsIHByZXZpb3VzbHkuCj4KPj4KPj4gVGhlbiBJIHRoaW5rIHdlIG5lZWQgYW4gc2ltcGxlIGlv
dmEgYWxsb2NhdG9yIGZvciB2ZHBhIHNpbXVsYXRvciwgYW5kIAo+PiBpdCBtaWdodCBiZSB1c2Vm
dWwgZm9yIFZEVVNFIGFzIHdlbGwuCj4KPiBPa2F5LCBJJ2xsIHdvcmsgb24gaXQuCj4gSWYgeW91
IGhhdmUgYW4gZXhhbXBsZSB0byBmb2xsb3cgb3Igc29tZSBwb2ludGVycywgdGhleSBhcmUgd2Vs
Y29tZSA6LSkKCgpLZXJuZWwgaGFkIGltcGxlbWVudGVkIG9uZSBpbiBpb3ZhLmMgYnV0IEknbSBu
b3Qgc3VyZSB3ZSBuZWVkIHRoZSAKY29tcGxleGl0eSBsaWtlIHRoYXQuIE9yIHdlIGNhbiBqdXN0
IHVzZSByYnRyZWUgb3IgaWRyIHRvIGltcGxlbWVudCBhIApzaW1wbGVyIG9uZS4KClRoYW5rcwoK
Cj4KPiBUaGFua3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

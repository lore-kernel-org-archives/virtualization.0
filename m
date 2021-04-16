Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C64C433B4
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 03:03:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC7961152
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 03:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC7961152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F0F88478F;
	Fri, 16 Apr 2021 03:03:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YQ04my7L4ufS; Fri, 16 Apr 2021 03:03:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA2F48474F;
	Fri, 16 Apr 2021 03:03:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B7FC000C;
	Fri, 16 Apr 2021 03:03:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26F59C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C20B41864
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z1F5a1-h7d95
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC1E141863
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 03:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618542200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikyH2z8Vt7uMI/VG6XB6eSk4QGEm2QFd/gz535ClrYI=;
 b=LME/u4BdDS2d6uVI+gvTjLYA0fTc9mkKVcHkc0XLoeFyEUA8Y01lWUtAysPZiocbi0hbyE
 v373lnXB3REEuJ8KTgnJw5Dan0TwraVoBqNzQ5UJjMQ5eh9C34DDKtjSTLss8k0hlseQoj
 Txd/sSk5h9svb/OdjYxjKabJmAEYlIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-ByMz4XzrPpGli7s2BmtqTA-1; Thu, 15 Apr 2021 23:03:16 -0400
X-MC-Unique: ByMz4XzrPpGli7s2BmtqTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D9EB81744F;
 Fri, 16 Apr 2021 03:03:14 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-140.pek2.redhat.com
 [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F395B60BE5;
 Fri, 16 Apr 2021 03:02:58 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] Documentation: Add documentation for VDUSE
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-11-xieyongji@bytedance.com>
 <YHb44R4HyLEUVSTF@stefanha-x1.localdomain>
 <CACycT3uNR+nZY5gY0UhPkeOyi7Za6XkX4b=hasuDcgqdc7fqfg@mail.gmail.com>
 <YHfo8pc7dIO9lNc3@stefanha-x1.localdomain>
 <80b31814-9e41-3153-7efb-c0c2fab44feb@redhat.com>
 <02c19c22-13ea-ea97-d99b-71edfee0b703@redhat.com>
 <CACycT3tL7URz3n-KhMAwYH+Sn1e1TSyfU+RKcc8jpPDJ7WcZ2w@mail.gmail.com>
 <5beabeaf-52a6-7ee5-b666-f3616ea82811@redhat.com>
 <CACycT3tyksBYxgbQLFJ-mFCKkaWotucM5_ho_K3q4wMpR0P=gw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <17e3312e-686b-c5dd-852d-e9ffb7f4c707@redhat.com>
Date: Fri, 16 Apr 2021 11:02:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACycT3tyksBYxgbQLFJ-mFCKkaWotucM5_ho_K3q4wMpR0P=gw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzQvMTYg5LiK5Y2IMTA6NTgsIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIEZyaSwg
QXByIDE2LCAyMDIxIGF0IDEwOjIwIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzE1IOS4i+WNiDc6MTcsIFlvbmdqaSBYaWUg5YaZ6YGT
Ogo+Pj4gT24gVGh1LCBBcHIgMTUsIDIwMjEgYXQgNTowNSBQTSBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPiB3cm90ZToKPj4+PiDlnKggMjAyMS80LzE1IOS4i+WNiDQ6MzYsIEphc29u
IFdhbmcg5YaZ6YGTOgo+Pj4+Pj4gUGxlYXNlIHN0YXRlIHRoaXMgZXhwbGljaXRseSBhdCB0aGUg
c3RhcnQgb2YgdGhlIGRvY3VtZW50LiBFeGlzdGluZwo+Pj4+Pj4gaW50ZXJmYWNlcyBsaWtlIEZV
U0UgYXJlIGRlc2lnbmVkIHRvIGF2b2lkIHRydXN0aW5nIHVzZXJzcGFjZS4KPj4+Pj4gVGhlcmUn
cmUgc29tZSBzdWJ0bGUgZGlmZmVyZW5jZSBoZXJlLiBWRFVTRSBwcmVzZW50IGEgZGV2aWNlIHRv
IGtlcm5lbAo+Pj4+PiB3aGljaCBtZWFucyBJT01NVSBpcyBwcm9iYWJseSB0aGUgb25seSB0aGlu
ZyB0byBwcmV2ZW50IGEgbWFsaWNvdXMKPj4+Pj4gZGV2aWNlLgo+Pj4+Pgo+Pj4+Pgo+Pj4+Pj4g
VGhlcmVmb3JlCj4+Pj4+PiBwZW9wbGUgbWlnaHQgdGhpbmsgdGhlIHNhbWUgaXMgdGhlIGNhc2Ug
aGVyZS4gSXQncyBjcml0aWNhbCB0aGF0IHBlb3BsZQo+Pj4+Pj4gYXJlIGF3YXJlIG9mIHRoaXMg
YmVmb3JlIGRlcGxveWluZyBWRFVTRSB3aXRoIHZpcnRpby12ZHBhLgo+Pj4+Pj4KPj4+Pj4+IFdl
IHNob3VsZCBwcm9iYWJseSBwYXVzZSBoZXJlIGFuZCB0aGluayBhYm91dCB3aGV0aGVyIGl0J3Mg
cG9zc2libGUgdG8KPj4+Pj4+IGF2b2lkIHRydXN0aW5nIHVzZXJzcGFjZS4gRXZlbiBpZiBpdCB0
YWtlcyBzb21lIGVmZm9ydCBhbmQgY29zdHMgc29tZQo+Pj4+Pj4gcGVyZm9ybWFuY2UgaXQgd291
bGQgcHJvYmFibHkgYmUgd29ydGh3aGlsZS4KPj4+Pj4gU2luY2UgdGhlIGJvdW5jZSBidWZmZXIg
aXMgdXNlZCB0aGUgb25seSBhdHRhY2sgc3VyZmFjZSBpcyB0aGUKPj4+Pj4gY29oZXJlbnQgYXJl
YSwgaWYgd2Ugd2FudCB0byBlbmZvcmNlIHN0cm9uZ2VyIGlzb2xhdGlvbiB3ZSBuZWVkIHRvIHVz
ZQo+Pj4+PiBzaGFkb3cgdmlydHF1ZXVlICh3aGljaCBpcyBwcm9wb3NlZCBpbiBlYXJsaWVyIHZl
cnNpb24gYnkgbWUpIGluIHRoaXMKPj4+Pj4gY2FzZS4gQnV0IEknbSBub3Qgc3VyZSBpdCdzIHdv
cnRoIHRvIGRvIHRoYXQuCj4+Pj4KPj4+PiBTbyB0aGlzIHJlbWluZHMgbWUgdGhlIGRpc2N1c3Np
b24gaW4gdGhlIGVuZCBvZiBsYXN0IHllYXIuIFdlIG5lZWQgdG8KPj4+PiBtYWtlIHN1cmUgd2Ug
ZG9uJ3Qgc3VmZmVyIGZyb20gdGhlIHNhbWUgaXNzdWVzIGZvciBWRFVTRSBhdCBsZWFzdAo+Pj4+
Cj4+Pj4gaHR0cHM6Ly95aGJ0Lm5ldC9sb3JlL2FsbC9jMzYyOWEyNy0zNTkwLTFkOWYtMjExYi1j
MGI3YmUxNTJiMzJAcmVkaGF0LmNvbS9ULyNtYzZiNmUyMzQzY2JlZmZjYTY4Y2E3YTk3ZTBmNDcz
YWFhODcxYzk1Ygo+Pj4+Cj4+Pj4gT3Igd2UgY2FuIHNvbHZlIGl0IGF0IHZpcnRpbyBsZXZlbCwg
ZS5nIHJlbWVtYmVyIHRoZSBkbWEgYWRkcmVzcyBpbnN0ZWFkCj4+Pj4gb2YgZGVwZW5kaW5nIG9u
IHRoZSBhZGRyIGluIHRoZSBkZXNjcmlwdG9yIHJpbmcKPj4+Pgo+Pj4gSSBtaWdodCBtaXNzIHNv
bWV0aGluZy4gQnV0IFZEVVNFIGhhcyByZWNvcmRlZCB0aGUgZG1hIGFkZHJlc3MgZHVyaW5nCj4+
PiBkbWEgbWFwcGluZywgc28gd2Ugd291bGQgbm90IGRvIGJvdW5jaW5nIGlmIHRoZSBhZGRyL2xl
bmd0aCBpcyBpbnZhbGlkCj4+PiBkdXJpbmcgZG1hIHVubWFwcGluZy4gSXMgaXQgZW5vdWdoPwo+
Pgo+PiBFLmcgbWFsaWNvdXMgZGV2aWNlIHdyaXRlIGEgYnVnZ3kgZG1hIGFkZHJlc3MgaW4gdGhl
IGRlc2NyaXB0b3IgcmluZywgc28KPj4gd2UgaGFkOgo+Pgo+PiB2cmluZ191bm1hcF9vbmVfc3Bs
aXQoZGVzYy0+YWRkciwgZGVzYy0+bGVuKQo+PiAgICAgICBkbWFfdW5tYXBfc2luZ2xlKCkKPj4g
ICAgICAgICAgIHZkdXNlX2Rldl91bm1hcF9wYWdlKCkKPj4gICAgICAgICAgICAgICB2ZHVzZV9k
b21haW5fYm91bmNlKCkKPj4KPj4gQW5kIGluIHZkdXNlX2RvbWFpbl9ib3VuY2UoKSB3ZSBoYWQ6
Cj4+Cj4+ICAgICAgICAgICB3aGlsZSAoc2l6ZSkgewo+PiAgICAgICAgICAgICAgICAgICBtYXAg
PSAmZG9tYWluLT5ib3VuY2VfbWFwc1tpb3ZhID4+IFBBR0VfU0hJRlRdOwo+PiAgICAgICAgICAg
ICAgICAgICBvZmZzZXQgPSBvZmZzZXRfaW5fcGFnZShpb3ZhKTsKPj4gICAgICAgICAgICAgICAg
ICAgc3ogPSBtaW5fdChzaXplX3QsIFBBR0VfU0laRSAtIG9mZnNldCwgc2l6ZSk7Cj4+Cj4+IFRo
aXMgbWVhbnMgd2UgdHJ1c3QgdGhlIGlvdmEgd2hpY2ggaXMgZGFuZ2Vyb3VzIGFuZCBleGFjbHkg
dGhlIGlzc3VlCj4+IG1lbnRpb25lZCBpbiB0aGUgYWJvdmUgbGluay4KPj4KPj4gICBGcm9tIFZE
VVNFIGxldmVsIG5lZWQgdG8gbWFrZSBzdXJlIGlvdmEgaXMgbGVnYWwuCj4+Cj4gSSB0aGluayB3
ZSBhbHJlYWR5IGRvIHRoYXQgaW4gdmR1c2VfZG9tYWluX2JvdW5jZSgpOgo+Cj4gICAgICB3aGls
ZSAoc2l6ZSkgewo+ICAgICAgICAgIG1hcCA9ICZkb21haW4tPmJvdW5jZV9tYXBzW2lvdmEgPj4g
UEFHRV9TSElGVF07Cj4KPiAgICAgICAgICBpZiAoV0FSTl9PTighbWFwLT5ib3VuY2VfcGFnZSB8
fAo+ICAgICAgICAgICAgICBtYXAtPm9yaWdfcGh5cyA9PSBJTlZBTElEX1BIWVNfQUREUikpCj4g
ICAgICAgICAgICAgIHJldHVybjsKCgpTbyB5b3UgZG9uJ3QgY2hlY2sgd2hldGhlciBpb3ZhIGlz
IGxlZ2FsIGJlZm9yZSB1c2luZyBpdCwgc28gaXQncyBhdCAKbGVhc3QgYSBwb3NzaWJsZSBvdXQg
b2YgYm91bmQgYWNjZXNzIG9mIHRoZSBib3VuY2VfbWFwc1tdIGlzbid0IGl0PyAoZS5nIAp3aGF0
IGhhcHBlbnMgaWYgaW92YSBpcyBVTExPTkdfTUFYKS4KCgo+Cj4KPj4gICBGcm9tIHZpcnRpbyBs
ZXZlbCwgd2Ugc2hvdWxkIG5vdCB0cnVzZSBkZXNjLT5hZGRyLgo+Pgo+IFdlIHdvdWxkIG5vdCB0
b3VjaCBkZXNjLT5hZGRyIGFmdGVyIHZyaW5nX3VubWFwX29uZV9zcGxpdCgpLiBTbyBJJ20KPiBu
b3Qgc3VyZSB3aGF0IHdlIG5lZWQgdG8gZG8gYXQgdGhlIHZpcnRpbyBsZXZlbC4KCgpJIHRoaW5r
IHRoZSBwb2ludCBpcyB0byByZWNvcmQgdGhlIGRtYSBhZGRyZXMvbGVuIHNvbWV3aGVyZSBpbnN0
ZWFkIG9mIApyZWFkaW5nIHRoZW0gZnJvbSBkZXNjcmlwdG9yIHJpbmcuCgpUaGFua3MKCgo+Cj4g
VGhhbmtzLAo+IFlvbmdqaQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

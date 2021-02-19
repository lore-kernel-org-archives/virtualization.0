Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DD5C433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 08:51:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C897964D92
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 08:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C897964D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DF7F86B75;
	Fri, 19 Feb 2021 08:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvgmlvdBvQ0A; Fri, 19 Feb 2021 08:51:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9641868CC;
	Fri, 19 Feb 2021 08:51:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79EE8C000E;
	Fri, 19 Feb 2021 08:51:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6F13C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9E7FA86BFA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:51:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zTjZGbVKidln
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:51:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 75DAD86AAB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613724679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzW38bag0aKrL8zMi/Uhja163ywErKOZZj1OgGSNVuk=;
 b=TKSxXFFYjQAdpIY4526jHNXR+g6VYoyHPKWtGUbWLC7NfoXnGMmKW0fWIJkikUZ2GSbEqg
 4zvTxmNv+pk512XOzrQmqDQnyWXTga4hOHuc9Xpu8aeHeBLT7HC5W9o/xv1/I4MI8PVT3O
 wmmvw2Om7nt9vDfzFJ+lyZFDTCDPJiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-_fgkeNYdPoevbhB3Idx16A-1; Fri, 19 Feb 2021 03:51:15 -0500
X-MC-Unique: _fgkeNYdPoevbhB3Idx16A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B59F107ACE6;
 Fri, 19 Feb 2021 08:51:14 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-40.pek2.redhat.com
 [10.72.12.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41A675D9C2;
 Fri, 19 Feb 2021 08:51:06 +0000 (UTC)
Subject: Re: [PATCH] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Balazs Nemeth <bnemeth@redhat.com>
References: <5e910d11a14da17c41317417fc41d3a9d472c6e7.1613659844.git.bnemeth@redhat.com>
 <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2cc06597-8005-7be8-4094-b20f525afde8@redhat.com>
Date: Fri, 19 Feb 2021 16:51:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Network Development <netdev@vger.kernel.org>,
 David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjEvMi8xOCAxMTo1MCDkuIvljYgsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24g
VGh1LCBGZWIgMTgsIDIwMjEgYXQgMTA6MDEgQU0gQmFsYXpzIE5lbWV0aCA8Ym5lbWV0aEByZWRo
YXQuY29tPiB3cm90ZToKPj4gRm9yIGdzbyBwYWNrZXRzLCB2aXJ0aW9fbmV0X2hkcl9zZXRfcHJv
dG8gc2V0cyB0aGUgcHJvdG9jb2wgKGlmIGl0IGlzbid0Cj4+IHNldCkgYmFzZWQgb24gdGhlIHR5
cGUgaW4gdGhlIHZpcnRpbyBuZXQgaGRyLCBidXQgdGhlIHNrYiBjb3VsZCBjb250YWluCj4+IGFu
eXRoaW5nIHNpbmNlIGl0IGNvdWxkIGNvbWUgZnJvbSBwYWNrZXRfc25kIHRocm91Z2ggYSByYXcg
c29ja2V0LiBJZgo+PiB0aGVyZSBpcyBhIG1pc21hdGNoIGJldHdlZW4gd2hhdCB2aXJ0aW9fbmV0
X2hkcl9zZXRfcHJvdG8gc2V0cyBhbmQKPj4gdGhlIGFjdHVhbCBwcm90b2NvbCwgdGhlbiB0aGUg
c2tiIGNvdWxkIGJlIGhhbmRsZWQgaW5jb3JyZWN0bHkgbGF0ZXIKPj4gb24gYnkgZ3NvLgo+Pgo+
PiBUaGUgbmV0d29yayBoZWFkZXIgb2YgZ3NvIHBhY2tldHMgc3RhcnRzIGF0IDE0IGJ5dGVzLCBi
dXQgYSBzcGVjaWFsbHkKPj4gY3JhZnRlZCBwYWNrZXQgY291bGQgZm9vbCB0aGUgY2FsbCB0byBz
a2JfZmxvd19kaXNzZWN0X2Zsb3dfa2V5c19iYXNpYwo+PiBhcyB0aGUgbmV0d29yayBoZWFkZXIg
b2Zmc2V0IGluIHRoZSBza2IgY291bGQgYmUgaW5jb3JyZWN0Lgo+PiBDb25zZXF1ZW50bHksIEVJ
TlZBTCBpcyBub3QgcmV0dXJuZWQuCj4+Cj4+IFRoZXJlIGFyZSBldmVuIHBhY2tldHMgdGhhdCBj
YW4gY2F1c2UgYW4gaW5maW5pdGUgbG9vcC4gRm9yIGV4YW1wbGUsIGEKPj4gcGFja2V0IHdpdGgg
ZXRoZXJuZXQgdHlwZSBFVEhfUF9NUExTX1VDICh3aGljaCBpcyB1bm5vdGljZWQgYnkKPj4gdmly
dGlvX25ldF9oZHJfdG9fc2tiKSB0aGF0IGlzIHNlbnQgdG8gYSBnZW5ldmUgaW50ZXJmYWNlIHdp
bGwgYmUKPj4gaGFuZGxlZCBieSBnZW5ldmVfYnVpbGRfc2tiLiBJbiB0dXJuLCBpdCBjYWxscwo+
PiB1ZHBfdHVubmVsX2hhbmRsZV9vZmZsb2FkcyB3aGljaCB0aGVuIGNhbGxzIHNrYl9yZXNldF9p
bm5lcl9oZWFkZXJzLgo+PiBBZnRlciB0aGF0LCB0aGUgcGFja2V0IGdldHMgcGFzc2VkIHRvIG1w
bHNfZ3NvX3NlZ21lbnQuIFRoYXQgZnVuY3Rpb24KPj4gY2FsY3VsYXRlcyB0aGUgbXBscyBoZWFk
ZXIgbGVuZ3RoIGJ5IHRha2luZyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuCj4+IG5ldHdvcmtfaGVh
ZGVyIGFuZCBpbm5lcl9uZXR3b3JrX2hlYWRlci4gU2luY2UgdGhlIHR3byBhcmUgZXF1YWwKPj4g
KGR1ZSB0byB0aGUgZWFybGllciBjYWxsIHRvIHNrYl9yZXNldF9pbm5lcl9oZWFkZXJzKSwgaXQg
d2lsbCBjYWxjdWxhdGUKPj4gYSBoZWFkZXIgb2YgbGVuZ3RoIDAsIGFuZCBpdCB3aWxsIG5vdCBw
dWxsIGFueSBoZWFkZXJzLiBUaGVuLCBpdCB3aWxsCj4+IGNhbGwgc2tiX21hY19nc29fc2VnbWVu
dCB3aGljaCB3aWxsIGFnYWluIGNhbGwgbXBsc19nc29fc2VnbWVudCwgZXRjLi4uCj4+IFRoaXMg
bGVhZHMgdG8gdGhlIGluZmluaXRlIGxvb3AuCgoKSSByZW1lbWJlciBrZXJuZWwgd2lsbCB2YWxp
ZGF0ZSBkb2RneSBnc28gcGFja2V0cyBpbiBnc28gb3BzLiBJIHdvbmRlciAKd2h5IG5vdCBkbyB0
aGUgY2hlY2sgdGhlcmU/IFRoZSByZWFzb24gaXMgdGhhdCB2aXJ0aW8vVFVOIGlzIG5vdCB0aGUg
Cm9ubHkgc291cmNlIGZvciB0aG9zZSBwYWNrZXRzLgoKVGhhbmtzCgoKPj4KPj4gRm9yIHRoYXQg
cmVhc29uLCBhZGRyZXNzIHRoZSByb290IGNhdXNlIG9mIHRoZSBpc3N1ZTogZG9uJ3QgYmxpbmRs
eQo+PiB0cnVzdCB0aGUgaW5mb3JtYXRpb24gcHJvdmlkZWQgYnkgdGhlIHZpcnRpbyBuZXQgaGVh
ZGVyLiBJbnN0ZWFkLAo+PiBjaGVjayBpZiB0aGUgcHJvdG9jb2wgaW4gdGhlIHBhY2tldCBhY3R1
YWxseSBtYXRjaGVzIHRoZSBwcm90b2NvbCBzZXQgYnkKPj4gdmlydGlvX25ldF9oZHJfc2V0X3By
b3RvLgo+Pgo+PiBGaXhlczogOTI3NDEyNGYwMjNiICgibmV0OiBzdHJpY3RlciB2YWxpZGF0aW9u
IG9mIHVudHJ1c3RlZCBnc28gcGFja2V0cyIpCj4+IFNpZ25lZC1vZmYtYnk6IEJhbGF6cyBOZW1l
dGggPGJuZW1ldGhAcmVkaGF0LmNvbT4KPj4gLS0tCj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9f
bmV0LmggfCA3ICsrKysrKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQu
aCBiL2luY2x1ZGUvbGludXgvdmlydGlvX25ldC5oCj4+IGluZGV4IGU4YTkyNGVlZWEzZC4uY2Yy
YzUzNTYzZjIyIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpb19uZXQuaAo+PiBAQCAtNzksOCArNzksMTMgQEAgc3Rh
dGljIGlubGluZSBpbnQgdmlydGlvX25ldF9oZHJfdG9fc2tiKHN0cnVjdCBza19idWZmICpza2Is
Cj4+ICAgICAgICAgICAgICAgICAgaWYgKGdzb190eXBlICYmIHNrYi0+bmV0d29ya19oZWFkZXIp
IHsKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBmbG93X2tleXNfYmFzaWMga2V5
czsKPj4KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFza2ItPnByb3RvY29sKQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICBpZiAoIXNrYi0+cHJvdG9jb2wpIHsKPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3QgZXRoaGRyICpldGggPSBza2JfZXRo
X2hkcihza2IpOwo+PiArCj4gVW5mb3J0dW5hdGVseSwgY2Fubm90IGFzc3VtZSB0aGF0IHRoZSBk
ZXZpY2UgdHlwZSBpcyBBUlBIUkRfRVRIRVIuCj4KPiBUaGUgdW5kZXJseWluZyBhcHByb2FjaCBp
cyBzb3VuZDogcGFja2V0cyB0aGF0IGhhdmUgYSBnc28gdHlwZSBzZXQgaW4KPiB0aGUgdmlydGlv
X25ldF9oZHIgaGF2ZSB0byBiZSBJUCBwYWNrZXRzLgo+Cj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZpcnRpb19uZXRfaGRyX3NldF9wcm90byhza2IsIGhkcik7Cj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNrYi0+cHJvdG9jb2wgIT0gZXRoLT5oX3By
b3RvKQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPj4gICByZXRyeToKPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICghc2tiX2Zsb3dfZGlzc2VjdF9mbG93X2tleXNfYmFzaWMo
TlVMTCwgc2tiLCAma2V5cywKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgMCwgMCwgMCwKPj4gLS0KPj4gMi4yOS4y
Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=

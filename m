Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC77C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:27:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2953601FD
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2953601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A08B8618D;
	Tue,  9 Feb 2021 03:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yd7C7NwP5MfG; Tue,  9 Feb 2021 03:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 981A886054;
	Tue,  9 Feb 2021 03:27:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 792ADC0174;
	Tue,  9 Feb 2021 03:27:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7F58C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9B8B686BDB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jJMSGbyYWPwq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AE91686B96
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612841235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caTHZTenmPQKadGbUAGyUsIA4p8IzVJtUSrJaDPU17o=;
 b=JFHg4qHJHxu+HHdzt1fJfgHbssqrju6JxRzgsr5d32DoC5z/WS+lU0KRtQ8x8H9lLrChiD
 Ltq/LKLxi6nBuukUz8q8UxPplKNV01lYJWbwTxvjIELX++8W3cOWdldxYLfbXaxAQILk8Q
 gYweut9HSAHJNV/4/MGe69AJ5IZx1iM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-GCB9qVSGPHG1msTW-0rOBQ-1; Mon, 08 Feb 2021 22:27:10 -0500
X-MC-Unique: GCB9qVSGPHG1msTW-0rOBQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85AF3192D785;
 Tue,  9 Feb 2021 03:27:09 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D3D960C5B;
 Tue,  9 Feb 2021 03:27:06 +0000 (UTC)
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20210129002136.70865-1-weiwan@google.com>
 <a0b2cb8d-eb8f-30fb-2a22-678e6dd2f58f@redhat.com>
 <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
 <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
 <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
 <9b0b8f2a-8476-697e-9002-e9947e3eab63@redhat.com>
 <CA+FuTScVOuoHKtrdrRFswjA3Zq1-7sgMVhnP2iMB5sYFFS8NFg@mail.gmail.com>
 <50ae0b71-df87-f26c-8b4d-8035f9f6a58d@redhat.com>
 <CAF=yD-J5-60D=JDwvpecjaO6J03SZHoHJyCsR3B1HbP1-jbqng@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <00de1b0f-f2aa-de54-9c7e-472643400417@redhat.com>
Date: Tue, 9 Feb 2021 11:27:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAF=yD-J5-60D=JDwvpecjaO6J03SZHoHJyCsR3B1HbP1-jbqng@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: Network Development <netdev@vger.kernel.org>, Wei Wang <weiwan@google.com>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
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

Ck9uIDIwMjEvMi85IOS4iuWNiDM6MDgsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gT24gU3Vu
LCBGZWIgNywgMjAyMSBhdCAxMDoyOSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPj4KPj4gT24gMjAyMS8yLzUg5LiK5Y2INDo1MCwgV2lsbGVtIGRlIEJydWlqbiB3
cm90ZToKPj4+IE9uIFdlZCwgRmViIDMsIDIwMjEgYXQgMTA6MDYgUE0gSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4gT24gMjAyMS8yLzQg5LiK5Y2IMjoyOCwgV2ls
bGVtIGRlIEJydWlqbiB3cm90ZToKPj4+Pj4gT24gV2VkLCBGZWIgMywgMjAyMSBhdCAxMjozMyBB
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IE9uIDIwMjEv
Mi8yIOS4i+WNiDEwOjM3LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+Pj4+Pj4+IE9uIE1vbiwg
RmViIDEsIDIwMjEgYXQgMTA6MDkgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+Pj4+Pj4+IE9uIDIwMjEvMS8yOSDkuIrljYg4OjIxLCBXZWkgV2FuZyB3cm90ZToK
Pj4+Pj4+Pj4+IFdpdGggdGhlIGltcGxlbWVudGF0aW9uIG9mIG5hcGktdHggaW4gdmlydGlvIGRy
aXZlciwgd2UgY2xlYW4gdHgKPj4+Pj4+Pj4+IGRlc2NyaXB0b3JzIGZyb20gcnggbmFwaSBoYW5k
bGVyLCBmb3IgdGhlIHB1cnBvc2Ugb2YgcmVkdWNpbmcgdHgKPj4+Pj4+Pj4+IGNvbXBsZXRlIGlu
dGVycnVwdHMuIEJ1dCB0aGlzIGNvdWxkIGludHJvZHVjZSBhIHJhY2Ugd2hlcmUgdHggY29tcGxl
dGUKPj4+Pj4+Pj4+IGludGVycnVwdCBoYXMgYmVlbiByYWlzZWQsIGJ1dCB0aGUgaGFuZGxlciBm
b3VuZCB0aGVyZSBpcyBubyB3b3JrIHRvIGRvCj4+Pj4+Pj4+PiBiZWNhdXNlIHdlIGhhdmUgZG9u
ZSB0aGUgd29yayBpbiB0aGUgcHJldmlvdXMgcnggaW50ZXJydXB0IGhhbmRsZXIuCj4+Pj4+Pj4+
PiBUaGlzIGNvdWxkIGxlYWQgdG8gdGhlIGZvbGxvd2luZyB3YXJuaW5nIG1zZzoKPj4+Pj4+Pj4+
IFsgMzU4OC4wMTA3NzhdIGlycSAzODogbm9ib2R5IGNhcmVkICh0cnkgYm9vdGluZyB3aXRoIHRo
ZQo+Pj4+Pj4+Pj4gImlycXBvbGwiIG9wdGlvbikKPj4+Pj4+Pj4+IFsgMzU4OC4wMTc5MzhdIENQ
VTogNCBQSUQ6IDAgQ29tbTogc3dhcHBlci80IE5vdCB0YWludGVkCj4+Pj4+Pj4+PiA1LjMuMC0x
OS1nZW5lcmljICMyMH4xOC4wNC4yLVVidW50dQo+Pj4+Pj4+Pj4gWyAzNTg4LjAxNzk0MF0gQ2Fs
bCBUcmFjZToKPj4+Pj4+Pj4+IFsgMzU4OC4wMTc5NDJdICA8SVJRPgo+Pj4+Pj4+Pj4gWyAzNTg4
LjAxNzk1MV0gIGR1bXBfc3RhY2srMHg2My8weDg1Cj4+Pj4+Pj4+PiBbIDM1ODguMDE3OTUzXSAg
X19yZXBvcnRfYmFkX2lycSsweDM1LzB4YzAKPj4+Pj4+Pj4+IFsgMzU4OC4wMTc5NTVdICBub3Rl
X2ludGVycnVwdCsweDI0Yi8weDJhMAo+Pj4+Pj4+Pj4gWyAzNTg4LjAxNzk1Nl0gIGhhbmRsZV9p
cnFfZXZlbnRfcGVyY3B1KzB4NTQvMHg4MAo+Pj4+Pj4+Pj4gWyAzNTg4LjAxNzk1N10gIGhhbmRs
ZV9pcnFfZXZlbnQrMHgzYi8weDYwCj4+Pj4+Pj4+PiBbIDM1ODguMDE3OTU4XSAgaGFuZGxlX2Vk
Z2VfaXJxKzB4ODMvMHgxYTAKPj4+Pj4+Pj4+IFsgMzU4OC4wMTc5NjFdICBoYW5kbGVfaXJxKzB4
MjAvMHgzMAo+Pj4+Pj4+Pj4gWyAzNTg4LjAxNzk2NF0gIGRvX0lSUSsweDUwLzB4ZTAKPj4+Pj4+
Pj4+IFsgMzU4OC4wMTc5NjZdICBjb21tb25faW50ZXJydXB0KzB4Zi8weGYKPj4+Pj4+Pj4+IFsg
MzU4OC4wMTc5NjZdICA8L0lSUT4KPj4+Pj4+Pj4+IFsgMzU4OC4wMTc5ODldIGhhbmRsZXJzOgo+
Pj4+Pj4+Pj4gWyAzNTg4LjAyMDM3NF0gWzwwMDAwMDAwMDFiOWYxZGE4Pl0gdnJpbmdfaW50ZXJy
dXB0Cj4+Pj4+Pj4+PiBbIDM1ODguMDI1MDk5XSBEaXNhYmxpbmcgSVJRICMzOAo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIG5ldyBwYXJhbSB0byBzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlLCBhbmQgd2Ugc2V0IGl0IGZvcgo+Pj4+Pj4+Pj4gdHggdmlydHF1ZXVlcyBpZiBuYXBp
LXR4IGlzIGVuYWJsZWQsIHRvIHN1cHByZXNzIHRoZSB3YXJuaW5nIGluIHN1Y2gKPj4+Pj4+Pj4+
IGNhc2UuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gRml4ZXM6IDdiMDQxMWVmNGFhNiAoInZpcnRpby1u
ZXQ6IGNsZWFuIHR4IGRlc2NyaXB0b3JzIGZyb20gcnggbmFwaSIpCj4+Pj4+Pj4+PiBSZXBvcnRl
ZC1ieTogUmljayBKb25lcyA8am9uZXNyaWNrQGdvb2dsZS5jb20+Cj4+Pj4+Pj4+PiBTaWduZWQt
b2ZmLWJ5OiBXZWkgV2FuZyA8d2Vpd2FuQGdvb2dsZS5jb20+Cj4+Pj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBXaWxsZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdvb2dsZS5jb20+Cj4+Pj4+Pj4+IFBsZWFz
ZSB1c2UgZ2V0X21haW50YWluZXIucGwgdG8gbWFrZSBzdXJlIE1pY2hhZWwgYW5kIG1lIHdlcmUg
Y2NlZC4KPj4+Pj4+PiBXaWxsIGRvLiBTb3JyeSBhYm91dCB0aGF0LiBJIHN1Z2dlc3RlZCBqdXN0
IHRoZSB2aXJ0dWFsaXphdGlvbiBsaXN0LCBteSBiYWQuCj4+Pj4+Pj4KPj4+Pj4+Pj4+IC0tLQo+
Pj4+Pj4+Pj4gICAgICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgICB8IDE5ICsrKysrKysr
KysrKysrLS0tLS0KPj4+Pj4+Pj4+ICAgICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMg
fCAxNiArKysrKysrKysrKysrKysrCj4+Pj4+Pj4+PiAgICAgICBpbmNsdWRlL2xpbnV4L3ZpcnRp
by5oICAgICAgIHwgIDIgKysKPj4+Pj4+Pj4+ICAgICAgIDMgZmlsZXMgY2hhbmdlZCwgMzIgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+
Pj4+Pj4+PiBpbmRleCA1MDg0MDhmYmU3OGYuLmU5YTNmMzA4NjRlOCAxMDA2NDQKPj4+Pj4+Pj4+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4+Pj4+Pj4+PiBAQCAtMTMwMywxMyArMTMwMywyMiBAQCBzdGF0aWMg
dm9pZCB2aXJ0bmV0X25hcGlfdHhfZW5hYmxlKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+Pj4+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuOwo+Pj4+Pj4+Pj4gICAgICAgICAgIH0KPj4+
Pj4+Pj4+Cj4+Pj4+Pj4+PiArICAgICAvKiBXaXRoIG5hcGlfdHggZW5hYmxlZCwgZnJlZV9vbGRf
eG1pdF9za2JzKCkgY291bGQgYmUgY2FsbGVkIGZyb20KPj4+Pj4+Pj4+ICsgICAgICAqIHJ4IG5h
cGkgaGFuZGxlci4gU2V0IHdvcmtfc3RlYWwgdG8gc3VwcHJlc3MgYmFkIGlycSB3YXJuaW5nIGZv
cgo+Pj4+Pj4+Pj4gKyAgICAgICogSVJRX05PTkUgY2FzZSBmcm9tIHR4IGNvbXBsZXRlIGludGVy
cnVwdCBoYW5kbGVyLgo+Pj4+Pj4+Pj4gKyAgICAgICovCj4+Pj4+Pj4+PiArICAgICB2aXJ0cXVl
dWVfc2V0X3dvcmtfc3RlYWwodnEsIHRydWUpOwo+Pj4+Pj4+Pj4gKwo+Pj4+Pj4+Pj4gICAgICAg
ICAgIHJldHVybiB2aXJ0bmV0X25hcGlfZW5hYmxlKHZxLCBuYXBpKTsKPj4+Pj4+Pj4gRG8gd2Ug
bmVlZCB0byBmb3JjZSB0aGUgb3JkZXJpbmcgYmV0d2VlbiBzdGVhbCBzZXQgYW5kIG5hcGkgZW5h
YmxlPwo+Pj4+Pj4+IFRoZSB3YXJuaW5nIG9ubHkgb2NjdXJzIGFmdGVyIG9uZSBodW5kcmVkIHNw
dXJpb3VzIGludGVycnVwdHMsIHNvIG5vdAo+Pj4+Pj4+IHJlYWxseS4KPj4+Pj4+IE9rLCBzbyBp
dCBsb29rcyBsaWtlIGEgaGludC4gVGhlbiBJIHdvbmRlciBob3cgbXVjaCB2YWx1ZSBkbyB3ZSBu
ZWVkIHRvCj4+Pj4+PiBpbnRyb2R1Y2UgaGVscGVyIGxpa2UgdmlydHF1ZXVlX3NldF93b3JrX3N0
ZWFsKCkgdGhhdCBhbGxvd3MgdGhlIGNhbGxlcgo+Pj4+Pj4gdG8gdG9nZ2xlLiBIb3cgYWJvdXQg
ZGlzYWJsZSB0aGUgY2hlY2sgZm9yZXZlciBkdXJpbmcgdmlydHF1ZXVlCj4+Pj4+PiBpbml0aWFs
aXphdGlvbj8KPj4+Pj4gWWVzLCB0aGF0IGlzIGV2ZW4gc2ltcGxlci4KPj4+Pj4KPj4+Pj4gV2Ug
c3RpbGwgbmVlZCB0aGUgaGVscGVyLCBhcyB0aGUgaW50ZXJuYWwgdmFyaWFibGVzIG9mIHZyaW5n
X3ZpcnRxdWV1ZQo+Pj4+PiBhcmUgbm90IGFjY2Vzc2libGUgZnJvbSB2aXJ0aW8tbmV0LiBBbiBl
YXJsaWVyIHBhdGNoIGFkZGVkIHRoZQo+Pj4+PiB2YXJpYWJsZSB0byB2aXJ0cXVldWUgaXRzZWxm
LCBidXQgSSB0aGluayBpdCBiZWxvbmdzIGluCj4+Pj4+IHZyaW5nX3ZpcnRxdWV1ZS4gQW5kIHRo
ZSBoZWxwZXIgaXMgbm90IGEgbG90IG9mIGNvZGUuCj4+Pj4gSXQncyBiZXR0ZXIgdG8gZG8gdGhp
cyBiZWZvcmUgdGhlIGFsbG9jYXRpbmcgdGhlIGlycS4gQnV0IGl0IGxvb2tzIG5vdAo+Pj4+IGVh
c3kgdW5sZXNzIHdlIGV4dGVuZCBmaW5kX3ZxcygpLgo+Pj4gQ2FuIHlvdSBlbGFib3JhdGUgd2h5
IHRoYXQgaXMgYmV0dGVyPyBBdCB2aXJ0bmV0X29wZW4gdGhlIGludGVycnVwdHMKPj4+IGFyZSBu
b3QgZmlyaW5nIGVpdGhlci4KPj4KPj4gSSB0aGluayB5b3UgbWVhbnQgTkFQSSBhY3R1YWxseT8K
PiBJIG1lYW50IGludGVycnVwdDogd2UgZG9uJ3QgaGF2ZSB0byB3b3JyeSBhYm91dCB0aGUgc3B1
cmlvdXMgaW50ZXJydXB0Cj4gd2FybmluZyB3aGVuIG5vIGludGVycnVwdHMgd2lsbCBiZSBmaXJp
bmcuIFVudGlsIHZpcnRuZXRfb3Blbgo+IGNvbXBsZXRlcywgdGhlIGRldmljZSBpcyBkb3duLgoK
Ck9rLgoKCj4KPgo+Pj4gSSBoYXZlIG5vIHByZWZlcmVuY2UuIEp1c3QgY3VyaW91cywgZXNwZWNp
YWxseSBpZiBpdCBjb21wbGljYXRlcyB0aGUgcGF0Y2guCj4+Pgo+PiBNeSB1bmRlcnN0YW5kaW5n
IGlzIHRoYXQuIEl0J3MgcHJvYmFibHkgb2sgZm9yIG5ldC4gQnV0IHdlIHByb2JhYmx5IG5lZWQK
Pj4gdG8gZG9jdW1lbnQgdGhlIGFzc3VtcHRpb25zIHRvIG1ha2Ugc3VyZSBpdCB3YXMgbm90IGFi
dXNlZCBpbiBvdGhlciBkcml2ZXJzLgo+Pgo+PiBJbnRyb2R1Y2UgbmV3IHBhcmFtZXRlcnMgZm9y
IGZpbmRfdnFzKCkgY2FuIGhlbHAgdG8gZWxpbWluYXRlIHRoZSBzdWJ0bGUKPj4gc3R1ZmZzIGJ1
dCBJIGFncmVlIGl0IGxvb2tzIGxpa2UgYSBvdmVya2lsbC4KPj4KPj4gKEJ0dywgSSBmb3JnZXQg
dGhlIG51bWJlcnMgYnV0IHdvbmRlciBob3cgbXVjaCBkaWZmZXJlbmNlIGlmIHdlIHNpbXBsZQo+
PiByZW1vdmUgdGhlIGZyZWVfb2xkX3htaXRzKCkgZnJvbSB0aGUgcnggTkFQSSBwYXRoPykKPiBU
aGUgY29tbWl0dGVkIHBhdGNoc2V0IGRpZCBub3QgcmVjb3JkIHRob3NlIG51bWJlcnMsIGJ1dCBJ
IGZvdW5kIHRoZW0KPiBpbiBhbiBlYXJsaWVyIGl0ZXJhdGlvbjoKPgo+ICAgIFtQQVRDSCBuZXQt
bmV4dCAwLzNdIHZpcnRpby1uZXQgdHggbmFwaQo+ICAgIGh0dHBzOi8vbGlzdHMub3BlbndhbGwu
bmV0L25ldGRldi8yMDE3LzA0LzAyLzU1Cj4KPiBJdCBkaWQgc2VlbSB0byBzaWduaWZpY2FudGx5
IHJlZHVjZSBjb21wdXRlIGN5Y2xlcyAoIkdjeWMiKSBhdCB0aGUKPiB0aW1lLiBGb3IgaW5zdGFu
Y2U6Cj4KPiAgICAgIFRDUF9SUiBMYXRlbmN5ICh1cyk6Cj4gICAgICAxeDoKPiAgICAgICAgcDUw
ICAgICAgICAgICAgICAyNCAgICAgICAyNCAgICAgICAyMQo+ICAgICAgICBwOTkgICAgICAgICAg
ICAgIDI3ICAgICAgIDI3ICAgICAgIDI3Cj4gICAgICAgIEdjeWNsZXMgICAgICAgICAyOTkgICAg
ICA0MzIgICAgICAzMDgKPgo+IEknbSBjb25jZXJuZWQgdGhhdCByZW1vdmluZyBpdCBub3cgbWF5
IGNhdXNlIGEgcmVncmVzc2lvbiByZXBvcnQgaW4gYQo+IGZldyBtb250aHMuIFRoYXQgaXMgaGln
aGVyIHJpc2sgdGhhbiB0aGUgc3B1cmlvdXMgaW50ZXJydXB0IHdhcm5pbmcKPiB0aGF0IHdhcyBv
bmx5IHJlcG9ydGVkIGFmdGVyIHllYXJzIG9mIHVzZS4KCgpSaWdodC4KClNvIGlmIE1pY2hhZWwg
aXMgZmluZSB3aXRoIHRoaXMgYXBwcm9hY2gsIEknbSBvayB3aXRoIGl0LiBCdXQgd2UgCnByb2Jh
Ymx5IG5lZWQgdG8gYSBUT0RPIHRvIGludmVudCB0aGUgaW50ZXJydXB0IGhhbmRsZXJzIHRoYXQg
Y2FuIGJlIAp1c2VkIGZvciBtb3JlIHRoYW4gb25lIHZpcnRxdWV1ZXMuIFdoZW4gTVNJLVggaXMg
ZW5hYmxlZCwgdGhlIGludGVycnVwdCAKaGFuZGxlciAodnJpbmdfaW50ZXJydXAoKSkgYXNzdW1l
cyB0aGUgaW50ZXJydXB0IGlzIHVzZWQgYnkgYSBzaW5nbGUgCnZpcnRxdWV1ZS4KClRoYW5rcwoK
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

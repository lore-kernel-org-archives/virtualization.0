Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D3AC433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Apr 2022 07:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5951D417EF;
	Thu,  7 Apr 2022 07:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3WqrxxaCpd1; Thu,  7 Apr 2022 07:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D024417C3;
	Thu,  7 Apr 2022 07:53:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DCFAC001D;
	Thu,  7 Apr 2022 07:53:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 110DAC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 07:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F035E417C7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 07:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AF0BaWF_bPfe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 07:53:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1BBC417C3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649318011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4oTU89iic44RnYmDXqYjpUYABah6cp5s63eYF96vUY=;
 b=CykZb9ZwgP1C31anQptfueHt00E5yzBJZ1M5VE3Z3xKEwF1AXx9XP1vGqNJH+6mDnWxsvB
 ZONU+qdBvSClYeISbxz5zfeaqmK/jQBBUwKDZ5Gy7oWG6nwkU4IjsgDm+cb+NtqiDxzgPa
 5Ne+dnDv0gdRXz2eTp3e2+jQ/UkWsTI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-S4TBySX0NsuWn9mNFbRhJA-1; Thu, 07 Apr 2022 03:53:22 -0400
X-MC-Unique: S4TBySX0NsuWn9mNFbRhJA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55D733C13948;
 Thu,  7 Apr 2022 07:53:16 +0000 (UTC)
Received: from localhost (unknown [10.39.193.222])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D977C28111;
 Thu,  7 Apr 2022 07:53:02 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 4/5] virtio-pci: implement synchronize_vqs()
In-Reply-To: <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
Organization: Red Hat GmbH
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-5-jasowang@redhat.com>
 <20220406075952-mutt-send-email-mst@kernel.org>
 <87wng2e527.fsf@redhat.com>
 <20220406112858-mutt-send-email-mst@kernel.org>
 <7e99abbf-f68d-4aa5-71b6-9d1d71b2d25b@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date: Thu, 07 Apr 2022 09:52:59 +0200
Message-ID: <87r169ba90.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 tglx@linutronix.de
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

T24gVGh1LCBBcHIgMDcgMjAyMiwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cgo+IOWcqCAyMDIyLzQvNiDkuIvljYgxMTozMSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemB
kzoKPj4gT24gV2VkLCBBcHIgMDYsIDIwMjIgYXQgMDM6MDQ6MzJQTSArMDIwMCwgQ29ybmVsaWEg
SHVjayB3cm90ZToKPj4+IE9uIFdlZCwgQXByIDA2IDIwMjIsICJNaWNoYWVsIFMuIFRzaXJraW4i
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pgo+Pj4+IE9uIFdlZCwgQXByIDA2LCAyMDIyIGF0
IDA0OjM1OjM3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+IFRoaXMgcGF0Y2ggaW1w
bGVtZW50cyBQQ0kgdmVyc2lvbiBvZiBzeW5jaHJvbml6ZV92cXMoKS4KPj4+Pj4KPj4+Pj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+Pj4+PiBDYzogUGV0ZXIgWmlq
bHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgo+Pj4+PiBDYzogIlBhdWwgRS4gTWNLZW5uZXki
IDxwYXVsbWNrQGtlcm5lbC5vcmc+Cj4+Pj4+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwu
b3JnPgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pgo+Pj4+IFBsZWFzZSBhZGQgaW1wbGVtZW50YXRpb25zIGF0IGxlYXN0IGZvciBjY3cgYW5kIG1t
aW8uCj4+PiBJJ20gbm90IHN1cmUgd2hhdCAoaWYgYW55dGhpbmcpIGNhbi9zaG91bGQgYmUgZG9u
ZSBmb3IgY2N3Li4uCj4+Pgo+Pj4+PiAtLS0KPj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2NvbW1vbi5jIHwgMTQgKysrKysrKysrKysrKysKPj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcGNpX2NvbW1vbi5oIHwgIDIgKysKPj4+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cGNpX2xlZ2FjeS5jIHwgIDEgKwo+Pj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9k
ZXJuLmMgfCAgMiArKwo+Pj4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQo+
Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21tb24u
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmMKPj4+Pj4gaW5kZXggZDcyNGY2
NzY2MDhiLi5iNzhjOGJjOTNhOTcgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfY29tbW9uLmMKPj4+Pj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9j
b21tb24uYwo+Pj4+PiBAQCAtMzcsNiArMzcsMjAgQEAgdm9pZCB2cF9zeW5jaHJvbml6ZV92ZWN0
b3JzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+Pj4+PiAgIAkJc3luY2hyb25pemVfaXJx
KHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaSkpOwo+Pj4+PiAgIH0KPj4+Pj4gICAK
Pj4+Pj4gK3ZvaWQgdnBfc3luY2hyb25pemVfdnFzKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+Pj4+PiArewo+Pj4+PiArCXN0cnVjdCB2aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9f
dnBfZGV2aWNlKHZkZXYpOwo+Pj4+PiArCWludCBpOwo+Pj4+PiArCj4+Pj4+ICsJaWYgKHZwX2Rl
di0+aW50eF9lbmFibGVkKSB7Cj4+Pj4+ICsJCXN5bmNocm9uaXplX2lycSh2cF9kZXYtPnBjaV9k
ZXYtPmlycSk7Cj4+Pj4+ICsJCXJldHVybjsKPj4+Pj4gKwl9Cj4+Pj4+ICsKPj4+Pj4gKwlmb3Ig
KGkgPSAwOyBpIDwgdnBfZGV2LT5tc2l4X3ZlY3RvcnM7ICsraSkKPj4+Pj4gKwkJc3luY2hyb25p
emVfaXJxKHBjaV9pcnFfdmVjdG9yKHZwX2Rldi0+cGNpX2RldiwgaSkpOwo+Pj4+PiArfQo+Pj4+
PiArCj4+PiAuLi5naXZlbiB0aGF0IHRoaXMgc2VlbXMgdG8gc3luY2hyb25pemUgdGhyZWFkZWQg
aW50ZXJydXB0IGhhbmRsZXJzPwo+PiBObywgYW55IGhhbmRsZXJzIGF0IGFsbC4gVGhlIHBvaW50
IGlzIHRvIG1ha2Ugc3VyZSBhbnkgbWVtb3J5IGNoYW5nZXMKPj4gbWFkZSBwcmlvciB0byB0aGlz
IG9wIGFyZSB2aXNpYmxlIHRvIGNhbGxiYWNrcy4KPj4KPj4gSmFzb24sIG1heWJlIGFkZCB0aGF0
IHRvIHRoZSBkb2N1bWVudGF0aW9uPwo+Cj4KPiBTdXJlLgo+Cj4KPj4KPj4+IEhhbGlsLCBkbyB5
b3UgdGhpbmsgY2N3IG5lZWRzIHRvIGRvIGFueXRoaW5nPyAoQUZBSUNTLCB3ZSBvbmx5IGhhdmUg
b25lCj4+PiAnaXJxJyBmb3IgY2hhbm5lbCBkZXZpY2VzIGFueXdheSwgYW5kIHRoZSBoYW5kbGVy
IGp1c3QgY2FsbHMgdGhlCj4+PiByZWxldmFudCBjYWxsYmFja3MgZGlyZWN0bHkuKQo+PiBUaGVu
IHlvdSBuZWVkIHRvIHN5bmNocm9uaXplIHdpdGggdGhhdC4KPgo+Cj4gSGF2ZSBhIHF1aWNrIGds
YW5jZSBhdCB0aGUgY29kZXMsIGl0IGxvb2tzIHRvIG1lIHdlIGNhbiBzeW5jaHJvbml6ZSB3aXRo
IAo+IHRoZSBJT19JTlRFUlJVUFQuIChBc3N1bWluZyBhbGwgY2FsbGJhY2tzIGFyZSB0cmlnZ2Vy
ZWQgdmlhIAo+IGNjd19kZXZpY2VfaXJxKCkpLgoKTm90IHF1aXRlLCBhZGFwdGVyIGludGVycnVw
dHMgYXJlIGRldmljZS1pbmRlcGVuZGVudCwgYnV0IHRoZXkgYXJlCnJlbGV2YW50IGZvciB2cmlu
ZyBpbnRlcnJ1cHRzLgoKVGhhdCB3b3VsZCBtZWFuIHRoYXQgd2Ugd291bGQgbmVlZCB0byBzeW5j
aHJvbml6ZSBfYWxsXyBjaGFubmVsIEkvTwppbnRlcnJ1cHRzLCB3aGljaCBsb29rcyBsaWtlIGEg
aHVnZSBoYW1tZXIuIEJ1dCBkbyB3ZSByZWFsbHkgbmVlZCB0aGF0CmF0IGFsbD8KClRoZSBsYXN0
IHBhdGNoIGluIHRoaXMgc2VyaWVzIHNlZW1zIHRvIGJlIGNvbmNlcm5lZCB3aXRoIHRoZSAibm8g
dnJpbmcKaW50ZXJydXB0cyBpZiB0aGUgZGV2aWNlIGlzIG5vdCByZWFkeSIgY2FzZSwgc28gaXQg
bmVlZHMgdG8gc3luY2hyb25pemUKdnJpbmcgaW50ZXJydXB0cyB3aXRoIGRldmljZSByZXNldCBh
bmQgc2V0dGluZyB0aGUgZGV2aWNlIHN0YXR1cyB0bwpyZWFkeS4gRm9yIHZpcnRpby1jY3csIGJv
dGggcmVzZXQgYW5kIHNldHRpbmcgdGhlIHN0YXR1cyBhcmUgY2hhbm5lbCBJL08Kb3BlcmF0aW9u
cywgaS5lLiBzdGFydGluZyBhIHByb2dyYW0gYW5kIHdhaXRpbmcgZm9yIHRoZSBmaW5hbCBkZXZp
Y2UKaW50ZXJydXB0IGZvciBpdCwgc28gc3luY2hyb25pemF0aW9uIChvbiBhIGRldmljZSBsZXZl
bCkgaXMgYWxyZWFkeQpoYXBwZW5pbmcgaW4gYSB3YXkuIFNvIEknbSBub3Qgc3VyZSBpZiBhbnkg
ZXh0cmEgc3luY2hyb25pemF0aW9uIGlzCmFjdHVhbGx5IG5lZWRlZCBpbiB0aGlzIGNhc2UsIGJ1
dCBtYXliZSBJJ20gbWlzdW5kZXJzdGFuZGluZy4KCkRvIHlvdSBoYXZlIGZ1cnRoZXIgdXNlIGNh
c2VzIGluIG1pbmQ/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

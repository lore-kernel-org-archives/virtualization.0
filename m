Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCDC64E90
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 03:44:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FF92064C
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 03:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzZLnHTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FF92064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1546E86FCA;
	Tue,  1 Dec 2020 03:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Puc5Y+gRB58E; Tue,  1 Dec 2020 03:44:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4DF4386FBD;
	Tue,  1 Dec 2020 03:44:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B588C0859;
	Tue,  1 Dec 2020 03:44:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3C22C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 03:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B018384E77
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 03:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Syjvzpx1VDmL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 03:44:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 454C984E6B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606794273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8CWW1JLoXpWoDMFBvVdgTwSzj5uqoC7xuW42mruGNxg=;
 b=FzZLnHTeTxZYtXdb2KuF9W+WrBsstVXziWDghnqbGUUt63krJddzMLqQE1YtxAKzJUm9B9
 RQQYZOpnIdqW8DCNxvI2859gnNbwuVXF4o1F7Q7ITJcnkjrFPgGU7BByHT1IgKIKM3GXm6
 04ByfnySrbE1LVoMlMbXn9jh5ABeZ8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-WoS6MIudNkCiRRcUcqVleA-1; Mon, 30 Nov 2020 22:44:31 -0500
X-MC-Unique: WoS6MIudNkCiRRcUcqVleA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 329B1817B9F;
 Tue,  1 Dec 2020 03:44:30 +0000 (UTC)
Received: from [10.72.13.167] (ovpn-13-167.pek2.redhat.com [10.72.13.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 407755C1A3;
 Tue,  1 Dec 2020 03:44:21 +0000 (UTC)
Subject: Re: [PATCH v2 12/17] vdpa_sim: add get_config callback in
 vdpasim_dev_attr
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-13-sgarzare@redhat.com>
 <f8106986-e19d-ea32-436c-14cddd2b6ff4@redhat.com>
 <20201130141453.jobe76loyfy4qrdw@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c2158059-6509-7702-f52a-e497ce899293@redhat.com>
Date: Tue, 1 Dec 2020 11:44:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201130141453.jobe76loyfy4qrdw@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjAvMTEvMzAg5LiL5Y2IMTA6MTQsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBP
biBNb24sIE5vdiAzMCwgMjAyMCBhdCAxMToyNTozMUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pgo+PiBPbiAyMDIwLzExLzI2IOS4i+WNiDEwOjQ5LCBTdGVmYW5vIEdhcnphcmVsbGEgd3Jv
dGU6Cj4+PiBUaGUgZ2V0X2NvbmZpZyBjYWxsYmFjayBjYW4gYmUgdXNlZCBieSB0aGUgZGV2aWNl
IHRvIGZpbGwgdGhlCj4+PiBjb25maWcgc3RydWN0dXJlLgo+Pj4gVGhlIGNhbGxiYWNrIHdpbGwg
YmUgaW52b2tlZCBpbiB2ZHBhc2ltX2dldF9jb25maWcoKSBiZWZvcmUgY29weWluZwo+Pj4gYnl0
ZXMgaW50byBjYWxsZXIgYnVmZmVyLgo+Pj4KPj4+IE1vdmUgdkRQQS1uZXQgY29uZmlnIHVwZGF0
ZXMgZnJvbSB2ZHBhc2ltX3NldF9mZWF0dXJlcygpIGluIHRoZQo+Pj4gbmV3IHZkcGFzaW1fbmV0
X2dldF9jb25maWcoKSBjYWxsYmFjay4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdh
cnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+IMKgZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCAzMyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQo+Pj4gwqAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
Cj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIAo+
Pj4gYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+Pj4gaW5kZXggYzA3ZGRmNmFm
NzIwLi44Yjg3Y2UwNDg1YjYgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj4+
IEBAIC01OCw2ICs1OCw4IEBAIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSB7Cj4+PiDCoCNkZWZp
bmUgVkRQQVNJTV9ORVRfRkVBVFVSRVPCoMKgwqAgKFZEUEFTSU1fRkVBVFVSRVMgfCBcCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxMIDw8IFZJUlRJT19ORVRfRl9N
QUMpKQo+Pj4gK3N0cnVjdCB2ZHBhc2ltOwo+Pj4gKwo+Pj4gwqBzdHJ1Y3QgdmRwYXNpbV9kZXZf
YXR0ciB7Cj4+PiDCoMKgwqDCoCB1NjQgc3VwcG9ydGVkX2ZlYXR1cmVzOwo+Pj4gwqDCoMKgwqAg
c2l6ZV90IGNvbmZpZ19zaXplOwo+Pj4gQEAgLTY1LDYgKzY3LDcgQEAgc3RydWN0IHZkcGFzaW1f
ZGV2X2F0dHIgewo+Pj4gwqDCoMKgwqAgdTMyIGlkOwo+Pj4gwqDCoMKgwqAgd29ya19mdW5jX3Qg
d29ya19mbjsKPj4+ICvCoMKgwqAgdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2
ZHBhc2ltLCB2b2lkICpjb25maWcpOwo+Pj4gwqB9Owo+Pj4gwqAvKiBTdGF0ZSBvZiBlYWNoIHZk
cGFzaW0gZGV2aWNlICovCj4+PiBAQCAtNTIwLDggKzUyMyw2IEBAIHN0YXRpYyB1NjQgdmRwYXNp
bV9nZXRfZmVhdHVyZXMoc3RydWN0IAo+Pj4gdmRwYV9kZXZpY2UgKnZkcGEpCj4+PiDCoHN0YXRp
YyBpbnQgdmRwYXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQg
Cj4+PiBmZWF0dXJlcykKPj4+IMKgewo+Pj4gwqDCoMKgwqAgc3RydWN0IHZkcGFzaW0gKnZkcGFz
aW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPj4+IC3CoMKgwqAgc3RydWN0IHZpcnRpb19uZXRfY29u
ZmlnICpjb25maWcgPQo+Pj4gLcKgwqDCoMKgwqDCoMKgIChzdHJ1Y3QgdmlydGlvX25ldF9jb25m
aWcgKil2ZHBhc2ltLT5jb25maWc7Cj4+PiDCoMKgwqDCoCAvKiBETUEgbWFwcGluZyBtdXN0IGJl
IGRvbmUgYnkgZHJpdmVyICovCj4+PiDCoMKgwqDCoCBpZiAoIShmZWF0dXJlcyAmICgxVUxMIDw8
IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4gQEAgLTUyOSwxNSArNTMwLDYgQEAgc3Rh
dGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgCj4+PiB2ZHBhX2RldmljZSAqdmRw
YSwgdTY0IGZlYXR1cmVzKQo+Pj4gwqDCoMKgwqAgdmRwYXNpbS0+ZmVhdHVyZXMgPSBmZWF0dXJl
cyAmIAo+Pj4gdmRwYXNpbS0+ZGV2X2F0dHIuc3VwcG9ydGVkX2ZlYXR1cmVzOwo+Pj4gLcKgwqDC
oCAvKiBXZSBnZW5lcmFsbHkgb25seSBrbm93IHdoZXRoZXIgZ3Vlc3QgaXMgdXNpbmcgdGhlIGxl
Z2FjeSAKPj4+IGludGVyZmFjZQo+Pj4gLcKgwqDCoMKgICogaGVyZSwgc28gZ2VuZXJhbGx5IHRo
YXQncyB0aGUgZWFybGllc3Qgd2UgY2FuIHNldCBjb25maWcgCj4+PiBmaWVsZHMuCj4+PiAtwqDC
oMKgwqAgKiBOb3RlOiBXZSBhY3R1YWxseSByZXF1aXJlIFZJUlRJT19GX0FDQ0VTU19QTEFURk9S
TSBhYm92ZSB3aGljaAo+Pj4gLcKgwqDCoMKgICogaW1wbGllcyBWSVJUSU9fRl9WRVJTSU9OXzEs
IGJ1dCBsZXQncyBub3QgdHJ5IHRvIGJlIGNsZXZlciAKPj4+IGhlcmUuCj4+PiAtwqDCoMKgwqAg
Ki8KPj4+IC0KPj4+IC3CoMKgwqAgY29uZmlnLT5tdHUgPSBjcHVfdG9fdmRwYXNpbTE2KHZkcGFz
aW0sIDE1MDApOwo+Pj4gLcKgwqDCoCBjb25maWctPnN0YXR1cyA9IGNwdV90b192ZHBhc2ltMTYo
dmRwYXNpbSwgVklSVElPX05FVF9TX0xJTktfVVApOwo+Pj4gLcKgwqDCoCBtZW1jcHkoY29uZmln
LT5tYWMsIG1hY2FkZHJfYnVmLCBFVEhfQUxFTik7Cj4+PiDCoMKgwqDCoCByZXR1cm4gMDsKPj4+
IMKgfQo+Pj4gQEAgLTU5Myw4ICs1ODUsMTIgQEAgc3RhdGljIHZvaWQgdmRwYXNpbV9nZXRfY29u
ZmlnKHN0cnVjdCAKPj4+IHZkcGFfZGV2aWNlICp2ZHBhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+
Pj4gwqB7Cj4+PiDCoMKgwqDCoCBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSA9IHZkcGFfdG9fc2lt
KHZkcGEpOwo+Pj4gLcKgwqDCoCBpZiAob2Zmc2V0ICsgbGVuIDwgdmRwYXNpbS0+ZGV2X2F0dHIu
Y29uZmlnX3NpemUpCj4+PiAtwqDCoMKgwqDCoMKgwqAgbWVtY3B5KGJ1ZiwgdmRwYXNpbS0+Y29u
ZmlnICsgb2Zmc2V0LCBsZW4pOwo+Pj4gK8KgwqDCoCBpZiAob2Zmc2V0ICsgbGVuID4gdmRwYXNp
bS0+ZGV2X2F0dHIuY29uZmlnX3NpemUpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4g
Kwo+Pj4gK8KgwqDCoCB2ZHBhc2ltLT5kZXZfYXR0ci5nZXRfY29uZmlnKHZkcGFzaW0sIHZkcGFz
aW0tPmNvbmZpZyk7Cj4+PiArCj4+PiArwqDCoMKgIG1lbWNweShidWYsIHZkcGFzaW0tPmNvbmZp
ZyArIG9mZnNldCwgbGVuKTsKPj4+IMKgfQo+Pgo+Pgo+PiBJIHdvbmRlciBob3cgbXVjaCB2YWx1
ZSB3ZSBjYW4gZ2V0IGZyb20gdmRwYXNpbS0+Y29uZmlnIGNvbnNpZGVyIAo+PiB3ZSd2ZSBhbHJl
YWR5IGhhZCBnZXRfY29uZmlnKCkgbWV0aG9kLgo+Pgo+PiBJcyBpdCBwb3NzaWJsZSB0byBjb3B5
IHRvIHRoZSBidWZmZXIgZGlyZWN0bHkgaGVyZT8KPgo+IEkgaGFkIHRob3VnaHQgb2YgZWxpbWlu
YXRpbmcgaXQgdG9vLCBidXQgdGhlbiBJIHdhbnRlZCB0byBkbyBzb21ldGhpbmcgCj4gc2ltaWxh
ciB0byB3aGF0IHdlIGRvIGluIFFFTVUgKGh3L3ZpcnRpby92aXJ0aW8uYyksIGxlYXZpbmcgaW4g
dGhlIAo+IHNpbXVsYXRvciBjb3JlIHRoZSBidWZmZXIsIHRoZSBtZW1vcnkgY29weSAoaGFuZGxp
bmcgb2Zmc2V0IGFuZCBsZW4pLCAKPiBhbmQgdGhlIGJvdW5kYXJ5IGNoZWNrcy4KPgo+IEluIHRo
aXMgd2F5IGVhY2ggZGV2aWNlIHNob3VsZCBzaW1wbHkgZmlsbCB0aGUgZW50aXJlIGNvbmZpZ3Vy
YXRpb24gCj4gYW5kIHdlIGNhbiBhdm9pZCBjb2RlIGR1cGxpY2F0aW9uLgo+Cj4gU3RvcmluZyB0
aGUgY29uZmlndXJhdGlvbiBpbiB0aGUgY29yZSBtYXkgYWxzbyBiZSB1c2VmdWwgaWYgc29tZSAK
PiBkZXZpY2UgbmVlZHMgdG8gc3VwcG9ydCBjb25maWcgd3JpdGVzLgoKCkkgdGhpbmsgaW4gdGhh
dCB3YXkgd2UgbmVlZCBzaG91bGQgcHJvdmlkZSBjb25maWdfd3JpdGUoKS4KCgo+Cj4gRG8geW91
IHRoaW5rIGl0IG1ha2VzIHNlbnNlLCBvciBpcyBpdCBiZXR0ZXIgdG8gbW92ZSBldmVyeXRoaW5n
IGluIHRoZSAKPiBkZXZpY2U/CgoKSSBwcmVmZXIgdG8gZG8gdGhhdCBpbiB0aGUgZGV2aWNlIGJ1
dCBpdCdzIGFsc28gZmluZSBrZWVwIHdoYXQgdGhlIHBhdGNoIApoYXMgZG9uZS4KClRoYW5rcwoK
Cj4KPiBUaGFua3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

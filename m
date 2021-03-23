Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325F0C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 02:39:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6107619A9
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 02:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6107619A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8788D607F4;
	Tue, 23 Mar 2021 02:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YAdP2KqAGipI; Tue, 23 Mar 2021 02:39:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19D2760804;
	Tue, 23 Mar 2021 02:39:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFDCDC000A;
	Tue, 23 Mar 2021 02:39:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FDBFC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DD8F40357
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MSlTUKUA23cf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:39:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BF30402FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616467144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VioJuhqdUyJCQVP29PR+eSQQoRfuRxX0mBNikg8J2Ak=;
 b=N37SljRPTa4sBErU7VYDE7kwE6MxIS5k1T8BgDiCjHj0LjD+oX7j7hx8PPM46n/cb4POU0
 1kMsIL4pTwtZ99bAUnXUNgSE01r+0bvAWgwkSZEFaEv632nWbD9JmAop3QNRwrl1basvtk
 fuCRjTsE34UWRYiP4CNws/ynyTkXQGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-6Vei-IDwNMa_H6gVgguhBA-1; Mon, 22 Mar 2021 22:39:02 -0400
X-MC-Unique: 6Vei-IDwNMa_H6gVgguhBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49B171009456;
 Tue, 23 Mar 2021 02:39:01 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-238.pek2.redhat.com
 [10.72.12.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5907760C5F;
 Tue, 23 Mar 2021 02:38:43 +0000 (UTC)
Subject: Re: [PATCH 1/3] virtio_ring: always warn when descriptor chain
 exceeds queue size
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-2-ckuehl@redhat.com>
 <fa4988fa-a671-0abf-f922-6b362faf10d5@redhat.com>
 <20210322041414-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a6eb72e0-50be-1231-f7b5-3ebb822ee1b5@redhat.com>
Date: Tue, 23 Mar 2021 10:38:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210322041414-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
 stefanha@redhat.com, linux-fsdevel@vger.kernel.org, vgoyal@redhat.com
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

CuWcqCAyMDIxLzMvMjIg5LiL5Y2INDoxNywgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBNb24sIE1hciAyMiwgMjAyMSBhdCAxMToyMjoxNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiDlnKggMjAyMS8zLzE4IOS4i+WNiDk6NTIsIENvbm5vciBLdWVobCDlhpnpgZM6Cj4+PiAg
IEZyb20gc2VjdGlvbiAyLjYuNS4zLjEgKERyaXZlciBSZXF1aXJlbWVudHM6IEluZGlyZWN0IERl
c2NyaXB0b3JzKQo+Pj4gb2YgdGhlIHZpcnRpbyBzcGVjOgo+Pj4KPj4+ICAgICAiQSBkcml2ZXIg
TVVTVCBOT1QgY3JlYXRlIGEgZGVzY3JpcHRvciBjaGFpbiBsb25nZXIgdGhhbiB0aGUgUXVldWUK
Pj4+ICAgICBTaXplIG9mIHRoZSBkZXZpY2UuIgo+Pj4KPj4+IFRoaXMgdGV4dCBzdWdnZXN0cyB0
aGF0IHRoZSB3YXJuaW5nIHNob3VsZCB0cmlnZ2VyIGV2ZW4gaWYKPj4+IGluZGlyZWN0IGRlc2Ny
aXB0b3JzIGFyZSBpbiB1c2UuCj4+Cj4+IFNvIEkgdGhpbmsgYXQgbGVhc3QgdGhlIGNvbW1pdCBs
b2cgbmVlZHMgc29tZSB0d2Vhay4KPj4KPj4gRm9yIHNwbGl0IHZpcnRxdWV1ZS4gV2UgaGFkOgo+
Pgo+PiAyLjYuNS4yIERyaXZlciBSZXF1aXJlbWVudHM6IFRoZSBWaXJ0cXVldWUgRGVzY3JpcHRv
ciBUYWJsZQo+Pgo+PiBEcml2ZXJzIE1VU1QgTk9UIGFkZCBhIGRlc2NyaXB0b3IgY2hhaW4gbG9u
Z2VyIHRoYW4gMl4zMiBieXRlcyBpbiB0b3RhbDsKPj4gdGhpcyBpbXBsaWVzIHRoYXQgbG9vcHMg
aW4gdGhlIGRlc2NyaXB0b3IgY2hhaW4gYXJlIGZvcmJpZGRlbiEKPj4KPj4gMi42LjUuMy4xIERy
aXZlciBSZXF1aXJlbWVudHM6IEluZGlyZWN0IERlc2NyaXB0b3JzCj4+Cj4+IEEgZHJpdmVyIE1V
U1QgTk9UIGNyZWF0ZSBhIGRlc2NyaXB0b3IgY2hhaW4gbG9uZ2VyIHRoYW4gdGhlIFF1ZXVlIFNp
emUgb2YKPj4gdGhlIGRldmljZS4KPj4KPj4gSWYgSSB1bmRlcnN0YW5kIHRoZSBzcGVjIGNvcnJl
Y3RseSwgdGhlIGNoZWNrIGlzIG9ubHkgbmVlZGVkIGZvciBhIHNpbmdsZQo+PiBpbmRpcmVjdCBk
ZXNjcmlwdG9yIHRhYmxlPwo+Pgo+PiBGb3IgcGFja2VkIHZpcnRxdWV1ZS4gV2UgaGFkOgo+Pgo+
PiAyLjcuMTcgRHJpdmVyIFJlcXVpcmVtZW50czogU2NhdHRlci1HYXRoZXIgU3VwcG9ydAo+Pgo+
PiBBIGRyaXZlciBNVVNUIE5PVCBjcmVhdGUgYSBkZXNjcmlwdG9yIGxpc3QgbG9uZ2VyIHRoYW4g
YWxsb3dlZCBieSB0aGUKPj4gZGV2aWNlLgo+Pgo+PiBBIGRyaXZlciBNVVNUIE5PVCBjcmVhdGUg
YSBkZXNjcmlwdG9yIGxpc3QgbG9uZ2VyIHRoYW4gdGhlIFF1ZXVlIFNpemUuCj4+Cj4+IDIuNy4x
OSBEcml2ZXIgUmVxdWlyZW1lbnRzOiBJbmRpcmVjdCBEZXNjcmlwdG9ycwo+Pgo+PiBBIGRyaXZl
ciBNVVNUIE5PVCBjcmVhdGUgYSBkZXNjcmlwdG9yIGNoYWluIGxvbmdlciB0aGFuIGFsbG93ZWQg
YnkgdGhlCj4+IGRldmljZS4KPj4KPj4gU28gaXQgbG9va3MgdG8gbWUgdGhlIHBhY2tlZCBwYXJ0
IGlzIGZpbmUuCj4+Cj4+IE5vdGUgdGhhdCBpZiBJIHVuZGVyc3RhbmQgdGhlIHNwZWMgY29ycmVj
dGx5IDIuNy4xNyBpbXBsaWVzIDIuNy4xOS4KPj4KPj4gVGhhbmtzCj4gSXQgd291bGQgYmUgcXVp
dGUgc3RyYW5nZSBmb3IgcGFja2VkIGFuZCBzcGxpdCB0byBkaWZmZXIgaGVyZToKPiBzbyBmb3Ig
cGFja2VkIHdvdWxkIHlvdSBzYXkgdGhlcmUncyBubyBsaW1pdCBvbiAjIG9mIGRlc2NyaXB0b3Jz
IGF0IGFsbD8KPgo+IEkgYW0gZ3Vlc3NpbmcgSSBqdXN0IGZvcmdvdCB0byBtb3ZlIHRoaXMgcGFy
dCBmcm9tCj4gdGhlIGZvcm1hdCBzcGVjaWZpYyB0byB0aGUgY29tbW9uIHBhcnQgb2YgdGhlIHNw
ZWMuCj4KPiBUaGlzIG5lZWRzIGRpc2N1c3Npb24gaW4gdGhlIFRDIG1haWxpbmcgbGlzdCAtIHdh
bnQgdG8gc3RhcnQgYSB0aHJlYWQKPiB0aGVyZT8KCgpXaWxsIGRvLgoKVGhhbmtzCgoKPgo+Cj4K
Pj4+IFJlcG9ydGVkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBDb25ub3IgS3VlaGwgPGNrdWVobEByZWRoYXQuY29tPgo+Pj4gLS0t
Cj4+PiAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNyArKysrLS0tCj4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8v
dmlydGlvX3JpbmcuYwo+Pj4gaW5kZXggNzFlMTZiNTNlOWMxLi4xYmMyOTBmOWJhMTMgMTAwNjQ0
Cj4+PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiBAQCAtNDQ0LDExICs0NDQsMTIgQEAgc3RhdGljIGlu
bGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4+PiAg
ICAJaGVhZCA9IHZxLT5mcmVlX2hlYWQ7Cj4+PiArCVdBUk5fT05fT05DRSh0b3RhbF9zZyA+IHZx
LT5zcGxpdC52cmluZy5udW0pOwo+Pj4gKwo+Pj4gICAgCWlmICh2aXJ0cXVldWVfdXNlX2luZGly
ZWN0KF92cSwgdG90YWxfc2cpKQo+Pj4gICAgCQlkZXNjID0gYWxsb2NfaW5kaXJlY3Rfc3BsaXQo
X3ZxLCB0b3RhbF9zZywgZ2ZwKTsKPj4+ICAgIAllbHNlIHsKPj4+ICAgIAkJZGVzYyA9IE5VTEw7
Cj4+PiAtCQlXQVJOX09OX09OQ0UodG90YWxfc2cgPiB2cS0+c3BsaXQudnJpbmcubnVtICYmICF2
cS0+aW5kaXJlY3QpOwo+Pj4gICAgCX0KPj4+ICAgIAlpZiAoZGVzYykgewo+Pj4gQEAgLTExMTgs
NiArMTExOSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVj
dCB2aXJ0cXVldWUgKl92cSwKPj4+ICAgIAlCVUdfT04odG90YWxfc2cgPT0gMCk7Cj4+PiArCVdB
Uk5fT05fT05DRSh0b3RhbF9zZyA+IHZxLT5wYWNrZWQudnJpbmcubnVtKTsKPj4+ICsKPj4+ICAg
IAlpZiAodmlydHF1ZXVlX3VzZV9pbmRpcmVjdChfdnEsIHRvdGFsX3NnKSkKPj4+ICAgIAkJcmV0
dXJuIHZpcnRxdWV1ZV9hZGRfaW5kaXJlY3RfcGFja2VkKHZxLCBzZ3MsIHRvdGFsX3NnLAo+Pj4g
ICAgCQkJCW91dF9zZ3MsIGluX3NncywgZGF0YSwgZ2ZwKTsKPj4+IEBAIC0xMTI1LDggKzExMjgs
NiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEsCj4+PiAgICAJaGVhZCA9IHZxLT5wYWNrZWQubmV4dF9hdmFpbF9pZHg7Cj4+PiAg
ICAJYXZhaWxfdXNlZF9mbGFncyA9IHZxLT5wYWNrZWQuYXZhaWxfdXNlZF9mbGFnczsKPj4+IC0J
V0FSTl9PTl9PTkNFKHRvdGFsX3NnID4gdnEtPnBhY2tlZC52cmluZy5udW0gJiYgIXZxLT5pbmRp
cmVjdCk7Cj4+PiAtCj4+PiAgICAJZGVzYyA9IHZxLT5wYWNrZWQudnJpbmcuZGVzYzsKPj4+ICAg
IAlpID0gaGVhZDsKPj4+ICAgIAlkZXNjc191c2VkID0gdG90YWxfc2c7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

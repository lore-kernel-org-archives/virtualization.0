Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C03C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9711F81BC6;
	Tue, 21 Mar 2023 15:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9711F81BC6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KMpcwdY0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z1hPyl-3mxzC; Tue, 21 Mar 2023 15:31:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E1ABD81FB8;
	Tue, 21 Mar 2023 15:31:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1ABD81FB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1022C0071;
	Tue, 21 Mar 2023 15:31:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1F06C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86A9B610F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:31:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 86A9B610F7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KMpcwdY0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id niE7G8n-Non8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:31:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3AC76610E8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AC76610E8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679412664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q72wB1AnB+EZXK6jJvM3m9PVX7bBBgcDpGR6RAoFAUA=;
 b=KMpcwdY0Kt7CNc+etJT8TiCf5SaSx+MWoR7oAph4URKiHAr+kUgBOnGKmDslz9qQeCilyn
 jHW7+CCMTTGzbZXMyO76CEKDQp9XuzjxIZcN+ud+5SjiMyIVFonuatw6PaAnPXmT/X07Lp
 emORpVNo0Vo/FkJhabOUqSnwYzhkNcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-NtOcONy6NzGPM3RiV2GI8g-1; Tue, 21 Mar 2023 11:31:01 -0400
X-MC-Unique: NtOcONy6NzGPM3RiV2GI8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A34685531E;
 Tue, 21 Mar 2023 15:31:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 765751410F1C;
 Tue, 21 Mar 2023 15:30:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Viktor Prutyanov <viktor@daynix.com>
Subject: Re: [PATCH v3] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
In-Reply-To: <CAPv0NP6Ep4-B7cMc285E3d3vYjgwO7O1pq5sG3OYYAoZd3EAYQ@mail.gmail.com>
Organization: Red Hat GmbH
References: <20230321134410.2097163-1-viktor@daynix.com>
 <87h6uem9qc.fsf@redhat.com>
 <CAPv0NP6Ep4-B7cMc285E3d3vYjgwO7O1pq5sG3OYYAoZd3EAYQ@mail.gmail.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 21 Mar 2023 16:30:57 +0100
Message-ID: <87bkkmm89a.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, yan@daynix.com
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

T24gVHVlLCBNYXIgMjEgMjAyMywgVmlrdG9yIFBydXR5YW5vdiA8dmlrdG9yQGRheW5peC5jb20+
IHdyb3RlOgoKPiBPbiBUdWUsIE1hciAyMSwgMjAyMyBhdCA1OjU54oCvUE0gQ29ybmVsaWEgSHVj
ayA8Y29odWNrQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiBPbiBUdWUsIE1hciAyMSAyMDIzLCBW
aWt0b3IgUHJ1dHlhbm92IDx2aWt0b3JAZGF5bml4LmNvbT4gd3JvdGU6Cj4+Cj4+ID4gQWNjb3Jk
aW5nIHRvIFZpcnRJTyBzcGVjIHYxLjIsIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1
cmUKPj4gPiBpbmRpY2F0ZXMgdGhhdCB0aGUgZHJpdmVyIHBhc3NlcyBleHRyYSBkYXRhIGFsb25n
IHdpdGggdGhlIHF1ZXVlCj4+ID4gbm90aWZpY2F0aW9ucy4KPj4gPgo+PiA+IEluIGEgc3BsaXQg
cXVldWUgY2FzZSwgdGhlIGV4dHJhIGRhdGEgaXMgMTYtYml0IGF2YWlsYWJsZSBpbmRleC4gSW4g
YQo+PiA+IHBhY2tlZCBxdWV1ZSBjYXNlLCB0aGUgZXh0cmEgZGF0YSBpcyAxLWJpdCB3cmFwIGNv
dW50ZXIgYW5kIDE1LWJpdAo+PiA+IGF2YWlsYWJsZSBpbmRleC4KPj4gPgo+PiA+IEFkZCBzdXBw
b3J0IGZvciB0aGlzIGZlYXR1cmUgZm9yIE1NSU8sIFBDSSBhbmQgY2hhbm5lbCBJL08gdHJhbnNw
b3J0cy4KPj4gPgo+PiA+IFNpZ25lZC1vZmYtYnk6IFZpa3RvciBQcnV0eWFub3YgPHZpa3RvckBk
YXluaXguY29tPgo+PiA+IC0tLQo+PiA+ICB2Mzogc3VwcG9ydCBmZWF0dXJlIGluIHZpcnRpb19j
Y3csIHJlbW92ZSBWTV9OT1RJRlksIHVzZSBhdmFpbF9pZHhfc2hhZG93LAo+PiA+ICAgICByZW1v
dmUgYnl0ZSBzd2FwLCByZW5hbWUgdG8gdnJpbmdfbm90aWZpY2F0aW9uX2RhdGEKPj4gPiAgdjI6
IHJlamVjdCB0aGUgZmVhdHVyZSBpbiB2aXJ0aW9fY2N3LCByZXBsYWNlIF9fbGUzMiB3aXRoIHUz
Mgo+PiA+Cj4+ID4gIGRyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jICAgfCAgNCArKyst
Cj4+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMgICAgICAgfCAxNCArKysrKysrKysr
KysrLQo+PiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgMTAgKysrKysr
KysrKwo+PiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oIHwgIDQgKysrKwo+
PiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDIgKy0KPj4gPiAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYyB8ICAyICstCj4+ID4gIGRyaXZlcnMvdmly
dGlvL3ZpcnRpb19yaW5nLmMgICAgICAgfCAxNyArKysrKysrKysrKysrKysrKwo+PiA+ICBpbmNs
dWRlL2xpbnV4L3ZpcnRpb19yaW5nLmggICAgICAgIHwgIDIgKysKPj4gPiAgaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19jb25maWcuaCB8ICA2ICsrKysrKwo+PiA+ICA5IGZpbGVzIGNoYW5nZWQs
IDU3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+ID4KPj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMgYi9kcml2ZXJzL3MzOTAvdmlydGlvL3Zp
cnRpb19jY3cuYwo+PiA+IGluZGV4IDk1NGZjMzFiNGJjNy4uYzMzMTcyYzViOGQ1IDEwMDY0NAo+
PiA+IC0tLSBhL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4+ID4gKysrIGIvZHJp
dmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMKPj4gPiBAQCAtMzk2LDEzICszOTYsMTUgQEAg
c3RhdGljIGJvb2wgdmlydGlvX2Njd19rdm1fbm90aWZ5KHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+
PiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fY2N3X3ZxX2luZm8gKmluZm8gPSB2cS0+cHJpdjsKPj4g
PiAgICAgICBzdHJ1Y3QgdmlydGlvX2Njd19kZXZpY2UgKnZjZGV2Owo+PiA+ICAgICAgIHN0cnVj
dCBzdWJjaGFubmVsX2lkIHNjaGlkOwo+PiA+ICsgICAgIHUzMiBkYXRhID0gX192aXJ0aW9fdGVz
dF9iaXQodnEtPnZkZXYsIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBKSA/Cj4+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIHZyaW5nX25vdGlmaWNhdGlvbl9kYXRhKHZxKSA6IHZxLT5pbmRleDsK
Pj4gPgo+PiA+ICAgICAgIHZjZGV2ID0gdG9fdmNfZGV2aWNlKGluZm8tPnZxLT52ZGV2KTsKPj4g
PiAgICAgICBjY3dfZGV2aWNlX2dldF9zY2hpZCh2Y2Rldi0+Y2RldiwgJnNjaGlkKTsKPj4gPiAg
ICAgICBCVUlMRF9CVUdfT04oc2l6ZW9mKHN0cnVjdCBzdWJjaGFubmVsX2lkKSAhPSBzaXplb2Yo
dW5zaWduZWQgaW50KSk7Cj4+ID4gICAgICAgaW5mby0+Y29va2llID0ga3ZtX2h5cGVyY2FsbDMo
S1ZNX1MzOTBfVklSVElPX0NDV19OT1RJRlksCj4+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKigodW5zaWduZWQgaW50ICopJnNjaGlkKSwKPj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2cS0+aW5kZXgsIGluZm8tPmNvb2tpZSk7Cj4+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSwgaW5mby0+Y29va2llKTsKPj4g
PiAgICAgICBpZiAoaW5mby0+Y29va2llIDwgMCkKPj4gPiAgICAgICAgICAgICAgIHJldHVybiBm
YWxzZTsKPj4gPiAgICAgICByZXR1cm4gdHJ1ZTsKPj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX21taW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19tbWlvLmMKPj4gPiBp
bmRleCAzZmY3NDZlM2YyNGEuLjdjMTZlNjIyYzMzZCAxMDA2NDQKPj4gPiAtLS0gYS9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fbW1pby5jCj4+ID4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX21t
aW8uYwo+PiA+IEBAIC0yODUsNiArMjg1LDE2IEBAIHN0YXRpYyBib29sIHZtX25vdGlmeShzdHJ1
Y3QgdmlydHF1ZXVlICp2cSkKPj4gPiAgICAgICByZXR1cm4gdHJ1ZTsKPj4gPiAgfQo+PiA+Cj4+
ID4gK3N0YXRpYyBib29sIHZtX25vdGlmeV93aXRoX2RhdGEoc3RydWN0IHZpcnRxdWV1ZSAqdnEp
Cj4+ID4gK3sKPj4gPiArICAgICBzdHJ1Y3QgdmlydGlvX21taW9fZGV2aWNlICp2bV9kZXYgPSB0
b192aXJ0aW9fbW1pb19kZXZpY2UodnEtPnZkZXYpOwo+PiA+ICsgICAgIHUzMiBkYXRhID0gdnJp
bmdfbm90aWZpY2F0aW9uX2RhdGEodnEpOwo+PiA+ICsKPj4gPiArICAgICB3cml0ZWwoZGF0YSwg
dm1fZGV2LT5iYXNlICsgVklSVElPX01NSU9fUVVFVUVfTk9USUZZKTsKPj4KPj4gQ2FuJ3QgeW91
IHNpbXBseSB1c2UgdGhlIHNhbWUgbWV0aG9kIGFzIGZvciBjY3csIGkuZS4gdXNlIG9uZSBjYWxs
YmFjawo+PiBmdW5jdGlvbiB0aGF0IHNpbXBseSB3cml0ZXMgb25lIHZhbHVlIG9yIHRoZSBvdGhl
cj8KPgo+IFRoZSBpZGVhIGlzIHRvIGVsaW1pbmF0ZSB0aGUgY29uZGl0aW9uYWwgYnJhbmNoIGlu
ZHVjZWQgYnkgZmVhdHVyZSBiaXQKPiB0ZXN0aW5nIGZyb20gdGhlIG5vdGlmaWNhdGlvbiBmdW5j
dGlvbi4gUHJvYmFibHksIHRoaXMgY2FuIGJlIGRvbmUgaW4KPiB0aGUgc2FtZSB3YXkgaW4gY2N3
LgoKSG0sIGhvdyBub3RpY2FibGUgaXMgdGhhdCBicmFuY2g/IElPVywgaXMgaXQgd29ydGggbWFr
aW5nIHRoZSBjb2RlIGxlc3MKcmVhZGFibGUgZm9yIHRoaXM/CgooSW4gYW55IGNhc2UsIGFsbCB0
cmFuc3BvcnRzIHByb2JhYmx5IHNob3VsZCB1c2UgdGhlIHNhbWUgbWV0aG9kLikKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E0EC6FD1D
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 16:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7704C82005;
	Tue, 21 Mar 2023 16:22:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7704C82005
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WlAJ27rd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x381fGSUouce; Tue, 21 Mar 2023 16:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CCF1382033;
	Tue, 21 Mar 2023 16:22:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CCF1382033
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF37C0035;
	Tue, 21 Mar 2023 16:22:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93FC4C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 601F381FFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:22:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 601F381FFF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UX4AFiXTjwQ3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C09A982028
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C09A982028
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679415725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgoaZPNV6QFiAZ6BoiXCSnPeZXlIYAThltxiCwI3A8Q=;
 b=WlAJ27rdinxrQWMUKYmUy1ruqWPb6aDB/kZrWH+X8b9r+Udo7EIbQxhVaLuIOsUT2BLb2r
 FtLhdZHMOQmFYVS8c3wyBoHB6pECGaciBJD2zeNAbgSrJtCLe4zlVT4jxok4Qa6T2P30KL
 UAmlNkgpuI+79H/mYJL7RAxJ3EAdcMk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-lZh2iYaPNROe8ncvNmm22g-1; Tue, 21 Mar 2023 12:22:01 -0400
X-MC-Unique: lZh2iYaPNROe8ncvNmm22g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B26391008139;
 Tue, 21 Mar 2023 16:22:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48CDD140E960;
 Tue, 21 Mar 2023 16:22:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
In-Reply-To: <20230321115854-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20230321134410.2097163-1-viktor@daynix.com>
 <87h6uem9qc.fsf@redhat.com>
 <CAPv0NP6Ep4-B7cMc285E3d3vYjgwO7O1pq5sG3OYYAoZd3EAYQ@mail.gmail.com>
 <87bkkmm89a.fsf@redhat.com>
 <20230321115854-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 21 Mar 2023 17:21:59 +0100
Message-ID: <878rfqm5w8.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 Viktor Prutyanov <viktor@daynix.com>, linux-kernel@vger.kernel.org,
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

T24gVHVlLCBNYXIgMjEgMjAyMywgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29t
PiB3cm90ZToKCj4gT24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgMDQ6MzA6NTdQTSArMDEwMCwgQ29y
bmVsaWEgSHVjayB3cm90ZToKPj4gT24gVHVlLCBNYXIgMjEgMjAyMywgVmlrdG9yIFBydXR5YW5v
diA8dmlrdG9yQGRheW5peC5jb20+IHdyb3RlOgo+PiAKPj4gPiBPbiBUdWUsIE1hciAyMSwgMjAy
MyBhdCA1OjU54oCvUE0gQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+IHdyb3RlOgo+
PiA+Pgo+PiA+PiBPbiBUdWUsIE1hciAyMSAyMDIzLCBWaWt0b3IgUHJ1dHlhbm92IDx2aWt0b3JA
ZGF5bml4LmNvbT4gd3JvdGU6Cj4+ID4+Cj4+ID4+ID4gQWNjb3JkaW5nIHRvIFZpcnRJTyBzcGVj
IHYxLjIsIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUKPj4gPj4gPiBpbmRpY2F0
ZXMgdGhhdCB0aGUgZHJpdmVyIHBhc3NlcyBleHRyYSBkYXRhIGFsb25nIHdpdGggdGhlIHF1ZXVl
Cj4+ID4+ID4gbm90aWZpY2F0aW9ucy4KPj4gPj4gPgo+PiA+PiA+IEluIGEgc3BsaXQgcXVldWUg
Y2FzZSwgdGhlIGV4dHJhIGRhdGEgaXMgMTYtYml0IGF2YWlsYWJsZSBpbmRleC4gSW4gYQo+PiA+
PiA+IHBhY2tlZCBxdWV1ZSBjYXNlLCB0aGUgZXh0cmEgZGF0YSBpcyAxLWJpdCB3cmFwIGNvdW50
ZXIgYW5kIDE1LWJpdAo+PiA+PiA+IGF2YWlsYWJsZSBpbmRleC4KPj4gPj4gPgo+PiA+PiA+IEFk
ZCBzdXBwb3J0IGZvciB0aGlzIGZlYXR1cmUgZm9yIE1NSU8sIFBDSSBhbmQgY2hhbm5lbCBJL08g
dHJhbnNwb3J0cy4KPj4gPj4gPgo+PiA+PiA+IFNpZ25lZC1vZmYtYnk6IFZpa3RvciBQcnV0eWFu
b3YgPHZpa3RvckBkYXluaXguY29tPgo+PiA+PiA+IC0tLQo+PiA+PiA+ICB2Mzogc3VwcG9ydCBm
ZWF0dXJlIGluIHZpcnRpb19jY3csIHJlbW92ZSBWTV9OT1RJRlksIHVzZSBhdmFpbF9pZHhfc2hh
ZG93LAo+PiA+PiA+ICAgICByZW1vdmUgYnl0ZSBzd2FwLCByZW5hbWUgdG8gdnJpbmdfbm90aWZp
Y2F0aW9uX2RhdGEKPj4gPj4gPiAgdjI6IHJlamVjdCB0aGUgZmVhdHVyZSBpbiB2aXJ0aW9fY2N3
LCByZXBsYWNlIF9fbGUzMiB3aXRoIHUzMgo+PiA+PiA+Cj4+ID4+ID4gIGRyaXZlcnMvczM5MC92
aXJ0aW8vdmlydGlvX2Njdy5jICAgfCAgNCArKystCj4+ID4+ID4gIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19tbWlvLmMgICAgICAgfCAxNCArKysrKysrKysrKysrLQo+PiA+PiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jIHwgMTAgKysrKysrKysrKwo+PiA+PiA+ICBkcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5oIHwgIDQgKysrKwo+PiA+PiA+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgIDIgKy0KPj4gPj4gPiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9tb2Rlcm4uYyB8ICAyICstCj4+ID4+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgICAgICAgfCAxNyArKysrKysrKysrKysrKysrKwo+PiA+PiA+ICBpbmNsdWRlL2xp
bnV4L3ZpcnRpb19yaW5nLmggICAgICAgIHwgIDIgKysKPj4gPj4gPiAgaW5jbHVkZS91YXBpL2xp
bnV4L3ZpcnRpb19jb25maWcuaCB8ICA2ICsrKysrKwo+PiA+PiA+ICA5IGZpbGVzIGNoYW5nZWQs
IDU3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+ID4+ID4KPj4gPj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMgYi9kcml2ZXJzL3MzOTAvdmly
dGlvL3ZpcnRpb19jY3cuYwo+PiA+PiA+IGluZGV4IDk1NGZjMzFiNGJjNy4uYzMzMTcyYzViOGQ1
IDEwMDY0NAo+PiA+PiA+IC0tLSBhL2RyaXZlcnMvczM5MC92aXJ0aW8vdmlydGlvX2Njdy5jCj4+
ID4+ID4gKysrIGIvZHJpdmVycy9zMzkwL3ZpcnRpby92aXJ0aW9fY2N3LmMKPj4gPj4gPiBAQCAt
Mzk2LDEzICszOTYsMTUgQEAgc3RhdGljIGJvb2wgdmlydGlvX2Njd19rdm1fbm90aWZ5KHN0cnVj
dCB2aXJ0cXVldWUgKnZxKQo+PiA+PiA+ICAgICAgIHN0cnVjdCB2aXJ0aW9fY2N3X3ZxX2luZm8g
KmluZm8gPSB2cS0+cHJpdjsKPj4gPj4gPiAgICAgICBzdHJ1Y3QgdmlydGlvX2Njd19kZXZpY2Ug
KnZjZGV2Owo+PiA+PiA+ICAgICAgIHN0cnVjdCBzdWJjaGFubmVsX2lkIHNjaGlkOwo+PiA+PiA+
ICsgICAgIHUzMiBkYXRhID0gX192aXJ0aW9fdGVzdF9iaXQodnEtPnZkZXYsIFZJUlRJT19GX05P
VElGSUNBVElPTl9EQVRBKSA/Cj4+ID4+ID4gKyAgICAgICAgICAgICAgICAgICAgIHZyaW5nX25v
dGlmaWNhdGlvbl9kYXRhKHZxKSA6IHZxLT5pbmRleDsKPj4gPj4gPgo+PiA+PiA+ICAgICAgIHZj
ZGV2ID0gdG9fdmNfZGV2aWNlKGluZm8tPnZxLT52ZGV2KTsKPj4gPj4gPiAgICAgICBjY3dfZGV2
aWNlX2dldF9zY2hpZCh2Y2Rldi0+Y2RldiwgJnNjaGlkKTsKPj4gPj4gPiAgICAgICBCVUlMRF9C
VUdfT04oc2l6ZW9mKHN0cnVjdCBzdWJjaGFubmVsX2lkKSAhPSBzaXplb2YodW5zaWduZWQgaW50
KSk7Cj4+ID4+ID4gICAgICAgaW5mby0+Y29va2llID0ga3ZtX2h5cGVyY2FsbDMoS1ZNX1MzOTBf
VklSVElPX0NDV19OT1RJRlksCj4+ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKigodW5zaWduZWQgaW50ICopJnNjaGlkKSwKPj4gPj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB2cS0+aW5kZXgsIGluZm8tPmNvb2tpZSk7Cj4+ID4+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSwgaW5mby0+Y29va2llKTsKPj4g
Pj4gPiAgICAgICBpZiAoaW5mby0+Y29va2llIDwgMCkKPj4gPj4gPiAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsKPj4gPj4gPiAgICAgICByZXR1cm4gdHJ1ZTsKPj4gPj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX21taW8uYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19t
bWlvLmMKPj4gPj4gPiBpbmRleCAzZmY3NDZlM2YyNGEuLjdjMTZlNjIyYzMzZCAxMDA2NDQKPj4g
Pj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fbW1pby5jCj4+ID4+ID4gKysrIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX21taW8uYwo+PiA+PiA+IEBAIC0yODUsNiArMjg1LDE2IEBAIHN0
YXRpYyBib29sIHZtX25vdGlmeShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPj4gPj4gPiAgICAgICBy
ZXR1cm4gdHJ1ZTsKPj4gPj4gPiAgfQo+PiA+PiA+Cj4+ID4+ID4gK3N0YXRpYyBib29sIHZtX25v
dGlmeV93aXRoX2RhdGEoc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4+ID4+ID4gK3sKPj4gPj4gPiAr
ICAgICBzdHJ1Y3QgdmlydGlvX21taW9fZGV2aWNlICp2bV9kZXYgPSB0b192aXJ0aW9fbW1pb19k
ZXZpY2UodnEtPnZkZXYpOwo+PiA+PiA+ICsgICAgIHUzMiBkYXRhID0gdnJpbmdfbm90aWZpY2F0
aW9uX2RhdGEodnEpOwo+PiA+PiA+ICsKPj4gPj4gPiArICAgICB3cml0ZWwoZGF0YSwgdm1fZGV2
LT5iYXNlICsgVklSVElPX01NSU9fUVVFVUVfTk9USUZZKTsKPj4gPj4KPj4gPj4gQ2FuJ3QgeW91
IHNpbXBseSB1c2UgdGhlIHNhbWUgbWV0aG9kIGFzIGZvciBjY3csIGkuZS4gdXNlIG9uZSBjYWxs
YmFjawo+PiA+PiBmdW5jdGlvbiB0aGF0IHNpbXBseSB3cml0ZXMgb25lIHZhbHVlIG9yIHRoZSBv
dGhlcj8KPj4gPgo+PiA+IFRoZSBpZGVhIGlzIHRvIGVsaW1pbmF0ZSB0aGUgY29uZGl0aW9uYWwg
YnJhbmNoIGluZHVjZWQgYnkgZmVhdHVyZSBiaXQKPj4gPiB0ZXN0aW5nIGZyb20gdGhlIG5vdGlm
aWNhdGlvbiBmdW5jdGlvbi4gUHJvYmFibHksIHRoaXMgY2FuIGJlIGRvbmUgaW4KPj4gPiB0aGUg
c2FtZSB3YXkgaW4gY2N3Lgo+PiAKPj4gSG0sIGhvdyBub3RpY2FibGUgaXMgdGhhdCBicmFuY2g/
IElPVywgaXMgaXQgd29ydGggbWFraW5nIHRoZSBjb2RlIGxlc3MKPj4gcmVhZGFibGUgZm9yIHRo
aXM/Cj4KPiBJJ20gbm90IHN1cmUgYnV0IHRoZXNlIHRoaW5ncyBhZGQgdXAuIEknbSB3aXRoIFZp
a3RvciBoZXJlIGxldCdzIGp1c3QKPiBhdm9pZCB0aGUgYnJhbmNoIGFuZCBub3Qgd29ycnkgYWJv
dXQgd2hldGhlciBpdCdzIGltcG9ydGFudCBvciBub3QuCj4gU28gbGV0J3MgdXNlIHRoZSBzYW1l
IHRoaW5nIGhlcmUgdGhlbj8gQW5kIHdlIGNhbiB1c2UgYSBzdWJmdW5jdGlvbgo+IHRvIGF2b2lk
IGNvZGUgZHVwbGljYXRpb24uCgpPaywgbGV0J3MgZG8gaXQgdGhhdCB3YXkuCgo+Cj4+IChJbiBh
bnkgY2FzZSwgYWxsIHRyYW5zcG9ydHMgcHJvYmFibHkgc2hvdWxkIHVzZSB0aGUgc2FtZSBtZXRo
b2QuKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

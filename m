Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D3C433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 06:21:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEA8264FCE
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 06:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA8264FCE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B9514301D;
	Thu, 11 Mar 2021 06:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nbZjWWAV-X_1; Thu, 11 Mar 2021 06:21:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DB5E43019;
	Thu, 11 Mar 2021 06:21:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA12AC000B;
	Thu, 11 Mar 2021 06:21:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E598EC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:21:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8BC583E7B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:21:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PhBZ9vhuCF9v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:20:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB2B5834D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 06:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615443658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjTxE9BR2uNybLgUHvNoBdUWBPK4sh7rwx5cjZJ/jb8=;
 b=Kq36lmcCh3JEHZbPIMdx7TtV27FIpjUFBybOdPDI7MKA3gUE97vX8s3BbL0vH5PHeWffsV
 Ei+72RtDWzPkORUz1DNWTvvQRoJYAnwcDpnr9TIVA8IGDwcaQx0ZGl21DCfNIXNEd4NdSh
 ucKnUvkL/HttwUqnUYdJuaPtVZC7Lmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-ul4rT5NMNz6JRQwGn0PCcw-1; Thu, 11 Mar 2021 01:20:55 -0500
X-MC-Unique: ul4rT5NMNz6JRQwGn0PCcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C011A1005D45;
 Thu, 11 Mar 2021 06:20:53 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com
 [10.72.13.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A94B5D746;
 Thu, 11 Mar 2021 06:20:47 +0000 (UTC)
Subject: Re: [PATCH V3 6/6] vDPA/ifcvf: verify mandatory feature bits for vDPA
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-7-lingshan.zhu@intel.com>
 <3e53a5c9-c531-48ee-c9a7-907dfdacc9d1@redhat.com>
 <9c2fb3d0-2d69-20b9-589d-cc5ffc830f38@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4f3ef2bb-d823-d53d-3bb0-0152a3f6c9f1@redhat.com>
Date: Thu, 11 Mar 2021 14:20:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <9c2fb3d0-2d69-20b9-589d-cc5ffc830f38@linux.intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMy8xMSAxMjoxNiDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
My8xMS8yMDIxIDExOjIwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIxLzMvMTAg
NTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4+IHZEUEEgcmVxdXJlcyBWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0gYXMgYSBtdXN0LCB0aGlzIGNvbW1pdAo+Pj4gZXhhbWluZXMgdGhp
cyB3aGVuIHNldCBmZWF0dXJlcy4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3NoYW4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmMgfCA4ICsrKysrKysrCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5oIHwgMSArCj4+PiDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwg
NSArKysrKwo+Pj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgCj4+PiBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMKPj4+IGluZGV4IGVhNmE3ODc5MWM5Yi4uNThmNDdm
ZGNlMzg1IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+
Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+Pj4gQEAgLTIyNCw2ICsy
MjQsMTQgQEAgdTY0IGlmY3ZmX2dldF9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4g
wqDCoMKgwqDCoCByZXR1cm4gaHctPmh3X2ZlYXR1cmVzOwo+Pj4gwqAgfQo+Pj4gwqAgK2ludCBp
ZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4+PiArewo+Pj4g
K8KgwqDCoCBpZiAoIShody0+aHdfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19Q
TEFURk9STSkpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gKwo+Pj4g
K8KgwqDCoCByZXR1cm4gMDsKPj4+ICt9Cj4+PiArCj4+PiDCoCB2b2lkIGlmY3ZmX3JlYWRfbmV0
X2NvbmZpZyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1NjQgb2Zmc2V0LAo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZCAqZHN0LCBpbnQgbGVuZ3RoKQo+Pj4gwqAgewo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggCj4+PiBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+IGluZGV4IGRiYjhjMTBhYTNiMS4uOTFjNTcz
NWQ0ZGM5IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+
Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4gQEAgLTEyMyw2ICsx
MjMsNyBAQCB2b2lkIGlvX3dyaXRlNjRfdHdvcGFydCh1NjQgdmFsLCB1MzIgKmxvLCB1MzIgKmhp
KTsKPj4+IMKgIHZvaWQgaWZjdmZfcmVzZXQoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4+PiDCoCB1
NjQgaWZjdmZfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+Pj4gwqAgdTY0IGlm
Y3ZmX2dldF9od19mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPj4+ICtpbnQgaWZjdmZf
dmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPj4+IMKgIHUxNiBpZmN2
Zl9nZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCk7Cj4+PiDCoCBpbnQg
aWZjdmZfc2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQsIHUxNiBudW0p
Owo+Pj4gwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKnZmX3RvX2FkYXB0ZXIoc3RydWN0IGlmY3Zm
X2h3ICpodyk7Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
YyAKPj4+IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4gaW5kZXggMjVmYjlk
ZmUyM2YwLi5mNjI0ZjIwMjQ0N2QgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+
PiBAQCAtMTc5LDYgKzE3OSwxMSBAQCBzdGF0aWMgdTY0IGlmY3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVz
KHN0cnVjdCAKPj4+IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPj4+IMKgIHN0YXRpYyBpbnQgaWZj
dmZfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgCj4+PiB1
NjQgZmVhdHVyZXMpCj4+PiDCoCB7Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYg
PSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4+ICvCoMKgwqAgaW50IHJldDsKPj4+ICsKPj4+ICvC
oMKgwqAgcmV0ID0gaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyh2Zik7Cj4+Cj4+Cj4+IFNvIHRo
aXMgdmFsaWRhdGUgZGV2aWNlIGZlYXR1cmVzIGluc3RlYWQgb2YgZHJpdmVyIHdoaWNoIGlzIHRo
ZSBvbmUgCj4+IHdlIHJlYWxseSB3YW50IHRvIGNoZWNrPwo+Pgo+PiBUaGFua3MKPgo+IEhpIEph
c29uLAo+Cj4gSGVyZSB3ZSBjaGVjayBkZXZpY2UgZmVhdHVyZSBiaXRzIHRvIG1ha2Ugc3VyZSB0
aGUgZGV2aWNlIHN1cHBvcnQgCj4gQUNDRVNTX1BMQVRGT1JNLiAKCgpJZiB5b3Ugd2FudCB0byBj
aGVjayBkZXZpY2UgZmVhdHVyZXMsIHlvdSBuZWVkIHRvIGRvIHRoYXQgZHVyaW5nIHByb2JlKCkg
CmFuZCBmYWlsIHRoZSBwcm9iaW5nIGlmIHdpdGhvdXQgdGhlIGZlYXR1cmUuIEJ1dCBJIHRoaW5r
IHlvdSB3b24ndCBzaGlwIApjYXJkcyB3aXRob3V0IEFDQ0VTU19QTEFURk9STS4KCgo+IEluIGdl
dF9mZWF0dXJlcygpLAo+IGl0IHdpbGwgcmV0dXJuIGEgaW50ZXJzZWN0aW9uIG9mIGRldmljZSBm
ZWF0dXJlcyBiaXQgYW5kIGRyaXZlciAKPiBzdXBwb3J0ZWQgZmVhdHVyZXMgYml0cyh3aGljaCBp
bmNsdWRlcyBBQ0NFU1NfUExBVEZPUk0pLgo+IE90aGVyIGNvbXBvbmVudHMgbGlrZSBRRU1VIHNo
b3VsZCBub3Qgc2V0IGZlYXR1cmVzIGJpdHMgbW9yZSB0aGFuIHRoaXMgCj4gaW50ZXJzZWN0aW9u
IG9mIGJpdHMuIHNvIHdlIGNhbiBtYWtlIHN1cmUgaWYgdGhpcwo+IGlmY3ZmX3ZlcmlmeV9taW5f
ZmVhdHVyZXMoKSBwYXNzZWQsIGJvdGggZGV2aWNlIGFuZCBkcml2ZXIgc3VwcG9ydCAKPiBBQ0NF
U1NfUExBVEZPUk0uCj4KPiBBcmUgeW91IHN1Z2dlc3RpbmcgY2hlY2sgZHJpdmVyIGZlYXR1cmUg
Yml0cyBpbiAKPiBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKCkgaW4gdGhlIG1lYW50aW1lIGFz
IHdlbGw/CgoKU28gaXQgcmVhbGx5IGRlcGVuZHMgb24geW91ciBoYXJkd2FyZS4gSWYgeW91IGhh
cmR3YXJlIGNhbiBhbHdheXMgb2ZmZXIgCkFDQ0VTU19QTEFURk9STSwgeW91IGp1c3QgbmVlZCB0
byBjaGVjayBkcml2ZXIgZmVhdHVyZXMuIFRoaXMgaXMgaG93IAp2ZHBhX3NpbSBhbmQgbWx4NV92
ZHBhIHdvcmsuCgpUaGFua3MKCgo+Cj4gVGhhbmtz77yBCj4+Cj4+Cj4+PiArwqDCoMKgIGlmIChy
ZXQpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgIMKgwqDCoMKgwqAgdmYt
PnJlcV9mZWF0dXJlcyA9IGZlYXR1cmVzOwo+Pgo+PiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+PiBWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPj4g
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPj4gaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

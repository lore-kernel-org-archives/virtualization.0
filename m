Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E905C433E0
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 05:53:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8205764F7A
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 05:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8205764F7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B48384508;
	Fri, 12 Mar 2021 05:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdHc-Lt8QmAn; Fri, 12 Mar 2021 05:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A909284503;
	Fri, 12 Mar 2021 05:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72FA4C000B;
	Fri, 12 Mar 2021 05:53:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF6BBC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 05:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B4FB643057
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 05:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtGYqjqmP80Z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 05:53:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86C59414FE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 05:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615528380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IIo64LdJLthFkJBxGpFePO70WMUQBBdNsmfbPvgk47s=;
 b=c1K7F2VFuAUmtwNLWqxj6AlZ/L4Tnprw84yrS/LAJp8FlsAazh7VH2zdrq73wUX0owIEJJ
 bJxXF9G2+aN+Rv4JJVa4Imv6VaemrbyAMJqnSrCLLSR4a5aw6dEZsIBIhsEDo4nSi6uG2I
 6/C206tHASDMCtAw8MGahdhJzLmPKuA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-7-3Ode_4Npydt4MxE7d6AA-1; Fri, 12 Mar 2021 00:52:56 -0500
X-MC-Unique: 7-3Ode_4Npydt4MxE7d6AA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE9B419253FD;
 Fri, 12 Mar 2021 05:52:38 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-33.pek2.redhat.com
 [10.72.13.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFB235947E;
 Fri, 12 Mar 2021 05:52:35 +0000 (UTC)
Subject: Re: [PATCH V3 6/6] vDPA/ifcvf: verify mandatory feature bits for vDPA
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Zhu Lingshan <lingshan.zhu@linux.intel.com>, mst@redhat.com,
 lulu@redhat.com, leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-7-lingshan.zhu@intel.com>
 <3e53a5c9-c531-48ee-c9a7-907dfdacc9d1@redhat.com>
 <9c2fb3d0-2d69-20b9-589d-cc5ffc830f38@linux.intel.com>
 <4f3ef2bb-d823-d53d-3bb0-0152a3f6c9f1@redhat.com>
 <a1f346cc-c9fd-6d16-39d7-b59965a18b0a@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67be60b6-bf30-de85-ed42-d9fad974f42b@redhat.com>
Date: Fri, 12 Mar 2021 13:52:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a1f346cc-c9fd-6d16-39d7-b59965a18b0a@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjEvMy8xMSAzOjE5IOS4i+WNiCwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
My8xMS8yMDIxIDI6MjAgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMy8xMSAx
MjoxNiDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMy8xMS8yMDIx
IDExOjIwIEFNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMS8zLzEwIDU6MDAg
5LiL5Y2ILCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+IHZEUEEgcmVxdXJlcyBWSVJUSU9fRl9B
Q0NFU1NfUExBVEZPUk0gYXMgYSBtdXN0LCB0aGlzIGNvbW1pdAo+Pj4+PiBleGFtaW5lcyB0aGlz
IHdoZW4gc2V0IGZlYXR1cmVzLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGluZ3No
YW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiDCoCBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5jIHwgOCArKysrKysrKwo+Pj4+PiDCoCBkcml2ZXJzL3ZkcGEv
aWZjdmYvaWZjdmZfYmFzZS5oIHwgMSArCj4+Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMgfCA1ICsrKysrCj4+Pj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jh
c2UuYyAKPj4+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+Pj4+IGluZGV4
IGVhNmE3ODc5MWM5Yi4uNThmNDdmZGNlMzg1IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmMKPj4+Pj4gQEAgLTIyNCw2ICsyMjQsMTQgQEAgdTY0IGlmY3ZmX2dldF9mZWF0dXJl
cyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KQo+Pj4+PiDCoMKgwqDCoMKgIHJldHVybiBody0+aHdfZmVh
dHVyZXM7Cj4+Pj4+IMKgIH0KPj4+Pj4gwqAgK2ludCBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVz
KHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4+Pj4+ICt7Cj4+Pj4+ICvCoMKgwqAgaWYgKCEoaHctPmh3
X2ZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkKPj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+PiArCj4+Pj4+ICvCoMKgwqAgcmV0dXJu
IDA7Cj4+Pj4+ICt9Cj4+Pj4+ICsKPj4+Pj4gwqAgdm9pZCBpZmN2Zl9yZWFkX25ldF9jb25maWco
c3RydWN0IGlmY3ZmX2h3ICpodywgdTY0IG9mZnNldCwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdm9pZCAqZHN0LCBpbnQgbGVuZ3RoKQo+Pj4+PiDCoCB7Cj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIAo+Pj4+PiBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPj4+Pj4gaW5kZXggZGJiOGMxMGFhM2IxLi45MWM1
NzM1ZDRkYzkgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNl
LmgKPj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+PiBAQCAt
MTIzLDYgKzEyMyw3IEBAIHZvaWQgaW9fd3JpdGU2NF90d29wYXJ0KHU2NCB2YWwsIHUzMiAqbG8s
IHUzMiAKPj4+Pj4gKmhpKTsKPj4+Pj4gwqAgdm9pZCBpZmN2Zl9yZXNldChzdHJ1Y3QgaWZjdmZf
aHcgKmh3KTsKPj4+Pj4gwqAgdTY0IGlmY3ZmX2dldF9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcg
Kmh3KTsKPj4+Pj4gwqAgdTY0IGlmY3ZmX2dldF9od19mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcg
Kmh3KTsKPj4+Pj4gK2ludCBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9o
dyAqaHcpOwo+Pj4+PiDCoCB1MTYgaWZjdmZfZ2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2Zl9odyAq
aHcsIHUxNiBxaWQpOwo+Pj4+PiDCoCBpbnQgaWZjdmZfc2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2
Zl9odyAqaHcsIHUxNiBxaWQsIHUxNiBudW0pOwo+Pj4+PiDCoCBzdHJ1Y3QgaWZjdmZfYWRhcHRl
ciAqdmZfdG9fYWRhcHRlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgCj4+Pj4+IGIvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYwo+Pj4+PiBpbmRleCAyNWZiOWRmZTIzZjAuLmY2MjRmMjAyNDQ3ZCAx
MDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+Pj4+IEBAIC0xNzksNiArMTc5
LDExIEBAIHN0YXRpYyB1NjQgaWZjdmZfdmRwYV9nZXRfZmVhdHVyZXMoc3RydWN0IAo+Pj4+PiB2
ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4+Pj4+IMKgIHN0YXRpYyBpbnQgaWZjdmZfdmRwYV9zZXRf
ZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgCj4+Pj4+IHU2NCBmZWF0dXJl
cykKPj4+Pj4gwqAgewo+Pj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBh
X3RvX3ZmKHZkcGFfZGV2KTsKPj4+Pj4gK8KgwqDCoCBpbnQgcmV0Owo+Pj4+PiArCj4+Pj4+ICvC
oMKgwqAgcmV0ID0gaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyh2Zik7Cj4+Pj4KPj4+Pgo+Pj4+
IFNvIHRoaXMgdmFsaWRhdGUgZGV2aWNlIGZlYXR1cmVzIGluc3RlYWQgb2YgZHJpdmVyIHdoaWNo
IGlzIHRoZSBvbmUgCj4+Pj4gd2UgcmVhbGx5IHdhbnQgdG8gY2hlY2s/Cj4+Pj4KPj4+PiBUaGFu
a3MKPj4+Cj4+PiBIaSBKYXNvbiwKPj4+Cj4+PiBIZXJlIHdlIGNoZWNrIGRldmljZSBmZWF0dXJl
IGJpdHMgdG8gbWFrZSBzdXJlIHRoZSBkZXZpY2Ugc3VwcG9ydCAKPj4+IEFDQ0VTU19QTEFURk9S
TS4gCj4+Cj4+Cj4+IElmIHlvdSB3YW50IHRvIGNoZWNrIGRldmljZSBmZWF0dXJlcywgeW91IG5l
ZWQgdG8gZG8gdGhhdCBkdXJpbmcgCj4+IHByb2JlKCkgYW5kIGZhaWwgdGhlIHByb2JpbmcgaWYg
d2l0aG91dCB0aGUgZmVhdHVyZS4gQnV0IEkgdGhpbmsgeW91IAo+PiB3b24ndCBzaGlwIGNhcmRz
IHdpdGhvdXQgQUNDRVNTX1BMQVRGT1JNLgo+IFllcywgdGhlcmUgYXJlIG5vIHJlYXNvbnMgc2hp
cCBhIGNhcmQgd2l0aG91dCBBQ0NFU1NfUExBVEZPUk0KPj4KPj4KPj4+IEluIGdldF9mZWF0dXJl
cygpLAo+Pj4gaXQgd2lsbCByZXR1cm4gYSBpbnRlcnNlY3Rpb24gb2YgZGV2aWNlIGZlYXR1cmVz
IGJpdCBhbmQgZHJpdmVyIAo+Pj4gc3VwcG9ydGVkIGZlYXR1cmVzIGJpdHMod2hpY2ggaW5jbHVk
ZXMgQUNDRVNTX1BMQVRGT1JNKS4KPj4+IE90aGVyIGNvbXBvbmVudHMgbGlrZSBRRU1VIHNob3Vs
ZCBub3Qgc2V0IGZlYXR1cmVzIGJpdHMgbW9yZSB0aGFuIAo+Pj4gdGhpcyBpbnRlcnNlY3Rpb24g
b2YgYml0cy4gc28gd2UgY2FuIG1ha2Ugc3VyZSBpZiB0aGlzCj4+PiBpZmN2Zl92ZXJpZnlfbWlu
X2ZlYXR1cmVzKCkgcGFzc2VkLCBib3RoIGRldmljZSBhbmQgZHJpdmVyIHN1cHBvcnQgCj4+PiBB
Q0NFU1NfUExBVEZPUk0uCj4+Pgo+Pj4gQXJlIHlvdSBzdWdnZXN0aW5nIGNoZWNrIGRyaXZlciBm
ZWF0dXJlIGJpdHMgaW4gCj4+PiBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKCkgaW4gdGhlIG1l
YW50aW1lIGFzIHdlbGw/Cj4+Cj4+Cj4+IFNvIGl0IHJlYWxseSBkZXBlbmRzIG9uIHlvdXIgaGFy
ZHdhcmUuIElmIHlvdSBoYXJkd2FyZSBjYW4gYWx3YXlzIAo+PiBvZmZlciBBQ0NFU1NfUExBVEZP
Uk0sIHlvdSBqdXN0IG5lZWQgdG8gY2hlY2sgZHJpdmVyIGZlYXR1cmVzLiBUaGlzIAo+PiBpcyBo
b3cgdmRwYV9zaW0gYW5kIG1seDVfdmRwYSB3b3JrLgo+IFllcywgd2UgYWx3YXlzIHN1cHBvcnQg
QUNDRVNTX1BMQVRGT1JNLCBzbyBpdCBpcyBoYXJkIGNvZGVkIGluIHRoZSAKPiBtYWNybyBJRkNW
Rl9TVVBQT1JURURfRkVBVFVSRVMuCgoKVGhhdCdzIG5vdCB3aGF0IEkgcmVhZCBmcm9tIHRoZSBj
b2RlOgoKIMKgwqDCoMKgwqDCoMKgIGZlYXR1cmVzID0gaWZjdmZfZ2V0X2ZlYXR1cmVzKHZmKSAm
IElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUzsKCgo+IE5vdyB3ZSBjaGVjayB3aGV0aGVyIGRldmlj
ZSBzdXBwb3J0IHRoaXMgZmVhdHVyZSBiaXQgYXMgYSBkb3VibGUgCj4gY29uZm9ybWF0aW9uLCBh
cmUgeW91IHN1Z2dlc3Rpbmcgd2Ugc2hvdWxkIGNoZWNrIHdoZXRoZXIgCj4gQUNDRVNTX1BMQVRG
T1JNICYgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTCj4gaW4gc2V0X2ZlYXR1cmVzKCkgYXMgd2Vs
bD8KCgpJZiB3ZSBrbm93IGRldmljZSB3aWxsIGFsd2F5cyBvZmZlciBBQ0NFU1NfUExBVEZPUk0s
IHRoZXJlJ3Mgbm8gbmVlZCB0byAKY2hlY2sgaXQgYWdhaW4uIFdoYXQgd2Ugc2hvdWxkIGNoZWNr
IGlmIHdoZXRoZXIgZHJpdmVyIHNldCB0aGF0LCBhbmQgaWYgCml0IGRvZXNuJ3Qgd2UgbmVlZCB0
byBmYWlsIHNldF9mZWF0dXJlcygpLiBJIHRoaW5rIHRoZXJlJ3MgbGl0dGxlIGNoYW5jZSAKdGhh
dCBJRkNWRiBjYW4gd29yayB3aGVuIElPTU1VX1BMQVRGT1JNIGlzIG5vdCBuZWdvdGlhdGVkLgoK
Cj4gSSBwcmVmZXIgY2hlY2sgYm90aCBkZXZpY2UgYW5kIElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJF
UyBib3RoLCBtb3JlIAo+IHJlbGlhYmxlLgoKClNvIGFnYWluLCBpZiB5b3Ugd2FudCB0byBjaGVj
ayBkZXZpY2UgZmVhdHVyZXMsIHNldF9mZWF0dXJlcygpIGlzIG5vdCAKdGhlIHByb3BlciBwbGFj
ZS4gV2UgbmVlZCB0byBmYWlsIHRoZSBwcm9iZSBpbiB0aGlzIGNhc2UuCgpUaGFua3MKCgo+Cj4g
VGhhbmtzIQo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+Cj4+PiBUaGFua3PvvIEKPj4+Pgo+Pj4+Cj4+
Pj4+ICvCoMKgwqAgaWYgKHJldCkKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+
Pj4+IMKgIMKgwqDCoMKgwqAgdmYtPnJlcV9mZWF0dXJlcyA9IGZlYXR1cmVzOwo+Pj4+Cj4+Pj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+PiBWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKPj4+PiBWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwo+Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9uCj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

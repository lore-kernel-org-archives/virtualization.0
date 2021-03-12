Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337EC433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 07:00:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CA764D74
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 07:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CA764D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2E26844F5;
	Fri, 12 Mar 2021 07:00:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VJ57pqjGvLmH; Fri, 12 Mar 2021 07:00:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39BE8844D7;
	Fri, 12 Mar 2021 07:00:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D2EAC000B;
	Fri, 12 Mar 2021 07:00:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1272C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9CB16F99A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ww_7NZ3aVz-I
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:00:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B8926F593
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615532447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCdk7eKRFtGhjDrxRS4Y4PRonFfh7hwbPN1mR7JuohY=;
 b=i6Q2J0kXl+1dYGj8lAEL8injm+Ux+xl8e529tu9aiAtoTOFbXa73iEX1IB4okG3PZZnaPN
 1wriINYma2Ju9xkAZVMj0K85PLuOuQEp6GERvaDe4NDH2H9Jp54ICpwZEFp9hCO0E48IXE
 nJI+IrRUcTKvxl+O84zdg7ZxYzj+IxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-9UeYFPVSPFa4GjiAiw-7sA-1; Fri, 12 Mar 2021 02:00:45 -0500
X-MC-Unique: 9UeYFPVSPFa4GjiAiw-7sA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7B921084D76;
 Fri, 12 Mar 2021 07:00:43 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-168.pek2.redhat.com
 [10.72.13.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ECFC1F05E;
 Fri, 12 Mar 2021 07:00:37 +0000 (UTC)
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
 <67be60b6-bf30-de85-ed42-d9fad974f42b@redhat.com>
 <2a6e31d3-ea31-9b64-0749-1f149b656623@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2111b14b-4857-34c8-82c4-72d182ca50c5@redhat.com>
Date: Fri, 12 Mar 2021 15:00:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2a6e31d3-ea31-9b64-0749-1f149b656623@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Ck9uIDIwMjEvMy8xMiAyOjQwIOS4i+WNiCwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
My8xMi8yMDIxIDE6NTIgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+IE9uIDIwMjEvMy8xMSAz
OjE5IOS4i+WNiCwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMy8xMS8yMDIx
IDI6MjAgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4KPj4+PiBPbiAyMDIxLzMvMTEgMTI6MTYg
5LiL5Y2ILCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IE9uIDMvMTEvMjAy
MSAxMToyMCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Cj4+Pj4+PiBPbiAyMDIxLzMvMTAg
NTowMCDkuIvljYgsIFpodSBMaW5nc2hhbiB3cm90ZToKPj4+Pj4+PiB2RFBBIHJlcXVyZXMgVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNIGFzIGEgbXVzdCwgdGhpcyBjb21taXQKPj4+Pj4+PiBleGFt
aW5lcyB0aGlzIHdoZW4gc2V0IGZlYXR1cmVzLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9mZi1i
eTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+IC0tLQo+Pj4+
Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgfCA4ICsrKysrKysrCj4+Pj4+
Pj4gwqAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCB8IDEgKwo+Pj4+Pj4+IMKgIGRy
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCA1ICsrKysrCj4+Pj4+Pj4gwqAgMyBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyAKPj4+Pj4+PiBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmMKPj4+Pj4+PiBpbmRleCBlYTZhNzg3OTFjOWIuLjU4ZjQ3ZmRjZTM4
NSAxMDA2NDQKPj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5jCj4+
Pj4+Pj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+Pj4+Pj4+IEBAIC0y
MjQsNiArMjI0LDE0IEBAIHU2NCBpZmN2Zl9nZXRfZmVhdHVyZXMoc3RydWN0IGlmY3ZmX2h3ICpo
dykKPj4+Pj4+PiDCoMKgwqDCoMKgIHJldHVybiBody0+aHdfZmVhdHVyZXM7Cj4+Pj4+Pj4gwqAg
fQo+Pj4+Pj4+IMKgICtpbnQgaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZf
aHcgKmh3KQo+Pj4+Pj4+ICt7Cj4+Pj4+Pj4gK8KgwqDCoCBpZiAoIShody0+aHdfZmVhdHVyZXMg
JiBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+Pj4+PiArCj4+Pj4+Pj4gK8KgwqDCoCByZXR1cm4gMDsK
Pj4+Pj4+PiArfQo+Pj4+Pj4+ICsKPj4+Pj4+PiDCoCB2b2lkIGlmY3ZmX3JlYWRfbmV0X2NvbmZp
ZyhzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1NjQgb2Zmc2V0LAo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKmRzdCwgaW50IGxlbmd0aCkKPj4+Pj4+PiDCoCB7Cj4+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggCj4+Pj4+
Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4+Pj4+Pj4gaW5kZXggZGJiOGMx
MGFhM2IxLi45MWM1NzM1ZDRkYzkgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX2Jhc2UuaAo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmgKPj4+Pj4+PiBAQCAtMTIzLDYgKzEyMyw3IEBAIHZvaWQgaW9fd3JpdGU2NF90d29wYXJ0
KHU2NCB2YWwsIHUzMiAqbG8sIAo+Pj4+Pj4+IHUzMiAqaGkpOwo+Pj4+Pj4+IMKgIHZvaWQgaWZj
dmZfcmVzZXQoc3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4+Pj4+Pj4gwqAgdTY0IGlmY3ZmX2dldF9m
ZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPj4+Pj4+PiDCoCB1NjQgaWZjdmZfZ2V0X2h3
X2ZlYXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+Pj4+Pj4+ICtpbnQgaWZjdmZfdmVyaWZ5
X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPj4+Pj4+PiDCoCB1MTYgaWZjdmZf
Z2V0X3ZxX3N0YXRlKHN0cnVjdCBpZmN2Zl9odyAqaHcsIHUxNiBxaWQpOwo+Pj4+Pj4+IMKgIGlu
dCBpZmN2Zl9zZXRfdnFfc3RhdGUoc3RydWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCwgdTE2IG51
bSk7Cj4+Pj4+Pj4gwqAgc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKnZmX3RvX2FkYXB0ZXIoc3RydWN0
IGlmY3ZmX2h3ICpodyk7Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMgCj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+
Pj4+Pj4gaW5kZXggMjVmYjlkZmUyM2YwLi5mNjI0ZjIwMjQ0N2QgMTAwNjQ0Cj4+Pj4+Pj4gLS0t
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4+Pj4+PiBAQCAtMTc5LDYgKzE3OSwxMSBAQCBzdGF0
aWMgdTY0IGlmY3ZmX3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCAKPj4+Pj4+PiB2ZHBhX2Rldmlj
ZSAqdmRwYV9kZXYpCj4+Pj4+Pj4gwqAgc3RhdGljIGludCBpZmN2Zl92ZHBhX3NldF9mZWF0dXJl
cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgCj4+Pj4+Pj4gKnZkcGFfZGV2LCB1NjQgZmVhdHVyZXMpCj4+
Pj4+Pj4gwqAgewo+Pj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFf
dG9fdmYodmRwYV9kZXYpOwo+Pj4+Pj4+ICvCoMKgwqAgaW50IHJldDsKPj4+Pj4+PiArCj4+Pj4+
Pj4gK8KgwqDCoCByZXQgPSBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKHZmKTsKPj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pj4gU28gdGhpcyB2YWxpZGF0ZSBkZXZpY2UgZmVhdHVyZXMgaW5zdGVhZCBvZiBk
cml2ZXIgd2hpY2ggaXMgdGhlIAo+Pj4+Pj4gb25lIHdlIHJlYWxseSB3YW50IHRvIGNoZWNrPwo+
Pj4+Pj4KPj4+Pj4+IFRoYW5rcwo+Pj4+Pgo+Pj4+PiBIaSBKYXNvbiwKPj4+Pj4KPj4+Pj4gSGVy
ZSB3ZSBjaGVjayBkZXZpY2UgZmVhdHVyZSBiaXRzIHRvIG1ha2Ugc3VyZSB0aGUgZGV2aWNlIHN1
cHBvcnQgCj4+Pj4+IEFDQ0VTU19QTEFURk9STS4gCj4+Pj4KPj4+Pgo+Pj4+IElmIHlvdSB3YW50
IHRvIGNoZWNrIGRldmljZSBmZWF0dXJlcywgeW91IG5lZWQgdG8gZG8gdGhhdCBkdXJpbmcgCj4+
Pj4gcHJvYmUoKSBhbmQgZmFpbCB0aGUgcHJvYmluZyBpZiB3aXRob3V0IHRoZSBmZWF0dXJlLiBC
dXQgSSB0aGluayAKPj4+PiB5b3Ugd29uJ3Qgc2hpcCBjYXJkcyB3aXRob3V0IEFDQ0VTU19QTEFU
Rk9STS4KPj4+IFllcywgdGhlcmUgYXJlIG5vIHJlYXNvbnMgc2hpcCBhIGNhcmQgd2l0aG91dCBB
Q0NFU1NfUExBVEZPUk0KPj4+Pgo+Pj4+Cj4+Pj4+IEluIGdldF9mZWF0dXJlcygpLAo+Pj4+PiBp
dCB3aWxsIHJldHVybiBhIGludGVyc2VjdGlvbiBvZiBkZXZpY2UgZmVhdHVyZXMgYml0IGFuZCBk
cml2ZXIgCj4+Pj4+IHN1cHBvcnRlZCBmZWF0dXJlcyBiaXRzKHdoaWNoIGluY2x1ZGVzIEFDQ0VT
U19QTEFURk9STSkuCj4+Pj4+IE90aGVyIGNvbXBvbmVudHMgbGlrZSBRRU1VIHNob3VsZCBub3Qg
c2V0IGZlYXR1cmVzIGJpdHMgbW9yZSB0aGFuIAo+Pj4+PiB0aGlzIGludGVyc2VjdGlvbiBvZiBi
aXRzLiBzbyB3ZSBjYW4gbWFrZSBzdXJlIGlmIHRoaXMKPj4+Pj4gaWZjdmZfdmVyaWZ5X21pbl9m
ZWF0dXJlcygpIHBhc3NlZCwgYm90aCBkZXZpY2UgYW5kIGRyaXZlciBzdXBwb3J0IAo+Pj4+PiBB
Q0NFU1NfUExBVEZPUk0uCj4+Pj4+Cj4+Pj4+IEFyZSB5b3Ugc3VnZ2VzdGluZyBjaGVjayBkcml2
ZXIgZmVhdHVyZSBiaXRzIGluIAo+Pj4+PiBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKCkgaW4g
dGhlIG1lYW50aW1lIGFzIHdlbGw/Cj4+Pj4KPj4+Pgo+Pj4+IFNvIGl0IHJlYWxseSBkZXBlbmRz
IG9uIHlvdXIgaGFyZHdhcmUuIElmIHlvdSBoYXJkd2FyZSBjYW4gYWx3YXlzIAo+Pj4+IG9mZmVy
IEFDQ0VTU19QTEFURk9STSwgeW91IGp1c3QgbmVlZCB0byBjaGVjayBkcml2ZXIgZmVhdHVyZXMu
IFRoaXMgCj4+Pj4gaXMgaG93IHZkcGFfc2ltIGFuZCBtbHg1X3ZkcGEgd29yay4KPj4+IFllcywg
d2UgYWx3YXlzIHN1cHBvcnQgQUNDRVNTX1BMQVRGT1JNLCBzbyBpdCBpcyBoYXJkIGNvZGVkIGlu
IHRoZSAKPj4+IG1hY3JvIElGQ1ZGX1NVUFBPUlRFRF9GRUFUVVJFUy4KPj4KPj4KPj4gVGhhdCdz
IG5vdCB3aGF0IEkgcmVhZCBmcm9tIHRoZSBjb2RlOgo+Pgo+PiDCoMKgwqDCoMKgwqDCoCBmZWF0
dXJlcyA9IGlmY3ZmX2dldF9mZWF0dXJlcyh2ZikgJiBJRkNWRl9TVVBQT1JURURfRkVBVFVSRVM7
Cj4gaWZjdmZfZ2V0X2ZlYXR1cmVzKCkgcmVhZHMgZGV2aWNlIGZlYXR1cmUgYml0cyh3aGljaCBz
aG91bGQgYWx3YXlzIGhhcyAKPiBBQ0NTU1NfUExBVEZPUk0pIGFuZCBJRkNWRl9TVVBQT1JURURf
RkVBVFVSRVMgaXMgdGhlIGRyaXZlciBzdXBwb3J0ZWQgCj4gZmVhdHVyZSBiaXRzIAoKCkZvciAi
ZHJpdmVyIiB5b3UgcHJvYmFibHkgbWVhbiBJRkNWRi4gU28gdGhlcmUncyBzb21lIG1pc3VuZGVy
c3RhbmRpbmcgCmJlZm9yZSwgd2hhdCBJIG1lYW50IGZvciAiZHJpdmVyIiBpcyB2aXJ0aW8gZHJp
dmVyIHRoYXQgZG8gZmVhdHVyZSAKbmVnb3RhaXRhdGlvbiB3aXRoIHRoZSBkZXZpY2UuCgpJIHdv
bmRlciB3aGF0IGZlYXR1cmVzIGFyZSBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZSBidXQgbm90IHRo
ZSBJRkNWRiBkcml2ZXI/CgpUaGFua3MKCgo+IHdoaWNoIGhhcmQgY29kZWQgQUNDRVNTX1BMQVRG
T1JNLCBzbyB0aGUgaW50ZXJzZWN0aW9uIHNob3VsZCBpbmNsdWRlIAo+IEFDQ0VTU19QTEFURk9S
TS4KPiB0aGUgaW50ZXJzZWN0aW9uICJmZWF0dXJlcyIgaXMgcmV0dXJuZWQgaW4gZ2V0X2ZlYXR1
cmVzKCksIHFlbXUgc2hvdWxkIAo+IHNldCBmZWF0dXJlcyBhY2NvcmRpbmcgdG8gaXQuCj4+Cj4+
Cj4+PiBOb3cgd2UgY2hlY2sgd2hldGhlciBkZXZpY2Ugc3VwcG9ydCB0aGlzIGZlYXR1cmUgYml0
IGFzIGEgZG91YmxlIAo+Pj4gY29uZm9ybWF0aW9uLCBhcmUgeW91IHN1Z2dlc3Rpbmcgd2Ugc2hv
dWxkIGNoZWNrIHdoZXRoZXIgCj4+PiBBQ0NFU1NfUExBVEZPUk0gJiBJRkNWRl9TVVBQT1JURURf
RkVBVFVSRVMKPj4+IGluIHNldF9mZWF0dXJlcygpIGFzIHdlbGw/Cj4+Cj4+Cj4+IElmIHdlIGtu
b3cgZGV2aWNlIHdpbGwgYWx3YXlzIG9mZmVyIEFDQ0VTU19QTEFURk9STSwgdGhlcmUncyBubyBu
ZWVkIAo+PiB0byBjaGVjayBpdCBhZ2Fpbi4gV2hhdCB3ZSBzaG91bGQgY2hlY2sgaWYgd2hldGhl
ciBkcml2ZXIgc2V0IHRoYXQsIAo+PiBhbmQgaWYgaXQgZG9lc24ndCB3ZSBuZWVkIHRvIGZhaWwg
c2V0X2ZlYXR1cmVzKCkuIEkgdGhpbmsgdGhlcmUncyAKPj4gbGl0dGxlIGNoYW5jZSB0aGF0IElG
Q1ZGIGNhbiB3b3JrIHdoZW4gSU9NTVVfUExBVEZPUk0gaXMgbm90IG5lZ290aWF0ZWQuCj4gQWdy
ZWUsIHdpbGwgY2hlY2sgdGhlIGZlYXR1cmVzIGJpdCB0byBzZXQgaW5zdGVhZCBvZiBkZXZpY2Ug
ZmVhdHVyZSAKPiBiaXRzLiBUaGFua3MhCj4+Cj4+Cj4+Cj4+PiBJIHByZWZlciBjaGVjayBib3Ro
IGRldmljZSBhbmQgSUZDVkZfU1VQUE9SVEVEX0ZFQVRVUkVTIGJvdGgsIG1vcmUgCj4+PiByZWxp
YWJsZS4KPj4KPj4KPj4gU28gYWdhaW4sIGlmIHlvdSB3YW50IHRvIGNoZWNrIGRldmljZSBmZWF0
dXJlcywgc2V0X2ZlYXR1cmVzKCkgaXMgbm90IAo+PiB0aGUgcHJvcGVyIHBsYWNlLiBXZSBuZWVk
IHRvIGZhaWwgdGhlIHByb2JlIGluIHRoaXMgY2FzZS4KPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+Pgo+
Pj4gVGhhbmtzIQo+Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+Pgo+Pj4+PiBUaGFua3Pv
vIEKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+ICvCoMKgwqAgaWYgKHJldCkKPj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+Pj4+PiDCoCDCoMKgwqDCoMKgIHZmLT5yZXFfZmVhdHVy
ZXMgPSBmZWF0dXJlczsKPj4+Pj4+Cj4+Pj4+PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+Pj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4+
Pj4+PiBWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4+Pj4gaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24KPj4+Pj4KPj4+Pgo+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

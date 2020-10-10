Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08929C433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 02:27:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E87C221FD
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 02:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWbb6HMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E87C221FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 55E0884E5E;
	Sat, 10 Oct 2020 02:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frsBjqHLd4bc; Sat, 10 Oct 2020 02:27:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5FFFB84D9A;
	Sat, 10 Oct 2020 02:27:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C276C016F;
	Sat, 10 Oct 2020 02:27:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93A3AC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 767D2875B5
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:27:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddZfsUN0NUnI
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:27:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 939D287585
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 02:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602296873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12HYuK0Nk24tj0+2XOPv/OD1JosPiyVfbvcjChBbyBo=;
 b=HWbb6HMKe5nGwcvrgp8qhXITk4jZ2UwpJDLAf6sldjYgKDPA768+v1nV6kLhmbx2dvCFcA
 mRA9463XPjxQet8kvQ7OqnpiB6tpfTUiK5lmC3WLw5XbmvDtCvERRdQ3eito65RIwVaYV8
 TJIjwCtJNaTk2hYAnalvCk1M9on/OTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-o5FaSILcPOSSXt_gosPSqQ-1; Fri, 09 Oct 2020 22:27:51 -0400
X-MC-Unique: o5FaSILcPOSSXt_gosPSqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 779BA805F05;
 Sat, 10 Oct 2020 02:27:49 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFA5319728;
 Sat, 10 Oct 2020 02:27:40 +0000 (UTC)
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
Date: Sat, 10 Oct 2020 10:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTAvMyDkuIvljYgxOjAyLCBTaS1XZWkgTGl1IHdyb3RlOgo+IFBpbm5lZCBwYWdl
cyBhcmUgbm90IHByb3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+IG1hcHBpbmcg
ZXJyb3Igb2NjdXJzIG9uIElPVExCIHVwZGF0ZS4gQ2xlYW4gdXAgZGFuZ2xpbmcKPiBwaW5uZWQg
cGFnZXMgZm9yIHRoZSBlcnJvciBwYXRoLiBBcyB0aGUgaW5mbGlnaHQgcGlubmVkCj4gcGFnZXMs
IHNwZWNpZmljYWxseSBmb3IgbWVtb3J5IHJlZ2lvbiB0aGF0IHN0cmlkZXMgYWNyb3NzCj4gbXVs
dGlwbGUgY2h1bmtzLCB3b3VsZCBuZWVkIG1vcmUgdGhhbiBvbmUgZnJlZSBwYWdlIGZvcgo+IGJv
b2sga2VlcGluZyBhbmQgYWNjb3VudGluZy4gRm9yIHNpbXBsaWNpdHksIHBpbiBwYWdlcwo+IGZv
ciBhbGwgbWVtb3J5IGluIHRoZSBJT1ZBIHJhbmdlIGluIG9uZSBnbyByYXRoZXIgdGhhbgo+IGhh
dmUgbXVsdGlwbGUgcGluX3VzZXJfcGFnZXMgY2FsbHMgdG8gbWFrZSB1cCB0aGUgZW50aXJlCj4g
cmVnaW9uLiBUaGlzIHdheSBpdCdzIGVhc2llciB0byB0cmFjayBhbmQgYWNjb3VudCB0aGUKPiBw
YWdlcyBhbHJlYWR5IG1hcHBlZCwgcGFydGljdWxhcmx5IGZvciBjbGVhbi11cCBpbiB0aGUKPiBl
cnJvciBwYXRoLgo+Cj4gRml4ZXM6IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQ
QS1iYXNlZCBiYWNrZW5kIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1
QG9yYWNsZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MzoKPiAtIEZhY3RvciBvdXQgdmhvc3Rf
dmRwYV9tYXAoKSBjaGFuZ2UgdG8gYSBzZXBhcmF0ZSBwYXRjaAo+Cj4gQ2hhbmdlcyBpbiB2MjoK
PiAtIEZpeCBpbmNvcnJlY3QgdGFyZ2V0IFNIQTEgcmVmZXJlbmNlZAo+Cj4gICBkcml2ZXJzL3Zo
b3N0L3ZkcGEuYyB8IDExOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCA0OCBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gaW5kZXggMGYyNzkxOS4uZGFkNDFkYWUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC01OTUs
MjEgKzU5NSwxOSBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJc3RydWN0IHZob3N0X2RldiAqZGV2ID0gJnYtPnZk
ZXY7Cj4gICAJc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiA9IGRldi0+aW90bGI7Cj4gICAJc3Ry
dWN0IHBhZ2UgKipwYWdlX2xpc3Q7Cj4gLQl1bnNpZ25lZCBsb25nIGxpc3Rfc2l6ZSA9IFBBR0Vf
U0laRSAvIHNpemVvZihzdHJ1Y3QgcGFnZSAqKTsKPiArCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
KnZtYXM7Cj4gICAJdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZPTExfTE9OR1RFUk07Cj4gLQl1
bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9wZm4sIGxhc3RfcGZuID0gMDsKPiAt
CXVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0LCBwaW5uZWQsIGk7Cj4gKwl1bnNpZ25l
ZCBsb25nIG1hcF9wZm4sIGxhc3RfcGZuID0gMDsKPiArCXVuc2lnbmVkIGxvbmcgbnBhZ2VzLCBs
b2NrX2xpbWl0Owo+ICsJdW5zaWduZWQgbG9uZyBpLCBubWFwID0gMDsKPiAgIAl1NjQgaW92YSA9
IG1zZy0+aW92YTsKPiArCWxvbmcgcGlubmVkOwo+ICAgCWludCByZXQgPSAwOwo+ICAgCj4gICAJ
aWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxiLCBtc2ctPmlvdmEsCj4gICAJCQkJICAg
IG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEpKQo+ICAgCQlyZXR1cm4gLUVFWElTVDsKPiAgIAo+
IC0JcGFnZV9saXN0ID0gKHN0cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5F
TCk7Cj4gLQlpZiAoIXBhZ2VfbGlzdCkKPiAtCQlyZXR1cm4gLUVOT01FTTsKPiAtCj4gICAJaWYg
KG1zZy0+cGVybSAmIFZIT1NUX0FDQ0VTU19XTykKPiAgIAkJZ3VwX2ZsYWdzIHw9IEZPTExfV1JJ
VEU7Cj4gICAKPiBAQCAtNjE3LDYxICs2MTUsODYgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3By
b2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCWlmICghbnBhZ2Vz
KQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+ICsJcGFnZV9saXN0ID0ga3ZtYWxsb2NfYXJy
YXkobnBhZ2VzLCBzaXplb2Yoc3RydWN0IHBhZ2UgKiksIEdGUF9LRVJORUwpOwo+ICsJdm1hcyA9
IGt2bWFsbG9jX2FycmF5KG5wYWdlcywgc2l6ZW9mKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqKSwK
PiArCQkJICAgICAgR0ZQX0tFUk5FTCk7CgoKVGhpcyB3aWxsIHJlc3VsdCBoaWdoIG9yZGVyIG1l
bW9yeSBhbGxvY2F0aW9uIHdoaWNoIHdhcyB3aGF0IHRoZSBjb2RlIAp0cmllZCB0byBhdm9pZCBv
cmlnaW5hbGx5LgoKVXNpbmcgYW4gdW5saW1pdGVkIHNpemUgd2lsbCBjYXVzZSBhIGxvdCBvZiBz
aWRlIGVmZmVjdHMgY29uc2lkZXIgVk0gb3IgCnVzZXJzcGFjZSBtYXkgdHJ5IHRvIHBpbiBzZXZl
cmFsIFRCIG9mIG1lbW9yeS4KCgo+ICsJaWYgKCFwYWdlX2xpc3QgfHwgIXZtYXMpIHsKPiArCQly
ZXQgPSAtRU5PTUVNOwo+ICsJCWdvdG8gZnJlZTsKPiArCX0KCgpBbnkgcmVhc29uIHRoYXQgeW91
IHdhbnQgdG8gdXNlIHZtYXM/CgoKPiArCj4gICAJbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4g
ICAKPiAtCWxvY2tlZCA9IGF0b21pYzY0X2FkZF9yZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlu
bmVkX3ZtKTsKPiAgIAlsb2NrX2xpbWl0ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdF
X1NISUZUOwo+IC0KPiAtCWlmIChsb2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4gKwlpZiAobnBhZ2Vz
ICsgYXRvbWljNjRfcmVhZCgmZGV2LT5tbS0+cGlubmVkX3ZtKSA+IGxvY2tfbGltaXQpIHsKPiAg
IAkJcmV0ID0gLUVOT01FTTsKPiAtCQlnb3RvIG91dDsKPiArCQlnb3RvIHVubG9jazsKPiAgIAl9
Cj4gICAKPiAtCWN1cl9iYXNlID0gbXNnLT51YWRkciAmIFBBR0VfTUFTSzsKPiAtCWlvdmEgJj0g
UEFHRV9NQVNLOwo+ICsJcGlubmVkID0gcGluX3VzZXJfcGFnZXMobXNnLT51YWRkciAmIFBBR0Vf
TUFTSywgbnBhZ2VzLCBndXBfZmxhZ3MsCj4gKwkJCQlwYWdlX2xpc3QsIHZtYXMpOwo+ICsJaWYg
KG5wYWdlcyAhPSBwaW5uZWQpIHsKPiArCQlpZiAocGlubmVkIDwgMCkgewo+ICsJCQlyZXQgPSBw
aW5uZWQ7Cj4gKwkJfSBlbHNlIHsKPiArCQkJdW5waW5fdXNlcl9wYWdlcyhwYWdlX2xpc3QsIHBp
bm5lZCk7Cj4gKwkJCXJldCA9IC1FTk9NRU07Cj4gKwkJfQo+ICsJCWdvdG8gdW5sb2NrOwo+ICsJ
fQo+ICAgCj4gLQl3aGlsZSAobnBhZ2VzKSB7Cj4gLQkJcGlubmVkID0gbWluX3QodW5zaWduZWQg
bG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+IC0JCXJldCA9IHBpbl91c2VyX3BhZ2VzKGN1cl9i
YXNlLCBwaW5uZWQsCj4gLQkJCQkgICAgIGd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPiAt
CQlpZiAocmV0ICE9IHBpbm5lZCkKPiAtCQkJZ290byBvdXQ7Cj4gLQo+IC0JCWlmICghbGFzdF9w
Zm4pCj4gLQkJCW1hcF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0pOwo+IC0KPiAtCQlm
b3IgKGkgPSAwOyBpIDwgcmV0OyBpKyspIHsKPiAtCQkJdW5zaWduZWQgbG9uZyB0aGlzX3BmbiA9
IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFtpXSk7Cj4gLQkJCXU2NCBjc2l6ZTsKPiAtCj4gLQkJCWlm
IChsYXN0X3BmbiAmJiAodGhpc19wZm4gIT0gbGFzdF9wZm4gKyAxKSkgewo+IC0JCQkJLyogUGlu
IGEgY29udGlndW91cyBjaHVuayBvZiBtZW1vcnkgKi8KPiAtCQkJCWNzaXplID0gKGxhc3RfcGZu
IC0gbWFwX3BmbiArIDEpIDw8IFBBR0VfU0hJRlQ7Cj4gLQkJCQlpZiAodmhvc3RfdmRwYV9tYXAo
diwgaW92YSwgY3NpemUsCj4gLQkJCQkJCSAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiAtCQkJ
CQkJICAgbXNnLT5wZXJtKSkKPiAtCQkJCQlnb3RvIG91dDsKPiAtCQkJCW1hcF9wZm4gPSB0aGlz
X3BmbjsKPiAtCQkJCWlvdmEgKz0gY3NpemU7Cj4gKwlpb3ZhICY9IFBBR0VfTUFTSzsKPiArCW1h
cF9wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbMF0pOwo+ICsKPiArCS8qIE9uZSBtb3JlIGl0
ZXJhdGlvbiB0byBhdm9pZCBleHRyYSB2ZHBhX21hcCgpIGNhbGwgb3V0IG9mIGxvb3AuICovCj4g
Kwlmb3IgKGkgPSAwOyBpIDw9IG5wYWdlczsgaSsrKSB7Cj4gKwkJdW5zaWduZWQgbG9uZyB0aGlz
X3BmbjsKPiArCQl1NjQgY3NpemU7Cj4gKwo+ICsJCS8qIFRoZSBsYXN0IGNodW5rIG1heSBoYXZl
IG5vIHZhbGlkIFBGTiBuZXh0IHRvIGl0ICovCj4gKwkJdGhpc19wZm4gPSBpIDwgbnBhZ2VzID8g
cGFnZV90b19wZm4ocGFnZV9saXN0W2ldKSA6IC0xVUw7Cj4gKwo+ICsJCWlmIChsYXN0X3BmbiAm
JiAodGhpc19wZm4gPT0gLTFVTCB8fAo+ICsJCQkJIHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkp
IHsKPiArCQkJLyogUGluIGEgY29udGlndW91cyBjaHVuayBvZiBtZW1vcnkgKi8KPiArCQkJY3Np
emUgPSBsYXN0X3BmbiAtIG1hcF9wZm4gKyAxOwo+ICsJCQlyZXQgPSB2aG9zdF92ZHBhX21hcCh2
LCBpb3ZhLCBjc2l6ZSA8PCBQQUdFX1NISUZULAo+ICsJCQkJCSAgICAgbWFwX3BmbiA8PCBQQUdF
X1NISUZULAo+ICsJCQkJCSAgICAgbXNnLT5wZXJtKTsKPiArCQkJaWYgKHJldCkgewo+ICsJCQkJ
LyoKPiArCQkJCSAqIFVucGluIHRoZSByZXN0IGNodW5rcyBvZiBtZW1vcnkgb24gdGhlCj4gKwkJ
CQkgKiBmbGlnaHQgd2l0aCBubyBjb3JyZXNwb25kaW5nIHZkcGFfbWFwKCkKPiArCQkJCSAqIGNh
bGxzIGhhdmluZyBiZWVuIG1hZGUgeWV0LiBPbiB0aGUgb3RoZXIKPiArCQkJCSAqIGhhbmQsIHZk
cGFfdW5tYXAoKSBpbiB0aGUgZmFpbHVyZSBwYXRoCj4gKwkJCQkgKiBpcyBpbiBjaGFyZ2Ugb2Yg
YWNjb3VudGluZyB0aGUgbnVtYmVyIG9mCj4gKwkJCQkgKiBwaW5uZWQgcGFnZXMgZm9yIGl0cyBv
d24uCj4gKwkJCQkgKiBUaGlzIGFzeW1tZXRyaWNhbCBwYXR0ZXJuIG9mIGFjY291bnRpbmcKPiAr
CQkJCSAqIGlzIGZvciBlZmZpY2llbmN5IHRvIHBpbiBhbGwgcGFnZXMgYXQKPiArCQkJCSAqIG9u
Y2UsIHdoaWxlIHRoZXJlIGlzIG5vIG90aGVyIGNhbGxzaXRlCj4gKwkJCQkgKiBvZiB2ZHBhX21h
cCgpIHRoYW4gaGVyZSBhYm92ZS4KPiArCQkJCSAqLwo+ICsJCQkJdW5waW5fdXNlcl9wYWdlcygm
cGFnZV9saXN0W25tYXBdLAo+ICsJCQkJCQkgbnBhZ2VzIC0gbm1hcCk7Cj4gKwkJCQlnb3RvIG91
dDsKPiAgIAkJCX0KPiAtCj4gLQkJCWxhc3RfcGZuID0gdGhpc19wZm47Cj4gKwkJCWF0b21pYzY0
X2FkZChjc2l6ZSwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4gKwkJCW5tYXAgKz0gY3NpemU7Cj4g
KwkJCWlvdmEgKz0gY3NpemUgPDwgUEFHRV9TSElGVDsKPiArCQkJbWFwX3BmbiA9IHRoaXNfcGZu
Owo+ICAgCQl9Cj4gLQo+IC0JCWN1cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+IC0JCW5w
YWdlcyAtPSByZXQ7Cj4gKwkJbGFzdF9wZm4gPSB0aGlzX3BmbjsKPiAgIAl9CgoKU28gd2hhdCBJ
IHN1Z2dlc3QgaXMgdG8gZml4IHRoZSBwaW5uaW5nIGxlYWthZ2UgZmlyc3QgYW5kIGRvIHRoZSAK
cG9zc2libGUgb3B0aW1pemF0aW9uIG9uIHRvcCAod2hpY2ggaXMgc3RpbGwgcXVlc3Rpb25hYmxl
IHRvIG1lKS4KClRoYW5rcwoKCj4gICAKPiAtCS8qIFBpbiB0aGUgcmVzdCBjaHVuayAqLwo+IC0J
cmV0ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwgKGxhc3RfcGZuIC0gbWFwX3BmbiArIDEpIDw8
IFBBR0VfU0hJRlQsCj4gLQkJCSAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULCBtc2ctPnBlcm0p
Owo+ICsJV0FSTl9PTihubWFwICE9IG5wYWdlcyk7Cj4gICBvdXQ6Cj4gLQlpZiAocmV0KSB7Cj4g
KwlpZiAocmV0KQo+ICAgCQl2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92YSwgbXNnLT5zaXpl
KTsKPiAtCQlhdG9taWM2NF9zdWIobnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAtCX0K
PiArdW5sb2NrOgo+ICAgCW1tYXBfcmVhZF91bmxvY2soZGV2LT5tbSk7Cj4gLQlmcmVlX3BhZ2Uo
KHVuc2lnbmVkIGxvbmcpcGFnZV9saXN0KTsKPiArZnJlZToKPiArCWt2ZnJlZSh2bWFzKTsKPiAr
CWt2ZnJlZShwYWdlX2xpc3QpOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

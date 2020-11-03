Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4812DC2D0A3
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 08:54:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B856F2071A
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 08:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIBjsleE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B856F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4884786A4F;
	Tue,  3 Nov 2020 08:54:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lc1krxlYUdWe; Tue,  3 Nov 2020 08:54:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9CD29815F4;
	Tue,  3 Nov 2020 08:54:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F023C0889;
	Tue,  3 Nov 2020 08:54:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8C5FC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 08:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DBB2E86A4F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 08:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UxKcl7WVWVA5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 08:54:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C3E54815F4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 08:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604393645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OQfTZ4/yLchqNBLCJcAj/4AvwpoGngxw+tG1Kqjj4u0=;
 b=VIBjsleEF21sVnlhpBcnoLEoc/g4I7D4RLGyM5OMHsnsmZTdN+DKBZ/W2994N58+oY2ieO
 vFbzTTiypkhyzvdsgnamTYdUDG/sR7mRFR8wIGwu2XN4eiyyrFONOygz4REvjS54ox+kSn
 06BjvGNZP3RU8l9WFdBs4l8lLUNja9k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-17qyTZoZNHyXfsNLIKtlCg-1; Tue, 03 Nov 2020 03:54:03 -0500
X-MC-Unique: 17qyTZoZNHyXfsNLIKtlCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41AA2879514;
 Tue,  3 Nov 2020 08:54:02 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC4EB389;
 Tue,  3 Nov 2020 08:53:49 +0000 (UTC)
Subject: Re: [PATCH 1/2] Revert "vhost-vdpa: fix page pinning leakage in error
 path"
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <174406aa-9a3a-5def-530d-cd19b451be99@redhat.com>
Date: Tue, 3 Nov 2020 16:53:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTAvMzAg5LiL5Y2IMzo0NSwgU2ktV2VpIExpdSB3cm90ZToKPiBUaGlzIHJldmVy
dHMgY29tbWl0IDdlZDllM2Q5N2MzMmQ5NjljYWRlZDJkZmI2ZTY3YzFhMmNjNWEwYjEuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDExOSArKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25z
KCspLCA3MSBkZWxldGlvbnMoLSkKCgpJIHNhdyB0aGlzIGhhcyBiZWVuIHJldmVydGVkIHRoZXJl
IApodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxk
cy9saW51eC5naXQvY29tbWl0L2RyaXZlcnMvdmhvc3Q/aWQ9NWUxYTMxNDllZWM4Njc1YzI3Njdj
YzQ2NTkwM2Y1ZTQ4MjlkZTViMC4KCjopCgpUaGFua3MKCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBhMmRiYzg1Li5i
NmQ5MDE2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPiBAQCAtNTg4LDE5ICs1ODgsMjEgQEAgc3RhdGljIGludCB2aG9zdF92
ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCXN0cnVj
dCB2aG9zdF9kZXYgKmRldiA9ICZ2LT52ZGV2Owo+ICAgCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90
bGIgPSBkZXYtPmlvdGxiOwo+ICAgCXN0cnVjdCBwYWdlICoqcGFnZV9saXN0Owo+IC0Jc3RydWN0
IHZtX2FyZWFfc3RydWN0ICoqdm1hczsKPiArCXVuc2lnbmVkIGxvbmcgbGlzdF9zaXplID0gUEFH
RV9TSVpFIC8gc2l6ZW9mKHN0cnVjdCBwYWdlICopOwo+ICAgCXVuc2lnbmVkIGludCBndXBfZmxh
Z3MgPSBGT0xMX0xPTkdURVJNOwo+IC0JdW5zaWduZWQgbG9uZyBtYXBfcGZuLCBsYXN0X3BmbiA9
IDA7Cj4gLQl1bnNpZ25lZCBsb25nIG5wYWdlcywgbG9ja19saW1pdDsKPiAtCXVuc2lnbmVkIGxv
bmcgaSwgbm1hcCA9IDA7Cj4gKwl1bnNpZ25lZCBsb25nIG5wYWdlcywgY3VyX2Jhc2UsIG1hcF9w
Zm4sIGxhc3RfcGZuID0gMDsKPiArCXVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0LCBw
aW5uZWQsIGk7Cj4gICAJdTY0IGlvdmEgPSBtc2ctPmlvdmE7Cj4gLQlsb25nIHBpbm5lZDsKPiAg
IAlpbnQgcmV0ID0gMDsKPiAgIAo+ICAgCWlmICh2aG9zdF9pb3RsYl9pdHJlZV9maXJzdChpb3Rs
YiwgbXNnLT5pb3ZhLAo+ICAgCQkJCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPiAg
IAkJcmV0dXJuIC1FRVhJU1Q7Cj4gICAKPiArCXBhZ2VfbGlzdCA9IChzdHJ1Y3QgcGFnZSAqKikg
X19nZXRfZnJlZV9wYWdlKEdGUF9LRVJORUwpOwo+ICsJaWYgKCFwYWdlX2xpc3QpCj4gKwkJcmV0
dXJuIC1FTk9NRU07Cj4gKwo+ICAgCWlmIChtc2ctPnBlcm0gJiBWSE9TVF9BQ0NFU1NfV08pCj4g
ICAJCWd1cF9mbGFncyB8PSBGT0xMX1dSSVRFOwo+ICAgCj4gQEAgLTYwOCw4NiArNjEwLDYxIEBA
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwKPiAgIAlpZiAoIW5wYWdlcykKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAt
CXBhZ2VfbGlzdCA9IGt2bWFsbG9jX2FycmF5KG5wYWdlcywgc2l6ZW9mKHN0cnVjdCBwYWdlICop
LCBHRlBfS0VSTkVMKTsKPiAtCXZtYXMgPSBrdm1hbGxvY19hcnJheShucGFnZXMsIHNpemVvZihz
dHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKiksCj4gLQkJCSAgICAgIEdGUF9LRVJORUwpOwo+IC0JaWYg
KCFwYWdlX2xpc3QgfHwgIXZtYXMpIHsKPiAtCQlyZXQgPSAtRU5PTUVNOwo+IC0JCWdvdG8gZnJl
ZTsKPiAtCX0KPiAtCj4gICAJbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4gICAKPiArCWxvY2tl
ZCA9IGF0b21pYzY0X2FkZF9yZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAg
IAlsb2NrX2xpbWl0ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NISUZUOwo+IC0J
aWYgKG5wYWdlcyArIGF0b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xp
bWl0KSB7Cj4gLQkJcmV0ID0gLUVOT01FTTsKPiAtCQlnb3RvIHVubG9jazsKPiAtCX0KPiAgIAo+
IC0JcGlubmVkID0gcGluX3VzZXJfcGFnZXMobXNnLT51YWRkciAmIFBBR0VfTUFTSywgbnBhZ2Vz
LCBndXBfZmxhZ3MsCj4gLQkJCQlwYWdlX2xpc3QsIHZtYXMpOwo+IC0JaWYgKG5wYWdlcyAhPSBw
aW5uZWQpIHsKPiAtCQlpZiAocGlubmVkIDwgMCkgewo+IC0JCQlyZXQgPSBwaW5uZWQ7Cj4gLQkJ
fSBlbHNlIHsKPiAtCQkJdW5waW5fdXNlcl9wYWdlcyhwYWdlX2xpc3QsIHBpbm5lZCk7Cj4gLQkJ
CXJldCA9IC1FTk9NRU07Cj4gLQkJfQo+IC0JCWdvdG8gdW5sb2NrOwo+ICsJaWYgKGxvY2tlZCA+
IGxvY2tfbGltaXQpIHsKPiArCQlyZXQgPSAtRU5PTUVNOwo+ICsJCWdvdG8gb3V0Owo+ICAgCX0K
PiAgIAo+ICsJY3VyX2Jhc2UgPSBtc2ctPnVhZGRyICYgUEFHRV9NQVNLOwo+ICAgCWlvdmEgJj0g
UEFHRV9NQVNLOwo+IC0JbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7Cj4gLQo+
IC0JLyogT25lIG1vcmUgaXRlcmF0aW9uIHRvIGF2b2lkIGV4dHJhIHZkcGFfbWFwKCkgY2FsbCBv
dXQgb2YgbG9vcC4gKi8KPiAtCWZvciAoaSA9IDA7IGkgPD0gbnBhZ2VzOyBpKyspIHsKPiAtCQl1
bnNpZ25lZCBsb25nIHRoaXNfcGZuOwo+IC0JCXU2NCBjc2l6ZTsKPiAtCj4gLQkJLyogVGhlIGxh
c3QgY2h1bmsgbWF5IGhhdmUgbm8gdmFsaWQgUEZOIG5leHQgdG8gaXQgKi8KPiAtCQl0aGlzX3Bm
biA9IGkgPCBucGFnZXMgPyBwYWdlX3RvX3BmbihwYWdlX2xpc3RbaV0pIDogLTFVTDsKPiAtCj4g
LQkJaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiA9PSAtMVVMIHx8Cj4gLQkJCQkgdGhpc19wZm4g
IT0gbGFzdF9wZm4gKyAxKSkgewo+IC0JCQkvKiBQaW4gYSBjb250aWd1b3VzIGNodW5rIG9mIG1l
bW9yeSAqLwo+IC0JCQljc2l6ZSA9IGxhc3RfcGZuIC0gbWFwX3BmbiArIDE7Cj4gLQkJCXJldCA9
IHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXplIDw8IFBBR0VfU0hJRlQsCj4gLQkJCQkJICAg
ICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4gLQkJCQkJICAgICBtc2ctPnBlcm0pOwo+IC0JCQlp
ZiAocmV0KSB7Cj4gLQkJCQkvKgo+IC0JCQkJICogVW5waW4gdGhlIHJlc3QgY2h1bmtzIG9mIG1l
bW9yeSBvbiB0aGUKPiAtCQkJCSAqIGZsaWdodCB3aXRoIG5vIGNvcnJlc3BvbmRpbmcgdmRwYV9t
YXAoKQo+IC0JCQkJICogY2FsbHMgaGF2aW5nIGJlZW4gbWFkZSB5ZXQuIE9uIHRoZSBvdGhlcgo+
IC0JCQkJICogaGFuZCwgdmRwYV91bm1hcCgpIGluIHRoZSBmYWlsdXJlIHBhdGgKPiAtCQkJCSAq
IGlzIGluIGNoYXJnZSBvZiBhY2NvdW50aW5nIHRoZSBudW1iZXIgb2YKPiAtCQkJCSAqIHBpbm5l
ZCBwYWdlcyBmb3IgaXRzIG93bi4KPiAtCQkJCSAqIFRoaXMgYXN5bW1ldHJpY2FsIHBhdHRlcm4g
b2YgYWNjb3VudGluZwo+IC0JCQkJICogaXMgZm9yIGVmZmljaWVuY3kgdG8gcGluIGFsbCBwYWdl
cyBhdAo+IC0JCQkJICogb25jZSwgd2hpbGUgdGhlcmUgaXMgbm8gb3RoZXIgY2FsbHNpdGUKPiAt
CQkJCSAqIG9mIHZkcGFfbWFwKCkgdGhhbiBoZXJlIGFib3ZlLgo+IC0JCQkJICovCj4gLQkJCQl1
bnBpbl91c2VyX3BhZ2VzKCZwYWdlX2xpc3Rbbm1hcF0sCj4gLQkJCQkJCSBucGFnZXMgLSBubWFw
KTsKPiAtCQkJCWdvdG8gb3V0Owo+ICsKPiArCXdoaWxlIChucGFnZXMpIHsKPiArCQlwaW5uZWQg
PSBtaW5fdCh1bnNpZ25lZCBsb25nLCBucGFnZXMsIGxpc3Rfc2l6ZSk7Cj4gKwkJcmV0ID0gcGlu
X3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPiArCQkJCSAgICAgZ3VwX2ZsYWdzLCBwYWdl
X2xpc3QsIE5VTEwpOwo+ICsJCWlmIChyZXQgIT0gcGlubmVkKQo+ICsJCQlnb3RvIG91dDsKPiAr
Cj4gKwkJaWYgKCFsYXN0X3BmbikKPiArCQkJbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlz
dFswXSk7Cj4gKwo+ICsJCWZvciAoaSA9IDA7IGkgPCByZXQ7IGkrKykgewo+ICsJCQl1bnNpZ25l
ZCBsb25nIHRoaXNfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0W2ldKTsKPiArCQkJdTY0IGNz
aXplOwo+ICsKPiArCQkJaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiAhPSBsYXN0X3BmbiArIDEp
KSB7Cj4gKwkJCQkvKiBQaW4gYSBjb250aWd1b3VzIGNodW5rIG9mIG1lbW9yeSAqLwo+ICsJCQkJ
Y3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVDsKPiArCQkJCWlm
ICh2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPiArCQkJCQkJICAgbWFwX3BmbiA8PCBQ
QUdFX1NISUZULAo+ICsJCQkJCQkgICBtc2ctPnBlcm0pKQo+ICsJCQkJCWdvdG8gb3V0Owo+ICsJ
CQkJbWFwX3BmbiA9IHRoaXNfcGZuOwo+ICsJCQkJaW92YSArPSBjc2l6ZTsKPiAgIAkJCX0KPiAt
CQkJYXRvbWljNjRfYWRkKGNzaXplLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAtCQkJbm1hcCAr
PSBjc2l6ZTsKPiAtCQkJaW92YSArPSBjc2l6ZSA8PCBQQUdFX1NISUZUOwo+IC0JCQltYXBfcGZu
ID0gdGhpc19wZm47Cj4gKwo+ICsJCQlsYXN0X3BmbiA9IHRoaXNfcGZuOwo+ICAgCQl9Cj4gLQkJ
bGFzdF9wZm4gPSB0aGlzX3BmbjsKPiArCj4gKwkJY3VyX2Jhc2UgKz0gcmV0IDw8IFBBR0VfU0hJ
RlQ7Cj4gKwkJbnBhZ2VzIC09IHJldDsKPiAgIAl9Cj4gICAKPiAtCVdBUk5fT04obm1hcCAhPSBu
cGFnZXMpOwo+ICsJLyogUGluIHRoZSByZXN0IGNodW5rICovCj4gKwlyZXQgPSB2aG9zdF92ZHBh
X21hcCh2LCBpb3ZhLCAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVCwKPiAr
CQkJICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsIG1zZy0+cGVybSk7Cj4gICBvdXQ6Cj4gLQlp
ZiAocmV0KQo+ICsJaWYgKHJldCkgewo+ICAgCQl2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92
YSwgbXNnLT5zaXplKTsKPiAtdW5sb2NrOgo+ICsJCWF0b21pYzY0X3N1YihucGFnZXMsICZkZXYt
Pm1tLT5waW5uZWRfdm0pOwo+ICsJfQo+ICAgCW1tYXBfcmVhZF91bmxvY2soZGV2LT5tbSk7Cj4g
LWZyZWU6Cj4gLQlrdmZyZWUodm1hcyk7Cj4gLQlrdmZyZWUocGFnZV9saXN0KTsKPiArCWZyZWVf
cGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xpc3QpOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4g
ICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

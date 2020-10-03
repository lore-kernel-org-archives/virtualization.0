Return-Path: <SRS0=p0Ab=DK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BBC4363C
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 02:02:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196AE20719
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 02:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkvm/6Gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196AE20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7C2F32014B;
	Sat,  3 Oct 2020 02:02:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id raX-KYt+C0-g; Sat,  3 Oct 2020 02:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0394A2043C;
	Sat,  3 Oct 2020 02:02:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D13A3C0889;
	Sat,  3 Oct 2020 02:02:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8B0EC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8941486BE8
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OzlkgTXTdIbm
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:02:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8EDC386B03
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 02:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601690551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiMlllEEKTQjIlICQJljkp75MtdRoQ3SeCkSnkimWXc=;
 b=dkvm/6Gyb1tdjYOn7VSNQZpjf5iFg2vR70wyfHbKqGFzAr0xDtp7iLfsSesjyKTVpuox54
 dBG1lLIRPNqCu1vpDaiPQpWhg6BMjS/RuND9POP4LybPs6EUaNwx1EPIN0Lc+Z5qAENNrc
 JgHOmOg8FshMbmLmRe16kXZcA+j2vfg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-OWteqTiIPCaVq9BquirjMw-1; Fri, 02 Oct 2020 22:02:27 -0400
X-MC-Unique: OWteqTiIPCaVq9BquirjMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B2B11006703;
 Sat,  3 Oct 2020 02:02:26 +0000 (UTC)
Received: from [10.72.12.21] (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E0DA1992F;
 Sat,  3 Oct 2020 02:02:17 +0000 (UTC)
Subject: Re: [PATCH] vhost-vdpa: fix page pinning leakage in error path
To: Si-Wei Liu <si-wei.liu@oracle.com>, tiwei.bie@intel.com,
 lingshan.zhu@intel.com, mst@redhat.com
References: <1601583799-15274-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <37df4421-7642-9b02-1859-af3a807d3e65@redhat.com>
Date: Sat, 3 Oct 2020 10:02:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601583799-15274-1-git-send-email-si-wei.liu@oracle.com>
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

Ck9uIDIwMjAvMTAvMiDkuIrljYg0OjIzLCBTaS1XZWkgTGl1IHdyb3RlOgo+IFBpbm5lZCBwYWdl
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
cnJvciBwYXRoLgo+Cj4gRml4ZXM6IDIwNDUzYTQ1ZmIwNiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQ
QS1iYXNlZCBiYWNrZW5kIikKPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1
QG9yYWNsZS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDEyMSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggNzk2
ZmU5Ny4uYWJjNGFhMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTU2NSw2ICs1NjUsOCBAQCBzdGF0aWMgaW50IHZo
b3N0X3ZkcGFfbWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCQkJICAgICAgcGVybV90b19p
b21tdV9mbGFncyhwZXJtKSk7Cj4gICAJfQo+ICAgCj4gKwlpZiAocikKPiArCQl2aG9zdF9pb3Rs
Yl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwgaW92YSArIHNpemUgLSAxKTsKPiAgIAlyZXR1
cm4gcjsKPiAgIH0KCgpQbGVhc2UgdXNlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMgZml4LgoK
Cj4gICAKPiBAQCAtNTkyLDIxICs1OTQsMTkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nl
c3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCXN0cnVjdCB2aG9zdF9k
ZXYgKmRldiA9ICZ2LT52ZGV2Owo+ICAgCXN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIgPSBkZXYt
PmlvdGxiOwo+ICAgCXN0cnVjdCBwYWdlICoqcGFnZV9saXN0Owo+IC0JdW5zaWduZWQgbG9uZyBs
aXN0X3NpemUgPSBQQUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4gKwlzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKip2bWFzOwo+ICAgCXVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBGT0xM
X0xPTkdURVJNOwo+IC0JdW5zaWduZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNlLCBtYXBfcGZuLCBs
YXN0X3BmbiA9IDA7Cj4gLQl1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwgcGlubmVk
LCBpOwo+ICsJdW5zaWduZWQgbG9uZyBtYXBfcGZuLCBsYXN0X3BmbiA9IDA7Cj4gKwl1bnNpZ25l
ZCBsb25nIG5wYWdlcywgbG9ja19saW1pdDsKPiArCXVuc2lnbmVkIGxvbmcgaSwgbm1hcCA9IDA7
Cj4gICAJdTY0IGlvdmEgPSBtc2ctPmlvdmE7Cj4gKwlsb25nIHBpbm5lZDsKPiAgIAlpbnQgcmV0
ID0gMDsKPiAgIAo+ICAgCWlmICh2aG9zdF9pb3RsYl9pdHJlZV9maXJzdChpb3RsYiwgbXNnLT5p
b3ZhLAo+ICAgCQkJCSAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPiAgIAkJcmV0dXJu
IC1FRVhJU1Q7Cj4gICAKPiAtCXBhZ2VfbGlzdCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJl
ZV9wYWdlKEdGUF9LRVJORUwpOwo+IC0JaWYgKCFwYWdlX2xpc3QpCj4gLQkJcmV0dXJuIC1FTk9N
RU07Cj4gLQo+ICAgCWlmIChtc2ctPnBlcm0gJiBWSE9TVF9BQ0NFU1NfV08pCj4gICAJCWd1cF9m
bGFncyB8PSBGT0xMX1dSSVRFOwo+ICAgCj4gQEAgLTYxNCw2MSArNjE0LDg2IEBAIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwK
PiAgIAlpZiAoIW5wYWdlcykKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiArCXBhZ2VfbGlz
dCA9IGt2bWFsbG9jX2FycmF5KG5wYWdlcywgc2l6ZW9mKHN0cnVjdCBwYWdlICopLCBHRlBfS0VS
TkVMKTsKPiArCXZtYXMgPSBrdm1hbGxvY19hcnJheShucGFnZXMsIHNpemVvZihzdHJ1Y3Qgdm1f
YXJlYV9zdHJ1Y3QgKiksCj4gKwkJCSAgICAgIEdGUF9LRVJORUwpOwo+ICsJaWYgKCFwYWdlX2xp
c3QgfHwgIXZtYXMpIHsKPiArCQlyZXQgPSAtRU5PTUVNOwo+ICsJCWdvdG8gZnJlZTsKPiArCX0K
PiArCj4gICAJbW1hcF9yZWFkX2xvY2soZGV2LT5tbSk7Cj4gICAKPiAtCWxvY2tlZCA9IGF0b21p
YzY0X2FkZF9yZXR1cm4obnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiAgIAlsb2NrX2xp
bWl0ID0gcmxpbWl0KFJMSU1JVF9NRU1MT0NLKSA+PiBQQUdFX1NISUZUOwo+IC0KPiAtCWlmIChs
b2NrZWQgPiBsb2NrX2xpbWl0KSB7Cj4gKwlpZiAobnBhZ2VzICsgYXRvbWljNjRfcmVhZCgmZGV2
LT5tbS0+cGlubmVkX3ZtKSA+IGxvY2tfbGltaXQpIHsKPiAgIAkJcmV0ID0gLUVOT01FTTsKPiAt
CQlnb3RvIG91dDsKPiArCQlnb3RvIHVubG9jazsKPiAgIAl9Cj4gICAKPiAtCWN1cl9iYXNlID0g
bXNnLT51YWRkciAmIFBBR0VfTUFTSzsKPiAtCWlvdmEgJj0gUEFHRV9NQVNLOwo+ICsJcGlubmVk
ID0gcGluX3VzZXJfcGFnZXMobXNnLT51YWRkciAmIFBBR0VfTUFTSywgbnBhZ2VzLCBndXBfZmxh
Z3MsCj4gKwkJCQlwYWdlX2xpc3QsIHZtYXMpOwo+ICsJaWYgKG5wYWdlcyAhPSBwaW5uZWQpIHsK
PiArCQlpZiAocGlubmVkIDwgMCkgewo+ICsJCQlyZXQgPSBwaW5uZWQ7Cj4gKwkJfSBlbHNlIHsK
PiArCQkJdW5waW5fdXNlcl9wYWdlcyhwYWdlX2xpc3QsIHBpbm5lZCk7Cj4gKwkJCXJldCA9IC1F
Tk9NRU07Cj4gKwkJfQo+ICsJCWdvdG8gdW5sb2NrOwo+ICsJfQo+ICAgCj4gLQl3aGlsZSAobnBh
Z2VzKSB7Cj4gLQkJcGlubmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3Np
emUpOwo+IC0JCXJldCA9IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBwaW5uZWQsCj4gLQkJCQkg
ICAgIGd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPiAtCQlpZiAocmV0ICE9IHBpbm5lZCkK
PiAtCQkJZ290byBvdXQ7Cj4gLQo+IC0JCWlmICghbGFzdF9wZm4pCj4gLQkJCW1hcF9wZm4gPSBw
YWdlX3RvX3BmbihwYWdlX2xpc3RbMF0pOwo+IC0KPiAtCQlmb3IgKGkgPSAwOyBpIDwgcmV0OyBp
KyspIHsKPiAtCQkJdW5zaWduZWQgbG9uZyB0aGlzX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlz
dFtpXSk7Cj4gLQkJCXU2NCBjc2l6ZTsKPiAtCj4gLQkJCWlmIChsYXN0X3BmbiAmJiAodGhpc19w
Zm4gIT0gbGFzdF9wZm4gKyAxKSkgewo+IC0JCQkJLyogUGluIGEgY29udGlndW91cyBjaHVuayBv
ZiBtZW1vcnkgKi8KPiAtCQkJCWNzaXplID0gKGxhc3RfcGZuIC0gbWFwX3BmbiArIDEpIDw8IFBB
R0VfU0hJRlQ7Cj4gLQkJCQlpZiAodmhvc3RfdmRwYV9tYXAodiwgaW92YSwgY3NpemUsCj4gLQkJ
CQkJCSAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiAtCQkJCQkJICAgbXNnLT5wZXJtKSkKPiAt
CQkJCQlnb3RvIG91dDsKPiAtCQkJCW1hcF9wZm4gPSB0aGlzX3BmbjsKPiAtCQkJCWlvdmEgKz0g
Y3NpemU7Cj4gKwlpb3ZhICY9IFBBR0VfTUFTSzsKPiArCW1hcF9wZm4gPSBwYWdlX3RvX3Bmbihw
YWdlX2xpc3RbMF0pOwo+ICsKPiArCS8qIE9uZSBtb3JlIGl0ZXJhdGlvbiB0byBhdm9pZCBleHRy
YSB2ZHBhX21hcCgpIGNhbGwgb3V0IG9mIGxvb3AuICovCj4gKwlmb3IgKGkgPSAwOyBpIDw9IG5w
YWdlczsgaSsrKSB7Cj4gKwkJdW5zaWduZWQgbG9uZyB0aGlzX3BmbjsKPiArCQl1NjQgY3NpemU7
Cj4gKwo+ICsJCS8qIFRoZSBsYXN0IGNodW5rIG1heSBoYXZlIG5vIHZhbGlkIFBGTiBuZXh0IHRv
IGl0ICovCj4gKwkJdGhpc19wZm4gPSBpIDwgbnBhZ2VzID8gcGFnZV90b19wZm4ocGFnZV9saXN0
W2ldKSA6IC0xVUw7Cj4gKwo+ICsJCWlmIChsYXN0X3BmbiAmJiAodGhpc19wZm4gPT0gLTFVTCB8
fAo+ICsJCQkJIHRoaXNfcGZuICE9IGxhc3RfcGZuICsgMSkpIHsKPiArCQkJLyogUGluIGEgY29u
dGlndW91cyBjaHVuayBvZiBtZW1vcnkgKi8KPiArCQkJY3NpemUgPSBsYXN0X3BmbiAtIG1hcF9w
Zm4gKyAxOwo+ICsJCQlyZXQgPSB2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSA8PCBQQUdF
X1NISUZULAo+ICsJCQkJCSAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULAo+ICsJCQkJCSAgICAg
bXNnLT5wZXJtKTsKPiArCQkJaWYgKHJldCkgewo+ICsJCQkJLyoKPiArCQkJCSAqIFVucGluIHRo
ZSByZXN0IGNodW5rcyBvZiBtZW1vcnkgb24gdGhlCj4gKwkJCQkgKiBmbGlnaHQgd2l0aCBubyBj
b3JyZXNwb25kaW5nIHZkcGFfbWFwKCkKPiArCQkJCSAqIGNhbGxzIGhhdmluZyBiZWVuIG1hZGUg
eWV0LiBPbiB0aGUgb3RoZXIKPiArCQkJCSAqIGhhbmQsIHZkcGFfdW5tYXAoKSBpbiB0aGUgZmFp
bHVyZSBwYXRoCj4gKwkJCQkgKiBpcyBpbiBjaGFyZ2Ugb2YgYWNjb3VudGluZyB0aGUgbnVtYmVy
IG9mCj4gKwkJCQkgKiBwaW5uZWQgcGFnZXMgZm9yIGl0cyBvd24uCj4gKwkJCQkgKiBUaGlzIGFz
eW1tZXRyaWNhbCBwYXR0ZXJuIG9mIGFjY291bnRpbmcKPiArCQkJCSAqIGlzIGZvciBlZmZpY2ll
bmN5IHRvIHBpbiBhbGwgcGFnZXMgYXQKPiArCQkJCSAqIG9uY2UsIHdoaWxlIHRoZXJlIGlzIG5v
IG90aGVyIGNhbGxzaXRlCj4gKwkJCQkgKiBvZiB2ZHBhX21hcCgpIHRoYW4gaGVyZSBhYm92ZS4K
PiArCQkJCSAqLwo+ICsJCQkJdW5waW5fdXNlcl9wYWdlcygmcGFnZV9saXN0W25tYXBdLAo+ICsJ
CQkJCQkgbnBhZ2VzIC0gbm1hcCk7Cj4gKwkJCQlnb3RvIG91dDsKPiAgIAkJCX0KPiAtCj4gLQkJ
CWxhc3RfcGZuID0gdGhpc19wZm47Cj4gKwkJCWF0b21pYzY0X2FkZChjc2l6ZSwgJmRldi0+bW0t
PnBpbm5lZF92bSk7Cj4gKwkJCW5tYXAgKz0gY3NpemU7Cj4gKwkJCWlvdmEgKz0gY3NpemUgPDwg
UEFHRV9TSElGVDsKPiArCQkJbWFwX3BmbiA9IHRoaXNfcGZuOwo+ICAgCQl9Cj4gLQo+IC0JCWN1
cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+IC0JCW5wYWdlcyAtPSByZXQ7Cj4gKwkJbGFz
dF9wZm4gPSB0aGlzX3BmbjsKPiAgIAl9Cj4gICAKPiAtCS8qIFBpbiB0aGUgcmVzdCBjaHVuayAq
Lwo+IC0JcmV0ID0gdmhvc3RfdmRwYV9tYXAodiwgaW92YSwgKGxhc3RfcGZuIC0gbWFwX3BmbiAr
IDEpIDw8IFBBR0VfU0hJRlQsCj4gLQkJCSAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULCBtc2ct
PnBlcm0pOwo+ICsJV0FSTl9PTihubWFwICE9IG5wYWdlcyk7Cj4gICBvdXQ6Cj4gLQlpZiAocmV0
KSB7Cj4gKwlpZiAocmV0KQo+ICAgCQl2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92YSwgbXNn
LT5zaXplKTsKPiAtCQlhdG9taWM2NF9zdWIobnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsK
PiAtCX0KPiArdW5sb2NrOgo+ICAgCW1tYXBfcmVhZF91bmxvY2soZGV2LT5tbSk7Cj4gLQlmcmVl
X3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZV9saXN0KTsKPiArZnJlZToKPiArCWt2ZnJlZSh2bWFz
KTsKPiArCWt2ZnJlZShwYWdlX2xpc3QpOwo+ICAgCXJldHVybiByZXQ7Cj4gICB9CgoKVGhpcyBs
b29rcyBsaWtlIGEgcmV3b3JrLCBzbyBJJ2Qgc3VnZ2VzdCB0byB1c2UgdXNlIGFub3RoZXIgcGF0
Y2ggZm9yIAp0aGlzIHBhcnQuCgooSSB3YXMgb24gdmFjYXRpb24sIHNvIHRoZSByZXBseSB3b3Vs
ZCBiZSBzbG93KQoKVGhhbmtzCgoKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

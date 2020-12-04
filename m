Return-Path: <SRS0=VsiN=FI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBCAC433FE
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 06:11:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545E62253D
	for <virtualization@archiver.kernel.org>; Fri,  4 Dec 2020 06:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545E62253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC4148808F;
	Fri,  4 Dec 2020 06:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XClcPkmTB8uc; Fri,  4 Dec 2020 06:11:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D4E58804F;
	Fri,  4 Dec 2020 06:11:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BBCEC0FA8;
	Fri,  4 Dec 2020 06:11:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D804C013B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 06:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2031988069
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 06:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N29Bbu3dWJI4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 06:11:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8A7428804F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 06:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607062261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K6cl8v35kD3r2OrOVTITYaEa1kSQSETMLTfEcRh66X8=;
 b=Ub5ASrhVPR5MeT92EpJqDLxfD6Fz981zH/wLAEFRSTn+5UoDq0+PnCyzRNiOnRw19Wn1Iz
 FhMSeMp8Au3bbU8KSLFnC50zRVKGDx86CeflI+LhSc908fjOKigKOyTuPeguftHcFLkl5X
 pLozQVr3qUgZTy0JtuLxRBrkncd3f+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-QxIfXreNMzOXDqnIx16k4g-1; Fri, 04 Dec 2020 01:10:59 -0500
X-MC-Unique: QxIfXreNMzOXDqnIx16k4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17ACD1005513;
 Fri,  4 Dec 2020 06:10:58 +0000 (UTC)
Received: from [10.72.12.116] (ovpn-12-116.pek2.redhat.com [10.72.12.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C5A22998C;
 Fri,  4 Dec 2020 06:10:49 +0000 (UTC)
Subject: Re: [PATCH net-next] tun: fix ubuf refcount incorrectly on error path
To: wangyunjian <wangyunjian@huawei.com>, mst@redhat.com
References: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <094f1828-9a73-033e-b1ca-43b73588d22b@redhat.com>
Date: Fri, 4 Dec 2020 14:10:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606982459-41752-1-git-send-email-wangyunjian@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, jerry.lilijun@huawei.com, xudingke@huawei.com,
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

Ck9uIDIwMjAvMTIvMyDkuIvljYg0OjAwLCB3YW5neXVuamlhbiB3cm90ZToKPiBGcm9tOiBZdW5q
aWFuIFdhbmcgPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+Cj4KPiBBZnRlciBzZXR0aW5nIGNhbGxi
YWNrIGZvciB1YnVmX2luZm8gb2Ygc2tiLCB0aGUgY2FsbGJhY2sKPiAodmhvc3RfbmV0X3plcm9j
b3B5X2NhbGxiYWNrKSB3aWxsIGJlIGNhbGxlZCB0byBkZWNyZWFzZQo+IHRoZSByZWZjb3VudCB3
aGVuIGZyZWVpbmcgc2tiLiBCdXQgd2hlbiBhbiBleGNlcHRpb24gb2NjdXJzCj4gYWZ0ZXJ3YXJk
cywgdGhlIGVycm9yIGhhbmRsaW5nIGluIHZob3N0IGhhbmRsZV90eCgpIHdpbGwKPiB0cnkgdG8g
ZGVjcmVhc2UgdGhlIHNhbWUgcmVmY291bnQgYWdhaW4uIFRoaXMgaXMgd3JvbmcgYW5kCj4gZml4
IHRoaXMgYnkgY2xlYXJpbmcgdWJ1Zl9pbmZvIHdoZW4gbWVldGluZyBlcnJvcnMuCj4KPiBGaXhl
czogNDQ3NzEzOGZhMGFlICgidHVuOiBwcm9wZXJseSB0ZXN0IGZvciBJRkZfVVAiKQo+IEZpeGVz
OiA5MGUzM2Q0NTk0MDcgKCJ0dW46IGVuYWJsZSBuYXBpX2dyb19mcmFncygpIGZvciBUVU4vVEFQ
IGRyaXZlciIpCj4KPiBTaWduZWQtb2ZmLWJ5OiBZdW5qaWFuIFdhbmcgPHdhbmd5dW5qaWFuQGh1
YXdlaS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC90dW4uYyB8IDExICsrKysrKysrKysrCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3R1bi5jIGIvZHJpdmVycy9uZXQvdHVuLmMKPiBpbmRleCAyZGMxOTg4YTg5NzMuLjM2
MTRiYjFiNmQzNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC90dW4uYwo+ICsrKyBiL2RyaXZl
cnMvbmV0L3R1bi5jCj4gQEAgLTE4NjEsNiArMTg2MSwxMiBAQCBzdGF0aWMgc3NpemVfdCB0dW5f
Z2V0X3VzZXIoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwgc3RydWN0IHR1bl9maWxlICp0ZmlsZSwK
PiAgIAlpZiAodW5saWtlbHkoISh0dW4tPmRldi0+ZmxhZ3MgJiBJRkZfVVApKSkgewo+ICAgCQll
cnIgPSAtRUlPOwo+ICAgCQlyY3VfcmVhZF91bmxvY2soKTsKPiArCQlpZiAoemVyb2NvcHkpIHsK
PiArCQkJc2tiX3NoaW5mbyhza2IpLT5kZXN0cnVjdG9yX2FyZyA9IE5VTEw7Cj4gKwkJCXNrYl9z
aGluZm8oc2tiKS0+dHhfZmxhZ3MgJj0gflNLQlRYX0RFVl9aRVJPQ09QWTsKPiArCQkJc2tiX3No
aW5mbyhza2IpLT50eF9mbGFncyAmPSB+U0tCVFhfU0hBUkVEX0ZSQUc7Cj4gKwkJfQo+ICsKPiAg
IAkJZ290byBkcm9wOwo+ICAgCX0KPiAgIAo+IEBAIC0xODc0LDYgKzE4ODAsMTEgQEAgc3RhdGlj
IHNzaXplX3QgdHVuX2dldF91c2VyKHN0cnVjdCB0dW5fc3RydWN0ICp0dW4sIHN0cnVjdCB0dW5f
ZmlsZSAqdGZpbGUsCj4gICAKPiAgIAkJaWYgKHVubGlrZWx5KGhlYWRsZW4gPiBza2JfaGVhZGxl
bihza2IpKSkgewo+ICAgCQkJYXRvbWljX2xvbmdfaW5jKCZ0dW4tPmRldi0+cnhfZHJvcHBlZCk7
Cj4gKwkJCWlmICh6ZXJvY29weSkgewo+ICsJCQkJc2tiX3NoaW5mbyhza2IpLT5kZXN0cnVjdG9y
X2FyZyA9IE5VTEw7Cj4gKwkJCQlza2Jfc2hpbmZvKHNrYiktPnR4X2ZsYWdzICY9IH5TS0JUWF9E
RVZfWkVST0NPUFk7Cj4gKwkJCQlza2Jfc2hpbmZvKHNrYiktPnR4X2ZsYWdzICY9IH5TS0JUWF9T
SEFSRURfRlJBRzsKPiArCQkJfQo+ICAgCQkJbmFwaV9mcmVlX2ZyYWdzKCZ0ZmlsZS0+bmFwaSk7
Cj4gICAJCQlyY3VfcmVhZF91bmxvY2soKTsKPiAgIAkJCW11dGV4X3VubG9jaygmdGZpbGUtPm5h
cGlfbXV0ZXgpOwoKCkl0IGxvb2tzIHRvIG1lIHRoZW4gd2UgbWlzcyB0aGUgZmFpbHVyZSBmZWVk
YmFjay4KClRoZSBpc3N1ZXMgY29tZXMgZnJvbSB0aGUgaW5jb25zaXN0ZW50IGVycm9yIGhhbmRs
aW5nIGluIHR1bi4KCkkgd29uZGVyIHdoZXRoZXIgd2UgY2FuIHNpbXBseSBkbyB1YXJnLT5jYWxs
YmFjayh1YXJnLCBmYWxzZSkgaWYgCm5lY2Vzc2FyeSBvbiBldmVyeSBmYWlsdHVyZSBwYXRoIG9u
IHR1bl9nZXRfdXNlcigpLgoKTm90ZSB0aGF0LCB6ZXJvY29weSBoYXMgYSBsb3Qgb2YgaXNzdWVz
IHdoaWNoIG1ha2VzIGl0IG5vdCBnb29kIGZvciAKcHJvZHVjdGlvbiBlbnZpcm9ubWVudC4KClRo
YW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

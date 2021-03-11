Return-Path: <SRS0=WRLV=IJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7240CC433E0
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 03:20:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F121064FA8
	for <virtualization@archiver.kernel.org>; Thu, 11 Mar 2021 03:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F121064FA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A7F449BD7;
	Thu, 11 Mar 2021 03:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Nzykvm-XEhA; Thu, 11 Mar 2021 03:20:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04CBB49CE1;
	Thu, 11 Mar 2021 03:20:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF437C000B;
	Thu, 11 Mar 2021 03:20:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08D69C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDF4D414E2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EfeyIqzAPRcP
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:20:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF6FC414DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Mar 2021 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615432831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P09mB4c+K2vA0WOzF718rEjH0GsJKBr1s72NBk2MRHg=;
 b=hLJB0AwYs+O+1got2rqL4qGrbKnoAmFadmBhiU1RnKDRabzwFQRtEYnpAI1XlQKjVcs4rb
 l01m9Vbwbr9sHTPK32aC/8q/AMWvS3NLP0QkecJ8PUuqMVXygP1yCz/VbEc8Q6p2tXDTsp
 p9k+U5hNDTM3gluVvXILUnXRwvFSvSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-VPLtTuS8NzqooVXMHlP4zw-1; Wed, 10 Mar 2021 22:20:27 -0500
X-MC-Unique: VPLtTuS8NzqooVXMHlP4zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 097C619200C1;
 Thu, 11 Mar 2021 03:20:26 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com
 [10.72.13.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 490795D746;
 Thu, 11 Mar 2021 03:20:20 +0000 (UTC)
Subject: Re: [PATCH V3 6/6] vDPA/ifcvf: verify mandatory feature bits for vDPA
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210310090052.4762-1-lingshan.zhu@intel.com>
 <20210310090052.4762-7-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3e53a5c9-c531-48ee-c9a7-907dfdacc9d1@redhat.com>
Date: Thu, 11 Mar 2021 11:20:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210310090052.4762-7-lingshan.zhu@intel.com>
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

Ck9uIDIwMjEvMy8xMCA1OjAwIOS4i+WNiCwgWmh1IExpbmdzaGFuIHdyb3RlOgo+IHZEUEEgcmVx
dXJlcyBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gYXMgYSBtdXN0LCB0aGlzIGNvbW1pdAo+IGV4
YW1pbmVzIHRoaXMgd2hlbiBzZXQgZmVhdHVyZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUgTGlu
Z3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jIHwgOCArKysrKysrKwo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaCB8IDEgKwo+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDUgKysr
KysKPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5jCj4gaW5kZXggZWE2YTc4NzkxYzliLi41OGY0N2ZkY2UzODUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmMKPiBAQCAtMjI0LDYgKzIyNCwxNCBAQCB1NjQgaWZjdmZfZ2V0X2Zl
YXR1cmVzKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4gICAJcmV0dXJuIGh3LT5od19mZWF0dXJlczsK
PiAgIH0KPiAgIAo+ICtpbnQgaWZjdmZfdmVyaWZ5X21pbl9mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZf
aHcgKmh3KQo+ICt7Cj4gKwlpZiAoIShody0+aHdfZmVhdHVyZXMgJiBCSVRfVUxMKFZJUlRJT19G
X0FDQ0VTU19QTEFURk9STSkpKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiArCXJldHVybiAw
Owo+ICt9Cj4gKwo+ICAgdm9pZCBpZmN2Zl9yZWFkX25ldF9jb25maWcoc3RydWN0IGlmY3ZmX2h3
ICpodywgdTY0IG9mZnNldCwKPiAgIAkJCSAgIHZvaWQgKmRzdCwgaW50IGxlbmd0aCkKPiAgIHsK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMv
dmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBpbmRleCBkYmI4YzEwYWEzYjEuLjkxYzU3MzVkNGRj
OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gKysrIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IEBAIC0xMjMsNiArMTIzLDcgQEAgdm9p
ZCBpb193cml0ZTY0X3R3b3BhcnQodTY0IHZhbCwgdTMyICpsbywgdTMyICpoaSk7Cj4gICB2b2lk
IGlmY3ZmX3Jlc2V0KHN0cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgdTY0IGlmY3ZmX2dldF9mZWF0
dXJlcyhzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPiAgIHU2NCBpZmN2Zl9nZXRfaHdfZmVhdHVyZXMo
c3RydWN0IGlmY3ZmX2h3ICpodyk7Cj4gK2ludCBpZmN2Zl92ZXJpZnlfbWluX2ZlYXR1cmVzKHN0
cnVjdCBpZmN2Zl9odyAqaHcpOwo+ICAgdTE2IGlmY3ZmX2dldF92cV9zdGF0ZShzdHJ1Y3QgaWZj
dmZfaHcgKmh3LCB1MTYgcWlkKTsKPiAgIGludCBpZmN2Zl9zZXRfdnFfc3RhdGUoc3RydWN0IGlm
Y3ZmX2h3ICpodywgdTE2IHFpZCwgdTE2IG51bSk7Cj4gICBzdHJ1Y3QgaWZjdmZfYWRhcHRlciAq
dmZfdG9fYWRhcHRlcihzdHJ1Y3QgaWZjdmZfaHcgKmh3KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWlu
LmMKPiBpbmRleCAyNWZiOWRmZTIzZjAuLmY2MjRmMjAyNDQ3ZCAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYwo+IEBAIC0xNzksNiArMTc5LDExIEBAIHN0YXRpYyB1NjQgaWZjdmZfdmRwYV9n
ZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKPiAgIHN0YXRpYyBpbnQg
aWZjdmZfdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwgdTY0
IGZlYXR1cmVzKQo+ICAgewo+ICAgCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZk
cGFfZGV2KTsKPiArCWludCByZXQ7Cj4gKwo+ICsJcmV0ID0gaWZjdmZfdmVyaWZ5X21pbl9mZWF0
dXJlcyh2Zik7CgoKU28gdGhpcyB2YWxpZGF0ZSBkZXZpY2UgZmVhdHVyZXMgaW5zdGVhZCBvZiBk
cml2ZXIgd2hpY2ggaXMgdGhlIG9uZSB3ZSAKcmVhbGx5IHdhbnQgdG8gY2hlY2s/CgpUaGFua3MK
Cgo+ICsJaWYgKHJldCkKPiArCQlyZXR1cm4gcmV0Owo+ICAgCj4gICAJdmYtPnJlcV9mZWF0dXJl
cyA9IGZlYXR1cmVzOwo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

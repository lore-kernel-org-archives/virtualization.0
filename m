Return-Path: <SRS0=J9So=JQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC3C433ED
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 03:16:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D482461104
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 03:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D482461104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D5096072A;
	Mon, 19 Apr 2021 03:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwUFjEDeW0b8; Mon, 19 Apr 2021 03:16:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28457606D6;
	Mon, 19 Apr 2021 03:16:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA4CCC000E;
	Mon, 19 Apr 2021 03:16:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2CC3C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBB2B40377
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xqZJTE9sy4j4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9032040372
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618802163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X38rk25z+aIlpe2jmK4mElIAnvBj6ZGYmC3xOZNprfM=;
 b=A/g+Ph19WtjDjJWISEWMpJo80/6f2VgtAL8Th2IhUiK0Rsu0JzyPFCbn8Zb0tkTcP6rTdi
 NQ7aACUGoHeXmCe+TwBpvzliVAy3S7Q4rTql7YUCJdrly9gHpkJR4UqWM2h/zEYC/c/v1b
 aoX1rrhMwZR1tgK523NlIzbcNwI8v00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-LAHvgotZOaaLtkGjzgkmAA-1; Sun, 18 Apr 2021 23:16:01 -0400
X-MC-Unique: LAHvgotZOaaLtkGjzgkmAA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263D38030C4;
 Mon, 19 Apr 2021 03:16:00 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-157.pek2.redhat.com
 [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BE3260936;
 Mon, 19 Apr 2021 03:15:53 +0000 (UTC)
Subject: Re: [PATCH V3 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 sgarzare@redhat.com
References: <20210416071628.4984-1-lingshan.zhu@intel.com>
 <20210416071628.4984-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <efc73829-0209-8144-0426-935b8384b6ad@redhat.com>
Date: Mon, 19 Apr 2021 11:15:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416071628.4984-2-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

CuWcqCAyMDIxLzQvMTYg5LiL5Y2IMzoxNiwgWmh1IExpbmdzaGFuIOWGmemBkzoKPiBUaGlzIGNv
bW1pdCBkZWR1Y2VzIFZJUlRJTyBkZXZpY2UgSUQgYXMgZGV2aWNlIHR5cGUgd2hlbiBwcm9iZSwK
PiB0aGVuIGlmY3ZmX3ZkcGFfZ2V0X2RldmljZV9pZCgpIGNhbiBzaW1wbHkgcmV0dXJuIHRoZSBJ
RC4KPiBpZmN2Zl92ZHBhX2dldF9mZWF0dXJlcygpIGFuZCBpZmN2Zl92ZHBhX2dldF9jb25maWdf
c2l6ZSgpCj4gY2FuIHdvcmsgcHJvcGVybHkgYmFzZWQgb24gdGhlIGRldmljZSBJRC4KPgo+IFNp
Z25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPiAtLS0K
PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAgMSArCj4gICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMzAgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
Cj4gICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggYjJlZWIxNmI5YzJjLi4xYzA0Y2QyNTZm
YTcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBi
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtODQsNiArODQsNyBAQCBzdHJ1
Y3QgaWZjdmZfaHcgewo+ICAgCXUzMiBub3RpZnlfb2ZmX211bHRpcGxpZXI7Cj4gICAJdTY0IHJl
cV9mZWF0dXJlczsKPiAgIAl1NjQgaHdfZmVhdHVyZXM7Cj4gKwl1MzIgZGV2X3R5cGU7Cj4gICAJ
c3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBfX2lvbWVtICpjb21tb25fY2ZnOwo+ICAgCXZv
aWQgX19pb21lbSAqbmV0X2NmZzsKPiAgIAlzdHJ1Y3QgdnJpbmdfaW5mbyB2cmluZ1tJRkNWRl9N
QVhfUVVFVUVfUEFJUlMgKiAyXTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lm
Y3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCA0NGQ3
NTg2MDE5ZGEuLjQ2OWE5YjU3MzdiNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYv
aWZjdmZfbWFpbi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBA
IC0zMjMsMTkgKzMyMyw5IEBAIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZ2VuZXJhdGlvbihz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgCj4gICBzdGF0aWMgdTMyIGlmY3ZmX3Zk
cGFfZ2V0X2RldmljZV9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgewo+IC0J
c3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0ZXIodmRwYV9kZXYp
Owo+IC0Jc3RydWN0IHBjaV9kZXYgKnBkZXYgPSBhZGFwdGVyLT5wZGV2Owo+IC0JdTMyIHJldCA9
IC1FTk9ERVY7Cj4gLQo+IC0JaWYgKHBkZXYtPmRldmljZSA8IDB4MTAwMCB8fCBwZGV2LT5kZXZp
Y2UgPiAweDEwN2YpCj4gLQkJcmV0dXJuIHJldDsKPiAtCj4gLQlpZiAocGRldi0+ZGV2aWNlIDwg
MHgxMDQwKQo+IC0JCXJldCA9ICBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+IC0JZWxzZQo+IC0J
CXJldCA9ICBwZGV2LT5kZXZpY2UgLSAweDEwNDA7Cj4gKwlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0g
dmRwYV90b192Zih2ZHBhX2Rldik7Cj4gICAKPiAtCXJldHVybiByZXQ7Cj4gKwlyZXR1cm4gdmYt
PmRldl90eXBlOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRv
cl9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+IEBAIC00NjYsNiArNDU2LDIyIEBA
IHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVj
dCBwY2lfZGV2aWNlX2lkICppZCkKPiAgIAlwY2lfc2V0X2RydmRhdGEocGRldiwgYWRhcHRlcik7
Cj4gICAKPiAgIAl2ZiA9ICZhZGFwdGVyLT52ZjsKPiArCj4gKwkvKiBUaGlzIGRyaXJ2ZXIgZHJp
dmVzIGJvdGggbW9kZXJuIHZpcnRpbyBkZXZpY2VzIGFuZCB0cmFuc2l0aW9uYWwKPiArCSAqIGRl
dmljZXMgaW4gbW9kZXJuIG1vZGUuCj4gKwkgKiB2RFBBIHJlcXVpcmVzIGZlYXR1cmUgYml0IFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSwKPiArCSAqIHNvIGxlZ2FjeSBkZXZpY2VzIGFuZCB0cmFu
c2l0aW9uYWwgZGV2aWNlcyBpbiBsZWdhY3kKPiArCSAqIG1vZGUgd2lsbCBub3Qgd29yayBmb3Ig
dkRQQSwgdGhpcyBkcml2ZXIgd2lsbCBub3QKPiArCSAqIGRyaXZlIGRldmljZXMgd2l0aCBsZWdh
Y3kgaW50ZXJmYWNlLgo+ICsJICovCj4gKwlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBk
ZXYtPmRldmljZSA+IDB4MTA3ZikKPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7CgoKU28gdGhpcyBz
ZWVtcyB1c2VsZXNzLCBpZF90YWJsZSBoYXMgYWxyZWFkeSBkaWQgdGhhdCBmb3IgdXM6CgpUaGUg
ZHJpdmVyIHN1cHBvcnRzOgoKI2RlZmluZSBJRkNWRl9ERVZJQ0VfSUTCoMKgwqDCoMKgwqDCoMKg
IDB4MTA0MQoKYW5kCgojZGVmaW5lIEM1MDAwWF9QTF9CTEtfREVWSUNFX0lEwqDCoMKgwqDCoMKg
wqAgMHgxMDAxCgpJIHRoaW5rIHdlIGNhbiBuZXZlciByZWFjaCB0aGUgY29uZGl0aW9uIGFib3Zl
LgoKVGhhbmtzCgoKPiArCj4gKwlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+ICsJCXZmLT5k
ZXZfdHlwZSA9ICBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+ICsJZWxzZQo+ICsJCXZmLT5kZXZf
dHlwZSA9ICBwZGV2LT5kZXZpY2UgLSAweDEwNDA7Cj4gKwo+ICAgCXZmLT5iYXNlID0gcGNpbV9p
b21hcF90YWJsZShwZGV2KTsKPiAgIAo+ICAgCWFkYXB0ZXItPnBkZXYgPSBwZGV2OwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u

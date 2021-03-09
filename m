Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F95C4332D
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:17:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC39D652AC
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC39D652AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A0584AE77;
	Tue,  9 Mar 2021 02:17:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8VAoaD8j5lt1; Tue,  9 Mar 2021 02:17:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCB254954E;
	Tue,  9 Mar 2021 02:17:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC87DC000B;
	Tue,  9 Mar 2021 02:17:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14AA4C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB1D16F55D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3fXAOifJ0HAj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:17:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9A71605CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615256252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6QvpOOqO9cbXP+W1bJXr9pOCC9HryjydKAN8qiu7fM=;
 b=TASoluVk2iTGSXlePMm2psF95B9G4vvFEh5JGdTIXtT39Cl2jWpcXswPpw04kw41/jPtBC
 Y88WaqMqCmr5JVVy6FTzvxD8T6aSg/2C2wrPBpKMq5ZJpEGm/Hj4AQ05LlUOdHXYwkMBWJ
 DZdJhT7p523BM/ORdjdJHk6RKolLpEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-N_iDmVjbOsS9s8nzi82q4A-1; Mon, 08 Mar 2021 21:17:30 -0500
X-MC-Unique: N_iDmVjbOsS9s8nzi82q4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2CE71084C97;
 Tue,  9 Mar 2021 02:17:28 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-202.pek2.redhat.com
 [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAEC260C04;
 Tue,  9 Mar 2021 02:17:20 +0000 (UTC)
Subject: Re: [PATCH v7 net-next] virtio-net: support XDP when not more queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <1615193536-112130-1-git-send-email-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <184047a5-c26c-90ad-d2b0-bcab9889c9ce@redhat.com>
Date: Tue, 9 Mar 2021 10:17:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615193536-112130-1-git-send-email-xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Ck9uIDIwMjEvMy84IDQ6NTIg5LiL5Y2ILCBYdWFuIFpodW8gd3JvdGU6Cj4gVGhlIG51bWJlciBv
ZiBxdWV1ZXMgaW1wbGVtZW50ZWQgYnkgbWFueSB2aXJ0aW8gYmFja2VuZHMgaXMgbGltaXRlZCwK
PiBlc3BlY2lhbGx5IHNvbWUgbWFjaGluZXMgaGF2ZSBhIGxhcmdlIG51bWJlciBvZiBDUFVzLiBJ
biB0aGlzIGNhc2UsIGl0Cj4gaXMgb2Z0ZW4gaW1wb3NzaWJsZSB0byBhbGxvY2F0ZSBhIHNlcGFy
YXRlIHF1ZXVlIGZvcgo+IFhEUF9UWC9YRFBfUkVESVJFQ1QsIHRoZW4geGRwIGNhbm5vdCBiZSBs
b2FkZWQgdG8gd29yaywgZXZlbiB4ZHAgZG9lcwo+IG5vdCB1c2UgdGhlIFhEUF9UWC9YRFBfUkVE
SVJFQ1QuCj4KPiBUaGlzIHBhdGNoIGFsbG93cyBYRFBfVFgvWERQX1JFRElSRUNUIHRvIHJ1biBi
eSByZXVzZSB0aGUgZXhpc3RpbmcgU1EKPiB3aXRoIF9fbmV0aWZfdHhfbG9jaygpIGhvbGQgd2hl
biB0aGVyZSBhcmUgbm90IGVub3VnaCBxdWV1ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IFJldmlld2VkLWJ5OiBEdXN0IExpIDxk
dXN0LmxpQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+IHY3OiAxLiB1c2UgbWFjcm9zIHRvIGlt
cGxlbWVudCBnZXQvcHV0Cj4gICAgICAyLiByZW1vdmUgJ2ZsYWcnLiAoc3VnZ2VzdGVkIGJ5IEph
c29uIFdhbmcpCj4KPiB2NjogMS4gdXNlIF9fbmV0aWZfdHhfYWNxdWlyZSgpL19fbmV0aWZfdHhf
cmVsZWFzZSgpLiAoc3VnZ2VzdGVkIGJ5IEphc29uIFdhbmcpCj4gICAgICAyLiBhZGQgbm90ZSBm
b3Igd2h5IG5vdCBsb2NrLiAoc3VnZ2VzdGVkIGJ5IEphc29uIFdhbmcpCj4gICAgICAzLiBVc2Ug
dmFyaWFibGUgJ2ZsYWcnIHRvIHJlY29yZCB3aXRoIG9yIHdpdGhvdXQgbG9ja2VkLiAgSXQgaXMg
bm90IHNhZmUgdG8KPiAgICAgICAgIHVzZSBjdXJyX3F1ZXVlX3BhaXJzIGluICJ2aXJ0bmV0X3B1
dF94ZHBfc3EiLCBiZWNhdXNlIGl0IG1heSBjaGFuZ2VkIGFmdGVyCj4gICAgICAgICAidmlydG5l
dF9nZXRfeGRwX3NxIi4KPgo+IHY1OiBjaGFuZ2Ugc3ViamVjdCBmcm9tICdzdXBwb3J0IFhEUF9U
WCB3aGVuIG5vdCBtb3JlIHF1ZXVlcycKPgo+IHY0OiBtYWtlIHNwYXJzZSBoYXBweQo+ICAgICAg
c3VnZ2VzdGVkIGJ5IEpha3ViIEtpY2luc2tpCj4KPiB2MzogYWRkIHdhcm5pbmcgd2hlbiBubyBt
b3JlIHF1ZXVlcwo+ICAgICAgc3VnZ2VzdGVkIGJ5IEplc3BlciBEYW5nYWFyZCBCcm91ZXIKPgo+
ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNTUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9u
cygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5kZXggYmE4ZTYzNy4uNWNlNDBl
YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMTk1LDYgKzE5NSw5IEBAIHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gewo+ICAgCS8qICMgb2YgWERQIHF1ZXVlIHBhaXJzIGN1cnJlbnRseSB1c2VkIGJ5IHRoZSBk
cml2ZXIgKi8KPiAgIAl1MTYgeGRwX3F1ZXVlX3BhaXJzOwo+Cj4gKwkvKiB4ZHBfcXVldWVfcGFp
cnMgbWF5IGJlIDAsIHdoZW4geGRwIGlzIGFscmVhZHkgbG9hZGVkLiBTbyBhZGQgdGhpcy4gKi8K
PiArCWJvb2wgeGRwX2VuYWJsZWQ7Cj4gKwo+ICAgCS8qIEkgbGlrZS4uLiBiaWcgcGFja2V0cyBh
bmQgSSBjYW5ub3QgbGllISAqLwo+ICAgCWJvb2wgYmlnX3BhY2tldHM7Cj4KPiBAQCAtNDgxLDEy
ICs0ODQsMzQgQEAgc3RhdGljIGludCBfX3ZpcnRuZXRfeGRwX3htaXRfb25lKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLAo+ICAgCXJldHVybiAwOwo+ICAgfQo+Cj4gLXN0YXRpYyBzdHJ1Y3Qgc2Vu
ZF9xdWV1ZSAqdmlydG5ldF94ZHBfc3Eoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gLXsKPiAt
CXVuc2lnbmVkIGludCBxcDsKPiAtCj4gLQlxcCA9IHZpLT5jdXJyX3F1ZXVlX3BhaXJzIC0gdmkt
PnhkcF9xdWV1ZV9wYWlycyArIHNtcF9wcm9jZXNzb3JfaWQoKTsKPiAtCXJldHVybiAmdmktPnNx
W3FwXTsKPiArLyogd2hlbiB2aS0+Y3Vycl9xdWV1ZV9wYWlycyA+IG5yX2NwdV9pZHMsIHRoZSB0
eHEvc3EgaXMgb25seSB1c2VkIGZvciB4ZHAgdHggb24KPiArICogdGhlIGN1cnJlbnQgY3B1LCBz
byBpdCBkb2VzIG5vdCBuZWVkIHRvIGJlIGxvY2tlZC4KPiArICovCj4gKyNkZWZpbmUgdmlydG5l
dF94ZHBfZ2V0X3NxKHZpKSAoeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAo+ICsJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAo+ICsJdHlwZW9mKHZpKSB2ID0gKHZpKTsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAoKCkFueSByZWFzb24gZm9yIG5vdCB1
c2luZyB2aSBkaXJlY3RseT8KCk90aGVyIGxvb2tzIGdvb2QuCgpUaGFua3MKCgo+ICsJdW5zaWdu
ZWQgaW50IHFwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXAo+ICsJaWYgKHYtPmN1cnJfcXVldWVfcGFpcnMgPiBucl9jcHVfaWRzKSB7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXAo+ICsJCXFwID0gdi0+Y3Vycl9xdWV1ZV9wYWlycyAtIHYtPnhk
cF9xdWV1ZV9wYWlyczsgICAgICAgICAgICBcCj4gKwkJcXAgKz0gc21wX3Byb2Nlc3Nvcl9pZCgp
OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiArCQl0eHEgPSBuZXRkZXZfZ2V0
X3R4X3F1ZXVlKHYtPmRldiwgcXApOyAgICAgICAgICAgICAgICAgICAgXAo+ICsJCV9fbmV0aWZf
dHhfYWNxdWlyZSh0eHEpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gKwl9
IGVsc2UgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcCj4gKwkJcXAgPSBzbXBfcHJvY2Vzc29yX2lkKCkgJSB2LT5jdXJyX3F1ZXVlX3Bh
aXJzOyAgICAgICAgICAgIFwKPiArCQl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHYtPmRldiwg
cXApOyAgICAgICAgICAgICAgICAgICAgXAo+ICsJCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19z
bXBfcHJvY2Vzc29yX2lkKCkpOyAgICAgICAgICAgICBcCj4gKwl9ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4gKwl2LT5z
cSArIHFwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcCj4gK30pCj4gKwo+ICsjZGVmaW5lIHZpcnRuZXRfeGRwX3B1dF9zcSh2aSwgcSkgeyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiArCXN0cnVjdCBuZXRkZXZf
cXVldWUgKnR4cTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiAr
CXR5cGVvZih2aSkgdiA9ICh2aSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKPiArCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodi0+ZGV2LCAocSkgLSB2
LT5zcSk7ICAgICAgICAgICAgICAgICAgIFwKPiArCWlmICh2LT5jdXJyX3F1ZXVlX3BhaXJzID4g
bnJfY3B1X2lkcykgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPiArCQlfX25ldGlmX3R4
X3JlbGVhc2UodHhxKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+ICsJZWxz
ZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXAo+ICsJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCj4gICB9Cj4KPiAgIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfeG1pdChz
dHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+IEBAIC01MTIsNyArNTM3LDcgQEAgc3RhdGljIGludCB2
aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJaWYgKCF4ZHBfcHJv
ZykKPiAgIAkJcmV0dXJuIC1FTlhJTzsKPgo+IC0Jc3EgPSB2aXJ0bmV0X3hkcF9zcSh2aSk7Cj4g
KwlzcSA9IHZpcnRuZXRfeGRwX2dldF9zcSh2aSk7Cj4KPiAgIAlpZiAodW5saWtlbHkoZmxhZ3Mg
JiB+WERQX1hNSVRfRkxBR1NfTUFTSykpIHsKPiAgIAkJcmV0ID0gLUVJTlZBTDsKPiBAQCAtNTYw
LDEyICs1ODUsMTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCj4gICAJc3EtPnN0YXRzLmtpY2tzICs9IGtpY2tzOwo+ICAgCXU2NF9zdGF0c191
cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3luY3ApOwo+Cj4gKwl2aXJ0bmV0X3hkcF9wdXRfc3Eodmks
IHNxKTsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+Cj4gICBzdGF0aWMgdW5zaWduZWQgaW50IHZp
cnRuZXRfZ2V0X2hlYWRyb29tKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICAgewo+IC0JcmV0
dXJuIHZpLT54ZHBfcXVldWVfcGFpcnMgPyBWSVJUSU9fWERQX0hFQURST09NIDogMDsKPiArCXJl
dHVybiB2aS0+eGRwX2VuYWJsZWQgPyBWSVJUSU9fWERQX0hFQURST09NIDogMDsKPiAgIH0KPgo+
ICAgLyogV2UgY29weSB0aGUgcGFja2V0IGZvciBYRFAgaW4gdGhlIGZvbGxvd2luZyBjYXNlczoK
PiBAQCAtMTQ1NywxMiArMTQ4MywxMyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbChzdHJ1Y3Qg
bmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJCXhkcF9kb19mbHVzaCgpOwo+Cj4g
ICAJaWYgKHhkcF94bWl0ICYgVklSVElPX1hEUF9UWCkgewo+IC0JCXNxID0gdmlydG5ldF94ZHBf
c3EodmkpOwo+ICsJCXNxID0gdmlydG5ldF94ZHBfZ2V0X3NxKHZpKTsKPiAgIAkJaWYgKHZpcnRx
dWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAmJiB2aXJ0cXVldWVfbm90aWZ5KHNxLT52cSkpIHsK
PiAgIAkJCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5zeW5jcCk7Cj4gICAJCQlz
cS0+c3RhdHMua2lja3MrKzsKPiAgIAkJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+c3RhdHMu
c3luY3ApOwo+ICAgCQl9Cj4gKwkJdmlydG5ldF94ZHBfcHV0X3NxKHZpLCBzcSk7Cj4gICAJfQo+
Cj4gICAJcmV0dXJuIHJlY2VpdmVkOwo+IEBAIC0yNDE3LDEwICsyNDQ0LDkgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X3hkcF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9n
ICpwcm9nLAo+Cj4gICAJLyogWERQIHJlcXVpcmVzIGV4dHJhIHF1ZXVlcyBmb3IgWERQX1RYICov
Cj4gICAJaWYgKGN1cnJfcXAgKyB4ZHBfcXAgPiB2aS0+bWF4X3F1ZXVlX3BhaXJzKSB7Cj4gLQkJ
TkxfU0VUX0VSUl9NU0dfTU9EKGV4dGFjaywgIlRvbyBmZXcgZnJlZSBUWCByaW5ncyBhdmFpbGFi
bGUiKTsKPiAtCQluZXRkZXZfd2FybihkZXYsICJyZXF1ZXN0ICVpIHF1ZXVlcyBidXQgbWF4IGlz
ICVpXG4iLAo+ICsJCW5ldGRldl93YXJuKGRldiwgIlhEUCByZXF1ZXN0ICVpIHF1ZXVlcyBidXQg
bWF4IGlzICVpLiBYRFBfVFggYW5kIFhEUF9SRURJUkVDVCB3aWxsIG9wZXJhdGUgaW4gYSBzbG93
ZXIgbG9ja2VkIHR4IG1vZGUuXG4iLAo+ICAgCQkJICAgIGN1cnJfcXAgKyB4ZHBfcXAsIHZpLT5t
YXhfcXVldWVfcGFpcnMpOwo+IC0JCXJldHVybiAtRU5PTUVNOwo+ICsJCXhkcF9xcCA9IDA7Cj4g
ICAJfQo+Cj4gICAJb2xkX3Byb2cgPSBydG5sX2RlcmVmZXJlbmNlKHZpLT5ycVswXS54ZHBfcHJv
Zyk7Cj4gQEAgLTI0NTQsMTEgKzI0ODAsMTQgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9zZXQo
c3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpwcm9nLAo+ICAgCXZpLT54
ZHBfcXVldWVfcGFpcnMgPSB4ZHBfcXA7Cj4KPiAgIAlpZiAocHJvZykgewo+ICsJCXZpLT54ZHBf
ZW5hYmxlZCA9IHRydWU7Cj4gICAJCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJz
OyBpKyspIHsKPiAgIAkJCXJjdV9hc3NpZ25fcG9pbnRlcih2aS0+cnFbaV0ueGRwX3Byb2csIHBy
b2cpOwo+ICAgCQkJaWYgKGkgPT0gMCAmJiAhb2xkX3Byb2cpCj4gICAJCQkJdmlydG5ldF9jbGVh
cl9ndWVzdF9vZmZsb2Fkcyh2aSk7Cj4gICAJCX0KPiArCX0gZWxzZSB7Cj4gKwkJdmktPnhkcF9l
bmFibGVkID0gZmFsc2U7Cj4gICAJfQo+Cj4gICAJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVl
dWVfcGFpcnM7IGkrKykgewo+IEBAIC0yNTI2LDcgKzI1NTUsNyBAQCBzdGF0aWMgaW50IHZpcnRu
ZXRfc2V0X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJaW50IGVycjsKPgo+
ICAgCWlmICgoZGV2LT5mZWF0dXJlcyBeIGZlYXR1cmVzKSAmIE5FVElGX0ZfTFJPKSB7Cj4gLQkJ
aWYgKHZpLT54ZHBfcXVldWVfcGFpcnMpCj4gKwkJaWYgKHZpLT54ZHBfZW5hYmxlZCkKPiAgIAkJ
CXJldHVybiAtRUJVU1k7Cj4KPiAgIAkJaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9MUk8pCj4gLS0K
PiAxLjguMy4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

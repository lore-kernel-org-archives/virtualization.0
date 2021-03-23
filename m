Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AFEC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 03:09:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED29A619AB
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 03:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED29A619AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 992EB8341A;
	Tue, 23 Mar 2021 03:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mybzjQSN88eT; Tue, 23 Mar 2021 03:09:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28F468397A;
	Tue, 23 Mar 2021 03:09:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0241DC000A;
	Tue, 23 Mar 2021 03:09:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C58FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0EFE140441
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VhLDLfSESc_L
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:09:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07A4240440
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616468989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK8t4LNmU+Ag0hLnSBmusXqV+wwlg2B/cGi7B01CKSg=;
 b=ajRipIbnpsLxkgESdqoB1dmJzXki5bb1V1tBzc3VbVGwBcvYobX1BD6KMEhS5YlsReGwI7
 lBuPyOoIwZ9tAg1UCop4VYX40VoR2vPd2hY3Daxq60rhJSeApgizd15Zw1lUFJn13btKMi
 ziZp2SuYx+zY6/SgV6IgRXd6Hry0JDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-Isdm_G_dMz-H0cIhUFbcMw-1; Mon, 22 Mar 2021 23:09:46 -0400
X-MC-Unique: Isdm_G_dMz-H0cIhUFbcMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46E619251D4;
 Tue, 23 Mar 2021 03:09:36 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-238.pek2.redhat.com
 [10.72.12.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B92610023B0;
 Tue, 23 Mar 2021 03:09:22 +0000 (UTC)
Subject: Re: [PATCH v5 06/11] vdpa: factor out vhost_vdpa_pa_map()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-7-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <45a307b5-85a4-0cbc-0bbc-7e8edbbac9ca@redhat.com>
Date: Tue, 23 Mar 2021 11:09:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315053721.189-7-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNSDPws7nMTozNywgWGllIFlvbmdqaSDQtLXAOgo+IFRoZSB1cGNvbWluZyBw
YXRjaCBpcyBnb2luZyB0byBzdXBwb3J0IFZBIG1hcHBpbmcuIFNvIGxldCdzCj4gZmFjdG9yIG91
dCB0aGUgbG9naWMgb2YgUEEgbWFwcGluZyBmaXJzdGx5IHRvIG1ha2UgdGhlIGNvZGUKPiBtb3Jl
IHJlYWRhYmxlLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29t
PgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKV2hpbGUgYXQg
aXQsIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8gZmFjdG9yIG91dCB0aGUgdW5tYXAoKSBwYXJ0PyBT
aW5jZSAKdGhlIHVucGluIGFuZCBwYWdlIGRpcnR5IGlzIG5vdCBuZWVkZWQgZm9yIHZhIGRldmlj
ZS4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDQ2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggYjI0ZWM2OWEz
NzRiLi43YzgzZmJmM2VkYWMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiAr
KysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC01NzksMzcgKzU3OSwyOCBAQCBzdGF0aWMg
dm9pZCB2aG9zdF92ZHBhX3VubWFwKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1NjQgaW92YSwgdTY0
IHNpemUpCj4gICAJfQo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNz
X2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAtCQkJCQkgICBzdHJ1Y3Qgdmhv
c3RfaW90bGJfbXNnICptc2cpCj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9wYV9tYXAoc3RydWN0
IHZob3N0X3ZkcGEgKnYsCj4gKwkJCSAgICAgdTY0IGlvdmEsIHU2NCBzaXplLCB1NjQgdWFkZHIs
IHUzMiBwZXJtKQo+ICAgewo+ICAgCXN0cnVjdCB2aG9zdF9kZXYgKmRldiA9ICZ2LT52ZGV2Owo+
IC0Jc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiA9IGRldi0+aW90bGI7Cj4gICAJc3RydWN0IHBh
Z2UgKipwYWdlX2xpc3Q7Cj4gICAJdW5zaWduZWQgbG9uZyBsaXN0X3NpemUgPSBQQUdFX1NJWkUg
LyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4gICAJdW5zaWduZWQgaW50IGd1cF9mbGFncyA9IEZP
TExfTE9OR1RFUk07Cj4gICAJdW5zaWduZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNlLCBtYXBfcGZu
LCBsYXN0X3BmbiA9IDA7Cj4gICAJdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5j
aHVua3MsIGk7Cj4gLQl1NjQgaW92YSA9IG1zZy0+aW92YTsKPiArCXU2NCBzdGFydCA9IGlvdmE7
Cj4gICAJbG9uZyBwaW5uZWQ7Cj4gICAJaW50IHJldCA9IDA7Cj4gICAKPiAtCWlmIChtc2ctPmlv
dmEgPCB2LT5yYW5nZS5maXJzdCB8fAo+IC0JICAgIG1zZy0+aW92YSArIG1zZy0+c2l6ZSAtIDEg
PiB2LT5yYW5nZS5sYXN0KQo+IC0JCXJldHVybiAtRUlOVkFMOwo+IC0KPiAtCWlmICh2aG9zdF9p
b3RsYl9pdHJlZV9maXJzdChpb3RsYiwgbXNnLT5pb3ZhLAo+IC0JCQkJICAgIG1zZy0+aW92YSAr
IG1zZy0+c2l6ZSAtIDEpKQo+IC0JCXJldHVybiAtRUVYSVNUOwo+IC0KPiAgIAkvKiBMaW1pdCB0
aGUgdXNlIG9mIG1lbW9yeSBmb3IgYm9va2tlZXBpbmcgKi8KPiAgIAlwYWdlX2xpc3QgPSAoc3Ry
dWN0IHBhZ2UgKiopIF9fZ2V0X2ZyZWVfcGFnZShHRlBfS0VSTkVMKTsKPiAgIAlpZiAoIXBhZ2Vf
bGlzdCkKPiAgIAkJcmV0dXJuIC1FTk9NRU07Cj4gICAKPiAtCWlmIChtc2ctPnBlcm0gJiBWSE9T
VF9BQ0NFU1NfV08pCj4gKwlpZiAocGVybSAmIFZIT1NUX0FDQ0VTU19XTykKPiAgIAkJZ3VwX2Zs
YWdzIHw9IEZPTExfV1JJVEU7Cj4gICAKPiAtCW5wYWdlcyA9IFBBR0VfQUxJR04obXNnLT5zaXpl
ICsgKGlvdmEgJiB+UEFHRV9NQVNLKSkgPj4gUEFHRV9TSElGVDsKPiArCW5wYWdlcyA9IFBBR0Vf
QUxJR04oc2l6ZSArIChpb3ZhICYgflBBR0VfTUFTSykpID4+IFBBR0VfU0hJRlQ7Cj4gICAJaWYg
KCFucGFnZXMpIHsKPiAgIAkJcmV0ID0gLUVJTlZBTDsKPiAgIAkJZ290byBmcmVlOwo+IEBAIC02
MjMsNyArNjE0LDcgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRl
KHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAgCQlnb3RvIHVubG9jazsKPiAgIAl9Cj4gICAKPiAt
CWN1cl9iYXNlID0gbXNnLT51YWRkciAmIFBBR0VfTUFTSzsKPiArCWN1cl9iYXNlID0gdWFkZHIg
JiBQQUdFX01BU0s7Cj4gICAJaW92YSAmPSBQQUdFX01BU0s7Cj4gICAJbmNodW5rcyA9IDA7Cj4g
ICAKPiBAQCAtNjU0LDcgKzY0NSw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lv
dGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAkJCQljc2l6ZSA9IChsYXN0X3Bm
biAtIG1hcF9wZm4gKyAxKSA8PCBQQUdFX1NISUZUOwo+ICAgCQkJCXJldCA9IHZob3N0X3ZkcGFf
bWFwKHYsIGlvdmEsIGNzaXplLAo+ICAgCQkJCQkJICAgICBtYXBfcGZuIDw8IFBBR0VfU0hJRlQs
Cj4gLQkJCQkJCSAgICAgbXNnLT5wZXJtKTsKPiArCQkJCQkJICAgICBwZXJtKTsKPiAgIAkJCQlp
ZiAocmV0KSB7Cj4gICAJCQkJCS8qCj4gICAJCQkJCSAqIFVucGluIHRoZSBwYWdlcyB0aGF0IGFy
ZSBsZWZ0IHVubWFwcGVkCj4gQEAgLTY4Myw3ICs2NzQsNyBAQCBzdGF0aWMgaW50IHZob3N0X3Zk
cGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAKPiAgIAkv
KiBQaW4gdGhlIHJlc3QgY2h1bmsgKi8KPiAgIAlyZXQgPSB2aG9zdF92ZHBhX21hcCh2LCBpb3Zh
LCAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVCwKPiAtCQkJICAgICBtYXBf
cGZuIDw8IFBBR0VfU0hJRlQsIG1zZy0+cGVybSk7Cj4gKwkJCSAgICAgbWFwX3BmbiA8PCBQQUdF
X1NISUZULCBwZXJtKTsKPiAgIG91dDoKPiAgIAlpZiAocmV0KSB7Cj4gICAJCWlmIChuY2h1bmtz
KSB7Cj4gQEAgLTcwMiwxMyArNjkzLDMyIEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNz
X2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAkJCWZvciAocGZuID0gbWFw
X3BmbjsgcGZuIDw9IGxhc3RfcGZuOyBwZm4rKykKPiAgIAkJCQl1bnBpbl91c2VyX3BhZ2UocGZu
X3RvX3BhZ2UocGZuKSk7Cj4gICAJCX0KPiAtCQl2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92
YSwgbXNnLT5zaXplKTsKPiArCQl2aG9zdF92ZHBhX3VubWFwKHYsIHN0YXJ0LCBzaXplKTsKPiAg
IAl9Cj4gICB1bmxvY2s6Cj4gICAJbW1hcF9yZWFkX3VubG9jayhkZXYtPm1tKTsKPiAgIGZyZWU6
Cj4gICAJZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXBhZ2VfbGlzdCk7Cj4gICAJcmV0dXJuIHJl
dDsKPiArCj4gK30KPiArCj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3Vw
ZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiArCQkJCQkgICBzdHJ1Y3Qgdmhvc3RfaW90bGJf
bXNnICptc2cpCj4gK3sKPiArCXN0cnVjdCB2aG9zdF9kZXYgKmRldiA9ICZ2LT52ZGV2Owo+ICsJ
c3RydWN0IHZob3N0X2lvdGxiICppb3RsYiA9IGRldi0+aW90bGI7Cj4gKwo+ICsJaWYgKG1zZy0+
aW92YSA8IHYtPnJhbmdlLmZpcnN0IHx8Cj4gKwkgICAgbXNnLT5pb3ZhICsgbXNnLT5zaXplIC0g
MSA+IHYtPnJhbmdlLmxhc3QpCj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwo+ICsJaWYgKHZob3N0
X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxiLCBtc2ctPmlvdmEsCj4gKwkJCQkgICAgbXNnLT5pb3Zh
ICsgbXNnLT5zaXplIC0gMSkpCj4gKwkJcmV0dXJuIC1FRVhJU1Q7Cj4gKwo+ICsJcmV0dXJuIHZo
b3N0X3ZkcGFfcGFfbWFwKHYsIG1zZy0+aW92YSwgbXNnLT5zaXplLCBtc2ctPnVhZGRyLAo+ICsJ
CQkJIG1zZy0+cGVybSk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9j
ZXNzX2lvdGxiX21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

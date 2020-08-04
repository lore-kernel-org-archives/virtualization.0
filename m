Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36AEC433DF
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:52:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CE62075A
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gia6rZVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CE62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4F167204E1;
	Tue,  4 Aug 2020 08:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GxzNvj1egwvA; Tue,  4 Aug 2020 08:52:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F04D320429;
	Tue,  4 Aug 2020 08:52:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4E97C0051;
	Tue,  4 Aug 2020 08:52:17 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4464BC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:52:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2FEDE20441
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mlWcqPi5Ta5a
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:52:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 1C67120429
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596531134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqjEJLolPmGHNe5yaOt/yfSsQ1bGdkSL/AwXQ/PFIg4=;
 b=Gia6rZVx9u+RzOIe/7sfic301ylNIJXncAu59tQpCRwwbXw8erXHP+blgbE/9wQmOlpbPM
 dBFKGGUfySV/tF5ZHclhdgThuq95Q15Kh1m/f2guHGktsgm4efo2w0ocAGq6nDmDZ2/tRz
 4LsTXjBIfQa8y64ZpOUHdavqcvlRvWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-OEkxtpFKOnqa8QMMyG6L9w-1; Tue, 04 Aug 2020 04:52:10 -0400
X-MC-Unique: OEkxtpFKOnqa8QMMyG6L9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA7E8014D7;
 Tue,  4 Aug 2020 08:52:08 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 966FF5C5B7;
 Tue,  4 Aug 2020 08:51:45 +0000 (UTC)
Subject: Re: [PATCH V5 4/6] vhost_vdpa: implement IRQ offloading in vhost_vdpa
To: Zhu Lingshan <lingshan.zhu@intel.com>, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 wanpengli@tencent.com
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-5-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5212669d-6e7b-21cb-6e25-1837d70624b2@redhat.com>
Date: Tue, 4 Aug 2020 16:51:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731065533.4144-5-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, parav@mellanox.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

Ck9uIDIwMjAvNy8zMSDkuIvljYgyOjU1LCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4gVGhpcyBwYXRj
aCBpbnRyb2R1Y2UgYSBzZXQgb2YgZnVuY3Rpb25zIGZvciBzZXR1cC91bnNldHVwCj4gYW5kIHVw
ZGF0ZSBpcnEgb2ZmbG9hZGluZyByZXNwZWN0aXZlbHkgYnkgcmVnaXN0ZXIvdW5yZWdpc3Rlcgo+
IGFuZCByZS1yZWdpc3RlciB0aGUgaXJxX2J5cGFzc19wcm9kdWNlci4KPgo+IFdpdGggdGhlc2Ug
ZnVuY3Rpb25zLCB0aGlzIGNvbW1pdCBjYW4gc2V0dXAvdW5zZXR1cAo+IGlycSBvZmZsb2FkaW5n
IHRocm91Z2ggc2V0dGluZyBEUklWRVJfT0svIURSSVZFUl9PSywgYW5kCj4gdXBkYXRlIGlycSBv
ZmZsb2FkaW5nIHRocm91Z2ggU0VUX1ZSSU5HX0NBTEwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUg
TGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC9LY29uZmln
IHwgIDEgKwo+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgIHwgNzkgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9LY29u
ZmlnIGIvZHJpdmVycy92aG9zdC9LY29uZmlnCj4gaW5kZXggZDM2ODhjNmFmYjg3Li41ODdmYmFl
MDYxODIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC9LY29uZmlnCj4gKysrIGIvZHJpdmVy
cy92aG9zdC9LY29uZmlnCj4gQEAgLTY1LDYgKzY1LDcgQEAgY29uZmlnIFZIT1NUX1ZEUEEKPiAg
IAl0cmlzdGF0ZSAiVmhvc3QgZHJpdmVyIGZvciB2RFBBLWJhc2VkIGJhY2tlbmQiCj4gICAJZGVw
ZW5kcyBvbiBFVkVOVEZECj4gICAJc2VsZWN0IFZIT1NUCj4gKwlzZWxlY3QgSVJRX0JZUEFTU19N
QU5BR0VSCj4gICAJZGVwZW5kcyBvbiBWRFBBCj4gICAJaGVscAo+ICAgCSAgVGhpcyBrZXJuZWwg
bW9kdWxlIGNhbiBiZSBsb2FkZWQgaW4gaG9zdCBrZXJuZWwgdG8gYWNjZWxlcmF0ZQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5k
ZXggZGYzY2YzODZiMGNkLi4yNzhlYTJmMDAxNzIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9z
dC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC0xMTUsNiArMTE1LDU1
IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCB2aG9zdF92ZHBhX2NvbmZpZ19jYih2b2lkICpwcml2YXRl
KQo+ICAgCXJldHVybiBJUlFfSEFORExFRDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2aG9z
dF92ZHBhX3NldHVwX3ZxX2lycShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTE2IHFpZCkKPiArewo+
ICsJc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEgPSAmdi0+dnFzW3FpZF07Cj4gKwljb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2LT52ZHBhLT5jb25maWc7Cj4gKwlzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+ICsJaW50IHJldCwgaXJxOwo+ICsKPiArCXNw
aW5fbG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiArCWlycSA9IG9wcy0+Z2V0X3ZxX2ly
cSh2ZHBhLCBxaWQpOwo+ICsJaWYgKCF2cS0+Y2FsbF9jdHguY3R4IHx8IGlycSA8IDApIHsKPiAr
CQlzcGluX3VubG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiArCQlyZXR1cm47Cj4gKwl9
Cj4gKwo+ICsJdnEtPmNhbGxfY3R4LnByb2R1Y2VyLnRva2VuID0gdnEtPmNhbGxfY3R4LmN0eDsK
PiArCXZxLT5jYWxsX2N0eC5wcm9kdWNlci5pcnEgPSBpcnE7Cj4gKwlyZXQgPSBpcnFfYnlwYXNz
X3JlZ2lzdGVyX3Byb2R1Y2VyKCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+ICsJc3Bpbl91bmxv
Y2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHZob3N0
X3ZkcGFfdW5zZXR1cF92cV9pcnEoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4gK3sK
PiArCXN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxID0gJnYtPnZxc1txaWRdOwo+ICsKPiArCXNw
aW5fbG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiArCWlycV9ieXBhc3NfdW5yZWdpc3Rl
cl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKCgpBbnkgcmVhc29uIGZvciBub3Qg
Y2hlY2tpbmcgdnEtPmNhbGxfY3R4LnByb2R1Y2VyLmlycSBhcyBiZWxvdyBoZXJlPwoKCj4gKwlz
cGluX3VubG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiArfQo+ICsKPiArc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV91cGRhdGVfdnFfaXJxKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxKQo+
ICt7Cj4gKwlzcGluX2xvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gKwkvKgo+ICsJICog
aWYgaXQgaGFzIGEgbm9uLXplcm8gaXJxLCBtZWFucyB0aGVyZSBpcyBhCj4gKwkgKiBwcmV2aXNv
dWx5IHJlZ2lzdGVyZWQgaXJxX2J5cGFzc19wcm9kdWNlciwKPiArCSAqIHdlIHNob3VsZCB1cGRh
dGUgaXQgd2hlbiBjdHggKGl0cyB0b2tlbikKPiArCSAqIGNoYW5nZXMuCj4gKwkgKi8KPiArCWlm
ICghdnEtPmNhbGxfY3R4LnByb2R1Y2VyLmlycSkgewo+ICsJCXNwaW5fdW5sb2NrKCZ2cS0+Y2Fs
bF9jdHguY3R4X2xvY2spOwo+ICsJCXJldHVybjsKPiArCX0KPiArCj4gKwlpcnFfYnlwYXNzX3Vu
cmVnaXN0ZXJfcHJvZHVjZXIoJnZxLT5jYWxsX2N0eC5wcm9kdWNlcik7Cj4gKwl2cS0+Y2FsbF9j
dHgucHJvZHVjZXIudG9rZW4gPSB2cS0+Y2FsbF9jdHguY3R4Owo+ICsJaXJxX2J5cGFzc19yZWdp
c3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKPiArCXNwaW5fdW5sb2NrKCZ2
cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+ICt9CgoKSSB0aGluayBzZXR1cF9pcnEoKSBhbmQgdXBk
YXRlX2lycSgpIGNvdWxkIGJlIHVuaWZpZWQgd2l0aCB0aGUgZm9sbG93aW5nIApsb2dpYzoKCmly
cV9ieXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsKaXJx
ID0gb3BzLT5nZXRfdnFfaXJxKHZkcGEsIHFpZCk7CiDCoMKgwqAgaWYgKCF2cS0+Y2FsbF9jdHgu
Y3R4IHx8IGlycSA8IDApIHsKIMKgwqDCoCDCoMKgwqAgc3Bpbl91bmxvY2soJnZxLT5jYWxsX2N0
eC5jdHhfbG9jayk7CiDCoMKgwqAgwqDCoMKgIHJldHVybjsKIMKgwqDCoCB9Cgp2cS0+Y2FsbF9j
dHgucHJvZHVjZXIudG9rZW4gPSB2cS0+Y2FsbF9jdHguY3R4Owp2cS0+Y2FsbF9jdHgucHJvZHVj
ZXIuaXJxID0gaXJxOwpyZXQgPSBpcnFfYnlwYXNzX3JlZ2lzdGVyX3Byb2R1Y2VyKCZ2cS0+Y2Fs
bF9jdHgucHJvZHVjZXIpOwoKPiArCj4gICBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3Jlc2V0KHN0
cnVjdCB2aG9zdF92ZHBhICp2KQo+ICAgewo+ICAgCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9
IHYtPnZkcGE7Cj4gQEAgLTE1NSwxMSArMjA0LDE1IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
c2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+ICAg
ewo+ICAgCXN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gICAJY29uc3Qgc3Ry
dWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+IC0JdTggc3RhdHVzOwo+
ICsJdTggc3RhdHVzLCBzdGF0dXNfb2xkOwo+ICsJaW50IG52cXMgPSB2LT5udnFzOwo+ICsJdTE2
IGk7Cj4gICAKPiAgIAlpZiAoY29weV9mcm9tX3VzZXIoJnN0YXR1cywgc3RhdHVzcCwgc2l6ZW9m
KHN0YXR1cykpKQo+ICAgCQlyZXR1cm4gLUVGQVVMVDsKPiAgIAo+ICsJc3RhdHVzX29sZCA9IG9w
cy0+Z2V0X3N0YXR1cyh2ZHBhKTsKPiArCj4gICAJLyoKPiAgIAkgKiBVc2Vyc3BhY2Ugc2hvdWxk
bid0IHJlbW92ZSBzdGF0dXMgYml0cyB1bmxlc3MgcmVzZXQgdGhlCj4gICAJICogc3RhdHVzIHRv
IDAuCj4gQEAgLTE2OSw2ICsyMjIsMTUgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRfc3Rh
dHVzKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4gICAKPiAgIAlv
cHMtPnNldF9zdGF0dXModmRwYSwgc3RhdHVzKTsKPiAgIAo+ICsJLyogdnEgaXJxIGlzIG5vdCBl
eHBlY3RlZCB0byBiZSBjaGFuZ2VkIG9uY2UgRFJJVkVSX09LIGlzIHNldCAqLwoKCkxldCdzIG1v
dmUgdGhpcyBjb21tZW50IHRvIHRoZSBnZXRfdnFfaXJxIGJ1cyBvcGVyYXRpb24uCgoKPiArCWlm
ICgoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgJiYgIShzdGF0dXNfb2xkICYg
VklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykpCj4gKwkJZm9yIChpID0gMDsgaSA8IG52cXM7IGkr
KykKPiArCQkJdmhvc3RfdmRwYV9zZXR1cF92cV9pcnEodiwgaSk7Cj4gKwo+ICsJaWYgKChzdGF0
dXNfb2xkICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykgJiYgIShzdGF0dXMgJiBWSVJUSU9f
Q09ORklHX1NfRFJJVkVSX09LKSkKPiArCQlmb3IgKGkgPSAwOyBpIDwgbnZxczsgaSsrKQo+ICsJ
CQl2aG9zdF92ZHBhX3Vuc2V0dXBfdnFfaXJxKHYsIGkpOwo+ICsKPiAgIAlyZXR1cm4gMDsKPiAg
IH0KPiAgIAo+IEBAIC0zMzIsNiArMzk0LDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRf
Y29uZmlnX2NhbGwoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUzMiBfX3VzZXIgKmFyZ3ApCj4gICAK
PiAgIAlyZXR1cm4gMDsKPiAgIH0KPiArCj4gICBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5n
X2lvY3RsKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgCQkJCSAg
IHZvaWQgX191c2VyICphcmdwKQo+ICAgewo+IEBAIC0zOTAsNiArNDUzLDcgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV92cmluZ19pb2N0bChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQg
aW50IGNtZCwKPiAgIAkJCWNiLnByaXZhdGUgPSBOVUxMOwo+ICAgCQl9Cj4gICAJCW9wcy0+c2V0
X3ZxX2NiKHZkcGEsIGlkeCwgJmNiKTsKPiArCQl2aG9zdF92ZHBhX3VwZGF0ZV92cV9pcnEodnEp
Owo+ICAgCQlicmVhazsKPiAgIAo+ICAgCWNhc2UgVkhPU1RfU0VUX1ZSSU5HX05VTToKPiBAQCAt
NzY1LDYgKzgyOSwxOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfb3BlbihzdHJ1Y3QgaW5vZGUg
Kmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gICAJcmV0dXJuIHI7Cj4gICB9Cj4gICAKPiAr
c3RhdGljIHZvaWQgdmhvc3RfdmRwYV9jbGVhbl9pcnEoc3RydWN0IHZob3N0X3ZkcGEgKnYpCj4g
K3sKPiArCXN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxOwo+ICsJaW50IGk7Cj4gKwo+ICsJZm9y
IChpID0gMDsgaSA8IHYtPm52cXM7IGkrKykgewo+ICsJCXZxID0gJnYtPnZxc1tpXTsKPiArCQlp
ZiAodnEtPmNhbGxfY3R4LnByb2R1Y2VyLmlycSkKPiArCQkJaXJxX2J5cGFzc191bnJlZ2lzdGVy
X3Byb2R1Y2VyKCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+ICsJfQo+ICt9CgoKV2h5IG5vdCB1
c2luZyB2aG9zdF92ZHBhX3Vuc2V0dXBfdnFfaXJxKCk/CgpUaGFua3MKCgo+ICsKPiAgIHN0YXRp
YyBpbnQgdmhvc3RfdmRwYV9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxl
ICpmaWxlcCkKPiAgIHsKPiAgIAlzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiA9IGZpbGVwLT5wcml2YXRl
X2RhdGE7Cj4gQEAgLTc3Nyw2ICs4NTMsNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVsZWFz
ZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gICAJdmhvc3RfdmRw
YV9pb3RsYl9mcmVlKHYpOwo+ICAgCXZob3N0X3ZkcGFfZnJlZV9kb21haW4odik7Cj4gICAJdmhv
c3RfdmRwYV9jb25maWdfcHV0KHYpOwo+ICsJdmhvc3RfdmRwYV9jbGVhbl9pcnEodik7Cj4gICAJ
dmhvc3RfZGV2X2NsZWFudXAoJnYtPnZkZXYpOwo+ICAgCWtmcmVlKHYtPnZkZXYudnFzKTsKPiAg
IAltdXRleF91bmxvY2soJmQtPm11dGV4KTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

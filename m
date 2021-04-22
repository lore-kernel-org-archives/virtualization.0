Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C354C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 02:37:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9613761453
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 02:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9613761453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4035983D52;
	Thu, 22 Apr 2021 02:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2CMsYabZHdmd; Thu, 22 Apr 2021 02:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D160883D0C;
	Thu, 22 Apr 2021 02:37:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1A93C000E;
	Thu, 22 Apr 2021 02:37:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E622C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 02:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2FFBF40E5B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 02:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLG-8v867Zk1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 02:37:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5266405FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 02:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619059065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Inh19Rdi8OHMk1GcJYs3DU+EPz9TREj6IWlYcp5GPTY=;
 b=hu81A+Znrqcj2S3YADnX1pf4Mdp/+sqUuEyljpmhzcixdT1+nIR5l8pAqg7h54YwlVaaPx
 K290n+3+nntrhgBzIQrL8XuAYq5Yk7bInxcIRn4F+vOigwPZb0jGcsZnNr0921X1EmDh7h
 0NlnXjIesgF8x/T1XNB3PMID1WE1VNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Gnon2iFYPoavERAheM8_FQ-1; Wed, 21 Apr 2021 22:37:43 -0400
X-MC-Unique: Gnon2iFYPoavERAheM8_FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 012CE802575;
 Thu, 22 Apr 2021 02:37:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-214.pek2.redhat.com
 [10.72.13.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D63F610A8;
 Thu, 22 Apr 2021 02:37:40 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com
References: <20210421104145.115907-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
Date: Thu, 22 Apr 2021 10:37:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421104145.115907-1-elic@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNC8yMSDPws7nNjo0MSwgRWxpIENvaGVuINC0tcA6Cj4gSW1wbGVtZW50IG1seDVf
Z2V0X3ZxX25vdGlmaWNhdGlvbigpIHRvIHJldHVybiB0aGUgZG9vcmJlbGwgYWRkcmVzcy4KPiBT
aXplIGlzIHNldCB0byBvbmUgc3lzdGVtIHBhZ2UgYXMgcmVxdWlyZWQuCj4KPiBTaWduZWQtb2Zm
LWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbWx4NV92ZHBhLmggfCAxICsKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVz
b3VyY2VzLmMgfCAxICsKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAgfCA2
ICsrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIGIvZHJpdmVycy92ZHBhL21s
eDUvY29yZS9tbHg1X3ZkcGEuaAo+IGluZGV4IGI2Y2M1M2JhOTgwYy4uNDlkZTYyY2RhNTk4IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgKPiArKysgYi9k
cml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gQEAgLTQxLDYgKzQxLDcgQEAgc3Ry
dWN0IG1seDVfdmRwYV9yZXNvdXJjZXMgewo+ICAgCXUzMiBwZG47Cj4gICAJc3RydWN0IG1seDVf
dWFyc19wYWdlICp1YXI7Cj4gICAJdm9pZCBfX2lvbWVtICpraWNrX2FkZHI7Cj4gKwl1NjQgcGh5
c19raWNrX2FkZHI7Cj4gICAJdTE2IHVpZDsKPiAgIAl1MzIgbnVsbF9ta2V5Owo+ICAgCWJvb2wg
dmFsaWQ7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL3Jlc291cmNlcy5jCj4gaW5kZXggNjUyMWNiZDBmNWMy
Li42NjVmOGZjMTcxMGYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9yZXNv
dXJjZXMuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvcmVzb3VyY2VzLmMKPiBAQCAt
MjQ3LDYgKzI0Nyw3IEBAIGludCBtbHg1X3ZkcGFfYWxsb2NfcmVzb3VyY2VzKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldikKPiAgIAkJZ290byBlcnJfa2V5Owo+ICAgCj4gICAJa2lja19hZGRy
ID0gbWRldi0+YmFyX2FkZHIgKyBvZmZzZXQ7Cj4gKwlyZXMtPnBoeXNfa2lja19hZGRyID0ga2lj
a19hZGRyOwo+ICAgCj4gICAJcmVzLT5raWNrX2FkZHIgPSBpb3JlbWFwKGtpY2tfYWRkciwgUEFH
RV9TSVpFKTsKPiAgIAlpZiAoIXJlcy0+a2lja19hZGRyKSB7Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYwo+IGluZGV4IDEwYzVmZWYzYzAyMC4uNjgwNzUxMDc0ZDJhIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0xODY1LDggKzE4NjUsMTQgQEAgc3RhdGljIHZvaWQg
bWx4NV92ZHBhX2ZyZWUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KQo+ICAgCj4gICBzdGF0aWMg
c3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgbWx4NV9nZXRfdnFfbm90aWZpY2F0aW9uKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkKPiAgIHsKPiArCXN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+ICAgCXN0cnVjdCB2ZHBhX25vdGlmaWNh
dGlvbl9hcmVhIHJldCA9IHt9Owo+ICsJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4gKwo+
ICsJbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAgIAo+ICsJcmV0LmFkZHIgPSAo
cGh5c19hZGRyX3QpbmRldi0+bXZkZXYucmVzLnBoeXNfa2lja19hZGRyOwo+ICsJcmV0LnNpemUg
PSBQQUdFX1NJWkU7CgoKTm90ZSB0aGF0IHRoZSBwYWdlIHdpbGwgYmUgbWFwcGVkIGluIHRvIGd1
ZXN0LCBzbyBpdCdzIG9ubHkgc2FmZSBpZiB0aGUgCmRvb3JiZWVsIGV4Y2x1c2l2ZWx5IG93biB0
aGUgcGFnZS4gVGhpcyBtZWFucyBpZiB0aGVyZSdyZSBvdGhlciAKcmVnaXN0ZXJzIGluIHRoZSBw
YWdlLCB3ZSBjYW4gbm90IGxldCB0aGUgZG9vcmJlbGwgYnlwYXNzIHRvIHdvcmsuCgpTbyB0aGlz
IGlzIHN1c3BpY2lvdXMgYXQgbGVhc3QgaW4gdGhlIGNhc2Ugb2Ygc3ViZnVuY3Rpb24gd2hlcmUg
d2UgCmNhbGN1bGF0ZSB0aGUgYmFyIGxlbmd0aCBpbiBtbHg1X3NmX2Rldl90YWJsZV9jcmVhdGUo
KSBhczoKCnRhYmxlLT5zZl9iYXJfbGVuZ3RoID0gMSA8PCAoTUxYNV9DQVBfR0VOKGRldiwgbG9n
X21pbl9zZl9zaXplKSArIDEyKTsKCkl0IGxvb2tzIHRvIG1lIHRoaXMgY2FuIG9ubHkgd29yayBm
b3IgdGhlIGFyY2ggd2l0aCBQQUdFX1NJWkUgPSA0MDk2LCAKb3RoZXJ3aXNlIHdlIGNhbiBtYXAg
bW9yZSBpbnRvIHRoZSB1c2Vyc3BhY2UoZ3Vlc3QpLgoKVGhhbmtzCgoKCj4gICAJcmV0dXJuIHJl
dDsKPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

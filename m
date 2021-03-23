Return-Path: <SRS0=L1Zq=IV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A9BC433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 03:02:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F6761998
	for <virtualization@archiver.kernel.org>; Tue, 23 Mar 2021 03:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F6761998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 767AF6080B;
	Tue, 23 Mar 2021 03:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aZChnfSGa5be; Tue, 23 Mar 2021 03:02:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2380060808;
	Tue, 23 Mar 2021 03:02:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCB2EC000A;
	Tue, 23 Mar 2021 03:02:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18485C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D46240359
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AQ5D5ERZWImt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:02:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18551402FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 03:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616468554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqPb4TLeg/4W4bHsX4Gzo6cnsaw2oDqjTlzBaVJEzig=;
 b=D4ciXllZTzPnBGkFgGjFjwcXYA/hqZeZV0KHVL2yV2tCHBRUtpxq6wizONCCp9mfWSNQ2y
 j6hBf3qUxB95tv6xsl/wmWaMlrwpw20dFobFGOg2hIxAmU5AZohs8rYjRoOjILRcCRnLNx
 Hl+9VPTrC/5a3ZxCfLyWoGwlCjkZm8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-Bm8Un-RYP9C2dwbPJU6f5g-1; Mon, 22 Mar 2021 23:02:29 -0400
X-MC-Unique: Bm8Un-RYP9C2dwbPJU6f5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B014881276;
 Tue, 23 Mar 2021 03:02:27 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-238.pek2.redhat.com
 [10.72.12.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 187771F05A;
 Tue, 23 Mar 2021 03:02:10 +0000 (UTC)
Subject: Re: [PATCH v5 03/11] vhost-vdpa: protect concurrent access to vhost
 device iotlb
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
 dan.carpenter@oracle.com
References: <20210315053721.189-1-xieyongji@bytedance.com>
 <20210315053721.189-4-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <38a2ae38-ebf7-3e3b-3439-d95a6f49b48b@redhat.com>
Date: Tue, 23 Mar 2021 11:02:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315053721.189-4-xieyongji@bytedance.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

CtTaIDIwMjEvMy8xNSDPws7nMTozNywgWGllIFlvbmdqaSDQtLXAOgo+IFVzZSB2aG9zdF9kZXYt
Pm11dGV4IHRvIHByb3RlY3Qgdmhvc3QgZGV2aWNlIGlvdGxiIGZyb20KPiBjb25jdXJyZW50IGFj
Y2Vzcy4KPgo+IEZpeGVzOiA0YzhjZjMxOCgidmhvc3Q6IGludHJvZHVjZSB2RFBBLWJhc2VkIGJh
Y2tlbmQiKQo+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2Uu
Y29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKUGxlYXNl
IGNjIHN0YWJsZSBmb3IgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzCgoKPiAtLS0KPiAgIGRyaXZlcnMv
dmhvc3QvdmRwYS5jIHwgNiArKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gaW5kZXggY2IxNGM2NmViMmVjLi4zZjcxNzVjMmFjMjQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0
L3ZkcGEuYwo+IEBAIC03MTksOSArNzE5LDExIEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9wcm9j
ZXNzX2lvdGxiX21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAJY29uc3Qgc3RydWN0IHZk
cGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ICAgCWludCByID0gMDsKPiAgIAo+
ICsJbXV0ZXhfbG9jaygmZGV2LT5tdXRleCk7Cj4gKwo+ICAgCXIgPSB2aG9zdF9kZXZfY2hlY2tf
b3duZXIoZGV2KTsKPiAgIAlpZiAocikKPiAtCQlyZXR1cm4gcjsKPiArCQlnb3RvIHVubG9jazsK
PiAgIAo+ICAgCXN3aXRjaCAobXNnLT50eXBlKSB7Cj4gICAJY2FzZSBWSE9TVF9JT1RMQl9VUERB
VEU6Cj4gQEAgLTc0Miw2ICs3NDQsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcHJvY2Vzc19p
b3RsYl9tc2coc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAgCQlyID0gLUVJTlZBTDsKPiAgIAkJ
YnJlYWs7Cj4gICAJfQo+ICt1bmxvY2s6Cj4gKwltdXRleF91bmxvY2soJmRldi0+bXV0ZXgpOwo+
ICAgCj4gICAJcmV0dXJuIHI7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

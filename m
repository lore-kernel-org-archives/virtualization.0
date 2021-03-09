Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30161C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:18:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CA765290
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CA765290
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77B2683C91;
	Tue,  9 Mar 2021 02:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PqKjFEHfTqBc; Tue,  9 Mar 2021 02:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EEBC83A7B;
	Tue,  9 Mar 2021 02:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B2B7C000B;
	Tue,  9 Mar 2021 02:18:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09722C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECDF26F55D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tjwC6uEvjlkB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:18:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8713605CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615256305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rcShwLoJWnpEZpwYw3XT7sfmNyFh50D0tcu/Ys15ACw=;
 b=Xl/nDcYcvmw2geBsxOImbRY8FeHfBxdFEF4vjSRXKAiZqOlhwSBj7JizoXZ8MsYk8WUdFE
 CCCuXCBNrMeXEF5yfG2IsrS6VqKxJnxytKtCotXn/PgoJaJwYPWa9ljm45dTleCkJOZ0JN
 vo60GOQzzunNTSzW8ffuBRpkjxABVbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Yjo8hpWsNR6Gv8zljaCtoQ-1; Mon, 08 Mar 2021 21:18:20 -0500
X-MC-Unique: Yjo8hpWsNR6Gv8zljaCtoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0E2C80432D;
 Tue,  9 Mar 2021 02:18:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-202.pek2.redhat.com
 [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61C0D5C27C;
 Tue,  9 Mar 2021 02:18:12 +0000 (UTC)
Subject: Re: [PATCH V2 1/4] vDPA/ifcvf: get_vendor_id returns a device
 specific vendor id
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com
References: <20210308083525.382514-1-lingshan.zhu@intel.com>
 <20210308083525.382514-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2a7b9cba-620f-a447-7de6-0b9dc74817ba@redhat.com>
Date: Tue, 9 Mar 2021 10:18:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308083525.382514-2-lingshan.zhu@intel.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Ck9uIDIwMjEvMy84IDQ6MzUg5LiL5Y2ILCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4gSW4gdGhpcyBj
b21taXQsIGlmY3ZmX2dldF92ZW5kb3JfaWQoKSB3aWxsIHJldHVybgo+IGEgZGV2aWNlIHNwZWNp
ZmljIHZlbmRvciBpZCBvZiB0aGUgcHJvYmVkIHBjaSBkZXZpY2UKPiB0aGFuIGEgaGFyZCBjb2Rl
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29t
PgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4g
ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgNSArKysrLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
bWFpbi5jCj4gaW5kZXggZmExYWYzMDFjZjU1Li5lNTAxZWUwN2RlMTcgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiBAQCAtMzI0LDcgKzMyNCwxMCBAQCBzdGF0aWMgdTMyIGlmY3ZmX3Zk
cGFfZ2V0X2RldmljZV9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgCj4gICBz
dGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRvcl9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2KQo+ICAgewo+IC0JcmV0dXJuIElGQ1ZGX1NVQlNZU19WRU5ET1JfSUQ7Cj4gKwlzdHJ1
Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4g
KwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4gKwo+ICsJcmV0dXJuIHBk
ZXYtPnN1YnN5c3RlbV92ZW5kb3I7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB1MzIgaWZjdmZfdmRw
YV9nZXRfdnFfYWxpZ24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==

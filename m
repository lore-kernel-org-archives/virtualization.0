Return-Path: <SRS0=SHSW=II=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF465C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 12:58:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCF764FDF
	for <virtualization@archiver.kernel.org>; Wed, 10 Mar 2021 12:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCF764FDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E20CF6F589;
	Wed, 10 Mar 2021 12:58:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mP1RSqwQp45y; Wed, 10 Mar 2021 12:58:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F7C76F4F7;
	Wed, 10 Mar 2021 12:58:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63222C000E;
	Wed, 10 Mar 2021 12:58:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B046C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 12:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 593F06F589
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 12:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jAZsz2MBIiZe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 12:58:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D7F96F4F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615381122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=focYiE8f6AZlwFwtTWyFc1fGn5rNUZQWCBuImpia4/w=;
 b=V4lLFObT4mUQBI0GvseH0lTKYUcFnTVnUEV8iNLV3g0fCv0K6qWvf8aTCjlQaVaT4zaVbs
 1kv7jqzmZt9VnK8K7UGRGgZ2zrj27PUU8yoVinC64/91AGuTHNYGAycORsavLkkDiY0lEw
 3TQP4kfdNao7hMJ1bV9lZ5IQqPcPStY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-mZVwZQJ_MeK5xzM2jKWTiw-1; Wed, 10 Mar 2021 07:58:40 -0500
X-MC-Unique: mZVwZQJ_MeK5xzM2jKWTiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D16891084D68;
 Wed, 10 Mar 2021 12:58:37 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-26.pek2.redhat.com
 [10.72.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0995960C0F;
 Wed, 10 Mar 2021 12:58:31 +0000 (UTC)
Subject: Re: [RFC v4 07/11] vduse: Introduce VDUSE - vDPA Device in Userspace
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-8-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2c7446dd-38f8-a06a-e423-6744c6a7207f@redhat.com>
Date: Wed, 10 Mar 2021 20:58:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-8-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiArCj4gKwlzd2l0
Y2ggKGNtZCkgewo+ICsJY2FzZSBWRFVTRV9JT1RMQl9HRVRfRkQ6IHsKPiArCQlzdHJ1Y3QgdmR1
c2VfaW90bGJfZW50cnkgZW50cnk7Cj4gKwkJc3RydWN0IHZob3N0X2lvdGxiX21hcCAqbWFwOwo+
ICsJCXN0cnVjdCB2ZHBhX21hcF9maWxlICptYXBfZmlsZTsKPiArCQlzdHJ1Y3QgZmlsZSAqZiA9
IE5VTEw7Cj4gKwo+ICsJCXJldCA9IC1FRkFVTFQ7Cj4gKwkJaWYgKGNvcHlfZnJvbV91c2VyKCZl
bnRyeSwgYXJncCwgc2l6ZW9mKGVudHJ5KSkpCj4gKwkJCWJyZWFrOwo+ICsKPiArCQlzcGluX2xv
Y2soJmRldi0+aW9tbXVfbG9jayk7Cj4gKwkJbWFwID0gdmhvc3RfaW90bGJfaXRyZWVfZmlyc3Qo
ZGV2LT5pb21tdSwgZW50cnkuc3RhcnQsCj4gKwkJCQkJICAgICAgZW50cnkubGFzdCk7Cj4gKwkJ
aWYgKG1hcCkgewo+ICsJCQltYXBfZmlsZSA9IChzdHJ1Y3QgdmRwYV9tYXBfZmlsZSAqKW1hcC0+
b3BhcXVlOwo+ICsJCQlmID0gZ2V0X2ZpbGUobWFwX2ZpbGUtPmZpbGUpOwo+ICsJCQllbnRyeS5v
ZmZzZXQgPSBtYXBfZmlsZS0+b2Zmc2V0Owo+ICsJCQllbnRyeS5zdGFydCA9IG1hcC0+c3RhcnQ7
Cj4gKwkJCWVudHJ5Lmxhc3QgPSBtYXAtPmxhc3Q7Cj4gKwkJCWVudHJ5LnBlcm0gPSBtYXAtPnBl
cm07Cj4gKwkJfQo+ICsJCXNwaW5fdW5sb2NrKCZkZXYtPmlvbW11X2xvY2spOwo+ICsJCWlmICgh
Zikgewo+ICsJCQlyZXQgPSAtRUlOVkFMOwo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwkJaWYgKGNv
cHlfdG9fdXNlcihhcmdwLCAmZW50cnksIHNpemVvZihlbnRyeSkpKSB7Cj4gKwkJCWZwdXQoZik7
Cj4gKwkJCXJldCA9IC1FRkFVTFQ7Cj4gKwkJCWJyZWFrOwo+ICsJCX0KPiArCQlyZXQgPSBnZXRf
dW51c2VkX2ZkX2ZsYWdzKHBlcm1fdG9fZmlsZV9mbGFncyhlbnRyeS5wZXJtKSk7Cj4gKwkJaWYg
KHJldCA8IDApIHsKPiArCQkJZnB1dChmKTsKPiArCQkJYnJlYWs7Cj4gKwkJfQo+ICsJCWZkX2lu
c3RhbGwocmV0LCBmKTsKCgpTbyBhdCBsZWFzdCB3ZSBuZWVkIHRvIHVzZSByZWNlaWNlX2ZkX3Vz
ZXIoKSBoZXJlIHRvIGdpdmUgYSBjaGFuY2UgdG8gYmUgCmhvb2tlZCBpbnRvIHNlY3VyaXR5IG1v
ZHVsZS4KCkNvbnNpZGVyIHRoaXMgaXMgYmFzY2lhbGx5IGEga2luZCBvZiBwYXNzaW5nIGZpbGUg
ZGVzY3JpcHRvciBpbXBsaWNpdGx5LiAKV2UgbmVlZCB0byBiZSBjYXJlZnVsIGlmIGFueSBzZWN1
cml0eSBzdHVmc3MgaXMgbWlzc2VkLgoKKEhhdmUgYSBxdWljayBnbGFuY2UgYXQgc2NtX3NlbmQv
cmVjdiwgZmVlbCBvayBidXQgbmVlZCB0byBkb3VibGUgY2hlY2spLgoKVGhhbmtzCgoKPiArCQli
cmVhazsKPiArCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

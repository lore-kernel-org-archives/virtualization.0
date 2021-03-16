Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685F9C43332
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 06:09:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA6BC6502D
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 06:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6BC6502D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80DDD4EC12;
	Tue, 16 Mar 2021 06:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ruDntZmJDruN; Tue, 16 Mar 2021 06:09:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7ED246B64;
	Tue, 16 Mar 2021 06:09:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4D05C000C;
	Tue, 16 Mar 2021 06:09:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C709DC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD0F74EC12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gxCbnTKin6Yr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A449A46B64
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 06:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615874951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BW1sBItML7wtTpQapaMP53TtXuZoCkLLYqm0wfSE7A=;
 b=aeALjptf0D1GZe1rynXJlkji7xAp5HutG/t8kbwHHMDU1Dzv5gYlSUnEogUZoPm5Mc081+
 QcYWjyuPP7o8h5RipsEnOwHzJzSx2J8SAKXn/lEF4McwSmZc4HCfrbtVRu/5hvSx4RQoSH
 Ela4T9l1YWekJHGOur0bvsysnJfachc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-VChqBI0RMoW8WQp27xjQ-g-1; Tue, 16 Mar 2021 02:09:09 -0400
X-MC-Unique: VChqBI0RMoW8WQp27xjQ-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94237801817;
 Tue, 16 Mar 2021 06:09:07 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-216.pek2.redhat.com
 [10.72.12.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 746CF60C0F;
 Tue, 16 Mar 2021 06:09:01 +0000 (UTC)
Subject: Re: [PATCH V4 1/7] vDPA/ifcvf: get_vendor_id returns a device
 specific vendor id
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210315074501.15868-1-lingshan.zhu@intel.com>
 <20210315074501.15868-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ad48606-1ed1-0b96-a236-ecdb0b01e560@redhat.com>
Date: Tue, 16 Mar 2021 14:09:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315074501.15868-2-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8xNSDPws7nMzo0NCwgWmh1IExpbmdzaGFuINC0tcA6Cj4gSW4gdGhpcyBjb21t
aXQsIGlmY3ZmX2dldF92ZW5kb3JfaWQoKSB3aWxsIHJldHVybgo+IGEgZGV2aWNlIHNwZWNpZmlj
IHZlbmRvciBpZCBvZiB0aGUgcHJvYmVkIHBjaSBkZXZpY2UKPiB0aGFuIGEgaGFyZCBjb2RlLgo+
Cj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBk
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgNSArKysrLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4gaW5kZXggZmExYWYzMDFjZjU1Li5lNTAxZWUwN2RlMTcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPiBAQCAtMzI0LDcgKzMyNCwxMCBAQCBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFf
Z2V0X2RldmljZV9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgCj4gICBzdGF0
aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRvcl9pZChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFf
ZGV2KQo+ICAgewo+IC0JcmV0dXJuIElGQ1ZGX1NVQlNZU19WRU5ET1JfSUQ7Cj4gKwlzdHJ1Y3Qg
aWZjdmZfYWRhcHRlciAqYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4gKwlz
dHJ1Y3QgcGNpX2RldiAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4gKwo+ICsJcmV0dXJuIHBkZXYt
PnN1YnN5c3RlbV92ZW5kb3I7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9n
ZXRfdnFfYWxpZ24oc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldikKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

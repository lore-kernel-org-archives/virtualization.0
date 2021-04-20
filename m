Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56889C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 02:56:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30A561354
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 02:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30A561354
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 792E8834B9;
	Tue, 20 Apr 2021 02:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VM5cuU5LJgpt; Tue, 20 Apr 2021 02:56:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E50B828DE;
	Tue, 20 Apr 2021 02:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04959C000E;
	Tue, 20 Apr 2021 02:56:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22AF6C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 034B8403BF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R28w50d9VyVY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:56:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05256403C0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618887408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE7LME23WUWVeXeRfQveamynPNr8MvEiH4grzJIaWTk=;
 b=NS4Ag9OZbhZoT2WB17G1ig1Qh5RkKvIWGm39nM37TzpOfYgk4b7gY3aZAgjuXp7lGAlAbu
 TD0OtvfSx/3AGyliyyb1FS7u93ZOurUrfUV/Ah5fJUlOZrAph9zELtjyMerxWdrkQxXH7M
 4YI3nL9E76UHvl4odPQQckUgucfTdlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-iQ2M1oXpPD2yq6tNf7YBHQ-1; Mon, 19 Apr 2021 22:56:44 -0400
X-MC-Unique: iQ2M1oXpPD2yq6tNf7YBHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D44683DD21;
 Tue, 20 Apr 2021 02:56:43 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-125.pek2.redhat.com
 [10.72.13.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA494610F1;
 Tue, 20 Apr 2021 02:56:38 +0000 (UTC)
Subject: Re: [PATCH V4 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 sgarzare@redhat.com
References: <20210419063326.3748-1-lingshan.zhu@intel.com>
 <20210419063326.3748-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <295dc8a9-3159-78bc-f90f-9c8abeedf1cb@redhat.com>
Date: Tue, 20 Apr 2021 10:56:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419063326.3748-2-lingshan.zhu@intel.com>
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

CtTaIDIwMjEvNC8xOSDPws7nMjozMywgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZGVkdWNlcyBWSVJUSU8gZGV2aWNlIElEIGFzIGRldmljZSB0eXBlIHdoZW4gcHJvYmUsCj4gdGhl
biBpZmN2Zl92ZHBhX2dldF9kZXZpY2VfaWQoKSBjYW4gc2ltcGx5IHJldHVybiB0aGUgSUQuCj4g
aWZjdmZfdmRwYV9nZXRfZmVhdHVyZXMoKSBhbmQgaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUo
KQo+IGNhbiB3b3JrIHByb3Blcmx5IGJhc2VkIG9uIHRoZSBkZXZpY2UgSUQuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+CgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAgMSArCj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
bWFpbi5jIHwgMjcgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZf
YmFzZS5oCj4gaW5kZXggYjJlZWIxNmI5YzJjLi4xYzA0Y2QyNTZmYTcgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtODQsNiArODQsNyBAQCBzdHJ1Y3QgaWZjdmZfaHcgewo+ICAg
CXUzMiBub3RpZnlfb2ZmX211bHRpcGxpZXI7Cj4gICAJdTY0IHJlcV9mZWF0dXJlczsKPiAgIAl1
NjQgaHdfZmVhdHVyZXM7Cj4gKwl1MzIgZGV2X3R5cGU7Cj4gICAJc3RydWN0IHZpcnRpb19wY2lf
Y29tbW9uX2NmZyBfX2lvbWVtICpjb21tb25fY2ZnOwo+ICAgCXZvaWQgX19pb21lbSAqbmV0X2Nm
ZzsKPiAgIAlzdHJ1Y3QgdnJpbmdfaW5mbyB2cmluZ1tJRkNWRl9NQVhfUVVFVUVfUEFJUlMgKiAy
XTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZl
cnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCA0NGQ3NTg2MDE5ZGEuLjY2OTI3ZWM4
MWZhNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gKysr
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC0zMjMsMTkgKzMyMyw5IEBA
IHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZ2VuZXJhdGlvbihzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGFfZGV2KQo+ICAgCj4gICBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X2RldmljZV9pZChz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICAgewo+IC0Jc3RydWN0IGlmY3ZmX2FkYXB0
ZXIgKmFkYXB0ZXIgPSB2ZHBhX3RvX2FkYXB0ZXIodmRwYV9kZXYpOwo+IC0Jc3RydWN0IHBjaV9k
ZXYgKnBkZXYgPSBhZGFwdGVyLT5wZGV2Owo+IC0JdTMyIHJldCA9IC1FTk9ERVY7Cj4gLQo+IC0J
aWYgKHBkZXYtPmRldmljZSA8IDB4MTAwMCB8fCBwZGV2LT5kZXZpY2UgPiAweDEwN2YpCj4gLQkJ
cmV0dXJuIHJldDsKPiAtCj4gLQlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+IC0JCXJldCA9
ICBwZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+IC0JZWxzZQo+IC0JCXJldCA9ICBwZGV2LT5kZXZp
Y2UgLSAweDEwNDA7Cj4gKwlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rl
dik7Cj4gICAKPiAtCXJldHVybiByZXQ7Cj4gKwlyZXR1cm4gdmYtPmRldl90eXBlOwo+ICAgfQo+
ICAgCj4gICBzdGF0aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZlbmRvcl9pZChzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkcGFfZGV2KQo+IEBAIC00NjYsNiArNDU2LDE5IEBAIHN0YXRpYyBpbnQgaWZjdmZf
cHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICpp
ZCkKPiAgIAlwY2lfc2V0X2RydmRhdGEocGRldiwgYWRhcHRlcik7Cj4gICAKPiAgIAl2ZiA9ICZh
ZGFwdGVyLT52ZjsKPiArCj4gKwkvKiBUaGlzIGRyaXJ2ZXIgZHJpdmVzIGJvdGggbW9kZXJuIHZp
cnRpbyBkZXZpY2VzIGFuZCB0cmFuc2l0aW9uYWwKPiArCSAqIGRldmljZXMgaW4gbW9kZXJuIG1v
ZGUuCj4gKwkgKiB2RFBBIHJlcXVpcmVzIGZlYXR1cmUgYml0IFZJUlRJT19GX0FDQ0VTU19QTEFU
Rk9STSwKPiArCSAqIHNvIGxlZ2FjeSBkZXZpY2VzIGFuZCB0cmFuc2l0aW9uYWwgZGV2aWNlcyBp
biBsZWdhY3kKPiArCSAqIG1vZGUgd2lsbCBub3Qgd29yayBmb3IgdkRQQSwgdGhpcyBkcml2ZXIg
d2lsbCBub3QKPiArCSAqIGRyaXZlIGRldmljZXMgd2l0aCBsZWdhY3kgaW50ZXJmYWNlLgo+ICsJ
ICovCj4gKwlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDQwKQo+ICsJCXZmLT5kZXZfdHlwZSA9ICBw
ZGV2LT5zdWJzeXN0ZW1fZGV2aWNlOwo+ICsJZWxzZQo+ICsJCXZmLT5kZXZfdHlwZSA9ICBwZGV2
LT5kZXZpY2UgLSAweDEwNDA7Cj4gKwo+ICAgCXZmLT5iYXNlID0gcGNpbV9pb21hcF90YWJsZShw
ZGV2KTsKPiAgIAo+ICAgCWFkYXB0ZXItPnBkZXYgPSBwZGV2OwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

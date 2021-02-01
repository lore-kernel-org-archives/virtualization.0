Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30984C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:04:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8659C64E15
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 06:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659C64E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 378FB86F67;
	Mon,  1 Feb 2021 06:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zoa0fkyiLxL6; Mon,  1 Feb 2021 06:03:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C50686F93;
	Mon,  1 Feb 2021 06:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 337EAC0FA7;
	Mon,  1 Feb 2021 06:03:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4891C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B241486F93
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y0E7uSXzYEir
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:03:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 132BA86F67
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 06:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612159434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d640g0AhW4H0p1MPXlNtTw79RpilHCze4Mi87EihdeA=;
 b=JQ30XCia6RQN8/WsIBXUO/KhL39MLQQ+fWEwQZwFM2EUrivKnHS+Z9FY1cqN+yhc6hiljk
 4JgI6RqVF+Io6TiLuXSve8XtBQgPWkzunihs8grI4RQFgRmDKi7ncrDr+C4PByjnL4t5M8
 KqsGwhwCBL+2iRNw67bZZm9Tl90GIO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ic3WixtZMn-kEXpG8WCikA-1; Mon, 01 Feb 2021 01:03:52 -0500
X-MC-Unique: ic3WixtZMn-kEXpG8WCikA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5C8801817;
 Mon,  1 Feb 2021 06:03:50 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1C775D9DC;
 Mon,  1 Feb 2021 06:03:40 +0000 (UTC)
Subject: Re: [PATCH RFC v2 09/10] vdpa_sim_blk: implement ramdisk behaviour
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-10-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7084ff0d-6dd3-66bc-1c34-4f9f99970d97@redhat.com>
Date: Mon, 1 Feb 2021 14:03:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-10-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMS8yOCDkuIvljYgxMDo0MSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IFRo
ZSBwcmV2aW91cyBpbXBsZW1lbnRhdGlvbiB3cm90ZSBvbmx5IHRoZSBzdGF0dXMgb2YgZWFjaCBy
ZXF1ZXN0Lgo+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyBhIG1vcmUgYWNjdXJhdGUgYmxvY2sgZGV2
aWNlIHNpbXVsYXRvciwKPiBwcm92aWRpbmcgYSByYW1kaXNrLWxpa2UgYmVoYXZpb3IuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4g
LS0tCj4gdjI6Cj4gLSB1c2VkICV6ZCAlenggdG8gcHJpbnQgc2l6ZV90IGFuZCBzc2l6ZV90IHZh
cmlhYmxlcyBpbiBkZXZfZXJyKCkKPiAtIHJlbW92ZWQgdW5uZWNlc3NhcnkgbmV3IGxpbmUgW0ph
c29uXQo+IC0gbW92ZWQgVklSVElPX0JMS19UX0dFVF9JRCBpbiBhbm90aGVyIHBhdGNoIFtKYXNv
bl0KPiAtIHVzZWQgcHVzaC9wdWxsIGluc3RlYWQgb2Ygd3JpdGUvcmVhZCB0ZXJtaW5vbG9neQo+
IC0gYWRkZWQgdmRwYXNpbV9ibGtfY2hlY2tfcmFuZ2UoKSB0byBhdm9pZCBvdmVyZmxvd3MgW1N0
ZWZhbl0KPiAtIHVzZSB2ZHBhc2ltKl90b19jcHUgaW5zdGVhZCBvZiBsZSpfdG9fY3B1Cj4gLSB1
c2VkIHZyaW5naF9raW92X2xlbmd0aCgpIGhlbHBlciBbSmFzb25dCgoKQWNrZWQtYnk6IEphc29u
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBh
X3NpbS92ZHBhX3NpbV9ibGsuYyB8IDE2NCArKysrKysrKysrKysrKysrKysrKysrKystLS0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIGIvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gaW5kZXggOTk5ZjljYTBiNjI4Li5mYzQ3
ZTgzMjAzNTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Js
ay5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gQEAgLTMs
NiArMyw3IEBACj4gICAgKiBWRFBBIHNpbXVsYXRvciBmb3IgYmxvY2sgZGV2aWNlLgo+ICAgICoK
PiAgICAqIENvcHlyaWdodCAoYykgMjAyMCwgTWVsbGFub3ggVGVjaG5vbG9naWVzLiBBbGwgcmln
aHRzIHJlc2VydmVkLgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjEsIFJlZCBIYXQgSW5jLiBBbGwg
cmlnaHRzIHJlc2VydmVkLgo+ICAgICoKPiAgICAqLwo+ICAgCj4gQEAgLTEzLDYgKzE0LDcgQEAK
PiAgICNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L3ZyaW5naC5o
Pgo+ICAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2Jsa2Rldi5o
Pgo+ICAgI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Jsay5oPgo+ICAgCj4gICAjaW5jbHVk
ZSAidmRwYV9zaW0uaCIKPiBAQCAtMzYsMTAgKzM4LDE1MSBAQAo+ICAgCj4gICBzdGF0aWMgc3Ry
dWN0IHZkcGFzaW0gKnZkcGFzaW1fYmxrX2RldjsKPiAgIAo+ICtzdGF0aWMgYm9vbCB2ZHBhc2lt
X2Jsa19jaGVja19yYW5nZSh1NjQgc3RhcnRfc2VjdG9yLCBzaXplX3QgcmFuZ2Vfc2l6ZSkKPiAr
ewo+ICsJdTY0IHJhbmdlX3NlY3RvcnMgPSByYW5nZV9zaXplID4+IFNFQ1RPUl9TSElGVDsKPiAr
Cj4gKwlpZiAocmFuZ2Vfc2l6ZSA+IFZEUEFTSU1fQkxLX1NJWkVfTUFYICogVkRQQVNJTV9CTEtf
U0VHX01BWCkKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICsJaWYgKHN0YXJ0X3NlY3RvciA+IFZE
UEFTSU1fQkxLX0NBUEFDSVRZKQo+ICsJCXJldHVybiBmYWxzZTsKPiArCj4gKwlpZiAocmFuZ2Vf
c2VjdG9ycyA+IFZEUEFTSU1fQkxLX0NBUEFDSVRZIC0gc3RhcnRfc2VjdG9yKQo+ICsJCXJldHVy
biBmYWxzZTsKPiArCj4gKwlyZXR1cm4gdHJ1ZTsKPiArfQo+ICsKPiArLyogUmV0dXJucyAndHJ1
ZScgaWYgdGhlIHJlcXVlc3QgaXMgaGFuZGxlZCAod2l0aCBvciB3aXRob3V0IGFuIEkvTyBlcnJv
cikKPiArICogYW5kIHRoZSBzdGF0dXMgaXMgY29ycmVjdGx5IHdyaXR0ZW4gaW4gdGhlIGxhc3Qg
Ynl0ZSBvZiB0aGUgJ2luIGlvdicsCj4gKyAqICdmYWxzZScgb3RoZXJ3aXNlLgo+ICsgKi8KPiAr
c3RhdGljIGJvb2wgdmRwYXNpbV9ibGtfaGFuZGxlX3JlcShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bSwKPiArCQkJCSAgIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEpCj4gK3sKPiArCXNpemVf
dCBwdXNoZWQgPSAwLCB0b19wdWxsLCB0b19wdXNoOwo+ICsJc3RydWN0IHZpcnRpb19ibGtfb3V0
aGRyIGhkcjsKPiArCXNzaXplX3QgYnl0ZXM7Cj4gKwlsb2ZmX3Qgb2Zmc2V0Owo+ICsJdTY0IHNl
Y3RvcjsKPiArCXU4IHN0YXR1czsKPiArCXUzMiB0eXBlOwo+ICsJaW50IHJldDsKPiArCj4gKwly
ZXQgPSB2cmluZ2hfZ2V0ZGVzY19pb3RsYigmdnEtPnZyaW5nLCAmdnEtPm91dF9pb3YsICZ2cS0+
aW5faW92LAo+ICsJCQkJICAgJnZxLT5oZWFkLCBHRlBfQVRPTUlDKTsKPiArCWlmIChyZXQgIT0g
MSkKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwo+ICsJaWYgKHZxLT5vdXRfaW92LnVzZWQgPCAxIHx8
IHZxLT5pbl9pb3YudXNlZCA8IDEpIHsKPiArCQlkZXZfZXJyKCZ2ZHBhc2ltLT52ZHBhLmRldiwg
Im1pc3NpbmcgaGVhZGVycyAtIG91dF9pb3Y6ICV1IGluX2lvdiAldVxuIiwKPiArCQkJdnEtPm91
dF9pb3YudXNlZCwgdnEtPmluX2lvdi51c2VkKTsKPiArCQlyZXR1cm4gZmFsc2U7Cj4gKwl9Cj4g
Kwo+ICsJaWYgKHZxLT5pbl9pb3YuaW92W3ZxLT5pbl9pb3YudXNlZCAtIDFdLmlvdl9sZW4gPCAx
KSB7Cj4gKwkJZGV2X2VycigmdmRwYXNpbS0+dmRwYS5kZXYsICJyZXF1ZXN0IGluIGhlYWRlciB0
b28gc2hvcnRcbiIpOwo+ICsJCXJldHVybiBmYWxzZTsKPiArCX0KPiArCj4gKwkvKiBUaGUgbGFz
dCBieXRlIGlzIHRoZSBzdGF0dXMgYW5kIHdlIGNoZWNrZWQgaWYgdGhlIGxhc3QgaW92IGhhcwo+
ICsJICogZW5vdWdoIHJvb20gZm9yIGl0Lgo+ICsJICovCj4gKwl0b19wdXNoID0gdnJpbmdoX2tp
b3ZfbGVuZ3RoKCZ2cS0+aW5faW92KSAtIDE7Cj4gKwo+ICsJdG9fcHVsbCA9IHZyaW5naF9raW92
X2xlbmd0aCgmdnEtPm91dF9pb3YpOwo+ICsKPiArCWJ5dGVzID0gdnJpbmdoX2lvdl9wdWxsX2lv
dGxiKCZ2cS0+dnJpbmcsICZ2cS0+b3V0X2lvdiwgJmhkciwKPiArCQkJCSAgICAgIHNpemVvZiho
ZHIpKTsKPiArCWlmIChieXRlcyAhPSBzaXplb2YoaGRyKSkgewo+ICsJCWRldl9lcnIoJnZkcGFz
aW0tPnZkcGEuZGV2LCAicmVxdWVzdCBvdXQgaGVhZGVyIHRvbyBzaG9ydFxuIik7Cj4gKwkJcmV0
dXJuIGZhbHNlOwo+ICsJfQo+ICsKPiArCXRvX3B1bGwgLT0gYnl0ZXM7Cj4gKwo+ICsJdHlwZSA9
IHZkcGFzaW0zMl90b19jcHUodmRwYXNpbSwgaGRyLnR5cGUpOwo+ICsJc2VjdG9yID0gdmRwYXNp
bTY0X3RvX2NwdSh2ZHBhc2ltLCBoZHIuc2VjdG9yKTsKPiArCW9mZnNldCA9IHNlY3RvciA8PCBT
RUNUT1JfU0hJRlQ7Cj4gKwlzdGF0dXMgPSBWSVJUSU9fQkxLX1NfT0s7Cj4gKwo+ICsJc3dpdGNo
ICh0eXBlKSB7Cj4gKwljYXNlIFZJUlRJT19CTEtfVF9JTjoKPiArCQlpZiAoIXZkcGFzaW1fYmxr
X2NoZWNrX3JhbmdlKHNlY3RvciwgdG9fcHVzaCkpIHsKPiArCQkJZGV2X2VycigmdmRwYXNpbS0+
dmRwYS5kZXYsCj4gKwkJCQkicmVhZGluZyBvdmVyIHRoZSBjYXBhY2l0eSAtIG9mZnNldDogMHgl
bGx4IGxlbjogMHglenhcbiIsCj4gKwkJCQlvZmZzZXQsIHRvX3B1c2gpOwo+ICsJCQlzdGF0dXMg
PSBWSVJUSU9fQkxLX1NfSU9FUlI7Cj4gKwkJCWJyZWFrOwo+ICsJCX0KPiArCj4gKwkJYnl0ZXMg
PSB2cmluZ2hfaW92X3B1c2hfaW90bGIoJnZxLT52cmluZywgJnZxLT5pbl9pb3YsCj4gKwkJCQkJ
ICAgICAgdmRwYXNpbS0+YnVmZmVyICsgb2Zmc2V0LAo+ICsJCQkJCSAgICAgIHRvX3B1c2gpOwo+
ICsJCWlmIChieXRlcyA8IDApIHsKPiArCQkJZGV2X2VycigmdmRwYXNpbS0+dmRwYS5kZXYsCj4g
KwkJCQkidnJpbmdoX2lvdl9wdXNoX2lvdGxiKCkgZXJyb3I6ICV6ZCBvZmZzZXQ6IDB4JWxseCBs
ZW46IDB4JXp4XG4iLAo+ICsJCQkJYnl0ZXMsIG9mZnNldCwgdG9fcHVzaCk7Cj4gKwkJCXN0YXR1
cyA9IFZJUlRJT19CTEtfU19JT0VSUjsKPiArCQkJYnJlYWs7Cj4gKwkJfQo+ICsKPiArCQlwdXNo
ZWQgKz0gYnl0ZXM7Cj4gKwkJYnJlYWs7Cj4gKwo+ICsJY2FzZSBWSVJUSU9fQkxLX1RfT1VUOgo+
ICsJCWlmICghdmRwYXNpbV9ibGtfY2hlY2tfcmFuZ2Uoc2VjdG9yLCB0b19wdWxsKSkgewo+ICsJ
CQlkZXZfZXJyKCZ2ZHBhc2ltLT52ZHBhLmRldiwKPiArCQkJCSJ3cml0aW5nIG92ZXIgdGhlIGNh
cGFjaXR5IC0gb2Zmc2V0OiAweCVsbHggbGVuOiAweCV6eFxuIiwKPiArCQkJCW9mZnNldCwgdG9f
cHVsbCk7Cj4gKwkJCXN0YXR1cyA9IFZJUlRJT19CTEtfU19JT0VSUjsKPiArCQkJYnJlYWs7Cj4g
KwkJfQo+ICsKPiArCQlieXRlcyA9IHZyaW5naF9pb3ZfcHVsbF9pb3RsYigmdnEtPnZyaW5nLCAm
dnEtPm91dF9pb3YsCj4gKwkJCQkJICAgICAgdmRwYXNpbS0+YnVmZmVyICsgb2Zmc2V0LAo+ICsJ
CQkJCSAgICAgIHRvX3B1bGwpOwo+ICsJCWlmIChieXRlcyA8IDApIHsKPiArCQkJZGV2X2Vycigm
dmRwYXNpbS0+dmRwYS5kZXYsCj4gKwkJCQkidnJpbmdoX2lvdl9wdWxsX2lvdGxiKCkgZXJyb3I6
ICV6ZCBvZmZzZXQ6IDB4JWxseCBsZW46IDB4JXp4XG4iLAo+ICsJCQkJYnl0ZXMsIG9mZnNldCwg
dG9fcHVsbCk7Cj4gKwkJCXN0YXR1cyA9IFZJUlRJT19CTEtfU19JT0VSUjsKPiArCQkJYnJlYWs7
Cj4gKwkJfQo+ICsJCWJyZWFrOwo+ICsKPiArCWRlZmF1bHQ6Cj4gKwkJZGV2X3dhcm4oJnZkcGFz
aW0tPnZkcGEuZGV2LAo+ICsJCQkgIlVuc3VwcG9ydGVkIHJlcXVlc3QgdHlwZSAlZFxuIiwgdHlw
ZSk7Cj4gKwkJc3RhdHVzID0gVklSVElPX0JMS19TX0lPRVJSOwo+ICsJCWJyZWFrOwo+ICsJfQo+
ICsKPiArCS8qIElmIHNvbWUgb3BlcmF0aW9ucyBmYWlsLCB3ZSBuZWVkIHRvIHNraXAgdGhlIHJl
bWFpbmluZyBieXRlcwo+ICsJICogdG8gcHV0IHRoZSBzdGF0dXMgaW4gdGhlIGxhc3QgYnl0ZQo+
ICsJICovCj4gKwlpZiAodG9fcHVzaCAtIHB1c2hlZCA+IDApCj4gKwkJdnJpbmdoX2tpb3ZfYWR2
YW5jZSgmdnEtPmluX2lvdiwgdG9fcHVzaCAtIHB1c2hlZCk7Cj4gKwo+ICsJLyogTGFzdCBieXRl
IGlzIHRoZSBzdGF0dXMgKi8KPiArCWJ5dGVzID0gdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCZ2cS0+
dnJpbmcsICZ2cS0+aW5faW92LCAmc3RhdHVzLCAxKTsKPiArCWlmIChieXRlcyAhPSAxKQo+ICsJ
CXJldHVybiBmYWxzZTsKPiArCj4gKwlwdXNoZWQgKz0gYnl0ZXM7Cj4gKwo+ICsJLyogTWFrZSBz
dXJlIGRhdGEgaXMgd3JvdGUgYmVmb3JlIGFkdmFuY2luZyBpbmRleCAqLwo+ICsJc21wX3dtYigp
Owo+ICsKPiArCXZyaW5naF9jb21wbGV0ZV9pb3RsYigmdnEtPnZyaW5nLCB2cS0+aGVhZCwgcHVz
aGVkKTsKPiArCj4gKwlyZXR1cm4gdHJ1ZTsKPiArfQo+ICsKPiAgIHN0YXRpYyB2b2lkIHZkcGFz
aW1fYmxrX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgewo+ICAgCXN0cnVjdCB2
ZHBhc2ltICp2ZHBhc2ltID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCB2ZHBhc2ltLCB3b3Jr
KTsKPiAtCXU4IHN0YXR1cyA9IFZJUlRJT19CTEtfU19PSzsKPiAgIAlpbnQgaTsKPiAgIAo+ICAg
CXNwaW5fbG9jaygmdmRwYXNpbS0+bG9jayk7Cj4gQEAgLTUzLDIyICsxOTYsNyBAQCBzdGF0aWMg
dm9pZCB2ZHBhc2ltX2Jsa193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiAgIAkJaWYg
KCF2cS0+cmVhZHkpCj4gICAJCQljb250aW51ZTsKPiAgIAo+IC0JCXdoaWxlICh2cmluZ2hfZ2V0
ZGVzY19pb3RsYigmdnEtPnZyaW5nLCAmdnEtPm91dF9pb3YsCj4gLQkJCQkJICAgICZ2cS0+aW5f
aW92LCAmdnEtPmhlYWQsCj4gLQkJCQkJICAgIEdGUF9BVE9NSUMpID4gMCkgewo+IC0JCQlpbnQg
d3JpdGU7Cj4gLQo+IC0JCQl2cS0+aW5faW92LmkgPSB2cS0+aW5faW92LnVzZWQgLSAxOwo+IC0J
CQl3cml0ZSA9IHZyaW5naF9pb3ZfcHVzaF9pb3RsYigmdnEtPnZyaW5nLCAmdnEtPmluX2lvdiwK
PiAtCQkJCQkJICAgICAgJnN0YXR1cywgMSk7Cj4gLQkJCWlmICh3cml0ZSA8PSAwKQo+IC0JCQkJ
YnJlYWs7Cj4gLQo+IC0JCQkvKiBNYWtlIHN1cmUgZGF0YSBpcyB3cm90ZSBiZWZvcmUgYWR2YW5j
aW5nIGluZGV4ICovCj4gLQkJCXNtcF93bWIoKTsKPiAtCj4gLQkJCXZyaW5naF9jb21wbGV0ZV9p
b3RsYigmdnEtPnZyaW5nLCB2cS0+aGVhZCwgd3JpdGUpOwo+IC0KPiArCQl3aGlsZSAodmRwYXNp
bV9ibGtfaGFuZGxlX3JlcSh2ZHBhc2ltLCB2cSkpIHsKPiAgIAkJCS8qIE1ha2Ugc3VyZSB1c2Vk
IGlzIHZpc2libGUgYmVmb3JlIHJhc2luZyB0aGUgaW50ZXJydXB0LiAqLwo+ICAgCQkJc21wX3dt
YigpOwo+ICAgCj4gQEAgLTEwOSw3ICsyMzcsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB2ZHBhc2lt
X2Jsa19pbml0KHZvaWQpCj4gICAJZGV2X2F0dHIuY29uZmlnX3NpemUgPSBzaXplb2Yoc3RydWN0
IHZpcnRpb19ibGtfY29uZmlnKTsKPiAgIAlkZXZfYXR0ci5nZXRfY29uZmlnID0gdmRwYXNpbV9i
bGtfZ2V0X2NvbmZpZzsKPiAgIAlkZXZfYXR0ci53b3JrX2ZuID0gdmRwYXNpbV9ibGtfd29yazsK
PiAtCWRldl9hdHRyLmJ1ZmZlcl9zaXplID0gUEFHRV9TSVpFOwo+ICsJZGV2X2F0dHIuYnVmZmVy
X3NpemUgPSBWRFBBU0lNX0JMS19DQVBBQ0lUWSA8PCBTRUNUT1JfU0hJRlQ7Cj4gICAKPiAgIAl2
ZHBhc2ltX2Jsa19kZXYgPSB2ZHBhc2ltX2NyZWF0ZSgmZGV2X2F0dHIpOwo+ICAgCWlmIChJU19F
UlIodmRwYXNpbV9ibGtfZGV2KSkgewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

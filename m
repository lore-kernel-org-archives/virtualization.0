Return-Path: <SRS0=2ixu=F5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE3EC433E0
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:40:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E5B22AAA
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E5B22AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E58620410;
	Fri, 25 Dec 2020 06:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SIKX3wY5QCG7; Fri, 25 Dec 2020 06:40:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 43186203AE;
	Fri, 25 Dec 2020 06:40:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 122DEC1825;
	Fri, 25 Dec 2020 06:40:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06EB9C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E9084863A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:40:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XoClLFiwYbbz
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:40:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D9C3586374
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608878400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xM6ipW2bJRZDLWmIx8iPsoeWBN30KOgJ6lEUY6brlAg=;
 b=AsG+u8qfAeVpkGZIGHSMhQxIgxAOjHsmb+Sty5PWRI2J9PEikcIMq/BrwKKPqmHMDBials
 MWi+u4RHs9oIsUvp2i49vlMwloj7xUhmP9BMgsxClM0OIjcPovb+7401ik5M/4vgJsJTk2
 K+gDuq24iEGX86Oy+DS57J/X4DmA58M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-yWBZZCZlPKKvzQZvE8evBQ-1; Fri, 25 Dec 2020 01:38:33 -0500
X-MC-Unique: yWBZZCZlPKKvzQZvE8evBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BBDB15720;
 Fri, 25 Dec 2020 06:38:32 +0000 (UTC)
Received: from [10.72.12.97] (ovpn-12-97.pek2.redhat.com [10.72.12.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ABB26F816;
 Fri, 25 Dec 2020 06:38:25 +0000 (UTC)
Subject: Re: [PATCH net v4 1/2] vhost_net: fix ubuf refcount incorrectly when
 sendmsg fails
To: wangyunjian <wangyunjian@huawei.com>, netdev@vger.kernel.org,
 mst@redhat.com, willemdebruijn.kernel@gmail.com
References: <1608776738-21868-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ab017214-9090-bff0-93db-a00f022c07e9@redhat.com>
Date: Fri, 25 Dec 2020 14:38:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1608776738-21868-1-git-send-email-wangyunjian@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: xudingke@huawei.com, brian.huangbin@huawei.com, jerry.lilijun@huawei.com,
 chenchanghu@huawei.com, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMjQg5LiK5Y2IMTA6MjUsIHdhbmd5dW5qaWFuIHdyb3RlOgo+IEZyb206IFl1
bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPgo+IEN1cnJlbnRseSB0aGUgdmhv
c3RfemVyb2NvcHlfY2FsbGJhY2soKSBtYXliZSBiZSBjYWxsZWQgdG8gZGVjcmVhc2UKPiB0aGUg
cmVmY291bnQgd2hlbiBzZW5kbXNnIGZhaWxzIGluIHR1bi4gVGhlIGVycm9yIGhhbmRsaW5nIGlu
IHZob3N0Cj4gaGFuZGxlX3R4X3plcm9jb3B5KCkgd2lsbCB0cnkgdG8gZGVjcmVhc2UgdGhlIHNh
bWUgcmVmY291bnQgYWdhaW4uCj4gVGhpcyBpcyB3cm9uZy4gVG8gZml4IHRoaXMgaXNzdWUsIHdl
IG9ubHkgY2FsbCB2aG9zdF9uZXRfdWJ1Zl9wdXQoKQo+IHdoZW4gdnEtPmhlYWRzW252cS0+ZGVz
Y10ubGVuID09IFZIT1NUX0RNQV9JTl9QUk9HUkVTUy4KPgo+IEZpeGVzOiAwNjkwODk5YjRkNDUg
KCJ0dW46IGV4cGVyaW1lbnRhbCB6ZXJvIGNvcHkgdHggc3VwcG9ydCIpCj4gU2lnbmVkLW9mZi1i
eTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPgo+IEFja2VkLWJ5OiBXaWxs
ZW0gZGUgQnJ1aWpuIDx3aWxsZW1iQGdvb2dsZS5jb20+Cj4gQWNrZWQtYnk6IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvbmV0LmMgfCA2ICsrKy0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L25ldC5jIGIvZHJpdmVycy92aG9zdC9uZXQuYwo+IGlu
ZGV4IDUzMWEwMGQ3MDNjZC4uYzg3ODRkZmFmZGQ3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvbmV0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gQEAgLTg2Myw2ICs4NjMsNyBA
QCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfemVyb2NvcHkoc3RydWN0IHZob3N0X25ldCAqbmV0LCBz
dHJ1Y3Qgc29ja2V0ICpzb2NrKQo+ICAgCXNpemVfdCBsZW4sIHRvdGFsX2xlbiA9IDA7Cj4gICAJ
aW50IGVycjsKPiAgIAlzdHJ1Y3Qgdmhvc3RfbmV0X3VidWZfcmVmICp1YnVmczsKPiArCXN0cnVj
dCB1YnVmX2luZm8gKnVidWY7Cj4gICAJYm9vbCB6Y29weV91c2VkOwo+ICAgCWludCBzZW50X3Br
dHMgPSAwOwo+ICAgCj4gQEAgLTg5NSw5ICs4OTYsNyBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhf
emVyb2NvcHkoc3RydWN0IHZob3N0X25ldCAqbmV0LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+ICAg
Cj4gICAJCS8qIHVzZSBtc2dfY29udHJvbCB0byBwYXNzIHZob3N0IHplcm9jb3B5IHVidWYgaW5m
byB0byBza2IgKi8KPiAgIAkJaWYgKHpjb3B5X3VzZWQpIHsKPiAtCQkJc3RydWN0IHVidWZfaW5m
byAqdWJ1ZjsKPiAgIAkJCXVidWYgPSBudnEtPnVidWZfaW5mbyArIG52cS0+dXBlbmRfaWR4Owo+
IC0KPiAgIAkJCXZxLT5oZWFkc1tudnEtPnVwZW5kX2lkeF0uaWQgPSBjcHVfdG9fdmhvc3QzMih2
cSwgaGVhZCk7Cj4gICAJCQl2cS0+aGVhZHNbbnZxLT51cGVuZF9pZHhdLmxlbiA9IFZIT1NUX0RN
QV9JTl9QUk9HUkVTUzsKPiAgIAkJCXVidWYtPmNhbGxiYWNrID0gdmhvc3RfemVyb2NvcHlfY2Fs
bGJhY2s7Cj4gQEAgLTkyNyw3ICs5MjYsOCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdHhfemVyb2Nv
cHkoc3RydWN0IHZob3N0X25ldCAqbmV0LCBzdHJ1Y3Qgc29ja2V0ICpzb2NrKQo+ICAgCQllcnIg
PSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywgJm1zZywgbGVuKTsKPiAgIAkJaWYgKHVubGlrZWx5
KGVyciA8IDApKSB7Cj4gICAJCQlpZiAoemNvcHlfdXNlZCkgewo+IC0JCQkJdmhvc3RfbmV0X3Vi
dWZfcHV0KHVidWZzKTsKPiArCQkJCWlmICh2cS0+aGVhZHNbdWJ1Zi0+ZGVzY10ubGVuID09IFZI
T1NUX0RNQV9JTl9QUk9HUkVTUykKPiArCQkJCQl2aG9zdF9uZXRfdWJ1Zl9wdXQodWJ1ZnMpOwo+
ICAgCQkJCW52cS0+dXBlbmRfaWR4ID0gKCh1bnNpZ25lZCludnEtPnVwZW5kX2lkeCAtIDEpCj4g
ICAJCQkJCSUgVUlPX01BWElPVjsKPiAgIAkJCX0KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

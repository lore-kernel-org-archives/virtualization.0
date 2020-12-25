Return-Path: <SRS0=2ixu=F5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B376DC433DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:18:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D1F23129
	for <virtualization@archiver.kernel.org>; Fri, 25 Dec 2020 06:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D1F23129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 44C762047E;
	Fri, 25 Dec 2020 06:18:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JT8D+froIF35; Fri, 25 Dec 2020 06:18:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 78E0C20410;
	Fri, 25 Dec 2020 06:18:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6559FC1825;
	Fri, 25 Dec 2020 06:18:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCAF6C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C844A873E8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N99w6IGQGwLI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:18:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id AF09A873E3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Dec 2020 06:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608877095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpqVkUDXq+c4toXVZRgWMvwCiy7iTphoDiBdMjsrs6k=;
 b=BRhGUuqP7W/a4iQHGFCW5HRuCIcmv98OEW8Aj9Eqh1BnE0vbuDl+I72imQqixLOJ1v1PuG
 qlV+BmM9k21w77lPhNQe+sl2YfsOPeJ0QvsQTOl+/+1hcnskgz8VHp5j2FHkH+2VBSnEDV
 wVnW4Aals4Dk2TFgB7DhN1olkBbLoMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-xPtuXUzFMiK4Elmmw801lQ-1; Fri, 25 Dec 2020 01:18:13 -0500
X-MC-Unique: xPtuXUzFMiK4Elmmw801lQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B22B107ACF5;
 Fri, 25 Dec 2020 06:18:11 +0000 (UTC)
Received: from [10.72.12.166] (ovpn-12-166.pek2.redhat.com [10.72.12.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B987B10023B9;
 Fri, 25 Dec 2020 06:18:04 +0000 (UTC)
Subject: Re: [PATCH net v2] tun: fix return value when the number of iovs
 exceeds MAX_SKB_FRAGS
To: wangyunjian <wangyunjian@huawei.com>, netdev@vger.kernel.org,
 mst@redhat.com, willemdebruijn.kernel@gmail.com
References: <1608864736-24332-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b9de1be1-159f-455d-445a-c37edae32574@redhat.com>
Date: Fri, 25 Dec 2020 14:18:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1608864736-24332-1-git-send-email-wangyunjian@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjAvMTIvMjUg5LiK5Y2IMTA6NTIsIHdhbmd5dW5qaWFuIHdyb3RlOgo+IEZyb206IFl1
bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNvbT4KPgo+IEN1cnJlbnRseSB0aGUgdHVu
X25hcGlfYWxsb2NfZnJhZ3MoKSBmdW5jdGlvbiByZXR1cm5zIC1FTk9NRU0gd2hlbiB0aGUKPiBu
dW1iZXIgb2YgaW92cyBleGNlZWRzIE1BWF9TS0JfRlJBR1MgKyAxLiBIb3dldmVyIHRoaXMgaXMg
aW5hcHByb3ByaWF0ZSwKPiB3ZSBzaG91bGQgdXNlIC1FTVNHU0laRSBpbnN0ZWFkIG9mIC1FTk9N
RU0uCj4KPiBUaGUgZm9sbG93aW5nIGRpc3RpbmN0aW9ucyBhcmUgbWF0dGVyczoKPiAxLiB0aGUg
Y2FsbGVyIG5lZWQgdG8gZHJvcCB0aGUgYmFkIHBhY2tldCB3aGVuIC1FTVNHU0laRSBpcyByZXR1
cm5lZCwKPiAgICAgd2hpY2ggbWVhbnMgbWVldGluZyBhIHBlcnNpc3RlbnQgZmFpbHVyZS4KPiAy
LiB0aGUgY2FsbGVyIGNhbiB0cnkgYWdhaW4gd2hlbiAtRU5PTUVNIGlzIHJldHVybmVkLCB3aGlj
aCBtZWFucwo+ICAgICBtZWV0aW5nIGEgdHJhbnNpZW50IGZhaWx1cmUuCj4KPiBGaXhlczogOTBl
MzNkNDU5NDA3ICgidHVuOiBlbmFibGUgbmFwaV9ncm9fZnJhZ3MoKSBmb3IgVFVOL1RBUCBkcml2
ZXIiKQo+IFNpZ25lZC1vZmYtYnk6IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5AaHVhd2VpLmNv
bT4KPiBBY2tlZC1ieTogV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtYkBnb29nbGUuY29tPgo+IC0t
LQo+IHYyOgo+ICAgICogdXBkYXRlIGNvbW1pdCBsb2cgc3VnZ2VzdGVkIGJ5IFdpbGxlbSBkZSBC
cnVpam4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3R1bi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdHVuLmMgYi9kcml2ZXJzL25ldC90dW4uYwo+IGluZGV4IDJkYzE5ODhhODk3My4uMTVj
NmRkN2ZiMDRjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3R1bi5jCj4gKysrIGIvZHJpdmVy
cy9uZXQvdHVuLmMKPiBAQCAtMTM2NSw3ICsxMzY1LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZm
ICp0dW5fbmFwaV9hbGxvY19mcmFncyhzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLAo+ICAgCWludCBp
Owo+ICAgCj4gICAJaWYgKGl0LT5ucl9zZWdzID4gTUFYX1NLQl9GUkFHUyArIDEpCj4gLQkJcmV0
dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVNU0dTSVpFKTsKPiAg
IAo+ICAgCWxvY2FsX2JoX2Rpc2FibGUoKTsKPiAgIAlza2IgPSBuYXBpX2dldF9mcmFncygmdGZp
bGUtPm5hcGkpOwoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

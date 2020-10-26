Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2652C55178
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 02:59:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF672222C
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 02:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDVUpmCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF672222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5CE5427A60;
	Mon, 26 Oct 2020 02:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10as6DQ79uPl; Mon, 26 Oct 2020 02:59:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 49ED1276D4;
	Mon, 26 Oct 2020 02:59:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C50AC0859;
	Mon, 26 Oct 2020 02:59:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C33ADC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AA43E85F51
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b7KMmT4NdFJT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7A49685C62
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603681190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wj4XKzYinjtinYOa4SEH9Db7ssmjPWw3m5dgQvIRbIo=;
 b=LDVUpmCh+/5reCFj0I5/MqfZMzO/hg2r/HnS8WHdR2LLdvJlUviLClk4SvlITHzVVst+4v
 Dr69WD5wv4KFaK8Pz1dQLFBTh/10PsEoJUlIUuHcFaiL3Ss8x02Ct0YOAHeBz3DjrT35Qs
 9I0BAQCMQNtotl6yPtkoINp2ZxqhqiM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-SsQjknsqOSaucbGw5t__FQ-1; Sun, 25 Oct 2020 22:59:45 -0400
X-MC-Unique: SsQjknsqOSaucbGw5t__FQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8121006C81;
 Mon, 26 Oct 2020 02:59:44 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F012E55769;
 Mon, 26 Oct 2020 02:59:38 +0000 (UTC)
Subject: Re: [PATCH net] vhost_vdpa: Return -EFUALT if copy_from_user() fails
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20201023120853.GI282278@mwanda>
 <20201023113326-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4485cc8d-ac69-c725-8493-eda120e29c41@redhat.com>
Date: Mon, 26 Oct 2020 10:59:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023113326-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-janitors@vger.kernel.org,
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

Ck9uIDIwMjAvMTAvMjMg5LiL5Y2IMTE6MzQsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBP
biBGcmksIE9jdCAyMywgMjAyMCBhdCAwMzowODo1M1BNICswMzAwLCBEYW4gQ2FycGVudGVyIHdy
b3RlOgo+PiBUaGUgY29weV90by9mcm9tX3VzZXIoKSBmdW5jdGlvbnMgcmV0dXJuIHRoZSBudW1i
ZXIgb2YgYnl0ZXMgd2hpY2ggd2UKPj4gd2VyZW4ndCBhYmxlIHRvIGNvcHkgYnV0IHRoZSBpb2N0
bCBzaG91bGQgcmV0dXJuIC1FRkFVTFQgaWYgdGhleSBmYWlsLgo+Pgo+PiBGaXhlczogYTEyN2M1
YmJiNmE4ICgidmhvc3QtdmRwYTogZml4IGJhY2tlbmQgZmVhdHVyZSBpb2N0bHMiKQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+Cj4gQWNr
ZWQtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gTmVlZGVkIGZvciBz
dGFibGUgSSBndWVzcy4KCgpBZ3JlZS4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKCj4+IC0tLQo+PiAgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMTAgKysrKyst
LS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+IGluZGV4IDYyYTliYjBlZmM1NS4uYzk0YTk3YjZiZDZkIDEwMDY0NAo+PiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiBA
QCAtNDI4LDEyICs0MjgsMTEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV91bmxvY2tlZF9pb2N0
bChzdHJ1Y3QgZmlsZSAqZmlsZXAsCj4+ICAgCXZvaWQgX191c2VyICphcmdwID0gKHZvaWQgX191
c2VyICopYXJnOwo+PiAgIAl1NjQgX191c2VyICpmZWF0dXJlcCA9IGFyZ3A7Cj4+ICAgCXU2NCBm
ZWF0dXJlczsKPj4gLQlsb25nIHI7Cj4+ICsJbG9uZyByID0gMDsKPj4gICAKPj4gICAJaWYgKGNt
ZCA9PSBWSE9TVF9TRVRfQkFDS0VORF9GRUFUVVJFUykgewo+PiAtCQlyID0gY29weV9mcm9tX3Vz
ZXIoJmZlYXR1cmVzLCBmZWF0dXJlcCwgc2l6ZW9mKGZlYXR1cmVzKSk7Cj4+IC0JCWlmIChyKQo+
PiAtCQkJcmV0dXJuIHI7Cj4+ICsJCWlmIChjb3B5X2Zyb21fdXNlcigmZmVhdHVyZXMsIGZlYXR1
cmVwLCBzaXplb2YoZmVhdHVyZXMpKSkKPj4gKwkJCXJldHVybiAtRUZBVUxUOwo+PiAgIAkJaWYg
KGZlYXR1cmVzICYgflZIT1NUX1ZEUEFfQkFDS0VORF9GRUFUVVJFUykKPj4gICAJCQlyZXR1cm4g
LUVPUE5PVFNVUFA7Cj4+ICAgCQl2aG9zdF9zZXRfYmFja2VuZF9mZWF0dXJlcygmdi0+dmRldiwg
ZmVhdHVyZXMpOwo+PiBAQCAtNDc2LDcgKzQ3NSw4IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
dW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVwLAo+PiAgIAkJYnJlYWs7Cj4+ICAgCWNh
c2UgVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVM6Cj4+ICAgCQlmZWF0dXJlcyA9IFZIT1NUX1ZE
UEFfQkFDS0VORF9GRUFUVVJFUzsKPj4gLQkJciA9IGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZl
YXR1cmVzLCBzaXplb2YoZmVhdHVyZXMpKTsKPj4gKwkJaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJl
cCwgJmZlYXR1cmVzLCBzaXplb2YoZmVhdHVyZXMpKSkKPj4gKwkJCXIgPSAtRUZBVUxUOwo+PiAg
IAkJYnJlYWs7Cj4+ICAgCWRlZmF1bHQ6Cj4+ICAgCQlyID0gdmhvc3RfZGV2X2lvY3RsKCZ2LT52
ZGV2LCBjbWQsIGFyZ3ApOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A36EC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:38:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C436C64E68
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 06:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C436C64E68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D2F9845C5;
	Thu, 18 Feb 2021 06:38:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JavamOe4KfP6; Thu, 18 Feb 2021 06:38:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E64F4847DE;
	Thu, 18 Feb 2021 06:38:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE7A5C000F;
	Thu, 18 Feb 2021 06:38:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3567C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E137986749
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gKSBe7pVZf6z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:38:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF81E86738
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613630284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xSBP2JIYUC8xWmwZs/YoFdX+EUOlZ0kViYULbocJus=;
 b=YMFJor7y+M+0olOSuDWfAjgGw+Ak6xFQoGW4AU4hQ7bp24r8FT1DtS+66mtCkNucUfgg6Y
 LzPXiPyqd94KwVk0ASt0+S0xYsHTlcrkNX8hE5Aql/x/l39ZZ+FM87PGnGCRY2vvMDXEs9
 pAbaDIWV+0TBlqklf9pKFEYYOuvguyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-NL4_CLGsNk2Km3TLHXsk0Q-1; Thu, 18 Feb 2021 01:36:52 -0500
X-MC-Unique: NL4_CLGsNk2Km3TLHXsk0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCF14107ACE4;
 Thu, 18 Feb 2021 06:36:50 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 662645B6AB;
 Thu, 18 Feb 2021 06:36:45 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] vdpa/mlx5: fix feature negotiation across device
 reset
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, elic@nvidia.com
References: <1612993680-29454-1-git-send-email-si-wei.liu@oracle.com>
 <1612993680-29454-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <386fffb2-be75-9ce0-0a4d-1d47f91e7d16@redhat.com>
Date: Thu, 18 Feb 2021 14:36:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1612993680-29454-3-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi8xMSDkuIrljYg1OjQ3LCBTaS1XZWkgTGl1IHdyb3RlOgo+IFRoZSBtbHhfZmVh
dHVyZXMgZGVub3RlcyB0aGUgY2FwYWJpbGl0eSBmb3Igd2hpY2gKPiBzZXQgb2YgdmlydGlvIGZl
YXR1cmVzIGlzIHN1cHBvcnRlZCBieSBkZXZpY2UuIEluCj4gcHJpbmNpcGxlLCB0aGlzIGZpZWxk
IG5lZWRzIG5vdCBiZSBjbGVhcmVkIGR1cmluZwo+IHZpcnRpbyBkZXZpY2UgcmVzZXQsIGFzIHRo
aXMgY2FwYWJpbGl0eSBpcyBzdGF0aWMKPiBhbmQgZG9lcyBub3QgY2hhbmdlIGFjcm9zcyByZXNl
dC4KPgo+IEluIGZhY3QsIHRoZSBjdXJyZW50IGNvZGUgbWF5IGhhdmUgdGhlIGFzc3VtcHRpb24K
PiB0aGF0IG1seF9mZWF0dXJlcyBjYW4gYmUgcmVsb2FkZWQgZnJvbSBmaXJtd2FyZQo+IHZpYSB0
aGUgLmdldF9mZWF0dXJlcyBvcHMgYWZ0ZXIgZGV2aWNlIGlzIHJlc2V0Cj4gKHZpYSB0aGUgLnNl
dF9zdGF0dXMgb3BzKSwgd2hpY2ggaXMgdW5mb3J0dW5hdGVseQo+IG5vdCB0cnVlLiBUaGUgdXNl
cnNwYWNlIFZNTSBtaWdodCBzYXZlIGEgY29weQo+IG9mIGJhY2tlbmQgY2FwYWJsZSBmZWF0dXJl
cyBhbmQgd29uJ3QgY2FsbCBpbnRvCj4ga2VybmVsIGFnYWluIHRvIGdldCBpdCBvbiByZXNldC4g
VGhpcyBjYXVzZXMgYWxsCj4gdmlydGlvIGZlYXR1cmVzIGdldHRpbmcgZGlzYWJsZWQgb24gbmV3
bHkgY3JlYXRlZAo+IHZpcnRxcyBhZnRlciBkZXZpY2UgcmVzZXQsIHdoaWxlIGd1ZXN0IHdvdWxk
IGhvbGQKPiBtaXNtYXRjaGVkIHZpZXcgb2YgYXZhaWxhYmxlIGZlYXR1cmVzLiBGb3IgZS5nLiwK
PiB0aGUgZ3Vlc3QgbWF5IHN0aWxsIGFzc3VtZSB0eCBjaGVja3N1bSBvZmZsb2FkCj4gaXMgYXZh
aWxhYmxlIGFmdGVyIHJlc2V0IGFuZCBmZWF0dXJlIG5lZ290aWF0aW9uLAo+IGNhdXNpbmcgZnJh
bWVzIHdpdGggYm9ndXMgKGluY29tcGxldGUpIGNoZWNrc3VtCj4gdHJhbnNtaXR0ZWQgb24gdGhl
IHdpcmUuCj4KPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2
ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+IFNpZ25lZC1vZmYtYnk6IFNpLVdlaSBM
aXUgPHNpLXdlaS5saXVAb3JhY2xlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jIHwgMjUgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+IGluZGV4IGI4NDE2YzQuLjdjMWY3ODkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4gQEAgLTE0ODYsMTYgKzE0ODYsOCBAQCBzdGF0aWMgdTY0IG1seF90b192cml0aW9f
ZmVhdHVyZXModTE2IGRldl9mZWF0dXJlcykKPiAgIHN0YXRpYyB1NjQgbWx4NV92ZHBhX2dldF9m
ZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gICB7Cj4gICAJc3RydWN0IG1seDVf
dmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gLQlzdHJ1Y3QgbWx4NV92ZHBhX25l
dCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAtCXUxNiBkZXZfZmVhdHVyZXM7
Cj4gICAKPiAtCWRldl9mZWF0dXJlcyA9IE1MWDVfQ0FQX0RFVl9WRFBBX0VNVUxBVElPTihtdmRl
di0+bWRldiwgZGV2aWNlX2ZlYXR1cmVzX2JpdHNfbWFzayk7Cj4gLQluZGV2LT5tdmRldi5tbHhf
ZmVhdHVyZXMgPSBtbHhfdG9fdnJpdGlvX2ZlYXR1cmVzKGRldl9mZWF0dXJlcyk7Cj4gLQlpZiAo
TUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG12ZGV2LT5tZGV2LCB2aXJ0aW9fdmVyc2lvbl8x
XzApKQo+IC0JCW5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19GX1ZF
UlNJT05fMSk7Cj4gLQluZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0pOwo+IC0JcHJpbnRfZmVhdHVyZXMobXZkZXYsIG5kZXYtPm12ZGV2
Lm1seF9mZWF0dXJlcywgZmFsc2UpOwo+IC0JcmV0dXJuIG5kZXYtPm12ZGV2Lm1seF9mZWF0dXJl
czsKPiArCXJldHVybiBtdmRldi0+bWx4X2ZlYXR1cmVzOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMg
aW50IHZlcmlmeV9taW5fZmVhdHVyZXMoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2LCB1NjQg
ZmVhdHVyZXMpCj4gQEAgLTE3ODgsNyArMTc4MCw2IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9z
ZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+ICAgCQljbGVh
cl92aXJ0cXVldWVzKG5kZXYpOwo+ICAgCQltbHg1X3ZkcGFfZGVzdHJveV9tcigmbmRldi0+bXZk
ZXYpOwo+ICAgCQluZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+IC0JCW5kZXYtPm12ZGV2Lm1seF9m
ZWF0dXJlcyA9IDA7Cj4gICAJCSsrbXZkZXYtPmdlbmVyYXRpb247Cj4gICAJCXJldHVybjsKPiAg
IAl9Cj4gQEAgLTE5MDcsNiArMTg5OCwxOSBAQCBzdGF0aWMgaW50IG1seDVfZ2V0X3ZxX2lycShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkdiwgdTE2IGlkeCkKPiAgIAkuZnJlZSA9IG1seDVfdmRwYV9m
cmVlLAo+ICAgfTsKPiAgIAo+ICtzdGF0aWMgdm9pZCBxdWVyeV92aXJ0aW9fZmVhdHVyZXMoc3Ry
dWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gK3sKPiArCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICpt
dmRldiA9ICZuZGV2LT5tdmRldjsKPiArCXUxNiBkZXZfZmVhdHVyZXM7Cj4gKwo+ICsJZGV2X2Zl
YXR1cmVzID0gTUxYNV9DQVBfREVWX1ZEUEFfRU1VTEFUSU9OKG12ZGV2LT5tZGV2LCBkZXZpY2Vf
ZmVhdHVyZXNfYml0c19tYXNrKTsKPiArCW12ZGV2LT5tbHhfZmVhdHVyZXMgPSBtbHhfdG9fdnJp
dGlvX2ZlYXR1cmVzKGRldl9mZWF0dXJlcyk7Cj4gKwlpZiAoTUxYNV9DQVBfREVWX1ZEUEFfRU1V
TEFUSU9OKG12ZGV2LT5tZGV2LCB2aXJ0aW9fdmVyc2lvbl8xXzApKQo+ICsJCW12ZGV2LT5tbHhf
ZmVhdHVyZXMgfD0gQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpOwo+ICsJbXZkZXYtPm1seF9m
ZWF0dXJlcyB8PSBCSVRfVUxMKFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSk7Cj4gKwlwcmludF9m
ZWF0dXJlcyhtdmRldiwgbXZkZXYtPm1seF9mZWF0dXJlcywgZmFsc2UpOwo+ICt9Cj4gKwo+ICAg
c3RhdGljIGludCBxdWVyeV9tdHUoc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXYsIHUxNiAqbXR1
KQo+ICAgewo+ICAgCXUxNiBod19tdHU7Cj4gQEAgLTIwMDUsNiArMjAwOSw3IEBAIHN0YXRpYyBp
bnQgbWx4NXZfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXYsCj4gICAJaW5pdF9t
dnFzKG5kZXYpOwo+ICAgCW11dGV4X2luaXQoJm5kZXYtPnJlc2xvY2spOwo+ICAgCWNvbmZpZyA9
ICZuZGV2LT5jb25maWc7Cj4gKwlxdWVyeV92aXJ0aW9fZmVhdHVyZXMobmRldik7Cj4gICAJZXJy
ID0gcXVlcnlfbXR1KG1kZXYsICZuZGV2LT5tdHUpOwo+ICAgCWlmIChlcnIpCj4gICAJCWdvdG8g
ZXJyX210dTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==

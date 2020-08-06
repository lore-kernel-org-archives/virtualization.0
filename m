Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E8DC433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:29:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A90CB21744
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HvjwAOa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A90CB21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B9A088866;
	Thu,  6 Aug 2020 03:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bp1WdlomCMc3; Thu,  6 Aug 2020 03:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BCD88887E9;
	Thu,  6 Aug 2020 03:29:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E922C0051;
	Thu,  6 Aug 2020 03:29:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5197C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A52DF237C8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:29:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1FeaSX4M25DQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 1D14C22F4C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqqusaMY5nwkPoft2J2o8MkWdw785dqs4rwmV+X8bIM=;
 b=HvjwAOa85UacLjWPs8MjzDsdLIlOwkEEbpGaNrs4PQuzmTYjSOcrMokTHKh2F4ZaRxmkTT
 QqhnmfYDkvwshqD+do/KvuANsHeg1Ma3GaIb+mcapFbXCat/jEXK21usggRqGBp6/3c81v
 0/l7HYEc50i2z4XtRCoFf8hEw9QzNAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-Tki8dWVcPCurLaGHCQ6RVA-1; Wed, 05 Aug 2020 23:29:28 -0400
X-MC-Unique: Tki8dWVcPCurLaGHCQ6RVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D514258;
 Thu,  6 Aug 2020 03:29:26 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A097B19C71;
 Thu,  6 Aug 2020 03:29:18 +0000 (UTC)
Subject: Re: [PATCH 4/4] vhost: vdpa: report iova range
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-5-jasowang@redhat.com>
 <20200805085635-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <357f681b-fdee-cc04-3cf3-04035c555893@redhat.com>
Date: Thu, 6 Aug 2020 11:29:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805085635-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

Ck9uIDIwMjAvOC81IOS4i+WNiDg6NTgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0N0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBuZXcgaW9jdGwgZm9yIHZob3N0LXZkcGEgZGV2aWNl
IHRoYXQgY2FuCj4+IHJlcG9ydCB0aGUgaW92YSByYW5nZSBieSB0aGUgZGV2aWNlLiBGb3IgZGV2
aWNlIHRoYXQgZGVwZW5kcyBvbgo+PiBwbGF0Zm9ybSBJT01NVSwgd2UgZmV0Y2ggdGhlIGlvdmEg
cmFuZ2UgdmlhIERPTUFJTl9BVFRSX0dFT01FVFJZLiBGb3IKPj4gZGV2aWNlcyB0aGF0IGhhcyBp
dHMgb3duIERNQSB0cmFuc2xhdGlvbiB1bml0LCB3ZSBmZXRjaCBpdCBkaXJlY3RseQo+PiBmcm9t
IHZEUEEgYnVzIG9wZXJhdGlvbi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFz
b3dhbmdAcmVkaGF0LmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgICAgICAg
ICAgICAgfCAyNyArKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gICBpbmNsdWRlL3VhcGkv
bGludXgvdmhvc3QuaCAgICAgICB8ICA0ICsrKysKPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmhv
c3RfdHlwZXMuaCB8ICA1ICsrKysrCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhv
c3QvdmRwYS5jCj4+IGluZGV4IDc3YTBjOWZiNmNjMy4uYWQyM2U2NmNiZjU3IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+
PiBAQCAtMzMyLDYgKzMzMiwzMCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWdf
Y2FsbChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTMyIF9fdXNlciAqYXJncCkKPj4gICAKPj4gICAJ
cmV0dXJuIDA7Cj4+ICAgfQo+PiArCj4+ICtzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9pb3Zh
X3JhbmdlKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MzIgX191c2VyICphcmdwKQo+PiArewo+PiAr
CXN0cnVjdCBpb21tdV9kb21haW5fZ2VvbWV0cnkgZ2VvOwo+PiArCXN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRwYSA9IHYtPnZkcGE7Cj4+ICsJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3Bz
ID0gdmRwYS0+Y29uZmlnOwo+PiArCXN0cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgcmFuZ2U7
Cj4+ICsJc3RydWN0IHZkcGFfaW92YV9yYW5nZSB2ZHBhX3JhbmdlOwo+PiArCj4+ICsJaWYgKCFv
cHMtPnNldF9tYXAgJiYgIW9wcy0+ZG1hX21hcCkgewo+IFdoeSBub3QganVzdCBjaGVjayBpZiAo
b3BzLT5nZXRfaW92YV9yYW5nZSkgZGlyZWN0bHk/CgoKQmVjYXVzZSBzZXRfbWFwIHx8IGRtYV9v
cHMgaXMgYSBoaW50IHRoYXQgdGhlIGRldmljZSBoYXMgaXRzIG93biBETUEgCnRyYW5zbGF0aW9u
IGxvZ2ljLgoKRGV2aWNlIHdpdGhvdXQgZ2V0X2lvdmFfcmFuZ2UgZG9lcyBub3QgbmVjZXNzYXJp
bHkgbWVhbnQgaXQgdXNlIElPTU1VIApkcml2ZXIuCgpUaGFua3MKCgo+Cj4KPgo+Cj4+ICsJCWlv
bW11X2RvbWFpbl9nZXRfYXR0cih2LT5kb21haW4sCj4+ICsJCQkJICAgICAgRE9NQUlOX0FUVFJf
R0VPTUVUUlksICZnZW8pOwo+PiArCQlyYW5nZS5zdGFydCA9IGdlby5hcGVydHVyZV9zdGFydDsK
Pj4gKwkJcmFuZ2UuZW5kID0gZ2VvLmFwZXJ0dXJlX2VuZDsKPj4gKwl9IGVsc2Ugewo+PiArCQl2
ZHBhX3JhbmdlID0gb3BzLT5nZXRfaW92YV9yYW5nZSh2ZHBhKTsKPj4gKwkJcmFuZ2Uuc3RhcnQg
PSB2ZHBhX3JhbmdlLnN0YXJ0Owo+PiArCQlyYW5nZS5lbmQgPSB2ZHBhX3JhbmdlLmVuZDsKPj4g
Kwl9Cj4+ICsKPj4gKwlyZXR1cm4gY29weV90b191c2VyKGFyZ3AsICZyYW5nZSwgc2l6ZW9mKHJh
bmdlKSk7Cj4+ICsKPj4gK30KPj4gKwo+PiAgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdnJpbmdf
aW9jdGwoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHVuc2lnbmVkIGludCBjbWQsCj4+ICAgCQkJCSAg
IHZvaWQgX191c2VyICphcmdwKQo+PiAgIHsKPj4gQEAgLTQ0Miw2ICs0NjYsOSBAQCBzdGF0aWMg
bG9uZyB2aG9zdF92ZHBhX3VubG9ja2VkX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxlcCwKPj4gICAJ
Y2FzZSBWSE9TVF9WRFBBX1NFVF9DT05GSUdfQ0FMTDoKPj4gICAJCXIgPSB2aG9zdF92ZHBhX3Nl
dF9jb25maWdfY2FsbCh2LCBhcmdwKTsKPj4gICAJCWJyZWFrOwo+PiArCWNhc2UgVkhPU1RfVkRQ
QV9HRVRfSU9WQV9SQU5HRToKPj4gKwkJciA9IHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uodiwg
YXJncCk7Cj4+ICsJCWJyZWFrOwo+PiAgIAlkZWZhdWx0Ogo+PiAgIAkJciA9IHZob3N0X2Rldl9p
b2N0bCgmdi0+dmRldiwgY21kLCBhcmdwKTsKPj4gICAJCWlmIChyID09IC1FTk9JT0NUTENNRCkK
Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3Zob3N0LmgKPj4gaW5kZXggMGMyMzQ5NjEyZTc3Li44NTA5NTY5ODBlMjcgMTAwNjQ0
Cj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aG9zdC5oCj4+ICsrKyBiL2luY2x1ZGUvdWFw
aS9saW51eC92aG9zdC5oCj4+IEBAIC0xNDQsNCArMTQ0LDggQEAKPj4gICAKPj4gICAvKiBTZXQg
ZXZlbnQgZmQgZm9yIGNvbmZpZyBpbnRlcnJ1cHQqLwo+PiAgICNkZWZpbmUgVkhPU1RfVkRQQV9T
RVRfQ09ORklHX0NBTEwJX0lPVyhWSE9TVF9WSVJUSU8sIDB4NzcsIGludCkKPj4gKwo+PiArLyog
R2V0IHRoZSB2YWxpZCBpb3ZhIHJhbmdlICovCj4+ICsjZGVmaW5lIFZIT1NUX1ZEUEFfR0VUX0lP
VkFfUkFOR0UJX0lPVyhWSE9TVF9WSVJUSU8sIDB4NzgsIFwKPj4gKwkJCQkJICAgICBzdHJ1Y3Qg
dmhvc3RfdmRwYV9pb3ZhX3JhbmdlKQo+PiAgICNlbmRpZgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmhvc3RfdHlw
ZXMuaAo+PiBpbmRleCA2Njk0NTdjZTVjNDguLjQwMjViNWEzNjE3NyAxMDA2NDQKPj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmgKPj4gKysrIGIvaW5jbHVkZS91YXBpL2xp
bnV4L3Zob3N0X3R5cGVzLmgKPj4gQEAgLTEyNyw2ICsxMjcsMTEgQEAgc3RydWN0IHZob3N0X3Zk
cGFfY29uZmlnIHsKPj4gICAJX191OCBidWZbMF07Cj4+ICAgfTsKPj4gICAKPj4gK3N0cnVjdCB2
aG9zdF92ZHBhX2lvdmFfcmFuZ2Ugewo+PiArCV9fdTY0IHN0YXJ0Owo+PiArCV9fdTY0IGVuZDsK
Pj4gK307Cj4+ICsKPgo+IFBscyBkb2N1bWVudCBmaWVsZHMuIEFuZCBJIHRoaW5rIGZpcnN0L2xh
c3QgaXMgYSBiZXR0ZXIgQVBJIC4uLgo+Cj4+ICAgLyogRmVhdHVyZSBiaXRzICovCj4+ICAgLyog
TG9nIGFsbCB3cml0ZSBkZXNjcmlwdG9ycy4gQ2FuIGJlIGNoYW5nZWQgd2hpbGUgZGV2aWNlIGlz
IGFjdGl2ZS4gKi8KPj4gICAjZGVmaW5lIFZIT1NUX0ZfTE9HX0FMTCAyNgo+PiAtLSAKPj4gMi4y
MC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=

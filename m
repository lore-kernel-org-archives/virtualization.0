Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F84C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:25:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F266136A
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F266136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92CD682DDE;
	Wed,  7 Apr 2021 07:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JxISjJ9w_8rG; Wed,  7 Apr 2021 07:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2986082F9E;
	Wed,  7 Apr 2021 07:25:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6060C000C;
	Wed,  7 Apr 2021 07:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCA3BC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:25:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C13D6849DA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HdkeCfFxtOZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:25:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EE60482F9E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617780310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9csyUYiwm6I7pgrc0DIiF3hqM7uma6o85xnk+oDvk6M=;
 b=Nwd9qdio5tEefvfv30y1kvVrvlFzDqMfWP2CnD+eijtMMWPXzX+rprIaEE4mHUXoXx31kd
 QjtVfQLcicaOj9MVgy41cMJK/OtUNsXDqbf01vnJmrnbh6RpnRa4LVYwX/uSdHq8Q7TKLR
 V9cKuLGeD3tsMypdCyJPXn/bQnc0rU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-LngSwSbGOs6cUMqgjJ6Y6A-1; Wed, 07 Apr 2021 03:25:09 -0400
X-MC-Unique: LngSwSbGOs6cUMqgjJ6Y6A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185D518B9EC3;
 Wed,  7 Apr 2021 07:25:08 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D87B6510ED;
 Wed,  7 Apr 2021 07:25:01 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 13/14] vdpa/mlx5: Fix suspend/resume index
 restoration
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-14-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a172fae0-068a-2d0b-c5c4-e15998f2a67d@redhat.com>
Date: Wed, 7 Apr 2021 15:25:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-14-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: elic@nvidia.com, mst@redhat.com
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

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBGcm9tOiBFbGkgQ29o
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+IFdoZW4gd2Ugc3VzcGVuZCB0aGUgVk0sIHRoZSBWRFBB
IGludGVyZmFjZSB3aWxsIGJlIHJlc2V0LiBXaGVuIHRoZSBWTSBpcwo+IHJlc3VtZWQgYWdhaW4s
IGNsZWFyX3ZpcnRxdWV1ZXMoKSB3aWxsIGNsZWFyIHRoZSBhdmFpbGFibGUgYW5kIHVzZWQKPiBp
bmRpY2VzIHJlc3VsdGluZyBpbiBoYXJkd2FyZSB2aXJxdHF1ZXVlIG9iamVjdHMgYmVjb21pbmcg
b3V0IG9mIHN5bmMuCj4gV2UgY2FuIGF2b2lkIHRoaXMgZnVuY3Rpb24gYWxsdG9nZXRoZXIgc2lu
Y2UgcWVtdSB3aWxsIGNsZWFyIHRoZW0gaWYKPiByZXF1aXJlZCwgZS5nLiB3aGVuIHRoZSBWTSB3
ZW50IHRocm91Z2ggYSByZWJvb3QuCj4KPiBNb3Jlb3Zlciwgc2luY2UgdGhlIGh3IGF2YWlsYWJs
ZSBhbmQgdXNlZCBpbmRpY2VzIHNob3VsZCBhbHdheXMgYmUKPiBpZGVudGljYWwgb24gcXVlcnkg
YW5kIHNob3VsZCBiZSByZXN0b3JlZCB0byB0aGUgc2FtZSB2YWx1ZSBzYW1lIHZhbHVlCj4gZm9y
IHZpcnRxdWV1ZXMgdGhhdCBjb21wbGV0ZSBpbiBvcmRlciwgd2Ugc2V0IHRoZSBzaW5nbGUgdmFs
dWUgcHJvdmlkZWQKPiBieSBzZXRfdnFfc3RhdGUoKS4gSW4gZ2V0X3ZxX3N0YXRlKCkgd2UgcmV0
dXJuIHRoZSB2YWx1ZSBvZiBoYXJkd2FyZQo+IHVzZWQgaW5kZXguCj4KPiBGaXhlczogYjM1Y2Nl
YmUzZWY3ICgidmRwYS9tbHg1OiBSZXN0b3JlIHRoZSBoYXJkd2FyZSB1c2VkIGluZGV4IGFmdGVy
IGNoYW5nZSBtYXAiKQo+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBB
IGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gU2lnbmVkLW9mZi1ieTogRWxp
IENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgfCAxNyArKysrLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4gaW5kZXggNTZkNDYzZDJiZTg1Li5hNmU2ZDQ0YjljYTUgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4gQEAgLTExNzAsNiArMTE3MCw3IEBAIHN0YXRpYyB2b2lkIHN1c3Bl
bmRfdnEoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1
ZXVlICptCj4gICAJCXJldHVybjsKPiAgIAl9Cj4gICAJbXZxLT5hdmFpbF9pZHggPSBhdHRyLmF2
YWlsYWJsZV9pbmRleDsKPiArCW12cS0+dXNlZF9pZHggPSBhdHRyLnVzZWRfaW5kZXg7Cj4gICB9
Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHN1c3BlbmRfdnFzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpu
ZGV2KQo+IEBAIC0xNDY2LDYgKzE0NjcsNyBAQCBzdGF0aWMgaW50IG1seDVfdmRwYV9zZXRfdnFf
c3RhdGUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LAo+ICAgCQlyZXR1cm4gLUVJ
TlZBTDsKPiAgIAl9Cj4gICAKPiArCW12cS0+dXNlZF9pZHggPSBzdGF0ZS0+YXZhaWxfaW5kZXg7
Cj4gICAJbXZxLT5hdmFpbF9pZHggPSBzdGF0ZS0+YXZhaWxfaW5kZXg7Cj4gICAJcmV0dXJuIDA7
Cj4gICB9Cj4gQEAgLTE0ODMsNyArMTQ4NSw3IEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2dldF92
cV9zdGF0ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIHN0cnVjdCB2ZHBhCj4g
ICAJICogdGhhdCBjYXJlcyBhYm91dCBlbXVsYXRpbmcgdGhlIGluZGV4IGFmdGVyIHZxIGlzIHN0
b3BwZWQuCj4gICAJICovCj4gICAJaWYgKCFtdnEtPmluaXRpYWxpemVkKSB7Cj4gLQkJc3RhdGUt
PmF2YWlsX2luZGV4ID0gbXZxLT5hdmFpbF9pZHg7Cj4gKwkJc3RhdGUtPmF2YWlsX2luZGV4ID0g
bXZxLT51c2VkX2lkeDsKCgpFdmVuIGlmIHRoZSBoYXJkd2FyZSBhdmFpbCBpZHggaXMgYWx3YXlz
IGVxdWFsIHRvIHVzZWQgaWR4LiBJIHdvdWxkIApzdGlsbCBrZWVwIHVzaW5nIHRoZSBhdmFpbF9p
ZHgsIHRoaXMgbWFrZXMgaXQgZWFzaWVyIHRvIGJlIHJldmlld2VkIApzaW5jZSBpdCBpcyBjb25z
aXN0ZW50IHRvIGUuZyBrZXJuZWwgdmhvc3QgYmFrY2VuZCBpbXBsZW1lbnRhdGlvbnMuIChUaGUg
Cmxhc3RfYXZhaWxfaWR4IGluIHZob3N0X3ZpcnRxdWV1ZSkuCgpUaGFua3MKCgo+ICAgCQlyZXR1
cm4gMDsKPiAgIAl9Cj4gICAKPiBAQCAtMTQ5Miw3ICsxNDk0LDcgQEAgc3RhdGljIGludCBtbHg1
X3ZkcGFfZ2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCwgc3Ry
dWN0IHZkcGEKPiAgIAkJbWx4NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQgdG8gcXVlcnkgdmly
dHF1ZXVlXG4iKTsKPiAgIAkJcmV0dXJuIGVycjsKPiAgIAl9Cj4gLQlzdGF0ZS0+YXZhaWxfaW5k
ZXggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPiArCXN0YXRlLT5hdmFpbF9pbmRleCA9IGF0dHIu
dXNlZF9pbmRleDsKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+IEBAIC0xNTcyLDE2ICsxNTc0
LDYgQEAgc3RhdGljIHZvaWQgdGVhcmRvd25fdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25l
dCAqbmRldikKPiAgIAl9Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZvaWQgY2xlYXJfdmlydHF1ZXVl
cyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAtewo+IC0JaW50IGk7Cj4gLQo+IC0JZm9y
IChpID0gbmRldi0+bXZkZXYubWF4X3ZxcyAtIDE7IGkgPj0gMDsgaS0tKSB7Cj4gLQkJbmRldi0+
dnFzW2ldLmF2YWlsX2lkeCA9IDA7Cj4gLQkJbmRldi0+dnFzW2ldLnVzZWRfaWR4ID0gMDsKPiAt
CX0KPiAtfQo+IC0KPiAgIC8qIFRPRE86IGNyb3NzLWVuZGlhbiBzdXBwb3J0ICovCj4gICBzdGF0
aWMgaW5saW5lIGJvb2wgbWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IG1seDVfdmRw
YV9kZXYgKm12ZGV2KQo+ICAgewo+IEBAIC0xODIyLDcgKzE4MTQsNiBAQCBzdGF0aWMgdm9pZCBt
bHg1X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykK
PiAgIAlpZiAoIXN0YXR1cykgewo+ICAgCQltbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1p
bmcgZGV2aWNlIHJlc2V0XG4iKTsKPiAgIAkJdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+IC0JCWNs
ZWFyX3ZpcnRxdWV1ZXMobmRldik7Cj4gICAJCW1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5t
dmRldik7Cj4gICAJCW5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7Cj4gICAJCSsrbXZkZXYtPmdlbmVy
YXRpb247CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=

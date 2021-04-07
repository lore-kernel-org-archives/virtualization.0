Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40856C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:18:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57B06128A
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57B06128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8209F40F35;
	Wed,  7 Apr 2021 03:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VCTM5hOn1T_f; Wed,  7 Apr 2021 03:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id A48864032D;
	Wed,  7 Apr 2021 03:18:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77D78C000B;
	Wed,  7 Apr 2021 03:18:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4D4C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0739740F31
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:18:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRqG2Nd70p1b
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:18:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE4184032D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617765491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fwV2ksFm4UW8anew/HJqrVRwyRQZFHrABi6+Hbo9F3I=;
 b=gt9O6eD+Mlpew2HsQ66ClT2wXJxHDMQqr8AwxFVUCqDO4cpVKQ06iyj3rAUG4q8iyIvm7X
 wF/n598bHlaUDsXA3WJQO3shjOSAkHUCapF6uC4K88i1UVkOrnkTHl6ZjLK8hGEZxzPS6Z
 mUeX5o/jLJKNcBi4ndAv33tRswr6pao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-_fZbW6ywOlu8B1SoJD2Mhg-1; Tue, 06 Apr 2021 23:18:09 -0400
X-MC-Unique: _fZbW6ywOlu8B1SoJD2Mhg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A2E1084D6B;
 Wed,  7 Apr 2021 03:18:08 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-233.pek2.redhat.com
 [10.72.13.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6808E19D9D;
 Wed,  7 Apr 2021 03:18:03 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 03/14] vdpa: Introduce and use vdpa device
 get,set config, features helpers
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-4-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e2f4f024-f506-c2d0-3aef-a11ce2c5778f@redhat.com>
Date: Wed, 7 Apr 2021 11:18:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-4-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBTdWJzZXF1ZW50IHBh
dGNoZXMgZW5hYmxlIGdldCBhbmQgc2V0IGNvbmZpZ3VyYXRpb24gZWl0aGVyCj4gdmlhIG1hbmFn
ZW1lbnQgZGV2aWNlIG9yIHZpYSB2ZHBhIGRldmljZScgY29uZmlnIG9wcy4KPgo+IFRoaXMgcmVx
dWlyZXMgc3luY2hyb25pemF0aW9uIGJldHdlZW4gbXVsdGlwbGUgY2FsbGVycyB0byBnZXQgYW5k
IHNldAo+IGNvbmZpZyBjYWxsYmFja3MuIEZlYXR1cmVzIHNldHRpbmcgYWxzbyBpbmZsdWVuY2Ug
dGhlIGxheW91dCBvZiB0aGUKPiBjb25maWd1cmF0aW9uIGZpZWxkcyBlbmRpYW5uZXNzLgo+Cj4g
VG8gYXZvaWQgZXhwb3Npbmcgc3luY2hyb25pemF0aW9uIHByaW1pdGl2ZXMgdG8gY2FsbGVycywg
aW50cm9kdWNlCj4gaGVscGVyIGZvciBzZXR0aW5nIHRoZSBjb25maWd1cmF0aW9uIGFuZCB1c2Ug
aXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4g
UmV2aWV3ZWQtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+IC0tLQo+IGNoYW5nZWxv
ZzoKPiB2MS0+djIKPiAgIC0gbmV3IHBhdGNoIHRvIGhhdmUgc3luY2hyb25pemVkIGFjY2VzcyB0
byBmZWF0dXJlcyBhbmQgY29uZmlnIHNwYWNlCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYS5j
ICB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBk
cml2ZXJzL3Zob3N0L3ZkcGEuYyB8ICA2ICsrLS0tCj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8
IDI4ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0
aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Zk
cGEuYyBiL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiBpbmRleCBiYjNmMWQxZjA0MjIuLjExNmUwNzZj
NzJmZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92
ZHBhL3ZkcGEuYwo+IEBAIC0yNjEsNiArMjYxLDYzIEBAIGludCB2ZHBhX21nbXRkZXZfcmVnaXN0
ZXIoc3RydWN0IHZkcGFfbWdtdF9kZXYgKm1kZXYpCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQ
TCh2ZHBhX21nbXRkZXZfcmVnaXN0ZXIpOwo+ICAgCj4gKy8qKgo+ICsgKiB2ZHBhX2dldF9mZWF0
dXJlcyAtIFJlYWQgdkRQQSBkZXZpY2UgZmVhdHVyZXMKPiArICogQHZkZXY6IHZkcGEgZGV2aWNl
IHdob3NlIGZlYXR1cmVzIHRvIHJlYWQKPiArICoKPiArICogUmV0dXJuOiBSZXR1cm5zIGRldmlj
ZSBmZWF0dXJlcy4KPiArICovCj4gK3U2NCB2ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9k
ZXZpY2UgKnZkZXYpCj4gK3sKPiArCXJldHVybiB2ZGV2LT5jb25maWctPmdldF9mZWF0dXJlcyh2
ZGV2KTsKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh2ZHBhX2dldF9mZWF0dXJlcyk7Cj4gKwo+
ICsvKioKPiArICogdmRwYV9zZXRfZmVhdHVyZXMgLSBTZXQgdkRQQSBkZXZpY2UgZmVhdHVyZXMK
PiArICogQHZkZXY6IHZkcGEgZGV2aWNlIHdob3NlIGZlYXR1cmVzIHRvIHNldAo+ICsgKiBAZmVh
dHVyZXM6IGZlYXR1cmVzIG9mIHRoZSB2ZHBhIGRldmljZSB0byBlbmFibGUvZGlzYWJsZQo+ICsg
Kgo+ICsgKiBSZXR1cm46IFJldHVybnMgMCBvbiBzdWNjZXNzIG9yIGVycm9yIGNvZGUuCj4gKyAq
Lwo+ICtpbnQgdmRwYV9zZXRfZmVhdHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQg
ZmVhdHVyZXMpCj4gK3sKPiArCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZk
ZXYtPmNvbmZpZzsKPiArCj4gKwl2ZGV2LT5mZWF0dXJlc192YWxpZCA9IHRydWU7Cj4gKwlyZXR1
cm4gb3BzLT5zZXRfZmVhdHVyZXModmRldiwgZmVhdHVyZXMpOwo+ICt9Cj4gK0VYUE9SVF9TWU1C
T0xfR1BMKHZkcGFfc2V0X2ZlYXR1cmVzKTsKPiArCgoKTGV0J3MgYWRkIGEgZG9jIGZvciB0aGlz
IGZ1bmN0aW9uPwoKCj4gK3ZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPiArCQkgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQg
aW50IGxlbikKPiArewo+ICsJY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRl
di0+Y29uZmlnOwo+ICsKPiArCS8qCj4gKwkgKiBDb25maWcgYWNjZXNzZXMgYXJlbid0IHN1cHBv
c2VkIHRvIHRyaWdnZXIgYmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuCj4gKwkgKiBJZiBpdCBkb2Vz
IGhhcHBlbiB3ZSBhc3N1bWUgYSBsZWdhY3kgZ3Vlc3QuCj4gKwkgKi8KPiArCWlmICghdmRldi0+
ZmVhdHVyZXNfdmFsaWQpCj4gKwkJdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gKwlvcHMt
PmdldF9jb25maWcodmRldiwgb2Zmc2V0LCBidWYsIGxlbik7Cj4gK30KPiArRVhQT1JUX1NZTUJP
TF9HUEwodmRwYV9nZXRfY29uZmlnKTsKPiArCj4gKy8qKgo+ICsgKiB2ZHBhX3NldF9jb25maWcg
LSBTZXQgb25lIG9yIG1vcmUgZGV2aWNlIGNvbmZpZ3VyYXRpb24gZmllbGRzLgo+ICsgKiBAZGV2
OiB2ZHBhIGRldmljZSB0byBvcGVyYXRlIG9uCj4gKyAqIEBvZmZzZXQ6IHN0YXJ0aW5nIGJ5dGUg
b2Zmc2V0IG9mIHRoZSBmaWVsZAo+ICsgKiBAYnVmOiBidWZmZXIgcG9pbnRlciB0byByZWFkIGZy
b20KPiArICogQGxlbmd0aDogbGVuZ3RoIG9mIHRoZSBjb25maWd1cmF0aW9uIGZpZWxkcyBpbiBi
eXRlcwo+ICsgKi8KPiArdm9pZCB2ZHBhX3NldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICpk
ZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gKwkJICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGlu
dCBsZW5ndGgpCj4gK3sKPiArCWRldi0+Y29uZmlnLT5zZXRfY29uZmlnKGRldiwgb2Zmc2V0LCBi
dWYsIGxlbmd0aCk7Cj4gK30KPiArRVhQT1JUX1NZTUJPTF9HUEwodmRwYV9zZXRfY29uZmlnKTsK
PiArCj4gICBzdGF0aWMgaW50IHZkcGFfbWF0Y2hfcmVtb3ZlKHN0cnVjdCBkZXZpY2UgKmRldiwg
dm9pZCAqZGF0YSkKPiAgIHsKPiAgIAlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYgPSBjb250YWlu
ZXJfb2YoZGV2LCBzdHJ1Y3QgdmRwYV9kZXZpY2UsIGRldik7Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBlMGEyN2UzMzYy
OTMuLjM4M2Y1YmU4ZmZhNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsr
KyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCgoKV2UgcHJvYmFibHkgbmVlZCB0byBjb252ZXJ0IGRy
aXZlcnMvdmlydGlvL3ZkcGEuYyBhcyB3ZWxsLgoKCj4gQEAgLTIzNiw3ICsyMzYsNiBAQCBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICAJ
CQkJICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgX191c2VyICpjKQo+ICAgewo+ICAgCXN0cnVj
dCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4gLQljb25zdCBzdHJ1Y3QgdmRwYV9jb25m
aWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gICAJc3RydWN0IHZob3N0X3ZkcGFfY29uZmln
IGNvbmZpZzsKPiAgIAl1bnNpZ25lZCBsb25nIHNpemUgPSBvZmZzZXRvZihzdHJ1Y3Qgdmhvc3Rf
dmRwYV9jb25maWcsIGJ1Zik7Cj4gICAJdTggKmJ1ZjsKPiBAQCAtMjUwLDcgKzI0OSw3IEBAIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAg
IAlpZiAoSVNfRVJSKGJ1ZikpCj4gICAJCXJldHVybiBQVFJfRVJSKGJ1Zik7Cj4gICAKPiAtCW9w
cy0+c2V0X2NvbmZpZyh2ZHBhLCBjb25maWcub2ZmLCBidWYsIGNvbmZpZy5sZW4pOwo+ICsJdmRw
YV9zZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1ZiwgY29uZmlnLmxlbik7Cj4gICAKPiAg
IAlrdmZyZWUoYnVmKTsKPiAgIAlyZXR1cm4gMDsKPiBAQCAtMjU5LDEwICsyNTgsOSBAQCBzdGF0
aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4gICBz
dGF0aWMgbG9uZyB2aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwg
dTY0IF9fdXNlciAqZmVhdHVyZXApCj4gICB7Cj4gICAJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBh
ID0gdi0+dmRwYTsKPiAtCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkcGEt
PmNvbmZpZzsKPiAgIAl1NjQgZmVhdHVyZXM7Cj4gICAKPiAtCWZlYXR1cmVzID0gb3BzLT5nZXRf
ZmVhdHVyZXModmRwYSk7Cj4gKwlmZWF0dXJlcyA9IHZkcGFfZ2V0X2ZlYXR1cmVzKHZkcGEpOwo+
ICAgCj4gICAJaWYgKGNvcHlfdG9fdXNlcihmZWF0dXJlcCwgJmZlYXR1cmVzLCBzaXplb2YoZmVh
dHVyZXMpKSkKPiAgIAkJcmV0dXJuIC1FRkFVTFQ7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBpbmRleCAzN2I2NWNhOTQwY2YuLjYy
ZTY4Y2NjNGM5NiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvdmRwYS5oCj4gQEAgLTMyMCwyOCArMzIwLDEyIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCB2ZHBhX3Jlc2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPiAgICAgICAgICAgb3Bz
LT5zZXRfc3RhdHVzKHZkZXYsIDApOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbmxpbmUgaW50IHZk
cGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+
IC17Cj4gLSAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRldi0+
Y29uZmlnOwo+IC0KPiAtCXZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gdHJ1ZTsKPiAtICAgICAgICBy
ZXR1cm4gb3BzLT5zZXRfZmVhdHVyZXModmRldiwgZmVhdHVyZXMpOwo+IC19Cj4gLQo+IC0KPiAt
c3RhdGljIGlubGluZSB2b2lkIHZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIG9mZnNldCwKPiAtCQkJCSAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxl
bikKPiAtewo+IC0gICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZk
ZXYtPmNvbmZpZzsKPiAtCj4gLQkvKgo+IC0JICogQ29uZmlnIGFjY2Vzc2VzIGFyZW4ndCBzdXBw
b3NlZCB0byB0cmlnZ2VyIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0Lgo+IC0JICogSWYgaXQgZG9l
cyBoYXBwZW4gd2UgYXNzdW1lIGEgbGVnYWN5IGd1ZXN0Lgo+IC0JICovCj4gLQlpZiAoIXZkZXYt
PmZlYXR1cmVzX3ZhbGlkKQo+IC0JCXZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+IC0Jb3Bz
LT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+IC19Cj4gK3U2NCB2ZHBhX2dl
dF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+ICtpbnQgdmRwYV9zZXRfZmVh
dHVyZXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMpOwo+ICt2b2lkIHZk
cGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZz
ZXQsCj4gKwkJICAgICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pOwo+ICt2b2lkIHZkcGFf
c2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwK
PiArCQkgICAgIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbmd0aCk7CgoKSSB0aGluayBpdCdz
IGJldHRlciB0byB1c2UgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcyBtb3ZpbmcuCgpUaGFua3MK
Cgo+ICAgCj4gICAvKioKPiAgICAqIHN0cnVjdCB2ZHBhX21nbXRkZXZfb3BzIC0gdmRwYSBkZXZp
Y2Ugb3BzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=

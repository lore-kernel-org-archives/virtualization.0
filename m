Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3D3C433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:10:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8028C611BE
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 03:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8028C611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1EF2B40145;
	Wed,  7 Apr 2021 03:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PIWI4Zw9L-tc; Wed,  7 Apr 2021 03:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 944C4405A0;
	Wed,  7 Apr 2021 03:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67F3CC000B;
	Wed,  7 Apr 2021 03:10:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74D06C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5717B403F9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6-bHb8Y_ZSiH
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:10:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5832940145
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 03:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617765006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIMxNv6TiKl/4TIXZslpKaf5nm4lYZ9E4m3D27fTGz0=;
 b=Cv+fHv8cDcoUR9z1Gm46mSvuySOctP6loR/WkGeXWH6sReCOmSxMZFvXxJSWtlUg7619ae
 Ils2Ov8vCvXrc8hSxI/M3xIzmhqfuuawMB4Ppe+EdkXhFruS6NKLQPqh9/2UQFp0eDX2J+
 pTmga2zdi3TeFtDFE1Fs6L7ds03nz54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-4ziHbzckMi2zd3feyPHLig-1; Tue, 06 Apr 2021 23:10:04 -0400
X-MC-Unique: 4ziHbzckMi2zd3feyPHLig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A2D180FCA2;
 Wed,  7 Apr 2021 03:10:03 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-233.pek2.redhat.com
 [10.72.13.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9825B19D9D;
 Wed,  7 Apr 2021 03:09:58 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 02/14] vdpa: Follow kdoc comment style
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-3-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ee143a65-a1ec-ae4f-4ad6-61d8797ae877@redhat.com>
Date: Wed, 7 Apr 2021 11:09:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-3-parav@nvidia.com>
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

CtTaIDIwMjEvNC83IMnPzucxOjA0LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBGb2xsb3cgY29tbWVu
dCBzdHlsZSBtZW50aW9uZWQgaW4gdGhlIFdyaXRpbmcga2VybmVsLWRvYyBkb2N1bWVudCBbMV0u
Cj4KPiBGb2xsb3dpbmcgd2FybmluZ3MgYXJlIGZpeGVkLgo+Cj4gJCBzY3JpcHRzL2tlcm5lbC1k
b2MgLXYgLW5vbmUgZHJpdmVycy92ZHBhL3ZkcGEuYwo+IGRyaXZlcnMvdmRwYS92ZHBhLmM6Njc6
IGluZm86IFNjYW5uaW5nIGRvYyBmb3IgX192ZHBhX2FsbG9jX2RldmljZQo+IGRyaXZlcnMvdmRw
YS92ZHBhLmM6ODQ6IHdhcm5pbmc6IE5vIGRlc2NyaXB0aW9uIGZvdW5kIGZvciByZXR1cm4gdmFs
dWUgb2YgJ19fdmRwYV9hbGxvY19kZXZpY2UnCj4gZHJpdmVycy92ZHBhL3ZkcGEuYzoxNTM6IGlu
Zm86IFNjYW5uaW5nIGRvYyBmb3IgX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlCj4gZHJpdmVycy92ZHBh
L3ZkcGEuYzoxNjM6IHdhcm5pbmc6IE5vIGRlc2NyaXB0aW9uIGZvdW5kIGZvciByZXR1cm4gdmFs
dWUgb2YgJ192ZHBhX3JlZ2lzdGVyX2RldmljZScKPiBkcml2ZXJzL3ZkcGEvdmRwYS5jOjE3Mjog
aW5mbzogU2Nhbm5pbmcgZG9jIGZvciB2ZHBhX3JlZ2lzdGVyX2RldmljZQo+IGRyaXZlcnMvdmRw
YS92ZHBhLmM6MTgwOiB3YXJuaW5nOiBObyBkZXNjcmlwdGlvbiBmb3VuZCBmb3IgcmV0dXJuIHZh
bHVlIG9mICd2ZHBhX3JlZ2lzdGVyX2RldmljZScKPiBkcml2ZXJzL3ZkcGEvdmRwYS5jOjE5MTog
aW5mbzogU2Nhbm5pbmcgZG9jIGZvciBfdmRwYV91bnJlZ2lzdGVyX2RldmljZQo+IGRyaXZlcnMv
dmRwYS92ZHBhLmM6MjA1OiBpbmZvOiBTY2FubmluZyBkb2MgZm9yIHZkcGFfdW5yZWdpc3Rlcl9k
ZXZpY2UKPiBkcml2ZXJzL3ZkcGEvdmRwYS5jOjIxNzogaW5mbzogU2Nhbm5pbmcgZG9jIGZvciBf
X3ZkcGFfcmVnaXN0ZXJfZHJpdmVyCj4gZHJpdmVycy92ZHBhL3ZkcGEuYzoyMjQ6IHdhcm5pbmc6
IE5vIGRlc2NyaXB0aW9uIGZvdW5kIGZvciByZXR1cm4gdmFsdWUgb2YgJ19fdmRwYV9yZWdpc3Rl
cl9kcml2ZXInCj4gZHJpdmVycy92ZHBhL3ZkcGEuYzoyMzM6IGluZm86IFNjYW5uaW5nIGRvYyBm
b3IgdmRwYV91bnJlZ2lzdGVyX2RyaXZlcgo+IGRyaXZlcnMvdmRwYS92ZHBhLmM6MjQzOiBpbmZv
OiBTY2FubmluZyBkb2MgZm9yIHZkcGFfbWdtdGRldl9yZWdpc3Rlcgo+IGRyaXZlcnMvdmRwYS92
ZHBhLmM6MjUwOiB3YXJuaW5nOiBObyBkZXNjcmlwdGlvbiBmb3VuZCBmb3IgcmV0dXJuIHZhbHVl
IG9mICd2ZHBhX21nbXRkZXZfcmVnaXN0ZXInCj4KPiBBZnRlciB0aGUgZml4Ogo+Cj4gc2NyaXB0
cy9rZXJuZWwtZG9jIC12IC1ub25lIGRyaXZlcnMvdmRwYS92ZHBhLmMKPiBkcml2ZXJzL3ZkcGEv
dmRwYS5jOjY3OiBpbmZvOiBTY2FubmluZyBkb2MgZm9yIF9fdmRwYV9hbGxvY19kZXZpY2UKPiBk
cml2ZXJzL3ZkcGEvdmRwYS5jOjE1MzogaW5mbzogU2Nhbm5pbmcgZG9jIGZvciBfdmRwYV9yZWdp
c3Rlcl9kZXZpY2UKPiBkcml2ZXJzL3ZkcGEvdmRwYS5jOjE3MjogaW5mbzogU2Nhbm5pbmcgZG9j
IGZvciB2ZHBhX3JlZ2lzdGVyX2RldmljZQo+IGRyaXZlcnMvdmRwYS92ZHBhLmM6MTkxOiBpbmZv
OiBTY2FubmluZyBkb2MgZm9yIF92ZHBhX3VucmVnaXN0ZXJfZGV2aWNlCj4gZHJpdmVycy92ZHBh
L3ZkcGEuYzoyMDU6IGluZm86IFNjYW5uaW5nIGRvYyBmb3IgdmRwYV91bnJlZ2lzdGVyX2Rldmlj
ZQo+IGRyaXZlcnMvdmRwYS92ZHBhLmM6MjE3OiBpbmZvOiBTY2FubmluZyBkb2MgZm9yIF9fdmRw
YV9yZWdpc3Rlcl9kcml2ZXIKPiBkcml2ZXJzL3ZkcGEvdmRwYS5jOjIzMzogaW5mbzogU2Nhbm5p
bmcgZG9jIGZvciB2ZHBhX3VucmVnaXN0ZXJfZHJpdmVyCj4gZHJpdmVycy92ZHBhL3ZkcGEuYzoy
NDM6IGluZm86IFNjYW5uaW5nIGRvYyBmb3IgdmRwYV9tZ210ZGV2X3JlZ2lzdGVyCj4KPiBbMV0g
aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZG9jLWd1aWRlL2tlcm5lbC1k
b2MuaHRtbAo+Cj4gU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29t
Pgo+IFJldmlld2VkLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTog
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBh
L3ZkcGEuYyB8IDEyICsrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5j
IGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+IGluZGV4IDVjZmZjZTY3Y2FiMC4uYmIzZjFkMWYwNDIy
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYS5jCj4gQEAgLTc1LDggKzc1LDggQEAgc3RhdGljIHZvaWQgdmRwYV9yZWxlYXNlX2Rldihz
dHJ1Y3QgZGV2aWNlICpkKQo+ICAgICogRHJpdmVyIHNob3VsZCB1c2UgdmRwYV9hbGxvY19kZXZp
Y2UoKSB3cmFwcGVyIG1hY3JvIGluc3RlYWQgb2YKPiAgICAqIHVzaW5nIHRoaXMgZGlyZWN0bHku
Cj4gICAgKgo+IC0gKiBSZXR1cm5zIGFuIGVycm9yIHdoZW4gcGFyZW50L2NvbmZpZy9kbWFfZGV2
IGlzIG5vdCBzZXQgb3IgZmFpbCB0byBnZXQKPiAtICogaWRhLgo+ICsgKiBSZXR1cm46IFJldHVy
bnMgYW4gZXJyb3Igd2hlbiBwYXJlbnQvY29uZmlnL2RtYV9kZXYgaXMgbm90IHNldCBvciBmYWls
IHRvIGdldAo+ICsgKgkgICBpZGEuCj4gICAgKi8KPiAgIHN0cnVjdCB2ZHBhX2RldmljZSAqX192
ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgZGV2aWNlICpwYXJlbnQsCj4gICAJCQkJCWNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKmNvbmZpZywKPiBAQCAtMTU3LDcgKzE1Nyw3IEBAIHN0YXRp
YyBpbnQgX192ZHBhX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIGlu
dCBudnFzKQo+ICAgICogQHZkZXY6IHRoZSB2ZHBhIGRldmljZSB0byBiZSByZWdpc3RlcmVkIHRv
IHZEUEEgYnVzCj4gICAgKiBAbnZxczogbnVtYmVyIG9mIHZpcnRxdWV1ZXMgc3VwcG9ydGVkIGJ5
IHRoaXMgZGV2aWNlCj4gICAgKgo+IC0gKiBSZXR1cm5zIGFuIGVycm9yIHdoZW4gZmFpbCB0byBh
ZGQgZGV2aWNlIHRvIHZEUEEgYnVzCj4gKyAqIFJldHVybjogUmV0dXJucyBhbiBlcnJvciB3aGVu
IGZhaWwgdG8gYWRkIGRldmljZSB0byB2RFBBIGJ1cwo+ICAgICovCj4gICBpbnQgX3ZkcGFfcmVn
aXN0ZXJfZGV2aWNlKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgaW50IG52cXMpCj4gICB7Cj4g
QEAgLTE3NCw3ICsxNzQsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChfdmRwYV9yZWdpc3Rlcl9kZXZp
Y2UpOwo+ICAgICogQHZkZXY6IHRoZSB2ZHBhIGRldmljZSB0byBiZSByZWdpc3RlcmVkIHRvIHZE
UEEgYnVzCj4gICAgKiBAbnZxczogbnVtYmVyIG9mIHZpcnRxdWV1ZXMgc3VwcG9ydGVkIGJ5IHRo
aXMgZGV2aWNlCj4gICAgKgo+IC0gKiBSZXR1cm5zIGFuIGVycm9yIHdoZW4gZmFpbCB0byBhZGQg
dG8gdkRQQSBidXMKPiArICogUmV0dXJuOiBSZXR1cm5zIGFuIGVycm9yIHdoZW4gZmFpbCB0byBh
ZGQgdG8gdkRQQSBidXMKPiAgICAqLwo+ICAgaW50IHZkcGFfcmVnaXN0ZXJfZGV2aWNlKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgaW50IG52cXMpCj4gICB7Cj4gQEAgLTIxOCw3ICsyMTgsNyBA
QCBFWFBPUlRfU1lNQk9MX0dQTCh2ZHBhX3VucmVnaXN0ZXJfZGV2aWNlKTsKPiAgICAqIEBkcnY6
IHRoZSB2ZHBhIGRldmljZSBkcml2ZXIgdG8gYmUgcmVnaXN0ZXJlZAo+ICAgICogQG93bmVyOiBt
b2R1bGUgb3duZXIgb2YgdGhlIGRyaXZlcgo+ICAgICoKPiAtICogUmV0dXJucyBhbiBlcnIgd2hl
biBmYWlsIHRvIGRvIHRoZSByZWdpc3RyYXRpb24KPiArICogUmV0dXJuOiBSZXR1cm5zIGFuIGVy
ciB3aGVuIGZhaWwgdG8gZG8gdGhlIHJlZ2lzdHJhdGlvbgo+ICAgICovCj4gICBpbnQgX192ZHBh
X3JlZ2lzdGVyX2RyaXZlcihzdHJ1Y3QgdmRwYV9kcml2ZXIgKmRydiwgc3RydWN0IG1vZHVsZSAq
b3duZXIpCj4gICB7Cj4gQEAgLTI0NSw2ICsyNDUsOCBAQCBFWFBPUlRfU1lNQk9MX0dQTCh2ZHBh
X3VucmVnaXN0ZXJfZHJpdmVyKTsKPiAgICAqIEBtZGV2OiBQb2ludGVyIHRvIHZkcGEgbWFuYWdl
bWVudCBkZXZpY2UKPiAgICAqIHZkcGFfbWdtdGRldl9yZWdpc3RlcigpIHJlZ2lzdGVyIGEgdmRw
YSBtYW5hZ2VtZW50IGRldmljZSB3aGljaCBzdXBwb3J0cwo+ICAgICogdmRwYSBkZXZpY2UgbWFu
YWdlbWVudC4KPiArICogUmV0dXJuOiBSZXR1cm5zIDAgb24gc3VjY2VzcyBvciBmYWlsdXJlIHdo
ZW4gcmVxdWlyZWQgY2FsbGJhY2sgb3BzIGFyZSBub3QKPiArICogICAgICAgICBpbml0aWFsaXpl
ZC4KPiAgICAqLwo+ICAgaW50IHZkcGFfbWdtdGRldl9yZWdpc3RlcihzdHJ1Y3QgdmRwYV9tZ210
X2RldiAqbWRldikKPiAgIHsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

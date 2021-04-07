Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA12C433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:22:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AE66139B
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 07:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AE66139B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0CD5140402;
	Wed,  7 Apr 2021 07:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6SUDi9SlnoB; Wed,  7 Apr 2021 07:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92C56400BF;
	Wed,  7 Apr 2021 07:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59A66C000C;
	Wed,  7 Apr 2021 07:22:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 696C7C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5039E8496D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gXpVq97-rgq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:22:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E42D840CB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617780132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmO2L3fG8SlLFwxHfm4gC5hQ/GMe5NrEUAiLKwCv0qQ=;
 b=iqKl1VFhScXGAC/gQrwlTMN7M87H+61hnkWgD0BKu0wcVkHqmSFm0jR44iJexmPKTwgBnF
 ldhhrg1ygTrXa6oADiko93l0Qh4eFnPcmJD5ez1SgbyTkucZOZ0rD0DrpJ3KHHSOZfzu4c
 6jtdpsTDUalUcDN6JuccCfBuPLI9y1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-E7VmTDlfMX6TK0nvnoGEVA-1; Wed, 07 Apr 2021 03:22:10 -0400
X-MC-Unique: E7VmTDlfMX6TK0nvnoGEVA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FF978030B5;
 Wed,  7 Apr 2021 07:22:09 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-160.pek2.redhat.com
 [10.72.13.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9355C5D9CA;
 Wed,  7 Apr 2021 07:22:01 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 10/14] vdpa/mlx5: Support configuration of
 MAC
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20210406170457.98481-1-parav@nvidia.com>
 <20210406170457.98481-11-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <52ed98c3-0349-fc34-ea82-31cda5d0d370@redhat.com>
Date: Wed, 7 Apr 2021 15:21:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210406170457.98481-11-parav@nvidia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
ZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+IEFkZCBjb2RlIHRvIGFjY2VwdCBNQUMgY29uZmlndXJh
dGlvbiB0aHJvdWdoIHZkcGEgdG9vbC4gVGhlIE1BQyBpcwo+IHdyaXR0ZW4gaW50byB0aGUgY29u
ZmlnIHN0cnVjdCBhbmQgbGF0ZXIgY2FuIGJlIHJldHJpZXZlZCB0aHJvdWdoCj4gZ2V0X2NvbmZp
ZygpLgo+Cj4gRXhhbXBsZXM6Cj4gMS4gQ29uZmlndXJlIE1BQzoKPiAkIHZkcGEgZGV2IGNvbmZp
ZyBzZXQgdmRwYTAgbWFjIDAwOjExOjIyOjMzOjQ0OjU1Cj4KPiAyLiBTaG93IGNvbmZpZ3VyZWQg
cGFyYW1zOgo+ICQgdmRwYSBkZXYgY29uZmlnIHNob3cKPiB2ZHBhMDogbWFjIDAwOjExOjIyOjMz
OjQ0OjU1IGxpbmsgZG93biBsaW5rX2Fubm91bmNlIGZhbHNlIG10dSAwIHNwZWVkIDAgZHVwbGV4
IDAKPgo+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+IFJldmll
d2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gLS0tCj4gY2hhbmdlbG9n
Ogo+IHYxLT52MjoKPiAgIC0gZm9sbG93aW5nIG5ldyBhcGkgZm9yIGNvbmZpZyBnZXQvc2V0IGZv
ciBtZ210IHRvb2wKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8
IDQ1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0
NCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4gaW5kZXggYWFmN2Y5Mzk0YWYwLi45NDkwODRhYWMxMDIgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4gQEAgLTE0OTMsNyArMTQ5Myw4IEBAIHN0YXRpYyB1NjQgbWx4NV92
ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4gICAJbmRldi0+bXZk
ZXYubWx4X2ZlYXR1cmVzID0gbWx4X3RvX3ZyaXRpb19mZWF0dXJlcyhkZXZfZmVhdHVyZXMpOwo+
ICAgCWlmIChNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obXZkZXYtPm1kZXYsIHZpcnRpb192
ZXJzaW9uXzFfMCkpCj4gICAJCW5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyB8PSBCSVRfVUxMKFZJ
UlRJT19GX1ZFUlNJT05fMSk7Cj4gLQluZGV2LT5tdmRldi5tbHhfZmVhdHVyZXMgfD0gQklUX1VM
TChWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pOwo+ICsJbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVz
IHw9IEJJVF9VTEwoVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSB8Cj4gKwkJCQkgICAgIEJJVF9V
TEwoVklSVElPX05FVF9GX01BQyk7Cj4gICAJcHJpbnRfZmVhdHVyZXMobXZkZXYsIG5kZXYtPm12
ZGV2Lm1seF9mZWF0dXJlcywgZmFsc2UpOwo+ICAgCXJldHVybiBuZGV2LT5tdmRldi5tbHhfZmVh
dHVyZXM7Cj4gICB9Cj4gQEAgLTE1NjIsNiArMTU2MywxMSBAQCBzdGF0aWMgX192aXJ0aW8xNiBj
cHVfdG9fbWx4NXZkcGExNihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIHUxNiB2YWwpCj4g
ICAJcmV0dXJuIF9fY3B1X3RvX3ZpcnRpbzE2KG1seDVfdmRwYV9pc19saXR0bGVfZW5kaWFuKG12
ZGV2KSwgdmFsKTsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgaW5saW5lIHUxNiBtbHg1dmRwYTE2X3Rv
X2NwdShzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsIF9fdmlydGlvMTYgdmFsKQo+ICt7Cj4g
KwlyZXR1cm4gX192aXJ0aW8xNl90b19jcHUobWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4obXZk
ZXYpLCB2YWwpOwo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVz
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgewo+ICAgCXN0cnVj
dCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+IEBAIC0xODgwLDYgKzE4
ODYsNDEgQEAgc3RhdGljIGludCBtbHg1X2dldF92cV9pcnEoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHYsIHUxNiBpZHgpCj4gICAJcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICAgfQo+ICAgCj4gK3N0YXRp
YyBpbnQgbWx4NV92ZHBhX3NldF9jZV9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LAo+
ICsJCQkJICAgY29uc3Qgc3RydWN0IHZkcGFfZGV2X3NldF9jb25maWcgKmNvbmZpZykKPiArewo+
ICsJc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gdG9fbXZkZXYodmRldik7Cj4gKwlzdHJ1
Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiArCWlu
dCBlcnIgPSAwOwo+ICsKPiArCW11dGV4X2xvY2soJm5kZXYtPnJlc2xvY2spOwo+ICsJaWYgKG5k
ZXYtPnNldHVwKQo+ICsJCWVyciA9IC1FQlVTWTsKPiArCW11dGV4X3VubG9jaygmbmRldi0+cmVz
bG9jayk7Cj4gKwo+ICsJaWYgKGVycikKPiArCQlyZXR1cm4gZXJyOwo+ICsKPiArCWlmIChjb25m
aWctPm5ldF9tYXNrLm10dV92YWxpZCkKPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gKwo+ICsJ
aWYgKGNvbmZpZy0+bmV0X21hc2subWFjX3ZhbGlkKQo+ICsJCW1lbWNweShuZGV2LT5jb25maWcu
bWFjLCBjb25maWctPm5ldC5tYWMsIEVUSF9BTEVOKTsKCgpTbyBpdCBsb29rcyB0byBtZSB0aGlz
IGFzc3VtZXMgdGhhdCB0aGUgbWFjIGNhbiBub3QgYmUgY2hhbmdlZCBieSBndWVzdCAKYmVjYXVz
ZSB0aGUgZmlsdGVyIGlzIG9ubHkgcmUtcHJvZ3JhbW1lZCBkdXJpbmcgc2V0dGluZyBzdGF0dXMu
CgpBbnkgY2hhbmNlIHRvIHRyaWdnZXIgdGhlIGZpbHRlciBwcm9ncmFtbW1pbmcgaGVyZSB0byBh
b3ZpZCBmdXR1cmUgCmNoYW5nZXMgd2hlbiBWSVJUSU9fTkVUX0ZfQ1RSTF9NQUMgaXMgaW1wbGVt
ZW50ZWQ/CgpUaGFua3MKCgo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMgdm9p
ZCBtbHg1X3ZkcGFfZ2V0X2NlX2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsCj4gKwkJ
CQkgICAgc3RydWN0IHZkcGFfZGV2X2NvbmZpZyAqY29uZmlnKQo+ICt7Cj4gKwlzdHJ1Y3QgbWx4
NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiArCXN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+ICsKPiArCW1lbWNweShjb25m
aWctPm5ldC5tYWMsIG5kZXYtPmNvbmZpZy5tYWMsIEVUSF9BTEVOKTsKPiArCWNvbmZpZy0+bmV0
Lm10dSA9IG1seDV2ZHBhMTZfdG9fY3B1KG12ZGV2LCBuZGV2LT5jb25maWcubXR1KTsKPiArCWNv
bmZpZy0+bmV0LnN0YXR1cyA9IFZJUlRJT19ORVRfU19MSU5LX1VQOwo+ICt9Cj4gKwo+ICAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgbWx4NV92ZHBhX29wcyA9IHsKPiAgIAku
c2V0X3ZxX2FkZHJlc3MgPSBtbHg1X3ZkcGFfc2V0X3ZxX2FkZHJlc3MsCj4gICAJLnNldF92cV9u
dW0gPSBtbHg1X3ZkcGFfc2V0X3ZxX251bSwKPiBAQCAtMTkwMiw2ICsxOTQzLDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgbWx4NV92ZHBhX29wcyA9IHsKPiAgIAkuc2V0
X3N0YXR1cyA9IG1seDVfdmRwYV9zZXRfc3RhdHVzLAo+ICAgCS5nZXRfY29uZmlnID0gbWx4NV92
ZHBhX2dldF9jb25maWcsCj4gICAJLnNldF9jb25maWcgPSBtbHg1X3ZkcGFfc2V0X2NvbmZpZywK
PiArCS5nZXRfY2VfY29uZmlnID0gbWx4NV92ZHBhX2dldF9jZV9jb25maWcsCj4gKwkuc2V0X2Nl
X2NvbmZpZyA9IG1seDVfdmRwYV9zZXRfY2VfY29uZmlnLAo+ICAgCS5nZXRfZ2VuZXJhdGlvbiA9
IG1seDVfdmRwYV9nZXRfZ2VuZXJhdGlvbiwKPiAgIAkuc2V0X21hcCA9IG1seDVfdmRwYV9zZXRf
bWFwLAo+ICAgCS5mcmVlID0gbWx4NV92ZHBhX2ZyZWUsCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <SRS0=FRCo=EK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E1AC5517A
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 01:58:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC722245F
	for <virtualization@archiver.kernel.org>; Wed,  4 Nov 2020 01:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+EBIz1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC722245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DC5478732F;
	Wed,  4 Nov 2020 01:58:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tJKwCj0ivP9W; Wed,  4 Nov 2020 01:58:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E591F872FB;
	Wed,  4 Nov 2020 01:58:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAFF4C088B;
	Wed,  4 Nov 2020 01:58:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C68EC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 02557861E3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EcEz1aleKnxI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:58:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BAEB5861AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 01:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604455106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UAWX/l1lwuyu7yfRs5oPUEbyXJnB4GGE7rO3NI4ilQ=;
 b=N+EBIz1YlxvhhMWnPmuhL/nL25nDuidVCcCqcf7nIoatG/gQ1jahSYDsJTp1EaoTq9XS/w
 ZDqeFkwRi0HyKBiJF5qCagnD0/rpr0rrYzMp7EOrUo33wAz86KgGCdGq3+mgowfcSJ1jMD
 YmRGFEewcHdiWxavFs0rRhM4V1tO59c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-UaK9TAl2MnS_77rMomrX-g-1; Tue, 03 Nov 2020 20:58:22 -0500
X-MC-Unique: UaK9TAl2MnS_77rMomrX-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5457A8030C8;
 Wed,  4 Nov 2020 01:58:21 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C93895D9D3;
 Wed,  4 Nov 2020 01:58:11 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
To: si-wei liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1604043944-4897-1-git-send-email-si-wei.liu@oracle.com>
 <1604043944-4897-2-git-send-email-si-wei.liu@oracle.com>
 <42fe6ef3-90f6-ddb9-f206-e60c1e98c301@redhat.com>
 <5FA1FE87.4050909@oracle.com> <5FA1FF1B.1000303@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <328b6e09-7393-00d8-54d9-aac508b3016e@redhat.com>
Date: Wed, 4 Nov 2020 09:58:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5FA1FF1B.1000303@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com,
 linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTEvNCDkuIrljYg5OjA4LCBzaS13ZWkgbGl1IHdyb3RlOgo+Cj4gT24gMTEvMy8y
MDIwIDU6MDYgUE0sIHNpLXdlaSBsaXUgd3JvdGU6Cj4+Cj4+IE9uIDExLzMvMjAyMCA1OjAwIEFN
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjAvMTAvMzAg5LiL5Y2IMzo0NSwgU2kt
V2VpIExpdSB3cm90ZToKPj4+PiBQaW5uZWQgcGFnZXMgYXJlIG5vdCBwcm9wZXJseSBhY2NvdW50
ZWQgcGFydGljdWxhcmx5IHdoZW4KPj4+PiBtYXBwaW5nIGVycm9yIG9jY3VycyBvbiBJT1RMQiB1
cGRhdGUuIENsZWFuIHVwIGRhbmdsaW5nCj4+Pj4gcGlubmVkIHBhZ2VzIGZvciB0aGUgZXJyb3Ig
cGF0aC4KPj4+Pgo+Pj4+IFRoZSBtZW1vcnkgdXNhZ2UgZm9yIGJvb2trZWVwaW5nIHBpbm5lZCBw
YWdlcyBpcyByZXZlcnRlZAo+Pj4+IHRvIHdoYXQgaXQgd2FzIGJlZm9yZTogb25seSBvbmUgc2lu
Z2xlIGZyZWUgcGFnZSBpcyBuZWVkZWQuCj4+Pj4gVGhpcyBoZWxwcyByZWR1Y2UgdGhlIGhvc3Qg
bWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4+Pj4gYW1vdW50IG9mIG1lbW9yeSwg
b3IgaW4gdGhlIHNpdHVhdGlvbiB3aGVyZSBob3N0IGlzIHJ1bm5pbmcKPj4+PiBzaG9ydCBvZiBm
cmVlIG1lbW9yeS4KPj4+Pgo+Pj4+IEZpeGVzOiA0YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9k
dWNlIHZEUEEtYmFzZWQgYmFja2VuZCIpCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2ktV2VpIExpdSA8
c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+Pj4+IC0tLQo+Pj4+IMKgIGRyaXZlcnMvdmhvc3QvdmRw
YS5jIHwgNjQgCj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLQo+Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAxOCBk
ZWxldGlvbnMoLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBi
L2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+Pj4gaW5kZXggYjZkOTAxNi4uOGRhODU1OCAxMDA2NDQK
Pj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qv
dmRwYS5jCj4+Pj4gQEAgLTU2MCw2ICs1NjAsOCBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfbWFw
KHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4+IMKgwqDCoMKgwqDCoMKgIGlmIChyKQo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCB2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoZGV2LT5pb3RsYiwgaW92YSwg
aW92YSArIHNpemUgLSAxKTsKPj4+PiArwqDCoMKgIGVsc2UKPj4+PiArwqDCoMKgwqDCoMKgwqAg
YXRvbWljNjRfYWRkKHNpemUgPj4gUEFHRV9TSElGVCwgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4+
Pj4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+Pj4gwqAgfQo+Pj4+IEBAIC01OTEsMTQgKzU5
MywxNiBAQCBzdGF0aWMgaW50IAo+Pj4+IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUo
c3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+Pj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGxpc3Rf
c2l6ZSA9IFBBR0VfU0laRSAvIHNpemVvZihzdHJ1Y3QgcGFnZSAqKTsKPj4+PiDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludCBndXBfZmxhZ3MgPSBGT0xMX0xPTkdURVJNOwo+Pj4+IMKgwqDCoMKgwqAg
dW5zaWduZWQgbG9uZyBucGFnZXMsIGN1cl9iYXNlLCBtYXBfcGZuLCBsYXN0X3BmbiA9IDA7Cj4+
Pj4gLcKgwqDCoCB1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwgcGlubmVkLCBpOwo+
Pj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBsb2NrX2xpbWl0LCBzejJwaW4sIG5jaHVua3MsIGk7
Cj4+Pj4gwqDCoMKgwqDCoCB1NjQgaW92YSA9IG1zZy0+aW92YTsKPj4+PiArwqDCoMKgIGxvbmcg
cGlubmVkOwo+Pj4+IMKgwqDCoMKgwqAgaW50IHJldCA9IDA7Cj4+Pj4gwqDCoMKgwqDCoMKgwqAg
aWYgKHZob3N0X2lvdGxiX2l0cmVlX2ZpcnN0KGlvdGxiLCBtc2ctPmlvdmEsCj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zZy0+aW92YSArIG1zZy0+c2l6
ZSAtIDEpKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVFWElTVDsKPj4+PiDCoCAr
wqDCoMKgIC8qIExpbWl0IHRoZSB1c2Ugb2YgbWVtb3J5IGZvciBib29ra2VlcGluZyAqLwo+Pj4+
IMKgwqDCoMKgwqAgcGFnZV9saXN0ID0gKHN0cnVjdCBwYWdlICoqKSBfX2dldF9mcmVlX3BhZ2Uo
R0ZQX0tFUk5FTCk7Cj4+Pj4gwqDCoMKgwqDCoCBpZiAoIXBhZ2VfbGlzdCkKPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIC1FTk9NRU07Cj4+Pj4gQEAgLTYwNyw1MiArNjExLDY0IEBAIHN0
YXRpYyBpbnQgCj4+Pj4gdmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhv
c3RfdmRwYSAqdiwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ3VwX2ZsYWdzIHw9IEZPTExfV1JJ
VEU7Cj4+Pj4gwqDCoMKgwqDCoMKgwqAgbnBhZ2VzID0gUEFHRV9BTElHTihtc2ctPnNpemUgKyAo
aW92YSAmIH5QQUdFX01BU0spKSA+PiAKPj4+PiBQQUdFX1NISUZUOwo+Pj4+IC3CoMKgwqAgaWYg
KCFucGFnZXMpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4+ICvCoMKg
wqAgaWYgKCFucGFnZXMpIHsKPj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVJTlZBTDsKPj4+
PiArwqDCoMKgwqDCoMKgwqAgZ290byBmcmVlOwo+Pj4+ICvCoMKgwqAgfQo+Pj4+IMKgwqDCoMKg
wqDCoMKgIG1tYXBfcmVhZF9sb2NrKGRldi0+bW0pOwo+Pj4+IMKgIC3CoMKgwqAgbG9ja2VkID0g
YXRvbWljNjRfYWRkX3JldHVybihucGFnZXMsICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+Pj4+IMKg
wqDCoMKgwqAgbG9ja19saW1pdCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElG
VDsKPj4+PiAtCj4+Pj4gLcKgwqDCoCBpZiAobG9ja2VkID4gbG9ja19saW1pdCkgewo+Pj4+ICvC
oMKgwqAgaWYgKG5wYWdlcyArIGF0b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBs
b2NrX2xpbWl0KSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IC1FTk9NRU07Cj4+Pj4g
LcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIHVubG9j
azsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiDCoMKgwqDCoMKgwqDCoCBjdXJfYmFzZSA9IG1zZy0+
dWFkZHIgJiBQQUdFX01BU0s7Cj4+Pj4gwqDCoMKgwqDCoCBpb3ZhICY9IFBBR0VfTUFTSzsKPj4+
PiArwqDCoMKgIG5jaHVua3MgPSAwOwo+Pj4+IMKgwqDCoMKgwqDCoMKgIHdoaWxlIChucGFnZXMp
IHsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgcGlubmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBh
Z2VzLCBsaXN0X3NpemUpOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBwaW5fdXNlcl9wYWdl
cyhjdXJfYmFzZSwgcGlubmVkLAo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGd1cF9mbGFncywgcGFnZV9saXN0LCBOVUxMKTsKPj4+PiAtwqDCoMKgwqDCoMKg
wqAgaWYgKHJldCAhPSBwaW5uZWQpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN6MnBpbiA9IG1pbl90
KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAg
cGlubmVkID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHN6MnBpbiwKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3VwX2ZsYWdzLCBwYWdlX2xpc3QsIE5VTEwp
Owo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoc3oycGluICE9IHBpbm5lZCkgewo+Pj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChwaW5uZWQgPCAwKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXQgPSBwaW5uZWQ7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfSBlbHNlIHsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVucGluX3Vz
ZXJfcGFnZXMocGFnZV9saXN0LCBwaW5uZWQpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0ID0gLUVOT01FTTsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIH0KPj4+PiArwqDCoMKgwqDCoMKgwqAgbmNodW5rcysrOwo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFsYXN0X3BmbikKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
YXBfcGZuID0gcGFnZV90b19wZm4ocGFnZV9saXN0WzBdKTsKPj4+PiDCoCAtwqDCoMKgwqDCoMKg
wqAgZm9yIChpID0gMDsgaSA8IHJldDsgaSsrKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBwaW5uZWQ7IGkrKykgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVuc2lnbmVkIGxvbmcgdGhpc19wZm4gPSBwYWdlX3RvX3BmbihwYWdlX2xpc3RbaV0pOwo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHU2NCBjc2l6ZTsKPj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiAhPSBsYXN0X3BmbiAr
IDEpKSB7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBQaW4gYSBj
b250aWd1b3VzIGNodW5rIG9mIG1lbW9yeSAqLwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3NpemUgPSAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElG
VDsKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICh2aG9zdF92ZHBhX21h
cCh2LCBpb3ZhLCBjc2l6ZSwKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXNnLT5wZXJtKSkK
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHZob3N0X3ZkcGFfbWFw
KHYsIGlvdmEsIGNzaXplLAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXBfcGZuIDw8IFBBR0VfU0hJRlQsCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1zZy0+
cGVybSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+
PiArCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXBfcGZuID0gdGhp
c19wZm47Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb3ZhICs9IGNz
aXplOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmNodW5rcyA9IDA7Cj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBsYXN0X3BmbiA9IHRoaXNfcGZuOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9
Cj4+Pj4gwqAgLcKgwqDCoMKgwqDCoMKgIGN1cl9iYXNlICs9IHJldCA8PCBQQUdFX1NISUZUOwo+
Pj4+IC3CoMKgwqDCoMKgwqDCoCBucGFnZXMgLT0gcmV0Owo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBj
dXJfYmFzZSArPSBwaW5uZWQgPDwgUEFHRV9TSElGVDsKPj4+PiArwqDCoMKgwqDCoMKgwqAgbnBh
Z2VzIC09IHBpbm5lZDsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiDCoMKgwqDCoMKgwqDCoCAvKiBQ
aW4gdGhlIHJlc3QgY2h1bmsgKi8KPj4+PiBAQCAtNjYwLDEwICs2NzYsMjIgQEAgc3RhdGljIGlu
dCAKPj4+PiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVjdCB2aG9zdF92ZHBh
ICp2LAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtYXBfcGZuIDw8
IFBBR0VfU0hJRlQsIG1zZy0+cGVybSk7Cj4+Pj4gwqAgb3V0Ogo+Pj4+IMKgwqDCoMKgwqAgaWYg
KHJldCkgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAobmNodW5rcyAmJiBsYXN0X3Bmbikgewo+
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcGZuOwo+Pj4+ICsKPj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiBVbnBpbiB0aGUgb3V0c3RhbmRpbmcgcGFnZXMgd2hpY2ggYXJlIHVubWFwcGVkLgo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBNYXBwZWQgcGFnZXMgYXJlIGFjY291bnRlZCBp
biB2ZHBhX21hcCgpLCB0aHVzCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHdpbGwg
YmUgaGFuZGxlZCBieSB2ZHBhX3VubWFwKCkuCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqLwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAocGZuID0gbWFwX3BmbjsgcGZu
IDw9IGxhc3RfcGZuOyBwZm4rKykKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVucGluX3VzZXJfcGFnZShwZm5fdG9fcGFnZShwZm4pKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAg
fQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB2aG9zdF92ZHBhX3VubWFwKHYsIG1zZy0+aW92YSwg
bXNnLT5zaXplKTsKPj4+Cj4+Pgo+Pj4gSSB3YW50IHRvIGtub3cgd2hhdCdzIHdyb25nIHdpdGgg
Y3VycmVudCBjb2RlLgo+Pj4KPj4+IFdlIGNhbGwgdmhvc3RfdmRwYV91bm1hcCgpIG9uIGVycm9y
IHdoaWNoIGNhbGxzIAo+Pj4gdmhvc3RfdmRwYV9pb3RsYl91bm1hcCgpIHRoYXQgd2lsbCB1bnBp
biBhbmQgcmVkdWNlIHRoZSBwaW5uZWRfdm0uCj4+IFRoaW5rIGFib3V0IHRoZSBjYXNlIHdoZXJl
IHZob3N0X3ZkcGFfbWFwKCkgZmFpbHMgaW4gdGhlIG1pZGRsZSBhZnRlciAKPj4gbWFraW5nIGEg
ZmV3IHN1Y2Nlc3NmdWwgb25lcy4gSW4gdGhlIGN1cnJlbnQgY29kZSwgdGhlIAo+PiB2aG9zdF92
ZHBhX2lvdGxiX3VubWFwKCkgdW5waW5zIHdoYXQgaGFkIGJlZW4gbWFwcGVkLCBidXQgZG9lcyBu
b3QgCj4+IHVucGluIHRob3NlIHRoYXQgaGF2ZSBub3QgeWV0IGJlZW4gbWFwcGVkLiBUaGVzZSBv
dXRzdGFuZGluZyBwaW5uZWQgCj4+IHBhZ2VzIHdpbGwgYmUgbGVha2VkIGFmdGVyIGxlYXZpbmcg
dGhlIHZob3N0X3ZkcGFfbWFwKCkgZnVuY3Rpb24uCj4gVHlwbzogLi4uIGxlYXZpbmcgdGhlIHZo
b3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoKSBmdW5jdGlvbi4KPj4KPj4gQWxzbywgdGhl
IHN1YnRyYWN0aW9uIGFjY291bnRpbmcgYXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24gaXMgCj4+
IGluY29ycmVjdCBpbiB0aGF0IGNhc2U6IEBucGFnZXMgaXMgZGVkdWNlZCBieSBAcGlubmVkIGlu
IGVhY2ggCj4+IGl0ZXJhdGlvbi4gVGhhdCdzIHdoeSBJIG1vdmVkIHRoZSBhY2NvdW50aW5nIHRv
IHZob3N0X3ZkcGFfbWFwKCkgdG8gCj4+IGJlIHN5bW1ldHJpYyB3aXRoIHZob3N0X3ZkcGFfdW5t
YXAoKS4KPj4KCkkgc2VlLCB0aGVuIEkgd29uZGVyIGlmIGl0IHdvdWxkIGhhdmUgbW9yZSBlYXN5
IHRvIHJlYWQgY29kZSBpZiB3ZSBkbyAKKHVuKXBpbm5pbmcvYWNjb3V0aW5nIG9ubHkgaW4gdmhv
c3RfdmRwYV9tYXAoKS92aG9zdF92ZHBhX3VubWFwKCk/CgpUaGFua3MKCgo+Pgo+PiAtU2l3ZWkK
Pj4+Cj4+PiBUaGFua3MKPj4+Cj4+Pgo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBhdG9taWM2NF9zdWIo
bnBhZ2VzLCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPj4+PiDCoMKgwqDCoMKgIH0KPj4+PiArdW5s
b2NrOgo+Pj4+IMKgwqDCoMKgwqAgbW1hcF9yZWFkX3VubG9jayhkZXYtPm1tKTsKPj4+PiArZnJl
ZToKPj4+PiDCoMKgwqDCoMKgIGZyZWVfcGFnZSgodW5zaWduZWQgbG9uZylwYWdlX2xpc3QpOwo+
Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+PiDCoCB9Cj4+Pgo+Pgo+CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWls
aW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRp
b24=

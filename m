Return-Path: <SRS0=WAh4=EZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF1AC2D0E4
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 06:16:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D032469D
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 06:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZbDS/WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D032469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8B47F233B0;
	Thu, 19 Nov 2020 06:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjsxPA6ALZpd; Thu, 19 Nov 2020 06:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EB04C204DE;
	Thu, 19 Nov 2020 06:16:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 821FAC0891;
	Thu, 19 Nov 2020 06:16:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 779D0C07FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 06:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5DB2587373
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 06:16:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aCm2qo7bKYS2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 06:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8B1E687372
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605766587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlkXr7s48FDSqN7LK4mEk+UbmSZsrG7b5ixjGj4X+PA=;
 b=cZbDS/WPt4DCjEee5cpXt0xMlAkKdhj1sFJNhnrYMFIccwz0PrkBRbSuhnuYZ6MFYtVzvv
 kbosh+fTj1/Z598CNMdudRcfEKZRGooyihbkvzljttM2MJpEVnEdNFyZi/9TtlVB6JKXXr
 VgUsF+Dx6X9JOyJQ4z2VQaTec0N72l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-gBdEjmyPNSyEQT-EZNqE8w-1; Thu, 19 Nov 2020 01:16:23 -0500
X-MC-Unique: gBdEjmyPNSyEQT-EZNqE8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 432AD80EDA8;
 Thu, 19 Nov 2020 06:16:22 +0000 (UTC)
Received: from [10.72.13.63] (ovpn-13-63.pek2.redhat.com [10.72.13.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D46CC19728;
 Thu, 19 Nov 2020 06:16:07 +0000 (UTC)
Subject: Re: [PATCH RFC 02/12] vdpa: split vdpasim to core and net modules
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-3-sgarzare@redhat.com>
 <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
 <20201118131408.4denectqx3bvcmxq@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8d941b5d-f691-226c-b31f-c92c45fa0d2a@redhat.com>
Date: Thu, 19 Nov 2020 14:16:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118131408.4denectqx3bvcmxq@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMTgg5LiL5Y2IOToxNCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+IEhp
IEphc29uLAo+IEkganVzdCBkaXNjb3ZlcmVkIHRoYXQgSSBtaXNzZWQgdGhlIG90aGVyIHF1ZXN0
aW9ucyBpbiB0aGlzIGVtYWlsLAo+IHNvcnJ5IGZvciB0aGF0IQoKCk5vIHByb2JsZW0gOikKCgo+
Cj4gT24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MDA6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4KPj4gT24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6Cj4+PiBGcm9tOiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+Pj4K
Pj4+IEludHJvZHVjZSBuZXcgdmRwYV9zaW1fbmV0IGFuZCB2ZHBhX3NpbSAoY29yZSkgZHJpdmVy
cy4gVGhpcyBpcyBhCj4+PiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIGEgdmRwYSBzaW11bGF0b3Ig
bW9kdWxlIGZvciBibG9jayBkZXZpY2VzLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0
b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+Cj4+PiBbc2dhcnphcmU6IHZhcmlvdXMgY2xlYW51
cHMvZml4ZXNdCj4+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJl
QHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+IHYxOgo+Pj4gLSBSZW1vdmVkIHVudXNlZCBoZWFkZXJz
Cj4+PiAtIFJlbW92ZWQgZW1wdHkgbW9kdWxlX2luaXQoKSBtb2R1bGVfZXhpdCgpCj4+PiAtIE1v
dmVkIHZkcGFzaW1faXNfbGl0dGxlX2VuZGlhbigpIGluIHZkcGFfc2ltLmgKPj4+IC0gTW92ZWQg
dmRwYXNpbTE2X3RvX2NwdS9jcHVfdG9fdmRwYXNpbTE2KCkgaW4gdmRwYV9zaW0uaAo+Pj4gLSBB
ZGRlZCB2ZHBhc2ltKl90b19jcHUvY3B1X3RvX3ZkcGFzaW0qKCkgYWxzbyBmb3IgMzIgYW5kIDY0
Cj4+PiAtIFJlcGxhY2VkICdzZWxlY3QgVkRQQV9TSU0nIHdpdGggJ2RlcGVuZHMgb24gVkRQQV9T
SU0nIHNpbmNlIHNlbGVjdGVkCj4+PiDCoCBvcHRpb24gY2FuIG5vdCBkZXBlbmQgb24gb3RoZXIg
W0phc29uXQo+Pgo+Pgo+PiBJZiBwb3NzaWJsZSwgSSB3b3VsZCBzdWdnZXN0IHRvIHNwbGl0IHRo
aXMgcGF0Y2ggZnVydGhlcjoKPj4KPj4gMSkgY29udmVydCB0byB1c2Ugdm9pZCAqY29uZmlnLCBh
bmQgYW4gYXR0cmlidXRlIGZvciBzZXR0aW5nIGNvbmZpZyAKPj4gc2l6ZSBkdXJpbmcgYWxsb2Nh
dGlvbgo+PiAyKSBpbnRyb2R1Y2Ugc3VwcG9ydGVkX2ZlYXR1cmVzCj4+IDMpIG90aGVyIGF0dHJp
YnV0ZXMgKCN2cXMpCj4+IDQpIHJlbmFtZSBjb25maWcgb3BzIChtb3JlIGdlbmVyaWMgb25lKQo+
PiA1KSBpbnRyb2R1Y2Ugb3BzIGZvciBzZXR8Z2V0X2NvbmZpZywgc2V0X2dldF9mZWF0dXJlcwo+
PiA2KSByZWFsIHNwbGl0Cj4+Cj4+Cj4KPiBbLi4uXQo+Cj4+PiAtc3RhdGljIGNvbnN0IHN0cnVj
dCB2ZHBhX2NvbmZpZ19vcHMgdmRwYXNpbV9uZXRfY29uZmlnX29wczsKPj4+IC1zdGF0aWMgY29u
c3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX25ldF9iYXRjaF9jb25maWdfb3BzOwo+
Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fY29uZmlnX29w
czsKPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyB2ZHBhc2ltX2JhdGNo
X2NvbmZpZ19vcHM7Cj4+PiAtc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZSh2
b2lkKQo+Pj4gK3N0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZShzdHJ1Y3QgdmRwYXNpbV9p
bml0X2F0dHIgKmF0dHIpCj4+PiDCoHsKPj4+IMKgwqDCoMKgIGNvbnN0IHN0cnVjdCB2ZHBhX2Nv
bmZpZ19vcHMgKm9wczsKPj4+IMKgwqDCoMKgIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltOwo+Pj4g
K8KgwqDCoCB1MzIgZGV2aWNlX2lkOwo+Pj4gwqDCoMKgwqAgc3RydWN0IGRldmljZSAqZGV2Owo+
Pj4gLcKgwqDCoCBpbnQgcmV0ID0gLUVOT01FTTsKPj4+ICvCoMKgwqAgaW50IGksIHNpemUsIHJl
dCA9IC1FTk9NRU07Cj4+PiAtwqDCoMKgIGlmIChiYXRjaF9tYXBwaW5nKQo+Pj4gLcKgwqDCoMKg
wqDCoMKgIG9wcyA9ICZ2ZHBhc2ltX25ldF9iYXRjaF9jb25maWdfb3BzOwo+Pj4gK8KgwqDCoCBk
ZXZpY2VfaWQgPSBhdHRyLT5kZXZpY2VfaWQ7Cj4+PiArwqDCoMKgIC8qIEN1cnJlbnRseSwgd2Ug
b25seSBhY2NlcHQgdGhlIG5ldHdvcmsgYW5kIGJsb2NrIGRldmljZXMuICovCj4+PiArwqDCoMKg
IGlmIChkZXZpY2VfaWQgIT0gVklSVElPX0lEX05FVCAmJiBkZXZpY2VfaWQgIT0gVklSVElPX0lE
X0JMT0NLKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1FT1BOT1RTVVBQKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgaWYgKGF0dHItPmJhdGNoX21hcHBpbmcpCj4+PiArwqDCoMKgwqDC
oMKgwqAgb3BzID0gJnZkcGFzaW1fYmF0Y2hfY29uZmlnX29wczsKPj4+IMKgwqDCoMKgIGVsc2UK
Pj4+IC3CoMKgwqDCoMKgwqDCoCBvcHMgPSAmdmRwYXNpbV9uZXRfY29uZmlnX29wczsKPj4+ICvC
oMKgwqDCoMKgwqDCoCBvcHMgPSAmdmRwYXNpbV9jb25maWdfb3BzOwo+Pj4gwqDCoMKgwqAgdmRw
YXNpbSA9IHZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCB2ZHBhc2ltLCB2ZHBhLCBOVUxMLCBvcHMs
IAo+Pj4gVkRQQVNJTV9WUV9OVU0pOwo+Pj4gwqDCoMKgwqAgaWYgKCF2ZHBhc2ltKQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGVycl9hbGxvYzsKPj4+IC3CoMKgwqAgSU5JVF9XT1JLKCZ2ZHBh
c2ltLT53b3JrLCB2ZHBhc2ltX3dvcmspOwo+Pj4gK8KgwqDCoCBpZiAoZGV2aWNlX2lkID09IFZJ
UlRJT19JRF9ORVQpCj4+PiArwqDCoMKgwqDCoMKgwqAgc2l6ZSA9IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcpOwo+Pj4gK8KgwqDCoCBlbHNlCj4+PiArwqDCoMKgwqDCoMKgwqAgc2l6
ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX2Jsa19jb25maWcpOwo+Pgo+Pgo+PiBJdCdzIGJldHRl
ciB0byBhdm9pZCBzdWNoIGlmL2Vsc2UgY29uc2lkZXIgd2UgbWF5IGludHJvZHVjZSBtb3JlIHR5
cGUgCj4+IG9mIGRldmljZXMuCj4+Cj4+IENhbiB3ZSBoYXZlIGFuIGF0dHJpYnV0ZSBvZiBjb25m
aWcgc2l6ZSBpbnN0ZWFkPwo+Cj4gWWVzLCBJJ2xsIG1vdmUgdGhlIHBhdGNoIDcgYmVmb3JlIHRo
aXMuCj4KPiBBYm91dCBjb25maWcgc2l6ZSBhbmQgc2V0L2dldF9jb25maWcgb3BzLCBJJ20gbm90
IHN1cmUgaWYgaXQgaXMgYmV0dGVyIAo+IHRvIGhpZGRlbiBldmVyeXRoaW5nIHVuZGVyIHRoZSBu
ZXcgc2V0L2dldF9jb25maWcgb3BzLCBhbGxvY2F0aW5nIHRoZSAKPiBjb25maWcgc3RydWN0dXJl
IGluIGVhY2ggZGV2aWNlLCBvciBsZWF2ZSB0aGUgYWxsb2NhdGlvbiBpbiB0aGUgY29yZSAKPiBh
bmQgdXBkYXRlIGl0IGxpa2Ugbm93LgoKCkkgdGhpbmsgd2UnZCBiZXR0ZXIgdG8gYXZvaWQgaGF2
aW5nIGFueSB0eXBlIHNwZWNpZmljIGNvZGVzIGluIGdlbmVyaWMgCnNpbSBjb2Rlcy4KCgpbLi4u
XQoKCj4+PiArY29uZmlnIFZEUEFfU0lNX05FVAo+Pj4gK8KgwqDCoCB0cmlzdGF0ZSAidkRQQSBz
aW11bGF0b3IgZm9yIG5ldHdvcmtpbmcgZGV2aWNlIgo+Pj4gK8KgwqDCoCBkZXBlbmRzIG9uIFZE
UEFfU0lNCj4+PiArwqDCoMKgIGRlZmF1bHQgbgo+Pgo+Pgo+PiBJIHJlbWVtYmVyIHNvbWVib2R5
IHRvbGQgbWUgdGhhdCBpZiB3ZSBkb24ndCBlbmFibGUgYSBtb2R1bGUgaXQgd2FzIAo+PiBkaXNh
YmxlZCBieSBkZWZhdWx0Lgo+Cj4gU28sIHNob3VsZCBJIHJlbW92ZSAiZGVmYXVsdCBuIiBmcm9t
IHZkcGFfc2ltKiBlbnRyaWVzPwoKClllcywgYnV0IHBsZWFzZSBkbyB0aGF0IGluIGFub3RoZXIg
cGF0Y2guCgpUaGFua3MKCgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <SRS0=p0Ab=DK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C07C4363C
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 01:51:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C33A206CA
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 01:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4K+52HD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C33A206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 222A18612E;
	Sat,  3 Oct 2020 01:51:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yp7XbhSPSDU; Sat,  3 Oct 2020 01:51:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A581860FC;
	Sat,  3 Oct 2020 01:51:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC0BC0889;
	Sat,  3 Oct 2020 01:51:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9B18C0051
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE23E8733B
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:51:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6I7COon8t3iY
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E0EBC8731F
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601689906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Okln2Ce1dgJBE2STQ2+G5bbJ8bSdiX6gXYLv/23VM+w=;
 b=Z4K+52HD2ti21DWZVqdhhMg3HAv8QBVyDCkMwATsGznU8gRmRZ8XYWDOEtk98OUDpxSRhY
 VJiZpkiAabiDnkNnt/K/72bKpEiWNymUclkswjk65fFQbSB4pMyEnP5oOjP8EZhQRntuMC
 uKTSdYUk4dthnAM3mAQqZRcnsnrA1uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-zBLUNamSNNWStPKaKi7Jtg-1; Fri, 02 Oct 2020 21:51:42 -0400
X-MC-Unique: zBLUNamSNNWStPKaKi7Jtg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E64803F5C;
 Sat,  3 Oct 2020 01:51:41 +0000 (UTC)
Received: from [10.72.12.21] (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44D7F5D9D3;
 Sat,  3 Oct 2020 01:51:34 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] vhost: Don't call access_ok() when using IOTLB
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
 <160139703153.162128.16860679176471296230.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <21349052-fefc-4437-4233-f803caceeb38@redhat.com>
Date: Sat, 3 Oct 2020 09:51:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160139703153.162128.16860679176471296230.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
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

Ck9uIDIwMjAvOS8zMCDkuIrljYgxMjozMCwgR3JlZyBLdXJ6IHdyb3RlOgo+IFdoZW4gdGhlIElP
VExCIGRldmljZSBpcyBlbmFibGVkLCB0aGUgdnJpbmcgYWRkcmVzc2VzIHdlIGdldAo+IGZyb20g
dXNlcnNwYWNlIGFyZSBHSU9WQXMuIEl0IGlzIHRodXMgd3JvbmcgdG8gcGFzcyB0aGVtIGRvd24K
PiB0byBhY2Nlc3Nfb2soKSB3aGljaCBvbmx5IHRha2VzIEhWQXMuCj4KPiBBY2Nlc3MgdmFsaWRh
dGlvbiBpcyBkb25lIGF0IHByZWZldGNoIHRpbWUgd2l0aCBJT1RMQi4gVGVhY2gKPiB2cV9hY2Nl
c3Nfb2soKSBhYm91dCB0aGF0IGJ5IG1vdmluZyB0aGUgKHZxLT5pb3RsYikgY2hlY2sKPiBmcm9t
IHZob3N0X3ZxX2FjY2Vzc19vaygpIHRvIHZxX2FjY2Vzc19vaygpLiBUaGlzIHByZXZlbnRzCj4g
dmhvc3RfdnJpbmdfc2V0X2FkZHIoKSB0byBmYWlsIHdoZW4gdmVyaWZ5aW5nIHRoZSBhY2Nlc3Nl
cy4KPiBObyBiZWhhdmlvciBjaGFuZ2UgZm9yIHZob3N0X3ZxX2FjY2Vzc19vaygpLgo+Cj4gQnVn
TGluazogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xODgzMDg0
Cj4gRml4ZXM6IDZiMWU2Y2M3ODU1YiAoInZob3N0OiBuZXcgZGV2aWNlIElPVExCIEFQSSIpCj4g
Q2M6IGphc293YW5nQHJlZGhhdC5jb20KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDQu
MTQrCj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLdXJ6IDxncm91Z0BrYW9kLm9yZz4KPiAtLS0KPiAg
IGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8ICAgIDkgKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IGI0NTUxOWNh
NjZhNy4uYzNiNDk5NzVkYzI4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+
ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC0xMjkwLDYgKzEyOTAsMTEgQEAgc3Rh
dGljIGJvb2wgdnFfYWNjZXNzX29rKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLCB1bnNpZ25l
ZCBpbnQgbnVtLAo+ICAgCQkJIHZyaW5nX3VzZWRfdCBfX3VzZXIgKnVzZWQpCj4gICAKPiAgIHsK
PiArCS8qIElmIGFuIElPVExCIGRldmljZSBpcyBwcmVzZW50LCB0aGUgdnJpbmcgYWRkcmVzc2Vz
IGFyZQo+ICsJICogR0lPVkFzLiBBY2Nlc3MgdmFsaWRhdGlvbiBvY2N1cnMgYXQgcHJlZmV0Y2gg
dGltZS4gKi8KPiArCWlmICh2cS0+aW90bGIpCj4gKwkJcmV0dXJuIHRydWU7Cj4gKwo+ICAgCXJl
dHVybiBhY2Nlc3Nfb2soZGVzYywgdmhvc3RfZ2V0X2Rlc2Nfc2l6ZSh2cSwgbnVtKSkgJiYKPiAg
IAkgICAgICAgYWNjZXNzX29rKGF2YWlsLCB2aG9zdF9nZXRfYXZhaWxfc2l6ZSh2cSwgbnVtKSkg
JiYKPiAgIAkgICAgICAgYWNjZXNzX29rKHVzZWQsIHZob3N0X2dldF91c2VkX3NpemUodnEsIG51
bSkpOwo+IEBAIC0xMzgzLDEwICsxMzg4LDYgQEAgYm9vbCB2aG9zdF92cV9hY2Nlc3Nfb2soc3Ry
dWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4gICAJaWYgKCF2cV9sb2dfYWNjZXNzX29rKHZxLCB2
cS0+bG9nX2Jhc2UpKQo+ICAgCQlyZXR1cm4gZmFsc2U7Cj4gICAKPiAtCS8qIEFjY2VzcyB2YWxp
ZGF0aW9uIG9jY3VycyBhdCBwcmVmZXRjaCB0aW1lIHdpdGggSU9UTEIgKi8KPiAtCWlmICh2cS0+
aW90bGIpCj4gLQkJcmV0dXJuIHRydWU7Cj4gLQo+ICAgCXJldHVybiB2cV9hY2Nlc3Nfb2sodnEs
IHZxLT5udW0sIHZxLT5kZXNjLCB2cS0+YXZhaWwsIHZxLT51c2VkKTsKPiAgIH0KPiAgIEVYUE9S
VF9TWU1CT0xfR1BMKHZob3N0X3ZxX2FjY2Vzc19vayk7Cj4KCkFja2VkLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

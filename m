Return-Path: <SRS0=p0Ab=DK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B31C4363C
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 01:59:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8425220719
	for <virtualization@archiver.kernel.org>; Sat,  3 Oct 2020 01:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8kRsPg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8425220719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2B1F220417;
	Sat,  3 Oct 2020 01:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Eq9vokT7527; Sat,  3 Oct 2020 01:59:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6041B2014B;
	Sat,  3 Oct 2020 01:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4095BC0889;
	Sat,  3 Oct 2020 01:59:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77B9BC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5FA2286A25
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:59:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ZzKqAnZNPNf
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:59:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 54EDF86A0C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Oct 2020 01:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601690352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeOAtvvMPwaNHz/wYRORgCGMK3Ts1ggRda1sMGxGQFA=;
 b=V8kRsPg73mY1aqPTpDBNpne+w39tFhduFJHfFgXNot4K0HeIbJMSkXzY9C7HASfBjATxky
 kd2zArMfpU0lxSwHWQHum36FgTWSW5HwA2O43dXoG63Qf5gpBiRTPiYui9WdztAHnK5lm2
 k3XKZ/sQ/JOVM6DqXUZHOu88pPmbGvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-1nU4H7_uOzuVqsTeKAiepQ-1; Fri, 02 Oct 2020 21:59:08 -0400
X-MC-Unique: 1nU4H7_uOzuVqsTeKAiepQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5F4E107464A;
 Sat,  3 Oct 2020 01:59:06 +0000 (UTC)
Received: from [10.72.12.21] (ovpn-12-21.pek2.redhat.com [10.72.12.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3FDA5577C;
 Sat,  3 Oct 2020 01:59:00 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] vhost: Don't call log_access_ok() when using IOTLB
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
 <160139704424.162128.7839027287942194310.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d9dae1ed-49a4-909a-6840-ae46a4ffdffc@redhat.com>
Date: Sat, 3 Oct 2020 09:58:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160139704424.162128.7839027287942194310.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
VExCIGRldmljZSBpcyBlbmFibGVkLCB0aGUgbG9nX2d1ZXN0X2FkZHIgdGhhdCBpcyBwYXNzZWQg
YnkKPiB1c2Vyc3BhY2UgdG8gdGhlIFZIT1NUX1NFVF9WUklOR19BRERSIGlvY3RsLCBhbmQgd2hp
Y2ggaXMgdGhlbiB3cml0dGVuCj4gdG8gdnEtPmxvZ19hZGRyLCBpcyBhIEdJT1ZBLiBBbGwgd3Jp
dGVzIHRvIHRoaXMgYWRkcmVzcyBhcmUgdHJhbnNsYXRlZAo+IGJ5IGxvZ191c2VyKCkgdG8gd3Jp
dGVzIHRvIGFuIEhWQSwgYW5kIHRoZW4gdWx0aW1hdGVseSBsb2dnZWQgdGhyb3VnaAo+IHRoZSBj
b3JyZXNwb25kaW5nIEdQQXMgaW4gbG9nX3dyaXRlX2h2YSgpLiBObyBsb2dnaW5nIHdpbGwgZXZl
ciBvY2N1cgo+IHdpdGggdnEtPmxvZ19hZGRyIGluIHRoaXMgY2FzZS4gSXQgaXMgdGh1cyB3cm9u
ZyB0byBwYXNzIHZxLT5sb2dfYWRkcgo+IGFuZCBsb2dfZ3Vlc3RfYWRkciB0byBsb2dfYWNjZXNz
X3ZxKCkgd2hpY2ggYXNzdW1lcyB0aGV5IGFyZSBhY3R1YWwKPiBHUEFzLgo+Cj4gSW50cm9kdWNl
IGEgbmV3IHZxX2xvZ191c2VkX2FjY2Vzc19vaygpIGhlbHBlciB0aGF0IG9ubHkgY2hlY2tzIGFj
Y2Vzc2VzCj4gdG8gdGhlIGxvZyBmb3IgdGhlIHVzZWQgc3RydWN0dXJlIHdoZW4gdGhlcmUgaXNu
J3QgYW4gSU9UTEIgZGV2aWNlIGFyb3VuZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3VyeiA8
Z3JvdWdAa2FvZC5vcmc+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAgIDIzICsr
KysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMg
Yi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCBjM2I0OTk3NWRjMjguLjU5OTZlMzJmYTgx
OCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJzL3Zo
b3N0L3Zob3N0LmMKPiBAQCAtMTM3MCw2ICsxMzcwLDIwIEBAIGJvb2wgdmhvc3RfbG9nX2FjY2Vz
c19vayhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2
aG9zdF9sb2dfYWNjZXNzX29rKTsKPiAgIAo+ICtzdGF0aWMgYm9vbCB2cV9sb2dfdXNlZF9hY2Nl
c3Nfb2soc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkgIHZvaWQgX191c2VyICps
b2dfYmFzZSwKPiArCQkJCSAgYm9vbCBsb2dfdXNlZCwKPiArCQkJCSAgdTY0IGxvZ19hZGRyLAo+
ICsJCQkJICBzaXplX3QgbG9nX3NpemUpCj4gK3sKPiArCS8qIElmIGFuIElPVExCIGRldmljZSBp
cyBwcmVzZW50LCBsb2dfYWRkciBpcyBhIEdJT1ZBIHRoYXQKPiArCSAqIHdpbGwgbmV2ZXIgYmUg
bG9nZ2VkIGJ5IGxvZ191c2VkKCkuICovCj4gKwlpZiAodnEtPmlvdGxiKQo+ICsJCXJldHVybiB0
cnVlOwo+ICsKPiArCXJldHVybiAhbG9nX3VzZWQgfHwgbG9nX2FjY2Vzc19vayhsb2dfYmFzZSwg
bG9nX2FkZHIsIGxvZ19zaXplKTsKPiArfQo+ICsKPiAgIC8qIFZlcmlmeSBhY2Nlc3MgZm9yIHdy
aXRlIGxvZ2dpbmcuICovCj4gICAvKiBDYWxsZXIgc2hvdWxkIGhhdmUgdnEgbXV0ZXggYW5kIGRl
dmljZSBtdXRleCAqLwo+ICAgc3RhdGljIGJvb2wgdnFfbG9nX2FjY2Vzc19vayhzdHJ1Y3Qgdmhv
c3RfdmlydHF1ZXVlICp2cSwKPiBAQCAtMTM3Nyw4ICsxMzkxLDggQEAgc3RhdGljIGJvb2wgdnFf
bG9nX2FjY2Vzc19vayhzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSwKPiAgIHsKPiAgIAlyZXR1
cm4gdnFfbWVtb3J5X2FjY2Vzc19vayhsb2dfYmFzZSwgdnEtPnVtZW0sCj4gICAJCQkJICAgdmhv
c3RfaGFzX2ZlYXR1cmUodnEsIFZIT1NUX0ZfTE9HX0FMTCkpICYmCj4gLQkJKCF2cS0+bG9nX3Vz
ZWQgfHwgbG9nX2FjY2Vzc19vayhsb2dfYmFzZSwgdnEtPmxvZ19hZGRyLAo+IC0JCQkJICB2aG9z
dF9nZXRfdXNlZF9zaXplKHZxLCB2cS0+bnVtKSkpOwo+ICsJCXZxX2xvZ191c2VkX2FjY2Vzc19v
ayh2cSwgbG9nX2Jhc2UsIHZxLT5sb2dfdXNlZCwgdnEtPmxvZ19hZGRyLAo+ICsJCQkJICAgICAg
dmhvc3RfZ2V0X3VzZWRfc2l6ZSh2cSwgdnEtPm51bSkpOwo+ICAgfQo+ICAgCj4gICAvKiBDYW4g
d2Ugc3RhcnQgdnE/ICovCj4gQEAgLTE1MTcsOCArMTUzMSw5IEBAIHN0YXRpYyBsb25nIHZob3N0
X3ZyaW5nX3NldF9hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmQsCj4gICAJCQlyZXR1cm4gLUVJTlZB
TDsKPiAgIAo+ICAgCQkvKiBBbHNvIHZhbGlkYXRlIGxvZyBhY2Nlc3MgZm9yIHVzZWQgcmluZyBp
ZiBlbmFibGVkLiAqLwo+IC0JCWlmICgoYS5mbGFncyAmICgweDEgPDwgVkhPU1RfVlJJTkdfRl9M
T0cpKSAmJgo+IC0JCQkhbG9nX2FjY2Vzc19vayh2cS0+bG9nX2Jhc2UsIGEubG9nX2d1ZXN0X2Fk
ZHIsCj4gKwkJaWYgKCF2cV9sb2dfdXNlZF9hY2Nlc3Nfb2sodnEsIHZxLT5sb2dfYmFzZSwKPiAr
CQkJCWEuZmxhZ3MgJiAoMHgxIDw8IFZIT1NUX1ZSSU5HX0ZfTE9HKSwKPiArCQkJCWEubG9nX2d1
ZXN0X2FkZHIsCj4gICAJCQkJc2l6ZW9mICp2cS0+dXNlZCArCj4gICAJCQkJdnEtPm51bSAqIHNp
emVvZiAqdnEtPnVzZWQtPnJpbmcpKQoKCkl0IGxvb2tzIHRvIG1lIHRoYXQgd2Ugc2hvdWxkIHVz
ZSB2aG9zdF9nZXRfdXNlZF9zaXplKCkgd2hpY2ggdGFrZXMgCmV2ZW50IGludG8gYWNjb3VudC4K
CkFueSByZWFzb24gdGhhdCB3ZSBjYW4ndCByZXVzZSB2cV9sb2dfYWNjZXNzX29rKCkgaGVyZT8K
ClRoYW5rcwoKCj4gICAJCQlyZXR1cm4gLUVJTlZBTDsKPgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E908C433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 03:01:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9904821D43
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 03:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RehQvm7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9904821D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4051D87669;
	Sat, 10 Oct 2020 03:01:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zYK0YmSdLIGk; Sat, 10 Oct 2020 03:01:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B17F877CE;
	Sat, 10 Oct 2020 03:01:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DA63C016F;
	Sat, 10 Oct 2020 03:01:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2146DC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 03:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 073BB877CE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 03:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id weUPkcxkWt8O
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 03:01:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E064987669
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 03:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602298869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coiDnr2j0+5r/bVcK9iEriuCq6hzJi0eXfVrwQbFAj4=;
 b=RehQvm7DtKb3YjMSSVsvsMJsvUdwEDDF7vO4WASRWO5N283VJNatcHlrpd2cs+3k1//6w9
 EJWPkZxzOQ/qK+guGHU08+0VaidE364HiWpmhj1zhxU6IHCZGaE+Z9zCEBEZQSdyLdCALc
 Q9bKXoAVYvqaMoQo7H3+eZzkTSlz5As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-PEzBcXldPL-FrrO4e73PHQ-1; Fri, 09 Oct 2020 23:01:05 -0400
X-MC-Unique: PEzBcXldPL-FrrO4e73PHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7599805F05;
 Sat, 10 Oct 2020 03:01:03 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92E425D9FC;
 Sat, 10 Oct 2020 03:00:56 +0000 (UTC)
Subject: Re: [PATCH v3 3/3] vhost: Don't call log_access_ok() when using IOTLB
To: Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <160171888144.284610.4628526949393013039.stgit@bahia.lan>
 <160171933385.284610.10189082586063280867.stgit@bahia.lan>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7c512087-639f-0b08-5d8d-6942528d2e06@redhat.com>
Date: Sat, 10 Oct 2020 11:00:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160171933385.284610.10189082586063280867.stgit@bahia.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
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

Ck9uIDIwMjAvMTAvMyDkuIvljYg2OjAyLCBHcmVnIEt1cnogd3JvdGU6Cj4gV2hlbiB0aGUgSU9U
TEIgZGV2aWNlIGlzIGVuYWJsZWQsIHRoZSBsb2dfZ3Vlc3RfYWRkciB0aGF0IGlzIHBhc3NlZCBi
eQo+IHVzZXJzcGFjZSB0byB0aGUgVkhPU1RfU0VUX1ZSSU5HX0FERFIgaW9jdGwsIGFuZCB3aGlj
aCBpcyB0aGVuIHdyaXR0ZW4KPiB0byB2cS0+bG9nX2FkZHIsIGlzIGEgR0lPVkEuIEFsbCB3cml0
ZXMgdG8gdGhpcyBhZGRyZXNzIGFyZSB0cmFuc2xhdGVkCj4gYnkgbG9nX3VzZXIoKSB0byB3cml0
ZXMgdG8gYW4gSFZBLCBhbmQgdGhlbiB1bHRpbWF0ZWx5IGxvZ2dlZCB0aHJvdWdoCj4gdGhlIGNv
cnJlc3BvbmRpbmcgR1BBcyBpbiBsb2dfd3JpdGVfaHZhKCkuIE5vIGxvZ2dpbmcgd2lsbCBldmVy
IG9jY3VyCj4gd2l0aCB2cS0+bG9nX2FkZHIgaW4gdGhpcyBjYXNlLiBJdCBpcyB0aHVzIHdyb25n
IHRvIHBhc3MgdnEtPmxvZ19hZGRyCj4gYW5kIGxvZ19ndWVzdF9hZGRyIHRvIGxvZ19hY2Nlc3Nf
dnEoKSB3aGljaCBhc3N1bWVzIHRoZXkgYXJlIGFjdHVhbAo+IEdQQXMuCj4KPiBJbnRyb2R1Y2Ug
YSBuZXcgdnFfbG9nX3VzZWRfYWNjZXNzX29rKCkgaGVscGVyIHRoYXQgb25seSBjaGVja3MgYWNj
ZXNzZXMKPiB0byB0aGUgbG9nIGZvciB0aGUgdXNlZCBzdHJ1Y3R1cmUgd2hlbiB0aGVyZSBpc24n
dCBhbiBJT1RMQiBkZXZpY2UgYXJvdW5kLgo+Cj4gU2lnbmVkLW9mZi1ieTogR3JlZyBLdXJ6IDxn
cm91Z0BrYW9kLm9yZz4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KCkluIHRoZSBmdXR1cmUsIHdlIG1heSBjb25zaWRlciB0byBkZXByZWNhdGUgbG9nX2d1ZXN0
X2FkZHIgc2luY2UgaW4gYW55IApjYXNlIHJlZ2FyZGxlc3Mgb2YgSU9UTEIgZW5ub2JsZW1lbnQg
d2UgY2FuIGdldCBHUEEgZnJvbSBlaXRoZXIgSU9UTEIgb3IgCk1FTSB0YWJsZS4KClRoYW5rcwoK
Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAgIDIzICsrKysrKysrKysrKysrKysr
Ky0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0
L3Zob3N0LmMKPiBpbmRleCA5ZDJjMjI1ZmI1MTguLjlhZDQ1ZTFkMjdmMCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBA
QCAtMTM3MCw2ICsxMzcwLDIwIEBAIGJvb2wgdmhvc3RfbG9nX2FjY2Vzc19vayhzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYpCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2aG9zdF9sb2dfYWNjZXNz
X29rKTsKPiAgIAo+ICtzdGF0aWMgYm9vbCB2cV9sb2dfdXNlZF9hY2Nlc3Nfb2soc3RydWN0IHZo
b3N0X3ZpcnRxdWV1ZSAqdnEsCj4gKwkJCQkgIHZvaWQgX191c2VyICpsb2dfYmFzZSwKPiArCQkJ
CSAgYm9vbCBsb2dfdXNlZCwKPiArCQkJCSAgdTY0IGxvZ19hZGRyKQo+ICt7Cj4gKwkvKiBJZiBh
biBJT1RMQiBkZXZpY2UgaXMgcHJlc2VudCwgbG9nX2FkZHIgaXMgYSBHSU9WQSB0aGF0Cj4gKwkg
KiB3aWxsIG5ldmVyIGJlIGxvZ2dlZCBieSBsb2dfdXNlZCgpLiAqLwo+ICsJaWYgKHZxLT5pb3Rs
YikKPiArCQlyZXR1cm4gdHJ1ZTsKPiArCj4gKwlyZXR1cm4gIWxvZ191c2VkIHx8IGxvZ19hY2Nl
c3Nfb2sobG9nX2Jhc2UsIGxvZ19hZGRyLAo+ICsJCQkJCSAgdmhvc3RfZ2V0X3VzZWRfc2l6ZSh2
cSwgdnEtPm51bSkpOwo+ICt9Cj4gKwo+ICAgLyogVmVyaWZ5IGFjY2VzcyBmb3Igd3JpdGUgbG9n
Z2luZy4gKi8KPiAgIC8qIENhbGxlciBzaG91bGQgaGF2ZSB2cSBtdXRleCBhbmQgZGV2aWNlIG11
dGV4ICovCj4gICBzdGF0aWMgYm9vbCB2cV9sb2dfYWNjZXNzX29rKHN0cnVjdCB2aG9zdF92aXJ0
cXVldWUgKnZxLAo+IEBAIC0xMzc3LDggKzEzOTEsNyBAQCBzdGF0aWMgYm9vbCB2cV9sb2dfYWNj
ZXNzX29rKHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxLAo+ICAgewo+ICAgCXJldHVybiB2cV9t
ZW1vcnlfYWNjZXNzX29rKGxvZ19iYXNlLCB2cS0+dW1lbSwKPiAgIAkJCQkgICB2aG9zdF9oYXNf
ZmVhdHVyZSh2cSwgVkhPU1RfRl9MT0dfQUxMKSkgJiYKPiAtCQkoIXZxLT5sb2dfdXNlZCB8fCBs
b2dfYWNjZXNzX29rKGxvZ19iYXNlLCB2cS0+bG9nX2FkZHIsCj4gLQkJCQkgIHZob3N0X2dldF91
c2VkX3NpemUodnEsIHZxLT5udW0pKSk7Cj4gKwkJdnFfbG9nX3VzZWRfYWNjZXNzX29rKHZxLCBs
b2dfYmFzZSwgdnEtPmxvZ191c2VkLCB2cS0+bG9nX2FkZHIpOwo+ICAgfQo+ICAgCj4gICAvKiBD
YW4gd2Ugc3RhcnQgdnE/ICovCj4gQEAgLTE1MTcsOSArMTUzMCw5IEBAIHN0YXRpYyBsb25nIHZo
b3N0X3ZyaW5nX3NldF9hZGRyKHN0cnVjdCB2aG9zdF9kZXYgKmQsCj4gICAJCQlyZXR1cm4gLUVJ
TlZBTDsKPiAgIAo+ICAgCQkvKiBBbHNvIHZhbGlkYXRlIGxvZyBhY2Nlc3MgZm9yIHVzZWQgcmlu
ZyBpZiBlbmFibGVkLiAqLwo+IC0JCWlmICgoYS5mbGFncyAmICgweDEgPDwgVkhPU1RfVlJJTkdf
Rl9MT0cpKSAmJgo+IC0JCQkhbG9nX2FjY2Vzc19vayh2cS0+bG9nX2Jhc2UsIGEubG9nX2d1ZXN0
X2FkZHIsCj4gLQkJCQkgICAgICAgdmhvc3RfZ2V0X3VzZWRfc2l6ZSh2cSwgdnEtPm51bSkpKQo+
ICsJCWlmICghdnFfbG9nX3VzZWRfYWNjZXNzX29rKHZxLCB2cS0+bG9nX2Jhc2UsCj4gKwkJCQlh
LmZsYWdzICYgKDB4MSA8PCBWSE9TVF9WUklOR19GX0xPRyksCj4gKwkJCQlhLmxvZ19ndWVzdF9h
ZGRyKSkKPiAgIAkJCXJldHVybiAtRUlOVkFMOwo+ICAgCX0KPiAgIAo+Cj4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==

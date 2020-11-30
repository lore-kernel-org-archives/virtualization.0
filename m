Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2DC64E7C
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:01:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C9720757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9D4iFjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C9720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D47F214E6;
	Mon, 30 Nov 2020 03:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOICu57Jw0t7; Mon, 30 Nov 2020 03:01:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 631572012D;
	Mon, 30 Nov 2020 03:01:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF62C0859;
	Mon, 30 Nov 2020 03:01:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6E55C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A999E86D7B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a9dGnPxfZN8w
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:01:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1201586D69
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606705290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBXG6FueBvNQUjOC0EjXTSMz58tXDXhMp19nfDV0Sso=;
 b=D9D4iFjWYEtyz1GwsPw9hTVZZXPjMkA+QLkDNOTrtZ+LnoIbUhUw5uqc+IxNKlOtnSCjvy
 sxNgiG4jM9zJgYrIuat2s5y4cPKGJRnpsOSwjIvcfx7apaX/7F0omKENyU2ts6/JohUYWJ
 v1KR3sL++JDXkOAxMgRxLYX57wQD3Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-JxC8mnLeOWutsvNqJfjsMg-1; Sun, 29 Nov 2020 22:01:28 -0500
X-MC-Unique: JxC8mnLeOWutsvNqJfjsMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B2DE9A22B;
 Mon, 30 Nov 2020 03:01:27 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18ABC1A882;
 Mon, 30 Nov 2020 03:01:17 +0000 (UTC)
Subject: Re: [PATCH v2 01/17] vdpa: remove unnecessary 'default n' in Kconfig
 entries
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-2-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f1ac66eb-e0f9-96c7-0282-f661d10b7378@redhat.com>
Date: Mon, 30 Nov 2020 11:01:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-2-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiAn
ZGVmYXVsdCBuJyBpcyBub3QgbmVjZXNzYXJ5IHNpbmNlIGl0IGlzIGFscmVhZHkgdGhlIGRlZmF1
bHQgd2hlbgo+IG5vdGhpbmcgaXMgc3BlY2lmaWVkLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFy
ZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL0tjb25maWcgfCAzIC0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92ZHBhL0tjb25maWcgYi9kcml2ZXJzL3ZkcGEvS2NvbmZpZwo+IGluZGV4IDM1OGY2MDQ4ZGQz
Yy4uNDAxOWNlYjg4MTgxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9LY29uZmlnCj4gKysr
IGIvZHJpdmVycy92ZHBhL0tjb25maWcKPiBAQCAtMTQsNyArMTQsNiBAQCBjb25maWcgVkRQQV9T
SU0KPiAgIAlzZWxlY3QgRE1BX09QUwo+ICAgCXNlbGVjdCBWSE9TVF9SSU5HCj4gICAJc2VsZWN0
IEdFTkVSSUNfTkVUX1VUSUxTCj4gLQlkZWZhdWx0IG4KPiAgIAloZWxwCj4gICAJICB2RFBBIG5l
dHdvcmtpbmcgZGV2aWNlIHNpbXVsYXRvciB3aGljaCBsb29wIFRYIHRyYWZmaWMgYmFjawo+ICAg
CSAgdG8gUlguIFRoaXMgZGV2aWNlIGlzIHVzZWQgZm9yIHRlc3RpbmcsIHByb3RvdHlwaW5nIGFu
ZAo+IEBAIC0yMyw3ICsyMiw2IEBAIGNvbmZpZyBWRFBBX1NJTQo+ICAgY29uZmlnIElGQ1ZGCj4g
ICAJdHJpc3RhdGUgIkludGVsIElGQyBWRiB2RFBBIGRyaXZlciIKPiAgIAlkZXBlbmRzIG9uIFBD
SV9NU0kKPiAtCWRlZmF1bHQgbgo+ICAgCWhlbHAKPiAgIAkgIFRoaXMga2VybmVsIG1vZHVsZSBj
YW4gZHJpdmUgSW50ZWwgSUZDIFZGIE5JQyB0byBvZmZsb2FkCj4gICAJICB2aXJ0aW8gZGF0YXBs
YW5lIHRyYWZmaWMgdG8gaGFyZHdhcmUuCj4gQEAgLTQxLDcgKzM5LDYgQEAgY29uZmlnIE1MWDVf
VkRQQV9ORVQKPiAgIAl0cmlzdGF0ZSAidkRQQSBkcml2ZXIgZm9yIENvbm5lY3RYIGRldmljZXMi
Cj4gICAJc2VsZWN0IE1MWDVfVkRQQQo+ICAgCWRlcGVuZHMgb24gTUxYNV9DT1JFCj4gLQlkZWZh
dWx0IG4KPiAgIAloZWxwCj4gICAJICBWRFBBIG5ldHdvcmsgZHJpdmVyIGZvciBDb25uZWN0WDYg
YW5kIG5ld2VyLiBQcm92aWRlcyBvZmZsb2FkaW5nCj4gICAJICBvZiB2aXJ0aW8gbmV0IGRhdGFw
YXRoIHN1Y2ggdGhhdCBkZXNjcmlwdG9ycyBwdXQgb24gdGhlIHJpbmcgd2lsbAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u

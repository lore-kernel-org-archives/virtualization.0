Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B2C64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 02:12:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A8720757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 02:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bs2lc78x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A8720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 117F087267;
	Mon, 30 Nov 2020 02:12:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWxpzglPsLH2; Mon, 30 Nov 2020 02:12:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 622E88725C;
	Mon, 30 Nov 2020 02:12:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46686C0859;
	Mon, 30 Nov 2020 02:12:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F186CC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E0E3186BC5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:12:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZK3EmdWrlOS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:12:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4765E86BBF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 02:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606702334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8sjd/83plcp606/47bcrLZsq1LEBw7/fWpUkizclFBY=;
 b=Bs2lc78x075IWJLmPNhvoR895C9CwE/ZeXJcaOsgkMS6gOx6Y1/lfvDt2Hi546Cz62hxvQ
 3gOxjGFlbYajEbyCnvh7Kc6kl1az6AOIoAfyvCWeLT08CWsaLCwN9ZpNaNZ4AMCIJi8aBw
 mH6rsqAii5O/fOawKGwX3yQIZjXcQZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Uhpc5TRBME2471aFym3k7Q-1; Sun, 29 Nov 2020 21:12:09 -0500
X-MC-Unique: Uhpc5TRBME2471aFym3k7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D928D1074641;
 Mon, 30 Nov 2020 02:12:07 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D03CA272DF;
 Mon, 30 Nov 2020 02:12:01 +0000 (UTC)
Subject: Re: [PATCH v4] vdpa: mlx5: fix vdpa/vhost dependencies
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
References: <20201128213905.27409-1-rdunlap@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6a1231c-8b81-6c69-3c63-74bf438da866@redhat.com>
Date: Mon, 30 Nov 2020 10:12:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201128213905.27409-1-rdunlap@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kernel test robot <lkp@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Parav Pandit <parav@mellanox.com>
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

Ck9uIDIwMjAvMTEvMjkg5LiK5Y2INTozOSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IGRyaXZlcnMv
dmRwYS9tbHg1LyB1c2VzIHZob3N0X2lvdGxiKigpIGludGVyZmFjZXMsIHNvIHNlbGVjdAo+IFZI
T1NUX0lPVExCIHRvIG1ha2UgdGhlbSBiZSBidWlsdC4KPgo+IEhvd2V2ZXIsIGlmIFZIT1NUX0lP
VExCIGlzIHRoZSBvbmx5IFZIT1NUIHN5bWJvbCB0aGF0IGlzCj4gc2V0L2VuYWJsZWQsIHRoZSBv
YmplY3QgZmlsZSBzdGlsbCB3b24ndCBiZSBidWlsdCBiZWNhdXNlCj4gZHJpdmVycy9NYWtlZmls
ZSB3b24ndCBkZXNjZW5kIGludG8gZHJpdmVycy92aG9zdC8gdG8gYnVpbGQgaXQsCj4gc28gbWFr
ZSBkcml2ZXJzL01ha2VmaWxlIGJ1aWxkIHRoZSBuZWVkZWQgYmluYXJ5IHdoZW5ldmVyCj4gVkhP
U1RfSU9UTEIgaXMgc2V0LCBsaWtlIGl0IGRvZXMgZm9yIFZIT1NUX1JJTkcuCj4KPiBGaXhlcyB0
aGVzZSBidWlsZCBlcnJvcnM6Cj4gRVJST1I6IG1vZHBvc3Q6ICJ2aG9zdF9pb3RsYl9pdHJlZV9u
ZXh0IiBbZHJpdmVycy92ZHBhL21seDUvbWx4NV92ZHBhLmtvXSB1bmRlZmluZWQhCj4gRVJST1I6
IG1vZHBvc3Q6ICJ2aG9zdF9pb3RsYl9pdHJlZV9maXJzdCIgW2RyaXZlcnMvdmRwYS9tbHg1L21s
eDVfdmRwYS5rb10gdW5kZWZpbmVkIQo+Cj4gRml4ZXM6IDI5MDY0YmZkYWJkNSAoInZkcGEvbWx4
NTogQWRkIHN1cHBvcnQgbGlicmFyeSBmb3IgbWx4NSBWRFBBIGltcGxlbWVudGF0aW9uIikKPiBG
aXhlczogYWZmOTA3NzBlNTRjICgidmRwYS9tbHg1OiBGaXggZGVwZW5kZW5jeSBvbiBNTFg1X0NP
UkUiKQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPiBDYzog
RWxpIENvaGVuIDxlbGlAbWVsbGFub3guY29tPgo+IENjOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG1l
bGxhbm94LmNvbT4KPiBDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgo+
IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IENjOiB2aXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IENjOiBTYWVlZCBNYWhhbWVlZCA8c2FlZWRt
QG52aWRpYS5jb20+Cj4gQ2M6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+Cj4g
Q2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKPiAtLS0KPiB2MjogY2hhbmdlIGZyb20gc2VsZWN0
IHRvIGRlcGVuZHMgb24gVkhPU1QgKFNhZWVkKQo+IHYzOiBjaGFuZ2UgdG8gZGVwZW5kcyBvbiBW
SE9TVF9JT1RMQiAoSmFzb24pCj4gdjQ6IHVzZSBzZWxlY3QgVkhPU1RfSU9UTEIgKE1pY2hhZWwp
OyBhbHNvIGFkZCB0byBkcml2ZXJzL01ha2VmaWxlCj4KPiAgIGRyaXZlcnMvTWFrZWZpbGUgICAg
IHwgICAgMSArCj4gICBkcml2ZXJzL3ZkcGEvS2NvbmZpZyB8ICAgIDEgKwo+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IC0tLSBsaW51eC1uZXh0LTIwMjAxMTI3Lm9yaWcv
ZHJpdmVycy92ZHBhL0tjb25maWcKPiArKysgbGludXgtbmV4dC0yMDIwMTEyNy9kcml2ZXJzL3Zk
cGEvS2NvbmZpZwo+IEBAIC0zMiw2ICszMiw3IEBAIGNvbmZpZyBJRkNWRgo+ICAgCj4gICBjb25m
aWcgTUxYNV9WRFBBCj4gICAJYm9vbAo+ICsJc2VsZWN0IFZIT1NUX0lPVExCCj4gICAJaGVscAo+
ICAgCSAgU3VwcG9ydCBsaWJyYXJ5IGZvciBNZWxsYW5veCBWRFBBIGRyaXZlcnMuIFByb3ZpZGVz
IGNvZGUgdGhhdCBpcwo+ICAgCSAgY29tbW9uIGZvciBhbGwgdHlwZXMgb2YgVkRQQSBkcml2ZXJz
LiBUaGUgZm9sbG93aW5nIGRyaXZlcnMgYXJlIHBsYW5uZWQ6Cj4gLS0tIGxpbnV4LW5leHQtMjAy
MDExMjcub3JpZy9kcml2ZXJzL01ha2VmaWxlCj4gKysrIGxpbnV4LW5leHQtMjAyMDExMjcvZHJp
dmVycy9NYWtlZmlsZQo+IEBAIC0xNDMsNiArMTQzLDcgQEAgb2JqLSQoQ09ORklHX09GKQkJKz0g
b2YvCj4gICBvYmotJChDT05GSUdfU1NCKQkJKz0gc3NiLwo+ICAgb2JqLSQoQ09ORklHX0JDTUEp
CQkrPSBiY21hLwo+ICAgb2JqLSQoQ09ORklHX1ZIT1NUX1JJTkcpCSs9IHZob3N0Lwo+ICtvYmot
JChDT05GSUdfVkhPU1RfSU9UTEIpCSs9IHZob3N0Lwo+ICAgb2JqLSQoQ09ORklHX1ZIT1NUKQkJ
Kz0gdmhvc3QvCj4gICBvYmotJChDT05GSUdfVkxZTlEpCQkrPSB2bHlucS8KPiAgIG9iai0kKENP
TkZJR19HUkVZQlVTKQkJKz0gZ3JleWJ1cy8KPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

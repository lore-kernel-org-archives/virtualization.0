Return-Path: <SRS0=RIAz=EB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C742DC388F7
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:13:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8852076B
	for <virtualization@archiver.kernel.org>; Mon, 26 Oct 2020 03:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InHkBOVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8852076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A661586A3D;
	Mon, 26 Oct 2020 03:13:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l9jJGDDvERi9; Mon, 26 Oct 2020 03:13:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10F2C869F6;
	Mon, 26 Oct 2020 03:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03C69C088B;
	Mon, 26 Oct 2020 03:13:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19717C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0B47286A2B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kLWkYUwdSids
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:13:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 63173869F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Oct 2020 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603682007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOjMnS2JqxNqOYMsb3x4VwNre9rvbc2W7qLLujuj9TA=;
 b=InHkBOVKlKhdkUX2kBwKNVOYVMokmw/kpl+xCHAJCHVv6ZLYypDaPQubjoUmvRc7KGwTvk
 uqWPR6m8HZI3bCh1PVAuab7+5+H+/Crz3jLNg1O6CvTalQh7iAPuktcn1aDrQfcWXCKYQJ
 TRDBRyjIZN+rXJzs7ppuSQ5iL87BtDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-1ClRXN5lNimlsXOlB3awWA-1; Sun, 25 Oct 2020 23:13:26 -0400
X-MC-Unique: 1ClRXN5lNimlsXOlB3awWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D55A10074D9;
 Mon, 26 Oct 2020 03:13:25 +0000 (UTC)
Received: from [10.72.13.201] (ovpn-13-201.pek2.redhat.com [10.72.13.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FA371972A;
 Mon, 26 Oct 2020 03:13:17 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: use DMA when memory encryption is active
To: Sebastian Hofmann <sebastian@kaemmelot.de>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <1075010014.50900.1603293266000@office.mailbox.org>
 <20201022073716-mutt-send-email-mst@kernel.org>
 <1419750420.56704.1603443654667@office.mailbox.org>
 <ea4d2c99-1c67-797d-29dc-d122e4856d24@redhat.com>
 <1556371108.50676.1603450557595@office.mailbox.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b6c11855-56df-82c3-a084-1fc627fcf52b@redhat.com>
Date: Mon, 26 Oct 2020 11:13:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1556371108.50676.1603450557595@office.mailbox.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTAvMjMg5LiL5Y2INjo1NSwgU2ViYXN0aWFuIEhvZm1hbm4gd3JvdGU6Cj4+IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IGhhdCBhbSAyMy4xMC4yMDIwIDExOjEwIGdl
c2NocmllYmVuOgo+Pgo+PiAgIAo+PiBPbiAyMDIwLzEwLzIzIOS4i+WNiDU6MDAsIFNlYmFzdGlh
biBIb2ZtYW5uIHdyb3RlOgo+Pj4+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+
IGhhdCBhbSAyMi4xMC4yMDIwIDEzOjM5IGdlc2NocmllYmVuOgo+Pj4+Cj4+Pj4gICAgCj4+Pj4g
T24gV2VkLCBPY3QgMjEsIDIwMjAgYXQgMDU6MTQ6MjVQTSArMDIwMCwgU2ViYXN0aWFuIEhvZm1h
bm4gd3JvdGU6Cj4+Pj4+IHZpcnRpb19yaW5nIGRvZXMgbm90IHdvcmsgd2l0aCBhY3RpdmUgbWVt
b3J5IGVuY3J5cHRpb24gYmVjYXVzZSB0aGUgaG9zdCBjYW5ub3QgcmVhZCBpdC4gRml4IHRoaXMg
YnkgZW5mb3JjaW5nIHRoZSB1c2Ugb2YgRE1BIHdoaWNoIHVzZXMgc2hhcmVkICh1bmVuY3J5cHRl
ZCkgbWVtb3J5IHBhZ2VzLgo+Pj4+Pgo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gSG9m
bWFubiA8c2ViYXN0aWFuQGthZW1tZWxvdC5kZT4KPj4+PiBTb3JyeSwgbm8uCj4+Pj4gaG9zdCB3
aGljaCBjYW4gbm90IGFjY2VzcyBhbGwgb2YgZHJpdmVyIG1lbW9yeSBtdXN0IHNldCBWSVJUSU9f
Rl9BQ0NFU1NfUExBVEZPUk0uCj4+Pj4KPj4+PiBOb3Qgd29ydGggaXQgdG8gd29yayBhcm91bmQg
YnJva2VuIGhvc3RzLgo+Pj4+Cj4+Pj4gWGVuIGlzIGFuIGV4Y2VwdGlvbiB3ZSBjYXJyeSBhcm91
bmQgc2luY2UgaXQgcHJlZGF0ZXMgdGhlCj4+Pj4gaW50cm9kdWN0aW9uIG9mIFZJUlRJT19GX0FD
Q0VTU19QTEFURk9STS4KPj4+Pgo+Pj4+Cj4+PiBUaGFua3MgZm9yIHBvaW50aW5nIG91dCBWSVJU
SU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggSSB3YXMgbm90IGF3YXJlIG9mLiBNYXliZSB0aGF0
IHBhdGNoIHdhcyBhIGJpdCBuYcOvdmUuCj4+Pgo+Pj4gQmFzaWNhbGx5IEknbSBsb29raW5nIGZv
ciBhIHdheSB0byB1c2UgdnNvY2sgd2l0aCBxZW11IG9uIEFNRCBTRVYuIFdoZW4gSSB0cnkgdG8g
dXNlIElPTU1VIGZvciB2c29jayBJIGdldCBhbiBFT1BOT1RTVVBQIG91dCBvZiB2aG9zdF92c29j
a19zZXRfZmVhdHVyZXMuCj4+Pgo+Pj4gSXMgdGhlcmUgYSByZWFzb24gd2h5IHZob3N0X3Zzb2Nr
X3NldF9mZWF0dXJlcyBkb2Vzbid0IHVzZSB2aG9zdF9pbml0X2RldmljZV9pb3RsYiBhcyBkb25l
IGluIHRoZSBuZXQgZGV2aWNlPwo+Pgo+PiBJdCdzIGp1c3QgYmVjYXVzZSBpdCBoYXMgYmVlbiBp
bXBsZW1lbnRlZC4gSW4gYWRkaXRpb24gdG8gaW1wbGVtZW50Cj4+IElPVExCLCB0aGUgdmlydGlv
LXZzb2NrLXBjaSBtdXN0IGFkdmVydGlzZSBBVFMgY2FwYWJpbGl0eSBhcyB3ZWxsLgo+Pgo+Pgo+
Pj4gQmVjYXVzZSB0aGF0IHdvdWxkIGhhdmUgYmVlbiBteSBuZXh0IGF0dGVtcHQuCj4+PiBJIHdv
dWxkIGFwcHJlY2lhdGUgYSBzaG9ydCBjb21tZW50IG9uIHRoaXMgaWRlYSBvciBhIHJlY29tbWVu
ZGF0aW9uIGZvciBhbm90aGVyIHNvbHV0aW9uIHRoYXQgaXMgYmV0dGVyIHRoYW4gdGhlIHBhdGNo
IGJlbG93Lgo+Pgo+PiBBIHF1ZXN0aW9uLCBpcyB2SU9NTVUgYSBtdXN0IGZvciBtYWtpbmcgU0VW
IHdvcms/Cj4gQmFzZWQgb24gdGhlIGRlbW8gY29kZSBmcm9tIEFNRCB3aGVyZSB0aGV5IGp1c3Qg
dXNlICItZGV2aWNlIHZpcnRpby1zY3NpLXBjaSxpZD1zY3NpLGRpc2FibGUtbGVnYWN5PW9uLGlv
bW11X3BsYXRmb3JtPXRydWUiIGFuZCBteSB1bmRlcnN0YW5kaW5nIG9mIElPTU1VOiBubywgSSBk
b24ndCB0aGluayBzby4KPgo+IFRoZSBBVFMgY2FwYWJpbGl0eSBpcyBvbmx5IHJlcXVpcmVkIGZv
ciB2SU9NTVUsIHJpZ2h0PwoKClllcywgc28gaWYgaXQgZG9lc24ndCByZXF1aXJlIGEgdklPTU1V
LCB5b3UgZG9uJ3QgbmVlZCB0byBpbXBsZW1lbnQgCkRldmljZSBJT1RMQiBpbiB2aG9zdC12c29j
ay4KClNldHRpbmcgaW9tbXVfcGxhdGZvcm0gc2hvdWxkIGJlIHN1ZmZpY2llbnQgdG8gdmhvc3Qt
dnNvY2sgb3IgaXQgY291bGQgCmJlIGEgYnVnIHNvbWV3aGVyZS4KClRoYW5rcwoKCj4KPj4gVGhh
bmtzCj4+Cj4+Cj4+Pj4+IC0tLQo+Pj4+PiAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IHwgNSArKysrKwo+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4+Pj4+
Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4+PiBpbmRleCBiZWNjNzc2OTc5NjAuLjhjNjhjNDc1
ZWMyMSAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4+
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+Pj4+IEBAIC0xMiw2ICsxMiw3
IEBACj4+Pj4+ICAgICNpbmNsdWRlIDxsaW51eC9ocnRpbWVyLmg+Cj4+Pj4+ICAgICNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwcGluZy5oPgo+Pj4+PiAgICAjaW5jbHVkZSA8eGVuL3hlbi5oPgo+Pj4+
PiArI2luY2x1ZGUgPGxpbnV4L21lbV9lbmNyeXB0Lmg+Cj4+Pj4+ICAgIAo+Pj4+PiAgICAjaWZk
ZWYgREVCVUcKPj4+Pj4gICAgLyogRm9yIGRldmVsb3BtZW50LCB3ZSB3YW50IHRvIGNyYXNoIHdo
ZW5ldmVyIHRoZSByaW5nIGlzIHNjcmV3ZWQuICovCj4+Pj4+IEBAIC0yNTUsNiArMjU2LDEwIEBA
IHN0YXRpYyBib29sIHZyaW5nX3VzZV9kbWFfYXBpKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
KQo+Pj4+PiAgICAJaWYgKHhlbl9kb21haW4oKSkKPj4+Pj4gICAgCQlyZXR1cm4gdHJ1ZTsKPj4+
Pj4gICAgCj4+Pj4+ICsJLyogTWVtb3J5IGVuY3J5cHRpb24gcmVxdWlyZXMgRE1BICovCj4+Pj4+
ICsJaWYgKG1lbV9lbmNyeXB0X2FjdGl2ZSgpKQo+Pj4+PiArCQlyZXR1cm4gdHJ1ZTsKPj4+Pj4g
Kwo+Pj4+PiAgICAJcmV0dXJuIGZhbHNlOwo+Pj4+PiAgICB9Cj4+Pj4+ICAgIAo+Pj4+PiAtLSAK
Pj4+Pj4gMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

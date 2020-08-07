Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A0DC433DF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:00:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B6A221E4
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bG2OQF+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B6A221E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FF9B871C1;
	Fri,  7 Aug 2020 03:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vv3sb3qZAUsU; Fri,  7 Aug 2020 03:00:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F3C387195;
	Fri,  7 Aug 2020 03:00:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90E17C0051;
	Fri,  7 Aug 2020 03:00:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 316ABC004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1CEF6203E2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:00:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XOR3hYZdTgaU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:00:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 1E7A82038D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596769252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8hjLpt/QzD6v1/2A6T4AsRXxZwxHTWi0Mqm+X07ilg=;
 b=bG2OQF+ETnYV+uuIwlY5vU98g8TIsQVg53hpGDXm/Rz7atVdOq75Ke0A5puu3SGY/t3CnC
 j0lMMq1roZSZIF+O3TX4G2mFEYoz0gqgEYGUO2X4zOlIWAmCVeUe2F8s7bOMaHOKdrpKUZ
 0IN+VNCwocdkm6uOSMvX+ecjU0GYOi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-e_JvTdG1PZ2e1KyXcm5FTQ-1; Thu, 06 Aug 2020 23:00:51 -0400
X-MC-Unique: e_JvTdG1PZ2e1KyXcm5FTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6637A106B242;
 Fri,  7 Aug 2020 03:00:50 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34E895D9DD;
 Fri,  7 Aug 2020 03:00:45 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
 <20200806015112-mutt-send-email-mst@kernel.org>
 <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
 <20200806055818-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5261b78d-f2db-0f80-34ac-1a834353b13a@redhat.com>
Date: Fri, 7 Aug 2020 11:00:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806055818-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC82IOS4i+WNiDY6MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBU
aHUsIEF1ZyAwNiwgMjAyMCBhdCAwMzoyNzozOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzgvNiDkuIvljYgxOjUzLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBP
biBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAxMToyMzowNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pj4+IE9uIDIwMjAvOC81IOS4i+WNiDc6NDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
Pj4+Pj4gT24gV2VkLCBBdWcgMDUsIDIwMjAgYXQgMDI6MTQ6MDdQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4+Pj4+IE9uIDIwMjAvOC80IOS4iuWNiDU6MDAsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPj4+Pj4+PiBTb21lIGxlZ2FjeSBndWVzdHMganVzdCBhc3N1bWUgZmVhdHVyZXMg
YXJlIDAgYWZ0ZXIgcmVzZXQuCj4+Pj4+Pj4gV2UgZGV0ZWN0IHRoYXQgY29uZmlnIHNwYWNlIGlz
IGFjY2Vzc2VkIGJlZm9yZSBmZWF0dXJlcyBhcmUKPj4+Pj4+PiBzZXQgYW5kIHNldCBmZWF0dXJl
cyB0byAwIGF1dG9tYXRpY2FsbHkuCj4+Pj4+Pj4gTm90ZTogc29tZSBsZWdhY3kgZ3Vlc3RzIG1p
Z2h0IG5vdCBldmVuIGFjY2VzcyBjb25maWcgc3BhY2UsIGlmIHRoaXMgaXMKPj4+Pj4+PiByZXBv
cnRlZCBpbiB0aGUgZmllbGQgd2UgbWlnaHQgbmVlZCB0byBjYXRjaCBhIGtpY2sgdG8gaGFuZGxl
IHRoZXNlLgo+Pj4+Pj4gSSB3b25kZXIgd2hldGhlciBpdCdzIGVhc2llciB0byBqdXN0IHN1cHBv
cnQgbW9kZXJuIGRldmljZT8KPj4+Pj4+Cj4+Pj4+PiBUaGFua3MKPj4+Pj4gV2VsbCBoYXJkd2Fy
ZSB2ZW5kb3JzIGFyZSBJIHRoaW5rIGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyBsZWdhY3kKPj4+
Pj4gZ3Vlc3RzLiBMaW1pdGluZyB2ZHBhIHRvIG1vZGVybiBvbmx5IHdvdWxkIG1ha2UgaXQgdW5j
b21wZXRpdGl2ZS4KPj4+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIElPTU1VX1BMQVRGT1JN
IGlzIG1hbmRhdG9yeSBmb3IgaGFyZHdhcmUgdkRQQSB0bwo+Pj4+IHdvcmsuCj4+PiBIbW0gSSBk
b24ndCByZWFsbHkgc2VlIHdoeS4gQXNzdW1lIGhvc3QgbWFwcyBndWVzdCBtZW1vcnkgcHJvcGVy
bHksCj4+PiBWTSBkb2VzIG5vdCBoYXZlIGFuIElPTU1VLCBsZWdhY3kgZ3Vlc3QgY2FuIGp1c3Qg
d29yay4KPj4KPj4gWWVzLCBndWVzdCBtYXkgbm90IHNldCBJT01NVV9QTEFURk9STS4KPj4KPj4K
Pj4+IENhcmUgZXhwbGFpbmluZyB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGlzIHBpY3R1cmU/Cj4+Cj4+
IFRoZSBwcm9ibGVtIGlzIHZpcnRpb192ZHBhLCB3aXRob3V0IElPTU1VX1BMQVRGT1JNIGl0IHVz
ZXMgUEEgd2hpY2ggY2FuIG5vdAo+PiB3b3JrIGlmIElPTU1VIGlzIGVuYWJsZWQuCj4+Cj4+IFRo
YW5rcwo+IFNvIHRoYXQncyBhIHZpcnRpb192ZHBhIGxpbWl0YXRpb24uCgoKUHJvYmFibHkgbm90
LCBJIHRoaW5rIHRoaXMgZ29lcyBiYWNrIHRvIHRoZSBsb25nIGRlYmF0ZSBvZiB3aGV0aGVyIHRv
IAp1c2UgRE1BIEFQSSB1bmNvbmRpdGlvbmFsbHkuIElmIHdlIGRpZCB0aGF0LCB3ZSBjYW4gc3Vw
cG9ydCBsZWdhY3kgCnZpcnRpbyBkcml2ZXIuCgpUaGUgdkRQQSBkZXZpY2UgbmVlZHMgdG8gcHJv
dmlkZSBhIERNQSBkZXZpY2UgYW5kIHRoZSB2aXJ0aW8gY29yZSBhbmQgCnBlcmZvcm0gRE1BIEFQ
SSB3aXRoIHRoYXQgZGV2aWNlIHdoaWNoIHNob3VsZCB3b3JrIGZvciBhbGwgb2YgdGhlIGNhc2Vz
LgoKQnV0IGEgYmlnIHF1ZXN0aW9uIGlzLCBkbyB1cHN0cmVhbSBjYXJlIGFib3V0IG91dCBvZiB0
cmVlIHZpcnRpbyBkcml2ZXJzPwoKVGhhbmtzCgoKPiBJbiB0aGUgc2FtZSB3YXksIGlmIGEgZGV2
aWNlCj4gZG9lcyBub3QgaGF2ZSBhbiBvbi1kZXZpY2UgaW9tbXUgKmFuZCogaXMgbm90IGJlaGlu
ZCBhbiBpb21tdSwKPiB0aGVuIHZkcGEgY2FuJ3QgYmluZCB0byBpdC4KPgo+IEJ1dCB0aGlzIHZp
cnRpb192ZHBhIHNwZWNpZmljIGhhY2sgZG9lcyBub3QgYmVsb25nIGluIGEgZ2VuZXJpYyB2ZHBh
IGNvZGUuCj4KPj4+Cj4+Pj4gU28gaXQgY2FuIG9ubHkgd29yayBmb3IgbW9kZXJuIGRldmljZSAu
Li4KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

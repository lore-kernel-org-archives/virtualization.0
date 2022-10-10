Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F6BC433FE
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 13:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E658A60E36;
	Mon, 10 Oct 2022 13:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E658A60E36
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYAV3vfS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id immN6ps_laxM; Mon, 10 Oct 2022 13:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8821960BC8;
	Mon, 10 Oct 2022 13:43:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8821960BC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5C5C0032;
	Mon, 10 Oct 2022 13:43:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F67C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 13:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 960FC404DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 13:43:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 960FC404DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YYAV3vfS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QgpT2ZZ_fa3l
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 13:43:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA35540104
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA35540104
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665409431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vAce1GTc/xVR4humhuRjKOZBURsP/bzwXLd8EnMO1IM=;
 b=YYAV3vfSlgoH1hX7vAOUO//guL6gDLZniWnqKPzlrvctDVph3Zk92ceXtm2J6UTKnLST8W
 p92XhATFBHHdaH2zzzJdzEgKVv7xzojLPTB1PnAb51r6RZYBP1igXFOlQ0ju6Z/D4doxDT
 nR1LTgZgGa2dQGuGvLr+fHQxoa6QAJ0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-bdyjq_JnNYmBWs-VnBOx9g-1; Mon, 10 Oct 2022 09:43:50 -0400
X-MC-Unique: bdyjq_JnNYmBWs-VnBOx9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01493C11EA0;
 Mon, 10 Oct 2022 13:43:49 +0000 (UTC)
Received: from localhost (unknown [10.39.193.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51697404CD91;
 Mon, 10 Oct 2022 13:43:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Ricardo =?utf-8?Q?Ca=C3=B1uelo?=
 <ricardo.canuelo@collabora.com>
Subject: Re: [RESEND PATCH v5 1/1] docs: driver-api: virtio: virtio on Linux
In-Reply-To: <Y0QYTq7KW9C731s0@debian.me>
Organization: Red Hat GmbH
References: <20221010064359.1324353-1-ricardo.canuelo@collabora.com>
 <20221010064359.1324353-2-ricardo.canuelo@collabora.com>
 <Y0QYTq7KW9C731s0@debian.me>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Mon, 10 Oct 2022 15:43:46 +0200
Message-ID: <877d17n699.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: corbet@lwn.net, mst@redhat.com, linux-doc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@collabora.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBPY3QgMTAgMjAyMiwgQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+
IHdyb3RlOgoKPiBPbiBNb24sIE9jdCAxMCwgMjAyMiBhdCAwODo0Mzo1OUFNICswMjAwLCBSaWNh
cmRvIENhw7F1ZWxvIHdyb3RlOgo+PiArCj4+ICtSZWZlcmVuY2VzCj4+ICs9PT09PT09PT09Cj4+
ICsKPj4gK19gWzFdYCBWaXJ0aW8gU3BlYyB2MS4yOgo+PiAraHR0cHM6Ly9kb2NzLm9hc2lzLW9w
ZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEuMi92aXJ0aW8tdjEuMi5odG1sCj4+ICsKPj4gK0NoZWNr
IGZvciBsYXRlciB2ZXJzaW9ucyBvZiB0aGUgc3BlYyBhcyB3ZWxsLgo+PiArCj4KPiBUaGUgdmVy
c2lvbiBjaGVja2luZyBzaG91bGQgYmUgbWFkZSBjb21tZW50IChub3QgdmlzaWJsZSBvbiB0aGUg
b3V0cHV0KToKPgo+IC0tLS0gPjggLS0tLQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Ry
aXZlci1hcGkvdmlydGlvL3ZpcnRpby5yc3QgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmly
dGlvL3ZpcnRpby5yc3QKPiBpbmRleCA3MGIzYWE2YmNmNTUxOC4uNGYzYWJiZWM0ZThiMmMgMTAw
NjQ0Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby92aXJ0aW8ucnN0Cj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kcml2ZXItYXBpL3ZpcnRpby92aXJ0aW8ucnN0Cj4gQEAgLTEz
NCw3ICsxMzQsNyBAQCBSZWZlcmVuY2VzCj4gIF9gWzFdYCBWaXJ0aW8gU3BlYyB2MS4yOgo+ICBo
dHRwczovL2RvY3Mub2FzaXMtb3Blbi5vcmcvdmlydGlvL3ZpcnRpby92MS4yL3ZpcnRpby12MS4y
Lmh0bWwKPiAgCj4gLUNoZWNrIGZvciBsYXRlciB2ZXJzaW9ucyBvZiB0aGUgc3BlYyBhcyB3ZWxs
Lgo+ICsuLiBDaGVjayBmb3IgbGF0ZXIgdmVyc2lvbnMgb2YgdGhlIHNwZWMgYXMgd2VsbC4KPiAg
Cj4gIF9gWzJdYCBWaXJ0cXVldWVzIGFuZCB2aXJ0aW8gcmluZzogSG93IHRoZSBkYXRhIHRyYXZl
bHMKPiAgaHR0cHM6Ly93d3cucmVkaGF0LmNvbS9lbi9ibG9nL3ZpcnRxdWV1ZXMtYW5kLXZpcnRp
by1yaW5nLWhvdy1kYXRhLXRyYXZlbHMKPgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
cml2ZXItYXBpL3ZpcnRpby93cml0aW5nX3ZpcnRpb19kcml2ZXJzLnJzdCBiL0RvY3VtZW50YXRp
b24vZHJpdmVyLWFwaS92aXJ0aW8vd3JpdGluZ192aXJ0aW9fZHJpdmVycy5yc3QKPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lMTRjNTg3OTZkMjUKPj4gLS0t
IC9kZXYvbnVsbAo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvdmlydGlvL3dyaXRp
bmdfdmlydGlvX2RyaXZlcnMucnN0Cj4+IDxzbmlwcGVkPi4uLgo+PiArUmVmZXJlbmNlcwo+PiAr
PT09PT09PT09PQo+PiArCj4+ICtfYFsxXWAgVmlydGlvIFNwZWMgdjEuMjoKPj4gK2h0dHBzOi8v
ZG9jcy5vYXNpcy1vcGVuLm9yZy92aXJ0aW8vdmlydGlvL3YxLjIvdmlydGlvLXYxLjIuaHRtbAo+
PiArCj4+ICtDaGVjayBmb3IgbGF0ZXIgdmVyc2lvbnMgb2YgdGhlIHNwZWMgYXMgd2VsbC4KPgo+
IFNhbWUgcmVwbHkuCgpJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBoaWRlIHRoYXQgaW4gYSBjb21t
ZW50IC0tIHVubGVzcyB5b3Ugd2FudCB0bwp1cGRhdGUgdGhpcyBmaWxlIGV2ZXJ5IHRpbWUgYSBu
ZXcgdmVyc2lvbiBvZiB0aGUgdmlydGlvIHNwZWMgZ2V0cwpyZWxlYXNlZC4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==

Return-Path: <SRS0=Ra46=BR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C8C433DF
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:27:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F172086A
	for <virtualization@archiver.kernel.org>; Fri,  7 Aug 2020 03:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijSobE0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F172086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8C11A87200;
	Fri,  7 Aug 2020 03:27:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hR-CVfkeziB2; Fri,  7 Aug 2020 03:27:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D5B6F86CE5;
	Fri,  7 Aug 2020 03:27:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEEE7C0050;
	Fri,  7 Aug 2020 03:27:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BACDC004C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 318A5813F0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:27:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hTjYqW02tINJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:27:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 767BD8861F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Aug 2020 03:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596770824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PzBVMxtG2p8vYea4PsugHNCB46PX04hMXUf43TE1qM8=;
 b=ijSobE0c/x3e/IVdwhV5vjojGlmtQ+4EjECPgAGcAQwemB8N6F7PwEVjOseL4nAb9uycHv
 Nc1lOPfSLBDbISx42UF7H39YO6EjLkTxRCczfAbsiDCuOagWNmKKAiJ/aX8simUGnTTWGk
 9IhD3m4BTAYtUDNgDPgFXLSWUTXuryc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Bc6xhlj6Opam2uxRH5xr5Q-1; Thu, 06 Aug 2020 23:27:02 -0400
X-MC-Unique: Bc6xhlj6Opam2uxRH5xr5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC21518C63E7;
 Fri,  7 Aug 2020 03:27:01 +0000 (UTC)
Received: from [10.72.13.215] (ovpn-13-215.pek2.redhat.com [10.72.13.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D31B587A66;
 Fri,  7 Aug 2020 03:26:57 +0000 (UTC)
Subject: Re: [PATCH v2 03/24] virtio: allow __virtioXX, __leXX in config space
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-4-mst@redhat.com>
 <ce85a206-45a6-da3d-45a7-06f068f3bad7@redhat.com>
 <20200805074434-mutt-send-email-mst@kernel.org>
 <4aa65ad6-5324-0a8c-0fa6-0d8e680f0706@redhat.com>
 <20200806015604-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a4ef115c-f005-fd09-a94f-5b2a004b672b@redhat.com>
Date: Fri, 7 Aug 2020 11:26:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806015604-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvOC82IOS4i+WNiDE6NTgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBU
aHUsIEF1ZyAwNiwgMjAyMCBhdCAxMTozNzozOEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzgvNSDkuIvljYg3OjQ1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+
ICAgICAjZGVmaW5lIHZpcnRpb19jcmVhZCh2ZGV2LCBzdHJ1Y3RuYW1lLCBtZW1iZXIsIHB0cikJ
CQlcCj4+Pj4+ICAgICAJZG8gewkJCQkJCQkJXAo+Pj4+PiAgICAgCQltaWdodF9zbGVlcCgpOwkJ
CQkJCVwKPj4+Pj4gICAgIAkJLyogTXVzdCBtYXRjaCB0aGUgbWVtYmVyJ3MgdHlwZSwgYW5kIGJl
IGludGVnZXIgKi8JXAo+Pj4+PiAtCQlpZiAoIXR5cGVjaGVjayh0eXBlb2YoKCgoc3RydWN0bmFt
ZSopMCktPm1lbWJlcikpLCAqKHB0cikpKSBcCj4+Pj4+ICsJCWlmICghX192aXJ0aW9fdHlwZWNo
ZWNrKHN0cnVjdG5hbWUsIG1lbWJlciwgKihwdHIpKSkJXAo+Pj4+PiAgICAgCQkJKCpwdHIpID0g
MTsJCQkJCVwKPj4+PiBBIHNpbGx5IHF1ZXN0aW9uLMKgIGNvbXBhcmUgdG8gdXNpbmcgc2V0KCkv
Z2V0KCkgZGlyZWN0bHksIHdoYXQncyB0aGUgdmFsdWUKPj4+PiBvZiB0aGUgYWNjZXNzb3JzIG1h
Y3JvIGhlcmU/Cj4+Pj4KPj4+PiBUaGFua3MKPj4+IGdldC9zZXQgZG9uJ3QgY29udmVydCB0byB0
aGUgbmF0aXZlIGVuZGlhbiwgSSBndWVzcyB0aGF0J3Mgd2h5Cj4+PiBkcml2ZXJzIHVzZSBjcmVh
ZC9jd3JpdGUuIEl0IGlzIGFsc28gbmljZSB0aGF0IHRoZXJlJ3MgdHlwZQo+Pj4gc2FmZXR5LCBj
aGVja2luZyB0aGUgY29ycmVjdCBpbnRlZ2VyIHdpZHRoIGlzIHVzZWQuCj4+Cj4+IFllcywgYnV0
IHRoaXMgaXMgc2ltcGx5IGJlY2F1c2UgYSBtYWNybyBpcyB1c2VkIGhlcmUsIGhvdyBhYm91dCBq
dXN0IGRvaW5nCj4+IHRoaW5ncyBzaW1pbGFyIGxpa2UgdmlydGlvX2NyZWFkX2J5dGVzKCk6Cj4+
Cj4+IHN0YXRpYyBpbmxpbmUgdm9pZCB2aXJ0aW9fY3JlYWQoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYsCj4+ICDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgwqDCoCB1bnNpZ25l
ZCBpbnQgb2Zmc2V0LAo+PiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoMKgwqAg
dm9pZCAqYnVmLCBzaXplX3QgbGVuKQo+Pgo+Pgo+PiBBbmQgZG8gdGhlIGVuZGlhbiBjb252ZXJz
aW9uIGluc2lkZT8KPj4KPj4gVGhhbmtzCj4+Cj4gVGhlbiB5b3UgbG9zZSB0eXBlIHNhZmV0eS4g
SXQncyB2ZXJ5IGVhc3kgdG8gaGF2ZSBhbiBsZTMyIGZpZWxkCj4gYW5kIHRyeSB0byByZWFkIGl0
IGludG8gYSB1MTYgYnkgbWlzdGFrZS4KPgo+IFRoZXNlIG1hY3JvcyBhcmUgYWxsIGFib3V0IHBy
ZXZlbnRpbmcgYnVnczogYW5kIHRoZSB3aG9sZSBwYXRjaHNldAo+IGlzIGFib3V0IHNldmVyYWwg
YnVncyBzcGFyc2UgZm91bmQgLSB0aGF0IGlzIHdoYXQgcHJvbXB0ZWQgbWUgdG8gbWFrZQo+IHR5
cGUgY2hlY2tzIG1vcmUgc3RyaWN0LgoKClllcywgYnV0IHdlIG5lZWQgdG8gZG8gdGhlIG1hY3Jv
IHdpdGggY29tcGlsZXIgZXh0ZW5zaW9ucy4gSSB3b25kZXIgCndoZXRoZXIgb3Igbm90IHRoZSBr
ZXJuZWwgaGFzIGFscmVhZHkgaGFkIHNvbWV0aGluZyBzaW5jZSB0aGlzIHJlcXVlc3QgCmhlcmUg
aXMgcHJldHR5IGNvbW1vbj8KClRoYW5rcwoKCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3142AC64E8A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:48:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE96208FE
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE96208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9756886E36;
	Wed,  2 Dec 2020 13:48:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wtBus08eD2j; Wed,  2 Dec 2020 13:48:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 21D1286DEF;
	Wed,  2 Dec 2020 13:48:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A1B3C0859;
	Wed,  2 Dec 2020 13:48:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52AE1C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3980E870E5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:48:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KJvfaZb-Qtm1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:48:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CC7E68701F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606916915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vHedmF2t1mThnVS41kBW1jt04b9cWe1xOcXAMd+DJ5o=;
 b=G3pK0C8WXJlEiCwxtmZ6oBBBN3L/CmEExmnygeFANbHZsndeBV8IhPc4KHbOGjXlWlsK6d
 8hkuVR/mIfEhE+lPTMUrAzgrN0j91JGbU/RZvUdIWrnfGr4I+f4YjuTb7baliLitrMNuOj
 TZhJME97TkYviDEKLIy/kGg0etIsy9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-U_64aH1OPsKIZpMUDYYixA-1; Wed, 02 Dec 2020 08:48:33 -0500
X-MC-Unique: U_64aH1OPsKIZpMUDYYixA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79CD31006C97;
 Wed,  2 Dec 2020 13:48:32 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC9DD60BFA;
 Wed,  2 Dec 2020 13:48:26 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201129150505-mutt-send-email-mst@kernel.org>
 <20201130062746.GA99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3e32ef6d-83c9-5866-30e5-f6eeacd5044d@redhat.com>
Date: Wed, 2 Dec 2020 21:48:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202041518-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: linux-kernel@vger.kernel.org, Cindy Lu <lulu@redhat.com>,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvMTIvMiDkuIvljYg1OjIzLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBEZWMgMDIsIDIwMjAgYXQgMDc6NTc6MTRBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+
PiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAxMjoxODozNlBNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4gT24gMjAyMC8xMi8xIOS4i+WNiDU6MjMsIENpbmR5IEx1IHdyb3RlOgo+Pj4+IE9u
IE1vbiwgTm92IDMwLCAyMDIwIGF0IDExOjMzIFBNIE1pY2hhZWwgUy4gVHNpcmtpbjxtc3RAcmVk
aGF0LmNvbT4gIHdyb3RlOgo+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwNjo0MTo0NVBN
ICswODAwLCBDaW5keSBMdSB3cm90ZToKPj4+Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDU6
MzMgUE0gTWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29tPiAgd3JvdGU6Cj4+Pj4+Pj4g
T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6Mjc6NTlBTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+Pj4+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwNDowMDo1MUFNIC0wNTAwLCBNaWNo
YWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAw
ODoyNzo0NkFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gU3VuLCBOb3Yg
MjksIDIwMjAgYXQgMDM6MDg6MjJQTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4+Pj4+Pj4+PiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBhdCAwODo0Mzo1MUFNICswMjAwLCBFbGkg
Q29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+PiBXZSBzaG91bGQgbm90IHRyeSB0byB1c2UgdGhlIFZG
IE1BQyBhZGRyZXNzIGFzIHRoYXQgaXMgdXNlZCBieSB0aGUKPj4+Pj4+Pj4+Pj4+IHJlZ3VsYXIg
KGUuZy4gbWx4NV9jb3JlKSBOSUMgaW1wbGVtZW50YXRpb24uIEluc3RlYWQsIHVzZSBhIHJhbmRv
bQo+Pj4+Pj4+Pj4+Pj4gZ2VuZXJhdGVkIE1BQyBhZGRyZXNzLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+IFN1Z2dlc3RlZCBieTogQ2luZHkgTHU8bHVsdUByZWRoYXQuY29tPgo+Pj4+Pj4+Pj4+
Pj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBz
dXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBD
b2hlbjxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4+Pj4+IEkgZGlkbid0IHJlYWxpc2UgaXQncyBw
b3NzaWJsZSB0byB1c2UgVkYgaW4gdHdvIHdheXMKPj4+Pj4+Pj4+Pj4gd2l0aCBhbmQgd2l0aG91
dCB2ZHBhLgo+Pj4+Pj4+Pj4+IFVzaW5nIGEgVkYgeW91IGNhbiBjcmVhdGUgcXVpdGUgYSBmZXcg
cmVzb3VyY2VzLCBlLmcuIHNlbmQgcXVldWVzCj4+Pj4+Pj4+Pj4gcmVjaWV2ZSBxdWV1ZXMsIHZp
cnRpb19uZXQgcXVldWVzIGV0Yy4gU28geW91IGNhbiBwb3NzaWJseSBjcmVhdGUKPj4+Pj4+Pj4+
PiBzZXZlcmFsIGluc3RhbmNlcyBvZiB2ZHBhIG5ldCBkZXZpY2VzIGFuZCBuaWMgbmV0IGRldmlj
ZXMuCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gQ291bGQgeW91IGluY2x1ZGUgYSBiaXQgbW9yZSBk
ZXNjcmlwdGlvbiBvbiB0aGUgZmFpbHVyZQo+Pj4+Pj4+Pj4+PiBtb2RlPwo+Pj4+Pj4+Pj4+IFdl
bGwsIHVzaW5nIHRoZSBNQUMgYWRkcmVzcyBvZiB0aGUgbmljIHZwb3J0IGlzIHdyb25nIHNpbmNl
IHRoYXQgaXMgdGhlCj4+Pj4+Pj4+Pj4gTUFDIG9mIHRoZSByZWd1bGFyIE5JQyBpbXBsZW1lbnRh
dGlvbiBvZiBtbHg1X2NvcmUuCj4+Pj4+Pj4+PiBSaWdodCBidXQgQVRNIGl0IGRvZXNuJ3QgY29l
eGlzdCB3aXRoIHZkcGEgc28gd2hhdCdzIHRoZSBwcm9ibGVtPwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4g
VGhpcyBjYWxsIGlzIHdyb25nOiAgbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKQo+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBJcyBzd2l0Y2hpbmcgdG8gYSByYW5kb20gbWFjIGZvciBzdWNo
IGFuIHVudXN1YWwKPj4+Pj4+Pj4+Pj4gY29uZmlndXJhdGlvbiByZWFsbHkganVzdGlmaWVkPwo+
Pj4+Pj4+Pj4+IFNpbmNlIEkgY2FuJ3QgdXNlIHRoZSBOSUMncyBNQUMgYWRkcmVzcywgSSBoYXZl
IHR3byBvcHRpb25zOgo+Pj4+Pj4+Pj4+IDEuIFRvIGdldCB0aGUgTUFDIGFkZHJlc3MgYXMgd2Fz
IGNob3NlbiBieSB0aGUgdXNlciBhZG1pbmlzdGVyaW5nIHRoZQo+Pj4+Pj4+Pj4+ICAgICAgTklD
LiBUaGlzIHNob3VsZCBpbnZva2UgdGhlIHNldF9jb25maWcgY2FsbGJhY2suIFVuZm9ydHVuYXRl
bHkgdGhpcwo+Pj4+Pj4+Pj4+ICAgICAgaXMgbm90IGltcGxlbWVudGVkIHlldC4KPj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+IDIuIFVzZSBhIHJhbmRvbSBNQUMgYWRkcmVzcy4gVGhpcyBpcyBPSyBzaW5j
ZSBpZiAoMSkgaXMgaW1wbGVtZW50ZWQgaXQKPj4+Pj4+Pj4+PiAgICAgIGNhbiBhbHdheXMgb3Zl
cnJpZGUgdGhpcyByYW5kb20gY29uZmlndXJhdGlvbi4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBJ
dCBsb29rcyBsaWtlIGNoYW5naW5nIGEgTUFDIGNvdWxkIGJyZWFrIHNvbWUgZ3Vlc3RzLAo+Pj4+
Pj4+Pj4+PiBjYW4gaXQgbm90Pwo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IE5vLCBpdCB3aWxsIG5v
dC4gVGhlIGN1cnJlbnQgdmVyc2lvbiBvZiBtbHg1IFZEUEEgZG9lcyBub3QgYWxsb3cgcmVndWxh
cgo+Pj4+Pj4+Pj4+IE5JQyBkcml2ZXIgYW5kIFZEUEEgdG8gY28tZXhpc3QuIEkgaGF2ZSBwYXRj
aGVzIHJlYWR5IHRoYXQgZW5hYmxlIHRoYXQKPj4+Pj4+Pj4+PiBmcm9tIHN0ZWVyaW5nIHBvaW50
IG9mIHZpZXcuIEkgd2lsbCBwb3N0IHRoZW0gaGVyZSBvbmNlIG90aGVyIHBhdGNoZXMgb24KPj4+
Pj4+Pj4+PiB3aGljaCB0aGV5IGRlcGVuZCB3aWxsIGJlIG1lcmdlZC4KPj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9uZXRkZXYvcGF0Y2gv
MjAyMDExMjAyMzAzMzkuNjUxNjA5LTEyLXNhZWVkbUBudmlkaWEuY29tLwo+Pj4+Pj4+Pj4gQ291
bGQgeW91IGJlIG1vcmUgZXhwbGljaXQgb24gdGhlIGZvbGxvd2luZyBwb2ludHM6Cj4+Pj4+Pj4+
PiAtIHdoaWNoIGNvbmZpZ3VyYXRpb24gaXMgYnJva2VuIEFUTSAoYXMgaW4sIHR3byBkZXZpY2Ug
aGF2ZSBpZGVudGljYWwKPj4+Pj4+Pj4+ICAgICBtYWNzPyBhbnkgb3RoZXIgaXNzdWVzKT8KPj4+
Pj4+Pj4gVGhlIG9ubHkgd3JvbmcgdGhpbmcgaXMgdGhlIGNhbGwgdG8gIG1seDVfcXVlcnlfbmlj
X3Zwb3J0X21hY19hZGRyZXNzKCkuCj4+Pj4+Pj4+IEl0J3Mgbm90IGJyZWFraW5nIGFueXRoaW5n
IHlldCBpcyB3cm9uZy4gVGhlIHJhbmRvbSBNQUMgYWRkcmVzcyBzZXR0aW5nCj4+Pj4+Pj4+IGlz
IHJlcXVpcmVkIGZvciB0aGUgc3RlZXJpbmcgcGF0Y2hlcy4KPj4+Pj4+PiBPa2F5IHNvIEknbSBu
b3Qgc3VyZSB0aGUgRml4ZXMgdGFnIGF0IGxlYXN0IGlzIGFwcHJvcHJpYXRlIGlmIGl0J3MgYQo+
Pj4+Pj4+IGRlcGVuZGVuY3kgb2YgYSBuZXcgZmVhdHVyZS4KPj4+Pj4+Pgo+Pj4+Pj4+Pj4gLSB3
aHkgd29uJ3QgZGV2aWNlIE1BQyBjaGFuZ2UgZnJvbSBndWVzdCBwb2ludCBvZiB2aWV3Pwo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4gSXQncyBsYWNrIG9mIGltcGxlbWVudGF0aW9uIGluIHFlbXUgYXMgZmFy
IGFzIEkga25vdy4KPj4+Pj4+PiBTb3JyeSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQuIFdoYXQncyBu
b3QgaW1wbGVtZW50ZWQgaW4gUUVNVT8KPj4+Pj4+Pgo+Pj4+Pj4gSEkgTWljaGFlbCwgdGhlcmUg
YXJlIHNvbWUgYnVnIGluIHFlbXUgdG8gc2V0X2NvbmZpZywgdGhpcyB3aWxsIGZpeCBpbiBmdXR1
cmUsCj4+Pj4+PiBCdXQgdGhpcyBwYXRjaCBpcyBzdGlsbCBuZWVkZWQsIGJlY2F1c2Ugd2l0aG91
dCB0aGlzIHBhdGNoIHRoZSBtbHgKPj4+Pj4+IGRyaXZlciB3aWxsIGdpdmUgYW4gMCBtYWMgYWRk
cmVzcyB0byBxZW11Cj4+Pj4+PiBhbmQgcWVtdSB3aWxsIG92ZXJ3cml0ZSB0aGUgZGVmYXVsdCBt
YWMgYWRkcmVzcy4gIFRoaXMgd2lsbCBjYXVzZSB0cmFmZmljIGRvd24uCj4+Pj4+IEhtbSB0aGUg
cGF0Y2ggZGVzY3JpcHRpb24gc2F5cyBWRiBtYWMgYWRkcmVzcywgbm90IDAgYWRkcmVzcy4gQ29u
ZnVzZWQuCj4+Pj4+IElmIHRoZXJlJ3Mgbm8gbWFjIHdlIGNhbiBjbGVhciBWSVJUSU9fTkVUX0Zf
TUFDIGFuZCBoYXZlIGd1ZXN0Cj4+Pj4+IHVzZSBhIHJhbmRvbSB2YWx1ZSAuLi4KPj4+IEknbSBu
b3Qgc3VyZSB0aGlzIGNhbiB3b3JrIGZvciBhbGwgdHlwZXMgb2YgdkRQQSAoZS5nIGl0IGNvdWxk
IG5vdCBiZSBhCj4+PiBsZWFybmluZyBicmlkZ2UgaW4gdGhlIHN3dGljaCkuCj4+Pgo+Pj4KPj4+
PiBoaSBNaWNoYWVs77yMCj4+Pj4gSSBoYXZlIHRyaWVkIGFzIHlvdXIgc3VnZ2VzdGlvbiwgc2Vl
bXMgZXZlbiByZW1vdmUgdGhlCj4+Pj4gVklSVElPX05FVF9GX01BQyB0aGUgcWVtdSB3aWxsIHN0
aWxsIGNhbGwgZ2V0X2NpbmZpZyBhbmQgb3ZlcndyaXRlIHRoZQo+Pj4+IGRlZmF1bHQgYWRkcmVz
cyBpbiAgVk0sCj4+PiBUaGlzIGxvb2tzIGEgYnVnIGluIHFlbXUsIGluIGd1ZXN0IGRyaXZlciB3
ZSBoYWQ6Cj4+Pgo+Pj4gIMKgwqDCoCAvKiBDb25maWd1cmF0aW9uIG1heSBzcGVjaWZ5IHdoYXQg
TUFDIHRvIHVzZS7CoCBPdGhlcndpc2UgcmFuZG9tLiAqLwo+Pj4gIMKgwqDCoCBpZiAodmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NQUMpKQo+Pj4gIMKgwqDCoCDCoMKgwqAg
dmlydGlvX2NyZWFkX2J5dGVzKHZkZXYsCj4+PiAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKg
IMKgwqAgb2Zmc2V0b2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnLCBtYWMpLAo+Pj4gIMKgwqDC
oCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIGRldi0+ZGV2X2FkZHIsIGRldi0+YWRkcl9sZW4p
Owo+Pj4gIMKgwqDCoCBlbHNlCj4+PiAgwqDCoMKgIMKgwqDCoCBldGhfaHdfYWRkcl9yYW5kb20o
ZGV2KTsKPj4+Cj4+Pgo+Pj4+IHRoaXMgcHJvY2VzcyBpcyBsaWtlCj4+Pj4gdmRwYSBfaW5pdCAt
LT5xZW11IGNhbGwgZ2V0X2NvbmZpZyAtPm1seCBkcml2ZXIgd2lsbCBnaXZlICBhbiBtYWMKPj4+
PiBhZGRyZXNzIHdpdGggYWxsIDAtLT4KPj4+PiBxZW11IHdpbGwgbm90IGNoZWNrIHRoaXMgbWFj
IGFkZHJlc3MgYW5kIHVzZSBpdCAtLT4gb3ZlcndyaXRlIHRoZSBtYWMKPj4+PiBhZGRyZXNzIGlu
IHFlbXUKPj4+Pgo+Pj4+IFNvIGZvciBteSB1bmRlcnN0YW5kaW5nIHRoZXJlIGFyZSBzZXZlcmFs
IG1ldGhvZCB0byBmaXggdGhpcyBwcm9ibGVtCj4+Pj4KPj4+PiAxLCBxZW11IGNoZWNrIHRoZSBt
YWMgYWRkcmVzcywgaWYgdGhlIG1hYyBhZGRyZXNzIGlzIGFsbCAwLCBxZW11IHdpbGwKPj4+PiBp
Z25vcmUgaXQgYW5kIHNldCB0aGUgcmFuZG9tIG1hYyBhZGRyZXNzIHRvIG1seCBkcml2ZXIuCj4+
PiBTbyBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIGlmIG1hYyBhZGRyZXNzIGlzIGFsbCAwLCB2
RFBBIHBhcmVudCBzaG91bGQgbm90Cj4+PiBhZHZlcnRpc2UgVklSVElPX05FVF9GX01BQy4gQW5k
IHFlbXUgc2hvdWxkIGVtdWxhdGUgdGhpcyBmZWF0dXJlIGFzIHlvdSBkaWQ6Cj4+IFRoaW5raW5n
IGl0IG92ZXIsIGF0IGxlYXN0IGluIG1seDUsIEkgc2hvdWxkIGFsd2F5cyBhZHZlcnRpc2UKPj4g
VklSVElPX05FVF9GX01BQyBhbmQgc2V0IGEgbm9uIHplcm8gTUFDIHZhbHVlLiBUaGUgc291cmNl
IG9mIHRoZSBNQUMgY2FuCj4+IGJlIGVpdGhlciByYW5kb21seSBnZW5lcmF0ZWQgdmFsdWUgYnkg
bWx4NV92ZHBhIG9yIGJ5IGEgbWFuYWdlbWVudCB0b29sLgo+PiBUaGlzIGlzIGltcG9ydGFudCBi
ZWNhdWFzZSB3ZSBzaG91bGQgbm90IGxldCB0aGUgVk0gbW9kaWZ5IHRoZSBNQUMuIElmCj4+IHdl
IGRvIGl0IGNhbiBzZXQgYSBNQUMgdmFsdWUgaWRlbnRpY2FsIHRvIHRoZSBtbHg1IE5JQyBkcml2
ZXIgYW5kIGNhbgo+PiBraWRuYXAgdHJhZmZpYyB0aGF0IHdhcyBub3QgZGVzdGluZWQgdG8gaXQu
Cj4+Cj4+IEluIGFkZGl0aW9uLCB3aGVuIFZJUlRJT19ORVRfRl9NQUMgaXMgcHVibGlzaGVkLCBh
dHRlbXB0cyB0byBjaGFuZ2UgdGhlCj4+IE1BQyBhZGRyZXNzIGZyb20gdGhlIFZNIHNob3VsZCBy
ZXN1bHQgaW4gZXJyb3IuCj4gVGhhdCBpcyBub3Qgd2hhdCB0aGUgc3BlYyBzYXlzIHRob3VnaC4K
PiBWSVJUSU9fTkVUX0ZfTUFDIG9ubHkgc2F5cyB3aGV0aGVyIG1hYyBpcyB2YWxpZCBpbiB0aGUg
Y29uZmlnIHNwYWNlLgo+IFdoZXRoZXIgZ3Vlc3QgY2FuIGNvbnRyb2wgdGhhdCBkZXBlbmRzIG9u
IFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSOgo+Cj4gCVRoZSBWSVJUSU9fTkVUX0NUUkxfTUFD
X0FERFJfU0VUIGNvbW1hbmQgaXMgdXNlZCB0byBzZXQgdGhlIGRlZmF1bHQgTUFDIGFkZHJlc3Mg
d2hpY2ggcngKPiAJZmlsdGVyaW5nIGFjY2VwdHMgKGFuZCBpZiBWSVJUSU9fTkVUX0ZfTUFDX0FE
RFIgaGFzIGJlZW4gbmVnb3RpYXRlZCwgdGhpcyB3aWxsIGJlIHJlZmxlY3RlZCBpbiBtYWMgaW4K
PiAJY29uZmlnIHNwYWNlKS4KPiAJVGhlIGNvbW1hbmQtc3BlY2lmaWMtZGF0YSBmb3IgVklSVElP
X05FVF9DVFJMX01BQ19BRERSX1NFVCBpcyB0aGUgNi1ieXRlIE1BQyBhZGRyZXNzLgoKCkNvbnNp
ZGVyIFZJUlRJT19ORVRfQ1RSTF9NQUNfQUREUl9TRVQgaXMgbm90IHN1cHBvcnRlZCBub3cuIFdo
YXQgRWxpIApwcm9wb3NlZCBoZXJlIHNob3VsZCB3b3JrPwoKVGhhbmtzCgoKPgo+Cj4KPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

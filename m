Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C6C64E7B
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:00:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B962222C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 13:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B962222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A242D2E15A;
	Wed,  2 Dec 2020 13:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bZGtowUjg7K; Wed,  2 Dec 2020 13:00:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2897D20415;
	Wed,  2 Dec 2020 13:00:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 184CBC163C;
	Wed,  2 Dec 2020 13:00:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52D4EC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3EC36877E4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:00:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a2YGr2AVS3Z8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:00:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EECFA877DB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 13:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606914042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUQgzWRH9rJne+EPzBWMt9oiuINHgTSGGnaYEK7O1Tk=;
 b=SlFSO1omjz+rzhnNl5a/qvpzJz7317F8e+hAMPNdWfFntPfikqmY4t6J1N0CIk4jHyIusm
 bhAmWGGsNjw2mQtaOrYR2Rk6tJmhOs/WSkz5trSeRaSFRZ1LDmEgbrjTGXRTmtgSAWkyj1
 bA5kyCDOFpRCEUOk7jmf5dXwvlgtiLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-W94Z4Cw4MBSNzmgGlxcBMw-1; Wed, 02 Dec 2020 08:00:39 -0500
X-MC-Unique: W94Z4Cw4MBSNzmgGlxcBMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 035361936B90;
 Wed,  2 Dec 2020 13:00:38 +0000 (UTC)
Received: from [10.72.12.105] (ovpn-12-105.pek2.redhat.com [10.72.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D04019172;
 Wed,  2 Dec 2020 13:00:08 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
To: "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201130035147-mutt-send-email-mst@kernel.org>
 <20201130092759.GB99449@mtl-vdi-166.wap.labs.mlnx>
 <20201130043050-mutt-send-email-mst@kernel.org>
 <CACLfguXB+SzocLppNtrTZwKPFsshS8TLVe8_iFJxgjT-cFpSzA@mail.gmail.com>
 <20201130103142-mutt-send-email-mst@kernel.org>
 <CACLfguWDFgJUJTJik1obvv-vzacRwgkfsN=-Uouu+K9dAKFE+A@mail.gmail.com>
 <e52b94b6-42a8-1270-1e10-d1905ccae598@redhat.com>
 <20201202055714.GA224423@mtl-vdi-166.wap.labs.mlnx>
 <20201202041518-mutt-send-email-mst@kernel.org>
 <20201202121241.GA228811@mtl-vdi-166.wap.labs.mlnx>
 <20201202071414-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <13d33e2c-ea99-6625-83fd-6cb223dd103b@redhat.com>
Date: Wed, 2 Dec 2020 21:00:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202071414-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Ck9uIDIwMjAvMTIvMiDkuIvljYg4OjE3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
V2VkLCBEZWMgMDIsIDIwMjAgYXQgMDI6MTI6NDFQTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+
PiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAwNDoyMzoxMUFNIC0wNTAwLCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4+PiBPbiBXZWQsIERlYyAwMiwgMjAyMCBhdCAwNzo1NzoxNEFNICswMjAw
LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gT24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMTI6MTg6MzZQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4gT24gMjAyMC8xMi8xIOS4i+WNiDU6MjMs
IENpbmR5IEx1IHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MzMgUE0g
TWljaGFlbCBTLiBUc2lya2luPG1zdEByZWRoYXQuY29tPiAgd3JvdGU6Cj4+Pj4+Pj4gT24gTW9u
LCBOb3YgMzAsIDIwMjAgYXQgMDY6NDE6NDVQTSArMDgwMCwgQ2luZHkgTHUgd3JvdGU6Cj4+Pj4+
Pj4+IE9uIE1vbiwgTm92IDMwLCAyMDIwIGF0IDU6MzMgUE0gTWljaGFlbCBTLiBUc2lya2luPG1z
dEByZWRoYXQuY29tPiAgd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAx
MToyNzo1OUFNICswMjAwLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4gT24gTW9uLCBOb3Yg
MzAsIDIwMjAgYXQgMDQ6MDA6NTFBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
Pj4+Pj4+Pj4+PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwODoyNzo0NkFNICswMjAwLCBFbGkg
Q29oZW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+PiBPbiBTdW4sIE5vdiAyOSwgMjAyMCBhdCAwMzowODoy
MlBNIC0wNTAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4gT24gU3Vu
LCBOb3YgMjksIDIwMjAgYXQgMDg6NDM6NTFBTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+Pj4+
Pj4+Pj4+Pj4+PiBXZSBzaG91bGQgbm90IHRyeSB0byB1c2UgdGhlIFZGIE1BQyBhZGRyZXNzIGFz
IHRoYXQgaXMgdXNlZCBieSB0aGUKPj4+Pj4+Pj4+Pj4+Pj4gcmVndWxhciAoZS5nLiBtbHg1X2Nv
cmUpIE5JQyBpbXBsZW1lbnRhdGlvbi4gSW5zdGVhZCwgdXNlIGEgcmFuZG9tCj4+Pj4+Pj4+Pj4+
Pj4+IGdlbmVyYXRlZCBNQUMgYWRkcmVzcy4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4g
U3VnZ2VzdGVkIGJ5OiBDaW5keSBMdTxsdWx1QHJlZGhhdC5jb20+Cj4+Pj4+Pj4+Pj4+Pj4+IEZp
eGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9y
dGVkIG1seDUgZGV2aWNlcyIpCj4+Pj4+Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hl
bjxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgcmVhbGlzZSBpdCdzIHBv
c3NpYmxlIHRvIHVzZSBWRiBpbiB0d28gd2F5cwo+Pj4+Pj4+Pj4+Pj4+IHdpdGggYW5kIHdpdGhv
dXQgdmRwYS4KPj4+Pj4+Pj4+Pj4+IFVzaW5nIGEgVkYgeW91IGNhbiBjcmVhdGUgcXVpdGUgYSBm
ZXcgcmVzb3VyY2VzLCBlLmcuIHNlbmQgcXVldWVzCj4+Pj4+Pj4+Pj4+PiByZWNpZXZlIHF1ZXVl
cywgdmlydGlvX25ldCBxdWV1ZXMgZXRjLiBTbyB5b3UgY2FuIHBvc3NpYmx5IGNyZWF0ZQo+Pj4+
Pj4+Pj4+Pj4gc2V2ZXJhbCBpbnN0YW5jZXMgb2YgdmRwYSBuZXQgZGV2aWNlcyBhbmQgbmljIG5l
dCBkZXZpY2VzLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBDb3VsZCB5b3UgaW5jbHVkZSBh
IGJpdCBtb3JlIGRlc2NyaXB0aW9uIG9uIHRoZSBmYWlsdXJlCj4+Pj4+Pj4+Pj4+Pj4gbW9kZT8K
Pj4+Pj4+Pj4+Pj4+IFdlbGwsIHVzaW5nIHRoZSBNQUMgYWRkcmVzcyBvZiB0aGUgbmljIHZwb3J0
IGlzIHdyb25nIHNpbmNlIHRoYXQgaXMgdGhlCj4+Pj4+Pj4+Pj4+PiBNQUMgb2YgdGhlIHJlZ3Vs
YXIgTklDIGltcGxlbWVudGF0aW9uIG9mIG1seDVfY29yZS4KPj4+Pj4+Pj4+Pj4gUmlnaHQgYnV0
IEFUTSBpdCBkb2Vzbid0IGNvZXhpc3Qgd2l0aCB2ZHBhIHNvIHdoYXQncyB0aGUgcHJvYmxlbT8K
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBUaGlzIGNhbGwgaXMgd3Jvbmc6ICBtbHg1X3F1ZXJ5X25p
Y192cG9ydF9tYWNfYWRkcmVzcygpCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBJcyBzd2l0Y2hp
bmcgdG8gYSByYW5kb20gbWFjIGZvciBzdWNoIGFuIHVudXN1YWwKPj4+Pj4+Pj4+Pj4+PiBjb25m
aWd1cmF0aW9uIHJlYWxseSBqdXN0aWZpZWQ/Cj4+Pj4+Pj4+Pj4+PiBTaW5jZSBJIGNhbid0IHVz
ZSB0aGUgTklDJ3MgTUFDIGFkZHJlc3MsIEkgaGF2ZSB0d28gb3B0aW9uczoKPj4+Pj4+Pj4+Pj4+
IDEuIFRvIGdldCB0aGUgTUFDIGFkZHJlc3MgYXMgd2FzIGNob3NlbiBieSB0aGUgdXNlciBhZG1p
bmlzdGVyaW5nIHRoZQo+Pj4+Pj4+Pj4+Pj4gICAgICBOSUMuIFRoaXMgc2hvdWxkIGludm9rZSB0
aGUgc2V0X2NvbmZpZyBjYWxsYmFjay4gVW5mb3J0dW5hdGVseSB0aGlzCj4+Pj4+Pj4+Pj4+PiAg
ICAgIGlzIG5vdCBpbXBsZW1lbnRlZCB5ZXQuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gMi4g
VXNlIGEgcmFuZG9tIE1BQyBhZGRyZXNzLiBUaGlzIGlzIE9LIHNpbmNlIGlmICgxKSBpcyBpbXBs
ZW1lbnRlZCBpdAo+Pj4+Pj4+Pj4+Pj4gICAgICBjYW4gYWx3YXlzIG92ZXJyaWRlIHRoaXMgcmFu
ZG9tIGNvbmZpZ3VyYXRpb24uCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IEl0IGxvb2tzIGxp
a2UgY2hhbmdpbmcgYSBNQUMgY291bGQgYnJlYWsgc29tZSBndWVzdHMsCj4+Pj4+Pj4+Pj4+Pj4g
Y2FuIGl0IG5vdD8KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gTm8sIGl0IHdpbGwgbm90LiBU
aGUgY3VycmVudCB2ZXJzaW9uIG9mIG1seDUgVkRQQSBkb2VzIG5vdCBhbGxvdyByZWd1bGFyCj4+
Pj4+Pj4+Pj4+PiBOSUMgZHJpdmVyIGFuZCBWRFBBIHRvIGNvLWV4aXN0LiBJIGhhdmUgcGF0Y2hl
cyByZWFkeSB0aGF0IGVuYWJsZSB0aGF0Cj4+Pj4+Pj4+Pj4+PiBmcm9tIHN0ZWVyaW5nIHBvaW50
IG9mIHZpZXcuIEkgd2lsbCBwb3N0IHRoZW0gaGVyZSBvbmNlIG90aGVyIHBhdGNoZXMgb24KPj4+
Pj4+Pj4+Pj4+IHdoaWNoIHRoZXkgZGVwZW5kIHdpbGwgYmUgbWVyZ2VkLgo+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9uZXRkZXYv
cGF0Y2gvMjAyMDExMjAyMzAzMzkuNjUxNjA5LTEyLXNhZWVkbUBudmlkaWEuY29tLwo+Pj4+Pj4+
Pj4+PiBDb3VsZCB5b3UgYmUgbW9yZSBleHBsaWNpdCBvbiB0aGUgZm9sbG93aW5nIHBvaW50czoK
Pj4+Pj4+Pj4+Pj4gLSB3aGljaCBjb25maWd1cmF0aW9uIGlzIGJyb2tlbiBBVE0gKGFzIGluLCB0
d28gZGV2aWNlIGhhdmUgaWRlbnRpY2FsCj4+Pj4+Pj4+Pj4+ICAgICBtYWNzPyBhbnkgb3RoZXIg
aXNzdWVzKT8KPj4+Pj4+Pj4+PiBUaGUgb25seSB3cm9uZyB0aGluZyBpcyB0aGUgY2FsbCB0byAg
bWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2FkZHJlc3MoKS4KPj4+Pj4+Pj4+PiBJdCdzIG5vdCBi
cmVha2luZyBhbnl0aGluZyB5ZXQgaXMgd3JvbmcuIFRoZSByYW5kb20gTUFDIGFkZHJlc3Mgc2V0
dGluZwo+Pj4+Pj4+Pj4+IGlzIHJlcXVpcmVkIGZvciB0aGUgc3RlZXJpbmcgcGF0Y2hlcy4KPj4+
Pj4+Pj4+IE9rYXkgc28gSSdtIG5vdCBzdXJlIHRoZSBGaXhlcyB0YWcgYXQgbGVhc3QgaXMgYXBw
cm9wcmlhdGUgaWYgaXQncyBhCj4+Pj4+Pj4+PiBkZXBlbmRlbmN5IG9mIGEgbmV3IGZlYXR1cmUu
Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiAtIHdoeSB3b24ndCBkZXZpY2UgTUFDIGNoYW5nZSBmcm9t
IGd1ZXN0IHBvaW50IG9mIHZpZXc/Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gSXQncyBsYWNrIG9m
IGltcGxlbWVudGF0aW9uIGluIHFlbXUgYXMgZmFyIGFzIEkga25vdy4KPj4+Pj4+Pj4+IFNvcnJ5
IG5vdCBzdXJlIEkgdW5kZXJzdGFuZC4gV2hhdCdzIG5vdCBpbXBsZW1lbnRlZCBpbiBRRU1VPwo+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4gSEkgTWljaGFlbCwgdGhlcmUgYXJlIHNvbWUgYnVnIGluIHFlbXUg
dG8gc2V0X2NvbmZpZywgdGhpcyB3aWxsIGZpeCBpbiBmdXR1cmUsCj4+Pj4+Pj4+IEJ1dCB0aGlz
IHBhdGNoIGlzIHN0aWxsIG5lZWRlZCwgYmVjYXVzZSB3aXRob3V0IHRoaXMgcGF0Y2ggdGhlIG1s
eAo+Pj4+Pj4+PiBkcml2ZXIgd2lsbCBnaXZlIGFuIDAgbWFjIGFkZHJlc3MgdG8gcWVtdQo+Pj4+
Pj4+PiBhbmQgcWVtdSB3aWxsIG92ZXJ3cml0ZSB0aGUgZGVmYXVsdCBtYWMgYWRkcmVzcy4gIFRo
aXMgd2lsbCBjYXVzZSB0cmFmZmljIGRvd24uCj4+Pj4+Pj4gSG1tIHRoZSBwYXRjaCBkZXNjcmlw
dGlvbiBzYXlzIFZGIG1hYyBhZGRyZXNzLCBub3QgMCBhZGRyZXNzLiBDb25mdXNlZC4KPj4+Pj4+
PiBJZiB0aGVyZSdzIG5vIG1hYyB3ZSBjYW4gY2xlYXIgVklSVElPX05FVF9GX01BQyBhbmQgaGF2
ZSBndWVzdAo+Pj4+Pj4+IHVzZSBhIHJhbmRvbSB2YWx1ZSAuLi4KPj4+Pj4gSSdtIG5vdCBzdXJl
IHRoaXMgY2FuIHdvcmsgZm9yIGFsbCB0eXBlcyBvZiB2RFBBIChlLmcgaXQgY291bGQgbm90IGJl
IGEKPj4+Pj4gbGVhcm5pbmcgYnJpZGdlIGluIHRoZSBzd3RpY2gpLgo+Pj4+Pgo+Pj4+Pgo+Pj4+
Pj4gaGkgTWljaGFlbO+8jAo+Pj4+Pj4gSSBoYXZlIHRyaWVkIGFzIHlvdXIgc3VnZ2VzdGlvbiwg
c2VlbXMgZXZlbiByZW1vdmUgdGhlCj4+Pj4+PiBWSVJUSU9fTkVUX0ZfTUFDIHRoZSBxZW11IHdp
bGwgc3RpbGwgY2FsbCBnZXRfY2luZmlnIGFuZCBvdmVyd3JpdGUgdGhlCj4+Pj4+PiBkZWZhdWx0
IGFkZHJlc3MgaW4gIFZNLAo+Pj4+PiBUaGlzIGxvb2tzIGEgYnVnIGluIHFlbXUsIGluIGd1ZXN0
IGRyaXZlciB3ZSBoYWQ6Cj4+Pj4+Cj4+Pj4+ICDCoMKgwqAgLyogQ29uZmlndXJhdGlvbiBtYXkg
c3BlY2lmeSB3aGF0IE1BQyB0byB1c2UuwqAgT3RoZXJ3aXNlIHJhbmRvbS4gKi8KPj4+Pj4gIMKg
wqDCoCBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NQUMpKQo+Pj4+
PiAgwqDCoMKgIMKgwqDCoCB2aXJ0aW9fY3JlYWRfYnl0ZXModmRldiwKPj4+Pj4gIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZp
ZywgbWFjKSwKPj4+Pj4gIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgIGRldi0+ZGV2
X2FkZHIsIGRldi0+YWRkcl9sZW4pOwo+Pj4+PiAgwqDCoMKgIGVsc2UKPj4+Pj4gIMKgwqDCoCDC
oMKgwqAgZXRoX2h3X2FkZHJfcmFuZG9tKGRldik7Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+PiB0aGlzIHBy
b2Nlc3MgaXMgbGlrZQo+Pj4+Pj4gdmRwYSBfaW5pdCAtLT5xZW11IGNhbGwgZ2V0X2NvbmZpZyAt
Pm1seCBkcml2ZXIgd2lsbCBnaXZlICBhbiBtYWMKPj4+Pj4+IGFkZHJlc3Mgd2l0aCBhbGwgMC0t
Pgo+Pj4+Pj4gcWVtdSB3aWxsIG5vdCBjaGVjayB0aGlzIG1hYyBhZGRyZXNzIGFuZCB1c2UgaXQg
LS0+IG92ZXJ3cml0ZSB0aGUgbWFjCj4+Pj4+PiBhZGRyZXNzIGluIHFlbXUKPj4+Pj4+Cj4+Pj4+
PiBTbyBmb3IgbXkgdW5kZXJzdGFuZGluZyB0aGVyZSBhcmUgc2V2ZXJhbCBtZXRob2QgdG8gZml4
IHRoaXMgcHJvYmxlbQo+Pj4+Pj4KPj4+Pj4+IDEsIHFlbXUgY2hlY2sgdGhlIG1hYyBhZGRyZXNz
LCBpZiB0aGUgbWFjIGFkZHJlc3MgaXMgYWxsIDAsIHFlbXUgd2lsbAo+Pj4+Pj4gaWdub3JlIGl0
IGFuZCBzZXQgdGhlIHJhbmRvbSBtYWMgYWRkcmVzcyB0byBtbHggZHJpdmVyLgo+Pj4+PiBTbyBt
eSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIGlmIG1hYyBhZGRyZXNzIGlzIGFsbCAwLCB2RFBBIHBh
cmVudCBzaG91bGQgbm90Cj4+Pj4+IGFkdmVydGlzZSBWSVJUSU9fTkVUX0ZfTUFDLiBBbmQgcWVt
dSBzaG91bGQgZW11bGF0ZSB0aGlzIGZlYXR1cmUgYXMgeW91IGRpZDoKPj4+PiBUaGlua2luZyBp
dCBvdmVyLCBhdCBsZWFzdCBpbiBtbHg1LCBJIHNob3VsZCBhbHdheXMgYWR2ZXJ0aXNlCj4+Pj4g
VklSVElPX05FVF9GX01BQyBhbmQgc2V0IGEgbm9uIHplcm8gTUFDIHZhbHVlLiBUaGUgc291cmNl
IG9mIHRoZSBNQUMgY2FuCj4+Pj4gYmUgZWl0aGVyIHJhbmRvbWx5IGdlbmVyYXRlZCB2YWx1ZSBi
eSBtbHg1X3ZkcGEgb3IgYnkgYSBtYW5hZ2VtZW50IHRvb2wuCj4+Pj4gVGhpcyBpcyBpbXBvcnRh
bnQgYmVjYXVhc2Ugd2Ugc2hvdWxkIG5vdCBsZXQgdGhlIFZNIG1vZGlmeSB0aGUgTUFDLiBJZgo+
Pj4+IHdlIGRvIGl0IGNhbiBzZXQgYSBNQUMgdmFsdWUgaWRlbnRpY2FsIHRvIHRoZSBtbHg1IE5J
QyBkcml2ZXIgYW5kIGNhbgo+Pj4+IGtpZG5hcCB0cmFmZmljIHRoYXQgd2FzIG5vdCBkZXN0aW5l
ZCB0byBpdC4KPj4+Pgo+Pj4+IEluIGFkZGl0aW9uLCB3aGVuIFZJUlRJT19ORVRfRl9NQUMgaXMg
cHVibGlzaGVkLCBhdHRlbXB0cyB0byBjaGFuZ2UgdGhlCj4+Pj4gTUFDIGFkZHJlc3MgZnJvbSB0
aGUgVk0gc2hvdWxkIHJlc3VsdCBpbiBlcnJvci4KPj4+IFRoYXQgaXMgbm90IHdoYXQgdGhlIHNw
ZWMgc2F5cyB0aG91Z2guCj4+PiBWSVJUSU9fTkVUX0ZfTUFDIG9ubHkgc2F5cyB3aGV0aGVyIG1h
YyBpcyB2YWxpZCBpbiB0aGUgY29uZmlnIHNwYWNlLgo+Pj4gV2hldGhlciBndWVzdCBjYW4gY29u
dHJvbCB0aGF0IGRlcGVuZHMgb24gVklSVElPX05FVF9GX0NUUkxfTUFDX0FERFI6Cj4+Pgo+Pj4g
CVRoZSBWSVJUSU9fTkVUX0NUUkxfTUFDX0FERFJfU0VUIGNvbW1hbmQgaXMgdXNlZCB0byBzZXQg
dGhlIGRlZmF1bHQgTUFDIGFkZHJlc3Mgd2hpY2ggcngKPj4+IAlmaWx0ZXJpbmcgYWNjZXB0cyAo
YW5kIGlmIFZJUlRJT19ORVRfRl9NQUNfQUREUiBoYXMgYmVlbiBuZWdvdGlhdGVkLCB0aGlzIHdp
bGwgYmUgcmVmbGVjdGVkIGluIG1hYyBpbgo+Pj4gCWNvbmZpZyBzcGFjZSkuCj4+PiAJVGhlIGNv
bW1hbmQtc3BlY2lmaWMtZGF0YSBmb3IgVklSVElPX05FVF9DVFJMX01BQ19BRERSX1NFVCBpcyB0
aGUgNi1ieXRlIE1BQyBhZGRyZXNzLgo+PiBUd28gcXVlc3Rpb25zIGhlcmU6Cj4+IDEuIE5vdyB3
ZSBkb24ndCBoYXZlIHN1cHBvcnQgZm9yIGNvbnRyb2wgdmlydHF1ZXVlLiBZZXQsIHdlIG11c3Qg
ZmlsdGVyCj4+IHBhY2tldHMgYmFzZWQgb24gTUFDLCB3aGF0IGRvIHlvdSBzdWdnZXN0IHRvIGRv
IGhlcmU/Cj4gSG93IGFib3V0IGFuIGlvY3RsIHRvIHBhc3MgdGhlIG1hYyB0byB0aGUgZGV2aWNl
Pwo+IE1heWJlIG1pcnJvcmluZyB0aGUgY29udHJvbCB2cSBzdHJ1Y3QgZm9ybWF0IC4uLgoKCkkg
dGhpbmsgd2UnZCBiZXR0ZXIgYXZvaWQgc3VjaCBhZC1ob2MgaW9jdGxzIHRvIG1ha2Ugdmhvc3Qt
dkRQQSB0eXBlIAppbmRlcGVuZGVudC4gQW5kIGRvaW5nIHRoaXMgbWVhbnMgd2UgbmVlZCB0byBz
ZWVrIGFub3RoZXIgd2F5IGZvciAKdmlydGlvLXZkcGEgZHJpdmVycy4KClRoYW5rcwoKCj4KPj4g
Mi4gV2hlbiBjb250cm9sIHZpcnRxdWV1ZSBpcyBpbXBsZW1lbnRlZCwgd2hpY2ggYWRtaW4gZW50
aXR5IGlzIGFsbG93ZWQKPj4gdG8gY2hhbmdlIHRoZSBNQUMgZmlsdGVyaW5nIHRhYmxlPwo+IEl0
J3MgdXAgdG8gdGhlIGh5cGVydmlzb3I6IGlmIFZJUlRJT19ORVRfRl9DVFJMX01BQ19BRERSCj4g
aXMgZW5hYmxlZCB0aGlzIG1lYW5zIGh5cGVydmlzb3IgdHJ1c3RzIHRoZSBndWVzdCB3aXRoIGZ1
bGwKPiBhY2Nlc3MgdG8gTklDIG5ldHdvcmsuCj4gSWYgaXQncyBjbGVhciB0aGVuIG1hYyBtdXN0
IGJlIHNldCBieSBoYXJkd2FyZSBvciB0aGUgaHlwZXJ2aXNvci4KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

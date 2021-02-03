Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC65C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 05:16:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B2A61477
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 05:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B2A61477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 308E2860BF;
	Wed,  3 Feb 2021 05:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tQItZ77zEq6N; Wed,  3 Feb 2021 05:16:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 94D42860D2;
	Wed,  3 Feb 2021 05:16:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B455C0174;
	Wed,  3 Feb 2021 05:16:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0534C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A9562860D2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ml7mjUjX53MF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:16:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DF1B5860BF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 05:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612329384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RIuXnL+Hg9KeDbYH0PNTbg1/8jFx78+qdyuMnTHT5HY=;
 b=f0KZ7zlm/L87EotrTKbOvRm3xzc+GfwRCDim/rPGxVwIxdpoY6p4Bi2Pb1gc6oaU59+zBY
 xQJq4j7bH3LNEqmyWAQx9qmhMJ2Yn4t1Yt3r94c2MD3Ayxm3AI1AsGVl6SoV+r/AlR9b7A
 YCP8yV9EwPgh7P2r0AE7kKCRa6xpl9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-Y8GF8fAEOJOwDKjLcUuz0Q-1; Wed, 03 Feb 2021 00:16:22 -0500
X-MC-Unique: Y8GF8fAEOJOwDKjLcUuz0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AF4D107ACE3;
 Wed,  3 Feb 2021 05:16:21 +0000 (UTC)
Received: from [10.72.13.97] (ovpn-13-97.pek2.redhat.com [10.72.13.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 803D472167;
 Wed,  3 Feb 2021 05:16:15 +0000 (UTC)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Avoid unnecessary query virtqueue
To: Si-Wei Liu <siwliu.kernel@gmail.com>, Eli Cohen <elic@nvidia.com>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-2-elic@nvidia.com>
 <CAPWQSg0XtEQ1U5N3a767Ak_naoyPdVF1CeE4r3hmN11a-aoBxg@mail.gmail.com>
 <CAPWQSg3U9DCSK_01Kzuea5B1X+Ef9JB23wBY82A3ss-UXGek_Q@mail.gmail.com>
 <9d6058d6-5ce1-0442-8fd9-5a6fe6a0bc6b@redhat.com>
 <CAPWQSg3KOAypcrs9krW8cGE7EDLTehCUCYFZMUYYNaYPH1oBZQ@mail.gmail.com>
 <c65808bf-b336-8718-f7ea-b39fcc658dfb@redhat.com>
 <20210202070631.GA233234@mtl-vdi-166.wap.labs.mlnx>
 <CAPWQSg058RGaxSS7s5s=kpxdGryiy2padRFztUZtXN+ttiDd1A@mail.gmail.com>
 <20210202092253.GA236663@mtl-vdi-166.wap.labs.mlnx>
 <CAPWQSg0tRXoGF88LQSLzUg88ZEi8p+M=R6Qd445iABShfn-o4g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <eed86e79-4fd9-dfcf-da17-288a3fc597e3@redhat.com>
Date: Wed, 3 Feb 2021 13:16:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPWQSg0tRXoGF88LQSLzUg88ZEi8p+M=R6Qd445iABShfn-o4g@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: lulu@redhat.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>
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

Ck9uIDIwMjEvMi8zIOS4iuWNiDE6NTQsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gT24gVHVlLCBGZWIg
MiwgMjAyMSBhdCAxOjIzIEFNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3cm90ZToKPj4g
T24gVHVlLCBGZWIgMDIsIDIwMjEgYXQgMTI6Mzg6NTFBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90
ZToKPj4+IFRoYW5rcyBFbGkgYW5kIEphc29uIGZvciBjbGFyaWZpY2F0aW9ucy4gU2VlIGlubGlu
ZS4KPj4+Cj4+PiBPbiBNb24sIEZlYiAxLCAyMDIxIGF0IDExOjA2IFBNIEVsaSBDb2hlbiA8ZWxp
Y0BudmlkaWEuY29tPiB3cm90ZToKPj4+PiBPbiBUdWUsIEZlYiAwMiwgMjAyMSBhdCAwMjowMjoy
NVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiBPbiAyMDIxLzIvMiDkuIvljYgxMjox
NSwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+IE9uIE1vbiwgRmViIDEsIDIwMjEgYXQgNzoxMyBQ
TSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+PiBPbiAyMDIx
LzIvMiDkuIrljYgzOjE3LCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+PiBPbiBNb24sIEZlYiAx
LCAyMDIxIGF0IDEwOjUxIEFNIFNpLVdlaSBMaXUgPHNpd2xpdS5rZXJuZWxAZ21haWwuY29tPiB3
cm90ZToKPj4+Pj4+Pj4+IE9uIFRodSwgSmFuIDI4LCAyMDIxIGF0IDU6NDYgQU0gRWxpIENvaGVu
IDxlbGljQG52aWRpYS5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4+IHN1c3BlbmRfdnEgc2hvdWxkIG9u
bHkgc3VzcGVuZCB0aGUgVlEgb24gbm90IHNhdmUgdGhlIGN1cnJlbnQgYXZhaWxhYmxlCj4+Pj4+
Pj4+Pj4gaW5kZXguIFRoaXMgaXMgZG9uZSB3aGVuIGEgY2hhbmdlIG9mIG1hcCBvY2N1cnMgd2hl
biB0aGUgZHJpdmVyIGNhbGxzCj4+Pj4+Pj4+Pj4gc2F2ZV9jaGFubmVsX2luZm8oKS4KPj4+Pj4+
Pj4+IEhtbW0sIHN1c3BlbmRfdnEoKSBpcyBhbHNvIGNhbGxlZCBieSB0ZWFyZG93bl92cSgpLCB0
aGUgbGF0dGVyIG9mCj4+Pj4+Pj4+PiB3aGljaCBkb2Vzbid0IHNhdmUgdGhlIGF2YWlsYWJsZSBp
bmRleCBhcyBzYXZlX2NoYW5uZWxfaW5mbygpIGRvZXNuJ3QKPj4+Pj4+Pj4+IGdldCBjYWxsZWQg
aW4gdGhhdCBwYXRoIGF0IGFsbC4gSG93IGRvZXMgaXQgaGFuZGxlIHRoZSBjYXNlIHRoYXQKPj4+
Pj4+Pj4+IGFnZXRfdnFfc3RhdGUoKSBpcyBjYWxsZWQgZnJvbSB1c2Vyc3BhY2UgKGUuZy4gUUVN
VSkgd2hpbGUgdGhlCj4+Pj4+Pj4+PiBoYXJkd2FyZSBWUSBvYmplY3Qgd2FzIHRvcm4gZG93biwg
YnV0IHVzZXJzcGFjZSBzdGlsbCB3YW50cyB0byBhY2Nlc3MKPj4+Pj4+Pj4+IHRoZSBxdWV1ZSBp
bmRleD8KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBSZWZlciB0byBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9uZXRkZXYvMTYwMTU4MzUxMS0xNTEzOC0xLWdpdC1zZW5kLWVtYWlsLXNpLXdlaS5saXVAb3Jh
Y2xlLmNvbS8KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiB2aG9zdCBWUSAwIHJpbmcgcmVzdG9yZSBmYWls
ZWQ6IC0xOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZSAoMTEpCj4+Pj4+Pj4+PiB2
aG9zdCBWUSAxIHJpbmcgcmVzdG9yZSBmYWlsZWQ6IC0xOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1
bmF2YWlsYWJsZSAoMTEpCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gUUVNVSB3aWxsIGNvbXBsYWluIHdp
dGggdGhlIGFib3ZlIHdhcm5pbmcgd2hpbGUgVk0gaXMgYmVpbmcgcmVib290ZWQKPj4+Pj4+Pj4+
IG9yIHNodXQgZG93bi4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBMb29rcyB0byBtZSBlaXRoZXIgdGhl
IGtlcm5lbCBkcml2ZXIgc2hvdWxkIGNvdmVyIHRoaXMgcmVxdWlyZW1lbnQsIG9yCj4+Pj4+Pj4+
PiB0aGUgdXNlcnNwYWNlIGhhcyB0byBiZWFyIHRoZSBidXJkZW4gaW4gc2F2aW5nIHRoZSBpbmRl
eCBhbmQgbm90IGNhbGwKPj4+Pj4+Pj4+IGludG8ga2VybmVsIGlmIFZRIGlzIGRlc3Ryb3llZC4K
Pj4+Pj4+Pj4gQWN0dWFsbHksIHRoZSB1c2Vyc3BhY2UgZG9lc24ndCBoYXZlIHRoZSBpbnNpZ2h0
cyB3aGV0aGVyIHZpcnQgcXVldWUKPj4+Pj4+Pj4gd2lsbCBiZSBkZXN0cm95ZWQgaWYganVzdCBj
aGFuZ2luZyB0aGUgZGV2aWNlIHN0YXR1cyB2aWEgc2V0X3N0YXR1cygpLgo+Pj4+Pj4+PiBMb29r
aW5nIGF0IG90aGVyIHZkcGEgZHJpdmVyIGluIHRyZWUgaS5lLiBpZmN2ZiBpdCBkb2Vzbid0IGJl
aGF2ZSBsaWtlCj4+Pj4+Pj4+IHNvLiBIZW5jZSB0aGlzIHN0aWxsIGxvb2tzIHRvIG1lIHRvIGJl
IE1lbGxhbm94IHNwZWNpZmljcyBhbmQKPj4+Pj4+Pj4gbWx4NV92ZHBhIGltcGxlbWVudGF0aW9u
IGRldGFpbCB0aGF0IHNob3VsZG4ndCBleHBvc2UgdG8gdXNlcnNwYWNlLgo+Pj4+Pj4+IFNvIEkg
dGhpbmsgd2UgY2FuIHNpbXBseSBkcm9wIHRoaXMgcGF0Y2g/Cj4+Pj4+PiBZZXAsIEkgdGhpbmsg
c28uIFRvIGJlIGhvbmVzdCBJIGRvbid0IGtub3cgd2h5IGl0IGhhcyBhbnl0aGluZyB0byBkbwo+
Pj4+Pj4gd2l0aCB0aGUgbWVtb3J5IGhvdHBsdWcgaXNzdWUuCj4+Pj4+Cj4+Pj4+IEVsaSBtYXkg
a25vdyBtb3JlLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQsIGR1cmluZyBtZW1vcnkgaG90cGx1
dCwgcWVtdQo+Pj4+PiBuZWVkIHRvIHByb3BhZ2F0ZSBuZXcgbWVtb3J5IG1hcHBpbmdzIHZpYSBz
ZXRfbWFwKCkuIEZvciBtZWxsYW5veCwgaXQgbWVhbnMKPj4+Pj4gaXQgbmVlZHMgdG8gcmVidWls
ZCBtZW1vcnkga2V5cywgc28gdGhlIHZpcnRxdWV1ZSBuZWVkcyB0byBiZSBzdXNwZW5kZWQuCj4+
Pj4+Cj4+Pj4gSSB0aGluayBTaXdlaSB3YXMgYXNraW5nIHdoeSB0aGUgZmlyc3QgcGF0Y2ggd2Fz
IHJlbGF0ZWQgdG8gdGhlIGhvdHBsdWcKPj4+PiBpc3N1ZS4KPj4+IEkgd2FzIHRoaW5raW5nIGhv
dyBjb25zaXN0ZW5jeSBpcyBhc3N1cmVkIHdoZW4gc2F2aW5nL3Jlc3RvcmluZyB0aGlzCj4+PiBo
L3cgYXZhaWxfaW5kZXggYWdhaW5zdCB0aGUgb25lIGluIHRoZSB2aXJ0cSBtZW1vcnksIHBhcnRp
Y3VsYXJseSBpbgo+Pj4gdGhlIHJlZ2lvbl9hZGQvLnJlZ2lvbl9kZWwoKSBjb250ZXh0IChlLmcu
IHRoZSBob3RwbHVnIGNhc2UpLiBQcm9ibGVtCj4+PiBpcyBJIGRvbid0IHNlZSBleHBsaWNpdCBt
ZW1vcnkgYmFycmllciB3aGVuIGd1ZXN0IHRocmVhZCB1cGRhdGVzIHRoZQo+Pj4gYXZhaWxfaW5k
ZXgsIGhvdyBkb2VzIHRoZSBkZXZpY2UgbWFrZSBzdXJlIHRoZSBoL3cgYXZhaWxfaW5kZXggaXMK
Pj4+IHVwdG9kYXRlIHdoaWxlIGd1ZXN0IG1heSByYWNlIHdpdGggdXBkYXRpbmcgdGhlIHZpcnRx
J3MgYXZhaWxfaW5kZXggaW4KPj4+IHRoZSBtZWFuIHdoaWxlPyBNYXliZSBJIGNvbXBsZXRlbHkg
bWlzcyBzb21ldGhpbmcgb2J2aW91cz8KPj4gREtJTS1TaWduYXR1cmU6IHYxOyBhcnNhLXNoYTI1
NjsgY3JlbGF4ZWQvcmVsYXhlZDsgZG52aWRpYS5jb207IHNuMTsKPj4gICAgICAgICAgdCAxMjI1
Nzc4MDsgYmhIbkIwejRWRUt3UlMzV0dZOGQ4MzZNSmd4dTVFbG4vamJGWmxOWFZ4YzA4Owo+PiAg
ICAgICAgICBoWC1QR1AtVW5pdmVyc2FsOkRhdGU6RnJvbTpUbzpDQzpTdWJqZWN0Ok1lc3NhZ2Ut
SUQ6UmVmZXJlbmNlczoKPj4gICAgICAgICAgIE1JTUUtVmVyc2lvbjpDb250ZW50LVR5cGU6Q29u
dGVudC1EaXNwb3NpdGlvbjoKPj4gICAgICAgICAgIENvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6
SW4tUmVwbHktVG86VXNlci1BZ2VudDpYLU9yaWdpbmF0aW5nLUlQOgo+PiAgICAgICAgICAgWC1D
bGllbnRQcm94aWVkQnk7Cj4+ICAgICAgICAgIGJnR21iOCtyY24zL3JLektRLzdRelNuZ2hXelor
RkFVMFhudHNSWllHUTY2c0Z2VDd6c1lQSG9nRzNMSVdOWTc3dAo+PiAgICAgICAgICAgd05IUHc3
R0NKck5hSDNuRVhQYk9wMEZNT1p3NEt2NFc3VVB1WVBvYmJMZVRrdnVQQWlkakI4ZE00MnZ6KzFY
NjF0Cj4+ICAgICAgICAgICA5SVZRVDlYNGhuQXhSakk1Q3FaT280MUdTNFRsMVgreWtHb0ErVkU4
MEJSL1IvK25RM3RYRFZVTGZwcHplQit2dTMKPj4gICAgICAgICAgIFRXbm5wYVoyR3lvTnlQbE1p
eVZSa0hkWHpEVmdBNHVRSHh3SG43b3RHSzVKNGx6eXU4S3JGeVF0aVArZjZoZnU1dgo+PiAgICAg
ICAgICAgY3JKa1lTOGU5QStyZnpVbUtXdXlIY0tjbWhQaEFWSjRYZHB6WmNEWFhsTUhWeEc3blIx
bzg4eHR0QzZEMStvTklQCj4+ICAgICAgICAgICA5eEhJM0RrTkJwRXVBCj4+IElmIHlvdSdyZSBh
c2tpbmcgYWJvdXQgc3luY3Jvbml6YXRpb24gdXBvbiBob3QgcGx1ZyBvZiBtZW1vcnksIHRoZQo+
PiBoYXJkd2FyZSBhbHdheXMgZ29lcyB0byByZWFkIHRoZSBhdmFpbGFibGUgaW5kZXggZnJvbSBt
ZW1vcnkgd2hlbiBhIG5ldwo+PiBoYXJkd2FyZSBvYmplY3QgaXMgYXNzb2NpdGVkIHdpdGggYSB2
aXJ0cXVldWUuIFlvdSBjYW4gYXJndWUgdGhlbiB0aGF0Cj4+IHlvdSBkb24ndCBuZWVkIHRvIHJl
c3RvcmUgdGhlIGF2YWlsYWJsZSBpbmRleCBhbmQgeW91IG1heSBiZSByaWdodCBidXQKPj4gdGhp
cyBpcyB0aGUgY3VycmVjdCBpbnRlZmFjZSB0byB0aGUgZmlybXdhcmUuCj4+Cj4+Cj4+IElmIHlv
dSdyZSBhc2tpbmcgb24gZ2VuZXJhbGx5IGhvdyBzeW5jIGlzIGFzc3VyZWQgd2hlbiB0aGUgZ3Vl
c3QgdXBkYXRlcwo+PiB0aGUgYXZhaWxhYmxlIGluZGV4LCBjYW4geW91IHBsZWFzZSBzZW5kIGEg
cG9pbnRlciB0byB0aGUgY29kZSB3aGVyZSB5b3UKPj4gc2VlIHRoZSB1cGRhdGUgd2l0aG91dCBh
IG1lbW9yeSBiYXJyaWVyPwo+IFRoaXMgaXMgYSBzbmlwcGV0IG9mIHZpcnRxdWV1ZV9hZGRfc3Bs
aXQoKSB3aGVyZSBhdmFpbF9pbmRleCBnZXRzCj4gdXBkYXRlZCBieSBndWVzdDoKPgo+ICAgICAg
ICAgIC8qIFB1dCBlbnRyeSBpbiBhdmFpbGFibGUgYXJyYXkgKGJ1dCBkb24ndCB1cGRhdGUgYXZh
aWwtPmlkeCB1bnRpbCB0aGV5Cj4gICAgICAgICAgICogZG8gc3luYykuICovCj4gICAgICAgICAg
YXZhaWwgPSB2cS0+c3BsaXQuYXZhaWxfaWR4X3NoYWRvdyAmICh2cS0+c3BsaXQudnJpbmcubnVt
IC0gMSk7Cj4gICAgICAgICAgdnEtPnNwbGl0LnZyaW5nLmF2YWlsLT5yaW5nW2F2YWlsXSA9IGNw
dV90b192aXJ0aW8xNihfdnEtPnZkZXYsIGhlYWQpOwo+Cj4gICAgICAgICAgLyogRGVzY3JpcHRv
cnMgYW5kIGF2YWlsYWJsZSBhcnJheSBuZWVkIHRvIGJlIHNldCBiZWZvcmUgd2UgZXhwb3NlIHRo
ZQo+ICAgICAgICAgICAqIG5ldyBhdmFpbGFibGUgYXJyYXkgZW50cmllcy4gKi8KPiAgICAgICAg
ICB2aXJ0aW9fd21iKHZxLT53ZWFrX2JhcnJpZXJzKTsKPiAgICAgICAgICB2cS0+c3BsaXQuYXZh
aWxfaWR4X3NoYWRvdysrOwo+ICAgICAgICAgIHZxLT5zcGxpdC52cmluZy5hdmFpbC0+aWR4ID0g
Y3B1X3RvX3ZpcnRpbzE2KF92cS0+dmRldiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdnEtPnNwbGl0LmF2YWlsX2lkeF9zaGFkb3cpOwo+ICAgICAg
ICAgIHZxLT5udW1fYWRkZWQrKzsKPgo+IFRoZXJlJ3MgbWVtb3J5IGJhcnJpZXIgdG8gbWFrZSBz
dXJlIHRoZSB1cGRhdGUgdG8gZGVzY3JpcHRvciBhbmQKPiBhdmFpbGFibGUgcmluZyBpcyBzZWVu
IGJlZm9yZSB3cml0aW5nIHRvIHRoZSBhdmFpbC0+aWR4LCBidXQgdGhlcmUKPiBzZWVtcyBubyBn
dXJhbnRlZSB0aGF0IHRoaXMgdXBkYXRlIHdvdWxkIGZsdXNoIHRvIHRoZSBtZW1vcnkKPiBpbW1t
ZWRhdGVseSBlaXRoZXIgYmVmb3JlIG9yIGFmdGVyIHRoZSBtbHg1LXZkcGEgaXMgc3VzcGVuZWQg
YW5kIGdldHMKPiB0aGUgb2xkIGF2YWlsX2luZGV4IHZhbHVlIHN0YXNoZWQgc29tZXdoZXJlLiBJ
biB0aGlzIGNhc2UsIGhvdyBkb2VzCj4gdGhlIGhhcmR3YXJlIGVuc3VyZSB0aGUgY29uc2lzdGVu
Y3kgYmV0d2VlbiB0aGUgZ3Vlc3QgdmlydGlvIGFuZCBob3N0Cj4gbWx4NS12ZHBhPyBPciwgaXQg
Y29tcGxldGx5IHJlbGllcyBvbiBndWVzdCB0byB1cGRhdGUgdGhlIGF2YWlsX2luZGV4Cj4gb25j
ZSB0aGUgbmV4dCBidWZmZXIgaXMgYXZhaWxhYmxlLCBzbyB0aGF0IHRoZSBpbmRleCB3aWxsIGJl
IGluIHN5bmMKPiBhZ2Fpbj8KCgpJJ20gbm90IHN1cmUgSSBnZXQgdGhlIHF1ZXN0aW9uIGJ1dCBu
b3RpY2UgdGhhdCB0aGUgZHJpdmVyIHNob3VsZCBjaGVjayAKYW5kIG5vdGlmeSB2aXJ0cXVldWUg
d2hlbiBkZXZpY2Ugd2FudCBhIG5vdGlmaWNhdGlvbi4gU28gdGhlcmUncyBhIAp2aXJ0aW9fd21i
KCkgZS5nIGluOgoKc3RhdGljIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZV9zcGxpdChzdHJ1
Y3QgdmlydHF1ZXVlICpfdnEpCnsKIMKgwqDCoCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9
IHRvX3Z2cShfdnEpOwogwqDCoMKgIHUxNiBuZXcsIG9sZDsKIMKgwqDCoCBib29sIG5lZWRzX2tp
Y2s7CgogwqDCoMKgIFNUQVJUX1VTRSh2cSk7CiDCoMKgwqAgLyogV2UgbmVlZCB0byBleHBvc2Ug
YXZhaWxhYmxlIGFycmF5IGVudHJpZXMgYmVmb3JlIGNoZWNraW5nIGF2YWlsCiDCoMKgwqAgwqAq
IGV2ZW50LiAqLwogwqDCoMKgIHZpcnRpb19tYih2cS0+d2Vha19iYXJyaWVzKTsKCiDCoMKgwqAg
b2xkID0gdnEtPnNwbGl0LmF2YWlsX2lkeF9zaGFkb3cgLSB2cS0+bnVtX2FkZGVkOwogwqDCoMKg
IG5ldyA9IHZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93OwogwqDCoMKgIHZxLT5udW1fYWRkZWQg
PSAwOwoKKFNlZSB0aGUgY29tbWVudCBhYm92ZSB2aXJ0aW9fbWIoKSkuIFNvIHRoZSBhdmFpbCBp
ZHggaXMgZ3VhcmFudGVlZCB0byAKYmUgY29tbWl0dGVkIHRvIG1lbXJveShjYWNoZSBoaWVyYXJj
aHkpIGJlZm9yZSB0aGUgY2hlY2sgb2YgCm5vdGlmaWNhdGlvbi4gSSB0aGluayB3ZSBzeW5jIHRo
cm91Z2ggdGhpcy4KClRoYW5rcwoKCj4KPiBUaGFua3MsCj4gLVNpd2VpCj4KPj4+IFRoYW5rcywK
Pj4+IC1TaXdlaQo+Pj4KPj4+PiBCdXQgeW91J3JlIGNvcnJlY3QuIFdoZW4gbWVtb3J5IGlzIGFk
ZGVkLCBJIGdldCBhIG5ldyBtZW1vcnkgbWFwLiBUaGlzCj4+Pj4gcmVxdWlyZXMgbWUgdG8gYnVp
bGQgYSBuZXcgbWVtb3J5IGtleSBvYmplY3Qgd2hpY2ggY292ZXJzIHRoZSBuZXcgbWVtb3J5Cj4+
Pj4gbWFwLiBTaW5jZSB0aGUgdmlydHF1ZXVlIG9iamVjdHMgYXJlIHJlZmVyZW5jaW5nIHRoaXMg
bWVtb3J5IGtleSwgSSBuZWVkCj4+Pj4gdG8gZGVzdHJveSB0aGVtIGFuZCBidWlsZCBuZXcgb25l
cyByZWZlcm5jaW5nIHRoZSBuZXcgbWVtb3J5IGtleS4KPj4+Pgo+Pj4+PiBUaGFua3MKPj4+Pj4K
Pj4+Pj4KPj4+Pj4+IC1TaXdlaQo+Pj4+Pj4KPj4+Pj4+PiBUaGFua3MKPj4+Pj4+Pgo+Pj4+Pj4+
Cj4+Pj4+Pj4+PiAtU2l3ZWkKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+
Pj4+ICAgICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA4IC0tLS0tLS0tCj4+
Pj4+Pj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQo+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBi
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4+IGluZGV4IDg4ZGRl
MzQ1NWJmZC4uNTQ5ZGVkMDc0ZmYzIDEwMDY0NAo+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+Pj4+IEBAIC0xMTQ4LDggKzExNDgsNiBAQCBzdGF0aWMg
aW50IHNldHVwX3ZxKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBh
X3ZpcnRxdWV1ZSAqbXZxKQo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gICAgIHN0YXRpYyB2b2lkIHN1
c3BlbmRfdnEoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmly
dHF1ZXVlICptdnEpCj4+Pj4+Pj4+Pj4gICAgIHsKPj4+Pj4+Pj4+PiAtICAgICAgIHN0cnVjdCBt
bHg1X3ZpcnRxX2F0dHIgYXR0cjsKPj4+Pj4+Pj4+PiAtCj4+Pj4+Pj4+Pj4gICAgICAgICAgICBp
ZiAoIW12cS0+aW5pdGlhbGl6ZWQpCj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIHJldHVy
bjsKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEBAIC0xMTU4LDEyICsxMTU2LDYgQEAgc3RhdGljIHZv
aWQgc3VzcGVuZF92cShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRw
YV92aXJ0cXVldWUgKm0KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+ICAgICAgICAgICAgaWYgKG1vZGlm
eV92aXJ0cXVldWUobmRldiwgbXZxLCBNTFg1X1ZJUlRJT19ORVRfUV9PQkpFQ1RfU1RBVEVfU1VT
UEVORCkpCj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKCZuZGV2
LT5tdmRldiwgIm1vZGlmeSB0byBzdXNwZW5kIGZhaWxlZFxuIik7Cj4+Pj4+Pj4+Pj4gLQo+Pj4+
Pj4+Pj4+IC0gICAgICAgaWYgKHF1ZXJ5X3ZpcnRxdWV1ZShuZGV2LCBtdnEsICZhdHRyKSkgewo+
Pj4+Pj4+Pj4+IC0gICAgICAgICAgICAgICBtbHg1X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJm
YWlsZWQgdG8gcXVlcnkgdmlydHF1ZXVlXG4iKTsKPj4+Pj4+Pj4+PiAtICAgICAgICAgICAgICAg
cmV0dXJuOwo+Pj4+Pj4+Pj4+IC0gICAgICAgfQo+Pj4+Pj4+Pj4+IC0gICAgICAgbXZxLT5hdmFp
bF9pZHggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+Pj4+Pj4+PiAgICAgfQo+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4gICAgIHN0YXRpYyB2b2lkIHN1c3BlbmRfdnFzKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2KQo+Pj4+Pj4+Pj4+IC0tCj4+Pj4+Pj4+Pj4gMi4yOS4yCj4+Pj4+Pj4+Pj4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==

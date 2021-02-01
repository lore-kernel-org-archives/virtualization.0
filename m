Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE7C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 07:23:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1323D64E2F
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 07:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1323D64E2F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D575864B2;
	Mon,  1 Feb 2021 07:23:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RlAS3PHEQcai; Mon,  1 Feb 2021 07:23:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4161A8389C;
	Mon,  1 Feb 2021 07:23:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2371DC0FA7;
	Mon,  1 Feb 2021 07:23:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB79C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 07:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BC0FD844E4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 07:23:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lQVHbXdGwUBt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 07:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BA04F80ACD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 07:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612164192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KlyzdQzXl3aPikAn68T+MmyWRqw+d/cvL92qDQmx7IA=;
 b=BXuMUofZ2RV1RviPp9hE1P7OqbNDoYqMQrtRctiokhr3GYQ/C+d+h+ZMpZAriZcMpwVz3E
 XxLfxbFoqJarLuaDN6bI4bGyTu/7QfDRdFlKVQ+AFERI60obzMv+FIyHmdvURHydXPFHxO
 w9YCJ7oA4uhnVIOH6LG+7acZsBe6vII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-i0x7hE8ZM4yi-n9XoYSA0A-1; Mon, 01 Feb 2021 02:23:08 -0500
X-MC-Unique: i0x7hE8ZM4yi-n9XoYSA0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6FD3800D55;
 Mon,  1 Feb 2021 07:23:07 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D94226F44F;
 Mon,  1 Feb 2021 07:23:02 +0000 (UTC)
Subject: Re: [PATCH 2/2] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-3-elic@nvidia.com>
 <54239b51-918c-3475-dc88-4da1a4548da8@redhat.com>
 <20210131185536.GA164217@mtl-vdi-166.wap.labs.mlnx>
 <0c99f35c-7644-7201-cd11-7d486389a182@redhat.com>
 <20210201055247.GA184807@mtl-vdi-166.wap.labs.mlnx>
 <c013407d-7a6a-adaa-efd1-24a8a48dc6fa@redhat.com>
 <20210201063835.GA185985@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fb9407a9-224a-d8be-ef1d-8bdf9b316953@redhat.com>
Date: Mon, 1 Feb 2021 15:23:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210201063835.GA185985@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lulu@redhat.com, mst@redhat.com
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

Ck9uIDIwMjEvMi8xIOS4i+WNiDI6MzgsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBNb24sIEZlYiAw
MSwgMjAyMSBhdCAwMjowMDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiAyMDIx
LzIvMSDkuIvljYgxOjUyLCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAwMSwgMjAy
MSBhdCAxMTozNjoyM0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEvMi8x
IOS4iuWNiDI6NTUsIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4gT24gRnJpLCBKYW4gMjksIDIwMjEg
YXQgMTE6NDk6NDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IE9uIDIwMjEvMS8y
OCDkuIvljYg5OjQxLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+Pj4gV2hlbiBhIGNoYW5nZSBvZiBt
ZW1vcnkgbWFwIG9jY3VycywgdGhlIGhhcmR3YXJlIHJlc291cmNlcyBhcmUgZGVzdHJveWVkCj4+
Pj4+Pj4gYW5kIHRoZW4gcmUtY3JlYXRlZCBhZ2FpbiB3aXRoIHRoZSBuZXcgbWVtb3J5IG1hcC4g
SW4gc3VjaCBjYXNlLCB3ZSBuZWVkCj4+Pj4+Pj4gdG8gcmVzdG9yZSB0aGUgaGFyZHdhcmUgYXZh
aWxhYmxlIGFuZCB1c2VkIGluZGljZXMuIFRoZSBkcml2ZXIgZmFpbGVkIHRvCj4+Pj4+Pj4gcmVz
dG9yZSB0aGUgdXNlZCBpbmRleCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Pj4+Pj4+Cj4+Pj4+Pj4g
Rml4ZXMgMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBv
cnRlZCBtbHg1IGRldmljZXMiKQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxp
Y0BudmlkaWEuY29tPgo+Pj4+Pj4gQSBxdWVzdGlvbi4gRG9lcyB0aGlzIG1lYW4gYWZ0ZXIgYSB2
cSBpcyBzdXNwZW5kZWQsIHRoZSBodyB1c2VkIGluZGV4IGlzIG5vdAo+Pj4+Pj4gZXF1YWwgdG8g
dnEgdXNlZCBpbmRleD8KPj4+Pj4gU3VyZWx5IHRoZXJlIGlzIGp1c3Qgb25lICJVc2VkIGluZGV4
IiBmb3IgYSBWUS4gV2hhdCBJIHdhcyB0cnlpbmcgdG8gc2F5Cj4+Pj4+IGlzIHRoYXQgYWZ0ZXIg
dGhlIFZRIGlzIHN1c3BlbmRlZCwgSSByZWFkIHRoZSB1c2VkIGluZGV4IGJ5IHF1ZXJ5aW5nIHRo
ZQo+Pj4+PiBoYXJkd2FyZS4gVGhlIHJlYWQgcmVzdWx0IGlzIHRoZSB1c2VkIGluZGV4IHRoYXQg
dGhlIGhhcmR3YXJlIHdyb3RlIHRvCj4+Pj4+IG1lbW9yeS4KPj4+PiBKdXN0IHRvIG1ha2Ugc3Vy
ZSBJIHVuZGVyc3RhbmQgaGVyZS4gU28gaXQgbG9va3MgdG8gbWUgd2UgaGFkIHR3byBpbmRleC4g
VGhlCj4+Pj4gZmlyc3QgaXMgdGhlIHVzZWQgaW5kZXggd2hpY2ggaXMgc3RvcmVkIGluIHRoZSBt
ZW1vcnkvdmlydHF1ZXVlLCB0aGUgc2Vjb25kCj4+Pj4gaXMgdGhlIG9uZSB0aGF0IGlzIHN0b3Jl
ZCBieSB0aGUgZGV2aWNlLgo+Pj4+Cj4+PiBJdCBpcyB0aGUgc3RydWN0dXJlcyBkZWZpbmVkIGlu
IHRoZSB2aXJ0aW8gc3BlYyBpbiAyLjYuNiBmb3IgdGhlCj4+PiBhdmFpbGFibGUgcmluZyBhbmQg
Mi42LjggZm9yIHRoZSB1c2VkIHJpbmcuIEFzIHlvdSBrbm93IHRoZXNlIHRoZQo+Pj4gYXZhaWxh
YmxlIHJpbmcgaXMgd3JpdHRlbiB0byBieSB0aGUgZHJpdmVyIGFuZCByZWFkIGJ5IHRoZSBkZXZp
Y2UuIFRoZQo+Pj4gb3Bwb3NpdGUgaGFwcGVucyBmb3IgdGhlIHVzZWQgaW5kZXguCj4+Cj4+IFJp
Z2h0LCBzbyBmb3IgdXNlZCBpbmRleCBpdCB3YXMgd3JvdGUgYnkgZGV2aWNlLiBBbmQgdGhlIGRl
dmljZSBzaG91bGQgaGF2ZQo+PiBhbiBpbnRlcm5hbCB1c2VkIGluZGV4IHZhbHVlIHRoYXQgaXMg
dXNlZCB0byB3cml0ZSB0byB0aGUgdXNlZCByaW5nLiBBbmQgdGhlCj4+IGNvZGUgaXMgdXNlZCB0
byBzeW5jIHRoZSBkZXZpY2UgaW50ZXJuYWwgdXNlZCBpbmRleCBpZiBJIHVuZGVyc3RhbmQgdGhp
cwo+PiBjb3JyZWN0bHkuCj4+Cj4+Cj4+PiBUaGUgcmVhc29uIEkgbmVlZCB0byByZXN0b3JlIHRo
ZSBsYXN0IGtub3duIGluZGljZXMgaXMgZm9yIHRoZSBuZXcKPj4+IGhhcmR3YXJlIG9iamVjdHMg
dG8gc3luYyBvbiB0aGUgbGFzdCBzdGF0ZSBhbmQgdGFrZSBvdmVyIGZyb20gdGhlcmUuCj4+Cj4+
IFJpZ2h0LCBhZnRlciB0aGUgdnEgc3VzcGVuZGluZywgdGhlIHF1ZXN0aW9ucyBhcmU6Cj4+Cj4+
IDEpIGlzIGhhcmR3YXJlIGludGVybmFsIHVzZWQgaW5kZXggbWlnaHQgbm90IGJlIHRoZSBzYW1l
IHdpdGggdGhlIHVzZWQgaW5kZXgKPj4gaW4gdGhlIHZpcnRxdWV1ZT8KPj4KPiBHZW5lcmFsbHkg
dGhlIGFuc3dlciBpcyBubyBiZWNhdXNlIHRoZSBoYXJkd2FyZSBpcyB0aGUgb25seSBvbmUgd3Jp
dGluZwo+IGl0LiBOZXcgb2JqZWN0cyBzdGFydCB1cCB3aXRoIHRoZSBpbml0aWFsIHZhbHVlIGNv
bmZpZ3VyZWQgdG8gdGhlbSB1cG9uCj4gY3JlYXRpb24uIFRoaXMgdmFsdWUgd2FzIHplcm8gYmVm
b3JlIHRoaXMgY2hhbmdlLgo+IFlvdSBjb3VsZCBhcmd1ZSB0aGF0IHNpbmNlIHRoZSBoYXJkd2Fy
ZSBoYXMgYWNjZXNzIHRvIHZpcnRxdWV1ZSBtZW1vcnksCj4gaXQgY291bGQganVzdCByZWFkIHRo
ZSB2YWx1ZSBmcm9tIHRoZXJlIGJ1dCBpdCBkb2VzIG5vdC4KCgpJIHNlZS4KCgo+Cj4+IG9yCj4+
Cj4+IDIpIGNhbiB3ZSBzaW1wbHkgc3luYyB0aGUgdmlydHF1ZXVlJ3MgdXNlZCBpbmRleCB0byB0
aGUgaGFyZHdhcmUncyB1c2VkCj4+IGluZGV4Pwo+Pgo+IFRoZW9yZXRpY2FsbHkgaXQgY291bGQg
YmUgZG9uZSBidXQgdGhhdCdzIG5vdCBob3cgdGhlIGhhcmR3YXJlIHdvcmtzLgo+IE9uZSByZWFz
b24gaXMgdGhhdCBpcyBub3Qgc3VwcG9zZWQgdG8gcmVhZCBmcm9tIHRoYXQgYXJlYS4gQnV0IGl0
IGlzCj4gcmVhbGx5IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uIGRldGFpbC4KCgpJIGdldCB5b3Ug
bm93LgoKU28KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhh
bmtzCgoKPj4+Pj4gICAgIEFmdGVyIHRoZSBJIGNyZWF0ZSB0aGUgbmV3IGhhcmR3YXJlIG9iamVj
dCwgSSBuZWVkIHRvIHRlbGwgaXQKPj4+Pj4gd2hhdCBpcyB0aGUgdXNlZCBpbmRleCAoYW5kIHRo
ZSBhdmFpbGFibGUgaW5kZXgpIGFzIGEgd2F5IHRvIHN5bmMgaXQKPj4+Pj4gd2l0aCB0aGUgZXhp
c3RpbmcgVlEuCj4+Pj4gRm9yIGF2YWlsIGluZGV4IEkgdW5kZXJzdGFuZCB0aGF0IHRoZSBoYXJk
d2FyZSBpbmRleCBpcyBub3Qgc3luY2VkIHdpdGggdGhlCj4+Pj4gYXZhaWwgaW5kZXggc3RvcmVk
IGluIHRoZSBtZW1vcnkvdmlydHF1ZXVlLiBUaGUgcXVlc3Rpb24gaXMgdXNlZCBpbmRleCwgaWYK
Pj4+PiB0aGUgaGFyZHdhcmUgb25lIGlzIG5vdCBzeW5jZWQgd2l0aCB0aGUgb25lIGluIHRoZSB2
aXJ0cXVldWUuIEl0IG1lYW5zIGFmdGVyCj4+Pj4gdnEgaXMgc3VzcGVuZGVkLMKgIHNvbWUgcmVx
dWVzdHMgaXMgbm90IGNvbXBsZXRlZCBieSB0aGUgaGFyZHdhcmUgKGUuZyB0aGUKPj4+PiBidWZm
ZXIgd2VyZSBub3QgcHV0IHRvIHVzZWQgcmluZykuCj4+Pj4KPj4+PiBUaGlzIG1heSBoYXZlIGlt
cGxpY2F0aW9ucyB0byBsaXZlIG1pZ3JhdGlvbiwgaXQgbWVhbnMgdGhvc2UgdW5hY2NvbXBsaXNo
ZWQKPj4+PiByZXF1ZXN0cyBuZWVkcyB0byBiZSBtaWdyYXRlZCB0byB0aGUgZGVzdGluYXRpb24g
YW5kIHJlc3VibWl0dGVkIHRvIHRoZQo+Pj4+IGRldmljZS4gVGhpcyBsb29rcyBub3QgZWFzeS4K
Pj4+Pgo+Pj4+IFRoYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gVGhpcyBzeW5jIGlzIGVzcGVjaWFsbHkg
aW1wb3J0YW50IHdoZW4gYSBjaGFuZ2Ugb2YgbWFwIG9jY3VycyB3aGlsZSB0aGUKPj4+Pj4gVlEg
d2FzIGFscmVhZHkgdXNlZCAoaGVuY2UgdGhlIGluZGljZXMgYXJlIGxpa2VseSB0byBiZSBub24g
emVybykuIFRoaXMKPj4+Pj4gY2FuIGJlIHRyaWdnZXJlZCBieSBob3QgYWRkaW5nIG1lbW9yeSBh
ZnRlciB0aGUgVlFzIGhhdmUgYmVlbiB1c2VkLgo+Pj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+
Pj4+Pj4KPj4+Pj4+PiAtLS0KPj4+Pj4+PiAgICAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyB8IDcgKysrKysrKwo+Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKQo+Pj4+Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+
IGluZGV4IDU0OWRlZDA3NGZmMy4uM2ZjODU4OGNlY2FlIDEwMDY0NAo+Pj4+Pj4+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+IEBAIC04Nyw2ICs4Nyw3IEBAIHN0cnVjdCBt
bHg1X3ZxX3Jlc3RvcmVfaW5mbyB7Cj4+Pj4+Pj4gICAgICAJdTY0IGRldmljZV9hZGRyOwo+Pj4+
Pj4+ICAgICAgCXU2NCBkcml2ZXJfYWRkcjsKPj4+Pj4+PiAgICAgIAl1MTYgYXZhaWxfaW5kZXg7
Cj4+Pj4+Pj4gKwl1MTYgdXNlZF9pbmRleDsKPj4+Pj4+PiAgICAgIAlib29sIHJlYWR5Owo+Pj4+
Pj4+ICAgICAgCXN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+Pj4+Pj4+ICAgICAgCWJvb2wgcmVz
dG9yZTsKPj4+Pj4+PiBAQCAtMTIxLDYgKzEyMiw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1
ZXVlIHsKPj4+Pj4+PiAgICAgIAl1MzIgdmlydHFfaWQ7Cj4+Pj4+Pj4gICAgICAJc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXY7Cj4+Pj4+Pj4gICAgICAJdTE2IGF2YWlsX2lkeDsKPj4+Pj4+PiAr
CXUxNiB1c2VkX2lkeDsKPj4+Pj4+PiAgICAgIAlpbnQgZndfc3RhdGU7Cj4+Pj4+Pj4gICAgICAJ
Lyoga2VlcCBsYXN0IGluIHRoZSBzdHJ1Y3QgKi8KPj4+Pj4+PiBAQCAtODA0LDYgKzgwNiw3IEBA
IHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwg
c3RydWN0IG1seDVfdmRwYV92aXJ0cXVlCj4+Pj4+Pj4gICAgICAJb2JqX2NvbnRleHQgPSBNTFg1
X0FERFJfT0YoY3JlYXRlX3ZpcnRpb19uZXRfcV9pbiwgaW4sIG9ial9jb250ZXh0KTsKPj4+Pj4+
PiAgICAgIAlNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfYXZh
aWxhYmxlX2luZGV4LCBtdnEtPmF2YWlsX2lkeCk7Cj4+Pj4+Pj4gKwlNTFg1X1NFVCh2aXJ0aW9f
bmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfdXNlZF9pbmRleCwgbXZxLT51c2VkX2lkeCk7
Cj4+Pj4+Pj4gICAgICAJTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQs
IHF1ZXVlX2ZlYXR1cmVfYml0X21hc2tfMTJfMywKPj4+Pj4+PiAgICAgIAkJIGdldF9mZWF0dXJl
c18xMl8zKG5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+Pj4+Pj4+ICAgICAgCXZxX2N0
eCA9IE1MWDVfQUREUl9PRih2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgdmlydGlv
X3FfY29udGV4dCk7Cj4+Pj4+Pj4gQEAgLTEwMjIsNiArMTAyNSw3IEBAIHN0YXRpYyBpbnQgY29u
bmVjdF9xcHMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmly
dHF1ZXVlICptCj4+Pj4+Pj4gICAgICBzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIHsKPj4+Pj4+PiAg
ICAgIAl1OCBzdGF0ZTsKPj4+Pj4+PiAgICAgIAl1MTYgYXZhaWxhYmxlX2luZGV4Owo+Pj4+Pj4+
ICsJdTE2IHVzZWRfaW5kZXg7Cj4+Pj4+Pj4gICAgICB9Owo+Pj4+Pj4+ICAgICAgc3RhdGljIGlu
dCBxdWVyeV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1
X3ZkcGFfdmlydHF1ZXVlICptdnEsCj4+Pj4+Pj4gQEAgLTEwNTIsNiArMTA1Niw3IEBAIHN0YXRp
YyBpbnQgcXVlcnlfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3Qg
bWx4NV92ZHBhX3ZpcnRxdWV1Cj4+Pj4+Pj4gICAgICAJbWVtc2V0KGF0dHIsIDAsIHNpemVvZigq
YXR0cikpOwo+Pj4+Pj4+ICAgICAgCWF0dHItPnN0YXRlID0gTUxYNV9HRVQodmlydGlvX25ldF9x
X29iamVjdCwgb2JqX2NvbnRleHQsIHN0YXRlKTsKPj4+Pj4+PiAgICAgIAlhdHRyLT5hdmFpbGFi
bGVfaW5kZXggPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdf
YXZhaWxhYmxlX2luZGV4KTsKPj4+Pj4+PiArCWF0dHItPnVzZWRfaW5kZXggPSBNTFg1X0dFVCh2
aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfdXNlZF9pbmRleCk7Cj4+Pj4+Pj4g
ICAgICAJa2ZyZWUob3V0KTsKPj4+Pj4+PiAgICAgIAlyZXR1cm4gMDsKPj4+Pj4+PiBAQCAtMTYw
Miw2ICsxNjA3LDcgQEAgc3RhdGljIGludCBzYXZlX2NoYW5uZWxfaW5mbyhzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXUKPj4+Pj4+PiAgICAgIAkJcmV0
dXJuIGVycjsKPj4+Pj4+PiAgICAgIAlyaS0+YXZhaWxfaW5kZXggPSBhdHRyLmF2YWlsYWJsZV9p
bmRleDsKPj4+Pj4+PiArCXJpLT51c2VkX2luZGV4ID0gYXR0ci51c2VkX2luZGV4Owo+Pj4+Pj4+
ICAgICAgCXJpLT5yZWFkeSA9IG12cS0+cmVhZHk7Cj4+Pj4+Pj4gICAgICAJcmktPm51bV9lbnQg
PSBtdnEtPm51bV9lbnQ7Cj4+Pj4+Pj4gICAgICAJcmktPmRlc2NfYWRkciA9IG12cS0+ZGVzY19h
ZGRyOwo+Pj4+Pj4+IEBAIC0xNjQ2LDYgKzE2NTIsNyBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX2No
YW5uZWxzX2luZm8oc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+Pj4+Pj4gICAgICAJCQlj
b250aW51ZTsKPj4+Pj4+PiAgICAgIAkJbXZxLT5hdmFpbF9pZHggPSByaS0+YXZhaWxfaW5kZXg7
Cj4+Pj4+Pj4gKwkJbXZxLT51c2VkX2lkeCA9IHJpLT51c2VkX2luZGV4Owo+Pj4+Pj4+ICAgICAg
CQltdnEtPnJlYWR5ID0gcmktPnJlYWR5Owo+Pj4+Pj4+ICAgICAgCQltdnEtPm51bV9lbnQgPSBy
aS0+bnVtX2VudDsKPj4+Pj4+PiAgICAgIAkJbXZxLT5kZXNjX2FkZHIgPSByaS0+ZGVzY19hZGRy
OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u

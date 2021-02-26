Return-Path: <SRS0=m8lA=H4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF454C433DB
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:19:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554CB64EE2
	for <virtualization@archiver.kernel.org>; Fri, 26 Feb 2021 08:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554CB64EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBC484EF2F;
	Fri, 26 Feb 2021 08:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FZXcDFe5UXez; Fri, 26 Feb 2021 08:19:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 051814EF33;
	Fri, 26 Feb 2021 08:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB3EC000A;
	Fri, 26 Feb 2021 08:19:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 926ACC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:19:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A5DF6059B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:19:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0fzfgzxMOr1o
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D45F7600CA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614327568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YkkxHy8+oZlo7XWbd6ridzKeKE9I3rLqgz5IZ/AXVU=;
 b=SvQ7UYuT/Vbnx+MrLTePzOWt0zjVFweDEMuaCRbqCOMhw4ktPR0nCGCLMWDXmBQ2k/zrXl
 xHaAhf79/1/YD2KcrtvqkGLlobeohahbsbYLZYAak+8gAEn1ra2rkThXlcZyARbWuu4Q1r
 2dV7+ITWf4FQf3p0WCBVXPgM8W37K2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-RNboLv4rPpiYWI238HpZBA-1; Fri, 26 Feb 2021 03:19:25 -0500
X-MC-Unique: RNboLv4rPpiYWI238HpZBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A1701005501;
 Fri, 26 Feb 2021 08:19:24 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-20.pek2.redhat.com
 [10.72.12.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CE5A61F55;
 Fri, 26 Feb 2021 08:19:18 +0000 (UTC)
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223110430.2f098bc0.cohuck@redhat.com>
 <bbb0a09e-17e1-a397-1b64-6ce9afe18e44@redhat.com>
 <20210223115833.732d809c.cohuck@redhat.com>
 <8355f9b3-4cda-cd2e-98df-fed020193008@redhat.com>
 <20210224121234.0127ae4b.cohuck@redhat.com>
 <be6713d3-ac98-bbbf-1dc1-a003ed06a156@redhat.com>
 <20210225135229-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f8eb381-cc98-9e05-0e35-ccdb1cbd6119@redhat.com>
Date: Fri, 26 Feb 2021 16:19:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210225135229-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>,
 elic@nvidia.com
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

Ck9uIDIwMjEvMi8yNiAyOjUzIOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFRodSwgRmViIDI1LCAyMDIxIGF0IDEyOjM2OjA3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjEvMi8yNCA3OjEyIOS4i+WNiCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPj4+IE9u
IFdlZCwgMjQgRmViIDIwMjEgMTc6Mjk6MDcgKzA4MDAKPj4+IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4KPj4+PiBPbiAyMDIxLzIvMjMgNjo1OCDkuIvljYgsIENv
cm5lbGlhIEh1Y2sgd3JvdGU6Cj4+Pj4+IE9uIFR1ZSwgMjMgRmViIDIwMjEgMTg6MzE6MDcgKzA4
MDAKPj4+Pj4gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiBP
biAyMDIxLzIvMjMgNjowNCDkuIvljYgsIENvcm5lbGlhIEh1Y2sgd3JvdGU6Cj4+Pj4+Pj4gT24g
VHVlLCAyMyBGZWIgMjAyMSAxNzo0NjoyMCArMDgwMAo+Pj4+Pj4+IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+PiBPbiAyMDIxLzIvMjMg5LiL5Y2INToyNSwg
TWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+Pj4+Pj4gT24gTW9uLCBGZWIgMjIsIDIwMjEg
YXQgMDk6MDk6MjhBTSAtMDgwMCwgU2ktV2VpIExpdSB3cm90ZToKPj4+Pj4+Pj4+PiBPbiAyLzIx
LzIwMjEgODoxNCBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4+Pj4gT24gMjAyMS8yLzE5
IDc6NTQg5LiL5Y2ILCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4gQ29tbWl0IDQ1MjYz
OWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+Pj4+Pj4+
Pj4+Pj4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhjZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRv
IHJlc2V0Cj4+Pj4+Pj4+Pj4+PiBmZWF0dXJlcyB0byAwLCB3aGVuIGNvbmZpZyBzcGFjZSBpcyBh
Y2Nlc3NlZCBiZWZvcmUgZmVhdHVyZXMKPj4+Pj4+Pj4+Pj4+IGFyZSBzZXQuIFdlIHNob3VsZCBy
ZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sKPj4+Pj4+Pj4+Pj4+IGFuZCBh
bGxvdyBmZWF0dXJlcyByZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNv
dWxkIGFjY2Vzcwo+Pj4+Pj4+Pj4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUg
c2V0LiBGb3IgaW5zdGFuY2UsIHdoZW4KPj4+Pj4+Pj4+Pj4+IGZlYXR1cmUgVklSVElPX05FVF9G
X01UVSBpcyBhZHZlcnRpc2VkIHNvbWUgbW9kZXJuIGRyaXZlcgo+Pj4+Pj4+Pj4+Pj4gd2lsbCB0
cnkgdG8gYWNjZXNzIGFuZCB2YWxpZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+
Pj4+Pj4+Pj4+Pj4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0Lgo+Pj4+Pj4+
Pj4+PiBUaGlzIGxvb2tzIGxpa2UgYSBzcGVjIHZpb2xhdGlvbjoKPj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4gIgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFk
LW9ubHkgZmllbGQsIG10dSBvbmx5IGV4aXN0cyBpZgo+Pj4+Pj4+Pj4+PiBWSVJUSU9fTkVUX0Zf
TVRVIGlzIHNldC4gVGhpcyBmaWVsZCBzcGVjaWZpZXMgdGhlIG1heGltdW0gTVRVIGZvciB0aGUK
Pj4+Pj4+Pj4+Pj4gZHJpdmVyIHRvIHVzZS4KPj4+Pj4+Pj4+Pj4gIgo+Pj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+PiBEbyB3ZSByZWFsbHkgd2FudCB0byB3b3JrYXJvdW5kIHRoaXM/Cj4+Pj4+Pj4+Pj4g
SXNuJ3QgdGhlIGNvbW1pdCA0NTI2MzlhNjRhZDggaXRzZWxmIGlzIGEgd29ya2Fyb3VuZCBmb3Ig
bGVnYWN5IGd1ZXN0Pwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gSSB0aGluayB0aGUgcG9pbnQgaXMs
IHNpbmNlIHRoZXJlJ3MgbGVnYWN5IGd1ZXN0IHdlJ2QgaGF2ZSB0byBzdXBwb3J0LCB0aGlzCj4+
Pj4+Pj4+Pj4gaG9zdCBzaWRlIHdvcmthcm91bmQgaXMgdW5hdm9pZGFibGUuIEFsdGhvdWdoIEkg
YWdyZWUgdGhlIHZpb2xhdGluZyBkcml2ZXIKPj4+Pj4+Pj4+PiBzaG91bGQgYmUgZml4ZWQgKHll
cywgaXQncyBpbiB0b2RheSdzIHVwc3RyZWFtIGtlcm5lbCB3aGljaCBleGlzdHMgZm9yIGEKPj4+
Pj4+Pj4+PiB3aGlsZSBub3cpLgo+Pj4+Pj4+Pj4gT2ggIHlvdSBhcmUgcmlnaHQ6Cj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IHN0YXRpYyBpbnQgdmlydG5ldF92YWxpZGF0ZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqdmRldikKPj4+Pj4+Pj4+IHsKPj4+Pj4+Pj4+ICAgICAgICAgICAgICBp
ZiAoIXZkZXYtPmNvbmZpZy0+Z2V0KSB7Cj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICBk
ZXZfZXJyKCZ2ZGV2LT5kZXYsICIlcyBmYWlsdXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4i
LAo+Pj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7Cj4+Pj4+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKPj4+Pj4+Pj4+ICAgICAg
ICAgICAgICB9Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gICAgICAgICAgICAgIGlmICghdmlydG5ldF92
YWxpZGF0ZV9mZWF0dXJlcyh2ZGV2KSkKPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgICAgICAgICBpZiAodmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NVFUpKSB7Cj4+Pj4+Pj4+PiAgICAgICAg
ICAgICAgICAgICAgICBpbnQgbXR1ID0gdmlydGlvX2NyZWFkMTYodmRldiwKPj4+Pj4+Pj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXRvZihzdHJ1
Y3QgdmlydGlvX25ldF9jb25maWcsCj4+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXR1KSk7Cj4+Pj4+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgICBpZiAobXR1IDwgTUlOX01UVSkKPj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRfRl9NVFUpOwo+
Pj4+Pj4+PiBJIHdvbmRlciB3aHkgbm90IHNpbXBseSBmYWlsIGhlcmU/Cj4+Pj4+Pj4gSSB0aGlu
ayBib3RoIGZhaWxpbmcgb3Igbm90IGFjY2VwdGluZyB0aGUgZmVhdHVyZSBjYW4gYmUgYXJndWVk
IHRvIG1ha2UKPj4+Pj4+PiBzZW5zZTogInRoZSBkZXZpY2UgcHJlc2VudGVkIHVzIHdpdGggYSBt
dHUgc2l6ZSB0aGF0IGRvZXMgbm90IG1ha2UKPj4+Pj4+PiBzZW5zZSIgd291bGQgcG9pbnQgdG8g
ZmFpbGluZywgIndlIGNhbm5vdCB3b3JrIHdpdGggdGhlIG10dSBzaXplIHRoYXQKPj4+Pj4+PiB0
aGUgZGV2aWNlIHByZXNlbnRlZCB1cyIgd291bGQgcG9pbnQgdG8gbm90IG5lZ290aWF0aW5nIHRo
ZSBmZWF0dXJlLgo+Pj4+Pj4+Pj4gICAgICAgICAgICAgIH0KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAg
ICAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQW5k
IHRoZSBzcGVjIHNheXM6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRoZSBkcml2ZXIg
TVVTVCBmb2xsb3cgdGhpcyBzZXF1ZW5jZSB0byBpbml0aWFsaXplIGEgZGV2aWNlOgo+Pj4+Pj4+
Pj4gMS4gUmVzZXQgdGhlIGRldmljZS4KPj4+Pj4+Pj4+IDIuIFNldCB0aGUgQUNLTk9XTEVER0Ug
c3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2VkIHRoZSBkZXZpY2UuCj4+Pj4+Pj4+
PiAzLiBTZXQgdGhlIERSSVZFUiBzdGF0dXMgYml0OiB0aGUgZ3Vlc3QgT1Mga25vd3MgaG93IHRv
IGRyaXZlIHRoZSBkZXZpY2UuCj4+Pj4+Pj4+PiA0LiBSZWFkIGRldmljZSBmZWF0dXJlIGJpdHMs
IGFuZCB3cml0ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29kIGJ5IHRoZSBP
UyBhbmQgZHJpdmVyIHRvIHRoZQo+Pj4+Pj4+Pj4gZGV2aWNlLiBEdXJpbmcgdGhpcyBzdGVwIHRo
ZSBkcml2ZXIgTUFZIHJlYWQgKGJ1dCBNVVNUIE5PVCB3cml0ZSkgdGhlIGRldmljZS1zcGVjaWZp
YyBjb25maWd1cmF0aW9uCj4+Pj4+Pj4+PiBmaWVsZHMgdG8gY2hlY2sgdGhhdCBpdCBjYW4gc3Vw
cG9ydCB0aGUgZGV2aWNlIGJlZm9yZSBhY2NlcHRpbmcgaXQuCj4+Pj4+Pj4+PiA1LiBTZXQgdGhl
IEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVTVCBOT1QgYWNjZXB0IG5ldyBm
ZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo+Pj4+Pj4+Pj4gNi4gUmUtcmVhZCBkZXZpY2Ug
c3RhdHVzIHRvIGVuc3VyZSB0aGUgRkVBVFVSRVNfT0sgYml0IGlzIHN0aWxsIHNldDogb3RoZXJ3
aXNlLCB0aGUgZGV2aWNlIGRvZXMgbm90Cj4+Pj4+Pj4+PiBzdXBwb3J0IG91ciBzdWJzZXQgb2Yg
ZmVhdHVyZXMgYW5kIHRoZSBkZXZpY2UgaXMgdW51c2FibGUuCj4+Pj4+Pj4+PiA3LiBQZXJmb3Jt
IGRldmljZS1zcGVjaWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2NvdmVyeSBvZiB2aXJ0cXVldWVz
IGZvciB0aGUgZGV2aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLAo+Pj4+Pj4+Pj4gcmVhZGlu
ZyBhbmQgcG9zc2libHkgd3JpdGluZyB0aGUgZGV2aWNl4oCZcyB2aXJ0aW8gY29uZmlndXJhdGlv
biBzcGFjZSwgYW5kIHBvcHVsYXRpb24gb2YgdmlydHF1ZXVlcy4KPj4+Pj4+Pj4+IDguIFNldCB0
aGUgRFJJVkVSX09LIHN0YXR1cyBiaXQuIEF0IHRoaXMgcG9pbnQgdGhlIGRldmljZSBpcyDigJxs
aXZl4oCdLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJdGVtIDQgb24gdGhlIGxpc3Qg
ZXhwbGljaXRseSBhbGxvd3MgcmVhZGluZyBjb25maWcgc3BhY2UgYmVmb3JlCj4+Pj4+Pj4+PiBG
RUFUVVJFU19PSy4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJIGNvbmNsdWRlIHRoYXQgVklSVElPX05F
VF9GX01UVSBpcyBzZXQgbWVhbnMgInNldCBpbiBkZXZpY2UgZmVhdHVyZXMiLgo+Pj4+Pj4+PiBT
byB0aGlzIHByb2JhYmx5IG5lZWQgc29tZSBjbGFyaWZpY2F0aW9uLiAiaXMgc2V0IiBpcyB1c2Vk
IG1hbnkgdGltZXMgaW4KPj4+Pj4+Pj4gdGhlIHNwZWMgdGhhdCBoYXMgZGlmZmVyZW50IGltcGxp
Y2F0aW9ucy4KPj4+Pj4+PiBCZWZvcmUgRkVBVFVSRVNfT0sgaXMgc2V0IGJ5IHRoZSBkcml2ZXIs
IEkgZ3Vlc3MgaXQgbWVhbnMgInRoZSBkZXZpY2UKPj4+Pj4+PiBoYXMgb2ZmZXJlZCB0aGUgZmVh
dHVyZSI7Cj4+Pj4+PiBGb3IgbWUgdGhpcyBwYXJ0IGlzIG9rIHNpbmNlIGl0IGNsYXJpZnkgdGhh
dCBpdCdzIHRoZSBkcml2ZXIgdGhhdCBzZXQKPj4+Pj4+IHRoZSBiaXQuCj4+Pj4+Pgo+Pj4+Pj4K
Pj4+Pj4+PiBkdXJpbmcgbm9ybWFsIHVzYWdlLCBpdCBtZWFucyAidGhlIGZlYXR1cmUKPj4+Pj4+
PiBoYXMgYmVlbiBuZWdvdGlhdGVkIi4KPj4+Pj4+IC8/Cj4+Pj4+Pgo+Pj4+Pj4gSXQgbG9va3Mg
dG8gbWUgdGhlIGZlYXR1cmUgbmVnb3RpYXRpb24gaXMgZG9uZSBvbmx5IGFmdGVyIGRldmljZSBz
ZXQKPj4+Pj4+IEZFQVRVUkVTX09LLCBvciBGRUFUVVJFU19PSyBjb3VsZCBiZSByZWFkIGZyb20g
ZGV2aWNlIHN0YXR1cz8KPj4+Pj4gSSdkIGNvbnNpZGVyIGZlYXR1cmUgbmVnb3RpYXRpb24gZG9u
ZSB3aGVuIHRoZSBkcml2ZXIgcmVhZHMgRkVBVFVSRVNfT0sKPj4+Pj4gYmFjayBmcm9tIHRoZSBz
dGF0dXMuCj4+Pj4gSSBhZ3JlZS4KPj4+Pgo+Pj4+Cj4+Pj4+Pj4gICAgICAoVGhpcyBpcyBhIGJp
dCBmdXp6eSBmb3IgbGVnYWN5IG1vZGUuKQo+Pj4+PiAuLi5iZWNhdXNlIGxlZ2FjeSBkb2VzIG5v
dCBoYXZlIEZFQVRVUkVTX09LLgo+Pj4+Pj4gVGhlIHByb2JsZW0gaXMgdGhlIE1UVSBkZXNjcmlw
dGlvbiBmb3IgZXhhbXBsZToKPj4+Pj4+Cj4+Pj4+PiAiVGhlIGZvbGxvd2luZyBkcml2ZXItcmVh
ZC1vbmx5IGZpZWxkLCBtdHUgb25seSBleGlzdHMgaWYKPj4+Pj4+IFZJUlRJT19ORVRfRl9NVFUg
aXMgc2V0LiIKPj4+Pj4+Cj4+Pj4+PiBJdCBsb29rcyB0byBtZSBuZWVkIHRvIHVzZSAiaWYgVklS
VElPX05FVF9GX01UVSBpcyBzZXQgYnkgZGV2aWNlIi4KPj4+Pj4gIm9mZmVyZWQgYnkgdGhlIGRl
dmljZSI/IEkgZG9uJ3QgdGhpbmsgaXQgc2hvdWxkICdkaXNhcHBlYXInIGZyb20gdGhlCj4+Pj4+
IGNvbmZpZyBzcGFjZSBpZiB0aGUgZHJpdmVyIHdvbid0IHVzZSBpdC4gKFNhbWUgZm9yIG90aGVy
IGNvbmZpZyBzcGFjZQo+Pj4+PiBmaWVsZHMgdGhhdCBhcmUgdGllZCB0byBmZWF0dXJlIGJpdHMu
KQo+Pj4+IEJ1dCB3aGF0IGhhcHBlbnMgaWYgZS5nIGRldmljZSBkb2Vzbid0IG9mZmVyIFZJUlRJ
T19ORVRfRl9NVFU/IEl0IGxvb2tzCj4+Pj4gdG8gYWNjb3JkaW5nIHRvIHRoZSBzcGVjIHRoZXJl
IHdpbGwgYmUgbm8gbXR1IGZpZWxkLgo+Pj4gSSB0aGluayBzbywgeWVzLgo+Pj4KPj4+PiBBbmQg
YSBtb3JlIGludGVyZXN0aW5nIGNhc2UgaXMgVklSVElPX05FVF9GX01RIGlzIG5vdCBvZmZlcmVk
IGJ1dAo+Pj4+IFZJUlRJT19ORVRfRl9NVFUgb2ZmZXJlZC4gVG8gbWUsIGl0IG1lYW5zIHdlIGRv
bid0IGhhdmUKPj4+PiBtYXhfdmlydHF1ZXVlX3BhaXJzIGJ1dCBpdCdzIG5vdCBob3cgdGhlIGRy
aXZlciBpcyB3cm90ZSB0b2RheS4KPj4+IFRoYXQgd291bGQgYmUgYSBidWcsIGJ1dCBpdCBzZWVt
cyB0byBtZSB0aGF0IHRoZSB2aXJ0aW8tbmV0IGRyaXZlcgo+Pj4gcmVhZHMgbWF4X3ZpcnRxdWV1
ZV9wYWlycyBjb25kaXRpb25hbGx5IGFuZCBoYW5kbGVzIGFic2VuY2Ugb2YgdGhlCj4+PiBmZWF0
dXJlIGNvcnJlY3RseT8KPj4KPj4gWWVzLCBzZWUgdGhlIGF2b3ZlIGNvZGVzOgo+Pgo+PiAgwqDC
oMKgwqDCoMKgwqAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRV
KSkgewo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCBtdHUgPSB2aXJ0aW9f
Y3JlYWQxNih2ZGV2LAo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0b2Yoc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnLAo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbXR1KSk7Cj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG10
dSA8IE1JTl9NVFUpCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKTsKPj4gIMKg
wqDCoMKgwqDCoMKgIH0KPj4KPj4gU28gaXQncyBwcm9iYWJseSB0b28gbGF0ZSB0byBmaXggdGhl
IGRyaXZlci4KPj4KPiBDb25mdXNlZC4gV2hhdCBpcyB3cm9uZyB3aXRoIHRoZSBhYm92ZT8gSXQg
bmV2ZXIgcmVhZHMgdGhlCj4gZmllbGQgdW5sZXNzIHRoZSBmZWF0dXJlIGhhcyBiZWVuIG9mZmVy
ZWQgYnkgZGV2aWNlLgoKClNvIHRoZSBzcGVjIHNhaWQ6CgoiCgpUaGUgZm9sbG93aW5nIGRyaXZl
ci1yZWFkLW9ubHkgZmllbGQsIG1heF92aXJ0cXVldWVfcGFpcnMgb25seSBleGlzdHMgaWYgClZJ
UlRJT19ORVRfRl9NUSBpcyBzZXQuCgoiCgpJZiBJIHJlYWQgdGhpcyBjb3JyZWN0bHksIHRoZXJl
IHdpbGwgYmUgbm8gbWF4X3ZpcnRxdWV1ZV9wYWlycyBmaWVsZCBpZiAKdGhlIFZJUlRJT19ORVRf
Rl9NUSBpcyBub3Qgb2ZmZXJlZCBieSBkZXZpY2U/IElmIHllcyB0aGUgb2Zmc2V0b2YoKSAKdmlv
bGF0ZXMgd2hhdCBzcGVjIHNhaWQuCgpUaGFua3MKCgo+Cj4KPj4+Pj4+IE90aGVyd2lzZSByZWFk
ZXJzIChhdCBsZWFzdCBmb3IgbWUpLCBtYXkgdGhpbmsgdGhlIE1UVSBpcyBvbmx5IHZhbGlkCj4+
Pj4+PiBpZiBkcml2ZXIgc2V0IHRoZSBiaXQuCj4+Pj4+IEkgdGhpbmsgaXQgd291bGQgc3RpbGwg
YmUgJ3ZhbGlkJyBpbiB0aGUgc2Vuc2UgdGhhdCBpdCBleGlzdHMgYW5kIGhhcwo+Pj4+PiBzb21l
IHZhbHVlIGluIHRoZXJlIGZpbGxlZCBpbiBieSB0aGUgZGV2aWNlLCBidXQgYSBkcml2ZXIgcmVh
ZGluZyBpdAo+Pj4+PiB3aXRob3V0IG5lZ290aWF0aW5nIHRoZSBmZWF0dXJlIHdvdWxkIGJlIGJ1
Z2d5LiAoTGlrZSBpbiB0aGUga2VybmVsCj4+Pj4+IGNvZGUgYWJvdmU7IHRoZSBrZXJuZWwgbm90
IGxpa2luZyB0aGUgdmFsdWUgZG9lcyBub3QgbWFrZSB0aGUgZmllbGQKPj4+Pj4gaW52YWxpZC4p
Cj4+Pj4gU2VlIE1pY2hhZWwncyByZXBseSwgdGhlIHNwZWMgYWxsb3dzIHJlYWQgdGhlIGNvbmZp
ZyBiZWZvcmUgc2V0dGluZwo+Pj4+IGZlYXR1cmVzLgo+Pj4gWWVzLCB0aGUgcGVyaW9kIHByaW9y
IHRvIGZpbmlzaGluZyBuZWdvdGlhdGlvbiBpcyBvYnZpb3VzbHkgc3BlY2lhbC4KPj4+Cj4+Pj4+
IE1heWJlIGEgc3RhdGVtZW50IGNvdmVyaW5nIGV2ZXJ5dGhpbmcgd291bGQgYmU6Cj4+Pj4+Cj4+
Pj4+ICJUaGUgZm9sbG93aW5nIGRyaXZlci1yZWFkLW9ubHkgZmllbGQgbXR1IG9ubHkgZXhpc3Rz
IGlmIHRoZSBkZXZpY2UKPj4+Pj4gb2ZmZXJzIFZJUlRJT19ORVRfRl9NVFUgYW5kIG1heSBiZSBy
ZWFkIGJ5IHRoZSBkcml2ZXIgZHVyaW5nIGZlYXR1cmUKPj4+Pj4gbmVnb3RpYXRpb24gYW5kIGFm
dGVyIFZJUlRJT19ORVRfRl9NVFUgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5Cj4+Pj4+IG5lZ290aWF0
ZWQuIgo+Pj4+Pj4+IFNob3VsZCB3ZSBhZGQgYSB3b3JkaW5nIGNsYXJpZmljYXRpb24gdG8gdGhl
IHNwZWM/Cj4+Pj4+PiBJIHRoaW5rIHNvLgo+Pj4+PiBTb21lIGNsYXJpZmljYXRpb24gd291bGQg
YmUgbmVlZGVkIGZvciBlYWNoIGZpZWxkIHRoYXQgZGVwZW5kcyBvbiBhCj4+Pj4+IGZlYXR1cmU7
IHRoYXQgd291bGQgYmUgcXVpdGUgdmVyYm9zZS4gTWF5YmUgd2UgY2FuIGdldCBhd2F5IHdpdGgg
YQo+Pj4+PiBjbGFyaWZ5aW5nIHN0YXRlbWVudD8KPj4+Pj4KPj4+Pj4gIlNvbWUgY29uZmlnIHNw
YWNlIGZpZWxkcyBtYXkgZGVwZW5kIG9uIGEgY2VydGFpbiBmZWF0dXJlLiBJbiB0aGF0Cj4+Pj4+
IGNhc2UsIHRoZSBmaWVsZCBleGl0cyBpZiB0aGUgZGV2aWNlIGhhcyBvZmZlcmVkIHRoZSBjb3Jy
ZXNwb25kaW5nCj4+Pj4+IGZlYXR1cmUsCj4+Pj4gU28gdGhpcyBpbXBsaWVzIGZvciAhVklSVElP
X05FVF9GX01RICYmIFZJUlRJT19ORVRfRl9NVFUsIHRoZSBjb25maWcKPj4+PiB3aWxsIGxvb2sg
bGlrZToKPj4+Pgo+Pj4+IHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyB7Cj4+Pj4gICAgwqDCoMKg
wqDCoMKgwqAgdTggbWFjWzZdOwo+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgIGxlMTYgc3RhdHVzOwo+
Pj4+ICAgIMKgwqDCoMKgwqDCoMKgIGxlMTYgbXR1Owo+Pj4+IH07Cj4+Pj4KPj4+IEkgYWdyZWUu
Cj4+Cj4+IFNvIGNvbnNpZGVyIGl0J3MgcHJvYmFibHkgdG9vIGxhdGUgdG8gZml4IHRoZSBkcml2
ZXIgd2hpY2ggYXNzdW1lcyBzb21lCj4+IGZpZWxkIGFyZSBhbHdheXMgcGVyc2VudCwgaXQgbG9v
a3MgdG8gbWUgbmVlZCBmaXggdGhlIHNwZWMgZG8gZGVjbGFyZSB0aGUKPj4gZmllbGRzIGFyZSBh
bHdheXMgZXhpc3RpbmcgaW5zdGVhZC4KPj4KPj4KPj4+Pj4gICAgIGFuZCBtYXkgYmUgcmVhZCBi
eSB0aGUgZHJpdmVyIGR1cmluZyBmZWF0dXJlIG5lZ290aWF0aW9uLCBhbmQKPj4+Pj4gYWNjZXNz
ZWQgYnkgdGhlIGRyaXZlciBhZnRlciB0aGUgZmVhdHVyZSBoYXMgYmVlbiBzdWNjZXNzZnVsbHkK
Pj4+Pj4gbmVnb3RpYXRlZC4gQSBzaG9ydGhhbmQgZm9yIHRoaXMgaXMgYSBzdGF0ZW1lbnQgdGhh
dCBhIGZpZWxkIG9ubHkKPj4+Pj4gZXhpc3RzIGlmIGEgY2VydGFpbiBmZWF0dXJlIGJpdCBpcyBz
ZXQuIgo+Pj4+IEknbSBub3Qgc3VyZSB1c2luZyAic2hvcnRoYW5kIiBpcyBnb29kIGZvciB0aGUg
c3BlYywgYXQgbGVhc3Qgd2UgY2FuCj4+Pj4gbGltaXQgdGhlIGl0cyBzY29wZSBvbmx5IHRvIHRo
ZSBjb25maWd1cmF0aW9uIHNwYWNlIHBhcnQuCj4+PiBNYXliZSAiYSBzaG9ydGhhbmQgZXhwcmVz
c2lvbiI/Cj4+Cj4+IFNvIHRoZSBxdWVzdGlvbnMgaXMgc2hvdWxkIHdlIHVzZSB0aGlzIGZvciBh
bGwgb3ZlciB0aGUgc3BlYyBvciBpdCB3aWxsIGJlCj4+IG9ubHkgdXNlZCBpbiB0aGlzIHNwZWlj
aWZjIHBhcnQgKGRldmljZSBjb25maWd1cmF0aW9uKS4KPj4KPj4gVGhhbmtzCj4+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

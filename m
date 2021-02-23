Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2545C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:18:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEF364E32
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEF364E32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C1CFB86FC8;
	Tue, 23 Feb 2021 10:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xf-2rp44LfBt; Tue, 23 Feb 2021 10:18:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2721286FCB;
	Tue, 23 Feb 2021 10:18:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0924C000A;
	Tue, 23 Feb 2021 10:18:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FCADC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:18:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D15C86FCB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:18:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70-ywA0XoAmX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B3AA086FC8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614075482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZGrk/KRVSJf4lDW/M6cnASmoATrbPhldVhOPwuWamk=;
 b=VW8XJcmINZWmLzZF2L4A/0WuMMIobwz5QkjO6OVFit4djzV0Zj1xqBglHgixjZ/iZIE8AV
 hS5T2A9fgpxoiS9GhhAIQP+CpCSFHkWU5mDZyp8t6nEBO146bqPkfIbtXuuIfy+8IqhTSF
 JLTAtursbaCN7eMPi9IJ3IHA3JrkqcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-BOWJBQAyOaygi4vJp1gqeA-1; Tue, 23 Feb 2021 05:17:58 -0500
X-MC-Unique: BOWJBQAyOaygi4vJp1gqeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C16BCC621;
 Tue, 23 Feb 2021 10:17:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-193.pek2.redhat.com
 [10.72.12.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 736D162A23;
 Tue, 23 Feb 2021 10:17:51 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
 <20210223045600-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c188353e-9aca-a94c-e8f5-4bad5942481c@redhat.com>
Date: Tue, 23 Feb 2021 18:17:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223045600-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>, elic@nvidia.com
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

Ck9uIDIwMjEvMi8yMyA2OjAxIOS4i+WNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFR1ZSwgRmViIDIzLCAyMDIxIGF0IDA1OjQ2OjIwUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjEvMi8yMyDkuIvljYg1OjI1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+
PiBPbiBNb24sIEZlYiAyMiwgMjAyMSBhdCAwOTowOToyOEFNIC0wODAwLCBTaS1XZWkgTGl1IHdy
b3RlOgo+Pj4+IE9uIDIvMjEvMjAyMSA4OjE0IFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+PiBP
biAyMDIxLzIvMTkgNzo1NCDkuIvljYgsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+PiBDb21taXQg
NDUyNjM5YTY0YWQ4ICgidmRwYTogbWFrZSBzdXJlIHNldF9mZWF0dXJlcyBpcyBpbnZva2VkCj4+
Pj4+PiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxlZ2FjeSBndWVzdHMgdG8g
cmVzZXQKPj4+Pj4+IGZlYXR1cmVzIHRvIDAsIHdoZW4gY29uZmlnIHNwYWNlIGlzIGFjY2Vzc2Vk
IGJlZm9yZSBmZWF0dXJlcwo+Pj4+Pj4gYXJlIHNldC4gV2Ugc2hvdWxkIHJlbGlldmUgdGhlIHZl
cmlmeV9taW5fZmVhdHVyZXMoKSBjaGVjawo+Pj4+Pj4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0
IHRvIDAgZm9yIHRoaXMgY2FzZS4KPj4+Pj4+Cj4+Pj4+PiBJdCdzIHdvcnRoIG5vdGluZyB0aGF0
IG5vdCBqdXN0IGxlZ2FjeSBndWVzdHMgY291bGQgYWNjZXNzCj4+Pj4+PiBjb25maWcgc3BhY2Ug
YmVmb3JlIGZlYXR1cmVzIGFyZSBzZXQuIEZvciBpbnN0YW5jZSwgd2hlbgo+Pj4+Pj4gZmVhdHVy
ZSBWSVJUSU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4+Pj4+
PiB3aWxsIHRyeSB0byBhY2Nlc3MgYW5kIHZhbGlkYXRlIHRoZSBNVFUgcHJlc2VudCBpbiB0aGUg
Y29uZmlnCj4+Pj4+PiBzcGFjZSBiZWZvcmUgdmlydGlvIGZlYXR1cmVzIGFyZSBzZXQuCj4+Pj4+
IFRoaXMgbG9va3MgbGlrZSBhIHNwZWMgdmlvbGF0aW9uOgo+Pj4+Pgo+Pj4+PiAiCj4+Pj4+Cj4+
Pj4+IFRoZSBmb2xsb3dpbmcgZHJpdmVyLXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkgZXhpc3Rz
IGlmCj4+Pj4+IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0LiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0
aGUgbWF4aW11bSBNVFUgZm9yIHRoZQo+Pj4+PiBkcml2ZXIgdG8gdXNlLgo+Pj4+PiAiCj4+Pj4+
Cj4+Pj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHdvcmthcm91bmQgdGhpcz8KPj4+PiBJc24ndCB0
aGUgY29tbWl0IDQ1MjYzOWE2NGFkOCBpdHNlbGYgaXMgYSB3b3JrYXJvdW5kIGZvciBsZWdhY3kg
Z3Vlc3Q/Cj4+Pj4KPj4+PiBJIHRoaW5rIHRoZSBwb2ludCBpcywgc2luY2UgdGhlcmUncyBsZWdh
Y3kgZ3Vlc3Qgd2UnZCBoYXZlIHRvIHN1cHBvcnQsIHRoaXMKPj4+PiBob3N0IHNpZGUgd29ya2Fy
b3VuZCBpcyB1bmF2b2lkYWJsZS4gQWx0aG91Z2ggSSBhZ3JlZSB0aGUgdmlvbGF0aW5nIGRyaXZl
cgo+Pj4+IHNob3VsZCBiZSBmaXhlZCAoeWVzLCBpdCdzIGluIHRvZGF5J3MgdXBzdHJlYW0ga2Vy
bmVsIHdoaWNoIGV4aXN0cyBmb3IgYQo+Pj4+IHdoaWxlIG5vdykuCj4+PiBPaCAgeW91IGFyZSBy
aWdodDoKPj4+Cj4+Pgo+Pj4gc3RhdGljIGludCB2aXJ0bmV0X3ZhbGlkYXRlKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+Pj4gewo+Pj4gICAgICAgICAgIGlmICghdmRldi0+Y29uZmlnLT5n
ZXQpIHsKPj4+ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnZkZXYtPmRldiwgIiVzIGZhaWx1
cmU6IGNvbmZpZyBhY2Nlc3MgZGlzYWJsZWRcbiIsCj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fZnVuY19fKTsKPj4+ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+Pj4g
ICAgICAgICAgIH0KPj4+Cj4+PiAgICAgICAgICAgaWYgKCF2aXJ0bmV0X3ZhbGlkYXRlX2ZlYXR1
cmVzKHZkZXYpKQo+Pj4gICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4+Pgo+Pj4g
ICAgICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX01UVSkp
IHsKPj4+ICAgICAgICAgICAgICAgICAgIGludCBtdHUgPSB2aXJ0aW9fY3JlYWQxNih2ZGV2LAo+
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9mZnNldG9mKHN0
cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBtdHUpKTsKPj4+ICAgICAgICAgICAgICAgICAgIGlmICht
dHUgPCBNSU5fTVRVKQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBfX3ZpcnRpb19jbGVh
cl9iaXQodmRldiwgVklSVElPX05FVF9GX01UVSk7Cj4+Cj4+IEkgd29uZGVyIHdoeSBub3Qgc2lt
cGx5IGZhaWwgaGVyZT8KPiBCYWNrIGluIDIwMTYgaXQgd2VudCBsaWtlIHRoaXM6Cj4KPiAJT24g
VGh1LCBKdW4gMDIsIDIwMTYgYXQgMDU6MTA6NTlQTSAtMDQwMCwgQWFyb24gQ29ub2xlIHdyb3Rl
Ogo+IAk+ICsgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX01U
VSkpIHsKPiAJPiArICAgICAgICAgICAgIGRldi0+bXR1ID0gdmlydGlvX2NyZWFkMTYodmRldiwK
PiAJPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3Ry
dWN0IHZpcnRpb19uZXRfY29uZmlnLAo+IAk+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBtdHUpKTsKPiAJPiArICAgICB9Cj4gCT4gKwo+IAk+ICAgICAg
IGlmICh2aS0+YW55X2hlYWRlcl9zZykKPiAJPiAgICAgICAgICAgICAgIGRldi0+bmVlZGVkX2hl
YWRyb29tID0gdmktPmhkcl9sZW47Cj4gCT4KPgo+IAlPbmUgY29tbWVudCB0aG91Z2g6IEkgdGhp
bmsgd2Ugc2hvdWxkIHZhbGlkYXRlIHRoZSBtdHUuCj4gCUlmIGl0J3MgaW52YWxpZCwgY2xlYXIg
VklSVElPX05FVF9GX01UVSBhbmQgaWdub3JlLgo+Cj4KPiBUb28gbGF0ZSBhdCB0aGlzIHBvaW50
IDopCj4KPiBJIGd1ZXNzIGl0J3MgYSB3YXkgdG8gdGVsbCBkZXZpY2UgIkkgY2FuIG5vdCBsaXZl
IHdpdGggdGhpcyBNVFUiLAo+IGRldmljZSBjYW4gZmFpbCBGRUFUVVJFU19PSyBpZiBpdCB3YW50
cyB0by4gTUlOX01UVQo+IGlzIGFuIGludGVybmFsIGxpbnV4IHRoaW5nIGFuZCBhdCB0aGUgdGlt
ZSBJIGZlbHQgaXQncyBiZXR0ZXIgdG8KPiB0cnkgdG8gbWFrZSBwcm9ncmVzcy4KCgpXaGF0IGlm
IGUuZyB0aGUgZGV2aWNlIGFkdmVydGlzZSBhIGxhcmdlIE1UVS4gRS5nIDY0SyBoZXJlPyBJbiB0
aGF0IApjYXNlLCB0aGUgZHJpdmVyIGNhbiBub3QgbGl2ZSBlaXRoZXIuIENsZWFyaW5nIE1UVSB3
b24ndCBoZWxwIGhlcmUuCgpUaGFua3MKCgo+Cj4KPj4+ICAgICAgICAgICB9Cj4+Pgo+Pj4gICAg
ICAgICAgIHJldHVybiAwOwo+Pj4gfQo+Pj4KPj4+IEFuZCB0aGUgc3BlYyBzYXlzOgo+Pj4KPj4+
Cj4+PiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVuY2UgdG8gaW5pdGlhbGl6ZSBh
IGRldmljZToKPj4+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4+PiAyLiBTZXQgdGhlIEFDS05PV0xF
REdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0aGUgZGV2aWNlLgo+Pj4g
My4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dzIGhvdyB0byBk
cml2ZSB0aGUgZGV2aWNlLgo+Pj4gNC4gUmVhZCBkZXZpY2UgZmVhdHVyZSBiaXRzLCBhbmQgd3Jp
dGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMgdW5kZXJzdG9vZCBieSB0aGUgT1MgYW5kIGRy
aXZlciB0byB0aGUKPj4+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0aGUgZHJpdmVyIE1BWSBy
ZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lmaWMgY29uZmlndXJhdGlv
bgo+Pj4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZv
cmUgYWNjZXB0aW5nIGl0Lgo+Pj4gNS4gU2V0IHRoZSBGRUFUVVJFU19PSyBzdGF0dXMgYml0LiBU
aGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcgZmVhdHVyZSBiaXRzIGFmdGVyIHRoaXMgc3Rl
cC4KPj4+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUgdGhlIEZFQVRVUkVTX09L
IGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBkb2VzIG5vdAo+Pj4gc3Vw
cG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVudXNhYmxlLgo+
Pj4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1ZGluZyBkaXNjb3Zlcnkg
b2YgdmlydHF1ZXVlcyBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVyLWJ1cyBzZXR1cCwKPj4+
IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKAmXMgdmlydGlvIGNvbmZp
Z3VyYXRpb24gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1ZXMuCj4+PiA4LiBTZXQg
dGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRoZSBkZXZpY2UgaXMg4oCc
bGl2ZeKAnS4KPj4+Cj4+Pgo+Pj4gSXRlbSA0IG9uIHRoZSBsaXN0IGV4cGxpY2l0bHkgYWxsb3dz
IHJlYWRpbmcgY29uZmlnIHNwYWNlIGJlZm9yZQo+Pj4gRkVBVFVSRVNfT0suCj4+Pgo+Pj4gSSBj
b25jbHVkZSB0aGF0IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0IG1lYW5zICJzZXQgaW4gZGV2aWNl
IGZlYXR1cmVzIi4KPj4KPj4gU28gdGhpcyBwcm9iYWJseSBuZWVkIHNvbWUgY2xhcmlmaWNhdGlv
bi4gImlzIHNldCIgaXMgdXNlZCBtYW55IHRpbWVzIGluIHRoZQo+PiBzcGVjIHRoYXQgaGFzIGRp
ZmZlcmVudCBpbXBsaWNhdGlvbnMuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gR2VuZXJhbGx5IGl0
IGlzIHdvcnRoIGdvaW5nIG92ZXIgZmVhdHVyZSBkZXBlbmRlbnQgY29uZmlnIGZpZWxkcwo+Pj4g
YW5kIGNoZWNraW5nIHdoZXRoZXIgdGhleSBzaG91bGQgYmUgcHJlc2VudCB3aGVuIGRldmljZSBm
ZWF0dXJlIGlzIHNldAo+Pj4gb3Igd2hlbiBmZWF0dXJlIGJpdCBoYXMgYmVlbiBuZWdvdGlhdGVk
LCBhbmQgbWFraW5nIHRoaXMgY2xlYXIuCj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

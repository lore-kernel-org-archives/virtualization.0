Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F00C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:06:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C1264E3F
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C1264E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D52218318B;
	Tue, 23 Feb 2021 10:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNjSnX07QZ24; Tue, 23 Feb 2021 10:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BE6E81C04;
	Tue, 23 Feb 2021 10:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5D00C000B;
	Tue, 23 Feb 2021 10:06:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CE43C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 44B8E8658D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:06:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oag0M2hNfJSq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5955C8650F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 10:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614074792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9ezWLhwEDgAZeIF3d1ynnogTVpyyQruaUJOC2rtSJM=;
 b=VkaT5/PH9bWnqmI2rEyKhxqyr8OPIjwgJ4w8lAQJIhwgwfq7KZql3//hH1OcAWIYyd9isN
 5eJ4A10MEMyxni/lrDpjCvj7V+BMUdeic4mal88+OYiDRr0fiRC+FF2TW2BBVxLwp8tDEM
 OCQpfLUpdiGjWZGhRhA35fHxb+8lKRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-7btmxPb9NoKnV01bpqZfTg-1; Tue, 23 Feb 2021 05:04:39 -0500
X-MC-Unique: 7btmxPb9NoKnV01bpqZfTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4025780403E;
 Tue, 23 Feb 2021 10:04:38 +0000 (UTC)
Received: from gondolin (ovpn-113-126.ams2.redhat.com [10.36.113.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 828665F706;
 Tue, 23 Feb 2021 10:04:33 +0000 (UTC)
Date: Tue, 23 Feb 2021 11:04:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] vdpa/mlx5: set_features should allow
 reset to zero
Message-ID: <20210223110430.2f098bc0.cohuck@redhat.com>
In-Reply-To: <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
 <20210223041740-mutt-send-email-mst@kernel.org>
 <788a0880-0a68-20b7-5bdf-f8150b08276a@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAyMyBGZWIgMjAyMSAxNzo0NjoyMCArMDgwMApKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gMjAyMS8yLzIzIOS4i+WNiDU6MjUsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+IE9uIE1vbiwgRmViIDIyLCAyMDIxIGF0IDA5OjA5OjI4QU0gLTA4
MDAsIFNpLVdlaSBMaXUgd3JvdGU6ICAKPiA+Pgo+ID4+IE9uIDIvMjEvMjAyMSA4OjE0IFBNLCBK
YXNvbiBXYW5nIHdyb3RlOiAgCj4gPj4+IE9uIDIwMjEvMi8xOSA3OjU0IOS4i+WNiCwgU2ktV2Vp
IExpdSB3cm90ZTogIAo+ID4+Pj4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZkcGE6IG1ha2Ugc3Vy
ZSBzZXRfZmVhdHVyZXMgaXMgaW52b2tlZAo+ID4+Pj4gZm9yIGxlZ2FjeSIpIG1hZGUgYW4gZXhj
ZXB0aW9uIGZvciBsZWdhY3kgZ3Vlc3RzIHRvIHJlc2V0Cj4gPj4+PiBmZWF0dXJlcyB0byAwLCB3
aGVuIGNvbmZpZyBzcGFjZSBpcyBhY2Nlc3NlZCBiZWZvcmUgZmVhdHVyZXMKPiA+Pj4+IGFyZSBz
ZXQuIFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sKPiA+
Pj4+IGFuZCBhbGxvdyBmZWF0dXJlcyByZXNldCB0byAwIGZvciB0aGlzIGNhc2UuCj4gPj4+Pgo+
ID4+Pj4gSXQncyB3b3J0aCBub3RpbmcgdGhhdCBub3QganVzdCBsZWdhY3kgZ3Vlc3RzIGNvdWxk
IGFjY2Vzcwo+ID4+Pj4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0dXJlcyBhcmUgc2V0LiBGb3Ig
aW5zdGFuY2UsIHdoZW4KPiA+Pj4+IGZlYXR1cmUgVklSVElPX05FVF9GX01UVSBpcyBhZHZlcnRp
c2VkIHNvbWUgbW9kZXJuIGRyaXZlcgo+ID4+Pj4gd2lsbCB0cnkgdG8gYWNjZXNzIGFuZCB2YWxp
ZGF0ZSB0aGUgTVRVIHByZXNlbnQgaW4gdGhlIGNvbmZpZwo+ID4+Pj4gc3BhY2UgYmVmb3JlIHZp
cnRpbyBmZWF0dXJlcyBhcmUgc2V0LiAgCj4gPj4+Cj4gPj4+IFRoaXMgbG9va3MgbGlrZSBhIHNw
ZWMgdmlvbGF0aW9uOgo+ID4+Pgo+ID4+PiAiCj4gPj4+Cj4gPj4+IFRoZSBmb2xsb3dpbmcgZHJp
dmVyLXJlYWQtb25seSBmaWVsZCwgbXR1IG9ubHkgZXhpc3RzIGlmCj4gPj4+IFZJUlRJT19ORVRf
Rl9NVFUgaXMgc2V0LiBUaGlzIGZpZWxkIHNwZWNpZmllcyB0aGUgbWF4aW11bSBNVFUgZm9yIHRo
ZQo+ID4+PiBkcml2ZXIgdG8gdXNlLgo+ID4+PiAiCj4gPj4+Cj4gPj4+IERvIHdlIHJlYWxseSB3
YW50IHRvIHdvcmthcm91bmQgdGhpcz8gIAo+ID4+IElzbid0IHRoZSBjb21taXQgNDUyNjM5YTY0
YWQ4IGl0c2VsZiBpcyBhIHdvcmthcm91bmQgZm9yIGxlZ2FjeSBndWVzdD8KPiA+Pgo+ID4+IEkg
dGhpbmsgdGhlIHBvaW50IGlzLCBzaW5jZSB0aGVyZSdzIGxlZ2FjeSBndWVzdCB3ZSdkIGhhdmUg
dG8gc3VwcG9ydCwgdGhpcwo+ID4+IGhvc3Qgc2lkZSB3b3JrYXJvdW5kIGlzIHVuYXZvaWRhYmxl
LiBBbHRob3VnaCBJIGFncmVlIHRoZSB2aW9sYXRpbmcgZHJpdmVyCj4gPj4gc2hvdWxkIGJlIGZp
eGVkICh5ZXMsIGl0J3MgaW4gdG9kYXkncyB1cHN0cmVhbSBrZXJuZWwgd2hpY2ggZXhpc3RzIGZv
ciBhCj4gPj4gd2hpbGUgbm93KS4gIAo+ID4gT2ggIHlvdSBhcmUgcmlnaHQ6Cj4gPgo+ID4KPiA+
IHN0YXRpYyBpbnQgdmlydG5ldF92YWxpZGF0ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikK
PiA+IHsKPiA+ICAgICAgICAgIGlmICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPiA+ICAgICAgICAg
ICAgICAgICAgZGV2X2VycigmdmRldi0+ZGV2LCAiJXMgZmFpbHVyZTogY29uZmlnIGFjY2VzcyBk
aXNhYmxlZFxuIiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7Cj4gPiAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4gICAgICAgICAgfQo+ID4KPiA+ICAg
ICAgICAgIGlmICghdmlydG5ldF92YWxpZGF0ZV9mZWF0dXJlcyh2ZGV2KSkKPiA+ICAgICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gPgo+ID4gICAgICAgICAgaWYgKHZpcnRpb19oYXNf
ZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVRVKSkgewo+ID4gICAgICAgICAgICAgICAgICBp
bnQgbXR1ID0gdmlydGlvX2NyZWFkMTYodmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywKPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG10dSkp
Owo+ID4gICAgICAgICAgICAgICAgICBpZiAobXR1IDwgTUlOX01UVSkKPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX05FVF9GX01UVSk7
ICAKPiAKPiAKPiBJIHdvbmRlciB3aHkgbm90IHNpbXBseSBmYWlsIGhlcmU/CgpJIHRoaW5rIGJv
dGggZmFpbGluZyBvciBub3QgYWNjZXB0aW5nIHRoZSBmZWF0dXJlIGNhbiBiZSBhcmd1ZWQgdG8g
bWFrZQpzZW5zZTogInRoZSBkZXZpY2UgcHJlc2VudGVkIHVzIHdpdGggYSBtdHUgc2l6ZSB0aGF0
IGRvZXMgbm90IG1ha2UKc2Vuc2UiIHdvdWxkIHBvaW50IHRvIGZhaWxpbmcsICJ3ZSBjYW5ub3Qg
d29yayB3aXRoIHRoZSBtdHUgc2l6ZSB0aGF0CnRoZSBkZXZpY2UgcHJlc2VudGVkIHVzIiB3b3Vs
ZCBwb2ludCB0byBub3QgbmVnb3RpYXRpbmcgdGhlIGZlYXR1cmUuCgo+IAo+IAo+ID4gICAgICAg
ICAgfQo+ID4KPiA+ICAgICAgICAgIHJldHVybiAwOwo+ID4gfQo+ID4KPiA+IEFuZCB0aGUgc3Bl
YyBzYXlzOgo+ID4KPiA+Cj4gPiBUaGUgZHJpdmVyIE1VU1QgZm9sbG93IHRoaXMgc2VxdWVuY2Ug
dG8gaW5pdGlhbGl6ZSBhIGRldmljZToKPiA+IDEuIFJlc2V0IHRoZSBkZXZpY2UuCj4gPiAyLiBT
ZXQgdGhlIEFDS05PV0xFREdFIHN0YXR1cyBiaXQ6IHRoZSBndWVzdCBPUyBoYXMgbm90aWNlZCB0
aGUgZGV2aWNlLgo+ID4gMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9T
IGtub3dzIGhvdyB0byBkcml2ZSB0aGUgZGV2aWNlLgo+ID4gNC4gUmVhZCBkZXZpY2UgZmVhdHVy
ZSBiaXRzLCBhbmQgd3JpdGUgdGhlIHN1YnNldCBvZiBmZWF0dXJlIGJpdHMgdW5kZXJzdG9vZCBi
eSB0aGUgT1MgYW5kIGRyaXZlciB0byB0aGUKPiA+IGRldmljZS4gRHVyaW5nIHRoaXMgc3RlcCB0
aGUgZHJpdmVyIE1BWSByZWFkIChidXQgTVVTVCBOT1Qgd3JpdGUpIHRoZSBkZXZpY2Utc3BlY2lm
aWMgY29uZmlndXJhdGlvbgo+ID4gZmllbGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQg
dGhlIGRldmljZSBiZWZvcmUgYWNjZXB0aW5nIGl0Lgo+ID4gNS4gU2V0IHRoZSBGRUFUVVJFU19P
SyBzdGF0dXMgYml0LiBUaGUgZHJpdmVyIE1VU1QgTk9UIGFjY2VwdCBuZXcgZmVhdHVyZSBiaXRz
IGFmdGVyIHRoaXMgc3RlcC4KPiA+IDYuIFJlLXJlYWQgZGV2aWNlIHN0YXR1cyB0byBlbnN1cmUg
dGhlIEZFQVRVUkVTX09LIGJpdCBpcyBzdGlsbCBzZXQ6IG90aGVyd2lzZSwgdGhlIGRldmljZSBk
b2VzIG5vdAo+ID4gc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZlYXR1cmVzIGFuZCB0aGUgZGV2aWNl
IGlzIHVudXNhYmxlLgo+ID4gNy4gUGVyZm9ybSBkZXZpY2Utc3BlY2lmaWMgc2V0dXAsIGluY2x1
ZGluZyBkaXNjb3Zlcnkgb2YgdmlydHF1ZXVlcyBmb3IgdGhlIGRldmljZSwgb3B0aW9uYWwgcGVy
LWJ1cyBzZXR1cCwKPiA+IHJlYWRpbmcgYW5kIHBvc3NpYmx5IHdyaXRpbmcgdGhlIGRldmljZeKA
mXMgdmlydGlvIGNvbmZpZ3VyYXRpb24gc3BhY2UsIGFuZCBwb3B1bGF0aW9uIG9mIHZpcnRxdWV1
ZXMuCj4gPiA4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlzIHBvaW50IHRo
ZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KPiA+Cj4gPgo+ID4gSXRlbSA0IG9uIHRoZSBsaXN0IGV4
cGxpY2l0bHkgYWxsb3dzIHJlYWRpbmcgY29uZmlnIHNwYWNlIGJlZm9yZQo+ID4gRkVBVFVSRVNf
T0suCj4gPgo+ID4gSSBjb25jbHVkZSB0aGF0IFZJUlRJT19ORVRfRl9NVFUgaXMgc2V0IG1lYW5z
ICJzZXQgaW4gZGV2aWNlIGZlYXR1cmVzIi4gIAo+IAo+IAo+IFNvIHRoaXMgcHJvYmFibHkgbmVl
ZCBzb21lIGNsYXJpZmljYXRpb24uICJpcyBzZXQiIGlzIHVzZWQgbWFueSB0aW1lcyBpbiAKPiB0
aGUgc3BlYyB0aGF0IGhhcyBkaWZmZXJlbnQgaW1wbGljYXRpb25zLgoKQmVmb3JlIEZFQVRVUkVT
X09LIGlzIHNldCBieSB0aGUgZHJpdmVyLCBJIGd1ZXNzIGl0IG1lYW5zICJ0aGUgZGV2aWNlCmhh
cyBvZmZlcmVkIHRoZSBmZWF0dXJlIjsgZHVyaW5nIG5vcm1hbCB1c2FnZSwgaXQgbWVhbnMgInRo
ZSBmZWF0dXJlCmhhcyBiZWVuIG5lZ290aWF0ZWQiLiAoVGhpcyBpcyBhIGJpdCBmdXp6eSBmb3Ig
bGVnYWN5IG1vZGUuKQoKU2hvdWxkIHdlIGFkZCBhIHdvcmRpbmcgY2xhcmlmaWNhdGlvbiB0byB0
aGUgc3BlYz8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==

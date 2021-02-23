Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58257C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:55:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF0B60233
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 09:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF0B60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DFC982FAE;
	Tue, 23 Feb 2021 09:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gdV45bItSec; Tue, 23 Feb 2021 09:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D66682F4A;
	Tue, 23 Feb 2021 09:55:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55754C000B;
	Tue, 23 Feb 2021 09:55:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72F38C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F77B86FA0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h-KgkHoMcGyY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:55:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B392486F6E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614074143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9UOXjMdz3lHTcWvMJyRl4DlsSgw/pGrzIfxZceKJLg=;
 b=Y4EohJ7QLf53m7mA4SbnQVXfWvA/o9b591an4IcahdD1U9pzkBeScVlGmRTNjs1NWhT1f2
 MSgAGQYTVizcfS/Y/c6r7d5m9ZIqdaMba4FdIB8xrLzFfgwY5N9UZzWefw6Wn4SGcr+uxu
 7TDPwsEINOAKK0yeOvxvY86Ea2WQ0tE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-hJ1b2L-JP8K0VtF1xGYmDQ-1; Tue, 23 Feb 2021 04:55:41 -0500
X-MC-Unique: hJ1b2L-JP8K0VtF1xGYmDQ-1
Received: by mail-wr1-f72.google.com with SMTP id q5so7110827wrs.20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 01:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+9UOXjMdz3lHTcWvMJyRl4DlsSgw/pGrzIfxZceKJLg=;
 b=ZKVUaX8HjNCFliY/etyoNDzwirQwhYM4amyB7V8aaHDo9dc/QhK0XYfcHMhz3yOoPf
 sN63Qt3B6M7ouKdds2bzUy55FqPA293+wuMYUHLc00jt9q5PjZ9HSR5hrZLbB1e9AnA6
 Vx9yymccx9CUXEhPdxbizslCXOHrU3ZondNbLeEZ6yXtM/+NvIL8Jz6y8F95LzG0Rdgh
 YU7SFNTX5rS8KesN4yEVDVBR+WltA3xVBhhqQOfadJ4QHNZlv9qRp56DxdTH2OJNbqgh
 QtBLFL++wsqokjnqM+269ptoBN/l+YjlxJ5TNG2mJwolww9fFdpoG0tjPy1wKQSxSU+T
 TY8A==
X-Gm-Message-State: AOAM533ZHK+SmJrOkTY4EeZzBWg5vl7CuezX+KgasrnwSEuJ5fYxigd5
 Ip3Xh6czmHbksCAFbgbswFVOU+L+GxK19/8IZxjFq4utLczRUAN7XiVrAYDDxzZKL8QcEuW+XBN
 LSJ8+Nzt8a871x1Pc8x+u14gOmb2s221wrcsIERD2yw==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr12417527wrm.253.1614074140893; 
 Tue, 23 Feb 2021 01:55:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUnL19tqj/USYQ+8ZatPBcBGOycf7+tVGdH/yYlA4wjDSUTopCTrlMNHsMzZuipo+DmCRKag==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr12417508wrm.253.1614074140719; 
 Tue, 23 Feb 2021 01:55:40 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id x66sm1978777wmg.6.2021.02.23.01.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 01:55:40 -0800 (PST)
Date: Tue, 23 Feb 2021 04:55:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223045519-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
 <20210221165047-mutt-send-email-mst@kernel.org>
 <20210222060526.GA110862@mtl-vdi-166.wap.labs.mlnx>
 <20210223042559-mutt-send-email-mst@kernel.org>
 <65494f6b-9613-1c0e-4a36-e4af2965235e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <65494f6b-9613-1c0e-4a36-e4af2965235e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgMDU6NDg6MTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvMjMg5LiL5Y2INToyNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gTW9uLCBGZWIgMjIsIDIwMjEgYXQgMDg6MDU6MjZBTSArMDIwMCwgRWxpIENvaGVu
IHdyb3RlOgo+ID4gPiBPbiBTdW4sIEZlYiAyMSwgMjAyMSBhdCAwNDo1MjowNVBNIC0wNTAwLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gT24gU3VuLCBGZWIgMjEsIDIwMjEgYXQg
MDQ6NDQ6MzdQTSArMDIwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gT24gRnJpLCBGZWIg
MTksIDIwMjEgYXQgMDY6NTQ6NThBTSAtMDUwMCwgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+
ID4gQ29tbWl0IDQ1MjYzOWE2NGFkOCAoInZkcGE6IG1ha2Ugc3VyZSBzZXRfZmVhdHVyZXMgaXMg
aW52b2tlZAo+ID4gPiA+ID4gPiBmb3IgbGVnYWN5IikgbWFkZSBhbiBleGNlcHRpb24gZm9yIGxl
Z2FjeSBndWVzdHMgdG8gcmVzZXQKPiA+ID4gPiA+ID4gZmVhdHVyZXMgdG8gMCwgd2hlbiBjb25m
aWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVmb3JlIGZlYXR1cmVzCj4gPiA+ID4gPiA+IGFyZSBzZXQu
IFdlIHNob3VsZCByZWxpZXZlIHRoZSB2ZXJpZnlfbWluX2ZlYXR1cmVzKCkgY2hlY2sKPiA+ID4g
PiA+ID4gYW5kIGFsbG93IGZlYXR1cmVzIHJlc2V0IHRvIDAgZm9yIHRoaXMgY2FzZS4KPiA+ID4g
PiA+ID4gCj4gPiA+ID4gPiA+IEl0J3Mgd29ydGggbm90aW5nIHRoYXQgbm90IGp1c3QgbGVnYWN5
IGd1ZXN0cyBjb3VsZCBhY2Nlc3MKPiA+ID4gPiA+ID4gY29uZmlnIHNwYWNlIGJlZm9yZSBmZWF0
dXJlcyBhcmUgc2V0LiBGb3IgaW5zdGFuY2UsIHdoZW4KPiA+ID4gPiA+ID4gZmVhdHVyZSBWSVJU
SU9fTkVUX0ZfTVRVIGlzIGFkdmVydGlzZWQgc29tZSBtb2Rlcm4gZHJpdmVyCj4gPiA+ID4gPiA+
IHdpbGwgdHJ5IHRvIGFjY2VzcyBhbmQgdmFsaWRhdGUgdGhlIE1UVSBwcmVzZW50IGluIHRoZSBj
b25maWcKPiA+ID4gPiA+ID4gc3BhY2UgYmVmb3JlIHZpcnRpbyBmZWF0dXJlcyBhcmUgc2V0LiBS
ZWplY3RpbmcgcmVzZXQgdG8gMAo+ID4gPiA+ID4gPiBwcmVtYXR1cmVseSBjYXVzZXMgY29ycmVj
dCBNVFUgYW5kIGxpbmsgc3RhdHVzIHVuYWJsZSB0byBsb2FkCj4gPiA+ID4gPiA+IGZvciB0aGUg
dmVyeSBmaXJzdCBjb25maWcgc3BhY2UgYWNjZXNzLCByZW5kZXJpbmcgaXNzdWVzIGxpa2UKPiA+
ID4gPiA+ID4gZ3Vlc3Qgc2hvd2luZyBpbmFjY3VyYXRlIE1UVSB2YWx1ZSwgb3IgZmFpbHVyZSB0
byByZWplY3QKPiA+ID4gPiA+ID4gb3V0LW9mLXJhbmdlIE1UVS4KPiA+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBm
b3Igc3VwcG9ydGVkIG1seDUgZGV2aWNlcyIpCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNp
LVdlaSBMaXU8c2ktd2VpLmxpdUBvcmFjbGUuY29tPgo+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+
ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNSArLS0tLS0tLS0tLS0t
LS0KPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0
aW9ucygtKQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+ID4gPiA+ID4gPiBpbmRleCA3YzFmNzg5Li41NDBkZDY3IDEwMDY0NAo+ID4gPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gPiA+ID4gKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiA+IEBAIC0xNDkwLDE0
ICsxNDkwLDYgQEAgc3RhdGljIHU2NCBtbHg1X3ZkcGFfZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldikKPiA+ID4gPiA+ID4gICAJcmV0dXJuIG12ZGV2LT5tbHhfZmVhdHVyZXM7
Cj4gPiA+ID4gPiA+ICAgfQo+ID4gPiA+ID4gPiAtc3RhdGljIGludCB2ZXJpZnlfbWluX2ZlYXR1
cmVzKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTY0IGZlYXR1cmVzKQo+ID4gPiA+ID4g
PiAtewo+ID4gPiA+ID4gPiAtCWlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9BQ0NF
U1NfUExBVEZPUk0pKSkKPiA+ID4gPiA+ID4gLQkJcmV0dXJuIC1FT1BOT1RTVVBQOwo+ID4gPiA+
ID4gPiAtCj4gPiA+ID4gPiA+IC0JcmV0dXJuIDA7Cj4gPiA+ID4gPiA+IC19Cj4gPiA+ID4gPiA+
IC0KPiA+ID4gPiA+IEJ1dCB3aGF0IGlmIFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBpcyBub3Qg
b2ZmZXJyZWQ/IFRoaXMgZG9lcyBub3QKPiA+ID4gPiA+IHN1cHBvcnQgc3VjaCBjYXNlcy4KPiA+
ID4gPiBEaWQgeW91IG1lYW4gImNhdGNoIHN1Y2ggY2FzZXMiIHJhdGhlciB0aGFuICJzdXBwb3J0
Ij8KPiA+ID4gPiAKPiA+ID4gQWN0dWFsbHkgSSBtZWFudCB0aGlzIGRyaXZlci9kZXZpY2UgZG9l
cyBub3Qgc3VwcG9ydCBzdWNoIGNhc2VzLgo+ID4gV2VsbCB0aGUgcmVtb3ZlZCBjb2RlIG1lcmVs
eSBmYWlsZWQgd2l0aG91dCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0KPiA+IGl0IGRpZG4ndCBh
Y3R1YWxseSB0cnkgdG8gc3VwcG9ydCBhbnl0aGluZyAuLi4KPiAKPiAKPiBJIHRoaW5rIGl0J3Mg
dXNlZCB0byBjYXRjaCB0aGUgZHJpdmVyIHRoYXQgZG9lc24ndCBzdXBwb3J0IEFDQ0VTU19QTEFU
Rk9STT8KPiAKPiBUaGFua3MKPiAKClRoYXQgaXMgd2h5IEkgYXNrZWQgd2hldGhlciBFbGkgbWVh
bnQgY2F0Y2guCgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

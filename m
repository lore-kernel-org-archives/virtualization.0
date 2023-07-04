Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958C2EB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 09:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2218B60E36;
	Tue,  4 Jul 2023 09:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2218B60E36
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=clAFMLIO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ezbU8TjdKwl0; Tue,  4 Jul 2023 09:59:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41D9C6066D;
	Tue,  4 Jul 2023 09:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 41D9C6066D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B26CC0072;
	Tue,  4 Jul 2023 09:59:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E460C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 09:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 346F4607F5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 09:59:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 346F4607F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A_5CMDRsIOo0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 09:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F25006066D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F25006066D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688464774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=892aSalStYsQtwptK7t1c8HIhOOHEUNVf5ArLGswb+M=;
 b=clAFMLIO/SSTyVkTTgBIlXftRafs8ivjSjjfw2k7bslktXiGb1KMroyZysOSzOVl5cVQK1
 F9DF73xSzIYV4DC3B15iTg2Y0AOwnsrVJf12Ni9Kd7WQmnYKLEpV9RVXu5V0ed/1gEdghp
 bADxt142SO+hF2K9uPDqmwumY9yLqTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-98Cq1MNQNHqZZCZ0VjXKPw-1; Tue, 04 Jul 2023 05:59:33 -0400
X-MC-Unique: 98Cq1MNQNHqZZCZ0VjXKPw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31273e0507dso3130547f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Jul 2023 02:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688464772; x=1691056772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=892aSalStYsQtwptK7t1c8HIhOOHEUNVf5ArLGswb+M=;
 b=UL4o12xMANxSvnv1bwzGdyVzFbS6SxSkzXIwh2Y1R6/cfcFUsiQrgMV0xuCwyoq3O0
 1957Vi8+htfF+hpzxYG6vL+moXMLZHN21/2d2RJy5bl4A9C3TOXSnFzOX+BQc+XqSZlV
 B3Lu/YG7+o+2AywAGnVYLSXfAcOQi1hS/dVCL4qgdrMcnEVkMr+ZzjStMtBqBOaMswSH
 v6m/jDFTfoCHbp4mSov5jlHVGmJT75azQ8YFZ6JP4dzyp3cH47hOiVhGLzEcRQG0hdTn
 El69/pxkBUjnSLs4TckbMnNRy5UHgOtDLyvEszh5N6g/cUjoPymxP9A+0aUff7mp0iBa
 K0Zg==
X-Gm-Message-State: ABy/qLa6wMPQZOW7YyaAd41FfEQQi9RAYpR1T4uoKW98vbdLzPHkrlRc
 O3C74IN38I8YT0/bdevhyonMmuq1NF+33yxZG/GgHDFwfaDxfwlewGIcZFIY4Rk+iKl+KLDDynW
 z2lgDXrkgykbMGaMNHyl8SKJPXCwbzFYudA7R+Qd6hw==
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id
 q17-20020a5d61d1000000b00314012c4322mr9924368wrv.4.1688464772566; 
 Tue, 04 Jul 2023 02:59:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFd/q5uFdR61nqrA+b7m+WX8tW3+kCffk5PcW2uKNzWMNMUWwL7eXK2DeOry/96kNoaIexczg==
X-Received: by 2002:a5d:61d1:0:b0:314:12c:4322 with SMTP id
 q17-20020a5d61d1000000b00314012c4322mr9924352wrv.4.1688464772214; 
 Tue, 04 Jul 2023 02:59:32 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 x8-20020a5d60c8000000b003142b0d98b4sm8771005wrt.37.2023.07.04.02.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 02:59:31 -0700 (PDT)
Date: Tue, 4 Jul 2023 05:59:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230704055840-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230702093530-mutt-send-email-mst@kernel.org>
 <CACGkMEtoW0nW8w6_Ew8qckjvpNGN_idwpU3jwsmX6JzbDknmQQ@mail.gmail.com>
 <571e2fbc-ea6a-d231-79f0-37529e05eb98@redhat.com>
 <20230703174043-mutt-send-email-mst@kernel.org>
 <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0630fc62-a414-6083-eed8-48b36acc7723@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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

T24gVHVlLCBKdWwgMDQsIDIwMjMgYXQgMTA6NDM6MDdBTSArMDIwMCwgTWF4aW1lIENvcXVlbGlu
IHdyb3RlOgo+IAo+IAo+IE9uIDcvMy8yMyAyMzo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gTW9uLCBKdWwgMDMsIDIwMjMgYXQgMDk6NDM6NDlBTSArMDIwMCwgTWF4aW1lIENv
cXVlbGluIHdyb3RlOgo+ID4gPiAKPiA+ID4gT24gNy8zLzIzIDA4OjQ0LCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+IE9uIFN1biwgSnVsIDIsIDIwMjMgYXQgOTozN+KAr1BNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBPbiBU
dWUsIEp1biAyNywgMjAyMyBhdCAwMTozNjo1MFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3Jv
dGU6Cj4gPiA+ID4gPiA+IFRoaXMgc21hbGwgc2VyaWVzIGVuYWJsZXMgdmlydGlvLW5ldCBkZXZp
Y2UgdHlwZSBpbiBWRFVTRS4KPiA+ID4gPiA+ID4gV2l0aCBpdCwgYmFzaWMgb3BlcmF0aW9uIGhh
dmUgYmVlbiB0ZXN0ZWQsIGJvdGggd2l0aAo+ID4gPiA+ID4gPiB2aXJ0aW8tdmRwYSBhbmQgdmhv
c3QtdmRwYSB1c2luZyBEUERLIFZob3N0IGxpYnJhcnkgc2VyaWVzCj4gPiA+ID4gPiA+IGFkZGlu
ZyBWRFVTRSBzdXBwb3J0IHVzaW5nIHNwbGl0IHJpbmdzIGxheW91dCAobWVyZ2VkIGluCj4gPiA+
ID4gPiA+IERQREsgdjIzLjA3LXJjMSkuCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBDb250cm9s
IHF1ZXVlIHN1cHBvcnQgKGFuZCBzbyBtdWx0aXF1ZXVlKSBoYXMgYWxzbyBiZWVuCj4gPiA+ID4g
PiA+IHRlc3RlZCwgYnV0IHJlcXVpcmVzIGEgS2VybmVsIHNlcmllcyBmcm9tIEphc29uIFdhbmcK
PiA+ID4gPiA+ID4gcmVsYXhpbmcgY29udHJvbCBxdWV1ZSBwb2xsaW5nIFsxXSB0byBmdW5jdGlv
biByZWxpYWJseS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFsxXTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9DQUNHa01FdGdyeE4zUFB3c0RvNG9Pc25zU0xKZkVtQkVaMFd2akdScjN3
aFUrUWFzVWdAbWFpbC5nbWFpbC5jb20vVC8KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSmFzb24gcHJv
bWlzZWQgdG8gcG9zdCBhIG5ldyB2ZXJzaW9uIG9mIHRoYXQgcGF0Y2guCj4gPiA+ID4gPiBSaWdo
dCBKYXNvbj8KPiA+ID4gPiAKPiA+ID4gPiBZZXMuCj4gPiA+ID4gCj4gPiA+ID4gPiBGb3Igbm93
IGxldCdzIG1ha2Ugc3VyZSBDVlEgZmVhdHVyZSBmbGFnIGlzIG9mZj8KPiA+ID4gPiAKPiA+ID4g
PiBXZSBjYW4gZG8gdGhhdCBhbmQgcmVsYXggb24gdG9wIG9mIG15IHBhdGNoLgo+ID4gPiAKPiA+
ID4gSSBhZ3JlZT8gRG8geW91IHByZWZlciBhIGZlYXR1cmVzIG5lZ290aWF0aW9uLCBvciBmYWls
aW5nIGluaXQgKGxpa2UKPiA+ID4gZG9uZSBmb3IgVkVSU0lPTl8xKSBpZiB0aGUgVkRVU0UgYXBw
bGljYXRpb24gYWR2ZXJ0aXNlcyBDVlE/Cj4gPiA+IAo+ID4gPiBUaGFua3MsCj4gPiA+IE1heGlt
ZQo+ID4gCj4gPiBVbmZvcnR1bmF0ZWx5IGd1ZXN0cyBmYWlsIHByb2JlIGlmIGZlYXR1cmUgc2V0
IGlzIGluY29uc2lzdGVudC4KPiA+IFNvIEkgZG9uJ3QgdGhpbmsgcGFzc2luZyB0aHJvdWdoIGZl
YXR1cmVzIGlzIGEgZ29vZCBpZGVhLAo+ID4geW91IG5lZWQgYSBsaXN0IG9mIGxlZ2FsIGJpdHMu
IEFuZCB3aGVuIGRvaW5nIHRoaXMsCj4gPiBjbGVhciBDVlEgYW5kIGV2ZXJ5dGhpbmcgdGhhdCBk
ZXBlbmRzIG9uIGl0Lgo+IAo+IFNpbmNlIHRoaXMgaXMgdGVtcG9yYXJ5LCB3aGlsZSBjdnEgaXMg
bWFkZSBtb3JlIHJvYnVzdCwgSSB0aGluayBpdCBpcwo+IGJldHRlciB0byBmYWlsIFZEVVNFIGRl
dmljZSBjcmVhdGlvbiBpZiBDVlEgZmVhdHVyZSBpcyBhZHZlcnRpc2VkIGJ5IHRoZQo+IFZEVVNF
IGFwcGxpY2F0aW9uLCBpbnN0ZWFkIG9mIGVuc3VyaW5nIGZlYXR1cmVzIGRlcGVuZGluZyBvbiBD
VlEgYXJlCj4gYWxzbyBjbGVhcmVkLgo+IAo+IEphc29uIHNlZW1zIHRvIHRoaW5rIGxpa2V3aXNl
LCB3b3VsZCB0aGF0IHdvcmsgZm9yIHlvdT8KPiAKPiBUaGFua3MsCj4gTWF4aW1lCgpOb3RoaW5n
IGlzIG1vcmUgcGVybWFuZW50IHRoYW4gdGVtcG9yYXJ5IHNvbHV0aW9ucy4KTXkgY29uY2VybiB3
b3VsZCBiZSB0aGF0IGhhcmR3YXJlIGRldmljZXMgdGhlbiBzdGFydCBtYXNraW5nIENWUQppbnRl
bnRpb25hbGx5IGp1c3QgdG8gYXZvaWQgdGhlIHBhaW4gb2YgYnJva2VuIHNvZnR3YXJlLgoKPiA+
IAo+ID4gCj4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gUkZD
IC0+IHYxIGNoYW5nZXM6Cj4gPiA+ID4gPiA+ID09PT09PT09PT09PT09PT09PQo+ID4gPiA+ID4g
PiAtIEZhaWwgZGV2aWNlIGluaXQgaWYgaXQgZG9lcyBub3Qgc3VwcG9ydCBWRVJTSU9OXzEgKEph
c29uKQo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gTWF4aW1lIENvcXVlbGluICgyKToKPiA+ID4g
PiA+ID4gICAgIHZkdXNlOiB2YWxpZGF0ZSBibG9jayBmZWF0dXJlcyBvbmx5IHdpdGggYmxvY2sg
ZGV2aWNlcwo+ID4gPiA+ID4gPiAgICAgdmR1c2U6IGVuYWJsZSBWaXJ0aW8tbmV0IGRldmljZSB0
eXBlCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiAgICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jIHwgMTUgKysrKysrKysrKystLS0tCj4gPiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gLS0KPiA+ID4gPiA+ID4gMi40MS4wCj4gPiA+ID4gPiAKPiA+ID4gPiAKPiA+IAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

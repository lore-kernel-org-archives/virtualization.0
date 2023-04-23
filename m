Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D2BC77B73
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 06:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E5BC4036F;
	Sun, 23 Apr 2023 06:30:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E5BC4036F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PawHmV5c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KduOtQFm_jPD; Sun, 23 Apr 2023 06:30:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B772540018;
	Sun, 23 Apr 2023 06:30:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B772540018
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CB32C0037;
	Sun, 23 Apr 2023 06:30:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55A73C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2421B821A2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2421B821A2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PawHmV5c
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lq_zS8QA3qQh
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:30:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFB808212C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFB808212C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682231435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ojJ8J6SwJ2t3heHFBn0Bsabr0jgX7CmT47hae2NlsQQ=;
 b=PawHmV5cHIpyEkkNGAuirCygIPXlpS9AuwC0ZeZ44UHP8uc058Wycla2aXz39sqZ82ve7m
 raPwayh13F8YOmkTqEBH7A98F/GaGx88823vZsykfN/miqPiqJO0EDHa8ozCBj+C8vDKuh
 v8PPKv5ogjg3PCi6FLmYkh+8hG1JvKE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-WttnAdDlPuOhrH6_ASFRqg-1; Sun, 23 Apr 2023 02:30:30 -0400
X-MC-Unique: WttnAdDlPuOhrH6_ASFRqg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1877e4dff8aso2145517fac.2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Apr 2023 23:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682231429; x=1684823429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ojJ8J6SwJ2t3heHFBn0Bsabr0jgX7CmT47hae2NlsQQ=;
 b=Bssy11amWBkXgQLvm6jivFRGL62VazJ9/9j0o4OX0Ab1gEqyDSUefEv4c+k5DvAEke
 NdGuap+3XtoSDQSQd/7N7BZHXz0+pZzwHIzYc9dvYYS+be+YrFJ42KONTta97rpcN1O/
 caDnjA3d3V0VrjZsgir3hQ/2TjYBBQY1eZ6kXCv2BXcLY/JC7jn/k+TAjGLqf81gmQBC
 iKvIGgl5blr7YFJiJsxXPvbNs2fb5J+sw6olNZrPMv4XSTLEMBve4jc68TVwJj61X4wC
 u7MhBgPKop81LUjKfVmI4TW3Mo5UkjmviSQFCiE0mNwvS4vG510hzvcek3and2r8iLzM
 GOCA==
X-Gm-Message-State: AAQBX9fIKpdKpOOKE1J8M2osh7fbTppXNnQtdgwpEfo9chZhaoE9Sjyq
 UxTEwQrGB+I+lJFX4a05xf7dNDWlsEPufr0FPcDHtK5y9MMe8rBua7kbrSyoU31KgvF6xsIKVul
 FRiwGSqfTYHAZQpK+ll8+vtScLSMRK1JnzZNdE+HGj+zcAaztMYj2srsQKA==
X-Received: by 2002:a05:6870:d389:b0:184:8300:bfac with SMTP id
 k9-20020a056870d38900b001848300bfacmr7672329oag.35.1682231429450; 
 Sat, 22 Apr 2023 23:30:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350YzsgF0Z9L5BvVC8ev7/eC3gT2mJGdBB3NlrQjX6tzHkIyY6LeBMqfYTzC99ghGTCiMe89Snmwc8jP9Ue530OI=
X-Received: by 2002:a05:6870:d389:b0:184:8300:bfac with SMTP id
 k9-20020a056870d38900b001848300bfacmr7672318oag.35.1682231429136; Sat, 22 Apr
 2023 23:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <CACGkMEuiHqPkqYk1ZG3RZXLjm+EM3bmR0v1T1yH-ADEazOwTMA@mail.gmail.com>
 <d7530c13-f1a1-311e-7d5e-8e65f3bc2e50@redhat.com>
 <CACGkMEuWpHokhwvJ5cF41_C=ezqFhoOyUOposdZ5+==A642OmQ@mail.gmail.com>
 <88a24206-b576-efc6-1bce-7f5075024c63@redhat.com>
In-Reply-To: <88a24206-b576-efc6-1bce-7f5075024c63@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 23 Apr 2023 14:30:18 +0800
Message-ID: <CACGkMEuZpk8QcrUQSOxqt6j3F9Ge-HdSs5-18FayMMQmH3Tcmg@mail.gmail.com>
Subject: Re: [RFC 0/2] vduse: add support for networking devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMTA6MjjigK9QTSBNYXhpbWUgQ29xdWVsaW4KPG1heGlt
ZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiA0LzIxLzIzIDA3OjUxLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4gT24gVGh1LCBBcHIgMjAsIDIwMjMgYXQgMTA6MTbigK9QTSBN
YXhpbWUgQ29xdWVsaW4KPiA+IDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
Pj4KPiA+Pgo+ID4+Cj4gPj4gT24gNC8yMC8yMyAwNjozNCwgSmFzb24gV2FuZyB3cm90ZToKPiA+
Pj4gT24gV2VkLCBBcHIgMTksIDIwMjMgYXQgOTo0M+KAr1BNIE1heGltZSBDb3F1ZWxpbgo+ID4+
PiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Pj4KPiA+Pj4+IFRoaXMg
c21hbGwgc2VyaWVzIGVuYWJsZXMgdmlydGlvLW5ldCBkZXZpY2UgdHlwZSBpbiBWRFVTRS4KPiA+
Pj4+IFdpdGggaXQsIGJhc2ljIG9wZXJhdGlvbiBoYXZlIGJlZW4gdGVzdGVkLCBib3RoIHdpdGgK
PiA+Pj4+IHZpcnRpby12ZHBhIGFuZCB2aG9zdC12ZHBhIHVzaW5nIERQREsgVmhvc3QgbGlicmFy
eSBzZXJpZXMKPiA+Pj4+IGFkZGluZyBWRFVTRSBzdXBwb3J0IFswXSB1c2luZyBzcGxpdCByaW5n
cyBsYXlvdXQuCj4gPj4+Pgo+ID4+Pj4gQ29udHJvbCBxdWV1ZSBzdXBwb3J0IChhbmQgc28gbXVs
dGlxdWV1ZSkgaGFzIGFsc28gYmVlbgo+ID4+Pj4gdGVzdGVkLCBidXQgcmVxdWlyZSBhIEtlcm5l
bCBzZXJpZXMgZnJvbSBKYXNvbiBXYW5nCj4gPj4+PiByZWxheGluZyBjb250cm9sIHF1ZXVlIHBv
bGxpbmcgWzFdIHRvIGZ1bmN0aW9uIHJlbGlhYmx5Lgo+ID4+Pj4KPiA+Pj4+IE90aGVyIHRoYW4g
dGhhdCwgd2UgaGF2ZSBpZGVudGlmaWVkIGEgZmV3IGdhcHM6Cj4gPj4+Pgo+ID4+Pj4gMS4gUmVj
b25uZWN0aW9uOgo+ID4+Pj4gICAgYS4gVkRVU0VfVlFfR0VUX0lORk8gaW9jdGwoKSByZXR1cm5z
IGFsd2F5cyAwIGZvciBhdmFpbAo+ID4+Pj4gICAgICAgaW5kZXgsIGV2ZW4gYWZ0ZXIgdGhlIHZp
cnRxdWV1ZSBoYXMgYWxyZWFkeSBiZWVuCj4gPj4+PiAgICAgICBwcm9jZXNzZWQuIElzIHRoYXQg
ZXhwZWN0ZWQ/IEkgaGF2ZSB0cmllZCBpbnN0ZWFkIHRvCj4gPj4+PiAgICAgICBnZXQgdGhlIGRy
aXZlcidzIGF2YWlsIGluZGV4IGRpcmVjdGx5IGZyb20gdGhlIGF2YWlsCj4gPj4+PiAgICAgICBy
aW5nLCBidXQgaXQgZG9lcyBub3Qgc2VlbSByZWxpYWJsZSBhcyBJIHNvbWV0aW1lcyBnZXQKPiA+
Pj4+ICAgICAgICJpZCAldSBpcyBub3QgYSBoZWFkIVxuIiB3YXJuaW5ncy4gQWxzbyBzdWNoIHNv
bHV0aW9uCj4gPj4+PiAgICAgICB3b3VsZCBub3QgYmUgcG9zc2libGUgd2l0aCBwYWNrZWQgcmlu
ZywgYXMgd2UgbmVlZCB0bwo+ID4+Pj4gICAgICAga25vdyB0aGUgd3JhcCBjb3VudGVycyB2YWx1
ZXMuCj4gPj4+Cj4gPj4+IExvb2tpbmcgYXQgdGhlIGNvZGVzLCBpdCBvbmx5IHJldHVybnMgdGhl
IHZhbHVlIHRoYXQgaXMgc2V0IHZpYQo+ID4+PiBzZXRfdnFfc3RhdGUoKS4gSSB0aGluayBpdCBp
cyBleHBlY3RlZCB0byBiZSBjYWxsZWQgYmVmb3JlIHRoZQo+ID4+PiBkYXRhcGF0aCBydW5zLgo+
ID4+Pgo+ID4+PiBTbyB3aGVuIGJvdW5kIHRvIHZpcnRpby12ZHBhLCBpdCBpcyBleHBlY3RlZCB0
byByZXR1cm4gMC4gQnV0IHdlIG5lZWQKPiA+Pj4gdG8gZml4IHRoZSBwYWNrZWQgdmlydHF1ZXVl
IGNhc2UsIEkgd29uZGVyIGlmIHdlIG5lZWQgdG8gY2FsbAo+ID4+PiBzZXRfdnFfc3RhdGUoKSBl
eHBsaWNpdGx5IGluIHZpcnRpby12ZHBhIGJlZm9yZSBzdGFydGluZyB0aGUgZGV2aWNlLgo+ID4+
Pgo+ID4+PiBXaGVuIGJvdW5kIHRvIHZob3N0LXZkcGEsIFFlbXUgd2lsbCBjYWxsIFZIT1NUX1NF
VF9WUklOR19CQVNFIHdoaWNoCj4gPj4+IHdpbGwgZW5kIHVwIGEgY2FsbCB0byBzZXRfdnFfc3Rh
dGUoKS4gVW5mb3J0dW5hdGVseSwgaXQgZG9lc24ndAo+ID4+PiBzdXBwb3J0IHBhY2tlZCByaW5n
IHdoaWNoIG5lZWRzIHNvbWUgZXh0ZW5zaW9uLgo+ID4+Pgo+ID4+Pj4KPiA+Pj4+ICAgIGIuIE1p
c3NpbmcgSU9DVExzOiBpdCB3b3VsZCBiZSBoYW5keSB0byBoYXZlIG5ldyBJT0NUTHMgdG8KPiA+
Pj4+ICAgICAgIHF1ZXJ5IFZpcnRpbyBkZXZpY2Ugc3RhdHVzLAo+ID4+Pgo+ID4+PiBXaGF0J3Mg
dGhlIHVzZSBjYXNlIG9mIHRoaXMgaW9jdGw/IEl0IGxvb2tzIHRvIG1lIHVzZXJzcGFjZSBpcwo+
ID4+PiBub3RpZmllZCBvbiBlYWNoIHN0YXR1cyBjaGFuZ2Ugbm93Ogo+ID4+Pgo+ID4+PiBzdGF0
aWMgaW50IHZkdXNlX2Rldl9zZXRfc3RhdHVzKHN0cnVjdCB2ZHVzZV9kZXYgKmRldiwgdTggc3Rh
dHVzKQo+ID4+PiB7Cj4gPj4+ICAgICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2X21zZyBtc2cgPSB7
IDAgfTsKPiA+Pj4KPiA+Pj4gICAgICAgICAgIG1zZy5yZXEudHlwZSA9IFZEVVNFX1NFVF9TVEFU
VVM7Cj4gPj4+ICAgICAgICAgICBtc2cucmVxLnMuc3RhdHVzID0gc3RhdHVzOwo+ID4+Pgo+ID4+
PiAgICAgICAgICAgcmV0dXJuIHZkdXNlX2Rldl9tc2dfc3luYyhkZXYsICZtc2cpOwo+ID4+PiB9
Cj4gPj4KPiA+PiBUaGUgaWRlYSB3YXMgdG8gYmUgYWJsZSB0byBxdWVyeSB0aGUgc3RhdHVzIGF0
IHJlY29ubmVjdCB0aW1lLCBhbmQKPiA+PiBuZWl0aGVyIGhhdmluZyB0byBhc3N1bWUgaXRzIHZh
bHVlIG5vciBoYXZpbmcgdG8gc3RvcmUgaXRzIHZhbHVlIGluIGEKPiA+PiBmaWxlICh0aGUgc3Rh
dHVzIGNvdWxkIGNoYW5nZSB3aGlsZSB0aGUgVkRVU0UgYXBwbGljYXRpb24gaXMgc3RvcHBlZCwK
PiA+PiBidXQgbWF5YmUgaXQgd291bGQgcmVjZWl2ZSB0aGUgbm90aWZpY2F0aW9uIGF0IHJlY29u
bmVjdCkuCj4gPgo+ID4gSSBzZWUuCj4gPgo+ID4+Cj4gPj4gSSB3aWxsIHByb3RvdHlwZSB1c2lu
ZyBhIHRtcGZzIGZpbGUgdG8gc2F2ZSBuZWVkZWQgaW5mb3JtYXRpb24sIGFuZCBzZWUKPiA+PiBp
ZiBpdCB3b3Jrcy4KPiA+Cj4gPiBJdCBtaWdodCB3b3JrIGJ1dCB0aGVuIHRoZSBBUEkgaXMgbm90
IHNlbGYgY29udGFpbmVkLiBNYXliZSBpdCdzCj4gPiBiZXR0ZXIgdG8gaGF2ZSBhIGRlZGljYXRl
ZCBpb2N0bC4KPiA+Cj4gPj4KPiA+Pj4+IGFuZCByZXRyaWV2ZSB0aGUgY29uZmlnCj4gPj4+PiAg
ICAgICBzcGFjZSBzZXQgYXQgVkRVU0VfQ1JFQVRFX0RFViB0aW1lLgo+ID4+Pgo+ID4+PiBJbiBv
cmRlciB0byBiZSBzYWZlLCBWRFVTRSBhdm9pZHMgd3JpdGFibGUgY29uZmlnIHNwYWNlLiBPdGhl
cndpc2UKPiA+Pj4gZHJpdmVycyBjb3VsZCBibG9jayBvbiBjb25maWcgd3JpdGluZyBmb3JldmVy
LiBUaGF0J3Mgd2h5IHdlIGRvbid0IGRvCj4gPj4+IGl0IG5vdy4KPiA+Pgo+ID4+IFRoZSBpZGVh
IHdhcyBub3QgdG8gbWFrZSB0aGUgY29uZmlnIHNwYWNlIHdyaXRhYmxlLCBidXQganVzdCB0byBi
ZSBhYmxlCj4gPj4gdG8gZmV0Y2ggd2hhdCB3YXMgZmlsbGVkIGF0IFZEVVNFX0NSRUFURV9ERVYg
dGltZS4KPiA+Pgo+ID4+IFdpdGggdGhlIHRtcGZzIGZpbGUsIHdlIGNhbiBhdm9pZCBkb2luZyB0
aGF0IGFuZCBqdXN0IHNhdmUgdGhlIGNvbmZpZwo+ID4+IHNwYWNlIHRoZXJlLgo+ID4KPiA+IFNh
bWUgYXMgdGhlIGNhc2UgZm9yIHN0YXR1cy4KPgo+IEkgaGF2ZSBjb29rZWQgYSBEUERLIHBhdGNo
IHRvIHN1cHBvcnQgcmVjb25uZWN0IHdpdGggYSB0bXBmcyBmaWxlIGFzCj4gc3VnZ2VzdGVkIGJ5
IFlvbmdqaToKPgo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9tY29xdWVsaW4vZHBkay1uZXh0LXZpcnRp
by8tL2NvbW1pdC81MzkxM2YyYjExNTViMDJjNDRkNWQzZDI5OGFhZmQzNTdlN2E4YzQ4CgpUaGlz
IHNlZW1zIHRyaWNreSwgZm9yIGV4YW1wbGUgZm9yIHN0YXR1czoKCmRldi0+bG9nLT5zdGF0dXMg
PSBkZXYtPnN0YXR1czsKCldoYXQgaWYgd2UgY3Jhc2ggaGVyZT8KCgo+Cj4gVGhhdCdzIHN0aWxs
IHJvdWdoIGFyb3VuZCB0aGUgZWRnZXMsIGJ1dCBpdCBzZWVtcyB0byB3b3JrIHJlbGlhYmx5Cj4g
Zm9yIHRoZSB0ZXN0aW5nIEkgaGF2ZSBkb25lIHNvIGZhci4gV2UnbGwgY2VydGFpbmx5IHdhbnQg
dG8gdXNlIHRoZQo+IHRtcGZzIG1lbW9yeSB0byBkaXJlY3RseSBzdG9yZSBhdmFpbGFibGUgaW5k
ZXhlcyBhbmQgd3JhcCBjb3VudGVycyB0bwo+IGF2b2lkIGludHJvZHVjaW5nIG92ZXJoZWFkIGlu
IHRoZSBkYXRhcGF0aC4KClRoYXQncyBmaW5lLCB3ZSBwcm9iYWJseSBuZWVkIGEgY2hhcHRlciBp
biB0aGUga2VybmVsIGRvYyB0byBkZXNjcmliZQp0aGUgcmVsaWFibGUgcmVjb25uZWN0aW9uIGJ1
dCBpdCBpcyBub3QgbGltaXRlZCB0byB0bXBmcy4KCj4gVGhlIHRyaWNreSBwYXJ0IHdpbGwgYmUg
dG8KPiBtYW5hZ2UgTlVNQSBhZmZpbml0eS4KClRoaXMgcGFydCBpcyBub3QgY2xlYXIgdG8gbWUs
IHdoYXQgYWZmaW5pdHkgc2hvdWxkIHdlIGNhcmUgYWJvdXQ/ClRoZXJlJ3MgYSBzeXNmcyB0aGF0
IHdhcyBpbnZlbnRlZCBieSBZb25nSmkgZm9yIHZpcnRxdWV1ZSBhZmZpbml0eQptYW5hZ2VtZW50
IHJlY2VudGx5LgoKVGhhbmtzCgo+Cj4gUmVnYXJkcywKPiBNYXhpbWUKPgo+ID4KPiA+IFRoYW5r
cwo+ID4KPiA+Pgo+ID4+PiBXZSBuZWVkIHRvIGhhcmRlbiB0aGUgY29uZmlnIHdyaXRlIGJlZm9y
ZSB3ZSBjYW4gcHJvY2VlZCB0byB0aGlzIEkgdGhpbmsuCj4gPj4+Cj4gPj4+Pgo+ID4+Pj4gMi4g
VkRVU0UgYXBwbGljYXRpb24gYXMgbm9uLXJvb3Q6Cj4gPj4+PiAgICAgV2UgbmVlZCB0byBydW4g
dGhlIFZEVVNFIGFwcGxpY2F0aW9uIGFzIG5vbi1yb290LiBUaGVyZQo+ID4+Pj4gICAgIGlzIHNv
bWUgcmFjZSBiZXR3ZWVuIHRoZSB0aW1lIHRoZSBVREVWIHJ1bGUgaXMgYXBwbGllZAo+ID4+Pj4g
ICAgIGFuZCB0aGUgdGltZSB0aGUgZGV2aWNlIHN0YXJ0cyBiZWluZyB1c2VkLiBEaXNjdXNzaW5n
Cj4gPj4+PiAgICAgd2l0aCBKYXNvbiwgaGUgc3VnZ2VzdGVkIHdlIG1heSBoYXZlIGEgVkRVU0Ug
ZGFlbW9uIHJ1bgo+ID4+Pj4gICAgIGFzIHJvb3QgdGhhdCB3b3VsZCBjcmVhdGUgdGhlIFZEVVNF
IGRldmljZSwgbWFuYWdlcyBpdHMKPiA+Pj4+ICAgICByaWdodHMgYW5kIHRoZW4gcGFzcyBpdHMg
ZmlsZSBkZXNjcmlwdG9yIHRvIHRoZSBWRFVTRQo+ID4+Pj4gICAgIGFwcC4gSG93ZXZlciwgd2l0
aCBjdXJyZW50IElPQ1RMcywgaXQgbWVhbnMgdGhlIFZEVVNFCj4gPj4+PiAgICAgZGFlbW9uIHdv
dWxkIG5lZWQgdG8ga25vdyBzZXZlcmFsIGluZm9ybWF0aW9uIHRoYXQKPiA+Pj4+ICAgICBiZWxv
bmdzIHRvIHRoZSBWRFVTRSBhcHAgaW1wbGVtZW50aW5nIHRoZSBkZXZpY2Ugc3VjaAo+ID4+Pj4g
ICAgIGFzIHN1cHBvcnRlZCBWaXJ0aW8gZmVhdHVyZXMsIGNvbmZpZyBzcGFjZSwgZXRjLi4uCj4g
Pj4+PiAgICAgSWYgd2UgZ28gdGhhdCByb3V0ZSwgbWF5YmUgd2Ugc2hvdWxkIGhhdmUgYSBjb250
cm9sCj4gPj4+PiAgICAgSU9DVEwgdG8gY3JlYXRlIHRoZSBkZXZpY2Ugd2hpY2ggd291bGQganVz
dCBwYXNzIHRoZQo+ID4+Pj4gICAgIGRldmljZSB0eXBlLiBUaGVuIGFub3RoZXIgZGV2aWNlIElP
Q1RMIHRvIHBlcmZvcm0gdGhlCj4gPj4+PiAgICAgaW5pdGlhbGl6YXRpb24uIFdvdWxkIHRoYXQg
bWFrZSBzZW5zZT8KPiA+Pj4KPiA+Pj4gSSB0aGluayBzby4gV2UgY2FuIGhlYXIgZnJvbSBvdGhl
cnMuCj4gPj4+Cj4gPj4+Pgo+ID4+Pj4gMy4gQ29yZWR1bXA6Cj4gPj4+PiAgICAgSW4gb3JkZXIg
dG8gYmUgYWJsZSB0byBwZXJmb3JtIHBvc3QtbW9ydGVtIGFuYWx5c2lzLCBEUERLCj4gPj4+PiAg
ICAgVmhvc3QgbGlicmFyeSBtYXJrcyBwYWdlcyB1c2VkIGZvciB2cmluZ3MgYW5kIGRlc2NyaXB0
b3JzCj4gPj4+PiAgICAgYnVmZmVycyBhcyBNQURWX0RPRFVNUCB1c2luZyBtYWR2aXNlKCkuIEhv
d2V2ZXIgd2l0aAo+ID4+Pj4gICAgIFZEVVNFIGl0IGZhaWxzIHdpdGggLUVJTlZBTC4gTXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IHdlCj4gPj4+PiAgICAgc2V0IFZNX0RPTlRFWFBBTkQgZmxhZyB0
byB0aGUgVk1BcyBhbmQgbWFkdmlzZSdzCj4gPj4+PiAgICAgTUFEVl9ET0RVTVAgZmFpbHMgaWYg
aXQgaXMgcHJlc2VudC4gSSdtIG5vdCBzdXJlIHRvCj4gPj4+PiAgICAgdW5kZXJzdGFuZCB3aHkg
bWFkdmlzZSB3b3VsZCBwcmV2ZW50IE1BRFZfRE9EVU1QIGlmCj4gPj4+PiAgICAgVk1fRE9OVEVY
UEFORCBpcyBzZXQuIEFueSB0aG91Z2h0cz8KPiA+Pj4KPiA+Pj4gQWRkaW5nIFBldGVyIHdobyBt
YXkga25vdyB0aGUgYW5zd2VyLgo+ID4+Cj4gPj4gVGhhbmtzIQo+ID4+IE1heGltZQo+ID4+Cj4g
Pj4+IFRoYW5rcwo+ID4+Pgo+ID4+Pj4KPiA+Pj4+IFswXTogaHR0cHM6Ly9wYXRjaHdvcmsuZHBk
ay5vcmcvcHJvamVjdC9kcGRrL2xpc3QvP3Nlcmllcz0yNzU5NCZzdGF0ZT0lMkEmYXJjaGl2ZT1i
b3RoCj4gPj4+PiBbMV06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FDR2tNRXRncnhO
M1BQd3NEbzRvT3Nuc1NMSmZFbUJFWjBXdmpHUnIzd2hVK1Fhc1VnQG1haWwuZ21haWwuY29tL1Qv
Cj4gPj4+Pgo+ID4+Pj4gTWF4aW1lIENvcXVlbGluICgyKToKPiA+Pj4+ICAgICB2ZHVzZTogdmFs
aWRhdGUgYmxvY2sgZmVhdHVyZXMgb25seSB3aXRoIGJsb2NrIGRldmljZXMKPiA+Pj4+ICAgICB2
ZHVzZTogZW5hYmxlIFZpcnRpby1uZXQgZGV2aWNlIHR5cGUKPiA+Pj4+Cj4gPj4+PiAgICBkcml2
ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgMTEgKysrKysrKy0tLS0KPiA+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPj4+Pgo+
ID4+Pj4gLS0KPiA+Pj4+IDIuMzkuMgo+ID4+Pj4KPiA+Pj4KPiA+Pgo+ID4KPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u

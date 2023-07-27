Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D92C0015E
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 08:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 412F281FE2;
	Thu, 27 Jul 2023 08:59:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 412F281FE2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M2/ZKM+8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TD5IgzfUwrLz; Thu, 27 Jul 2023 08:59:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CC6182007;
	Thu, 27 Jul 2023 08:59:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CC6182007
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F934C0071;
	Thu, 27 Jul 2023 08:59:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20F9CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD5FC82007
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:59:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD5FC82007
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qi4W2aqjmQfb
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:59:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A28CF81FE2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 08:59:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A28CF81FE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690448387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03oOF7vVj5UKxL75ZQcK8QbPvXNKmVEl+3ApUJjoHnU=;
 b=M2/ZKM+871OqgSg50V4JbRzsozFDpRNoUyEgOps3UfT9OmyleowKyZWByN9PvPMPHj6cCX
 KMuVAVYZ3t32y5sPajHEyL3GM2ILh8ymx2HQbZbQ9t9J4UwMxZmokORGAQiE3356Vw0Zi6
 nepuTAH+81KIBR9H4a2erCmpt5g1VOQ=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-D6XPUysuMu2mclUBMD2wvg-1; Thu, 27 Jul 2023 04:59:46 -0400
X-MC-Unique: D6XPUysuMu2mclUBMD2wvg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso6617411fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 01:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690448384; x=1691053184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03oOF7vVj5UKxL75ZQcK8QbPvXNKmVEl+3ApUJjoHnU=;
 b=ZrACVHzZ2GuMZBA85ihuXN7sQaxEyZycKT+uTlaiBftt4yviwrz+dkd5gVc3lzmklY
 GsKXeJJHA2lxP/M0t/YVjcxPKwiWw/fO/vlRr9y336lLgPVc58EzY6pk4YTmbgIhLtex
 l5CPXvDOoyzPhZj7f3Vn+zjyJfTq5As4jfRN8keWqoZ3kzyqhQY0ntdgfKhEBP46Y+V1
 VYTDeKIPgtpAXGm1ffoZI6RwmCwj935vuJPTjBDVnn2guIKZQNntefXrKpoGuShRO0x9
 EbgIHbCRe8pw+vP1L3sYXG5S6PrTZuQOUIJcBCmlBCtugpXMTDEWmWCjaA2NDxa9xBct
 xSKg==
X-Gm-Message-State: ABy/qLbbKQiERAerf6eJ1H1iogRDE2jLJ1w+hJ0fV6e/BsR98WzCEhn7
 fwaOPXrLHKd/+yHbs01jgpvGcOujZ0avuOxQuOTMCF6CpvFHZXiuDMX6m3rS5xorY5jesjJT4JP
 Q2npdNGvm8N3H3rUzsW2fNb74sls1ixjudtjbhBCSscAQ5xwD0QZtcGY9Sg==
X-Received: by 2002:a2e:9c10:0:b0:2b6:e719:324e with SMTP id
 s16-20020a2e9c10000000b002b6e719324emr1191511lji.49.1690448384601; 
 Thu, 27 Jul 2023 01:59:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHta/cwZDR4YvqZd7bkc+MnqB/nYdlybw3rLP1YeL9CwKygmbdMr6fEdy2Lpxr/bmjs7Sv7CuvCV3CAuMBEsOU=
X-Received: by 2002:a2e:9c10:0:b0:2b6:e719:324e with SMTP id
 s16-20020a2e9c10000000b002b6e719324emr1191498lji.49.1690448384237; Thu, 27
 Jul 2023 01:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org>
 <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727020930-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 27 Jul 2023 16:59:33 +0800
Message-ID: <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMjoxMOKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgMjcsIDIwMjMgYXQgMDI6MDM6NTlQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFdlZCwgSnVsIDI2LCAyMDIzIGF0IDc6
MzjigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMDk6NTU6MzdBTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIEp1bCAyNSwgMjAyMyBhdCAzOjM24oCvUE0gTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
T24gVHVlLCBKdWwgMjUsIDIwMjMgYXQgMTE6MDc6NDBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiA+ID4gPiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMzoxN+KAr1BNIE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IE9uIFNhdCwgSnVsIDIyLCAyMDIzIGF0IDQ6MTjigK9B
TSBNYXhpbWUgQ29xdWVsaW4KPiA+ID4gPiA+ID4gPiA+IDxtYXhpbWUuY29xdWVsaW5AcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIDcvMjEvMjMgMTc6MTAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBh
dCAwNDo1ODowNFBNICswMjAwLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4g
PiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+IE9uIDcvMjEv
MjMgMTY6NDUsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPj4+
IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0IDA0OjM3OjAwUE0gKzAyMDAsIE1heGltZSBDb3F1ZWxp
biB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Cj4g
PiA+ID4gPiA+ID4gPiA+ID4+Pj4gT24gNy8yMC8yMyAyMzowMiwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAyMCwgMjAyMyBhdCAw
MToyNjoyMFBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
Pj4+Pj4+IE9uIDcvMjAvMjMgMTozOCBBTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2No
ZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxvb3AgZm9yIGEgYmV0dGVyCj4gPiA+ID4gPiA+
ID4gPiA+ID4+Pj4+Pj4gY28tb3BlcmF0aW9uIHdpdGggdGhlIHNjaGVkdWxlci4gVGhpcyBhbGxv
d3MgdG8gZ2l2ZSBDUFUgYSBicmVhdGggdG8KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBydW4g
b3RoZXIgdGFzayh3b3JrcXVldWUpIGluc3RlYWQgb2YgYnVzeSBsb29waW5nIHdoZW4gcHJlZW1w
dGlvbiBpcwo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNl
IHdob3NlIENWUSBtaWdodCBiZSBzbG93Lgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+Cj4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+
Pj4+PiBUaGlzIHN0aWxsIGxlYXZlcyBodW5nIHByb2Nlc3NlcywgYnV0IGF0IGxlYXN0IGl0IGRv
ZXNuJ3QgcGluIHRoZSBDUFUgYW55Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+PiBtb3JlLiAgVGhh
bmtzLgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6IFNoYW5ub24gTmVsc29u
IDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4KPiA+ID4g
PiA+ID4gPiA+ID4gPj4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4gSSdkIGxpa2UgdG8gc2Vl
IGEgZnVsbCBzb2x1dGlvbgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+PiAxLSBibG9jayB1bnRpbCBp
bnRlcnJ1cHQKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBJIHJlbWVtYmVyIGluIHBy
ZXZpb3VzIHZlcnNpb25zLCB5b3Ugd29ycmllZCBhYm91dCB0aGUgZXh0cmEgTVNJCj4gPiA+ID4g
PiA+ID4gPiB2ZWN0b3IuIChNYXliZSBJIHdhcyB3cm9uZykuCj4gPiA+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+ID4gPiA+Pj4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4gV291bGQgaXQgbWFrZSBz
ZW5zZSB0byBhbHNvIGhhdmUgYSB0aW1lb3V0Pwo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+IEFuZCB3
aGVuIHRpbWVvdXQgZXhwaXJlcywgc2V0IEZBSUxFRCBiaXQgaW4gZGV2aWNlIHN0YXR1cz8KPiA+
ID4gPiA+ID4gPiA+ID4gPj4+Cj4gPiA+ID4gPiA+ID4gPiA+ID4+PiB2aXJ0aW8gc3BlYyBkb2Vz
IG5vdCBzZXQgYW55IGxpbWl0cyBvbiB0aGUgdGltaW5nIG9mIHZxCj4gPiA+ID4gPiA+ID4gPiA+
ID4+PiBwcm9jZXNzaW5nLgo+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+
PiBJbmRlZWQsIGJ1dCBJIHRob3VnaHQgdGhlIGRyaXZlciBjb3VsZCBkZWNpZGUgaXQgaXMgdG9v
IGxvbmcgZm9yIGl0Lgo+ID4gPiA+ID4gPiA+ID4gPiA+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+PiBU
aGUgaXNzdWUgaXMgd2Uga2VlcCB3YWl0aW5nIHdpdGggcnRubCBsb2NrZWQsIGl0IGNhbiBxdWlj
a2x5IG1ha2UgdGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4+IHN5c3RlbSB1bnVzYWJsZS4KPiA+ID4g
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+IGlmIHRoaXMgaXMgYSBwcm9ibGVtIHdl
IHNob3VsZCBmaW5kIGEgd2F5IG5vdCB0byBrZWVwIHJ0bmwKPiA+ID4gPiA+ID4gPiA+ID4gPiBs
b2NrZWQgaW5kZWZpbml0ZWx5Lgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEFueSBp
ZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8gU2ltcGx5IGRyb3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBi
dXN5IGxvb3AKPiA+ID4gPiA+ID4gPiA+IHdpbGwgcmVzdWx0IGluIGEgbG90IG9mIHJhY2VzLiBU
aGlzIHNlZW1zIHRvIHJlcXVpcmUgbm9uLXRyaXZpYWwKPiA+ID4gPiA+ID4gPiA+IGNoYW5nZXMg
aW4gdGhlIG5ldHdvcmtpbmcgY29yZS4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4gPiA+ICBGcm9tIHRoZSB0ZXN0cyBJIGhhdmUgZG9uZSwgSSB0aGluayBp
dCBpcy4gV2l0aCBPVlMsIGEgcmVjb25maWd1cmF0aW9uCj4gPiA+ID4gPiA+ID4gPiA+IGlzIHBl
cmZvcm1lZCB3aGVuIHRoZSBWRFVTRSBkZXZpY2UgaXMgYWRkZWQsIGFuZCB3aGVuIGEgTUxYNSBk
ZXZpY2UgaXMKPiA+ID4gPiA+ID4gPiA+ID4gaW4gdGhlIHNhbWUgYnJpZGdlLCBpdCBlbmRzIHVw
IGRvaW5nIGFuIGlvY3RsKCkgdGhhdCB0cmllcyB0byB0YWtlIHRoZQo+ID4gPiA+ID4gPiA+ID4g
PiBydG5sIGxvY2suIEluIHRoaXMgY29uZmlndXJhdGlvbiwgaXQgaXMgbm90IHBvc3NpYmxlIHRv
IGtpbGwgT1ZTIGJlY2F1c2UKPiA+ID4gPiA+ID4gPiA+ID4gaXQgaXMgc3R1Y2sgdHJ5aW5nIHRv
IGFjcXVpcmUgcnRubCBsb2NrIGZvciBtbHg1IHRoYXQgaXMgaGVsZCBieSB2aXJ0aW8tCj4gPiA+
ID4gPiA+ID4gPiA+IG5ldC4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBZZWFoLCBi
YXNpY2FsbHksIGFueSBSVE5MIHVzZXJzIHdvdWxkIGJlIGJsb2NrZWQgZm9yZXZlci4KPiA+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBBbmQgdGhlIGluZmluaXRlIGxvb3AgaGFzIG90aGVy
IHNpZGUgZWZmZWN0cyBsaWtlIGl0IGJsb2NrcyB0aGUgZnJlZXplciB0byB3b3JrLgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRvIHN1bW1hcml6ZSwgdGhlcmUgYXJlIHRocmVlIGlz
c3Vlcwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IDEpIGJ1c3kgcG9sbGluZwo+ID4g
PiA+ID4gPiA+ID4gMikgYnJlYWtzIGZyZWV6ZXIKPiA+ID4gPiA+ID4gPiA+IDMpIGhvbGQgUlRO
TCBkdXJpbmcgdGhlIGxvb3AKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBTb2x2aW5n
IDMgbWF5IGhlbHAgc29tZWhvdyBmb3IgMiBlLmcgc29tZSBwbSByb3V0aW5lIGUuZyB3aXJlZ3Vh
cmQgb3IKPiA+ID4gPiA+ID4gPiA+IGV2ZW4gdmlydG5ldF9yZXN0b3JlKCkgaXRzZWxmIG1heSB0
cnkgdG8gaG9sZCB0aGUgbG9jay4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFllcC4gU28g
bXkgZmVlbGluZyBjdXJyZW50bHkgaXMsIHRoZSBvbmx5IHJlYWwgZml4IGlzIHRvIGFjdHVhbGx5
Cj4gPiA+ID4gPiA+ID4gcXVldWUgdXAgdGhlIHdvcmsgaW4gc29mdHdhcmUuCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IERvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlOgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiBydG5sX2xvY2soKTsKPiA+ID4gPiA+ID4gcXVldWUgdXAgdGhlIHdvcmsKPiA+ID4g
PiA+ID4gcnRubF91bmxvY2soKTsKPiA+ID4gPiA+ID4gcmV0dXJuIHN1Y2Nlc3M7Cj4gPiA+ID4g
PiA+Cj4gPiA+ID4gPiA+ID8KPiA+ID4gPiA+Cj4gPiA+ID4gPiB5ZXMKPiA+ID4gPgo+ID4gPiA+
IFdlIHdpbGwgbG9zZSB0aGUgZXJyb3IgcmVwb3J0aW5nLCBpcyBpdCBhIHJlYWwgcHJvYmxlbSBv
ciBub3Q/Cj4gPiA+Cj4gPiA+IEZ1bmRhbWVudGFsIGlzbid0IGl0PyBNYXliZSB3ZSB3YW50IGEg
cGVyLWRldmljZSBmbGFnIGZvciBhIGFzeW5jaCBjb21tYW5kcywKPiA+ID4gYW5kIHZkdXNlIHdp
bGwgc2V0IGl0IHdoaWxlIGhhcmR3YXJlIHZpcnRpbyB3b24ndC4KPiA+ID4gdGhpcyB3YXkgd2Ug
b25seSBsb3NlIGVycm9yIHJlcG9ydGluZyBmb3IgdmR1c2UuCj4gPgo+ID4gVGhpcyBwcm9ibGVt
IGlzIG5vdCBWRFVTRSBzcGVjaWZpYywgRFBVcy92RFBBIG1heSBzdWZmZXIgZnJvbSB0aGlzIGFz
Cj4gPiB3ZWxsLiBUaGlzIG1pZ2h0IHJlcXVpcmUgbW9yZSB0aG91Z2h0cy4KPiA+Cj4gPiBUaGFu
a3MKPgo+IFRoZXkgcmVhbGx5IHNob3VsZG4ndCAtIGFueSBOSUMgdGhhdCB0YWtlcyBmb3JldmVy
IHRvCj4gcHJvZ3JhbSB3aWxsIGNyZWF0ZSBpc3N1ZXMgaW4gdGhlIG5ldHdvcmtpbmcgc3RhY2su
CgpVbmZvcnR1bmF0ZWx5LCBpdCdzIG5vdCByYXJlIGFzIHRoZSBkZXZpY2UvY3ZxIGNvdWxkIGJl
IGltcGxlbWVudGVkCnZpYSBmaXJtd2FyZSBvciBzb2Z0d2FyZS4KCj4gQnV0IGlmIHRoZXkgZG8g
dGhleSBjYW4gYWx3YXlzIHNldCB0aGlzIGZsYWcgdG9vLgoKVGhpcyBtYXkgaGF2ZSBmYWxzZSBu
ZWdhdGl2ZXMgYW5kIG1heSBjb25mdXNlIHRoZSBtYW5hZ2VtZW50LgoKTWF5YmUgd2UgY2FuIGV4
dGVuZCB0aGUgbmV0d29ya2luZyBjb3JlIHRvIGFsbG93IHNvbWUgZGV2aWNlIHNwZWNpZmljCmNv
bmZpZ3VyYXRpb25zIHRvIGJlIGRvbmUgd2l0aCBkZXZpY2Ugc3BlY2lmaWMgbG9jayB3aXRob3V0
IHJ0bmwuIEZvcgpleGFtcGxlLCBzcGxpdCB0aGUgc2V0X2NoYW5uZWxzIHRvCgpwcmVfc2V0X2No
YW5uZWxzCnNldF9jaGFubmVscwpwb3N0X3NldF9jaGFubmVscwoKVGhlIGRldmljZSBzcGVjaWZp
YyBwYXJ0IGNvdWxkIGJlIGRvbmUgaW4gcHJlIGFuZCBwb3N0IHdpdGhvdXQgYSBydG5sIGxvY2s/
CgpUaGFua3MKCgoKPgo+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSXQn
cyBtb3N0bHkgdHJpdmlhbCB0byBsaW1pdAo+ID4gPiA+ID4gPiA+IG1lbW9yeSBjb25zdW1wdGlv
biwgdmlkJ3MgaXMgdGhlCj4gPiA+ID4gPiA+ID4gb25seSBvbmUgd2hlcmUgaXQgd291bGQgbWFr
ZSBzZW5zZSB0byBoYXZlIG1vcmUgdGhhbgo+ID4gPiA+ID4gPiA+IDEgY29tbWFuZCBvZiBhIGdp
dmVuIHR5cGUgb3V0c3RhbmRpbmcuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEFuZCByeCBtb2Rl
IHNvIHRoaXMgaW1wbGllcyB3ZSB3aWxsIGZhaWwgYW55IGNvbW1hbmQgaWYgdGhlIHByZXZpb3Vz
Cj4gPiA+ID4gPiA+IHdvcmsgaXMgbm90IGZpbmlzaGVkLgo+ID4gPiA+ID4KPiA+ID4gPiA+IGRv
bid0IGZhaWwgaXQsIHN0b3JlIGl0Lgo+ID4gPiA+Cj4gPiA+ID4gT2suCj4gPiA+ID4KPiA+ID4g
PiBUaGFua3MKPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBoYXZlIGEgdHJlZQo+ID4g
PiA+ID4gPiA+IG9yIGEgYml0bWFwIHdpdGggdmlkcyB0byBhZGQvcmVtb3ZlPwo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiBQcm9iYWJseS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzCj4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4g
Mi0gc3RpbGwgaGFuZGxlIHN1cnByaXNlIHJlbW92YWwgY29ycmVjdGx5IGJ5IHdha2luZyBpbiB0
aGF0IGNhc2UKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBUaGlzIGlzIGJhc2ljYWxs
eSB3aGF0IHZlcnNpb24gMSBkaWQ/Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82MDI2ZTgwMS02ZmRhLWZlZTktYTY5Yi1kMDZhODAz
Njg2MjFAcmVkaGF0LmNvbS90Lwo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoYW5r
cwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gWWVzIC0gZXhjZXB0IHRoZSB0aW1lb3V0IHBh
cnQuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pgo+
ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pgo+ID4gPiA+ID4g
PiA+ID4gPiA+Pj4+Pj4+IC0tLQo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIHwgNCArKystCj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAg
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+ID4g
PiA+ID4gPiA+ID4+Pj4+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gaW5kZXggOWYzYjFkNmFjMzNkLi5lNzUzM2YyOWIyMTkgMTAw
NjQ0Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gQEAgLTIzMTQsOCArMjMxNCwxMCBAQCBzdGF0
aWMgYm9vbCB2aXJ0bmV0X3NlbmRfY29tbWFuZChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgdTgg
Y2xhc3MsIHU4IGNtZCwKPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICAgKiBp
bnRvIHRoZSBoeXBlcnZpc29yLCBzbyB0aGUgcmVxdWVzdCBzaG91bGQgYmUgaGFuZGxlZCBpbW1l
ZGlhdGVseS4KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICAgKi8KPiA+ID4g
PiA+ID4gPiA+ID4gPj4+Pj4+PiAgICAgICAgICAgICB3aGlsZSAoIXZpcnRxdWV1ZV9nZXRfYnVm
KHZpLT5jdnEsICZ0bXApICYmCj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gLSAgICAgICAgICAg
ICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpCj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+
Pj4gKyAgICAgICAgICAgICAgIXZpcnRxdWV1ZV9pc19icm9rZW4odmktPmN2cSkpIHsKPiA+ID4g
PiA+ID4gPiA+ID4gPj4+Pj4+PiArICAgICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4gPiA+
ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsKPiA+
ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiArICAgICAgIH0KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+ICAgICAgICAgICAgIHJldHVybiB2aS0+Y3RybC0+
c3RhdHVzID09IFZJUlRJT19ORVRfT0s7Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gICAgICB9
Cj4gPiA+ID4gPiA+ID4gPiA+ID4+Pj4+Pj4gLS0KPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiAy
LjM5LjMKPiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+Pj4+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiA+ID4g
PiA+ID4gPiA+ID4+Pj4+Pj4gVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0Cj4gPiA+ID4gPiA+
ID4gPiA+ID4+Pj4+Pj4gVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
PiA+ID4gPiA+ID4gPiA+ID4gPj4+Pj4+PiBodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4+
Pgo+ID4gPiA+ID4gPiA+ID4gPiA+Pj4KPiA+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

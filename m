Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F16C77B7D
	for <virtualization@archiver.kernel.org>; Mon, 15 May 2023 01:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5B7583AFE;
	Mon, 15 May 2023 01:07:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5B7583AFE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ev9SzvEh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lla6Fxgmc46t; Mon, 15 May 2023 01:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1599483BEE;
	Mon, 15 May 2023 01:07:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1599483BEE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1F21C0036;
	Mon, 15 May 2023 01:06:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27B38C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8A8840399
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8A8840399
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ev9SzvEh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kA1kHec0ObwR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E686402E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E686402E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 May 2023 01:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684112816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GShV9rQVPoiBC3aZLWHV81IRxeBh9KQe/grJK0OSZg=;
 b=ev9SzvEhpHTPrYn8c6TIUyk5DUV2unRoYwlGrYTK653O+04V93u9/G2nMVu2bezpBcNri0
 XRhBx6/nlP69MQcqb7B19Nx+5jr+e8fFdVbTU0wP7iZmsML5QVPLDAO7r+IwreUE8EO8tp
 9jFTljBzI9f92V6FwBD8K9fwKiu9OwQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-bq06gwiON3aLKf_5NFzIpw-1; Sun, 14 May 2023 21:06:54 -0400
X-MC-Unique: bq06gwiON3aLKf_5NFzIpw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4edc5d704a0so7197220e87.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 14 May 2023 18:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684112813; x=1686704813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GShV9rQVPoiBC3aZLWHV81IRxeBh9KQe/grJK0OSZg=;
 b=HrZ8jhCluFwVTb7/rFEnCBIEARyhs/LXONCn0//iArTULDLsj8ZaAx+0/7MvwlzDe4
 znU57m5gWcd0k9m8ZGREQBBDOOr9mQugUMzg5SQ9wN/T0/Dy9jPNRnsuHsd4vrHtu8QN
 07yFfpxttrweCWBNgm/f6Jwa6/bYSBsWv0CT6nr1VpClqsXfF+wZK5xWiC70101YfIyO
 kzJ1VwyHO9Ma1CFevQEWhieqW07nRiVC6q4gWogxyDWDrNkQByyYio263dqYhPPFyNIR
 nNnpcb9qVodiFu+MYRisJ7IiA2Zc9jiMap13FgrjIAN6P5erzzyiaIRGpCqc+A32bYlm
 uZIA==
X-Gm-Message-State: AC+VfDxRkcghNwsvV/gW+LP9w0RK3WsCgwVzpctG0fL5W2w+FQcVERU9
 4lo/c3UWmAsYA0CIdarqzEHXqtn6kGVcOcm+ltmQh2T8yUwfP/yi1MsSk/hdcXF3TZAU5Ica6cW
 i+944pcwam7SLJfhM7NlMRXLNVEEEEn4gXsrf9yPST3umLy/lGtBVaOmlyA==
X-Received: by 2002:ac2:55a6:0:b0:4ee:d8f3:1398 with SMTP id
 y6-20020ac255a6000000b004eed8f31398mr5934360lfg.68.1684112813213; 
 Sun, 14 May 2023 18:06:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45LxbE+gq1RPYwef6WE67FgUUzSqPe9cPjccRfp9vTAvE7LGqJ2vn8M657T3NlXAupmgs40Ezr6Ol6Lylly1U=
X-Received: by 2002:ac2:55a6:0:b0:4ee:d8f3:1398 with SMTP id
 y6-20020ac255a6000000b004eed8f31398mr5934353lfg.68.1684112813027; Sun, 14 May
 2023 18:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230512151812.1806-1-feliu@nvidia.com>
In-Reply-To: <20230512151812.1806-1-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 May 2023 09:06:41 +0800
Message-ID: <CACGkMEvMDWZg56TfMX0XV86ANet01WU1Mr+ZCQa_Xphem42ydw@mail.gmail.com>
Subject: Re: [PATCH net v6] virtio_net: Fix error unwinding of XDP
 initialization
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, William Tu <witu@nvidia.com>,
 Simon Horman <simon.horman@corigine.com>, Bodong Wang <bodong@nvidia.com>,
 bpf@vger.kernel.org
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

T24gRnJpLCBNYXkgMTIsIDIwMjMgYXQgMTE6MTjigK9QTSBGZW5nIExpdSA8ZmVsaXVAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPiBXaGVuIGluaXRpYWxpemluZyBYRFAgaW4gdmlydG5ldF9vcGVuKCks
IHNvbWUgcnEgeGRwIGluaXRpYWxpemF0aW9uCj4gbWF5IGhpdCBhbiBlcnJvciBjYXVzaW5nIG5l
dCBkZXZpY2Ugb3BlbiBmYWlsZWQuIEhvd2V2ZXIsIHByZXZpb3VzCj4gcnFzIGhhdmUgYWxyZWFk
eSBpbml0aWFsaXplZCBYRFAgYW5kIGVuYWJsZWQgTkFQSSwgd2hpY2ggaXMgbm90IHRoZQo+IGV4
cGVjdGVkIGJlaGF2aW9yLiBOZWVkIHRvIHJvbGwgYmFjayB0aGUgcHJldmlvdXMgcnEgaW5pdGlh
bGl6YXRpb24KPiB0byBhdm9pZCBsZWFrcyBpbiBlcnJvciB1bndpbmRpbmcgb2YgaW5pdCBjb2Rl
Lgo+Cj4gQWxzbyBleHRyYWN0IGhlbHBlciBmdW5jdGlvbnMgb2YgZGlzYWJsZSBhbmQgZW5hYmxl
IHF1ZXVlIHBhaXJzLgo+IFVzZSBuZXdseSBpbnRyb2R1Y2VkIGRpc2FibGUgaGVscGVyIGZ1bmN0
aW9uIGluIGVycm9yIHVud2luZGluZyBhbmQKPiB2aXJ0bmV0X2Nsb3NlLiBVc2UgZW5hYmxlIGhl
bHBlciBmdW5jdGlvbiBpbiB2aXJ0bmV0X29wZW4uCj4KPiBGaXhlczogNzU0YjhhMjFhOTZkICgi
dmlydGlvX25ldDogc2V0dXAgeGRwX3J4cV9pbmZvIikKPiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExp
dSA8ZmVsaXVAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amlyaUBudmlk
aWEuY29tPgo+IFJldmlld2VkLWJ5OiBXaWxsaWFtIFR1IDx3aXR1QG52aWRpYS5jb20+CgpBY2tl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiB2
NSAtPiB2Ngo+IGZlZWRiYWNrcyBmcm9tIFh1YW4gWmh1bwo+IC0gYWRkIGRpc2FibGVfZGVsYXll
ZF9yZWZpbGwgYW5kIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYwo+Cj4gdjQgLT4gdjUKPiBmZWVk
YmFja3MgZnJvbSBNaWNoYWVsIFMuIFRzaXJraW4KPiAtIHJlbmFtZSBoZWxwZXIgYXMgdmlydG5l
dF9kaXNhYmxlX3F1ZXVlX3BhaXIKPiAtIHJlbmFtZSBoZWxwZXIgYXMgdmlydG5ldF9lbmFibGVf
cXVldWVfcGFpcgo+Cj4gdjMgLT4gdjQKPiBmZWVkYmFja3MgZnJvbSBKaXJpIFBpcmtvCj4gLSBB
ZGQgc3ltbWV0cmljIGhlbHBlciBmdW5jdGlvbiB2aXJ0bmV0X2VuYWJsZV9xcCB0byBlbmFibGUg
cXVldWVzLgo+IC0gRXJyb3IgaGFuZGxlOiAgY2xlYW51cCBjdXJyZW50IHF1ZXVlIHBhaXIgaW4g
dmlydG5ldF9lbmFibGVfcXAsCj4gICBhbmQgY29tcGxldGUgdGhlIHJlc2V0IHF1ZXVlIHBhaXJz
IGNsZWFudXAgaW4gdmlydG5ldF9vcGVuLgo+IC0gRml4IGNvZGluZyBzdHlsZS4KPiBmZWVkYmFj
a3MgZnJvbSBQYXJhdiBQYW5kaXQKPiAtIFJlbW92ZSByZWR1bmRhbnQgZGVidWcgbWVzc2FnZSBh
bmQgd2hpdGUgc3BhY2UuCj4KPiB2MiAtPiB2Mwo+IGZlZWRiYWNrcyBmcm9tIE1pY2hhZWwgUy4g
VHNpcmtpbgo+IC0gUmVtb3ZlIHJlZHVuZGFudCBjb21tZW50Lgo+Cj4gdjEgLT4gdjIKPiBmZWVk
YmFja3MgZnJvbSBNaWNoYWVsIFMuIFRzaXJraW4KPiAtIHNxdWFzaCB0d28gcGF0Y2hlcyB0b2dl
dGhlci4KPgo+IC0tLQo+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA2MSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNl
cnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCBhMTJhZTI2ZGIw
ZTIuLjU2Y2ExZDI3MDMwNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMTg2OCw2ICsxODY4LDM4IEBA
IHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsKHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1
ZGdldCkKPiAgICAgICAgIHJldHVybiByZWNlaXZlZDsKPiAgfQo+Cj4gK3N0YXRpYyB2b2lkIHZp
cnRuZXRfZGlzYWJsZV9xdWV1ZV9wYWlyKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBpbnQgcXBf
aW5kZXgpCj4gK3sKPiArICAgICAgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2aS0+c3FbcXBf
aW5kZXhdLm5hcGkpOwo+ICsgICAgICAgbmFwaV9kaXNhYmxlKCZ2aS0+cnFbcXBfaW5kZXhdLm5h
cGkpOwo+ICsgICAgICAgeGRwX3J4cV9pbmZvX3VucmVnKCZ2aS0+cnFbcXBfaW5kZXhdLnhkcF9y
eHEpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IHZpcnRuZXRfZW5hYmxlX3F1ZXVlX3BhaXIoc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmksIGludCBxcF9pbmRleCkKPiArewo+ICsgICAgICAgc3RydWN0
IG5ldF9kZXZpY2UgKmRldiA9IHZpLT5kZXY7Cj4gKyAgICAgICBpbnQgZXJyOwo+ICsKPiArICAg
ICAgIGVyciA9IHhkcF9yeHFfaW5mb19yZWcoJnZpLT5ycVtxcF9pbmRleF0ueGRwX3J4cSwgZGV2
LCBxcF9pbmRleCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmktPnJxW3FwX2lu
ZGV4XS5uYXBpLm5hcGlfaWQpOwo+ICsgICAgICAgaWYgKGVyciA8IDApCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBlcnI7Cj4gKwo+ICsgICAgICAgZXJyID0geGRwX3J4cV9pbmZvX3JlZ19tZW1f
bW9kZWwoJnZpLT5ycVtxcF9pbmRleF0ueGRwX3J4cSwKPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1FTV9UWVBFX1BBR0VfU0hBUkVELCBOVUxMKTsKPiArICAgICAg
IGlmIChlcnIgPCAwKQo+ICsgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfcmVnX21lbV9tb2Rl
bDsKPiArCj4gKyAgICAgICB2aXJ0bmV0X25hcGlfZW5hYmxlKHZpLT5ycVtxcF9pbmRleF0udnEs
ICZ2aS0+cnFbcXBfaW5kZXhdLm5hcGkpOwo+ICsgICAgICAgdmlydG5ldF9uYXBpX3R4X2VuYWJs
ZSh2aSwgdmktPnNxW3FwX2luZGV4XS52cSwgJnZpLT5zcVtxcF9pbmRleF0ubmFwaSk7Cj4gKwo+
ICsgICAgICAgcmV0dXJuIDA7Cj4gKwo+ICtlcnJfeGRwX3JlZ19tZW1fbW9kZWw6Cj4gKyAgICAg
ICB4ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtxcF9pbmRleF0ueGRwX3J4cSk7Cj4gKyAgICAg
ICByZXR1cm4gZXJyOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IHZpcnRuZXRfb3BlbihzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9
IG5ldGRldl9wcml2KGRldik7Cj4gQEAgLTE4ODEsMjIgKzE5MTMsMjAgQEAgc3RhdGljIGludCB2
aXJ0bmV0X29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoIXRyeV9maWxsX3JlY3YodmksICZ2aS0+cnFbaV0sIEdGUF9LRVJORUwpKQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZ2aS0+
cmVmaWxsLCAwKTsKPgo+IC0gICAgICAgICAgICAgICBlcnIgPSB4ZHBfcnhxX2luZm9fcmVnKCZ2
aS0+cnFbaV0ueGRwX3J4cSwgZGV2LCBpLCB2aS0+cnFbaV0ubmFwaS5uYXBpX2lkKTsKPiArICAg
ICAgICAgICAgICAgZXJyID0gdmlydG5ldF9lbmFibGVfcXVldWVfcGFpcih2aSwgaSk7Cj4gICAg
ICAgICAgICAgICAgIGlmIChlcnIgPCAwKQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBlcnI7Cj4gLQo+IC0gICAgICAgICAgICAgICBlcnIgPSB4ZHBfcnhxX2luZm9fcmVnX21lbV9t
b2RlbCgmdmktPnJxW2ldLnhkcF9yeHEsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE1FTV9UWVBFX1BBR0VfU0hBUkVELCBOVUxMKTsKPiAtICAgICAg
ICAgICAgICAgaWYgKGVyciA8IDApIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcnhx
X2luZm9fdW5yZWcoJnZpLT5ycVtpXS54ZHBfcnhxKTsKPiAtICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gZXJyOwo+IC0gICAgICAgICAgICAgICB9Cj4gLQo+IC0gICAgICAgICAgICAgICB2
aXJ0bmV0X25hcGlfZW5hYmxlKHZpLT5ycVtpXS52cSwgJnZpLT5ycVtpXS5uYXBpKTsKPiAtICAg
ICAgICAgICAgICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgdmktPnNxW2ldLnZxLCAmdmkt
PnNxW2ldLm5hcGkpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2VuYWJsZV9x
cDsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgcmV0dXJuIDA7Cj4gKwo+ICtlcnJfZW5hYmxlX3Fw
Ogo+ICsgICAgICAgZGlzYWJsZV9kZWxheWVkX3JlZmlsbCh2aSk7Cj4gKyAgICAgICBjYW5jZWxf
ZGVsYXllZF93b3JrX3N5bmMoJnZpLT5yZWZpbGwpOwo+ICsKPiArICAgICAgIGZvciAoaS0tOyBp
ID49IDA7IGktLSkKPiArICAgICAgICAgICAgICAgdmlydG5ldF9kaXNhYmxlX3F1ZXVlX3BhaXIo
dmksIGkpOwo+ICsgICAgICAgcmV0dXJuIGVycjsKPiAgfQo+Cj4gIHN0YXRpYyBpbnQgdmlydG5l
dF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiBAQCAtMjMw
NSwxMSArMjMzNSw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KQo+ICAgICAgICAgLyogTWFrZSBzdXJlIHJlZmlsbF93b3JrIGRvZXNuJ3QgcmUtZW5h
YmxlIG5hcGkhICovCj4gICAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnZpLT5yZWZp
bGwpOwo+Cj4gLSAgICAgICBmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsr
KSB7Cj4gLSAgICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2aS0+c3FbaV0u
bmFwaSk7Cj4gLSAgICAgICAgICAgICAgIG5hcGlfZGlzYWJsZSgmdmktPnJxW2ldLm5hcGkpOwo+
IC0gICAgICAgICAgICAgICB4ZHBfcnhxX2luZm9fdW5yZWcoJnZpLT5ycVtpXS54ZHBfcnhxKTsK
PiAtICAgICAgIH0KPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJz
OyBpKyspCj4gKyAgICAgICAgICAgICAgIHZpcnRuZXRfZGlzYWJsZV9xdWV1ZV9wYWlyKHZpLCBp
KTsKPgo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPiAtLQo+IDIuMzcuMSAoQXBwbGUgR2l0LTEz
Ny4xKQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=

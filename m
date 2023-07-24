Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36138C001DE
	for <virtualization@archiver.kernel.org>; Mon, 24 Jul 2023 07:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E38D60B6E;
	Mon, 24 Jul 2023 07:17:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E38D60B6E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OVe8Bxiy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5qRrDgEXeYdL; Mon, 24 Jul 2023 07:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 039AD60B65;
	Mon, 24 Jul 2023 07:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 039AD60B65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB55C0071;
	Mon, 24 Jul 2023 07:17:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46390C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:17:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2712460B6E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:17:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2712460B6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZqDci7LhWpYB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:17:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFD3C60B65
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 07:17:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFD3C60B65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690183037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjKbZ93PktxP4rjIVyTtsb1Z6x60YFfrU4kZWAJuRWQ=;
 b=OVe8BxiyKocjgMpAkQqFaOBEzhPmMwGfan6vlJ3nSdbUKVea6TWtKJib5NdGuuqgGmKXnK
 C/TZ1T5SVdrmg2R9HCpuX8tR41Z6VkdW5BjMlfS4ml5Zc+LTm0z9ni2MV4hLJGCw2bj3PZ
 YV4H2EnkLsXM/6JYNAWdi5DX8CnlpQs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Eh1ejk4kMamLJ18Dyl_8MA-1; Mon, 24 Jul 2023 03:17:16 -0400
X-MC-Unique: Eh1ejk4kMamLJ18Dyl_8MA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-317421b94a4so666594f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Jul 2023 00:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690183035; x=1690787835;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HjKbZ93PktxP4rjIVyTtsb1Z6x60YFfrU4kZWAJuRWQ=;
 b=IwmlGLTuLu4sLzXnek2RgcJiXJ3apH6LX/XQu6eGzMv+7ZgnQ2J8AgB1HZHeM2u0yA
 frSEL6kTVWtQGQHQNehlOKp59OVER8P6fl57/JgnfSpJrnb1qKrolFIe+4623bCYdZSc
 0s4Ar2AyknmiEb2bwtZeuhxgRb/V6yGxGXwHCSHRZKJQWejDQKUQ+uaXJw7F00cYPa8x
 VqsrXC8woyD9NVQ3/ERRWftgbhGqbnNl6fpkuR0oW6fs/qZGvwYmvFnjp6lAVdye5mdO
 j19CRN57qONh3XvCll53yifmwtBOu4sbo+ekKKcx6GVJ9Wpp0+0BoyhlZ2JaQc2ucZNQ
 6Nbw==
X-Gm-Message-State: ABy/qLba8dTCevns3TFpisBk9PolMKGI+DcSSdQW+WseCRYIGlEVIKXd
 iZTwybsFffAeYG/NAgEKR3/q+vU5AineDyE6flKLfqTj8TXqHvf9wZs7Y9pEKi8RB9vBwQUyEzd
 xLbVHhPaMCjH4pX9GC/A3vVet6K6JRQ1gn0rV7OWhng==
X-Received: by 2002:a5d:6ad2:0:b0:317:64f4:5536 with SMTP id
 u18-20020a5d6ad2000000b0031764f45536mr79468wrw.44.1690183035296; 
 Mon, 24 Jul 2023 00:17:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHbd/1kAabUvsg2xkTZwcpGYrD8C4U0G8EAYPMvn6hm0cUUOcAYyC6wdAJZ4CQRNW3exfCZA==
X-Received: by 2002:a5d:6ad2:0:b0:317:64f4:5536 with SMTP id
 u18-20020a5d6ad2000000b0031764f45536mr79454wrw.44.1690183034947; 
 Mon, 24 Jul 2023 00:17:14 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
 by smtp.gmail.com with ESMTPSA id
 o26-20020a5d58da000000b0030ae499da59sm11867982wrf.111.2023.07.24.00.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 00:17:14 -0700 (PDT)
Date: Mon, 24 Jul 2023 03:17:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230724025720-mutt-send-email-mst@kernel.org>
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
 <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDI6NTI6MDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBTYXQsIEp1bCAyMiwgMjAyMyBhdCA0OjE44oCvQU0gTWF4aW1lIENvcXVlbGluCj4g
PG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPgo+ID4KPiA+IE9uIDcv
MjEvMjMgMTc6MTAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gT24gRnJpLCBKdWwg
MjEsIDIwMjMgYXQgMDQ6NTg6MDRQTSArMDIwMCwgTWF4aW1lIENvcXVlbGluIHdyb3RlOgo+ID4g
Pj4KPiA+ID4+Cj4gPiA+PiBPbiA3LzIxLzIzIDE2OjQ1LCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+Pj4gT24gRnJpLCBKdWwgMjEsIDIwMjMgYXQgMDQ6Mzc6MDBQTSArMDIwMCwgTWF4
aW1lIENvcXVlbGluIHdyb3RlOgo+ID4gPj4+Pgo+ID4gPj4+Pgo+ID4gPj4+PiBPbiA3LzIwLzIz
IDIzOjAyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+Pj4+PiBPbiBUaHUsIEp1bCAy
MCwgMjAyMyBhdCAwMToyNjoyMFBNIC0wNzAwLCBTaGFubm9uIE5lbHNvbiB3cm90ZToKPiA+ID4+
Pj4+PiBPbiA3LzIwLzIzIDE6MzggQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Pj4+Pj4+Cj4g
PiA+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxv
b3AgZm9yIGEgYmV0dGVyCj4gPiA+Pj4+Pj4+IGNvLW9wZXJhdGlvbiB3aXRoIHRoZSBzY2hlZHVs
ZXIuIFRoaXMgYWxsb3dzIHRvIGdpdmUgQ1BVIGEgYnJlYXRoIHRvCj4gPiA+Pj4+Pj4+IHJ1biBv
dGhlciB0YXNrKHdvcmtxdWV1ZSkgaW5zdGVhZCBvZiBidXN5IGxvb3Bpbmcgd2hlbiBwcmVlbXB0
aW9uIGlzCj4gPiA+Pj4+Pj4+IG5vdCBhbGxvd2VkIG9uIGEgZGV2aWNlIHdob3NlIENWUSBtaWdo
dCBiZSBzbG93Lgo+ID4gPj4+Pj4+Pgo+ID4gPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPj4+Pj4+Cj4gPiA+Pj4+Pj4gVGhpcyBzdGls
bCBsZWF2ZXMgaHVuZyBwcm9jZXNzZXMsIGJ1dCBhdCBsZWFzdCBpdCBkb2Vzbid0IHBpbiB0aGUg
Q1BVIGFueQo+ID4gPj4+Pj4+IG1vcmUuICBUaGFua3MuCj4gPiA+Pj4+Pj4gUmV2aWV3ZWQtYnk6
IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29tPgo+ID4gPj4+Pj4+Cj4gPiA+
Pj4+Pgo+ID4gPj4+Pj4gSSdkIGxpa2UgdG8gc2VlIGEgZnVsbCBzb2x1dGlvbgo+ID4gPj4+Pj4g
MS0gYmxvY2sgdW50aWwgaW50ZXJydXB0Cj4gCj4gSSByZW1lbWJlciBpbiBwcmV2aW91cyB2ZXJz
aW9ucywgeW91IHdvcnJpZWQgYWJvdXQgdGhlIGV4dHJhIE1TSQo+IHZlY3Rvci4gKE1heWJlIEkg
d2FzIHdyb25nKS4KPiAKPiA+ID4+Pj4KPiA+ID4+Pj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBh
bHNvIGhhdmUgYSB0aW1lb3V0Pwo+ID4gPj4+PiBBbmQgd2hlbiB0aW1lb3V0IGV4cGlyZXMsIHNl
dCBGQUlMRUQgYml0IGluIGRldmljZSBzdGF0dXM/Cj4gPiA+Pj4KPiA+ID4+PiB2aXJ0aW8gc3Bl
YyBkb2VzIG5vdCBzZXQgYW55IGxpbWl0cyBvbiB0aGUgdGltaW5nIG9mIHZxCj4gPiA+Pj4gcHJv
Y2Vzc2luZy4KPiA+ID4+Cj4gPiA+PiBJbmRlZWQsIGJ1dCBJIHRob3VnaHQgdGhlIGRyaXZlciBj
b3VsZCBkZWNpZGUgaXQgaXMgdG9vIGxvbmcgZm9yIGl0Lgo+ID4gPj4KPiA+ID4+IFRoZSBpc3N1
ZSBpcyB3ZSBrZWVwIHdhaXRpbmcgd2l0aCBydG5sIGxvY2tlZCwgaXQgY2FuIHF1aWNrbHkgbWFr
ZSB0aGUKPiA+ID4+IHN5c3RlbSB1bnVzYWJsZS4KPiA+ID4KPiA+ID4gaWYgdGhpcyBpcyBhIHBy
b2JsZW0gd2Ugc2hvdWxkIGZpbmQgYSB3YXkgbm90IHRvIGtlZXAgcnRubAo+ID4gPiBsb2NrZWQg
aW5kZWZpbml0ZWx5Lgo+IAo+IEFueSBpZGVhcyBvbiB0aGlzIGRpcmVjdGlvbj8gU2ltcGx5IGRy
b3BwaW5nIHJ0bmwgZHVyaW5nIHRoZSBidXN5IGxvb3AKPiB3aWxsIHJlc3VsdCBpbiBhIGxvdCBv
ZiByYWNlcy4gVGhpcyBzZWVtcyB0byByZXF1aXJlIG5vbi10cml2aWFsCj4gY2hhbmdlcyBpbiB0
aGUgbmV0d29ya2luZyBjb3JlLgo+IAo+ID4KPiA+ICBGcm9tIHRoZSB0ZXN0cyBJIGhhdmUgZG9u
ZSwgSSB0aGluayBpdCBpcy4gV2l0aCBPVlMsIGEgcmVjb25maWd1cmF0aW9uCj4gPiBpcyBwZXJm
b3JtZWQgd2hlbiB0aGUgVkRVU0UgZGV2aWNlIGlzIGFkZGVkLCBhbmQgd2hlbiBhIE1MWDUgZGV2
aWNlIGlzCj4gPiBpbiB0aGUgc2FtZSBicmlkZ2UsIGl0IGVuZHMgdXAgZG9pbmcgYW4gaW9jdGwo
KSB0aGF0IHRyaWVzIHRvIHRha2UgdGhlCj4gPiBydG5sIGxvY2suIEluIHRoaXMgY29uZmlndXJh
dGlvbiwgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGtpbGwgT1ZTIGJlY2F1c2UKPiA+IGl0IGlzIHN0
dWNrIHRyeWluZyB0byBhY3F1aXJlIHJ0bmwgbG9jayBmb3IgbWx4NSB0aGF0IGlzIGhlbGQgYnkg
dmlydGlvLQo+ID4gbmV0Lgo+IAo+IFllYWgsIGJhc2ljYWxseSwgYW55IFJUTkwgdXNlcnMgd291
bGQgYmUgYmxvY2tlZCBmb3JldmVyLgo+IAo+IEFuZCB0aGUgaW5maW5pdGUgbG9vcCBoYXMgb3Ro
ZXIgc2lkZSBlZmZlY3RzIGxpa2UgaXQgYmxvY2tzIHRoZSBmcmVlemVyIHRvIHdvcmsuCj4gCj4g
VG8gc3VtbWFyaXplLCB0aGVyZSBhcmUgdGhyZWUgaXNzdWVzCj4gCj4gMSkgYnVzeSBwb2xsaW5n
Cj4gMikgYnJlYWtzIGZyZWV6ZXIKPiAzKSBob2xkIFJUTkwgZHVyaW5nIHRoZSBsb29wCj4gCj4g
U29sdmluZyAzIG1heSBoZWxwIHNvbWVob3cgZm9yIDIgZS5nIHNvbWUgcG0gcm91dGluZSBlLmcg
d2lyZWd1YXJkIG9yCj4gZXZlbiB2aXJ0bmV0X3Jlc3RvcmUoKSBpdHNlbGYgbWF5IHRyeSB0byBo
b2xkIHRoZSBsb2NrLgoKWWVwLiBTbyBteSBmZWVsaW5nIGN1cnJlbnRseSBpcywgdGhlIG9ubHkg
cmVhbCBmaXggaXMgdG8gYWN0dWFsbHkKcXVldWUgdXAgdGhlIHdvcmsgaW4gc29mdHdhcmUuIEl0
J3MgbW9zdGx5IHRyaXZpYWwgdG8gbGltaXQKbWVtb3J5IGNvbnN1bXB0aW9uLCB2aWQncyBpcyB0
aGUKb25seSBvbmUgd2hlcmUgaXQgd291bGQgbWFrZSBzZW5zZSB0byBoYXZlIG1vcmUgdGhhbgox
IGNvbW1hbmQgb2YgYSBnaXZlbiB0eXBlIG91dHN0YW5kaW5nLiBoYXZlIGEgdHJlZQpvciBhIGJp
dG1hcCB3aXRoIHZpZHMgdG8gYWRkL3JlbW92ZT8KCgoKPiA+Cj4gPiA+Cj4gPiA+Pj4+PiAyLSBz
dGlsbCBoYW5kbGUgc3VycHJpc2UgcmVtb3ZhbCBjb3JyZWN0bHkgYnkgd2FraW5nIGluIHRoYXQg
Y2FzZQo+IAo+IFRoaXMgaXMgYmFzaWNhbGx5IHdoYXQgdmVyc2lvbiAxIGRpZD8KPiAKPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzYwMjZlODAxLTZmZGEtZmVlOS1hNjliLWQwNmE4MDM2
ODYyMUByZWRoYXQuY29tL3QvCj4gCj4gVGhhbmtzCgpZZXMgLSBleGNlcHQgdGhlIHRpbWVvdXQg
cGFydC4KCgo+ID4gPj4+Pj4KPiA+ID4+Pj4+Cj4gPiA+Pj4+Pgo+ID4gPj4+Pj4+PiAtLS0KPiA+
ID4+Pj4+Pj4gICAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA0ICsrKy0KPiA+ID4+Pj4+
Pj4gICAgICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4g
PiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4+Pj4+Pj4gaW5kZXggOWYzYjFkNmFj
MzNkLi5lNzUzM2YyOWIyMTkgMTAwNjQ0Cj4gPiA+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ID4gPj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+
ID4+Pj4+Pj4gQEAgLTIzMTQsOCArMjMxNCwxMCBAQCBzdGF0aWMgYm9vbCB2aXJ0bmV0X3NlbmRf
Y29tbWFuZChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwgdTggY2xhc3MsIHU4IGNtZCwKPiA+ID4+
Pj4+Pj4gICAgICAgICAgICAgICogaW50byB0aGUgaHlwZXJ2aXNvciwgc28gdGhlIHJlcXVlc3Qg
c2hvdWxkIGJlIGhhbmRsZWQgaW1tZWRpYXRlbHkuCj4gPiA+Pj4+Pj4+ICAgICAgICAgICAgICAq
Lwo+ID4gPj4+Pj4+PiAgICAgICAgICAgICB3aGlsZSAoIXZpcnRxdWV1ZV9nZXRfYnVmKHZpLT5j
dnEsICZ0bXApICYmCj4gPiA+Pj4+Pj4+IC0gICAgICAgICAgICAgICF2aXJ0cXVldWVfaXNfYnJv
a2VuKHZpLT5jdnEpKQo+ID4gPj4+Pj4+PiArICAgICAgICAgICAgICAhdmlydHF1ZXVlX2lzX2Jy
b2tlbih2aS0+Y3ZxKSkgewo+ID4gPj4+Pj4+PiArICAgICAgICAgICAgICAgY29uZF9yZXNjaGVk
KCk7Cj4gPiA+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgY3B1X3JlbGF4KCk7Cj4gPiA+Pj4+
Pj4+ICsgICAgICAgfQo+ID4gPj4+Pj4+Pgo+ID4gPj4+Pj4+PiAgICAgICAgICAgICByZXR1cm4g
dmktPmN0cmwtPnN0YXR1cyA9PSBWSVJUSU9fTkVUX09LOwo+ID4gPj4+Pj4+PiAgICAgIH0KPiA+
ID4+Pj4+Pj4gLS0KPiA+ID4+Pj4+Pj4gMi4zOS4zCj4gPiA+Pj4+Pj4+Cj4gPiA+Pj4+Pj4+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiA+Pj4+Pj4+
IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+ID4gPj4+Pj4+PiBWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4gPj4+Pj4+PiBodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbgo+ID4gPj4+Pj4K
PiA+ID4+Pgo+ID4gPgo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

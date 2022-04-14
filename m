Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31EBC433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 09:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77C554187D;
	Thu, 14 Apr 2022 09:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CR7qdwEdkmrB; Thu, 14 Apr 2022 09:19:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9DDC541852;
	Thu, 14 Apr 2022 09:19:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80203C002F;
	Thu, 14 Apr 2022 09:19:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF63AC002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE61C8142B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bI0T0EwK_chC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:19:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0ED5081438
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649927939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJfqPahZeiTk1PNwWhxutR1fdSWZNJKRpTJ6ssfKLRw=;
 b=eMTMEK1K9wtXWf0jem7/J157hOf+hi+yawDi36RA1/16y5fKPyBz8g1jFc8o//AIMaMr1+
 yB/h84oQbPvyWjg7TNU4NKbV0EqXOOkFbFpIHHzlFcERRbiGm5tWTWfgRg7b2ul6NsEzh2
 MymVt7RQNdJ2sFFX6hWJqkDT5F1Tcm0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-iIkhIcWVN1SGaVhR0Phr0w-1; Thu, 14 Apr 2022 05:18:57 -0400
X-MC-Unique: iIkhIcWVN1SGaVhR0Phr0w-1
Received: by mail-lf1-f69.google.com with SMTP id
 bp19-20020a056512159300b0046bac0601a3so2078719lfb.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 02:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sJfqPahZeiTk1PNwWhxutR1fdSWZNJKRpTJ6ssfKLRw=;
 b=k8KqqyJug1POaHy+F13VsejW7lvgiwGwLrcEhFsbffW2040as4pB6odj5J4QyHlNQ6
 0PvkR4MVCUcfadm9muknS4XNVn83FHw5GdNAUMkcoynsPBi36oAnTAv6dYyU7dbJ9MIG
 03fEMGcobBkws6XNXFYka8ZpizeiYvLbjpglHP9wVyq+hGgR8x2grpu6Mq3mrM0nluLe
 Mky7cyxYw0nSYGZihIF9GpPfxMDD/tJwaiHkXahnPDfwsRJV22bJuZgTaZJnLyoPoSMf
 v+eZZ6NQCMhZdObe2LshLp4pW6JuVCGnSpv2ofPVBZq6i0yTXTnSjlY17/+fTSzQKAsW
 NHxA==
X-Gm-Message-State: AOAM532T6Mjh/50ymGNZ9f89ApIqfWGwBKUTKOh4EVYVRPeLg3QmwSYR
 8i34EynCXmXy0ZwqPdV2pWluhLN+x9fp360d8gEXX3g0nyiqtlJFxIlLDYYgsmfbdLjSGSByGmf
 0bkDhKbtwsnrU4eDkpYHwmra5kOguCPjsgWUudGB/cXQseiDTowAxv0q8zA==
X-Received: by 2002:a2e:9d06:0:b0:24c:7dee:4d58 with SMTP id
 t6-20020a2e9d06000000b0024c7dee4d58mr1094333lji.177.1649927936387; 
 Thu, 14 Apr 2022 02:18:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKBYYLPyYh4rIV0O9pHFa2HW5c1lmiy1wx80UMeUS3XhqO2fkzHNVGe3v4nkVgcVO7Mvlc9uQ1U+LXwGtF0zk=
X-Received: by 2002:a2e:9d06:0:b0:24c:7dee:4d58 with SMTP id
 t6-20020a2e9d06000000b0024c7dee4d58mr1094324lji.177.1649927936181; Thu, 14
 Apr 2022 02:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
 <4da7b8dc-74ca-fc1b-fbdb-21f9943e8d45@redhat.com>
 <1649820210.3432868-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1649820210.3432868-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 14 Apr 2022 17:18:45 +0800
Message-ID: <CACGkMEv2qHLLqtc1uwObZFdRhaCNRMyTQ5qnvF02Yj8cKgV-8g@mail.gmail.com>
Subject: Re: [PATCH v9 12/32] virtio_ring: packed: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm <kvm@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCBBcHIgMTMsIDIwMjIgYXQgMTE6MjYgQU0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBPbiBUdWUsIDEyIEFwciAyMDIyIDE0OjI4OjI0ICsw
ODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiDlnKgg
MjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IFNlcGFyYXRlIHRo
ZSBsb2dpYyBvZiBwYWNrZWQgdG8gY3JlYXRlIHZyaW5nIHF1ZXVlLgo+ID4gPgo+ID4gPiBGb3Ig
dGhlIGNvbnZlbmllbmNlIG9mIHBhc3NpbmcgcGFyYW1ldGVycywgYWRkIGEgc3RydWN0dXJlCj4g
PiA+IHZyaW5nX3BhY2tlZC4KPiA+ID4KPiA+ID4gVGhpcyBmZWF0dXJlIGlzIHJlcXVpcmVkIGZv
ciBzdWJzZXF1ZW50IHZpcnR1cXVldWUgcmVzZXQgdnJpbmcuCj4gPiA+Cj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+
ID4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCA3MCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNTYgaW5zZXJ0aW9u
cygrKSwgMTQgZGVsZXRpb25zKC0pCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiBp
bmRleCAzMzg2NDEzNGE3NDQuLmVhNDUxYWUyYWFlZiAxMDA2NDQKPiA+ID4gLS0tIGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gPiA+IEBAIC0xODE3LDE5ICsxODE3LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgdnJpbmdf
ZGVzY19leHRyYSAqdnJpbmdfYWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKQo+ID4g
PiAgICAgcmV0dXJuIGRlc2NfZXh0cmE7Cj4gPiA+ICAgfQo+ID4gPgo+ID4gPiAtc3RhdGljIHN0
cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKAo+ID4gPiAtICAg
dW5zaWduZWQgaW50IGluZGV4LAo+ID4gPiAtICAgdW5zaWduZWQgaW50IG51bSwKPiA+ID4gLSAg
IHVuc2lnbmVkIGludCB2cmluZ19hbGlnbiwKPiA+ID4gLSAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LAo+ID4gPiAtICAgYm9vbCB3ZWFrX2JhcnJpZXJzLAo+ID4gPiAtICAgYm9vbCBtYXlf
cmVkdWNlX251bSwKPiA+ID4gLSAgIGJvb2wgY29udGV4dCwKPiA+ID4gLSAgIGJvb2wgKCpub3Rp
ZnkpKHN0cnVjdCB2aXJ0cXVldWUgKiksCj4gPiA+IC0gICB2b2lkICgqY2FsbGJhY2spKHN0cnVj
dCB2aXJ0cXVldWUgKiksCj4gPiA+IC0gICBjb25zdCBjaGFyICpuYW1lKQo+ID4gPiArc3RhdGlj
IGludCB2cmluZ19hbGxvY19xdWV1ZV9wYWNrZWQoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYs
Cj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyIG51bSwKPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKipf
cmluZywKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdnJpbmdf
cGFja2VkX2Rlc2NfZXZlbnQgKipfZHJpdmVyLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCB2cmluZ19wYWNrZWRfZGVzY19ldmVudCAqKl9kZXZpY2UsCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCAqX3JpbmdfZG1hX2Fk
ZHIsCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCAqX2Ry
aXZlcl9ldmVudF9kbWFfYWRkciwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkbWFfYWRkcl90ICpfZGV2aWNlX2V2ZW50X2RtYV9hZGRyLAo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHNpemVfdCAqX3Jpbmdfc2l6ZV9pbl9ieXRlcywKPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgKl9ldmVudF9zaXplX2luX2J5dGVz
KQo+ID4gPiAgIHsKPiA+ID4gLSAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxOwo+ID4gPiAg
ICAgc3RydWN0IHZyaW5nX3BhY2tlZF9kZXNjICpyaW5nOwo+ID4gPiAgICAgc3RydWN0IHZyaW5n
X3BhY2tlZF9kZXNjX2V2ZW50ICpkcml2ZXIsICpkZXZpY2U7Cj4gPiA+ICAgICBkbWFfYWRkcl90
IHJpbmdfZG1hX2FkZHIsIGRyaXZlcl9ldmVudF9kbWFfYWRkciwgZGV2aWNlX2V2ZW50X2RtYV9h
ZGRyOwo+ID4gPiBAQCAtMTg1Nyw2ICsxODU1LDUyIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVl
ICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiA+ID4gICAgIGlmICghZGV2aWNlKQo+
ID4gPiAgICAgICAgICAgICBnb3RvIGVycl9kZXZpY2U7Cj4gPiA+Cj4gPiA+ICsgICAqX3Jpbmcg
ICAgICAgICAgICAgICAgICAgPSByaW5nOwo+ID4gPiArICAgKl9kcml2ZXIgICAgICAgICAgICAg
ICAgID0gZHJpdmVyOwo+ID4gPiArICAgKl9kZXZpY2UgICAgICAgICAgICAgICAgID0gZGV2aWNl
Owo+ID4gPiArICAgKl9yaW5nX2RtYV9hZGRyICAgICAgICAgID0gcmluZ19kbWFfYWRkcjsKPiA+
ID4gKyAgICpfZHJpdmVyX2V2ZW50X2RtYV9hZGRyICA9IGRyaXZlcl9ldmVudF9kbWFfYWRkcjsK
PiA+ID4gKyAgICpfZGV2aWNlX2V2ZW50X2RtYV9hZGRyICA9IGRldmljZV9ldmVudF9kbWFfYWRk
cjsKPiA+ID4gKyAgICpfcmluZ19zaXplX2luX2J5dGVzICAgICA9IHJpbmdfc2l6ZV9pbl9ieXRl
czsKPiA+ID4gKyAgICpfZXZlbnRfc2l6ZV9pbl9ieXRlcyAgICA9IGV2ZW50X3NpemVfaW5fYnl0
ZXM7Cj4gPgo+ID4KPiA+IEkgd29uZGVyIGlmIHdlIGNhbiBzaW1wbHkgZmFjdG9yIG91dCBzcGxp
dCBhbmQgcGFja2VkIGZyb20gc3RydWN0Cj4gPiB2cmluZ192aXJ0cXVldWU6Cj4gPgo+ID4gc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSB7Cj4gPiAgICAgIHVuaW9uIHsKPiA+ICAgICAgICAgIHN0cnVj
dCB7fSBzcGxpdDsKPiA+ICAgICAgICAgIHN0cnVjdCB7fSBwYWNrZWQ7Cj4gPiAgICAgIH07Cj4g
PiB9Owo+ID4KPiA+IHRvCj4gPgo+ID4gc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxpdCB7fTsK
PiA+IHN0cnVjdCB2cmluZ192aXJ0cXVldWVfcGFja2VkIHt9Owo+ID4KPiA+IFRoZW4gd2UgY2Fu
IGRvIHRoaW5ncyBsaWtlOgo+ID4KPiA+IHZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfcGFja2VkKHN0
cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LCB1MzIgbnVtLAo+ID4gc3RydWN0IHZyaW5nX3ZpcnRx
dWV1ZV9wYWNrZWQgKnBhY2tlZCk7Cj4gPgo+ID4gYW5kCj4gPgo+ID4gdnJpbmdfdnJpdHF1ZXVl
X2F0dGFjaF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsIHN0cnVjdAo+ID4gdnJp
bmdfdmlydHF1ZXVlX3BhY2tlZCBwYWNrZWQpOwo+Cj4gVGhpcyBpZGVhIGlzIHZlcnkgc2ltaWxh
ciB0byBteSBwcmV2aW91cyBpZGVhLCBqdXN0IHdpdGhvdXQgaW50cm9kdWNpbmcgYSBuZXcKPiBz
dHJ1Y3R1cmUuCgpZZXMsIGl0J3MgYmV0dGVyIHRvIG5vdCBpbnRyb2R1Y2UgbmV3IHN0cnVjdHVy
ZXMgaWYgaXQncyBwb3NzaWJsZS4KCj4KPiBJJ2QgYmUgbW9yZSB0aGFuIGhhcHB5IHRvIHJldmlz
ZSB0aGlzLgoKR29vZCB0byBrbm93IHRoaXMuCgpUaGFua3MKCj4KPiBUaGFua3MuCj4KPgo+ID4K
PiA+IFRoYW5rcwo+ID4KPiA+Cj4gPiA+ICsKPiA+ID4gKyAgIHJldHVybiAwOwo+ID4gPiArCj4g
PiA+ICtlcnJfZGV2aWNlOgo+ID4gPiArICAgdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCBldmVudF9z
aXplX2luX2J5dGVzLCBkcml2ZXIsIGRyaXZlcl9ldmVudF9kbWFfYWRkcik7Cj4gPiA+ICsKPiA+
ID4gK2Vycl9kcml2ZXI6Cj4gPiA+ICsgICB2cmluZ19mcmVlX3F1ZXVlKHZkZXYsIHJpbmdfc2l6
ZV9pbl9ieXRlcywgcmluZywgcmluZ19kbWFfYWRkcik7Cj4gPiA+ICsKPiA+ID4gK2Vycl9yaW5n
Ogo+ID4gPiArICAgcmV0dXJuIC1FTk9NRU07Cj4gPiA+ICt9Cj4gPiA+ICsKPiA+ID4gK3N0YXRp
YyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlX3BhY2tlZCgKPiA+ID4g
KyAgIHVuc2lnbmVkIGludCBpbmRleCwKPiA+ID4gKyAgIHVuc2lnbmVkIGludCBudW0sCj4gPiA+
ICsgICB1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gPiA+ICsgICBzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldiwKPiA+ID4gKyAgIGJvb2wgd2Vha19iYXJyaWVycywKPiA+ID4gKyAgIGJvb2wg
bWF5X3JlZHVjZV9udW0sCj4gPiA+ICsgICBib29sIGNvbnRleHQsCj4gPiA+ICsgICBib29sICgq
bm90aWZ5KShzdHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gPiArICAgdm9pZCAoKmNhbGxiYWNrKShz
dHJ1Y3QgdmlydHF1ZXVlICopLAo+ID4gPiArICAgY29uc3QgY2hhciAqbmFtZSkKPiA+ID4gK3sK
PiA+ID4gKyAgIGRtYV9hZGRyX3QgcmluZ19kbWFfYWRkciwgZHJpdmVyX2V2ZW50X2RtYV9hZGRy
LCBkZXZpY2VfZXZlbnRfZG1hX2FkZHI7Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rl
c2NfZXZlbnQgKmRyaXZlciwgKmRldmljZTsKPiA+ID4gKyAgIHNpemVfdCByaW5nX3NpemVfaW5f
Ynl0ZXMsIGV2ZW50X3NpemVfaW5fYnl0ZXM7Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfcGFja2Vk
X2Rlc2MgKnJpbmc7Cj4gPiA+ICsgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsKPiA+ID4g
Kwo+ID4gPiArICAgaWYgKHZyaW5nX2FsbG9jX3F1ZXVlX3BhY2tlZCh2ZGV2LCBudW0sICZyaW5n
LCAmZHJpdmVyLCAmZGV2aWNlLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAmcmluZ19kbWFfYWRkciwgJmRyaXZlcl9ldmVudF9kbWFfYWRkciwKPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmRldmljZV9ldmVudF9kbWFfYWRkciwKPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJnJpbmdfc2l6ZV9pbl9ieXRlcywKPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmV2ZW50X3NpemVfaW5fYnl0ZXMpKQo+
ID4gPiArICAgICAgICAgICBnb3RvIGVycl9yaW5nOwo+ID4gPiArCj4gPiA+ICAgICB2cSA9IGtt
YWxsb2Moc2l6ZW9mKCp2cSksIEdGUF9LRVJORUwpOwo+ID4gPiAgICAgaWYgKCF2cSkKPiA+ID4g
ICAgICAgICAgICAgZ290byBlcnJfdnE7Cj4gPiA+IEBAIC0xOTM5LDkgKzE5ODMsNyBAQCBzdGF0
aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1ZV9wYWNrZWQoCj4gPiA+
ICAgICBrZnJlZSh2cSk7Cj4gPiA+ICAgZXJyX3ZxOgo+ID4gPiAgICAgdnJpbmdfZnJlZV9xdWV1
ZSh2ZGV2LCBldmVudF9zaXplX2luX2J5dGVzLCBkZXZpY2UsIGRldmljZV9ldmVudF9kbWFfYWRk
cik7Cj4gPiA+IC1lcnJfZGV2aWNlOgo+ID4gPiAgICAgdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCBl
dmVudF9zaXplX2luX2J5dGVzLCBkcml2ZXIsIGRyaXZlcl9ldmVudF9kbWFfYWRkcik7Cj4gPiA+
IC1lcnJfZHJpdmVyOgo+ID4gPiAgICAgdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCByaW5nX3NpemVf
aW5fYnl0ZXMsIHJpbmcsIHJpbmdfZG1hX2FkZHIpOwo+ID4gPiAgIGVycl9yaW5nOgo+ID4gPiAg
ICAgcmV0dXJuIE5VTEw7Cj4gPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

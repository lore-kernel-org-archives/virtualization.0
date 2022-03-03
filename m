Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1335C433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 03:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D385408E3;
	Thu,  3 Mar 2022 03:59:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGNeVGuvoZNk; Thu,  3 Mar 2022 03:59:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28497400FE;
	Thu,  3 Mar 2022 03:59:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA7F6C0082;
	Thu,  3 Mar 2022 03:59:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6879AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 03:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49B7D40156
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 03:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NqfAxPTjhSec
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 03:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C61C400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646279961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLyYEFbzKazGajr/Z7eLhFc2iDs9PD4fdRAFMZ5Qomk=;
 b=Xo6PY89Xap6AfFQ2FRhWBcsxBlF9R/3gwYuVBP8FX9aeBV2jbKiMy5IQM363sOdr8y7719
 HD6NwEO77xHRf5j4fSEcxgh4OmfCsqKXIf/aUPodKIIenfoCuomJDrLjDd6AErdz6/PhTU
 /7ER9uadbB/BbsI3W+HmkOp2AU+I+AY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-ar50ZhhTOoik6lPQyXiUdQ-1; Wed, 02 Mar 2022 22:59:20 -0500
X-MC-Unique: ar50ZhhTOoik6lPQyXiUdQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 z10-20020a170902708a00b0014fc3888923so2129766plk.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 19:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=JLyYEFbzKazGajr/Z7eLhFc2iDs9PD4fdRAFMZ5Qomk=;
 b=tbPxKgWKqJIVoq21xcxrrY+VYb6XRICuT+PyNE/ACknMapZ0bVZaah2hX0gdkOmcZr
 Suoq3CFfdlYFltP8hBBTZgGNuR53UlMR1t6NPd5Tv3ai1HtZhY4tJKdNgAWjX7y1ILvP
 unz57EYc7JR3+QGj5HI1wRXWd4cxq07u5UoTAqcEfabSKfaZFXFGxtTpmuXPrPAp0FMT
 0VDToRNwaR7y0iYclbiKYc3JVUCoPz1Ua6pF5PQ/nI+oYTiwLWs+3dmGOGMuwNq1VZ12
 Y7y1RdI1Iq3Xvll1cz1BSyf9wgXaGArtkZXVpb11Cuvd7cMuoPyyVjPOCjYoWvKJvoS7
 Xwsg==
X-Gm-Message-State: AOAM532qukGScsH33/HyCY+oMELW+S6BVTlWlJNLhCpdfnIY+lwifSUE
 xbXp2swD9pKEe9kpiOjcPZVA/sNycQWb+LTjztCCNut9NXGYcKgtKWNGAsRwoVSpGbppbgP5ecV
 eYsahx4flitoOpbmEQw5IzgsdMC5y/EGk8924uuDK7A==
X-Received: by 2002:a05:6a00:188f:b0:4e1:a253:850c with SMTP id
 x15-20020a056a00188f00b004e1a253850cmr36329984pfh.61.1646279959036; 
 Wed, 02 Mar 2022 19:59:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZQZtiyN/+eVQIh36yLquJvhShQxa3L1DH/1+/nasdtDZX5ozJfyYacmVoMm56LpbVlK/3mQ==
X-Received: by 2002:a05:6a00:188f:b0:4e1:a253:850c with SMTP id
 x15-20020a056a00188f00b004e1a253850cmr36329956pfh.61.1646279958700; 
 Wed, 02 Mar 2022 19:59:18 -0800 (PST)
Received: from [10.72.13.250] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a056a00124b00b004e11307f8cdsm662501pfi.86.2022.03.02.19.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 19:59:18 -0800 (PST)
Message-ID: <276dfdf4-2ee5-b054-4e34-c5c32b99d6d7@redhat.com>
Date: Thu, 3 Mar 2022 11:59:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH net-next] tuntap: add sanity checks about msg_controllen
 in sendmsg
To: Harold Huang <baymaxhuang@gmail.com>, netdev@vger.kernel.org
References: <20220301064314.2028737-1-baymaxhuang@gmail.com>
 <20220303022441.383865-1-baymaxhuang@gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220303022441.383865-1-baymaxhuang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Eric Dumazet <eric.dumazet@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, edumazet@google.com,
 "open list:VIRTIO HOST \(VHOST\)" <kvm@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "open list:VIRTIO HOST \(VHOST\)" <virtualization@lists.linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>
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

CuWcqCAyMDIyLzMvMyDkuIrljYgxMDoyNCwgSGFyb2xkIEh1YW5nIOWGmemBkzoKPiBJbiBwYXRj
aCBbMV0sIHR1bl9tc2dfY3RsIHdhcyBhZGRlZCB0byBhbGxvdyBwYXNzIGJhdGNoZWQgeGRwIGJ1
ZmZlcnMgdG8KPiB0dW5fc2VuZG1zZy4gQWx0aG91Z2ggd2UgZG9ub3QgdXNlIG1zZ19jb250cm9s
bGVuIGluIHRoaXMgcGF0aCwgd2Ugc2hvdWxkCj4gY2hlY2sgbXNnX2NvbnRyb2xsZW4gdG8gbWFr
ZSBzdXJlIHRoZSBjYWxsZXIgcGFzcyBhIHZhbGlkIG1zZ19jdGwuCj4KPiBbMV06IGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4Lmdp
dC9jb21taXQvP2lkPWZlOGRkNDViYjc1NTYyNDZjNmI3NjI3N2IxYmE0Mjk2YzkxYzI1MDUKPgo+
IFJlcG9ydGVkLWJ5OiBFcmljIER1bWF6ZXQgPGVyaWMuZHVtYXpldEBnbWFpbC5jb20+Cj4gU3Vn
Z2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEhhcm9sZCBIdWFuZyA8YmF5bWF4aHVhbmdAZ21haWwuY29tPgoKCkFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL25ldC90YXAu
YyAgIHwgMyArKy0KPiAgIGRyaXZlcnMvbmV0L3R1bi5jICAgfCAzICsrLQo+ICAgZHJpdmVycy92
aG9zdC9uZXQuYyB8IDEgKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdGFwLmMgYi9kcml2ZXJz
L25ldC90YXAuYwo+IGluZGV4IDhlM2EyOGJhNmIyOC4uYmEyZWY1NDM3ZTE2IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3RhcC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdGFwLmMKPiBAQCAtMTE5
OCw3ICsxMTk4LDggQEAgc3RhdGljIGludCB0YXBfc2VuZG1zZyhzdHJ1Y3Qgc29ja2V0ICpzb2Nr
LCBzdHJ1Y3QgbXNnaGRyICptLAo+ICAgCXN0cnVjdCB4ZHBfYnVmZiAqeGRwOwo+ICAgCWludCBp
Owo+ICAgCj4gLQlpZiAoY3RsICYmIChjdGwtPnR5cGUgPT0gVFVOX01TR19QVFIpKSB7Cj4gKwlp
ZiAobS0+bXNnX2NvbnRyb2xsZW4gPT0gc2l6ZW9mKHN0cnVjdCB0dW5fbXNnX2N0bCkgJiYKPiAr
CSAgICBjdGwgJiYgY3RsLT50eXBlID09IFRVTl9NU0dfUFRSKSB7Cj4gICAJCWZvciAoaSA9IDA7
IGkgPCBjdGwtPm51bTsgaSsrKSB7Cj4gICAJCQl4ZHAgPSAmKChzdHJ1Y3QgeGRwX2J1ZmYgKilj
dGwtPnB0cilbaV07Cj4gICAJCQl0YXBfZ2V0X3VzZXJfeGRwKHEsIHhkcCk7Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3R1bi5jIGIvZHJpdmVycy9uZXQvdHVuLmMKPiBpbmRleCA5NjllYTY5
ZmQyOWQuLjJhMGQ4YTVkN2FlYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC90dW4uYwo+ICsr
KyBiL2RyaXZlcnMvbmV0L3R1bi5jCj4gQEAgLTI1MDEsNyArMjUwMSw4IEBAIHN0YXRpYyBpbnQg
dHVuX3NlbmRtc2coc3RydWN0IHNvY2tldCAqc29jaywgc3RydWN0IG1zZ2hkciAqbSwgc2l6ZV90
IHRvdGFsX2xlbikKPiAgIAlpZiAoIXR1bikKPiAgIAkJcmV0dXJuIC1FQkFERkQ7Cj4gICAKPiAt
CWlmIChjdGwgJiYgKGN0bC0+dHlwZSA9PSBUVU5fTVNHX1BUUikpIHsKPiArCWlmIChtLT5tc2df
Y29udHJvbGxlbiA9PSBzaXplb2Yoc3RydWN0IHR1bl9tc2dfY3RsKSAmJgo+ICsJICAgIGN0bCAm
JiBjdGwtPnR5cGUgPT0gVFVOX01TR19QVFIpIHsKPiAgIAkJc3RydWN0IHR1bl9wYWdlIHRwYWdl
Owo+ICAgCQlpbnQgbiA9IGN0bC0+bnVtOwo+ICAgCQlpbnQgZmx1c2ggPSAwLCBxdWV1ZWQgPSAw
Owo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L25ldC5jIGIvZHJpdmVycy92aG9zdC9uZXQu
Ywo+IGluZGV4IDI4ZWYzMjM4ODJmYi4uNzkyYWI1ZjIzNjQ3IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvbmV0LmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L25ldC5jCj4gQEAgLTQ3Myw2ICs0
NzMsNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF90eF9iYXRjaChzdHJ1Y3Qgdmhvc3RfbmV0ICpuZXQs
Cj4gICAJCWdvdG8gc2lnbmFsX3VzZWQ7Cj4gICAKPiAgIAltc2doZHItPm1zZ19jb250cm9sID0g
JmN0bDsKPiArCW1zZ2hkci0+bXNnX2NvbnRyb2xsZW4gPSBzaXplb2YoY3RsKTsKPiAgIAllcnIg
PSBzb2NrLT5vcHMtPnNlbmRtc2coc29jaywgbXNnaGRyLCAwKTsKPiAgIAlpZiAodW5saWtlbHko
ZXJyIDwgMCkpIHsKPiAgIAkJdnFfZXJyKCZudnEtPnZxLCAiRmFpbCB0byBiYXRjaCBzZW5kaW5n
IHBhY2tldHNcbiIpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE751C433EF
	for <virtualization@archiver.kernel.org>; Thu, 21 Jul 2022 09:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63DA78477F;
	Thu, 21 Jul 2022 09:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63DA78477F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ht9iHBb7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GT0Jl5gUk990; Thu, 21 Jul 2022 09:14:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 016788476E;
	Thu, 21 Jul 2022 09:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 016788476E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF0E1C0033;
	Thu, 21 Jul 2022 09:14:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BC0FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63841422DF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 63841422DF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ht9iHBb7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YJ5pSEm1V5Rl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FF02422DD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FF02422DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 09:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658394884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qsc4liwturFJYHAITq0jfAcGv5JnVY7R1RVgysjsWkI=;
 b=ht9iHBb7wDvinRuLOPw2KXXXxh1SIXRRqM2B7PFqaXNzr1c5fRrm04TN4CcHZYWBlIpXTe
 DTEykRgzTAXN6AIo0oQZ/tnH6hzvEE4veg0ATXLoqeEJ3OSTx32xskeYa6V95Fd3H0Cw51
 d0qm8zB5x24eUFXubt0PkMvF/of06a8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-ZFPx57WpP_GEnxPszVKM9w-1; Thu, 21 Jul 2022 05:14:43 -0400
X-MC-Unique: ZFPx57WpP_GEnxPszVKM9w-1
Received: by mail-pg1-f198.google.com with SMTP id
 a24-20020a63e418000000b0041a20e8c1d3so680834pgi.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Jul 2022 02:14:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Qsc4liwturFJYHAITq0jfAcGv5JnVY7R1RVgysjsWkI=;
 b=t9HvtBV8nWJ+iGaDzKgjKX6L3If12HyqQf7n4Z31gfVPSR4JiO6jhTe2JOBN7PHZQP
 pMoj1GXzPwyo/emRXQcnzGurfoegEf1Ry+9c+X+sfBj/odUN4b571lSpAu7deS4TVGr1
 imsg8dWlkepxK3LAYqAGg8OP2NH585V7bB6uRaM/DhioVCG13txkNUE82po2yzPprrdq
 ciqov1UWqY+1ECwiPlAyMt/aqO1PyUtC5T9at6GhXUejocSBZGDOII7SdFPuV6+YngYs
 Uh1jnfkHG4pEQYqyfYmmGTkHCcdVlR++ghxnA/sxBLantRxbImReNtxfY1QRbcBFGBFq
 vHSQ==
X-Gm-Message-State: AJIora9QnxxUbcZvwKHssqQA0mBsgOR4XF9HCqsEHpLt/njaMIgC2I+v
 PZkx9oexu/D74wX3CoMXzWuQP6MfeSpE4xCx1Z57hwOamSyaOeeZJt8RHdocYfqWwrhKS8afgYM
 I03Cudz9jH23Nb9ATHlI3fFA45zTKk/cB5oqpTr5Hyw==
X-Received: by 2002:a17:902:f54e:b0:16c:5119:d4a8 with SMTP id
 h14-20020a170902f54e00b0016c5119d4a8mr41391774plf.22.1658394881757; 
 Thu, 21 Jul 2022 02:14:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vZasibIAHQ47D1+cg3lbZlHNL9q45E+5hv7aYoBqQJppes7C+ekD1lr5quAazlbWW4qs7GdA==
X-Received: by 2002:a17:902:f54e:b0:16c:5119:d4a8 with SMTP id
 h14-20020a170902f54e00b0016c5119d4a8mr41391753plf.22.1658394881472; 
 Thu, 21 Jul 2022 02:14:41 -0700 (PDT)
Received: from [10.72.12.47] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a170902a38800b0016bebb0cb96sm1114154pla.266.2022.07.21.02.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jul 2022 02:14:40 -0700 (PDT)
Message-ID: <e760bce5-2ead-8be4-6a86-0f453b30dcc3@redhat.com>
Date: Thu, 21 Jul 2022 17:14:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v12 26/40] virtio_ring: struct virtqueue introduce reset
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
 <20220720030436.79520-27-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220720030436.79520-27-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzcvMjAgMTE6MDQsIFh1YW4gWmh1byDlhpnpgZM6Cj4gSW50cm9kdWNlIGEgbmV3
IG1lbWJlciByZXNldCB0byB0aGUgc3RydWN0dXJlIHZpcnRxdWV1ZSB0byBkZXRlcm1pbmUKPiB3
aGV0aGVyIHRoZSBjdXJyZW50IHZxIGlzIGluIHRoZSByZXNldCBzdGF0ZS4gU3Vic2VxdWVudCBw
YXRjaGVzIHdpbGwKPiB1c2UgaXQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMiAr
Kwo+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8IDIgKysKPiAgIDIgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBpbmRleCBiZjY2NmRh
ZDk5MDQuLjgyNzhiOTE3YWQ2NCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0yMDExLDYg
KzIwMTEsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRxdWV1
ZV9wYWNrZWQoCj4gICAJdnEtPnZxLnZkZXYgPSB2ZGV2Owo+ICAgCXZxLT52cS5uYW1lID0gbmFt
ZTsKPiAgIAl2cS0+dnEuaW5kZXggPSBpbmRleDsKPiArCXZxLT52cS5yZXNldCA9IGZhbHNlOwo+
ICAgCXZxLT53ZV9vd25fcmluZyA9IHRydWU7Cj4gICAJdnEtPm5vdGlmeSA9IG5vdGlmeTsKPiAg
IAl2cS0+d2Vha19iYXJyaWVycyA9IHdlYWtfYmFycmllcnM7Cj4gQEAgLTI0OTAsNiArMjQ5MSw3
IEBAIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBpbnQg
aW5kZXgsCj4gICAJdnEtPnZxLnZkZXYgPSB2ZGV2Owo+ICAgCXZxLT52cS5uYW1lID0gbmFtZTsK
PiAgIAl2cS0+dnEuaW5kZXggPSBpbmRleDsKPiArCXZxLT52cS5yZXNldCA9IGZhbHNlOwo+ICAg
CXZxLT53ZV9vd25fcmluZyA9IGZhbHNlOwo+ICAgCXZxLT5ub3RpZnkgPSBub3RpZnk7Cj4gICAJ
dnEtPndlYWtfYmFycmllcnMgPSB3ZWFrX2JhcnJpZXJzOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGQ0NWVlODJh
NDQ3MC4uYTNmNzNiYjY3MzNlIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgK
PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTIwLDYgKzIwLDcgQEAKPiAgICAq
IEBpbmRleDogdGhlIHplcm8tYmFzZWQgb3JkaW5hbCBudW1iZXIgZm9yIHRoaXMgcXVldWUuCj4g
ICAgKiBAbnVtX2ZyZWU6IG51bWJlciBvZiBlbGVtZW50cyB3ZSBleHBlY3QgdG8gYmUgYWJsZSB0
byBmaXQuCj4gICAgKiBAbnVtX21heDogdGhlIG1heGltdW0gbnVtYmVyIG9mIGVsZW1lbnRzIHN1
cHBvcnRlZCBieSB0aGUgZGV2aWNlLgo+ICsgKiBAcmVzZXQ6IHZxIGlzIGluIHJlc2V0IHN0YXRl
IG9yIG5vdC4KPiAgICAqCj4gICAgKiBBIG5vdGUgb24gQG51bV9mcmVlOiB3aXRoIGluZGlyZWN0
IGJ1ZmZlcnMsIGVhY2ggYnVmZmVyIG5lZWRzIG9uZQo+ICAgICogZWxlbWVudCBpbiB0aGUgcXVl
dWUsIG90aGVyd2lzZSBhIGJ1ZmZlciB3aWxsIG5lZWQgb25lIGVsZW1lbnQgcGVyCj4gQEAgLTM0
LDYgKzM1LDcgQEAgc3RydWN0IHZpcnRxdWV1ZSB7Cj4gICAJdW5zaWduZWQgaW50IG51bV9mcmVl
Owo+ICAgCXVuc2lnbmVkIGludCBudW1fbWF4Owo+ICAgCXZvaWQgKnByaXY7Cj4gKwlib29sIHJl
c2V0Owo+ICAgfTsKPiAgIAo+ICAgaW50IHZpcnRxdWV1ZV9hZGRfb3V0YnVmKHN0cnVjdCB2aXJ0
cXVldWUgKnZxLAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

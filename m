Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC55CDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 06:51:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BDEE8478F;
	Fri, 20 Oct 2023 06:51:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BDEE8478F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3jXItfA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ymU9lLhv9o2; Fri, 20 Oct 2023 06:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 072C584786;
	Fri, 20 Oct 2023 06:51:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 072C584786
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF60DC0071;
	Fri, 20 Oct 2023 06:51:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5AC8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2112431E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:51:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2112431E7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3jXItfA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YgdTsoVi0v7s
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:51:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86F0740160
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 06:51:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 86F0740160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697784667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crwaKaePMEZqRzjOk6ARvGGv9aJDmk5zOwJBkKiIeIc=;
 b=D3jXItfAFM4Aa/xMHYhgGzbi+n69JvopkG5sFfd2i6BZHY1Nu+GW3V380RAZelVPCN/wo7
 0KNjkrMRISZcgZF6tQc+Rqsa6QIQSWzFdUI3IGTh4YNVrjbk/bSHfABMqnDu4p7HomqSOh
 H7AX69ImgZd7lU1oOcDeP3DKrdmRQ50=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-L9M-bfzfMgC4oNMG_qzKaQ-1; Fri, 20 Oct 2023 02:51:05 -0400
X-MC-Unique: L9M-bfzfMgC4oNMG_qzKaQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507ceeff451so436825e87.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 23:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697784664; x=1698389464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=crwaKaePMEZqRzjOk6ARvGGv9aJDmk5zOwJBkKiIeIc=;
 b=KIGU/YeOcMuzad1K1UGij/K/AW49N0t4yWB8emyG4TORJ8yMtvz3uWXwjdOH9U9ci1
 Q4JJG9ffCF9SQ/Dmx/yqLF3unEVjm2wz2g4hjUCTS7rit2DCiH3CWlxyZiYHYq4j2cEh
 pPDk8uk4uS0yd/nQ+FdiIstVyDUjgNLrDSLA0F31l5zdoMbO0yLw5b4XdydKHcGSugT2
 aut1+tm7b+J0P6OAPKo6+ZVoJirz/sBUHIxz9jN6qqGUrFeLLJbnRqeS/ywE67K6fiYM
 aJpxYEsvUF8y/8nRXZ9IF8grwCDEGtU1ZXT7hCh6TEU7i9oX2tP7+FYMX8BsIzznP5gR
 5b6w==
X-Gm-Message-State: AOJu0YwDJJOwIowXTEVq0SePH4bdy1RH3xCAHGQkQrSc7ybwvf1Usj+C
 yHRchufxj9BN+YcVvlsR130hcXKNV1DVBUKcnHeAXKu2BMLK8ECUbs4X74r+R4WhbxXBY9aDm2l
 gk9EDVXD6wEZrKhLvr83WEcdXJ8phnXNOkpKU5QOxboaUxVi1wvkiFej3IA==
X-Received: by 2002:a05:6512:3094:b0:500:9dd4:2969 with SMTP id
 z20-20020a056512309400b005009dd42969mr619364lfd.59.1697784664439; 
 Thu, 19 Oct 2023 23:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYQPJLf7vs3BLmZJ52qeoke4CdfBTo8vgI6dD81vASHojo8uRB5TjPI7cvhTZebQi6LtEdhmZ9zb7VvjcDQ/8=
X-Received: by 2002:a05:6512:3094:b0:500:9dd4:2969 with SMTP id
 z20-20020a056512309400b005009dd42969mr619342lfd.59.1697784663734; Thu, 19 Oct
 2023 23:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:50:52 +0800
Message-ID: <CACGkMEuq8i9_PX+vRESS3g2BpaWBv3FxDLMryG=aEJ+gAOsSaA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 08/19] virtio_net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gSWYgdGhlIHhzayBpcyBlbmFibGluZywgdGhlIHhz
ayB0eCB3aWxsIHNoYXJlIHRoZSBzZW5kIHF1ZXVlLgo+IEJ1dCB0aGUgeHNrIHJlcXVpcmVzIHRo
YXQgdGhlIHNlbmQgcXVldWUgdXNlIHRoZSBwcmVtYXBwZWQgbW9kZS4KPiBTbyB0aGUgc2VuZCBx
dWV1ZSBtdXN0IHN1cHBvcnQgcHJlbWFwcGVkIG1vZGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL25ldC92
aXJ0aW8vbWFpbi5jICAgICAgIHwgMTA4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
Cj4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmggfCAgNTQgKysrKysrKysrKysrKysr
LQo+ICAyIGZpbGVzIGNoYW5nZWQsIDE0OSBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vbWFpbi5jIGIvZHJpdmVycy9uZXQv
dmlydGlvL21haW4uYwo+IGluZGV4IDhkYTg0ZWE5YmNiZS4uMDJkMjcxMDFmZWYxIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby9tYWluLmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW8vbWFpbi5jCj4gQEAgLTUxNCwyMCArNTE0LDEwNCBAQCBzdGF0aWMgdm9pZCAqdmlydG5ldF9y
cV9hbGxvYyhzdHJ1Y3QgdmlydG5ldF9ycSAqcnEsIHUzMiBzaXplLCBnZnBfdCBnZnApCj4gICAg
ICAgICByZXR1cm4gYnVmOwo+ICB9Cj4KPiAtc3RhdGljIHZvaWQgdmlydG5ldF9ycV9zZXRfcHJl
bWFwcGVkKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+ICtzdGF0aWMgaW50IHZpcnRuZXRfc3Ff
c2V0X3ByZW1hcHBlZChzdHJ1Y3QgdmlydG5ldF9zcSAqc3EpCj4gIHsKPiAtICAgICAgIGludCBp
Owo+ICsgICAgICAgc3RydWN0IHZpcnRuZXRfc3FfZG1hICpkOwo+ICsgICAgICAgaW50IGVyciwg
c2l6ZSwgaTsKPgo+IC0gICAgICAgLyogZGlzYWJsZSBmb3IgYmlnIG1vZGUgKi8KPiAtICAgICAg
IGlmICghdmktPm1lcmdlYWJsZV9yeF9idWZzICYmIHZpLT5iaWdfcGFja2V0cykKPiAtICAgICAg
ICAgICAgICAgcmV0dXJuOwoKTm90IHNwZWNpZmljIHRvIHRoaXMgcGF0Y2ggYnV0IGFueSBwbGFu
IHRvIGZpeCB0aGUgYmlnIG1vZGU/CgoKPiArICAgICAgIHNpemUgPSB2aXJ0cXVldWVfZ2V0X3Zy
aW5nX3NpemUoc3EtPnZxKTsKPiArCj4gKyAgICAgICBzaXplICs9IE1BWF9TS0JfRlJBR1MgKyAy
Owo+ICsKPiArICAgICAgIHNxLT5kbWFpbmZvLmhlYWQgPSBrY2FsbG9jKHNpemUsIHNpemVvZigq
c3EtPmRtYWluZm8uaGVhZCksIEdGUF9LRVJORUwpOwo+ICsgICAgICAgaWYgKCFzcS0+ZG1haW5m
by5oZWFkKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsKPiArCj4gKyAgICAgICBl
cnIgPSB2aXJ0cXVldWVfc2V0X2RtYV9wcmVtYXBwZWQoc3EtPnZxKTsKPiArICAgICAgIGlmIChl
cnIpIHsKPiArICAgICAgICAgICAgICAga2ZyZWUoc3EtPmRtYWluZm8uaGVhZCk7Cj4gKyAgICAg
ICAgICAgICAgIHJldHVybiBlcnI7Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgc3EtPmRtYWlu
Zm8uZnJlZSA9IE5VTEw7Cj4gKwo+ICsgICAgICAgc3EtPmRvX2RtYSA9IHRydWU7Cj4gKwo+ICsg
ICAgICAgZm9yIChpID0gMDsgaSA8IHNpemU7ICsraSkgewo+ICsgICAgICAgICAgICAgICBkID0g
JnNxLT5kbWFpbmZvLmhlYWRbaV07Cj4gKwo+ICsgICAgICAgICAgICAgICBkLT5uZXh0ID0gc3Et
PmRtYWluZm8uZnJlZTsKPiArICAgICAgICAgICAgICAgc3EtPmRtYWluZm8uZnJlZSA9IGQ7Cj4g
KyAgICAgICB9Cj4gKwo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lk
IHZpcnRuZXRfc2V0X3ByZW1hcHBlZChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiArewo+ICsg
ICAgICAgaW50IGk7Cj4KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3Bh
aXJzOyBpKyspIHsKPiAtICAgICAgICAgICAgICAgaWYgKHZpcnRxdWV1ZV9zZXRfZG1hX3ByZW1h
cHBlZCh2aS0+cnFbaV0udnEpKQo+ICsgICAgICAgICAgICAgICBpZiAoIXZpcnRuZXRfc3Ffc2V0
X3ByZW1hcHBlZCgmdmktPnNxW2ldKSkKPiArICAgICAgICAgICAgICAgICAgICAgICB2aS0+c3Fb
aV0uZG9fZG1hID0gdHJ1ZTsKPiArCj4gKyAgICAgICAgICAgICAgIC8qIGRpc2FibGUgZm9yIGJp
ZyBtb2RlICovCj4gKyAgICAgICAgICAgICAgIGlmICghdmktPm1lcmdlYWJsZV9yeF9idWZzICYm
IHZpLT5iaWdfcGFja2V0cykKPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPgo+
IC0gICAgICAgICAgICAgICB2aS0+cnFbaV0uZG9fZG1hID0gdHJ1ZTsKPiArICAgICAgICAgICAg
ICAgaWYgKCF2aXJ0cXVldWVfc2V0X2RtYV9wcmVtYXBwZWQodmktPnJxW2ldLnZxKSkKPiArICAg
ICAgICAgICAgICAgICAgICAgICB2aS0+cnFbaV0uZG9fZG1hID0gdHJ1ZTsKPiArICAgICAgIH0K
PiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB2aXJ0bmV0X3NxX2RtYSAqdmlydG5ldF9zcV9tYXBf
c2coc3RydWN0IHZpcnRuZXRfc3EgKnNxLCBpbnQgbmVudHMsIHZvaWQgKmRhdGEpCj4gK3sKPiAr
ICAgICAgIHN0cnVjdCB2aXJ0bmV0X3NxX2RtYSAqZCwgKmhlYWQ7Cj4gKyAgICAgICBzdHJ1Y3Qg
c2NhdHRlcmxpc3QgKnNnOwo+ICsgICAgICAgaW50IGk7Cj4gKwo+ICsgICAgICAgaGVhZCA9IE5V
TEw7Cj4gKwo+ICsgICAgICAgZm9yX2VhY2hfc2coc3EtPnNnLCBzZywgbmVudHMsIGkpIHsKPiAr
ICAgICAgICAgICAgICAgc2ctPmRtYV9hZGRyZXNzID0gdmlydHF1ZXVlX2RtYV9tYXBfc2luZ2xl
X2F0dHJzKHNxLT52cSwgc2dfdmlydChzZyksCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZy0+bGVuZ3RoLAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRE1BX1RPX0RFVklDRSwgMCk7Cj4gKyAgICAgICAgICAgICAgIGlmICh2aXJ0cXVldWVfZG1h
X21hcHBpbmdfZXJyb3Ioc3EtPnZxLCBzZy0+ZG1hX2FkZHJlc3MpKQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gZXJyOwo+ICsKPiArICAgICAgICAgICAgICAgZCA9IHNxLT5kbWFpbmZv
LmZyZWU7Cj4gKyAgICAgICAgICAgICAgIHNxLT5kbWFpbmZvLmZyZWUgPSBkLT5uZXh0Owo+ICsK
PiArICAgICAgICAgICAgICAgZC0+YWRkciA9IHNnLT5kbWFfYWRkcmVzczsKPiArICAgICAgICAg
ICAgICAgZC0+bGVuID0gc2ctPmxlbmd0aDsKPiArCj4gKyAgICAgICAgICAgICAgIGQtPm5leHQg
PSBoZWFkOwo+ICsgICAgICAgICAgICAgICBoZWFkID0gZDsKCkl0J3MgcmVhbGx5IGEgcGl0eSB0
aGF0IHdlIG5lZWQgdG8gZHVwbGljYXRlIHRob3NlIERNQSBtZXRhdGEgdHdpY2UuCkNvdWxkIHdl
IGludmVudCBhIG5ldyBBUEkgdG8ganVzdCBmZXRjaCBpdCBmcm9tIHRoZSB2aXJ0aW8gY29yZT8K
Cj4gKyAgICAgICB9Cj4gKwo+ICsgICAgICAgaGVhZC0+ZGF0YSA9IGRhdGE7Cj4gKwo+ICsgICAg
ICAgcmV0dXJuICh2b2lkICopKCh1bnNpZ25lZCBsb25nKWhlYWQgfCAoKHVuc2lnbmVkIGxvbmcp
ZGF0YSAmIFZJUlRJT19YTUlUX0RBVEFfTUFTSykpOwoKSWYgd2UgcGFja2VkIGV2ZXJ5dGhpbmcg
aW50byBkbWFpbmZvLCB3ZSBjYW4gbGVhdmUgdGhlIHR5cGUgKFhEUCB2cwpza2IpIHRoZXJlIHRv
IGF2b2lkIHRyaWNrIGxpa2UgcGFja2luZyBpdCBpbnRvIHRoZSBwb2ludGVyIGhlcmU/CgpUaGFu
a3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

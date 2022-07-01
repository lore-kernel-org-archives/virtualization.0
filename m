Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149D5CCA47F
	for <virtualization@archiver.kernel.org>; Fri,  1 Jul 2022 09:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D2DF84684;
	Fri,  1 Jul 2022 09:36:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D2DF84684
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XOTCaOHL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CI6jHP21oD7T; Fri,  1 Jul 2022 09:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2B2BC8453F;
	Fri,  1 Jul 2022 09:36:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B2BC8453F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13212C0035;
	Fri,  1 Jul 2022 09:36:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE7B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B40661018
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B40661018
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XOTCaOHL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id giVMkhySRNs9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:36:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D705B61011
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D705B61011
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656668210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dN2Ed9BguDI5gyWO5SlL0rnKl20jgh9B0B8prvlwR0=;
 b=XOTCaOHLSVBMjyiI2aTeDtKk9BFTWgSJmvxjVSCKRxjLBq9dSRv17Lf5YiUGMu4pLWqf8x
 9vHPR7m4VvgnNfKgqjOMDfbhNXzs+aptyBIpFSgPSclqG3tIVZYiBParAr9TOegmqKrzuM
 sWV86QNiu9wgkxUuJ8buyJTFXA/zO+4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-ripaGpcxM7SjxVNLwCgrRQ-1; Fri, 01 Jul 2022 05:36:49 -0400
X-MC-Unique: ripaGpcxM7SjxVNLwCgrRQ-1
Received: by mail-pl1-f198.google.com with SMTP id
 e8-20020a17090301c800b0016a57150c37so1215003plh.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Jul 2022 02:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3dN2Ed9BguDI5gyWO5SlL0rnKl20jgh9B0B8prvlwR0=;
 b=3ap6n7RGzkXtpLvnT75xX3Ph0LciT7HvGlSYZygb5VUzgB1C83J3I/ToyP8soFy1Am
 DwbbNJBmjWx8ehgSx3MSCcN8fTeQNT4NeCyMv2L+MgcMHh9xNiNRok/O662pNOE7/hbu
 4hzPW+RdNgLD1zhiayVmYPS/l6Pgk3DzAAJ3K4UNGYp60RfnP8RI4Bd/ngki1QNbjQ0X
 lNfWyfJGCURajFRQ637Pg3qwhpznmAQhQd0f6LkDhnzYXKO7JTsyaTVCsfS+6y+5DoRq
 wnzUMTRfDeAiBDEuzXwGLPZHmzhHdxTCuQnI6eCE2bhlgIGf9OYCEBkyv6bIECrHKapg
 6c9Q==
X-Gm-Message-State: AJIora9P1wB5QHb5Xh/Vm7kz9kFrIU02ux6c/xoI93tRYEltt3/H27xu
 f81/mQE9EllAWpH8z/iqg+ULpSonLrYTZ0lCyadfrnmeAkXesDhfdEMaiaYuO2zNdwpVUAOJt24
 lE1wt96rrsERzMJKXXpG7bU1/IrPo/CMAJ0CYv0QtIg==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id
 j14-20020a170903024e00b0016b9fa241e5mr13769770plh.127.1656668208671; 
 Fri, 01 Jul 2022 02:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s2tQyLCXMrbx9yXxpYY9TeU2uoF6cGR+tGI1XuAVQyHwDEpf0d8SFWt7v9pCDnMz5Bdj+bww==
X-Received: by 2002:a17:903:24e:b0:16b:9fa2:41e5 with SMTP id
 j14-20020a170903024e00b0016b9fa241e5mr13769722plh.127.1656668208349; 
 Fri, 01 Jul 2022 02:36:48 -0700 (PDT)
Received: from [10.72.13.237] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 t129-20020a625f87000000b005259578e8fcsm11802013pfb.181.2022.07.01.02.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 02:36:47 -0700 (PDT)
Message-ID: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Date: Fri, 1 Jul 2022 17:36:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
 <20220701022950-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220701022950-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

CuWcqCAyMDIyLzcvMSAxNDozMSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBPbiBXZWQs
IEp1biAyOSwgMjAyMiBhdCAwMjo1Njo0MVBNICswODAwLCBYdWFuIFpodW8gd3JvdGU6Cj4+IFRo
aXMgcGF0Y2ggYWxsb3dzIHRoZSBuZXcgaW50cm9kdWNlZAo+PiBfX3ZpcnRxdWV1ZV9icmVhaygp
L19fdmlydHF1ZXVlX3VuYnJlYWsoKSB0byBicmVhay91bmJyZWFrIHRoZQo+PiB2aXJ0cXVldWUu
Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+Cj4gSSB3b25kZXIgaG93IHRoaXMgaW50ZXJhY3RzIHdpdGggdGhlIGhhcmRlbmluZyBwYXRj
aGVzLgo+IEphc29uPwoKCkNvbnNpZGVyIHdlJ3ZlIG1hcmtlZCBpdCBhcyBicm9rZW4sIEkgdGhp
bmsgd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IAp0aGUgaGFyZGVuaW5nIGluIHRoaXMgc2Vy
aWVzLiBKdXN0IG1ha2UgaXQgd29yayB3aXRob3V0IGhhcmRlbmluZy4KCkFuZCBJIHdpbGwgaGFu
ZGxlIHZxIHJlc2V0IHdoZW4gcmV3b3JrIHRoZSBJUlEgaGFyZGVuaW5nLgoKVGhhbmtzCgoKPgo+
PiAtLS0KPj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMjQgKysrKysrKysrKysr
KysrKysrKysrKysrCj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrKwo+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5n
LmMKPj4gaW5kZXggNWVjNDM2MDdjYzE1Li43YjAyYmU3ZmNlNjcgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+PiBAQCAtMjc0NCw2ICsyNzQ0LDMwIEBAIHVuc2lnbmVkIGludCB2aXJ0cXVldWVf
Z2V0X3ZyaW5nX3NpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+PiAgIH0KPj4gICBFWFBPUlRf
U1lNQk9MX0dQTCh2aXJ0cXVldWVfZ2V0X3ZyaW5nX3NpemUpOwo+PiAgIAo+PiArLyoKPj4gKyAq
IFRoaXMgZnVuY3Rpb24gc2hvdWxkIG9ubHkgYmUgY2FsbGVkIGJ5IHRoZSBjb3JlLCBub3QgZGly
ZWN0bHkgYnkgdGhlIGRyaXZlci4KPj4gKyAqLwo+PiArdm9pZCBfX3ZpcnRxdWV1ZV9icmVhayhz
dHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICt7Cj4+ICsJc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEgPSB0b192dnEoX3ZxKTsKPj4gKwo+PiArCS8qIFBhaXJzIHdpdGggUkVBRF9PTkNFKCkgaW4g
dmlydHF1ZXVlX2lzX2Jyb2tlbigpLiAqLwo+PiArCVdSSVRFX09OQ0UodnEtPmJyb2tlbiwgdHJ1
ZSk7Cj4+ICt9Cj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1ZV9icmVhayk7Cj4+ICsK
Pj4gKy8qCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBieSB0aGUg
Y29yZSwgbm90IGRpcmVjdGx5IGJ5IHRoZSBkcml2ZXIuCj4+ICsgKi8KPj4gK3ZvaWQgX192aXJ0
cXVldWVfdW5icmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+ICt7Cj4+ICsJc3RydWN0IHZy
aW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPj4gKwo+PiArCS8qIFBhaXJzIHdpdGgg
UkVBRF9PTkNFKCkgaW4gdmlydHF1ZXVlX2lzX2Jyb2tlbigpLiAqLwo+PiArCVdSSVRFX09OQ0Uo
dnEtPmJyb2tlbiwgZmFsc2UpOwo+PiArfQo+IEkgZG9uJ3QgdGhpbmsgdGhlc2UgIlBhaXJzIiBj
b21tZW50cyBoYXZlIGFueSB2YWx1ZS4KPgo+Cj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRx
dWV1ZV91bmJyZWFrKTsKPj4gKwo+PiAgIGJvb2wgdmlydHF1ZXVlX2lzX2Jyb2tlbihzdHJ1Y3Qg
dmlydHF1ZXVlICpfdnEpCj4+ICAgewo+PiAgIAlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9
IHRvX3Z2cShfdnEpOwo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8uaCBiL2lu
Y2x1ZGUvbGludXgvdmlydGlvLmgKPj4gaW5kZXggMTI3MjU2NmFkZWM2Li5kYzQ3NGEwZDQ4ZDEg
MTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPj4gKysrIGIvaW5jbHVkZS9s
aW51eC92aXJ0aW8uaAo+PiBAQCAtMTM4LDYgKzEzOCw5IEBAIGJvb2wgaXNfdmlydGlvX2Rldmlj
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwo+PiAgIHZvaWQgdmlydGlvX2JyZWFrX2RldmljZShzdHJ1
Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4gICB2b2lkIF9fdmlydGlvX3VuYnJlYWtfZGV2aWNl
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+PiAgIAo+PiArdm9pZCBfX3ZpcnRxdWV1ZV9i
cmVhayhzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpOwo+PiArdm9pZCBfX3ZpcnRxdWV1ZV91bmJyZWFr
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+ICsKPj4gICB2b2lkIHZpcnRpb19jb25maWdfY2hh
bmdlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4gICAjaWZkZWYgQ09ORklHX1BNX1NM
RUVQCj4+ICAgaW50IHZpcnRpb19kZXZpY2VfZnJlZXplKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpk
ZXYpOwo+PiAtLSAKPj4gMi4zMS4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

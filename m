Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030AC76196
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 06:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 240C782190;
	Tue, 28 Mar 2023 06:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 240C782190
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g/3EMHuW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tOQNa6w6DGRx; Tue, 28 Mar 2023 06:18:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 15DA782178;
	Tue, 28 Mar 2023 06:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15DA782178
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA55C0036;
	Tue, 28 Mar 2023 06:18:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EDDEC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39D9A40CA1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:17:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39D9A40CA1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=g/3EMHuW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BocGOXyJ_1dw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:17:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FDA74011C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FDA74011C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 06:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679984277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xsc7UO9YYazLYGSDUS0EJUCS68PHCQOhVmqaJ1ZEnhU=;
 b=g/3EMHuWKj5V1kKbKreFfE7UXjRtsLbSSM+poujDIlJcN3kOIOFfVhOCA0z1W5/7OXVrqG
 uKbLyG0ChLmkx9VejMD0mQ3ZMwbJvOTU8YB162VwZoYy1pUv5nYLGypBaq3mrk8eHOOLT6
 znpcnwCve2quL0aitp0pRRzMn6t2kZo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-iIP15AFxMYK7hsBtrdB2nw-1; Tue, 28 Mar 2023 02:17:56 -0400
X-MC-Unique: iIP15AFxMYK7hsBtrdB2nw-1
Received: by mail-pg1-f200.google.com with SMTP id
 g13-20020a63f40d000000b005015be7b9faso2969090pgi.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 23:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679984275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xsc7UO9YYazLYGSDUS0EJUCS68PHCQOhVmqaJ1ZEnhU=;
 b=Qein+NphUzQa7worq5phL/AeRbOkvIP6+Oa8J/PPrdrxmY+GXDomexuulUKDTNx/kE
 VZDnsQSvkmxReWRCHtGNbMoZAyCvKcxJxswezy9m8qwMghuaE0RvzKLBqmC50yjgz78Q
 pcfc3s2rH8Vn5jtRw+SRAVOoaHUkqll1aZb3MdctaIOag09Id6m0X4+Fa0RBHme+5pBe
 RJSVmKfbNoOrmRIJEshfcH/PldG6VMU4Yzk6MSS9M/x26pgNC7NAxBKajfewpfzdLXak
 MKiR2nRlBoYszHduUVm5hJOCdEgGn6mi/BsrBAWDUxZBt9XJz5nr+cOhWNbEmEGjo5bw
 OzsA==
X-Gm-Message-State: AAQBX9ebgM7WXFLVpmHtmNy9dV72AHX9FGj3HQPPQcPcRbx1V7FODOWI
 k+ZMmnNs8Sxvtn7UYqN0VprzHDSVYeM1vUGWhMoEHf+fVfbFAnmUZe4U7koVJhCg4yBUCrEnGbi
 g8GAkjmYgr2s/03g1t9LkNbPLsJF72+JEuP4hzIR5cQ==
X-Received: by 2002:a17:90b:1b49:b0:23f:9439:9a27 with SMTP id
 nv9-20020a17090b1b4900b0023f94399a27mr15305332pjb.20.1679984275137; 
 Mon, 27 Mar 2023 23:17:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350YN1lfzRNqgj4QyndNByT6/a3apGRBTI3BMeCeEFa0Kwbx0ENst/W1oW8eI9H1IVDkkr9sSqg==
X-Received: by 2002:a17:90b:1b49:b0:23f:9439:9a27 with SMTP id
 nv9-20020a17090b1b4900b0023f94399a27mr15305316pjb.20.1679984274824; 
 Mon, 27 Mar 2023 23:17:54 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a17090aba0a00b0023f355a0bb5sm8478897pjr.14.2023.03.27.23.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Mar 2023 23:17:54 -0700 (PDT)
Message-ID: <e928b283-709d-c632-a294-c95b60d813ce@redhat.com>
Date: Tue, 28 Mar 2023 14:17:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 08/11] vdpa: Add eventfd for the vdpa callback
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, tglx@linutronix.de, 
 hch@lst.de
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-9-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-9-xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIzLzMvMjMgMTM6MzAsIFhpZSBZb25namkg5YaZ6YGTOgo+IEFkZCBldmVudGZkIGZv
ciB0aGUgdmRwYSBjYWxsYmFjayBzbyB0aGF0IHVzZXIKPiBjYW4gc2lnbmFsIGl0IGRpcmVjdGx5
IGluc3RlYWQgb2YgdHJpZ2dlcmluZyB0aGUKPiBjYWxsYmFjay4gSXQgd2lsbCBiZSB1c2VkIGZv
ciB2aG9zdC12ZHBhIGNhc2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25n
amlAYnl0ZWRhbmNlLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyAgICAgICAgIHwg
MiArKwo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDEgKwo+ICAgaW5jbHVkZS9s
aW51eC92ZHBhLmggICAgICAgICB8IDYgKysrKysrCj4gICAzIGZpbGVzIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPiBpbmRleCA3YmU5ZDlkOGYwMWMuLjljZDg3OGUyNWNmZiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4gQEAgLTU5OSw5ICs1OTksMTEgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV92cmluZ19pb2N0
bChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwKPiAgIAkJaWYgKHZxLT5j
YWxsX2N0eC5jdHgpIHsKPiAgIAkJCWNiLmNhbGxiYWNrID0gdmhvc3RfdmRwYV92aXJ0cXVldWVf
Y2I7Cj4gICAJCQljYi5wcml2YXRlID0gdnE7Cj4gKwkJCWNiLnRyaWdnZXIgPSB2cS0+Y2FsbF9j
dHguY3R4Owo+ICAgCQl9IGVsc2Ugewo+ICAgCQkJY2IuY2FsbGJhY2sgPSBOVUxMOwo+ICAgCQkJ
Y2IucHJpdmF0ZSA9IE5VTEw7Cj4gKwkJCWNiLnRyaWdnZXIgPSBOVUxMOwo+ICAgCQl9Cj4gICAJ
CW9wcy0+c2V0X3ZxX2NiKHZkcGEsIGlkeCwgJmNiKTsKPiAgIAkJdmhvc3RfdmRwYV9zZXR1cF92
cV9pcnEodiwgaWR4KTsKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEu
YyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb192ZHBhLmMKPiBpbmRleCBmMzgyNmY0MmI3MDQuLjJh
MDk1ZjM3ZjI2YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4g
KysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IEBAIC0xOTYsNiArMTk2LDcgQEAg
dmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVk
IGludCBpbmRleCwKPiAgIAkvKiBTZXR1cCB2aXJ0cXVldWUgY2FsbGJhY2sgKi8KPiAgIAljYi5j
YWxsYmFjayA9IGNhbGxiYWNrID8gdmlydGlvX3ZkcGFfdmlydHF1ZXVlX2NiIDogTlVMTDsKPiAg
IAljYi5wcml2YXRlID0gaW5mbzsKPiArCWNiLnRyaWdnZXIgPSBOVUxMOwo+ICAgCW9wcy0+c2V0
X3ZxX2NiKHZkcGEsIGluZGV4LCAmY2IpOwo+ICAgCW9wcy0+c2V0X3ZxX251bSh2ZHBhLCBpbmRl
eCwgdmlydHF1ZXVlX2dldF92cmluZ19zaXplKHZxKSk7Cj4gICAKPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IGluZGV4IGU1MmM5YTM3
OTk5Yy4uMDM3MmIyZTNkMzhhIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4g
KysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAtMTMsMTAgKzEzLDE2IEBACj4gICAgKiBz
dHJ1Y3QgdmRwYV9jYWxsbGJhY2sgLSB2RFBBIGNhbGxiYWNrIGRlZmluaXRpb24uCj4gICAgKiBA
Y2FsbGJhY2s6IGludGVycnVwdCBjYWxsYmFjayBmdW5jdGlvbgo+ICAgICogQHByaXZhdGU6IHRo
ZSBkYXRhIHBhc3NlZCB0byB0aGUgY2FsbGJhY2sgZnVuY3Rpb24KPiArICogQHRyaWdnZXI6IHRo
ZSBldmVudGZkIGZvciB0aGUgY2FsbGJhY2sgKE9wdGlvbmFsKS4KPiArICogICAgICAgICAgIFdo
ZW4gaXQgaXMgc2V0LCB0aGUgdkRQQSBkcml2ZXIgbXVzdCBndWFyYW50ZWUgdGhhdAo+ICsgKiAg
ICAgICAgICAgc2lnbmFsaW5nIGl0IGlzIGZ1bmN0aW9uYWwgZXF1aXZhbGVudCB0byB0cmlnZ2Vy
aW5nCj4gKyAqICAgICAgICAgICB0aGUgY2FsbGJhY2suIFRoZW4gdkRQQSBwYXJlbnQgY2FuIHNp
Z25hbCBpdCBkaXJlY3RseQo+ICsgKiAgICAgICAgICAgaW5zdGVhZCBvZiB0cmlnZ2VyaW5nIHRo
ZSBjYWxsYmFjay4KPiAgICAqLwo+ICAgc3RydWN0IHZkcGFfY2FsbGJhY2sgewo+ICAgCWlycXJl
dHVybl90ICgqY2FsbGJhY2spKHZvaWQgKmRhdGEpOwo+ICAgCXZvaWQgKnByaXZhdGU7Cj4gKwlz
dHJ1Y3QgZXZlbnRmZF9jdHggKnRyaWdnZXI7Cj4gICB9Owo+ICAgCj4gICAvKioKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

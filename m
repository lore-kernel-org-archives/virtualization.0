Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D73C433ED
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 05:51:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CAA608FC
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 05:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CAA608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46F2560D68;
	Wed, 14 Apr 2021 05:51:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fJAYKSNQm3vJ; Wed, 14 Apr 2021 05:51:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA52B60D65;
	Wed, 14 Apr 2021 05:51:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90AA3C000B;
	Wed, 14 Apr 2021 05:51:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61298C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 05:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5392240F17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 05:51:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id trcU9w2Vp010
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 05:51:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 622EB40F0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618379484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XTp5CTUDbE/ftQ/v/Y7x3rIKSHCnEgcZXgomSO+tEsM=;
 b=AfBm2zQMdKysvPpQ5W0zdbkNtdq7gSE6thdJmxv8J4P0xf61aQS0VewLNpulJO+dJn2MED
 rLXFyWrPsZ9j6kALe6Ei9xEaWxQ04oaJfVDaf41xF0KoEjEw1ZtyQWrYaiXBelsT1eXNKz
 1pxBetyGCA1aSkiWaTj+a8DfSiRKMNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-js-Em3rDNA2HCALIpf5aWg-1; Wed, 14 Apr 2021 01:51:20 -0400
X-MC-Unique: js-Em3rDNA2HCALIpf5aWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E961882FD5;
 Wed, 14 Apr 2021 05:51:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-33.pek2.redhat.com
 [10.72.13.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0AF45D9CA;
 Wed, 14 Apr 2021 05:51:09 +0000 (UTC)
Subject: Re: [PATCH net-next v4 10/10] virtio-net: xsk zero copy xmit kick by
 threshold
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210413031523.73507-1-xuanzhuo@linux.alibaba.com>
 <20210413031523.73507-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <078fcc88-ebb3-badc-0004-e11af58143c3@redhat.com>
Date: Wed, 14 Apr 2021 13:51:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413031523.73507-11-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xMyDJz87nMTE6MTUsIFh1YW4gWmh1byDQtLXAOgo+IEFmdGVyIHRlc3Rpbmcs
IHRoZSBwZXJmb3JtYW5jZSBvZiBjYWxsaW5nIGtpY2sgZXZlcnkgdGltZSBpcyBub3Qgc3RhYmxl
Lgo+IEFuZCBpZiBhbGwgdGhlIHBhY2tldHMgYXJlIHNlbnQgYW5kIGtpY2tlZCBhZ2FpbiwgdGhl
IHBlcmZvcm1hbmNlIGlzIG5vdAo+IGdvb2QuIFNvIGFkZCBhIG1vZHVsZSBwYXJhbWV0ZXIgdG8g
c3BlY2lmeSBob3cgbWFueSBwYWNrZXRzIGFyZSBzZW50IHRvCj4gY2FsbCBhIGtpY2suCj4KPiA4
IGlzIGEgcmVsYXRpdmVseSBzdGFibGUgdmFsdWUgd2l0aCB0aGUgYmVzdCBwZXJmb3JtYW5jZS4K
Pgo+IEhlcmUgaXMgdGhlIHBwcyBvZiB0aGUgdGVzdCBvZiB4c2tfa2lja190aHIgdW5kZXIgZGlm
ZmVyZW50IHZhbHVlcyAoZnJvbQo+IDEgdG8gNjQpLgo+Cj4gdGhyICBQUFMgICAgICAgICAgICAg
dGhyIFBQUyAgICAgICAgICAgICB0aHIgUFBTCj4gMSAgICAyOTI0MTE2Ljc0MjQ3IHwgMjMgIDM2
ODMyNjMuMDQzNDggfCA0NSAgMjc3NzkwNy4yMjk2Mwo+IDIgICAgMzQ0MTAxMC41NzE5MSB8IDI0
ICAzMDc4ODgwLjEzMDQzIHwgNDYgIDI3ODEzNzYuMjE3MzkKPiAzICAgIDM2MzY3MjguNzIzNzgg
fCAyNSAgMjg1OTIxOS41NzY1NiB8IDQ3ICAyNzc3MjcxLjkxMzA0Cj4gNCAgICAzNjM3NTE4LjYx
NDY4IHwgMjYgIDI4NTE1NTcuOTU5MyAgfCA0OCAgMjgwMDMyMC41NjU3NQo+IDUgICAgMzY1MTcz
OC4xNjI1MSB8IDI3ICAyODM0NzgzLjU0NDA4IHwgNDkgIDI4MTMwMzkuODc1OTkKPiA2ICAgIDM2
NTIxNzYuNjkyMzEgfCAyOCAgMjg0NzAxMi40MTQ3MiB8IDUwICAzNDQ1MTQzLjAxODM5Cj4gNyAg
ICAzNjY1NDE1LjgwNjAyIHwgMjkgIDI4NjA2MzMuOTEzMDQgfCA1MSAgMzY2NjkxOC4wMTI4MQo+
IDggICAgMzY2NTA0NS4xNjU1NSB8IDMwICAyODU3OTAzLjU3ODYgIHwgNTIgIDMwNTk5MjkuMjcw
OQo+IDkgICAgMzY3MTAyMy4yNDAxICB8IDMxICAyODM1NTg5Ljk4OTYzIHwgNTMgIDI4MzE1MTUu
MjE3MzkKPiAxMCAgIDM2Njk1MzIuMjMyNzQgfCAzMiAgMjg2MjgyNy44ODcwNiB8IDU0ICAzNDUx
ODA0LjA3MjA0Cj4gMTEgICAzNjY2MTYwLjM3NzQ5IHwgMzMgIDI4NzE4NTUuOTY2OTYgfCA1NSAg
MzY1NDk3NS45MjM4NQo+IDEyICAgMzY3NDk1MS40NDgxMyB8IDM0ICAzNDM0NDU2LjQ0ODE2IHwg
NTYgIDM2NzYxOTguMzE4OAo+IDEzICAgMzY2NzQ0Ny41NzMzMSB8IDM1ICAzNjU2OTE4LjU0MTc3
IHwgNTcgIDM2ODQ3NDAuODU2MTkKPiAxNCAgIDMwMTg4NDYuMDUwMyAgfCAzNiAgMzU5NjkyMS4x
NjcyMiB8IDU4ICAzMDYwOTU4Ljg1OTQKPiAxNSAgIDI3OTI3NzMuODQ1MDUgfCAzNyAgMzYwMzQ2
MC42MzkwMyB8IDU5ICAyODI4ODc0LjU3MTkxCj4gMTYgICAzNDMwNTk2LjM2MDIgIHwgMzggIDM1
OTU0MTAuODc2NjYgfCA2MCAgMzQ1OTkyNi4xMTAyNwo+IDE3ICAgMzY2MDUyNS44NTgwNiB8IDM5
ICAzNjA0MjUwLjE3ODE5IHwgNjEgIDM2ODU0NDQuNDc1OTkKPiAxOCAgIDMwNDU2MjcuNjkwNTQg
fCA0MCAgMzU5NjU0Mi4yODQyOCB8IDYyICAzMDQ5OTU5LjA4MDkKPiAxOSAgIDI4NDE1NDIuOTQx
NzcgfCA0MSAgMzYwMDcwNS4xNjA1NCB8IDYzICAyODA2MjgwLjA0MDEzCj4gMjAgICAyODMwNDc1
Ljk3MzQ4IHwgNDIgIDMwMTk4MzMuNzExOTEgfCA2NCAgMzQ0ODQ5NC4zOTEzCj4gMjEgICAyODQ1
NjU1LjU1Nzg5IHwgNDMgIDI3NTI5NTEuOTMyNjQgfAo+IDIyICAgMzQ1MDM4OS44NDM2NSB8IDQ0
ICAyNzUzMTA3LjI3MTY0IHwKPgo+IEl0IGNhbiBiZSBmb3VuZCB0aGF0IHdoZW4gdGhlIHZhbHVl
IG9mIHhza19raWNrX3RociBpcyByZWxhdGl2ZWx5IHNtYWxsLAo+IHRoZSBwZXJmb3JtYW5jZSBp
cyBub3QgZ29vZCwgYW5kIHdoZW4gaXRzIHZhbHVlIGlzIGdyZWF0ZXIgdGhhbiAxMywgdGhlCj4g
cGVyZm9ybWFuY2Ugd2lsbCBiZSBtb3JlIGlycmVndWxhciBhbmQgdW5zdGFibGUuIEl0IGxvb2tz
IHNpbWlsYXIgZnJvbSAzCj4gdG8gMTMsIEkgY2hvc2UgOCBhcyB0aGUgZGVmYXVsdCB2YWx1ZS4K
Pgo+IFRoZSB0ZXN0IGVudmlyb25tZW50IGlzIHFlbXUgKyB2aG9zdC1uZXQuIEkgbW9kaWZpZWQg
dmhvc3QtbmV0IHRvIGRyb3AKPiB0aGUgcGFja2V0cyBzZW50IGJ5IHZtIGRpcmVjdGx5LCBzbyB0
aGF0IHRoZSBjcHUgb2Ygdm0gY2FuIHJ1biBoaWdoZXIuCj4gQnkgZGVmYXVsdCwgdGhlIHByb2Nl
c3NlcyBpbiB0aGUgdm0gYW5kIHRoZSBjcHUgb2Ygc29mdGlycWQgYXJlIHRvbyBsb3csCj4gYW5k
IHRoZXJlIGlzIG5vIG9idmlvdXMgZGlmZmVyZW5jZSBpbiB0aGUgdGVzdCBkYXRhLgo+Cj4gRHVy
aW5nIHRoZSB0ZXN0LCB0aGUgY3B1IG9mIHNvZnRpcnEgcmVhY2hlZCAxMDAlLiBFYWNoIHhza19r
aWNrX3RociB3YXMKPiBydW4gZm9yIDMwMHMsIHRoZSBwcHMgb2YgZXZlcnkgc2Vjb25kIHdhcyBy
ZWNvcmRlZCwgYW5kIHRoZSBhdmVyYWdlIG9mCj4gdGhlIHBwcyB3YXMgZmluYWxseSB0YWtlbi4g
VGhlIHZob3N0IHByb2Nlc3MgY3B1IG9uIHRoZSBob3N0IGhhcyBhbHNvCj4gcmVhY2hlZCAxMDAl
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNv
bT4KPiBSZXZpZXdlZC1ieTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDE5ICsrKysrKysrKysrKysrKysrLS0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+IGluZGV4IGM0NDFkNmJmMTUxMC4uNGUzNjBiZmMyY2YwIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+IEBAIC0yOCw5ICsyOCwxMSBAQCBzdGF0aWMgaW50IG5hcGlfd2VpZ2h0ID0gTkFQSV9QT0xM
X1dFSUdIVDsKPiAgIG1vZHVsZV9wYXJhbShuYXBpX3dlaWdodCwgaW50LCAwNDQ0KTsKPiAgIAo+
ICAgc3RhdGljIGJvb2wgY3N1bSA9IHRydWUsIGdzbyA9IHRydWUsIG5hcGlfdHggPSB0cnVlOwo+
ICtzdGF0aWMgaW50IHhza19raWNrX3RociA9IDg7Cj4gICBtb2R1bGVfcGFyYW0oY3N1bSwgYm9v
bCwgMDQ0NCk7Cj4gICBtb2R1bGVfcGFyYW0oZ3NvLCBib29sLCAwNDQ0KTsKPiAgIG1vZHVsZV9w
YXJhbShuYXBpX3R4LCBib29sLCAwNjQ0KTsKPiArbW9kdWxlX3BhcmFtKHhza19raWNrX3Rociwg
aW50LCAwNjQ0KTsKPiAgIAo+ICAgLyogRklYTUU6IE1UVSBpbiBjb25maWcuICovCj4gICAjZGVm
aW5lIEdPT0RfUEFDS0VUX0xFTiAoRVRIX0hMRU4gKyBWTEFOX0hMRU4gKyBFVEhfREFUQV9MRU4p
Cj4gQEAgLTI2OTAsNiArMjY5Miw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94c2tfeG1pdF9iYXRj
aChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4gICAJc3RydWN0IHhkcF9kZXNjIGRlc2M7Cj4gICAJ
aW50IGVyciwgcGFja2V0ID0gMDsKPiAgIAlpbnQgcmV0ID0gLUVBR0FJTjsKPiArCWludCBuZWVk
X2tpY2sgPSAwOwo+ICAgCj4gICAJaWYgKHNxLT54c2subGFzdF9kZXNjLmFkZHIpIHsKPiAgIAkJ
aWYgKHNxLT52cS0+bnVtX2ZyZWUgPCAyICsgTUFYX1NLQl9GUkFHUykKPiBAQCAtMjcwMCw2ICsy
NzAzLDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hza194bWl0X2JhdGNoKHN0cnVjdCBzZW5kX3F1
ZXVlICpzcSwKPiAgIAkJCXJldHVybiAtRUJVU1k7Cj4gICAKPiAgIAkJKytwYWNrZXQ7Cj4gKwkJ
KytuZWVkX2tpY2s7Cj4gICAJCS0tYnVkZ2V0Owo+ICAgCQlzcS0+eHNrLmxhc3RfZGVzYy5hZGRy
ID0gMDsKPiAgIAl9Cj4gQEAgLTI3MjMsMTEgKzI3MjcsMjIgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3hza194bWl0X2JhdGNoKHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwKPiAgIAkJfQo+ICAgCj4gICAJ
CSsrcGFja2V0Owo+ICsJCSsrbmVlZF9raWNrOwo+ICsJCWlmIChuZWVkX2tpY2sgPiB4c2tfa2lj
a190aHIpIHsKPiArCQkJaWYgKHZpcnRxdWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAmJgo+ICsJ
CQkgICAgdmlydHF1ZXVlX25vdGlmeShzcS0+dnEpKQoKCkkgd29uZXIgd2hldGhlciBpdCdzIHRp
bWUgdG8gaW50cm9kdWNlIGEgaGVscGVyIGluIHRoZSB2aXJ0aW8gY29yZSB0byBkbyAKdGhpcy4K
ClRoYW5rcwoKCj4gKwkJCQkrK3N0YXRzLT5raWNrczsKPiArCj4gKwkJCW5lZWRfa2ljayA9IDA7
Cj4gKwkJfQo+ICAgCX0KPiAgIAo+ICAgCWlmIChwYWNrZXQpIHsKPiAtCQlpZiAodmlydHF1ZXVl
X2tpY2tfcHJlcGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPiAtCQkJ
KytzdGF0cy0+a2lja3M7Cj4gKwkJaWYgKG5lZWRfa2ljaykgewo+ICsJCQlpZiAodmlydHF1ZXVl
X2tpY2tfcHJlcGFyZShzcS0+dnEpICYmCj4gKwkJCSAgICB2aXJ0cXVldWVfbm90aWZ5KHNxLT52
cSkpCj4gKwkJCQkrK3N0YXRzLT5raWNrczsKPiArCQl9Cj4gICAKPiAgIAkJKmRvbmUgPSBwYWNr
ZXQ7Cj4gICAJCXN0YXRzLT54ZHBfdHggKz0gcGFja2V0OwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56607CCA483
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 02:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD0D981CFE;
	Tue,  5 Jul 2022 02:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD0D981CFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bps0TcjspAqX; Tue,  5 Jul 2022 02:01:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6A48781A8E;
	Tue,  5 Jul 2022 02:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A48781A8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C7ECC0032;
	Tue,  5 Jul 2022 02:01:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECF41C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA69D81C56
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA69D81C56
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebtr9ODbO6CS
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6304D81A8E
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6304D81A8E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 02:01:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R611e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=36; SR=0; TI=SMTPD_---0VIPVqL._1656986505; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIPVqL._1656986505) by smtp.aliyun-inc.com;
 Tue, 05 Jul 2022 10:01:46 +0800
Message-ID: <1656986432.1164997-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 39/40] virtio_net: support tx queue resize
Date: Tue, 5 Jul 2022 10:00:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-40-xuanzhuo@linux.alibaba.com>
 <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
In-Reply-To: <102d3b83-1ae9-a59a-16ce-251c22b7afb0@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, bpf@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCA0IEp1bCAyMDIyIDExOjQ1OjUyICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIHJlc2l6ZSBmdW5jdGlvbiBvZiB0aGUg
dHggcXVldWVzLgo+ID4gQmFzZWQgb24gdGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8g
bW9kaWZ5IHRoZSByaW5nIG51bSBvZiB0aGUKPiA+IHF1ZXVlLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQo+ID4K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+IGluZGV4IDZhYjE2ZmQxOTNlNS4uZmQzNTg0NjJmODAyIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+IEBAIC0xMzUsNiArMTM1LDkgQEAgc3RydWN0IHNlbmRfcXVldWUgewo+
ID4gICAJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4gPgo+ID4gICAJc3RydWN0IG5h
cGlfc3RydWN0IG5hcGk7Cj4gPiArCj4gPiArCS8qIFJlY29yZCB3aGV0aGVyIHNxIGlzIGluIHJl
c2V0IHN0YXRlLiAqLwo+ID4gKwlib29sIHJlc2V0Owo+ID4gICB9Owo+ID4KPiA+ICAgLyogSW50
ZXJuYWwgcmVwcmVzZW50YXRpb24gb2YgYSByZWNlaXZlIHZpcnRxdWV1ZSAqLwo+ID4gQEAgLTI3
OSw2ICsyODIsNyBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPiA+ICAgfTsKPiA+Cj4gPiAg
IHN0YXRpYyB2b2lkIHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUg
KnZxLCB2b2lkICpidWYpOwo+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRf
YnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpOwo+ID4KPiA+ICAgc3RhdGljIGJv
b2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPiA+ICAgewo+ID4gQEAgLTE2MDMsNiArMTYwNywx
MSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1
ZSAqcnEpCj4gPiAgIAkJcmV0dXJuOwo+ID4KPiA+ICAgCWlmIChfX25ldGlmX3R4X3RyeWxvY2so
dHhxKSkgewo+ID4gKwkJaWYgKFJFQURfT05DRShzcS0+cmVzZXQpKSB7Cj4gPiArCQkJX19uZXRp
Zl90eF91bmxvY2sodHhxKTsKPiA+ICsJCQlyZXR1cm47Cj4gPiArCQl9Cj4gPiArCj4gPiAgIAkJ
ZG8gewo+ID4gICAJCQl2aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gICAJCQlmcmVl
X29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+ID4gQEAgLTE4NjgsNiArMTg3Nyw0NSBAQCBzdGF0
aWMgaW50IHZpcnRuZXRfcnhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gICAJ
cmV0dXJuIGVycjsKPiA+ICAgfQo+ID4KPiA+ICtzdGF0aWMgaW50IHZpcnRuZXRfdHhfcmVzaXpl
KHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4gKwkJCSAgICAgc3RydWN0IHNlbmRfcXVldWUg
KnNxLCB1MzIgcmluZ19udW0pCj4gPiArewo+ID4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7
Cj4gPiArCWludCBlcnIsIHFpbmRleDsKPiA+ICsKPiA+ICsJcWluZGV4ID0gc3EgLSB2aS0+c3E7
Cj4gPiArCj4gPiArCXZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZzcS0+bmFwaSk7Cj4gPiArCj4g
PiArCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcWluZGV4KTsKPiA+ICsKPiA+
ICsJLyogMS4gd2FpdCBhbGwgeGltdCBjb21wbGV0ZQo+ID4gKwkgKiAyLiBmaXggdGhlIHJhY2Ug
b2YgbmV0aWZfc3RvcF9zdWJxdWV1ZSgpIHZzIG5ldGlmX3N0YXJ0X3N1YnF1ZXVlKCkKPiA+ICsJ
ICovCj4gPiArCV9fbmV0aWZfdHhfbG9ja19iaCh0eHEpOwo+ID4gKwo+ID4gKwkvKiBQcmV2ZW50
IHJ4IHBvbGwgZnJvbSBhY2Nlc3Npbmcgc3EuICovCj4gPiArCVdSSVRFX09OQ0Uoc3EtPnJlc2V0
LCB0cnVlKTsKPgo+Cj4gQ2FuIHdlIHNpbXBseSBkaXNhYmxlIFJYIE5BUEkgaGVyZT8KCkRpc2Fi
bGUgcnggbmFwaSBpcyBpbmRlZWQgYSBzaW1wbGUgc29sdXRpb24uIEJ1dCBJIGhvcGUgdGhhdCB3
aGVuIGRlYWxpbmcgd2l0aAp0eCwgaXQgd2lsbCBub3QgYWZmZWN0IHJ4LgoKVGhhbmtzLgoKCj4K
PiBUaGFua3MKPgo+Cj4gPiArCj4gPiArCS8qIFByZXZlbnQgdGhlIHVwcGVyIGxheWVyIGZyb20g
dHJ5aW5nIHRvIHNlbmQgcGFja2V0cy4gKi8KPiA+ICsJbmV0aWZfc3RvcF9zdWJxdWV1ZSh2aS0+
ZGV2LCBxaW5kZXgpOwo+ID4gKwo+ID4gKwlfX25ldGlmX3R4X3VubG9ja19iaCh0eHEpOwo+ID4g
Kwo+ID4gKwllcnIgPSB2aXJ0cXVldWVfcmVzaXplKHNxLT52cSwgcmluZ19udW0sIHZpcnRuZXRf
c3FfZnJlZV91bnVzZWRfYnVmKTsKPiA+ICsJaWYgKGVycikKPiA+ICsJCW5ldGRldl9lcnIodmkt
PmRldiwgInJlc2l6ZSB0eCBmYWlsOiB0eCBxdWV1ZSBpbmRleDogJWQgZXJyOiAlZFxuIiwgcWlu
ZGV4LCBlcnIpOwo+ID4gKwo+ID4gKwkvKiBNZW1vcnkgYmFycmllciBiZWZvcmUgc2V0IHJlc2V0
IGFuZCBzdGFydCBzdWJxdWV1ZS4gKi8KPiA+ICsJc21wX21iKCk7Cj4gPiArCj4gPiArCVdSSVRF
X09OQ0Uoc3EtPnJlc2V0LCBmYWxzZSk7Cj4gPiArCW5ldGlmX3R4X3dha2VfcXVldWUodHhxKTsK
PiA+ICsKPiA+ICsJdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZxLCAmc3EtPm5hcGkp
Owo+ID4gKwlyZXR1cm4gZXJyOwo+ID4gK30KPiA+ICsKPiA+ICAgLyoKPiA+ICAgICogU2VuZCBj
b21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNoZWNrIHN0YXR1cy4gIENvbW1h
bmRzCj4gPiAgICAqIHN1cHBvcnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgYXMgaW5kaWNhdGVkIGJ5
IGZlYXR1cmUgYml0cywgc2hvdWxkCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

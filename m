Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1204C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 02:23:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B42C4013D;
	Mon,  4 Jul 2022 02:23:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B42C4013D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZG4goL4Nuxt; Mon,  4 Jul 2022 02:23:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8B8B400F3;
	Mon,  4 Jul 2022 02:23:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8B8B400F3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F262C0032;
	Mon,  4 Jul 2022 02:23:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D591C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBB45400F3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DBB45400F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4nq03C_sXtAI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:23:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B18540128
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B18540128
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 02:23:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=36; SR=0;
 TI=SMTPD_---0VIDvD9B_1656901419; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VIDvD9B_1656901419) by smtp.aliyun-inc.com;
 Mon, 04 Jul 2022 10:23:40 +0800
Message-ID: <1656901409.0470793-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v11 23/40] virtio_pci: move struct virtio_pci_common_cfg
 to virtio_pci_modern.h
Date: Mon, 4 Jul 2022 10:23:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-24-xuanzhuo@linux.alibaba.com>
 <f35fdd60-8f69-6004-dd00-62e5fe8a8856@redhat.com>
In-Reply-To: <f35fdd60-8f69-6004-dd00-62e5fe8a8856@redhat.com>
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

T24gRnJpLCAxIEp1bCAyMDIyIDE3OjMzOjAwICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzYvMjkgMTQ6NTYsIFh1YW4gWmh1byDlhpnp
gZM6Cj4gPiBJbiBvcmRlciB0byBmYWNpbGl0YXRlIHRoZSBleHBhbnNpb24gb2YgdmlydGlvX3Bj
aV9jb21tb25fY2ZnIGluIHRoZQo+ID4gZnV0dXJlLCBtb3ZlIGl0IGZyb20gdWFwaSB0byB2aXJ0
aW9fcGNpX21vZGVybi5oLiBJbiB0aGlzIHdheSwgd2UgY2FuCj4gPiBmcmVlbHkgZXhwYW5kIHZp
cnRpb19wY2lfY29tbW9uX2NmZyBpbiB0aGUgZnV0dXJlLgo+ID4KPiA+IE90aGVyIHByb2plY3Rz
IHVzaW5nIHZpcnRpb19wY2lfY29tbW9uX2NmZyBpbiB1YXBpIG5lZWQgdG8gbWFpbnRhaW4gYQo+
ID4gc2VwYXJhdGUgdmlydGlvX3BjaV9jb21tb25fY2ZnIG9yIHVzZSB0aGUgb2Zmc2V0IG1hY3Jv
IGRlZmluZWQgaW4gdWFwaS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56
aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlv
X3BjaV9tb2Rlcm4uaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgIGluY2x1
ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmggICB8IDI2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25z
KC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4u
aCBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+ID4gaW5kZXggZWIyYmQ5YjQw
NzdkLi5jNGY3ZmZiYWNiNGUgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19w
Y2lfbW9kZXJuLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmlydGlvX3BjaV9tb2Rlcm4uaAo+
ID4gQEAgLTUsNiArNSwzMiBAQAo+ID4gICAjaW5jbHVkZSA8bGludXgvcGNpLmg+Cj4gPiAgICNp
bmNsdWRlIDxsaW51eC92aXJ0aW9fcGNpLmg+Cj4gPgo+ID4gKy8qIEZpZWxkcyBpbiBWSVJUSU9f
UENJX0NBUF9DT01NT05fQ0ZHOiAqLwo+ID4gK3N0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcg
ewo+ID4gKwkvKiBBYm91dCB0aGUgd2hvbGUgZGV2aWNlLiAqLwo+ID4gKwlfX2xlMzIgZGV2aWNl
X2ZlYXR1cmVfc2VsZWN0OwkvKiByZWFkLXdyaXRlICovCj4gPiArCV9fbGUzMiBkZXZpY2VfZmVh
dHVyZTsJCS8qIHJlYWQtb25seSAqLwo+ID4gKwlfX2xlMzIgZ3Vlc3RfZmVhdHVyZV9zZWxlY3Q7
CS8qIHJlYWQtd3JpdGUgKi8KPiA+ICsJX19sZTMyIGd1ZXN0X2ZlYXR1cmU7CQkvKiByZWFkLXdy
aXRlICovCj4gPiArCV9fbGUxNiBtc2l4X2NvbmZpZzsJCS8qIHJlYWQtd3JpdGUgKi8KPiA+ICsJ
X19sZTE2IG51bV9xdWV1ZXM7CQkvKiByZWFkLW9ubHkgKi8KPiA+ICsJX191OCBkZXZpY2Vfc3Rh
dHVzOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX3U4IGNvbmZpZ19nZW5lcmF0aW9uOwkJLyog
cmVhZC1vbmx5ICovCj4gPiArCj4gPiArCS8qIEFib3V0IGEgc3BlY2lmaWMgdmlydHF1ZXVlLiAq
Lwo+ID4gKwlfX2xlMTYgcXVldWVfc2VsZWN0OwkJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX2xl
MTYgcXVldWVfc2l6ZTsJCS8qIHJlYWQtd3JpdGUsIHBvd2VyIG9mIDIuICovCj4gPiArCV9fbGUx
NiBxdWV1ZV9tc2l4X3ZlY3RvcjsJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX2xlMTYgcXVldWVf
ZW5hYmxlOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX2xlMTYgcXVldWVfbm90aWZ5X29mZjsJ
LyogcmVhZC1vbmx5ICovCj4gPiArCV9fbGUzMiBxdWV1ZV9kZXNjX2xvOwkJLyogcmVhZC13cml0
ZSAqLwo+ID4gKwlfX2xlMzIgcXVldWVfZGVzY19oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiA+ICsJ
X19sZTMyIHF1ZXVlX2F2YWlsX2xvOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX2xlMzIgcXVl
dWVfYXZhaWxfaGk7CQkvKiByZWFkLXdyaXRlICovCj4gPiArCV9fbGUzMiBxdWV1ZV91c2VkX2xv
OwkJLyogcmVhZC13cml0ZSAqLwo+ID4gKwlfX2xlMzIgcXVldWVfdXNlZF9oaTsJCS8qIHJlYWQt
d3JpdGUgKi8KPiA+ICt9Owo+ID4gKwo+ID4gICBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2
aWNlIHsKPiA+ICAgCXN0cnVjdCBwY2lfZGV2ICpwY2lfZGV2Owo+ID4KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Zp
cnRpb19wY2kuaAo+ID4gaW5kZXggM2E4NmYzNmQ3ZTNkLi4yNDdlYzQyYWYyYzggMTAwNjQ0Cj4g
PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiBAQCAtMTQwLDMyICsxNDAsNiBAQCBzdHJ1Y3Qg
dmlydGlvX3BjaV9ub3RpZnlfY2FwIHsKPiA+ICAgCV9fbGUzMiBub3RpZnlfb2ZmX211bHRpcGxp
ZXI7CS8qIE11bHRpcGxpZXIgZm9yIHF1ZXVlX25vdGlmeV9vZmYuICovCj4gPiAgIH07Cj4gPgo+
ID4gLS8qIEZpZWxkcyBpbiBWSVJUSU9fUENJX0NBUF9DT01NT05fQ0ZHOiAqLwo+ID4gLXN0cnVj
dCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgewo+ID4gLQkvKiBBYm91dCB0aGUgd2hvbGUgZGV2aWNl
LiAqLwo+ID4gLQlfX2xlMzIgZGV2aWNlX2ZlYXR1cmVfc2VsZWN0OwkvKiByZWFkLXdyaXRlICov
Cj4gPiAtCV9fbGUzMiBkZXZpY2VfZmVhdHVyZTsJCS8qIHJlYWQtb25seSAqLwo+ID4gLQlfX2xl
MzIgZ3Vlc3RfZmVhdHVyZV9zZWxlY3Q7CS8qIHJlYWQtd3JpdGUgKi8KPiA+IC0JX19sZTMyIGd1
ZXN0X2ZlYXR1cmU7CQkvKiByZWFkLXdyaXRlICovCj4gPiAtCV9fbGUxNiBtc2l4X2NvbmZpZzsJ
CS8qIHJlYWQtd3JpdGUgKi8KPiA+IC0JX19sZTE2IG51bV9xdWV1ZXM7CQkvKiByZWFkLW9ubHkg
Ki8KPiA+IC0JX191OCBkZXZpY2Vfc3RhdHVzOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gLQlfX3U4
IGNvbmZpZ19nZW5lcmF0aW9uOwkJLyogcmVhZC1vbmx5ICovCj4gPiAtCj4gPiAtCS8qIEFib3V0
IGEgc3BlY2lmaWMgdmlydHF1ZXVlLiAqLwo+ID4gLQlfX2xlMTYgcXVldWVfc2VsZWN0OwkJLyog
cmVhZC13cml0ZSAqLwo+ID4gLQlfX2xlMTYgcXVldWVfc2l6ZTsJCS8qIHJlYWQtd3JpdGUsIHBv
d2VyIG9mIDIuICovCj4gPiAtCV9fbGUxNiBxdWV1ZV9tc2l4X3ZlY3RvcjsJLyogcmVhZC13cml0
ZSAqLwo+ID4gLQlfX2xlMTYgcXVldWVfZW5hYmxlOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gLQlf
X2xlMTYgcXVldWVfbm90aWZ5X29mZjsJLyogcmVhZC1vbmx5ICovCj4gPiAtCV9fbGUzMiBxdWV1
ZV9kZXNjX2xvOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gLQlfX2xlMzIgcXVldWVfZGVzY19oaTsJ
CS8qIHJlYWQtd3JpdGUgKi8KPiA+IC0JX19sZTMyIHF1ZXVlX2F2YWlsX2xvOwkJLyogcmVhZC13
cml0ZSAqLwo+ID4gLQlfX2xlMzIgcXVldWVfYXZhaWxfaGk7CQkvKiByZWFkLXdyaXRlICovCj4g
PiAtCV9fbGUzMiBxdWV1ZV91c2VkX2xvOwkJLyogcmVhZC13cml0ZSAqLwo+ID4gLQlfX2xlMzIg
cXVldWVfdXNlZF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8KPiA+IC19Owo+ID4gLQo+Cj4KPiBJIHRo
aW5rIGl0J3MgYmV0dGVyIG5vdCBkZWxldGUgdGhvc2UgZnJvbSB1QVBJLiBXZSBjYW4gZW1iZWQg
dGhpcyBzdHJ1Y3QKPiBpbiB0aGUgcHJpdmF0ZSB2aXJpdG9fcGNpX21vZGVuLmggYW55aG93LgoK
T0suCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+ID4gICAvKiBGaWVsZHMgaW4gVklSVElPX1BD
SV9DQVBfUENJX0NGRzogKi8KPiA+ICAgc3RydWN0IHZpcnRpb19wY2lfY2ZnX2NhcCB7Cj4gPiAg
IAlzdHJ1Y3QgdmlydGlvX3BjaV9jYXAgY2FwOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

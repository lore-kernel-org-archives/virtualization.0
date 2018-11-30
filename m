From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Fri, 30 Nov 2018 20:55:17 +0800
Message-ID: <55352308-9ceb-413e-44f6-e3dfd8f642cc__5834.58703845299$1543582422$gmane$org@redhat.com>
References: <5BECEE53.7090408@huawei.com>
	<20181115015547-mutt-send-email-mst@kernel.org>
	<61d57505-7ff6-23c6-d26c-6a0062e08445@redhat.com>
	<20181129085049-mutt-send-email-mst@kernel.org>
	<7e78fc3d-0d5a-090f-476d-03ad490ff8a2@redhat.com>
	<20181130075134-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181130075134-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvMzAg5LiL5Y2IODo1MiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4g
ICAgSWYgeW91IHdhbnQgdG8gY29tcGFyZSBpdCB3aXRoCj4+PiBzb21ldGhpbmcgdGhhdCB3b3Vs
ZCBiZSBUQ1Agb3IgUVVJQy4gIFRoZSBmdW5kYW1lbnRhbCBkaWZmZXJlbmNlIGJldHdlZW4KPj4+
IHZpcnRpby12c29jayBhbmQgZS5nLiBUQ1AgaXMgdGhhdCBUQ1Agb3BlcmF0ZXMgaW4gYSBwYWNr
ZXQgbG9zcyBlbnZpcm9ubWVudC4KPj4+IFNvIHRoZXkgYXJlIHVzaW5nIHRpbWVycyBmb3IgcmVs
aWFiaWxpdHksIGFuZCByZWNlaXZlciBpcyBhbHdheXMgZnJlZSB0bwo+Pj4gZGlzY2FyZCBhbnkg
dW5hY2tlZCBkYXRhLgo+PiBWaXJ0aW8tbmV0IGtub3dzIG5vdGhpbmcgYWJvdmUgTDIsIHNvIHRo
ZXkgYXJlIHRvdGFsbHkgdHJhbnNwYXJlbnQgdG8gZGV2aWNlCj4+IGl0c2VsZi4gSSBzdGlsbCBk
b24ndCBnZXQgd2h5IG5vdCB1c2luZyB2aXJ0aW8tbmV0IGluc3RlYWQuCj4+Cj4+Cj4+IFRoYW5r
cwo+IElzIHlvdXIgcXVlc3Rpb24gd2h5IGlzIHZpcnRpby12c29jayB1c2VkIGluc3RlYWQgb2Yg
VENQIG9uIHRvcCBvZiBJUAo+IG9uIHRvcCBvZiB2aXJ0aW8tbmV0Pwo+Cj4KCk5vLCBteSBxdWVz
dGlvbiBpcyB3aHkgbm90IGRvIHZzb2NrIHRocm91Z2ggdmlydGlvLW5ldC4KClRoYW5rcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

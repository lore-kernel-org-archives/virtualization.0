From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 net 7/7] virtio_net: Differentiate sk_buff and
	xdp_frame on freeing
Date: Tue, 29 Jan 2019 10:49:45 +0800
Message-ID: <9df542d3-c0b5-5170-1913-9174a2c37a8e__49333.8194953807$1548742798$gmane$org@redhat.com>
References: <1548722759-2470-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<1548722759-2470-8-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<6267c42f-ce1e-1b63-2af9-84a76090f686@redhat.com>
	<5f114c25-1f42-996b-134c-962b64597e74@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5f114c25-1f42-996b-134c-962b64597e74@lab.ntt.co.jp>
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
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMS8yOSDkuIrljYgxMDozNSwgVG9zaGlha2kgTWFraXRhIHdyb3RlOgo+IE9uIDIw
MTkvMDEvMjkgMTE6MjMsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIwMTkvMS8yOSDkuIrljYg4
OjQ1LCBUb3NoaWFraSBNYWtpdGEgd3JvdGU6Cj4gLi4uCj4+PiBAQCAtMjY2NiwxMCArMjY5Niwx
MCBAQCBzdGF0aWMgdm9pZCBmcmVlX3VudXNlZF9idWZzKHN0cnVjdAo+Pj4gdmlydG5ldF9pbmZv
ICp2aSkKPj4+ICDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJz
OyBpKyspIHsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZpcnRxdWV1ZSAqdnEgPSB2
aS0+c3FbaV0udnE7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlICgoYnVmID0gdmlydHF1
ZXVlX2RldGFjaF91bnVzZWRfYnVmKHZxKSkgIT0gTlVMTCkgewo+Pj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKCFpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZSh2aSwgaSkpCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoIWlzX3hkcF9mcmFtZShidWYpKQo+Pgo+PiBJIGJlbGlldmUg
dGhpcyBpcyB0aGUgbGFzdCB1c2VyIG9mIGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKCksIG1heWJl
IHlvdQo+PiBjYW4gc2VudCBhIHBhdGNoIG9uIHRvcCB0byByZW1vdmUgaXQuCj4gQWN0dWFsbHkg
cGF0Y2gyIGFkZGVkIG5ldyB1c2VycyBvZiBpdCA7KQoKClJpZ2h0LCBJIG1pc3NlZCB0aGF0LgoK
VGhhbmtzCgoKPgo+Pgo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X2tmcmVlX3NrYihidWYpOwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGRwX3JldHVybl9mcmFtZShidWYpOwo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZHBfcmV0dXJuX2ZyYW1lKHB0cl90
b194ZHAoYnVmKSk7Cj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+ICDCoMKgwqDCoMKgIH0K
Pj4+ICAgIAo+Pgo+PiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4K
Pj4KPiBUaGFua3MhCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

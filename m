From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] Discuss about an new idea "Vsock over Virtio-net"
Date: Thu, 15 Nov 2018 16:24:38 +0800
Message-ID: <61d57505-7ff6-23c6-d26c-6a0062e08445@redhat.com>
References: <5BECEE53.7090408@huawei.com>
	<20181115015547-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181115015547-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, jiangyiwen <jiangyiwen@huawei.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, stefanha@redhat.com, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvMTUg5LiL5Y2IMzowNCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFRodSwgTm92IDE1LCAyMDE4IGF0IDExOjU2OjAzQU0gKzA4MDAsIGppYW5neWl3ZW4gd3JvdGU6
Cj4+IEhpIFN0ZWZhbiwgTWljaGFlbCwgSmFzb24gYW5kIGV2ZXJ5b25lLAo+Pgo+PiBTZXZlcmFs
IGRheXMgYWdvLCBJIGRpc2N1c3NlZCB3aXRoIGphc29uIGFib3V0ICJWc29jayBvdmVyIFZpcnRp
by1uZXQiLgo+PiBUaGlzIGlkZWEgaGFzIHR3byBhZHZhbnRhZ2VzOgo+PiBGaXJzdCwgaXQgY2Fu
IHVzZSBtYW55IGdyZWF0IGZlYXR1cmVzIG9mIHZpcnRpby1uZXQsIGxpa2UgYmF0Y2hpbmcsCj4+
IG1lcmdlYWJsZSByeCBidWZmZXIgYW5kIG11bHRpcXVldWUsIGV0Yy4KPj4gU2Vjb25kLCBpdCBj
YW4gcmVkdWNlIG1hbnkgZHVwbGljYXRlIGNvZGVzIGFuZCBtYWtlIGl0IGVhc3kgdG8gYmUKPj4g
bWFpbnRhaW5lZC4KPiBJJ20gbm90IHN1cmUgSSBnZXQgdGhlIG1vdGl2YXRpb24uIFdoaWNoIGZl
YXR1cmVzIG9mCj4gdmlydGlvIG5ldCBhcmUgcmVsZXZhbnQgdG8gdnNvY2s/CgoKVnNvY2sgaXMg
anVzdCBhIEwyIChhbmQgYWJvdmUpIHByb3RvY29sIGZyb20gdGhlIHZpZXcgb2YgdGhlIGRldmlj
ZS4gU28gCkkgdGhpbmsgd2Ugc2hvdWxkIGFuc3dlciB0aGUgcXVlc3Rpb24gd2h5IHdlIG5lZWQg
dHdvIGRpZmZlcmVudCBwYXRocyAKZm9yIG5ldHdvcmtpbmcgdHJhZmZpYz8gT3Igd2hhdCBpcyB0
aGUgZnVuZGFtZW50YWwgcmVhc29uIHRoYXQgbWFrZXMgCnZzb2NrIGRvZXMgbm90IGdvIGZvciB2
aXJ0aW8tbmV0PwoKSSBhZ3JlZSB0aGV5IGNvdWxkIGJlIGRpZmZlcmVudCB0eXBlIG9mIGRldmlj
ZXMgYnV0IGNvZGVzIGNvdWxkIGJlIApzaGFyZWQgaW4gYm90aCBndWVzdCBhbmQgaG9zdCAob3Ig
ZXZlbiBxZW11KSBmb3Igbm90IGR1cGxpY2F0aW5nIApmZWF0dXJlcyhidWdzKS4KClRoYW5rcwoK
Cj4gVGhlIG9uZXMgdGhhdCB5b3UgbWVudGlvbgo+IGFsbCBzZWVtIHRvIGJlIG1vc3RseSBvZiB1
c2UgdG8gdGhlIG5ldHdvcmtpbmcgc3RhY2suCj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

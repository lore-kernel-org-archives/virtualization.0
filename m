From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/2] vhost: re-introducing metadata acceleration through
	kernel virtual address
Date: Fri, 6 Sep 2019 20:51:29 +0800
Message-ID: <cd2ed116-4b19-73b2-a3f0-4377cc0f2db3__8256.78137350536$1567774317$gmane$org@redhat.com>
References: <20190905122736.19768-1-jasowang@redhat.com>
	<20190906032154.9376-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190906032154.9376-1-hdanton@sina.com>
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
To: Hillf Danton <hdanton@sina.com>
Cc: aarcange@redhat.com, Christoph Hellwig <hch@infradead.org>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org, jglisse@redhat.com, jgg@mellanox.com, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS82IOS4iuWNiDExOjIxLCBIaWxsZiBEYW50b24gd3JvdGU6Cj4gT24gVGh1LCAg
NSBTZXAgMjAxOSAyMDoyNzozNiArMDgwMCBGcm9tOiAgIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4+ICtzdGF0aWMgdm9pZCB2aG9zdF9zZXRfbWFwX2RpcnR5KHN0cnVjdCB2aG9z
dF92aXJ0cXVldWUgKnZxLAo+PiArCQkJCXN0cnVjdCB2aG9zdF9tYXAgKm1hcCwgaW50IGluZGV4
KQo+PiArewo+PiArCXN0cnVjdCB2aG9zdF91YWRkciAqdWFkZHIgPSAmdnEtPnVhZGRyc1tpbmRl
eF07Cj4+ICsJaW50IGk7Cj4+ICsKPj4gKwlpZiAodWFkZHItPndyaXRlKSB7Cj4+ICsJCWZvciAo
aSA9IDA7IGkgPCBtYXAtPm5wYWdlczsgaSsrKQo+PiArCQkJc2V0X3BhZ2VfZGlydHkobWFwLT5w
YWdlc1tpXSk7Cj4+ICsJfQo+IE5vdCBzdXJlIG5lZWQgdG8gc2V0IHBhZ2UgZGlydHkgdW5kZXIg
cGFnZSBsb2NrLgoKCkp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgaXNzdWUuIERv
IHlvdSBtZWFuIHRoZXJlJ3Mgbm8gbmVlZCAKZm9yIHNldF9wYWdlX2RpcnR5KCkgaGVyZT8gSWYg
eWVzLCBpcyB0aGVyZSBhbnkgb3RoZXIgZnVuY3Rpb24gdGhhdCAKYWxyZWFkeSBkaWQgdGhpcz8K
ClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

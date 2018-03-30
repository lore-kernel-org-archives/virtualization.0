From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] vhost: validate log when IOTLB is enabled
Date: Fri, 30 Mar 2018 10:27:07 +0800
Message-ID: <a6d20da3-cebb-b672-ad4a-8e17083b7234@redhat.com>
References: <1522310404-8486-1-git-send-email-jasowang@redhat.com>
	<20180329173438-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180329173438-mutt-send-email-mst@kernel.org>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgyOeaXpSAyMjo0NCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9uIFRodSwgTWFyIDI5LCAyMDE4IGF0IDA0OjAwOjA0UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+IFZxIGxvZ19iYXNlIGlzIHRoZSB1c2Vyc3BhY2UgYWRkcmVzcyBvZiBiaXRtYXAgd2hp
Y2ggaGFzIG5vdGhpbmcgdG8gZG8KPj4gd2l0aCBJT1RMQi4gU28gaXQgbmVlZHMgdG8gYmUgdmFs
aWRhdGVkIHVuY29uZGl0aW9uYWxseSBvdGhlcndpc2Ugd2UKPj4gbWF5IHRyeSB1c2UgMCBhcyBs
b2dfYmFzZSB3aGljaCBtYXkgbGVhZCB0byBwaW4gcGFnZXMgdGhhdCB3aWxsIGxlYWQKPj4gdW5l
eHBlY3RlZCByZXN1bHQgKGUuZyB0cmlnZ2VyIEJVR19PTigpIGluIHNldF9iaXRfdG9fdXNlcigp
KS4KPj4KPj4gRml4ZXM6IDZiMWU2Y2M3ODU1YjAgKCJ2aG9zdDogbmV3IGRldmljZSBJT1RMQiBB
UEkiKQo+PiBSZXBvcnRlZC1ieTpzeXpib3QrNjMwNGJmOTdlZjQzNjU4MGZlZGVAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbQo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4gT25lIGZvbGxvdy11cCBxdWVzdGlvbjoKPgo+IFdlIHN0aWxsIG9ic2VydmUg
dGhhdCBnZXQgdXNlciBwYWdlcyByZXR1cm5zIDAgc29tZXRpbWVzLiBXaGlsZSBJIGFncmVlCj4g
d2Ugc2hvdWxkIG5vdCBwYXNzIGluIHVudmFsaWRhdGVkIGFkZHJlc3NlcywgaXNuJ3QgdGhpcyB3
b3J0aAo+IGRvY3VtZW50aW5nPwo+IAkKPgoKTG9va2luZyBhdCBnZXRfdXNlcl9wYWdlc19mYXN0
KCksIGl0IGhhczoKCiDCoMKgwqAgaWYgKHVubGlrZWx5KCFhY2Nlc3Nfb2sod3JpdGUgPyBWRVJJ
RllfV1JJVEUgOiBWRVJJRllfUkVBRCwKIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgKHZvaWQgX191c2VyICopc3RhcnQsIGxlbikpKQogwqDCoMKgIMKgwqDCoCByZXR1cm4gMDsK
ClNvIHRoaXMgaXMgZXhwZWN0ZWQgSSB0aGluay4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Fri, 11 May 2018 08:43:16 -0700
Message-ID: <9bbc5be8-71e2-5aab-ce18-32eb8a612f21@intel.com>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
	<1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
	<460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-Id: virtualization@lists.linuxfoundation.org

T24gNS83LzIwMTggMzozOSBQTSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IEhpLAo+Cj4gT24gMDUv
MDcvMjAxOCAwMzoxMCBQTSwgU3JpZGhhciBTYW11ZHJhbGEgd3JvdGU6Cj4+IFNpZ25lZC1vZmYt
Ynk6IFNyaWRoYXIgU2FtdWRyYWxhIDxzcmlkaGFyLnNhbXVkcmFsYUBpbnRlbC5jb20+Cj4+IC0t
LQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgIHwgICAgNyArCj4+ICAgaW5jbHVkZS9s
aW51eC9uZXRkZXZpY2UuaCAgfCAgIDE2ICsKPj4gICBpbmNsdWRlL25ldC9uZXRfZmFpbG92ZXIu
aCB8ICAgNTIgKysrCj4+ICAgbmV0L0tjb25maWcgICAgICAgICAgICAgICAgfCAgIDEwICsKPj4g
ICBuZXQvY29yZS9NYWtlZmlsZSAgICAgICAgICB8ICAgIDEgKwo+PiAgIG5ldC9jb3JlL25ldF9m
YWlsb3Zlci5jICAgIHwgMTA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwo+PiAgIDYgZmlsZXMgY2hhbmdlZCwgMTEzMCBpbnNlcnRpb25zKCspCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbmV0L25ldF9mYWlsb3Zlci5oCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IG5ldC9jb3JlL25ldF9mYWlsb3Zlci5jCj4KPj4gZGlmZiAtLWdpdCBhL25ldC9L
Y29uZmlnIGIvbmV0L0tjb25maWcKPj4gaW5kZXggYjYyMDg5ZmIxMzMyLi4wNTQwODU2Njc2ZGUg
MTAwNjQ0Cj4+IC0tLSBhL25ldC9LY29uZmlnCj4+ICsrKyBiL25ldC9LY29uZmlnCj4+IEBAIC00
MjksNiArNDI5LDE2IEBAIGNvbmZpZyBNQVlfVVNFX0RFVkxJTksKPj4gICBjb25maWcgUEFHRV9Q
T09MCj4+ICAgICAgICAgIGJvb2wKPj4gICAKPj4gK2NvbmZpZyBORVRfRkFJTE9WRVIKPj4gKwl0
cmlzdGF0ZSAiRmFpbG92ZXIgaW50ZXJmYWNlIgo+PiArCWRlZmF1bHQgbQo+IE5lZWQgc29tZSBq
dXN0aWZpY2F0aW9uIGZvciBkZWZhdWx0IG0gKGFzIG9wcG9zZWQgdG8gbikuCgpkZWZhdWx0IG4g
c2hvdWxkIGJlIGZpbmUuwqAgSXQgd2lsbCBnZXQgc2VsZWN0ZWQgYXV0b21hdGljYWxseSB3aGVu
IHZpcnRpb19uZXQgb3IKbmV0dnNjIGFyZSBlbmFibGVkLiB3aWxsIGZpeCBpbiB0aGUgbmV4dCBy
ZXZpc2lvbi4KCgo+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

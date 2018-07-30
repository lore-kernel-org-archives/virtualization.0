From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/2] tools/virtio: add dma barrier stubs
Date: Mon, 30 Jul 2018 15:28:01 +0800
Message-ID: <066294db-82d6-9b7c-14ac-d64428b3a15a@redhat.com>
References: <20180725134057.113423-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180725134057.113423-1-mst@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, khandual@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDfmnIgyNeaXpSAyMTo0NSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IEZpeGVzOiA1NWU0OWRjNDNhOCAoInZpcnRpb19yaW5nOiBzd2l0Y2ggdG8gZG1hX1hYIGJhcnJp
ZXJzIGZvciBycG1zZyIpCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4KPiAtLS0KPiAgIHRvb2xzL3ZpcnRpby9hc20vYmFycmllci5oIHwgNCArKy0t
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpby9hc20vYmFycmllci5oIGIvdG9vbHMvdmlydGlvL2Fz
bS9iYXJyaWVyLmgKPiBpbmRleCAwYWMzY2FmOTA4NzcuLmQwMzUxZjgzYWViZSAxMDA2NDQKPiAt
LS0gYS90b29scy92aXJ0aW8vYXNtL2JhcnJpZXIuaAo+ICsrKyBiL3Rvb2xzL3ZpcnRpby9hc20v
YmFycmllci5oCj4gQEAgLTEzLDggKzEzLDggQEAKPiAgIH0gd2hpbGUgKDApOwo+ICAgLyogV2Vh
ayBiYXJyaWVycyBzaG91bGQgYmUgdXNlZC4gSWYgbm90IC0gaXQncyBhIGJ1ZyAqLwo+ICAgIyBk
ZWZpbmUgbWIoKSBhYm9ydCgpCj4gLSMgZGVmaW5lIHJtYigpIGFib3J0KCkKPiAtIyBkZWZpbmUg
d21iKCkgYWJvcnQoKQo+ICsjIGRlZmluZSBkbWFfcm1iKCkgYWJvcnQoKQo+ICsjIGRlZmluZSBk
bWFfd21iKCkgYWJvcnQoKQo+ICAgI2Vsc2UKPiAgICNlcnJvciBQbGVhc2UgZmlsbCBpbiBiYXJy
aWVyIG1hY3Jvcwo+ICAgI2VuZGlmCgpSZXZpZXdlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 12/12] tools/virtio: fix smp_mb on x86
Date: Fri, 26 Jan 2018 11:56:14 +0800
Message-ID: <f2581b9f-9e0d-4db5-ee9d-a235bb0a1842@redhat.com>
References: <1516923320-16959-1-git-send-email-mst@redhat.com>
	<1516923320-16959-16-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1516923320-16959-16-git-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDHmnIgyNuaXpSAwNzozNiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IE9mZnNldCAxMjggb3ZlcmxhcHMgdGhlIGxhc3Qgd29yZCBvZiB0aGUgcmVkem9uZS4KPiBVc2Ug
MTMyIHdoaWNoIGlzIGFsd2F5cyBiZXlvbmQgdGhhdC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gLS0tCj4gICB0b29scy92aXJ0aW8vcmlu
Z3Rlc3QvbWFpbi5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdmlydGlvL3Jpbmd0ZXN0L21haW4u
aCBiL3Rvb2xzL3ZpcnRpby9yaW5ndGVzdC9tYWluLmgKPiBpbmRleCA1OTNhMzI4Li4zMDFkNTli
IDEwMDY0NAo+IC0tLSBhL3Rvb2xzL3ZpcnRpby9yaW5ndGVzdC9tYWluLmgKPiArKysgYi90b29s
cy92aXJ0aW8vcmluZ3Rlc3QvbWFpbi5oCj4gQEAgLTExMSw3ICsxMTEsNyBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgYnVzeV93YWl0KHZvaWQpCj4gICB9Cj4gICAKPiAgICNpZiBkZWZpbmVkKF9feDg2
XzY0X18pIHx8IGRlZmluZWQoX19pMzg2X18pCj4gLSNkZWZpbmUgc21wX21iKCkgICAgIGFzbSB2
b2xhdGlsZSgibG9jazsgYWRkbCAkMCwtMTI4KCUlcnNwKSIgOjo6ICJtZW1vcnkiLCAiY2MiKQoK
SnVzdCB3b25kZXIgZGlkICJyc3AiIHdvcmsgZm9yIF9faTM4Nl9fID8KClRoYW5rcwoKPiArI2Rl
ZmluZSBzbXBfbWIoKSAgICAgYXNtIHZvbGF0aWxlKCJsb2NrOyBhZGRsICQwLC0xMzIoJSVyc3Ap
IiA6OjogIm1lbW9yeSIsICJjYyIpCj4gICAjZWxzZQo+ICAgLyoKPiAgICAqIE5vdCB1c2luZyBf
X0FUT01JQ19TRVFfQ1NUIHNpbmNlIGdjYyBkb2NzIHNheSB0aGV5IGFyZSBvbmx5IHN5bmNocm9u
aXplZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 02/10] drm/virtio: fix endianness in primary_plane_update
Date: Wed, 7 Dec 2016 12:13:13 +0800
Message-ID: <eea5a9fd-dde0-d9b2-735f-5db4ae4af947@redhat.com>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
	<1481038106-24899-3-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481038106-24899-3-git-send-email-mst@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE25bm0MTLmnIgwNuaXpSAyMzo0MCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
IHZpcnRpb19ncHVfY21kX3RyYW5zZmVyX3RvX2hvc3RfMmQgZXhwZWN0cyB4IGFuZCB5Cj4gcGFy
YW1ldGVycyBpbiBMRSwgYnV0IHZpcnRpb19ncHVfcHJpbWFyeV9wbGFuZV91cGRhdGUKPiBwYXNz
ZXMgaW4gdGhlIENQVSBmb3JtYXQgaW5zdGVhZC4KPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwg
Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vdmly
dGlvL3ZpcnRncHVfcGxhbmUuYyB8IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKClJldmlld2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgoKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3Zp
cnRncHVfcGxhbmUuYyBiL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9wbGFuZS5jCj4g
aW5kZXggYmEyOGMwZi4uMWZkYTk2NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdmly
dGlvL3ZpcnRncHVfcGxhbmUuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdw
dV9wbGFuZS5jCj4gQEAgLTg4LDggKzg4LDggQEAgc3RhdGljIHZvaWQgdmlydGlvX2dwdV9wcmlt
YXJ5X3BsYW5lX3VwZGF0ZShzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwKPiAgIAkJCQkodmdkZXYs
IGhhbmRsZSwgMCwKPiAgIAkJCQkgY3B1X3RvX2xlMzIocGxhbmUtPnN0YXRlLT5zcmNfdyA+PiAx
NiksCj4gICAJCQkJIGNwdV90b19sZTMyKHBsYW5lLT5zdGF0ZS0+c3JjX2ggPj4gMTYpLAo+IC0J
CQkJIHBsYW5lLT5zdGF0ZS0+c3JjX3ggPj4gMTYsCj4gLQkJCQkgcGxhbmUtPnN0YXRlLT5zcmNf
eSA+PiAxNiwgTlVMTCk7Cj4gKwkJCQkgY3B1X3RvX2xlMzIocGxhbmUtPnN0YXRlLT5zcmNfeCA+
PiAxNiksCj4gKwkJCQkgY3B1X3RvX2xlMzIocGxhbmUtPnN0YXRlLT5zcmNfeSA+PiAxNiksIE5V
TEwpOwo+ICAgCQl9Cj4gICAJfSBlbHNlIHsKPiAgIAkJaGFuZGxlID0gMDsKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==

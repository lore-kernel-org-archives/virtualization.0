From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 04/10] drm/virtio: annotate
	virtio_gpu_queue_ctrl_buffer_locked
Date: Wed, 7 Dec 2016 12:15:44 +0800
Message-ID: <708d9c01-5a59-3d78-37c4-7cb848b50f3a@redhat.com>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
	<1481038106-24899-5-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481038106-24899-5-git-send-email-mst@redhat.com>
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
IHZpcnRpb19ncHVfcXVldWVfY3RybF9idWZmZXJfbG9ja2VkIGlzIGNhbGxlZCB3aXRoIGN0cmxx
LnFsb2NrIHRha2VuLCBpdAo+IHJlbGVhc2VzIGFuZCBhY3F1aXJlcyB0aGlzIGxvY2suICBUaGlz
IGNhdXNlcyBhIHNwYXJzZSB3YXJuaW5nLiAgQWRkCj4gYXBwcm9wcmlhdGUgYW5ub3RhdGlvbnMg
Zm9yIHNwYXJzZSBjb250ZXh0IGNoZWNraW5nLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS92aXJ0
aW8vdmlydGdwdV92cS5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV92cS5jIGIv
ZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3ZxLmMKPiBpbmRleCAyZjBjMmY5Li5hNmUy
Y2U0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV92cS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X3ZxLmMKPiBAQCAtMjk3LDYgKzI5
Nyw4IEBAIHZvaWQgdmlydGlvX2dwdV9kZXF1ZXVlX2N1cnNvcl9mdW5jKHN0cnVjdCB3b3JrX3N0
cnVjdCAqd29yaykKPiAgIAo+ICAgc3RhdGljIGludCB2aXJ0aW9fZ3B1X3F1ZXVlX2N0cmxfYnVm
ZmVyX2xvY2tlZChzdHJ1Y3QgdmlydGlvX2dwdV9kZXZpY2UgKnZnZGV2LAo+ICAgCQkJCQkgICAg
ICAgc3RydWN0IHZpcnRpb19ncHVfdmJ1ZmZlciAqdmJ1ZikKPiArCQlfX3JlbGVhc2VzKCZ2Z2Rl
di0+Y3RybHEucWxvY2spCj4gKwkJX19hY3F1aXJlcygmdmdkZXYtPmN0cmxxLnFsb2NrKQo+ICAg
ewo+ICAgCXN0cnVjdCB2aXJ0cXVldWUgKnZxID0gdmdkZXYtPmN0cmxxLnZxOwo+ICAgCXN0cnVj
dCBzY2F0dGVybGlzdCAqc2dzWzNdLCB2Y21kLCB2b3V0LCB2cmVzcDsKClJldmlld2VkLWJ5OiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

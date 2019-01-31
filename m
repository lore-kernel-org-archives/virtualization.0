From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 1/6] drm/virtio: move virtio_gpu_object_{attach,
	detach} calls.
Date: Thu, 31 Jan 2019 11:34:26 +0100
Message-ID: <355f535c-8a5f-f3e8-f715-66ddcc52da5f__42704.8147468426$1548967456$gmane$org@tronnes.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-2-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190130094338.14203-2-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMzAuMDEuMjAxOSAxMC40Mywgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBEcm9wIHRoZSBk
dW1teSB0dG0gYmFja2VuZCBpbXBsZW1lbnRhdGlvbiwgYWRkIGEgcmVhbCBvbmUgZm9yCj4gVFRN
X1BMX0ZMQUdfVFQgb2JqZWN0cy4gIFRoZSBiaW4vdW5iaW5kIGNhbGxiYWNrcyB3aWxsIGNhbGwK
PiB2aXJ0aW9fZ3B1X29iamVjdF97YXR0YWNoLGRldGFjaH0sIHRvIHVwZGF0ZSB0aGUgb2JqZWN0
IHN0YXRlCj4gb24gdGhlIGhvc3Qgc2lkZSwgaW5zdGVhZCBvZiBpbnZva2luZyB0aG9zZSBjYWxs
cyBmcm9tIHRoZQo+IG1vdmVfbm90aWZ5KCkgY2FsbGJhY2suCj4gCj4gV2l0aCB0aGF0IGluIHBs
YWNlIHRoZSBtb3ZlIGFuZCBtb3ZlX25vdGlmeSBjYWxsYmFja3MgYXJlIG5vdAo+IG5lZWRlZCBh
bnkgbW9yZSwgc28gZHJvcCB0aGVtLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4g
PGtyYXhlbEByZWRoYXQuY29tPgo+IC0tLQoKQWNrZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9y
YWxmQHRyb25uZXMub3JnPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

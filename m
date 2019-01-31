From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v2 6/6] drm/virtio: move virtio_gpu_cmd_create_resource
	call into virtio_gpu_object_create
Date: Thu, 31 Jan 2019 11:53:47 +0100
Message-ID: <eff1a43e-a3ed-3c12-229c-61c450b31e86__20321.9411125005$1548967543$gmane$org@tronnes.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
	<20190130094338.14203-7-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190130094338.14203-7-kraxel@redhat.com>
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

CgpEZW4gMzAuMDEuMjAxOSAxMC40Mywgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBTcGVjaWZpY2Fs
bHkgY2FsbCB2aXJ0aW9fZ3B1X29iamVjdF9jcmVhdGUoKSBiZWZvcmUgdHRtX2JvX2luaXQoKSwg
c28KPiB0aGUgb2JqZWN0IGlzIGFscmVhZHkgY3JlYXRlZCB3aGVuIHR0bSBjYWxscyB0aGUKPiB2
aXJ0aW9fZ3B1X3R0bV90dF9iaW5kKCkgY2FsbGJhY2sgKHdoaWNoIGluIHR1cm4gY2FsbHMKPiB2
aXJ0aW9fZ3B1X29iamVjdF9hdHRhY2goKSkuCj4gCj4gV2l0aCB0aGF0IGluIHBsYWNlIHZpcnRp
b19ncHVfb2JqZWN0X2F0dGFjaCgpIHdpbGwgbmV2ZXIgYmUgY2FsbGVkIHdpdGgKPiBhbiBvYmpl
Y3Qgd2hpY2ggaXMgbm90IHlldCBjcmVhdGVkLCBzbyB0aGUgZXh0cmEKPiB2aXJ0aW9fZ3B1X29i
amVjdF9hdHRhY2goKSBjYWxscyBkb25lIGFmdGVyCj4gdmlydGlvX2dwdV9jbWRfY3JlYXRlX3Jl
c291cmNlKCkgaXMgbm90IG5lZWRlZCBhbnkgbW9yZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHZXJk
IEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KPiAtLS0KCkFja2VkLWJ5OiBOb3JhbGYgVHLD
uG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

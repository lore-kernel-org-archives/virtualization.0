From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 2/5] drm/virtio: use struct to pass params to
	virtio_gpu_object_create()
Date: Wed, 27 Mar 2019 15:35:17 +0100
Message-ID: <7582e919-48a1-61cf-b697-804213776fbe__28826.4855554857$1553697332$gmane$org@tronnes.org>
References: <20190318113332.10900-1-kraxel@redhat.com>
	<20190318113332.10900-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190318113332.10900-3-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMTguMDMuMjAxOSAxMi4zMywgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBDcmVhdGUgdmly
dGlvX2dwdV9vYmplY3RfcGFyYW1zLCB1c2UgdGhhdCB0byBwYXNzIG9iamVjdCBwYXJhbWV0ZXJz
IHRvCj4gdmlydGlvX2dwdV9vYmplY3RfY3JlYXRlLiAgVGhpcyBpcyBqdXN0IHRoZSBmaXJzdCBz
dGVwLCBmb2xsb3d1cCBwYXRjaGVzCj4gd2lsbCBhZGQgbW9yZSBwYXJhbWV0ZXJzIHRvIHRoZSBz
dHJ1Y3QuICBUaGUgcGxhbiBpcyB0byB1c2UgdGhlIHN0cnVjdAo+IGZvciBhbGwgb2JqZWN0IHBh
cmFtZXRlcnMuCj4gCj4gRHJvcCB1bnVzZWQgImtlcm5lbCIgcGFyYW1ldGVyIGZvciB2aXJ0aW9f
Z3B1X2FsbG9jX29iamVjdCgpLCBpdCBpcwo+IHVudXNlZCBhbmQgYWx3YXlzIGZhbHNlLgo+IAo+
IEFsc28gZHJvcCAicGlubmVkIiBwYXJhbWV0ZXIuICB2aXJ0aW8tZ3B1IGRvZXNuJ3Qgc2h1ZmZs
ZSBhcm91bmQKPiBvYmplY3RzLCBzbyBlZmZlY2l2ZWx5IHRoZXkgYWxsIGFyZSBwaW5uZWQgYW55
d2F5LiAgSGFyZGNvZGUKPiBUVE1fUExfRkxBR19OT19FVklDVCBzbyB0dG0ga25vd3MuICBEb2Vz
bid0IGNoYW5nZSBtdWNoIGZvciB0aGUgbW9tZW50Cj4gYXMgdmlydGlvLWdwdSBzdXBwb3J0cyBU
VE1fUExfRkxBR19UVCBvbmx5IHNvIHRoZXJlIGlzIG5vIG9wcG9ydHVuaXR5IHRvCj4gbW92ZSBh
cm91bmQgb2JqZWN0cy4gIFRoYXQnbGwgcHJvYmFibHkgY2hhbmdlIGluIHRoZSBmdXR1cmUgdGhv
dWdoLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29t
Pgo+IC0tLQoKQWNrZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=

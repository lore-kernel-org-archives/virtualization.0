From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 07/23] drm/qxl: allow both PRIV and VRAM placement for
	QXL_GEM_DOMAIN_SURFACE
Date: Fri, 25 Jan 2019 16:58:17 +0100
Message-ID: <b02d7064-4a5d-057e-5342-e60688e8afbd__7756.29743454687$1548442413$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-8-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBxeGwgc3VyZmFj
ZXMgKHVzZWQgZm9yIGZyYW1lYnVmZmVycyBhbmQgZ2VtIG9iamVjdHMpIGNhbiBsaXZlIGluIGJv
dGgKPiBWUkFNIGFuZCBQUklWIHR0bSBkb21haW5zLiAgVXBkYXRlIHBsYWNlbWVudCBzZXR1cCB0
byBpbmNsdWRlIGJvdGguCj4gUHV0IFBSSVYgZmlyc3QgaW4gdGhlIGxpc3Qgc28gaXQgaXMgcHJl
ZmVycmVkLCBzbyBWUkFNIHdpbGwgaGF2ZSBtb3JlCj4gcm9vbSBmb3Igb2JqZWN0cyB3aGljaCBt
dXN0IGJlIGFsbG9jYXRlZCB0aGVyZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5u
IDxrcmF4ZWxAcmVkaGF0LmNvbT4KPiAtLS0KCkFja2VkLWJ5OiBOb3JhbGYgVHLDuG5uZXMgPG5v
cmFsZkB0cm9ubmVzLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

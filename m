From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH 4/5] drm/bochs: Use shadow buffer for bochs framebuffer
	console
Date: Wed, 3 Jul 2019 16:21:36 +0200
Message-ID: <e401d084-3a13-701e-3f46-e59e66b6cceb__26018.2211104379$1562163817$gmane$org@tronnes.org>
References: <20190703083302.2609-1-tzimmermann@suse.de>
	<20190703083302.2609-5-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190703083302.2609-5-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CgpEZW4gMDMuMDcuMjAxOSAxMC4zMywgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gVGhlIGJv
Y2hzIGRyaXZlciAoYW5kIHZpcnR1YWwgaGFyZHdhcmUpIHJlcXVpcmVzIGJ1ZmZlciBvYmplY3Rz
IHRvCj4gcmVzaWRlIGluIHZpZGVvIHJhbSB0byBkaXNwbGF5IHRoZW0gdG8gdGhlIHNjcmVlbi4g
U28gaXQgY2FuIG5vdAo+IGRpc3BsYXkgdGhlIGZyYW1lYnVmZmVyIGNvbnNvbGUgYmVjYXVzZSB0
aGUgcmVzcGVjdGl2ZSBidWZmZXIgb2JqZWN0Cj4gaXMgcGVybWFuZW50bHkgcGlubmVkIGluIHN5
c3RlbSBtZW1vcnkuCj4gCj4gVXNpbmcgYSBzaGFkb3cgYnVmZmVyIGZvciB0aGUgY29uc29sZSBz
b2x2ZXMgdGhpcyBwcm9ibGVtLiBUaGUgY29uc29sZQo+IGVtdWxhdGlvbiB3aWxsIHBpbiB0aGUg
YnVmZmVyIG9iamVjdCBvbmx5IGR1cmluZyB1cGRhdGVzIGZyb20gdGhlIHNoYWRvdwo+IGJ1ZmZl
ci4gT3RoZXJ3aXNlLCB0aGUgYm9jaHMgZHJpdmVyIGNhbiBmcmVlbHkgcmVsb2NhdGVkIHRoZSBi
dWZmZXIKPiBiZXR3ZWVuIHN5c3RlbSBtZW1vcnkgYW5kIHZpZGVvIHJhbS4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KPiAtLS0KCkFj
a2VkLWJ5OiBOb3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

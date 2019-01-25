From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 12/23] drm/qxl: track primary bo
Date: Fri, 25 Jan 2019 17:11:18 +0100
Message-ID: <c0af8755-6d9d-5bbe-609d-ab93eb75e31e__7901.21702464006$1548442015$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-13-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-13-kraxel@redhat.com>
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

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBUcmFjayB3aGlj
aCBibyBpcyB1c2VkIGFzIHByaW1hcnkgc3VyZmFjZS4gIFdpdGggdGhhdCBpbiBwbGFjZSB3ZSBk
b24ndAo+IG5lZWQgdGhlIHByaW1hcnlfY3JlYXRlZCBmbGFnIGFueSBtb3JlLCB3ZSBjYW4ganVz
dCBjaGVjayB0aGUgcHJpbWFyeSBibwo+IHBvaW50ZXIgaW5zdGVhZC4KPiAKPiBBbHNvIHZlcmlm
eSB3ZSBkb24ndCBhbHJlYWR5IGhhdmUgYSBwcmltYXJ5IHN1cmZhY2UgaW4KPiBxeGxfaW9fY3Jl
YXRlX3ByaW1hcnkoKS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxA
cmVkaGF0LmNvbT4KPiAtLS0KCkFja2VkLWJ5OiBOb3JhbGYgVHLDuG5uZXMgPG5vcmFsZkB0cm9u
bmVzLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

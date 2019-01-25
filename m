From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 13/23] drm/qxl: use shadow bo directly
Date: Fri, 25 Jan 2019 17:59:13 +0100
Message-ID: <709f738a-308b-90f2-2cc0-698db4e25068__29840.7895885006$1548442106$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-14-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-14-kraxel@redhat.com>
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

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBQYXNzIHRoZSBz
aGFkb3cgYm8gdG8gcXhsX2lvX2NyZWF0ZV9wcmltYXJ5KCkgaW5zdGVhZCBvZiBleHBlY3RpbmcK
PiBxeGxfaW9fY3JlYXRlX3ByaW1hcnkgdG8gY2hlY2sgYm8tPnNoYWRvdy4gIFNldCBpc19wcmlt
YXJ5IGZsYWcgb24gdGhlCj4gc2hhZG93IGJvLiAgTW92ZSB0aGUgaXNfcHJpbWFyeSB0cmFja2lu
ZyBpbnRvIHF4bF9pb19jcmVhdGVfcHJpbWFyeSgpCj4gYW5kIHF4bF9pb19kZXN0cm95X3ByaW1h
cnkoKSBmdW5jdGlvbnMuCj4gCj4gVGhhdCBzaW1wbGlmaWVzIHByaW1hcnkgc3VyZmFjZSB0cmFj
a2luZyBhbmQgdGhlIHdvcmtmbG93IGluCj4gcXhsX3ByaW1hcnlfYXRvbWljX3VwZGF0ZSgpLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgo+IAo+
IHF4bF9pb19jcmVhdGUvZGVzdHJveV9wcmltYXJ5OiBwcmltYXJ5X2JvIHRyYWNraW5nIFtmaXh1
cF0KPiAtLS0KCkknbSB1bmFibGUgdG8gZm9sbG93IHRoZSBsb2dpYywgYnV0IEkgZGlkbid0IHNw
b3QgYW55dGhpbmcgc3VzcGljaW91cwpsb29raW5nLgoKQWNrZWQtYnk6IE5vcmFsZiBUcsO4bm5l
cyA8bm9yYWxmQHRyb25uZXMub3JnPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

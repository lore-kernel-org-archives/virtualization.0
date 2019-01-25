From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 15/23] drm/qxl: use qxl_num_crtc directly
Date: Fri, 25 Jan 2019 18:12:50 +0100
Message-ID: <32b84914-7ccc-42fe-cc2f-a012e389e61a__2768.66500951058$1548442134$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-16-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-16-kraxel@redhat.com>
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

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBxZGV2LT5tb25p
dG9yc19jb25maWctPm1heF9hbGxvd2VkIGlzIGVmZmVjdGl2ZWx5IHNldCBieSB0aGUKPiBxeGwu
bnVtX2hlYWRzIG1vZHVsZSBwYXJhbWV0ZXIsIHN0b3JlZCBpbiB0aGUgcXhsX251bV9jcnRjIHZh
cmlhYmxlLgo+IExldHMgZ2V0IHJpZCBvZiB0aGUgaW5kaXJlY3Rpb24gYW5kIHVzZSB0aGUgdmFy
aWFibGUgcXhsX251bV9jcnRjCj4gZGlyZWN0bHkuICBUaGUga2VybmVsIGRvZXNuJ3QgbmVlZCB0
byBkZXJlZmVyZW5jZSBwb2ludGVycyBlYWNoIHRpbWUgaXQKPiBuZWVkcyB0aGUgdmFsdWUsIGFu
ZCB3aGVuIHJlYWRpbmcgdGhlIGNvZGUgeW91IGRvbid0IGhhdmUgdG8gdHJhY2Ugd2hlcmUKPiBh
bmQgd2h5IHFkZXYtPm1vbml0b3JzX2NvbmZpZy0+bWF4X2FsbG93ZWQgaXMgc2V0Lgo+IAo+IFNp
Z25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgo+IC0tLQoKQWNr
ZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

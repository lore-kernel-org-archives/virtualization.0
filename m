From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 09/23] drm/qxl: use QXL_GEM_DOMAIN_SURFACE for dumb gem
	objects
Date: Fri, 25 Jan 2019 16:59:12 +0100
Message-ID: <4c01f764-618c-b7de-3121-56adb2d909b0__22776.2109761656$1548442441$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-10-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-10-kraxel@redhat.com>
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

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBkdW1iIGJ1ZmZl
cnMgYXJlIHVzZWQgYXMgcXhsIHN1cmZhY2VzLCBzbyBhbGxvY2F0ZSB0aGVtIGFzCj4gUVhMX0dF
TV9ET01BSU5fU1VSRkFDRS4gIFNob3VsZCB1c3VhbGx5IGJlIGFsbG9jYXRlZCBpbgo+IFBSSVYg
dHRtIGRvbWFpbiB0aGVuLCBzbyB0aGlzIHJlZHVjZXMgVlJBTSBtZW1vcnkgcHJlc3N1cmUuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+Cj4gLS0t
CgpBY2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

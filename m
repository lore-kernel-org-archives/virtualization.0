From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 06/23] drm/qxl: use separate offset spaces for the two
	slots / ttm memory types.
Date: Fri, 25 Jan 2019 16:57:16 +0100
Message-ID: <80a3d205-78d2-f723-e452-b56c01a73b34__40110.8154723019$1548442401$gmane$org@tronnes.org>
References: <20190118122020.27596-1-kraxel@redhat.com>
	<20190118122020.27596-7-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-7-kraxel@redhat.com>
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

CgpEZW4gMTguMDEuMjAxOSAxMy4yMCwgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBXaXRob3V0IHRo
YXQgdHRtIG9mZnNldHMgYXJlIG5vdCB1bmlxdWUsIHRoZXkgY2FuIHJlZmVyIHRvIG9iamVjdHMK
PiBpbiBib3RoIFZSQU0gYW5kIFBSSVYgbWVtb3J5IChha2EgbWFpbiBhbmQgc3VyZmFjZXMgc2xv
dCkuCj4gCj4gT25lIG9mIHRob3NlICJ3aHkgdGhpbmdzIGRpZG4ndCBibG93IHVwIHdpdGhvdXQg
dGhpcyIgbW9tZW50cy4KPiBQcm9iYWJseSBvZmZzZXQgY29uZmxpY3RzIGFyZSByYXJlIGVub3Vn
aCBieSBwdXJlIGx1Y2suCj4gCj4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVs
QHJlZGhhdC5jb20+Cj4gLS0tCgpBY2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJv
bm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==

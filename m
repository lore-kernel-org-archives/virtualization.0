From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: Complete exception handling in qxl_device_init()
Date: Fri, 29 Nov 2019 13:24:54 +0100
Message-ID: <20191129122454.2xoi43kaowmqppm5@sirius.home.kraxel.org>
References: <5e5ef9c4-4d85-3c93-cf28-42cfcb5b0649@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5e5ef9c4-4d85-3c93-cf28-42cfcb5b0649@web.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: David Airlie <airlied@linux.ie>, Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Navid Emamdoost <emamd001@umn.edu>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, spice-devel@lists.freedesktop.org, Anton Vasilyev <vasilyev@ispras.ru>
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDY6MTg6MTRQTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2Uu
bmV0Pgo+IERhdGU6IFRodSwgNyBOb3YgMjAxOSAxODowNTowOCArMDEwMAo+IAo+IEEgY29jY2lj
aGVjayBydW4gcHJvdmlkZWQgaW5mb3JtYXRpb24gbGlrZSB0aGUgZm9sbG93aW5nLgo+IAo+IGRy
aXZlcnMvZ3B1L2RybS9xeGwvcXhsX2ttcy5jOjI5NToxLTc6IEVSUk9SOiBtaXNzaW5nIGlvdW5t
YXA7Cj4gaW9yZW1hcCBvbiBsaW5lIDE3OCBhbmQgZXhlY3V0aW9uIHZpYSBjb25kaXRpb25hbCBv
biBsaW5lIDE4NQo+IAo+IEdlbmVyYXRlZCBieTogc2NyaXB0cy9jb2NjaW5lbGxlL2ZyZWUvaW91
bm1hcC5jb2NjaQo+IAo+IEEganVtcCB0YXJnZXQgd2FzIHNwZWNpZmllZCBpbiBhbiBpZiBicmFu
Y2guIFRoZSBjb3JyZXNwb25kaW5nIGZ1bmN0aW9uCj4gY2FsbCBkaWQgbm90IHJlbGVhc2UgdGhl
IGRlc2lyZWQgc3lzdGVtIHJlc291cmNlIHRoZW4uCj4gVGh1cyB1c2UgdGhlIGxhYmVsIOKAnHJv
bV91bm1hcOKAnSBpbnN0ZWFkIHRvIGZpeCB0aGUgZXhjZXB0aW9uIGhhbmRsaW5nCj4gZm9yIHRo
aXMgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24uCj4gCj4gRml4ZXM6IDUwNDMzNDhhNDk2OWFlMTY2
MWMwMDhlZmU5MjlhYmQwZDc2ZTM3OTIgKCJkcm06IHF4bDogRml4IGVycm9yIGhhbmRsaW5nIGF0
IHF4bF9kZXZpY2VfaW5pdCIpCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEVsZnJpbmcgPGVsZnJp
bmdAdXNlcnMuc291cmNlZm9yZ2UubmV0PgoKUHVzaGVkIHRvIGRybS1taXNjLW5leHQuCgp0aGFu
a3MsCiAgR2VyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

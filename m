From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v3 5/5] drm/virtio: rework resource creation workflow.
Date: Wed, 27 Mar 2019 15:41:20 +0100
Message-ID: <4561a2be-cc58-9e87-2a60-7d05a7e6f6df__41889.1525290505$1553697693$gmane$org@tronnes.org>
References: <20190318113332.10900-1-kraxel@redhat.com>
	<20190318113332.10900-6-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190318113332.10900-6-kraxel@redhat.com>
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

CgpEZW4gMTguMDMuMjAxOSAxMi4zMywgc2tyZXYgR2VyZCBIb2ZmbWFubjoKPiBUaGlzIHBhdGNo
IG1vdmVzIHRoZSB2aXJ0aW9fZ3B1X2NtZF9jcmVhdGVfcmVzb3VyY2UoKSBjYWxsICh3aGljaAo+
IG5vdGlmaWVzIHRoZSBob3N0IGFib3V0IHRoZSBuZXcgcmVzb3VyY2UgY3JlYXRlZCkgaW50byB0
aGUKPiB2aXJ0aW9fZ3B1X29iamVjdF9jcmVhdGUoKSBmdW5jdGlvbi4gIFRoYXQgd2F5IHdlIGNh
biBjYWxsCj4gdmlydGlvX2dwdV9jbWRfY3JlYXRlX3Jlc291cmNlKCkgYmVmb3JlIHR0bV9ib19p
bml0KCksIHNvIHRoZSBob3N0Cj4gYWxyZWFkeSBrbm93cyBhYm91dCB0aGUgb2JqZWN0IHdoZW4g
dHRtIGluaXRpYWxpemVzIHRoZSBvYmplY3QgYW5kIGNhbGxzCj4gb3VyIGRyaXZlciBjYWxsYmFj
a3MuCj4gCj4gU3BlY2lmaWNhbGx5IHRoZSBvYmplY3QgaXMgYWxyZWFkeSBjcmVhdGVkIHdoZW4g
dGhlCj4gdmlydGlvX2dwdV90dG1fdHRfYmluZCgpIGNhbGxiYWNrIGludm9rZXMgdmlydGlvX2dw
dV9vYmplY3RfYXR0YWNoKCksCj4gc28gdGhlIGV4dHJhIHZpcnRpb19ncHVfb2JqZWN0X2F0dGFj
aCgpIGNhbGxzIGRvbmUgYWZ0ZXIKPiB2aXJ0aW9fZ3B1X29iamVjdF9jcmVhdGUoKSBhcmUgbm90
IG5lZWRlZCBhbnkgbW9yZS4KPiAKPiBUaGUgZmVuY2Ugc3VwcG9ydCBmb3IgdGhlIGNyZWF0ZSBp
b2N0bCBiZWNvbWVzIGEgYml0IG1vcmUgdHJpY2t5IHRob3VnaC4KPiBUaGUgY29kZSBtb3ZlZCBp
bnRvIHZpcnRpb19ncHVfb2JqZWN0X2NyZWF0ZSgpIHRvby4gIFdlIGZpcnN0IHN1Ym1pdCB0aGUK
PiAoZmVuY2VkKSB2aXJ0aW9fZ3B1X2NtZF9jcmVhdGVfcmVzb3VyY2UoKSBjb21tYW5kLCB0aGVu
IGluaXRpYWxpemUgdGhlCj4gdHRtIG9iamVjdCwgYW5kIGZpbmFsbHkgYXR0YWNoIGp1c3QgY3Jl
YXRlZCBvYmplY3QgdG8gdGhlIGZlbmNlIGZvciB0aGUKPiBjb21tYW5kIGluIGNhc2UgaXQgZGlk
bid0IGZpbmlzaCB5ZXQuCj4gCj4gU2lnbmVkLW9mZi1ieTogR2VyZCBIb2ZmbWFubiA8a3JheGVs
QHJlZGhhdC5jb20+Cj4gLS0tCgpBY2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJv
bm5lcy5vcmc+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==

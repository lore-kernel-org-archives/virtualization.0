From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
	drivers
Date: Thu, 22 Mar 2018 17:54:45 +0000
Message-ID: <CACvgo53B4zLLUqw9y18skpjacmjt-iAYBcG19HkmE=jFwcb4+w__48295.9114983261$1521741171$gmane$org@mail.gmail.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Kyungmin Park <kyungmin.park@samsung.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Shawn Guo <shawnguo@kernel.org>, freedreno@lists.freedesktop.org, Vincent Abriou <vincent.abriou@st.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

SGkgVmlsbGUsCgpPbiAyMiBNYXJjaCAyMDE4IGF0IDE1OjIyLCBWaWxsZSBTeXJqYWxhIDx2aWxs
ZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4gRnJvbTogVmlsbGUgU3lyasOkbMOk
IDx2aWxsZS5zeXJqYWxhQGxpbnV4LmludGVsLmNvbT4KPgo+IEkgcmVhbGx5IGp1c3Qgd2FudGVk
IHRvIGZpeCBpOTE1IHRvIHJlLWVuYWJsZSBpdHMgcGxhbmVzIGFmZXIgbG9hZAo+IGRldGVjdGlv
biAoYSB0d28gbGluZSBwYXRjaCkuIFRoaXMgaXMgd2hhdCBJIGFjdHVhbGx5IGVuZGVkIHVwIHdp
dGgKPiBhZnRlciBJIHJhbiBpbnRvIGEgZnJhbWVidWZmZXIgcmVmY291bnQgbGVhayB3aXRoIHNh
aWQgdHdvIGxpbmUgcGF0Y2guCj4KPiBJJ3ZlIHRlc3RlZCB0aGlzIG9uIGEgZmV3IGk5MTUgYm94
ZXMgYW5kIHNvIGZhciBpdCdzIGxvb2tpbmcKPiBnb29kLiBFdmVyeXRoaW5nIGVsc2UgaXMganVz
dCBjb21waWxlIHRlc3RlZC4KPgpNb3N0bHkgdGhpbmtpbmcgb3V0IGxvdWQ6CgpXb25kZXJpbmcg
aWYgb25lIGNhbm5vdCBzb21laG93IChyZSltb3ZlIHBsYW5lLT5mYi9jcnRjIGFsdG9nZXRoZXIu
Ck90aGVyd2lzZSBkcml2ZXJzIHdpbGwgcmVpbnRyb2R1Y2Ugc2ltaWxhciBjb2RlLCBkZXNwaXRl
IHRoZSBXQVJOcyBhbmQKYmVlZnkgZG9jdW1lbnRhdGlvbiA6LVwKCkhUSApFbWlsCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

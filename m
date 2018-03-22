From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 00/23] drm: Eliminate plane->fb/crtc usage for atomic
	drivers
Date: Thu, 22 Mar 2018 18:34:19 +0000
Message-ID: <CACvgo52O9ALUm8MqM69SDaUF_spw2nkJ0tr8UCJnB9t4GbkVFw__14707.6881294653$1521743548$gmane$org@mail.gmail.com>
References: <20180322152313.6561-1-ville.syrjala@linux.intel.com>
	<CACvgo53B4zLLUqw9y18skpjacmjt-iAYBcG19HkmE=jFwcb4+w@mail.gmail.com>
	<a0d3ec32-be68-c96e-607c-0af4a97a3dd6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a0d3ec32-be68-c96e-607c-0af4a97a3dd6@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Harry Wentland <harry.wentland@amd.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Thomas Hellstrom <thellstrom@vmware.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Vincent Abriou <vincent.abriou@st.com>, Kyungmin Park <kyungmin.park@samsung.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org, Shawn Guo <shawnguo@kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Ville Syrjala <ville.syrjala@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMjIgTWFyY2ggMjAxOCBhdCAxODowMywgSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5k
QGFtZC5jb20+IHdyb3RlOgo+IE9uIDIwMTgtMDMtMjIgMDE6NTQgUE0sIEVtaWwgVmVsaWtvdiB3
cm90ZToKPj4gSGkgVmlsbGUsCj4+Cj4+IE9uIDIyIE1hcmNoIDIwMTggYXQgMTU6MjIsIFZpbGxl
IFN5cmphbGEgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPiB3cm90ZToKPj4+IEZyb206
IFZpbGxlIFN5cmrDpGzDpCA8dmlsbGUuc3lyamFsYUBsaW51eC5pbnRlbC5jb20+Cj4+Pgo+Pj4g
SSByZWFsbHkganVzdCB3YW50ZWQgdG8gZml4IGk5MTUgdG8gcmUtZW5hYmxlIGl0cyBwbGFuZXMg
YWZlciBsb2FkCj4+PiBkZXRlY3Rpb24gKGEgdHdvIGxpbmUgcGF0Y2gpLiBUaGlzIGlzIHdoYXQg
SSBhY3R1YWxseSBlbmRlZCB1cCB3aXRoCj4+PiBhZnRlciBJIHJhbiBpbnRvIGEgZnJhbWVidWZm
ZXIgcmVmY291bnQgbGVhayB3aXRoIHNhaWQgdHdvIGxpbmUgcGF0Y2guCj4+Pgo+Pj4gSSd2ZSB0
ZXN0ZWQgdGhpcyBvbiBhIGZldyBpOTE1IGJveGVzIGFuZCBzbyBmYXIgaXQncyBsb29raW5nCj4+
PiBnb29kLiBFdmVyeXRoaW5nIGVsc2UgaXMganVzdCBjb21waWxlIHRlc3RlZC4KPj4+Cj4+IE1v
c3RseSB0aGlua2luZyBvdXQgbG91ZDoKPj4KPj4gV29uZGVyaW5nIGlmIG9uZSBjYW5ub3Qgc29t
ZWhvdyAocmUpbW92ZSBwbGFuZS0+ZmIvY3J0YyBhbHRvZ2V0aGVyLgo+PiBPdGhlcndpc2UgZHJp
dmVycyB3aWxsIHJlaW50cm9kdWNlIHNpbWlsYXIgY29kZSwgZGVzcGl0ZSB0aGUgV0FSTnMgYW5k
Cj4+IGJlZWZ5IGRvY3VtZW50YXRpb24gOi1cCj4KPiBXb3VsZG4ndCB0aGF0IHJlcXVpcmUgYW4g
YXRvbWljIGNvbnZlcnNpb24gb2YgYWxsIHJlbWFpbmluZyBkcml2ZXJzPwo+ClRoYXQgb3IgbWF5
YmUgbW92ZSBpbnRvIHBsYW5lLT5sZWdhY3ktPntmYixjcnRjfS4gRmVlbCBmcmVlIHRvIHN3YXAK
J2xlZ2FjeScgd2l0aCBmbGFzaGllciBuYW1lLgoKSG1tIGJhY2sgaW4gMjAxNSB3ZSBoYWQgYSBH
U29DIHRoYXQgdXBkYXRlZCBCT0NIUyBhbmQgQ0lSUlVTIGRyaXZlcnMsCmJ1dCB0aGV5IG5ldmVy
IGdvdCBtZXJnZWQuCkRvbid0IHJlY2FsbCB0aGUgZGV0YWlscyAtIGZyb20gbWVtb3J5IHRoZSBj
b252ZXJzaW9uIHNlZW1lZCBmaW5lLCBidXQKdGhlcmUgd2FzIGVpdGhlciBzaG9ydGFnZSBvbiBy
ZXZpZXcvb3RoZXIuCgpNaWdodCBiZSB3b3J0aCByZXZpdmluZyB0aGF0Li4uIHJlZ2FyZGxlc3Mg
aXQncyBnZXR0aW5nIGEgYml0IG9mZi10b3BpYy4KLUVtaWwKClsxXSBodHRwczovL3d3dy5nb29n
bGUtbWVsYW5nZS5jb20vYXJjaGl2ZS9nc29jLzIwMTUvb3Jncy94b3JnL3Byb2plY3RzL2pvaG5o
dW50ZXIuaHRtbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=

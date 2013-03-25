From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 05/22] virtio: add support for 64 bit features.
Date: Mon, 25 Mar 2013 19:00:33 +1030
Message-ID: <877gkvev9y.fsf@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
	<20130321110614.24c6ed08@gondolin>
	<CAJK669aeEAkPrtrjM5e1pwVgvqU8CGo6TFdm5hGUEJ1PpFZLAA@mail.gmail.com>
	<CAK=Wgbbdz0g=8Ps--=njY=6RYZU0yBfXscz9tP5tTHZ4QsstMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK=Wgbbdz0g=8Ps--=njY=6RYZU0yBfXscz9tP5tTHZ4QsstMg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Brian Swetland <swetland@google.com>, Linus Walleij <linus.walleij@linaro.org>, Erwan YVIN <Erwan.Yvin@stericsson.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

T2hhZCBCZW4tQ29oZW4gPG9oYWRAd2l6ZXJ5LmNvbT4gd3JpdGVzOgo+IE9uIEZyaSwgTWFyIDIy
LCAyMDEzIGF0IDQ6NTAgUE0sIFNqdXIgQnLDpm5kZWxhbmQgPHNqdXJicmVuQGdtYWlsLmNvbT4g
d3JvdGU6Cj4+IEkgZ3Vlc3MgeW91IHdvdWxkIG5lZWQgdG8gdXBkYXRlIHRoZSBmZWF0dXJlIGJp
dHMgaW4gcmVtb3RlcHJvYyBhcyB3ZWxsPwo+PiBlLmcuIHNvbWV0aGluZyBsaWtlOgo+Pgo+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yZW1vdGVwcm9jLmggYi9pbmNsdWRlL2xpbnV4L3Jl
bW90ZXByb2MuaAo+PiBpbmRleCBmYWYzMzMyLi4xNDhhNTAzIDEwMDY0NAo+PiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3JlbW90ZXByb2MuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3JlbW90ZXByb2Mu
aAo+PiBAQCAtMjk2LDggKzI5Niw4IEBAIHN0cnVjdCBmd19yc2NfdmRldl92cmluZyB7Cj4+ICBz
dHJ1Y3QgZndfcnNjX3ZkZXYgewo+PiAgICAgICAgIHUzMiBpZDsKPj4gICAgICAgICB1MzIgbm90
aWZ5aWQ7Cj4+IC0gICAgICAgdTMyIGRmZWF0dXJlczsKPj4gLSAgICAgICB1MzIgZ2ZlYXR1cmVz
Owo+PiArICAgICAgIHU2NCBkZmVhdHVyZXM7Cj4+ICsgICAgICAgdTY0IGdmZWF0dXJlczsKPj4g
ICAgICAgICB1MzIgY29uZmlnX2xlbjsKPj4gICAgICAgICB1OCBzdGF0dXM7Cj4+ICAgICAgICAg
dTggbnVtX29mX3ZyaW5nczsKPgo+IFdlIHdpbGwgYnJlYWsgZXhpc3RpbmcgZmlybXdhcmUgaWYg
d2UgZG8gdGhhdC4KPgo+IEluaXRpYWxseSB3ZSB0aG91Z2h0IGl0J3MgYSBnb29kIGlkZWEgdG8g
YW5ub3VuY2UgdGhhdCByZW1vdGVwcm9jJ3MKPiBiaW5hcnkgaW50ZXJmYWNlIGlzbid0IHN0YWJs
ZSBzbyB3ZSBjb3VsZCBrZWVwIGNoYW5naW5nIGl0LCBidXQgYXQKPiB0aGlzIHBvaW50IGNoYW5n
aW5nIHRoZSBiaW5hcnkgaW50ZXJmYWNlIG1lYW5zIHBhaW4gZm9yIHRvbyBtYW55Cj4gcGVvcGxl
Lgo+Cj4gSSdtIHRoaW5raW5nIHRoYXQgYXQgdGhpcyBzdGFnZSBhbnkgY2hhbmdlcyB0byB0aGUg
YmluYXJ5IGludGVyZmFjZQo+IHdpbGwgaGF2ZSB0byBidW1wIHVwIHRoZSBiaW5hcnkgdmVyc2lv
biBzbyB3ZSBjYW4gc3RpbGwgc3VwcG9ydCBvbGRlcgo+IGltYWdlcywgZGVzcGl0ZSBvdXIgInVu
c3RhYmxlIiBwb2xpY3kuCgpZZWFoLCB0aGF0J3Mgd2h5IEkgbGVmdCBpdCBhbG9uZS4KCk9idmlv
dXNseSwgZXhpc3RpbmcgZmlybXdhcmUgd29uJ3Qgc2V0IGZlYXR1cmVzID49IDMyIGFueXdheSwg
YnV0IHlvdQptYXkgbmVlZCB0byBjb21lIHVwIHdpdGggYSBtZXRob2QgZm9yIGZ1dHVyZSBleHRl
bnNpb25zLgoKQ2hlZXJzLApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

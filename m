From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: fix =?utf-8?Q?=22warni?=
	=?utf-8?B?bmc6IOKAmHF1ZXVl4oCZ?= may be used uninitialized"
Date: Tue, 5 Apr 2016 11:04:10 +0300
Message-ID: <20160405110113-mutt-send-email-mst@redhat.com>
References: <5702AEFB.5090701@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5702AEFB.5090701@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Mahoney <jeffm@suse.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBBcHIgMDQsIDIwMTYgYXQgMDI6MTQ6MTlQTSAtMDQwMCwgSmVmZiBNYWhvbmV5IHdy
b3RlOgo+IFRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyB3YXJuaW5nOgo+IGRyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmM6MTAzMjo1OiB3YXJuaW5nOiDigJhxdWV1ZeKAmSBtYXkgYmUgdXNlZAo+
IHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbgo+IAo+IFRoZSBjb25kaXRpb25zIHRoYXQg
Z292ZXJuIHdoZW4gcXVldWUgaXMgc2V0IGFyZW4ndCBhcHBhcmVudCB0byBnY2MuCj4gCj4gU2V0
dGluZyBxdWV1ZSA9IE5VTEwgY2xlYXJzIHRoZSB3YXJuaW5nLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEplZmYgTWFob25leSA8amVmZm1Ac3VzZS5jb20+CgpXaGljaCBnY2MgdmVyc2lvbiBwcm9kdWNl
cyB0aGlzIHdhcm5pbmc/CkkgZG8gbm90IHNlZW0gdG8gc2VlIGl0IHdpdGggZ2NjIDUuMy4xLgpB
bHNvIC0gdXNlIHVuaW5pdGlhbGl6ZWRfdmFyIHRoZW4/Cgo+IC0tLQo+IAo+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgICAgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBAIC0xMDA2LDcgKzEw
MDYsNyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVfdmlydHF1ZXVlCj4gIAljb25z
dCBjaGFyICpuYW1lKQo+ICB7Cj4gIAlzdHJ1Y3QgdmlydHF1ZXVlICp2cTsKPiAtCXZvaWQgKnF1
ZXVlOwo+ICsJdm9pZCAqcXVldWUgPSBOVUxMOwo+ICAJZG1hX2FkZHJfdCBkbWFfYWRkcjsKPiAg
CXNpemVfdCBxdWV1ZV9zaXplX2luX2J5dGVzOwo+ICAJc3RydWN0IHZyaW5nIHZyaW5nOwo+IAo+
IC0tIAo+IEplZmYgTWFob25leQo+IFNVU0UgTGFicwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

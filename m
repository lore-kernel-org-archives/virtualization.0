From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH 2/2] virtio-rng: fix stuck in catting hwrng attributes
Date: Tue, 16 Sep 2014 08:50:03 +0800
Message-ID: <20140916005003.GC5671@zen>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
	<1410340027-15373-3-git-send-email-akong@redhat.com>
	<8738byie04.fsf@rustcorp.com.au>
	<20140913171258.GB12276@zen.redhat.com>
	<20140914011208.GA1032@zen.redhat.com>
	<20140914022553.GC1032@zen.redhat.com>
	<20140915164846.GA29862@potion.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140915164846.GA29862@potion.brq.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: herbert@gondor.apana.org.au, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, m@bues.ch, mpm@selenic.com, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Q0MgbGludXgta2VybmVsCgpPcmlnaW5hbCB0aHJlYWQ6IGh0dHA6Ly9jb21tZW50cy5nbWFuZS5v
cmcvZ21hbmUubGludXgua2VybmVsLnZpcnR1YWxpemF0aW9uLzIyNzc1CgpPbiBNb24sIFNlcCAx
NSwgMjAxNCBhdCAwNjo0ODo0NlBNICswMjAwLCBSYWRpbSBLcsSNbcOhxZkgd3JvdGU6Cj4gMjAx
NC0wOS0xNCAxMDoyNSswODAwLCBBbW9zIEtvbmc6Cj4gPiBPbiBTdW4sIFNlcCAxNCwgMjAxNCBh
dCAwOToxMjowOEFNICswODAwLCBBbW9zIEtvbmcgd3JvdGU6Cj4gPiAKPiA+IC4uLgo+ID4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9jb3JlLmMgYi9kcml2ZXJz
L2NoYXIvaHdfcmFuZG9tL2NvcmUuYwo+ID4gPiA+ID4gPiBpbmRleCBjNTkxZDdlLi5iNWQxYjZm
IDEwMDY0NAo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL2NvcmUuYwo+
ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL2NvcmUuYwo+ID4gPiA+ID4g
PiBAQCAtMTk1LDggKzE5NSw3IEBAIHN0YXRpYyBzc2l6ZV90IHJuZ19kZXZfcmVhZChzdHJ1Y3Qg
ZmlsZSAqZmlscCwgY2hhciBfX3VzZXIgKmJ1ZiwKPiA+ID4gPiA+ID4gIAo+ID4gPiA+ID4gPiAg
CQltdXRleF91bmxvY2soJnJuZ19tdXRleCk7Cj4gPiA+ID4gPiA+ICAKPiA+ID4gPiA+ID4gLQkJ
aWYgKG5lZWRfcmVzY2hlZCgpKQo+ID4gPiA+ID4gPiAtCQkJc2NoZWR1bGVfdGltZW91dF9pbnRl
cnJ1cHRpYmxlKDEpOwo+ID4gPiA+ID4gPiArCQlzY2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGli
bGUoMTApOwo+IAo+IElmIGNvbmRfcmVzY2hlZCgpIGRvZXMgbm90IHdvcmssIGl0IGlzIGEgYnVn
IGVsc2V3ZWhlcmUuCgpUaGFua3MgZm9yIHlvdXIgcmVwbHksIEphc29uIGFsc28gdG9sZCBtZSB0
aGUgVElGX05FRURfUkVTQ0hFRCBzaG91bGQKYmUgc2V0IGluIHRoaXMgY2FzZSwgdGhlbiBuZWVk
X3Jlc2NoZWQoKSByZXR1cm5zIHRydWUuCgpJIHdpbGwgaW52ZXN0aWdhdGUgdGhlIGlzc3VlIGFu
ZCByZXBseSB5b3UgbGF0ZXIuCiAKPiA+IFByb2JsZW0gb25seSBvY2N1cnJlZCBpbiBub24tc21w
IGd1ZXN0LCB3ZSBjYW4gaW1wcm92ZSBpdCB0bzoKPiA+IAo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgaWYoIWlzX3NtcCgpKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
Y2hlZHVsZV90aW1lb3V0X2ludGVycnVwdGlibGUoMTApOwo+ID4gCj4gPiBpc19zbXAoKSBpcyBv
bmx5IGF2YWlsYWJsZSBmb3IgYXJtIGFyY2gsIHdlIG5lZWQgYSBnZW5lcmFsIG9uZS4KPiAKPiAo
SXQgaXMgbnVtX29ubGluZV9jcHVzKCkgPiAxLikKCi0tIAoJCQlBbW9zLgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

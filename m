From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-gpu: use src not crtc
Date: Tue, 14 Jun 2016 14:57:33 +0200
Message-ID: <1465909053.6693.63.camel__20225.790635641$1465909074$gmane$org@redhat.com>
References: <1464699172-26755-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CKQNpJ+=i3wq2JDJi8Z+tyK1=wBEmYTE=NfNJ20VKEoDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ+F1CKQNpJ+=i3wq2JDJi8Z+tyK1=wBEmYTE=NfNJ20VKEoDA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open
	list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gRGksIDIwMTYtMDYtMTQgYXQgMTI6MTMgKzAyMDAsIE1hcmMtQW5kcsOpIEx1cmVhdSB3cm90
ZToKPiBIaQo+IAo+IE9uIFR1ZSwgTWF5IDMxLCAyMDE2IGF0IDI6NTIgUE0sIEdlcmQgSG9mZm1h
bm4gPGtyYXhlbEByZWRoYXQuY29tPiB3cm90ZToKPiA+IFBpY2sgdXAgdGhlIGNvcnJlY3Qgc291
cmNlIHJlY3RhbmdsZSBmcm9tIGZyYW1lYnVmZmVyLgo+ID4gV2l0aG91dCB0aGlzIG11bHRpaGVh
ZCBzZXR1cHMgYXJlIG5vdCB3b3JraW5nIGNvcnJlY3RseS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KPiAKPiBSZXZpZXdlZC1ieTogTWFy
Yy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+Cj4gCj4gQWRkaXRp
b25hbGx5LCBJIGhhZCB0byBtb2RpZnkgdGhlIHBhZ2VfZmxpcCgpIGZ1bmN0aW9uIHRvIHRha2Ug
dGhlCj4gcGxhbmUgc291cmNlIGNvb3JkaW5hdGVzIGZvciB2aXJnbC8zZCBtdWx0aWhlYWQgdG8g
d29yay4gRmVlbCBmcmVlIHRvCj4gc3F1YXNoLgoKVGhpcyBpcyBpbiBwcm9ncmVzcyBvZiBiZWlu
ZyBzb3J0ZWQsIGJ5IGRyb3BwaW5nIHRoZQp2aXJ0aW9fZ3B1X3BhZ2VfZmxpcCBmdW5jdGlvbiBh
bHRvZ2V0aGVyIGluIGZhdm9yIG9mIGF0b21pYyBoZWxwZXJzLAp3aGljaCB3aWxsIHVzZSB0aGUg
KGFscmVhZHkgZml4ZWQpIHBsYW5lIGNhbGxiYWNrcyBpbnN0ZWFkLgoKU2VlIG5vbmJsb2NraW5n
IGNvbW1pdCBzdXBwb3J0IHBhdGNoZXMgYnkgRGFuaWVsIFZldHRlciBvbiB0aGlzIGxpc3QuCgpj
aGVlcnMsCiAgR2VyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

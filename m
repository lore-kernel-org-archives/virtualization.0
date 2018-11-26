From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 2/3] vhost_net: support in order feature
Date: Mon, 26 Nov 2018 11:52:07 +0800
Message-ID: <1c50dc69-49d5-0d19-dea9-4c97a2d99b5f@redhat.com>
References: <20181123030016.4924-1-jasowang@redhat.com>
	<20181123030016.4924-3-jasowang@redhat.com>
	<20181123104333-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181123104333-mutt-send-email-mst@kernel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTgvMTEvMjMg5LiL5Y2IMTE6NDksIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBP
biBGcmksIE5vdiAyMywgMjAxOCBhdCAxMTowMDoxNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiBUaGlzIG1ha2VzIHZob3N0X25ldCB0byBzdXBwb3J0IGluIG9yZGVyIGZlYXR1cmUuIFRo
aXMgaXMgYXMgc2ltcGxlIGFzCj4+IHVzZSBkYXRhY29weSBwYXRoIHdoZW4gaXQgd2FzIG5lZ290
aWF0ZWQuIEFuIGFsdGVybmF0aXZlIGlzIG5vdCB0bwo+PiBhZHZlcnRpc2UgaW4gb3JkZXIgd2hl
biB6ZXJvY29weSBpcyBlbmFibGVkIHdoaWNoIHRlbmRzIHRvIGJlCj4+IHN1Ym9wdGltYWwgY29u
c2lkZXIgemVyb2NvcHkgbWF5IHN1ZmZlciBmcm9tIGUuZyBIT0wgaXNzdWVzLgo+IFdlbGwgSUlS
QyB2aG9zdF96ZXJvY29weV9zaWduYWxfdXNlZCBpcyB1c2VkIHRvCj4gYWN0dWFsbHkgcmVvcmRl
ciB1c2VkIHJpbmcgdG8gbWF0Y2ggYXZhaWxhYmxlIHJpbmcuCj4gU28gd2l0aCBhIGJpZyBjb21t
ZW50IGV4cGxhaW5pbmcgd2h5IGl0IGlzIHNvLAo+IHdlIGNvdWxkIGp1c3QgZW5hYmxlIElOX09S
REVSIHRoZXJlIHRvby4KPgoKVGhlIHByb2JsZW0gaXMgd2UgYWxsb3cgc3dpdGNoaW5nIGJldHdl
ZW4gemVyb2NvcHkgYW5kIGRhdGFjb3B5LgoKQW5kIHdoYXQncyBtb3JlIGltcG9ydGFudCwgaWYg
d2UgYWxsb3cgaW4gb3JkZXIgZm9yIHplcm9jb3B5LCBhIHNpbmdsZSAKcGFja2V0IGRlbGF5IG1h
eSBoYW5nIGFsbCB0aGUgcmVzdC4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

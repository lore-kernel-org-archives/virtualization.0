From: Wei Xu <wexu@redhat.com>
Subject: Re: [RFC V5 PATCH 8/8] vhost: event suppression for packed ring
Date: Sun, 3 Jun 2018 23:40:04 +0800
Message-ID: <20180603154004.GA24012__4577.71047154001$1528050497$gmane$org@wei-ubt>
References: <1527559830-8133-1-git-send-email-jasowang@redhat.com>
	<1527559830-8133-9-git-send-email-jasowang@redhat.com>
	<20180530114200.GA23792@wei-ubt>
	<12f2c455-5868-3b07-0eba-d49dcafd10f2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <12f2c455-5868-3b07-0eba-d49dcafd10f2@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBNYXkgMzEsIDIwMTggYXQgMTE6MDk6MDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiAKPiBPbiAyMDE45bm0MDXmnIgzMOaXpSAxOTo0MiwgV2VpIFh1IHdyb3RlOgo+ID4+
ICAvKiBUaGlzIGFjdHVhbGx5IHNpZ25hbHMgdGhlIGd1ZXN0LCB1c2luZyBldmVudGZkLiAqLwo+
ID4+ICB2b2lkIHZob3N0X3NpZ25hbChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHN0cnVjdCB2aG9z
dF92aXJ0cXVldWUgKnZxKQo+ID4+ICB7Cj4gPj5AQCAtMjgwMiwxMCArMjkzMCwzNCBAQCBzdGF0
aWMgYm9vbCB2aG9zdF9lbmFibGVfbm90aWZ5X3BhY2tlZChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4gPj4gIAkJCQkgICAgICAgc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4gPj4gIHsKPiA+
PiAgCXN0cnVjdCB2cmluZ19kZXNjX3BhY2tlZCAqZCA9IHZxLT5kZXNjX3BhY2tlZCArIHZxLT5h
dmFpbF9pZHg7Cj4gPj4tCV9fdmlydGlvMTYgZmxhZ3M7Cj4gPj4rCV9fdmlydGlvMTYgZmxhZ3Mg
PSBSSU5HX0VWRU5UX0ZMQUdTX0VOQUJMRTsKPiA+PiAgCWludCByZXQ7Cj4gPj4tCS8qIEZJWE1F
OiBkaXNhYmxlIG5vdGlmaWNhdGlvbiB0aHJvdWdoIGRldmljZSBhcmVhICovCj4gPj4rCWlmICgh
KHZxLT51c2VkX2ZsYWdzICYgVlJJTkdfVVNFRF9GX05PX05PVElGWSkpCj4gPj4rCQlyZXR1cm4g
ZmFsc2U7Cj4gPj4rCXZxLT51c2VkX2ZsYWdzICY9IH5WUklOR19VU0VEX0ZfTk9fTk9USUZZOwo+
ID4ndXNlZF9mbGFncycgd2FzIG9yaWdpbmFsbHkgZGVzaWduZWQgZm9yIDEuMCwgd2h5IHNob3Vs
ZCB3ZSBwYXkgYXR0ZXRpb24gdG8gaXQgaGVyZT8KPiA+Cj4gPldlaQo+IAo+IEl0IHdhcyB1c2Vk
IHRvIHJlY29yZWQgd2hldGhlciBvciBub3Qgd2UndmUgZGlzYWJsZWQgbm90aWZpY2F0aW9uLiBU
aGVuIHdlCj4gY2FuIGF2b2lkIHVubmVjZXNzYXJ5IHVzZXJzcGFjZSB3cml0ZXMgb3IgbWVtb3J5
IGJhcnJpZXJzLgoKT0ssIHRoYW5rcy4KCj4gCj4gVGhhbmtzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

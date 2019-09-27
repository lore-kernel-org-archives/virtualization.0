From: Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Date: Fri, 27 Sep 2019 16:04:10 +0800
Message-ID: <20190927080410.GA22568__37649.2628523678$1569571633$gmane$org@___>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
	<1b4b8891-8c14-1c85-1d6a-2eed1c90bcde@redhat.com>
	<20190927045438.GA17152@___>
	<49bb0777-3761-3737-8e5b-568957f9a935@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <49bb0777-3761-3737-8e5b-568957f9a935@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBTZXAgMjcsIDIwMTkgYXQgMDM6MTQ6NDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiAyMDE5LzkvMjcg5LiL5Y2IMTI6NTQsIFRpd2VpIEJpZSB3cm90ZToKPiA+ID4gPiAr
Cj4gPiA+ID4gKwkJLyoKPiA+ID4gPiArCQkgKiBJbiB2aG9zdC1tZGV2LCB1c2Vyc3BhY2Ugc2hv
dWxkIHBhc3MgcmluZyBhZGRyZXNzZXMKPiA+ID4gPiArCQkgKiBpbiBndWVzdCBwaHlzaWNhbCBh
ZGRyZXNzZXMgd2hlbiBJT01NVSBpcyBkaXNhYmxlZCBvcgo+ID4gPiA+ICsJCSAqIElPVkFzIHdo
ZW4gSU9NTVUgaXMgZW5hYmxlZC4KPiA+ID4gPiArCQkgKi8KPiA+ID4gQSBxdWVzdGlvbiBoZXJl
LCBjb25zaWRlciB3ZSdyZSB1c2luZyBub2lvbW11IG1vZGUuIElmIGd1ZXN0IHBoeXNpY2FsCj4g
PiA+IGFkZHJlc3MgaXMgcGFzc2VkIGhlcmUsIGhvdyBjYW4gYSBkZXZpY2UgdXNlIHRoYXQ/Cj4g
PiA+IAo+ID4gPiBJIGJlbGlldmUgeW91IG1lYW50ICJob3N0IHBoeXNpY2FsIGFkZHJlc3MiIGhl
cmU/IEFuZCBpdCBhbHNvIGhhdmUgdGhlCj4gPiA+IGltcGxpY2F0aW9uIHRoYXQgdGhlIEhQQSBz
aG91bGQgYmUgY29udGludW91cyAoZS5nIHVzaW5nIGh1Z2V0bGJmcykuCj4gPiBUaGUgY29tbWVu
dCBpcyB0YWxraW5nIGFib3V0IHRoZSB2aXJ0dWFsIElPTU1VIChpLmUuIGlvdGxiIGluIHZob3N0
KS4KPiA+IEl0IHNob3VsZCBiZSByZXBocmFzZWQgdG8gY292ZXIgdGhlIG5vaW9tbXUgY2FzZSBh
cyB3ZWxsLiBUaGFua3MgZm9yCj4gPiBzcG90dGluZyB0aGlzLgo+IAo+IAo+IFNvIHRoZSBxdWVz
dGlvbiBzdGlsbCwgaWYgR1BBIGlzIHBhc3NlZCBob3cgY2FuIGl0IGJlIHVzZWQgYnkgdGhlCj4g
dmlydGlvLW1kZXYgZGV2aWNlPwoKU29ycnkgaWYgSSBkaWRuJ3QgbWFrZSBpdCBjbGVhci4uCk9m
IGNvdXJzZSwgR1BBIGNhbid0IGJlIHBhc3NlZCBpbiBub2lvbW11IG1vZGUuCgoKPiAKPiBUaGFu
a3MKPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

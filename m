From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 08:50:46 -0500
Message-ID: <20191107085013-mutt-send-email-mst__3805.31424177519$1573134675$gmane$org@kernel.org>
References: <20191106133531.693-1-jasowang@redhat.com>
	<20191106133531.693-7-jasowang@redhat.com>
	<20191107040700-mutt-send-email-mst@kernel.org>
	<bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
	<20191107061942-mutt-send-email-mst@kernel.org>
	<d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
	<20191107080834-mutt-send-email-mst@kernel.org>
	<b2265e3a-6f86-c21a-2ebd-d0e4eea2886f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b2265e3a-6f86-c21a-2ebd-d0e4eea2886f@redhat.com>
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
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDk6MzI6MjlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzExLzcg5LiL5Y2IOTowOCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDg6NDM6MjlQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gT24gMjAxOS8xMS83IOS4i+WNiDc6MjEsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPiA+ID4gPiBPbiBUaHUsIE5vdiAwNywgMjAxOSBhdCAwNjoxODo0NVBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gT24gMjAxOS8xMS83IOS4i+WNiDU6MDgsIE1p
Y2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiA+ID4gT24gV2VkLCBOb3YgMDYsIDIwMTkg
YXQgMDk6MzU6MzFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiBUaGlz
IHNhbXBsZSBkcml2ZXIgY3JlYXRlcyBtZGV2IGRldmljZSB0aGF0IHNpbXVsYXRlIHZpcnRpbyBu
ZXQgZGV2aWNlCj4gPiA+ID4gPiA+ID4gb3ZlciB2aXJ0aW8gbWRldiB0cmFuc3BvcnQuIFRoZSBk
ZXZpY2UgaXMgaW1wbGVtZW50ZWQgdGhyb3VnaCB2cmluZ2gKPiA+ID4gPiA+ID4gPiBhbmQgd29y
a3F1ZXVlLiBBIGRldmljZSBzcGVjaWZpYyBkbWEgb3BzIGlzIHRvIG1ha2Ugc3VyZSBIVkEgaXMg
dXNlZAo+ID4gPiA+ID4gPiA+IGRpcmVjdGx5IGFzIHRoZSBJT1ZBLiBUaGlzIHNob3VsZCBiZSBz
dWZmaWNpZW50IGZvciBrZXJuZWwgdmlydGlvCj4gPiA+ID4gPiA+ID4gZHJpdmVyIHRvIHdvcmsu
Cj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gT25seSAndmlydGlvJyB0eXBlIGlzIHN1cHBv
cnRlZCByaWdodCBub3cuIEkgcGxhbiB0byBhZGQgJ3Zob3N0JyB0eXBlCj4gPiA+ID4gPiA+ID4g
b24gdG9wIHdoaWNoIHJlcXVpcmVzIHNvbWUgdmlydHVhbCBJT01NVSBpbXBsZW1lbnRlZCBpbiB0
aGlzIHNhbXBsZQo+ID4gPiA+ID4gPiA+IGRyaXZlci4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+
ID4gPiBBY2tlZC1ieTogQ29ybmVsaWEgSHVjazxjb2h1Y2tAcmVkaGF0LmNvbT4KPiA+ID4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+
ID4gPiA+IEknZCBwcmVmZXIgaXQgdGhhdCB3ZSBjYWxsIHRoaXMgc29tZXRoaW5nIGVsc2UsIGUu
Zy4KPiA+ID4gPiA+ID4gbXZuZXQtbG9vcGJhY2suIEp1c3Qgc28gcGVvcGxlIGRvbid0IGV4cGVj
dCBhIGZ1bGx5Cj4gPiA+ID4gPiA+IGZ1bmN0aW9uYWwgZGV2aWNlIHNvbWVob3cuIENhbiBiZSBy
ZW5hbWVkIHdoZW4gYXBwbHlpbmc/Cj4gPiA+ID4gPiBBY3R1YWxseSwgSSBwbGFuIHRvIGV4dGVu
ZCBpdCBhcyBhbm90aGVyIHN0YW5kYXJkIG5ldHdvcmsgaW50ZXJmYWNlIGZvcgo+ID4gPiA+ID4g
a2VybmVsLiBJdCBjb3VsZCBiZSBlaXRoZXIgYSBzdGFuZGFsb25lIHBzZXVkbyBkZXZpY2Ugb3Ig
YSBzdGFjayBkZXZpY2UuCj4gPiA+ID4gPiBEb2VzIHRoaXMgc291bmRzIGdvb2QgdG8geW91Pwo+
ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiBUaGF0J3MgYSBiaWcgY2hhbmdlIGlu
IGFuIGludGVyZmFjZSBzbyBpdCdzIGEgZ29vZCByZWFzb24KPiA+ID4gPiB0byByZW5hbWUgdGhl
IGRyaXZlciBhdCB0aGF0IHBvaW50IHJpZ2h0Pwo+ID4gPiA+IE9oZXJ3aXNlIHVzZXJzIG9mIGFu
IG9sZCBrZXJuZWwgd291bGQgZXhwZWN0IGEgc3RhY2tlZCBkcml2ZXIKPiA+ID4gPiBhbmQgZ2V0
IGEgbG9vcGJhY2sgaW5zdGVhZC4KPiA+ID4gPiAKPiA+ID4gPiBPciBkaWQgSSBtaXNzIHNvbWV0
aGluZz8KPiA+ID4gCj4gPiA+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBpdCB3YXMgYSBzYW1w
bGUgZHJpdmVyIGluIC9kb2MuIEl0IHNob3VsZCBub3QgYmUKPiA+ID4gdXNlZCBpbiBwcm9kdWN0
aW9uIGVudmlyb25tZW50LiBPdGhlcndpc2Ugd2UgbmVlZCB0byBtb3ZlIGl0IHRvCj4gPiA+IGRy
aXZlci92aXJ0aW8uCj4gPiA+IAo+ID4gPiBCdXQgaWYgeW91IGluc2lzdCwgSSBjYW4gcG9zdCBh
IFYxMS4KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gdGhpcyBjYW4gYmUgYSBwYXRjaCBvbiB0b3Au
Cj4gCj4gCj4gVGhlbiBtYXliZSBpdCdzIGJldHRlciBqdXN0IGV4dGVuZCBpdCB0byB3b3JrIGFz
IGEgbm9ybWFsIG5ldHdvcmtpbmcgZGV2aWNlCj4gb24gdG9wPwo+IAo+IFRoYW5rcwoKVGhhdCB3
b3VsZCBiZSBhIHN1YnN0YW50aWFsIGNoYW5nZS4gTWF5YmUgZHJvcCA2LzYgZm9yIG5vdyB1bnRp
bAp3ZSBoYXZlIGEgYmV0dGVyIGhhbmRsZSBvbiB0aGlzPwoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

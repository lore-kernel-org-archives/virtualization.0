From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 22:20:43 +0800
Message-ID: <3440c55b-bbb9-fd4d-7c06-f45860fb4bd3__18023.4666376904$1573136518$gmane$org@redhat.com>
References: <20191106133531.693-1-jasowang@redhat.com>
	<20191106133531.693-7-jasowang@redhat.com>
	<20191107040700-mutt-send-email-mst@kernel.org>
	<bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
	<20191107061942-mutt-send-email-mst@kernel.org>
	<d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
	<20191107080834-mutt-send-email-mst@kernel.org>
	<b2265e3a-6f86-c21a-2ebd-d0e4eea2886f@redhat.com>
	<20191107085013-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191107085013-mutt-send-email-mst@kernel.org>
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
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTEvNyDkuIvljYg5OjUwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBOb3YgMDcsIDIwMTkgYXQgMDk6MzI6MjlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAxOS8xMS83IOS4i+WNiDk6MDgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDA4OjQzOjI5UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4gT24gMjAxOS8xMS83IOS4i+WNiDc6MjEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPj4+Pj4gT24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDY6MTg6NDVQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPj4+Pj4+IE9uIDIwMTkvMTEvNyDkuIvljYg1OjA4LCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cj4+Pj4+Pj4gT24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDk6MzU6MzFQTSAr
MDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4gVGhpcyBzYW1wbGUgZHJpdmVyIGNyZWF0
ZXMgbWRldiBkZXZpY2UgdGhhdCBzaW11bGF0ZSB2aXJ0aW8gbmV0IGRldmljZQo+Pj4+Pj4+PiBv
dmVyIHZpcnRpbyBtZGV2IHRyYW5zcG9ydC4gVGhlIGRldmljZSBpcyBpbXBsZW1lbnRlZCB0aHJv
dWdoIHZyaW5naAo+Pj4+Pj4+PiBhbmQgd29ya3F1ZXVlLiBBIGRldmljZSBzcGVjaWZpYyBkbWEg
b3BzIGlzIHRvIG1ha2Ugc3VyZSBIVkEgaXMgdXNlZAo+Pj4+Pj4+PiBkaXJlY3RseSBhcyB0aGUg
SU9WQS4gVGhpcyBzaG91bGQgYmUgc3VmZmljaWVudCBmb3Iga2VybmVsIHZpcnRpbwo+Pj4+Pj4+
PiBkcml2ZXIgdG8gd29yay4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gT25seSAndmlydGlvJyB0eXBlIGlz
IHN1cHBvcnRlZCByaWdodCBub3cuIEkgcGxhbiB0byBhZGQgJ3Zob3N0JyB0eXBlCj4+Pj4+Pj4+
IG9uIHRvcCB3aGljaCByZXF1aXJlcyBzb21lIHZpcnR1YWwgSU9NTVUgaW1wbGVtZW50ZWQgaW4g
dGhpcyBzYW1wbGUKPj4+Pj4+Pj4gZHJpdmVyLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBY2tlZC1ieTog
Q29ybmVsaWEgSHVjazxjb2h1Y2tAcmVkaGF0LmNvbT4KPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
SmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+Pj4+IEknZCBwcmVmZXIgaXQgdGhh
dCB3ZSBjYWxsIHRoaXMgc29tZXRoaW5nIGVsc2UsIGUuZy4KPj4+Pj4+PiBtdm5ldC1sb29wYmFj
ay4gSnVzdCBzbyBwZW9wbGUgZG9uJ3QgZXhwZWN0IGEgZnVsbHkKPj4+Pj4+PiBmdW5jdGlvbmFs
IGRldmljZSBzb21laG93LiBDYW4gYmUgcmVuYW1lZCB3aGVuIGFwcGx5aW5nPwo+Pj4+Pj4gQWN0
dWFsbHksIEkgcGxhbiB0byBleHRlbmQgaXQgYXMgYW5vdGhlciBzdGFuZGFyZCBuZXR3b3JrIGlu
dGVyZmFjZSBmb3IKPj4+Pj4+IGtlcm5lbC4gSXQgY291bGQgYmUgZWl0aGVyIGEgc3RhbmRhbG9u
ZSBwc2V1ZG8gZGV2aWNlIG9yIGEgc3RhY2sgZGV2aWNlLgo+Pj4+Pj4gRG9lcyB0aGlzIHNvdW5k
cyBnb29kIHRvIHlvdT8KPj4+Pj4+Cj4+Pj4+PiBUaGFua3MKPj4+Pj4gVGhhdCdzIGEgYmlnIGNo
YW5nZSBpbiBhbiBpbnRlcmZhY2Ugc28gaXQncyBhIGdvb2QgcmVhc29uCj4+Pj4+IHRvIHJlbmFt
ZSB0aGUgZHJpdmVyIGF0IHRoYXQgcG9pbnQgcmlnaHQ/Cj4+Pj4+IE9oZXJ3aXNlIHVzZXJzIG9m
IGFuIG9sZCBrZXJuZWwgd291bGQgZXhwZWN0IGEgc3RhY2tlZCBkcml2ZXIKPj4+Pj4gYW5kIGdl
dCBhIGxvb3BiYWNrIGluc3RlYWQuCj4+Pj4+Cj4+Pj4+IE9yIGRpZCBJIG1pc3Mgc29tZXRoaW5n
Pwo+Pj4+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBpdCB3YXMgYSBzYW1wbGUgZHJpdmVyIGlu
IC9kb2MuIEl0IHNob3VsZCBub3QgYmUKPj4+PiB1c2VkIGluIHByb2R1Y3Rpb24gZW52aXJvbm1l
bnQuIE90aGVyd2lzZSB3ZSBuZWVkIHRvIG1vdmUgaXQgdG8KPj4+PiBkcml2ZXIvdmlydGlvLgo+
Pj4+Cj4+Pj4gQnV0IGlmIHlvdSBpbnNpc3QsIEkgY2FuIHBvc3QgYSBWMTEuCj4+Pj4KPj4+PiBU
aGFua3MKPj4+IHRoaXMgY2FuIGJlIGEgcGF0Y2ggb24gdG9wLgo+PiBUaGVuIG1heWJlIGl0J3Mg
YmV0dGVyIGp1c3QgZXh0ZW5kIGl0IHRvIHdvcmsgYXMgYSBub3JtYWwgbmV0d29ya2luZyBkZXZp
Y2UKPj4gb24gdG9wPwo+Pgo+PiBUaGFua3MKPiBUaGF0IHdvdWxkIGJlIGEgc3Vic3RhbnRpYWwg
Y2hhbmdlLiBNYXliZSBkcm9wIDYvNiBmb3Igbm93IHVudGlsCj4gd2UgaGF2ZSBhIGJldHRlciBo
YW5kbGUgb24gdGhpcz8KPgoKT2ssIGNvbnNpZGVyIHRoZSBjaGFuZ2Ugc2hvdWxkIGJlIHNtYWxs
LCBJIHdpbGwgcG9zdCBWMTEgd2hlcmUgSSBjYW4gZml4IAp0aGUgdHlwb3Mgc3BvdHRlZC4KClRo
YW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 08:08:41 -0500
Message-ID: <20191107080834-mutt-send-email-mst__14398.4197102085$1573132148$gmane$org@kernel.org>
References: <20191106133531.693-1-jasowang@redhat.com>
	<20191106133531.693-7-jasowang@redhat.com>
	<20191107040700-mutt-send-email-mst@kernel.org>
	<bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
	<20191107061942-mutt-send-email-mst@kernel.org>
	<d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
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

T24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDg6NDM6MjlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzExLzcg5LiL5Y2INzoyMSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDY6MTg6NDVQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gT24gMjAxOS8xMS83IOS4i+WNiDU6MDgsIE1pY2hhZWwgUy4gVHNpcmtp
biB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIE5vdiAwNiwgMjAxOSBhdCAwOTozNTozMVBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gVGhpcyBzYW1wbGUgZHJpdmVyIGNyZWF0ZXMg
bWRldiBkZXZpY2UgdGhhdCBzaW11bGF0ZSB2aXJ0aW8gbmV0IGRldmljZQo+ID4gPiA+ID4gb3Zl
ciB2aXJ0aW8gbWRldiB0cmFuc3BvcnQuIFRoZSBkZXZpY2UgaXMgaW1wbGVtZW50ZWQgdGhyb3Vn
aCB2cmluZ2gKPiA+ID4gPiA+IGFuZCB3b3JrcXVldWUuIEEgZGV2aWNlIHNwZWNpZmljIGRtYSBv
cHMgaXMgdG8gbWFrZSBzdXJlIEhWQSBpcyB1c2VkCj4gPiA+ID4gPiBkaXJlY3RseSBhcyB0aGUg
SU9WQS4gVGhpcyBzaG91bGQgYmUgc3VmZmljaWVudCBmb3Iga2VybmVsIHZpcnRpbwo+ID4gPiA+
ID4gZHJpdmVyIHRvIHdvcmsuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IE9ubHkgJ3ZpcnRpbycgdHlw
ZSBpcyBzdXBwb3J0ZWQgcmlnaHQgbm93LiBJIHBsYW4gdG8gYWRkICd2aG9zdCcgdHlwZQo+ID4g
PiA+ID4gb24gdG9wIHdoaWNoIHJlcXVpcmVzIHNvbWUgdmlydHVhbCBJT01NVSBpbXBsZW1lbnRl
ZCBpbiB0aGlzIHNhbXBsZQo+ID4gPiA+ID4gZHJpdmVyLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBB
Y2tlZC1ieTogQ29ybmVsaWEgSHVjazxjb2h1Y2tAcmVkaGF0LmNvbT4KPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEphc29uIFdhbmc8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiBJJ2QgcHJl
ZmVyIGl0IHRoYXQgd2UgY2FsbCB0aGlzIHNvbWV0aGluZyBlbHNlLCBlLmcuCj4gPiA+ID4gbXZu
ZXQtbG9vcGJhY2suIEp1c3Qgc28gcGVvcGxlIGRvbid0IGV4cGVjdCBhIGZ1bGx5Cj4gPiA+ID4g
ZnVuY3Rpb25hbCBkZXZpY2Ugc29tZWhvdy4gQ2FuIGJlIHJlbmFtZWQgd2hlbiBhcHBseWluZz8K
PiA+ID4gQWN0dWFsbHksIEkgcGxhbiB0byBleHRlbmQgaXQgYXMgYW5vdGhlciBzdGFuZGFyZCBu
ZXR3b3JrIGludGVyZmFjZSBmb3IKPiA+ID4ga2VybmVsLiBJdCBjb3VsZCBiZSBlaXRoZXIgYSBz
dGFuZGFsb25lIHBzZXVkbyBkZXZpY2Ugb3IgYSBzdGFjayBkZXZpY2UuCj4gPiA+IERvZXMgdGhp
cyBzb3VuZHMgZ29vZCB0byB5b3U/Cj4gPiA+IAo+ID4gPiBUaGFua3MKPiA+IFRoYXQncyBhIGJp
ZyBjaGFuZ2UgaW4gYW4gaW50ZXJmYWNlIHNvIGl0J3MgYSBnb29kIHJlYXNvbgo+ID4gdG8gcmVu
YW1lIHRoZSBkcml2ZXIgYXQgdGhhdCBwb2ludCByaWdodD8KPiA+IE9oZXJ3aXNlIHVzZXJzIG9m
IGFuIG9sZCBrZXJuZWwgd291bGQgZXhwZWN0IGEgc3RhY2tlZCBkcml2ZXIKPiA+IGFuZCBnZXQg
YSBsb29wYmFjayBpbnN0ZWFkLgo+ID4gCj4gPiBPciBkaWQgSSBtaXNzIHNvbWV0aGluZz8KPiAK
PiAKPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQgd2FzIGEgc2FtcGxlIGRyaXZlciBpbiAv
ZG9jLiBJdCBzaG91bGQgbm90IGJlCj4gdXNlZCBpbiBwcm9kdWN0aW9uIGVudmlyb25tZW50LiBP
dGhlcndpc2Ugd2UgbmVlZCB0byBtb3ZlIGl0IHRvCj4gZHJpdmVyL3ZpcnRpby4KPiAKPiBCdXQg
aWYgeW91IGluc2lzdCwgSSBjYW4gcG9zdCBhIFYxMS4KPiAKPiBUaGFua3MKCnRoaXMgY2FuIGJl
IGEgcGF0Y2ggb24gdG9wLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

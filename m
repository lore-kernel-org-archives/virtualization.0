From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 21:40:09 +0800
Message-ID: <29d92758-18f7-15c7-fd04-0556b1f9033c__39864.2460045934$1573134079$gmane$org@redhat.com>
References: <20191106133531.693-1-jasowang@redhat.com>
	<20191106133531.693-7-jasowang@redhat.com>
	<20191107040700-mutt-send-email-mst@kernel.org>
	<bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
	<20191107061942-mutt-send-email-mst@kernel.org>
	<d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
	<c588c724-04da-2991-9f88-f36c0d04364a@redhat.com>
	<20191107080721-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191107080721-mutt-send-email-mst@kernel.org>
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
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, parav@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, stefanha@redhat.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTEvNyDkuIvljYg5OjA4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBOb3YgMDcsIDIwMTkgYXQgMDg6NDc6MDZQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAxOS8xMS83IOS4i+WNiDg6NDMsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiAyMDE5
LzExLzcg5LiL5Y2INzoyMSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+Pj4+IE9uIFRodSwg
Tm92IDA3LCAyMDE5IGF0IDA2OjE4OjQ1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+
IE9uIDIwMTkvMTEvNyDkuIvljYg1OjA4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+
PiBPbiBXZWQsIE5vdiAwNiwgMjAxOSBhdCAwOTozNTozMVBNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+Pj4+Pj4+IFRoaXMgc2FtcGxlIGRyaXZlciBjcmVhdGVzIG1kZXYgZGV2aWNlIHRoYXQg
c2ltdWxhdGUKPj4+Pj4+PiB2aXJ0aW8gbmV0IGRldmljZQo+Pj4+Pj4+IG92ZXIgdmlydGlvIG1k
ZXYgdHJhbnNwb3J0LiBUaGUgZGV2aWNlIGlzIGltcGxlbWVudGVkIHRocm91Z2ggdnJpbmdoCj4+
Pj4+Pj4gYW5kIHdvcmtxdWV1ZS4gQSBkZXZpY2Ugc3BlY2lmaWMgZG1hIG9wcyBpcyB0byBtYWtl
IHN1cmUgSFZBIGlzIHVzZWQKPj4+Pj4+PiBkaXJlY3RseSBhcyB0aGUgSU9WQS4gVGhpcyBzaG91
bGQgYmUgc3VmZmljaWVudCBmb3Iga2VybmVsIHZpcnRpbwo+Pj4+Pj4+IGRyaXZlciB0byB3b3Jr
Lgo+Pj4+Pj4+Cj4+Pj4+Pj4gT25seSAndmlydGlvJyB0eXBlIGlzIHN1cHBvcnRlZCByaWdodCBu
b3cuIEkgcGxhbiB0byBhZGQgJ3Zob3N0JyB0eXBlCj4+Pj4+Pj4gb24gdG9wIHdoaWNoIHJlcXVp
cmVzIHNvbWUgdmlydHVhbCBJT01NVSBpbXBsZW1lbnRlZCBpbiB0aGlzIHNhbXBsZQo+Pj4+Pj4+
IGRyaXZlci4KPj4+Pj4+Pgo+Pj4+Pj4+IEFja2VkLWJ5OiBDb3JuZWxpYSBIdWNrPGNvaHVja0By
ZWRoYXQuY29tPgo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmc8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPj4+Pj4+IEknZCBwcmVmZXIgaXQgdGhhdCB3ZSBjYWxsIHRoaXMgc29tZXRoaW5n
IGVsc2UsIGUuZy4KPj4+Pj4+IG12bmV0LWxvb3BiYWNrLiBKdXN0IHNvIHBlb3BsZSBkb24ndCBl
eHBlY3QgYSBmdWxseQo+Pj4+Pj4gZnVuY3Rpb25hbCBkZXZpY2Ugc29tZWhvdy4gQ2FuIGJlIHJl
bmFtZWQgd2hlbiBhcHBseWluZz8KPj4+Pj4gQWN0dWFsbHksIEkgcGxhbiB0byBleHRlbmQgaXQg
YXMgYW5vdGhlciBzdGFuZGFyZCBuZXR3b3JrIGludGVyZmFjZSBmb3IKPj4+Pj4ga2VybmVsLiBJ
dCBjb3VsZCBiZSBlaXRoZXIgYSBzdGFuZGFsb25lIHBzZXVkbyBkZXZpY2Ugb3IgYSBzdGFjawo+
Pj4+PiBkZXZpY2UuCj4+Pj4+IERvZXMgdGhpcyBzb3VuZHMgZ29vZCB0byB5b3U/Cj4+Pj4+Cj4+
Pj4+IFRoYW5rcwo+Pj4+IFRoYXQncyBhIGJpZyBjaGFuZ2UgaW4gYW4gaW50ZXJmYWNlIHNvIGl0
J3MgYSBnb29kIHJlYXNvbgo+Pj4+IHRvIHJlbmFtZSB0aGUgZHJpdmVyIGF0IHRoYXQgcG9pbnQg
cmlnaHQ/Cj4+Pj4gT2hlcndpc2UgdXNlcnMgb2YgYW4gb2xkIGtlcm5lbCB3b3VsZCBleHBlY3Qg
YSBzdGFja2VkIGRyaXZlcgo+Pj4+IGFuZCBnZXQgYSBsb29wYmFjayBpbnN0ZWFkLgo+Pj4+Cj4+
Pj4gT3IgZGlkIEkgbWlzcyBzb21ldGhpbmc/Cj4+Pgo+Pj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0
aGF0IGl0IHdhcyBhIHNhbXBsZSBkcml2ZXIgaW4gL2RvYy4gSXQgc2hvdWxkIG5vdAo+Pj4gYmUg
dXNlZCBpbiBwcm9kdWN0aW9uIGVudmlyb25tZW50LiBPdGhlcndpc2Ugd2UgbmVlZCB0byBtb3Zl
IGl0IHRvCj4+PiBkcml2ZXIvdmlydGlvLgo+Pj4KPj4+IEJ1dCBpZiB5b3UgaW5zaXN0LCBJIGNh
biBwb3N0IGEgVjExLgo+Pj4KPj4+IFRoYW5rcwo+Pgo+PiBPciBtYXliZSBpdCdzIGJldHRlciB0
byByZW5hbWUgdGhlIHR5cGUgb2YgY3VycmVudCBtZGV2IGZyb20gJ3ZpcnRpbycgdG8KPj4gJ3Zp
cnRpby1sb29wYmFjaycuIFRoZW4gd2UgY2FuIGFkZCBtb3JlIHR5cGVzIGluIHRoZSBmdXR1cmUu
Cj4+Cj4+IFRoYW5rcwo+Pgo+IE1heWJlIGJ1dCBpcyB2aXJ0aW8gYWN0dWFsbHkgYSBsb29wYmFj
ayBzb21laG93PyBJIHRob3VnaHQgd2UKPiBjYW4gYmluZCBhIHJlZ3VsYXIgdmlydGlvIGRldmlj
ZSB0aGVyZSwgbm8/CgoKSXQgaGFzIGEgcHJlZml4LCBzbyB1c2VyIHdpbGwgc2VlICJtdm5ldC12
aXJ0aW8tbG9vcGJhY2siLgoKVGhhbmtzCgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 20:47:06 +0800
Message-ID: <c588c724-04da-2991-9f88-f36c0d04364a__30006.8745667645$1573130878$gmane$org@redhat.com>
References: <20191106133531.693-1-jasowang@redhat.com>
	<20191106133531.693-7-jasowang@redhat.com>
	<20191107040700-mutt-send-email-mst@kernel.org>
	<bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
	<20191107061942-mutt-send-email-mst@kernel.org>
	<d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
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

Ck9uIDIwMTkvMTEvNyDkuIvljYg4OjQzLCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gT24gMjAxOS8x
MS83IOS4i+WNiDc6MjEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4gT24gVGh1LCBOb3Yg
MDcsIDIwMTkgYXQgMDY6MTg6NDVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+IE9uIDIw
MTkvMTEvNyDkuIvljYg1OjA4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4gT24gV2Vk
LCBOb3YgMDYsIDIwMTkgYXQgMDk6MzU6MzFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+
Pj4gVGhpcyBzYW1wbGUgZHJpdmVyIGNyZWF0ZXMgbWRldiBkZXZpY2UgdGhhdCBzaW11bGF0ZSB2
aXJ0aW8gbmV0IAo+Pj4+PiBkZXZpY2UKPj4+Pj4gb3ZlciB2aXJ0aW8gbWRldiB0cmFuc3BvcnQu
IFRoZSBkZXZpY2UgaXMgaW1wbGVtZW50ZWQgdGhyb3VnaCB2cmluZ2gKPj4+Pj4gYW5kIHdvcmtx
dWV1ZS4gQSBkZXZpY2Ugc3BlY2lmaWMgZG1hIG9wcyBpcyB0byBtYWtlIHN1cmUgSFZBIGlzIHVz
ZWQKPj4+Pj4gZGlyZWN0bHkgYXMgdGhlIElPVkEuIFRoaXMgc2hvdWxkIGJlIHN1ZmZpY2llbnQg
Zm9yIGtlcm5lbCB2aXJ0aW8KPj4+Pj4gZHJpdmVyIHRvIHdvcmsuCj4+Pj4+Cj4+Pj4+IE9ubHkg
J3ZpcnRpbycgdHlwZSBpcyBzdXBwb3J0ZWQgcmlnaHQgbm93LiBJIHBsYW4gdG8gYWRkICd2aG9z
dCcgdHlwZQo+Pj4+PiBvbiB0b3Agd2hpY2ggcmVxdWlyZXMgc29tZSB2aXJ0dWFsIElPTU1VIGlt
cGxlbWVudGVkIGluIHRoaXMgc2FtcGxlCj4+Pj4+IGRyaXZlci4KPj4+Pj4KPj4+Pj4gQWNrZWQt
Ynk6IENvcm5lbGlhIEh1Y2s8Y29odWNrQHJlZGhhdC5jb20+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IEphc29uIFdhbmc8amFzb3dhbmdAcmVkaGF0LmNvbT4KPj4+PiBJJ2QgcHJlZmVyIGl0IHRoYXQg
d2UgY2FsbCB0aGlzIHNvbWV0aGluZyBlbHNlLCBlLmcuCj4+Pj4gbXZuZXQtbG9vcGJhY2suIEp1
c3Qgc28gcGVvcGxlIGRvbid0IGV4cGVjdCBhIGZ1bGx5Cj4+Pj4gZnVuY3Rpb25hbCBkZXZpY2Ug
c29tZWhvdy4gQ2FuIGJlIHJlbmFtZWQgd2hlbiBhcHBseWluZz8KPj4+IEFjdHVhbGx5LCBJIHBs
YW4gdG8gZXh0ZW5kIGl0IGFzIGFub3RoZXIgc3RhbmRhcmQgbmV0d29yayBpbnRlcmZhY2UgZm9y
Cj4+PiBrZXJuZWwuIEl0IGNvdWxkIGJlIGVpdGhlciBhIHN0YW5kYWxvbmUgcHNldWRvIGRldmlj
ZSBvciBhIHN0YWNrIAo+Pj4gZGV2aWNlLgo+Pj4gRG9lcyB0aGlzIHNvdW5kcyBnb29kIHRvIHlv
dT8KPj4+Cj4+PiBUaGFua3MKPj4gVGhhdCdzIGEgYmlnIGNoYW5nZSBpbiBhbiBpbnRlcmZhY2Ug
c28gaXQncyBhIGdvb2QgcmVhc29uCj4+IHRvIHJlbmFtZSB0aGUgZHJpdmVyIGF0IHRoYXQgcG9p
bnQgcmlnaHQ/Cj4+IE9oZXJ3aXNlIHVzZXJzIG9mIGFuIG9sZCBrZXJuZWwgd291bGQgZXhwZWN0
IGEgc3RhY2tlZCBkcml2ZXIKPj4gYW5kIGdldCBhIGxvb3BiYWNrIGluc3RlYWQuCj4+Cj4+IE9y
IGRpZCBJIG1pc3Mgc29tZXRoaW5nPwo+Cj4KPiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaXQg
d2FzIGEgc2FtcGxlIGRyaXZlciBpbiAvZG9jLiBJdCBzaG91bGQgbm90IAo+IGJlIHVzZWQgaW4g
cHJvZHVjdGlvbiBlbnZpcm9ubWVudC4gT3RoZXJ3aXNlIHdlIG5lZWQgdG8gbW92ZSBpdCB0byAK
PiBkcml2ZXIvdmlydGlvLgo+Cj4gQnV0IGlmIHlvdSBpbnNpc3QsIEkgY2FuIHBvc3QgYSBWMTEu
Cj4KPiBUaGFua3MgCgoKT3IgbWF5YmUgaXQncyBiZXR0ZXIgdG8gcmVuYW1lIHRoZSB0eXBlIG9m
IGN1cnJlbnQgbWRldiBmcm9tICd2aXJ0aW8nIHRvIAondmlydGlvLWxvb3BiYWNrJy4gVGhlbiB3
ZSBjYW4gYWRkIG1vcmUgdHlwZXMgaW4gdGhlIGZ1dHVyZS4KClRoYW5rcwoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==

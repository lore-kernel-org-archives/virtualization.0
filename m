From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
	implement virtio-mdev framework
Date: Thu, 7 Nov 2019 21:32:29 +0800
Message-ID: <b2265e3a-6f86-c21a-2ebd-d0e4eea2886f__33927.7144799539$1573133606$gmane$org@redhat.com>
References: <20191106133531.693-1-jasowang@redhat.com>
	<20191106133531.693-7-jasowang@redhat.com>
	<20191107040700-mutt-send-email-mst@kernel.org>
	<bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
	<20191107061942-mutt-send-email-mst@kernel.org>
	<d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
	<20191107080834-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191107080834-mutt-send-email-mst@kernel.org>
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

Ck9uIDIwMTkvMTEvNyDkuIvljYg5OjA4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
VGh1LCBOb3YgMDcsIDIwMTkgYXQgMDg6NDM6MjlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gT24gMjAxOS8xMS83IOS4i+WNiDc6MjEsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPj4+
IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDA2OjE4OjQ1UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4gT24gMjAxOS8xMS83IOS4i+WNiDU6MDgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90
ZToKPj4+Pj4gT24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDk6MzU6MzFQTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPj4+Pj4+IFRoaXMgc2FtcGxlIGRyaXZlciBjcmVhdGVzIG1kZXYgZGV2aWNl
IHRoYXQgc2ltdWxhdGUgdmlydGlvIG5ldCBkZXZpY2UKPj4+Pj4+IG92ZXIgdmlydGlvIG1kZXYg
dHJhbnNwb3J0LiBUaGUgZGV2aWNlIGlzIGltcGxlbWVudGVkIHRocm91Z2ggdnJpbmdoCj4+Pj4+
PiBhbmQgd29ya3F1ZXVlLiBBIGRldmljZSBzcGVjaWZpYyBkbWEgb3BzIGlzIHRvIG1ha2Ugc3Vy
ZSBIVkEgaXMgdXNlZAo+Pj4+Pj4gZGlyZWN0bHkgYXMgdGhlIElPVkEuIFRoaXMgc2hvdWxkIGJl
IHN1ZmZpY2llbnQgZm9yIGtlcm5lbCB2aXJ0aW8KPj4+Pj4+IGRyaXZlciB0byB3b3JrLgo+Pj4+
Pj4KPj4+Pj4+IE9ubHkgJ3ZpcnRpbycgdHlwZSBpcyBzdXBwb3J0ZWQgcmlnaHQgbm93LiBJIHBs
YW4gdG8gYWRkICd2aG9zdCcgdHlwZQo+Pj4+Pj4gb24gdG9wIHdoaWNoIHJlcXVpcmVzIHNvbWUg
dmlydHVhbCBJT01NVSBpbXBsZW1lbnRlZCBpbiB0aGlzIHNhbXBsZQo+Pj4+Pj4gZHJpdmVyLgo+
Pj4+Pj4KPj4+Pj4+IEFja2VkLWJ5OiBDb3JuZWxpYSBIdWNrPGNvaHVja0ByZWRoYXQuY29tPgo+
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZzxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pj4+
PiBJJ2QgcHJlZmVyIGl0IHRoYXQgd2UgY2FsbCB0aGlzIHNvbWV0aGluZyBlbHNlLCBlLmcuCj4+
Pj4+IG12bmV0LWxvb3BiYWNrLiBKdXN0IHNvIHBlb3BsZSBkb24ndCBleHBlY3QgYSBmdWxseQo+
Pj4+PiBmdW5jdGlvbmFsIGRldmljZSBzb21laG93LiBDYW4gYmUgcmVuYW1lZCB3aGVuIGFwcGx5
aW5nPwo+Pj4+IEFjdHVhbGx5LCBJIHBsYW4gdG8gZXh0ZW5kIGl0IGFzIGFub3RoZXIgc3RhbmRh
cmQgbmV0d29yayBpbnRlcmZhY2UgZm9yCj4+Pj4ga2VybmVsLiBJdCBjb3VsZCBiZSBlaXRoZXIg
YSBzdGFuZGFsb25lIHBzZXVkbyBkZXZpY2Ugb3IgYSBzdGFjayBkZXZpY2UuCj4+Pj4gRG9lcyB0
aGlzIHNvdW5kcyBnb29kIHRvIHlvdT8KPj4+Pgo+Pj4+IFRoYW5rcwo+Pj4gVGhhdCdzIGEgYmln
IGNoYW5nZSBpbiBhbiBpbnRlcmZhY2Ugc28gaXQncyBhIGdvb2QgcmVhc29uCj4+PiB0byByZW5h
bWUgdGhlIGRyaXZlciBhdCB0aGF0IHBvaW50IHJpZ2h0Pwo+Pj4gT2hlcndpc2UgdXNlcnMgb2Yg
YW4gb2xkIGtlcm5lbCB3b3VsZCBleHBlY3QgYSBzdGFja2VkIGRyaXZlcgo+Pj4gYW5kIGdldCBh
IGxvb3BiYWNrIGluc3RlYWQuCj4+Pgo+Pj4gT3IgZGlkIEkgbWlzcyBzb21ldGhpbmc/Cj4+Cj4+
IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBpdCB3YXMgYSBzYW1wbGUgZHJpdmVyIGluIC9kb2Mu
IEl0IHNob3VsZCBub3QgYmUKPj4gdXNlZCBpbiBwcm9kdWN0aW9uIGVudmlyb25tZW50LiBPdGhl
cndpc2Ugd2UgbmVlZCB0byBtb3ZlIGl0IHRvCj4+IGRyaXZlci92aXJ0aW8uCj4+Cj4+IEJ1dCBp
ZiB5b3UgaW5zaXN0LCBJIGNhbiBwb3N0IGEgVjExLgo+Pgo+PiBUaGFua3MKPiB0aGlzIGNhbiBi
ZSBhIHBhdGNoIG9uIHRvcC4KCgpUaGVuIG1heWJlIGl0J3MgYmV0dGVyIGp1c3QgZXh0ZW5kIGl0
IHRvIHdvcmsgYXMgYSBub3JtYWwgbmV0d29ya2luZyAKZGV2aWNlIG9uIHRvcD8KClRoYW5rcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u

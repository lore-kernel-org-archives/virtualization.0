From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/6] vringh: fix copy direction of vringh_iov_push_kern()
Date: Wed, 25 Sep 2019 19:56:33 +0800
Message-ID: <2f145744-cbfb-5bc3-0e2c-e8c23c20b42d__17261.0833238409$1569412679$gmane$org@redhat.com>
References: <20190923130331.29324-1-jasowang@redhat.com>
	<20190923130331.29324-6-jasowang@redhat.com>
	<20190923094559.765da494@x1.home>
	<20190923115930-mutt-send-email-mst@kernel.org>
	<20190924080413.0cc875c5@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190924080413.0cc875c5@x1.home>
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
To: Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@inte
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS8yNCDkuIvljYgxMDowNCwgQWxleCBXaWxsaWFtc29uIHdyb3RlOgo+IE9uIE1v
biwgMjMgU2VwIDIwMTkgMTI6MDA6NDEgLTA0MDAKPiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4+IE9uIE1vbiwgU2VwIDIzLCAyMDE5IGF0IDA5OjQ1OjU5
QU0gLTA2MDAsIEFsZXggV2lsbGlhbXNvbiB3cm90ZToKPj4+IE9uIE1vbiwgMjMgU2VwIDIwMTkg
MjE6MDM6MzAgKzA4MDAKPj4+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3Rl
Ogo+Pj4gICAKPj4+PiBXZSB3YW50IHRvIGNvcHkgZnJvbSBpb3YgdG8gYnVmLCBzbyB0aGUgZGly
ZWN0aW9uIHdhcyB3cm9uZy4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+Cj4+Pj4gLS0tCj4+Pj4gIGRyaXZlcnMvdmhvc3QvdnJpbmdoLmMg
fCA4ICsrKysrKystCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkgIAo+Pj4gV2h5IGlzIHRoaXMgaW5jbHVkZWQgaW4gdGhlIHNlcmllcz8gIFNlZW1z
IGxpa2UgYW4gdW5yZWxhdGVkIGZpeCBiZWluZwo+Pj4gaGVsZCB1cCB3aXRoaW4gYSBwcm9wb3Nh
bCBmb3IgYSBuZXcgZmVhdHVyZS4gIFRoYW5rcywKPj4+Cj4+PiBBbGV4ICAKPj4gSXQncyBiZXR0
ZXIgdG8gaGF2ZSBpdCBhcyBwYXRjaCAxLzYsIGJ1dCBpdCdzIGEgZGVwZW5kZW5jeSBvZiB0aGUK
Pj4gZXhhbXBsZSBkcml2ZXIgaW4gdGhlIHNlcmllcy4gSSBjYW4gcmVvcmRlciB3aGVuIEkgYXBw
bHkuCj4gSXQncyBhIGZpeCwgcGxlYXNlIHN1Ym1pdCBpdCBzZXBhcmF0ZWx5IHRocm91Z2ggdmly
dGlvL3Zob3N0IGNoYW5uZWxzLAo+IHRoZW4gaXQgd2lsbCBhbHJlYWR5IGJlIGluIHRoZSBiYXNl
IGtlcm5lbCB3ZSB1c2UgZm9yIHRoZSByZXN0IG9mIHRoZQo+IHNlcmllcy4gIFRoZSByZW1haW5k
ZXIgb2YgdGhlIHNlcmllcyBjZXJ0YWlubHkgc3VnZ2VzdHMgYSB3b3JrZmxvdwo+IHRocm91Z2gg
dGhlIHZmaW8gdHJlZSByYXRoZXIgdGhhbiB2aXJ0aW8vdmhvc3QuICBUaGFua3MsCj4KPiBBbGV4
CgoKT2suCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

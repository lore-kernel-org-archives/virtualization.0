From: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
	ring
Date: Thu, 13 Sep 2018 17:47:29 +0800
Message-ID: <98d6bd4d-45e2-4207-e961-782f649e0139__305.537627036934$1536831944$gmane$org@redhat.com>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
	<20180827170005-mutt-send-email-mst@kernel.org>
	<20180907012225.GA32677@debian>
	<20180907084509-mutt-send-email-mst@kernel.org>
	<20180910030053.GA15645@debian>
	<f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
	<20180911053726.GA7472@debian>
	<20180912121457-mutt-send-email-mst@kernel.org>
	<20180913085919.GA42049@fbsd1.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180913085919.GA42049@fbsd1.sh.intel.com>
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
To: Tiwei Bie <tiwei.bie@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDnmnIgxM+aXpSAxNjo1OSwgVGl3ZWkgQmllIHdyb3RlOgo+PiBJZiB3aGF0
IHlvdSBzYXkgaXMgdHJ1ZSB0aGVuIHdlIHNob3VsZCB0YWtlIGEgY2FyZWZ1bCBsb29rCj4+IGFu
ZCBub3Qgc3VwcG9ydGluZyB0aGVzZSBnZW5lcmljIHRoaW5ncyB3aXRoIHBhY2tlZCBsYXlvdXQu
Cj4+IE9uY2Ugd2UgZG8gc3VwcG9ydCB0aGVtIGl0IHdpbGwgYmUgdG9vIGxhdGUgYW5kIHdlIHdv
bid0Cj4+IGJlIGFibGUgdG8gZ2V0IHBlcmZvcm1hbmNlIGJhY2suCj4gSSB0aGluayBpdCdzIGEg
Z29vZCBwb2ludCB0aGF0IHdlIGRvbid0IG5lZWQgdG8gc3VwcG9ydAo+IGV2ZXJ5dGhpbmcgaW4g
cGFja2VkIHJpbmcgKGVzcGVjaWFsbHkgdGhlc2Ugd2hpY2ggd291bGQKPiBodXJ0IHRoZSBwZXJm
b3JtYW5jZSksIGFzIHRoZSBwYWNrZWQgcmluZyBhaW1zIGF0IGhpZ2gKPiBwZXJmb3JtYW5jZS4g
SSdtIGFsc28gd29uZGVyaW5nIGFib3V0IHRoZSBmZWF0dXJlcy4gSXMKPiB0aGVyZSBhbnkgcG9z
c2liaWxpdHkgdGhhdCB3ZSB3b24ndCBzdXBwb3J0IHRoZSBvdXQgb2YKPiBvcmRlciBwcm9jZXNz
aW5nIChhdCBsZWFzdCBub3QgYnkgZGVmYXVsdCkgaW4gcGFja2VkIHJpbmc/Cj4gSWYgSSBkaWRu
J3QgbWlzcyBhbnl0aGluZywgdGhlIG5lZWQgdG8gc3VwcG9ydCBvdXQgb2Ygb3JkZXIKPiBwcm9j
ZXNzaW5nIGluIHBhY2tlZCByaW5nIHdpbGwgbWFrZSB0aGUgZGF0YSBzdHJ1Y3R1cmUKPiBpbnNp
ZGUgdGhlIGRyaXZlciBub3QgY2FjaGUgZnJpZW5kbHkgd2hpY2ggaXMgc2ltaWxhciB0bwo+IHRo
ZSBjYXNlIG9mIHRoZSBkZXNjcmlwdG9yIHRhYmxlIGluIHRoZSBzcGxpdCByaW5nICh0aGUKPiBk
aWZmZXJlbmNlIGlzIHRoYXQsIGl0IG9ubHkgaGFwcGVucyBpbiBkcml2ZXIgbm93KS4KCk91dCBv
ZiBvcmRlciBpcyBub3QgdGhlIG9ubHkgdXNlciwgRE1BIGlzIGFub3RoZXIgb25lLiBXZSBkb24n
dCBoYXZlIAp1c2VkIHJpbmcobGVuKSwgc28gd2UgbmVlZCB0byBtYWludGFpbiBidWZmZXIgbGVu
Z3RoIHNvbWV3aGVyZSBldmVuIGZvciAKaW4gb3JkZXIgZGV2aWNlLiBCdXQgaWYgaXQncyBub3Qg
dG9vIGxhdGUsIEkgc2Vjb25kIGZvciBhIE9VVF9PRl9PUkRFUiAKZmVhdHVyZS4gU3RhcnRpbmcg
ZnJvbSBpbiBvcmRlciBjYW4gaGF2ZSBtdWNoIHNpbXBsZXIgY29kZSBpbiBkcml2ZXIuCgpUaGFu
a3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==

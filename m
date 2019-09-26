From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 6/8] mdev: introduce virtio device and its device ops
Date: Thu, 26 Sep 2019 08:15:09 -0400
Message-ID: <20190926081506-mutt-send-email-mst__28505.3152054147$1569500136$gmane$org@kernel.org>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-7-jasowang@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F7DA@SHSMSX104.ccr.corp.intel.com>
	<2210d23d-38e4-e654-e53d-7867348de86a@redhat.com>
	<20190925092044-mutt-send-email-mst@kernel.org>
	<eb7c76b5-2938-2e73-d847-b174a289c5c9@redhat.com>
	<20190926042102-mutt-send-email-mst@kernel.org>
	<d6a66de5-5774-5ad6-8e9d-26bb6d8eaa8c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6a66de5-5774-5ad6-8e9d-26bb6d8eaa8c@redhat.com>
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
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, haotian.
List-Id: virtualization@lists.linuxfoundation.org

T24gVGh1LCBTZXAgMjYsIDIwMTkgYXQgMDY6NDg6NTRQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDE5LzkvMjYg5LiL5Y2INDoyMSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVGh1LCBTZXAgMjYsIDIwMTkgYXQgMTI6MDQ6NDZQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIGhvdyBzdGFibGUgYWJvdmUgb3BzIGFy
ZS4KPiA+ID4gPiA+IEl0J3MgdGhlIGtlcm5lbCBpbnRlcm5hbCBBUEksIHNvIHRoZXJlJ3Mgbm8g
c3RyaWN0IHJlcXVpcmVtZW50IGZvciB0aGlzLiBXZQo+ID4gPiA+ID4gd2lsbCBleHBvcnQgYSB2
ZXJzaW9uIHZhbHVlIGZvciB1c2Vyc3BhY2UgZm9yIGNvbXBhdGliaWxpdHkuCj4gPiA+ID4gR2l2
ZW4gaXQncyB0aWVkIHRvIHZpcnRpbyB3ZSBwcm9iYWJseSB3YW50IGtlcm5lbCt1c2Vyc3BhY2UK
PiA+ID4gPiBmZWF0dXJlIGJpdHM/Cj4gPiA+IAo+ID4gPiBZZXMsIHRoZW4gSSB0aGluayB3ZSBj
b3VsZCBwcm9iYWJseSBoYXZlIGEgdmVyc2lvbiBmaWVsZCBpbnNpZGUgZS5nCj4gPiA+IGRldmlj
ZV9vcHMgc3RydWN0dXJlLiBUaGVuIGl0IGNvdWxkIGJlIGZldGNoZWQgZnJvbSBib3RoIGtlcm5l
bCBhbmQKPiA+ID4gdXNlcnNwYWNlIGRyaXZlci4KPiA+ID4gCj4gPiA+IFRoYW5rcwo+ID4gPiAK
PiA+IAo+ID4gbXkgcG9pbnQgd2FzIGZlYXR1cmUgYml0cyBub3QgYSB2ZXJzaW9uIG51bWJlci4K
PiAKPiAKPiBTb21ldGhpbmcgbGlrZSBiYWNrZW5kX2ZlYXR1cmUgdGhhdCBjdXJyZW50IHZob3N0
X25ldCBkaWQ/Cj4gCj4gVGhhbmtzCj4gCj4gCj4gPiAKCnJpZ2h0Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

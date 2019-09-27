From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 5/8] mdev: introduce device specific ops
Date: Fri, 27 Sep 2019 16:04:25 +0800
Message-ID: <c532d7ce-90be-6456-a630-96f56cb6409d@redhat.com>
References: <20190924135332.14160-1-jasowang@redhat.com>
	<20190924135332.14160-6-jasowang@redhat.com>
	<20190924170638.064d85f7@x1.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D58F754@SHSMSX104.ccr.corp.intel.com>
	<CAJPjb1+i7jb0aVfr=7CDuUBpeo_w3wAfTrnmuLVJ-h+qOV+1hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJPjb1+i7jb0aVfr=7CDuUBpeo_w3wAfTrnmuLVJ-h+qOV+1hw@mail.gmail.com>
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
To: Rob Miller <rob.miller@broadcom.com>, "Tian, Kevin" <kevin.tian@intel.com>
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "parav@mellanox.com" <parav@mellanox.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "lulu@redhat.com" <lulu@redhat.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "haotian.wang@sifive.com" <haoti>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvOS8yNSDkuIvljYgxMDoxMSwgUm9iIE1pbGxlciB3cm90ZToKPgo+ID4gPsKgIMKg
IMKgbWRldl9zZXRfY2xhc3NfaWQobWRldiwgTURFVl9JRF9WRklPKTsKPiA+ID4gK8KgIMKgbWRl
dl9zZXRfZGV2X29wcyhtZGV2LCAmaW50ZWxfdmZpb192Z3B1X2Rldl9vcHMpOwo+ID4KPiA+IFRo
aXMgc2VlbXMgcmF0aGVyIHVucmVmaW5lZC7CoCBXZSdyZSByZWdpc3RlcmluZyBpbnRlcmRlcGVu
ZGVudCBkYXRhIGluCj4gPiBzZXBhcmF0ZSBjYWxscy7CoCBBbGwgZHJpdmVycyBuZWVkIHRvIG1h
a2UgYm90aCBvZiB0aGVzZSBjYWxscy7CoCBJJ20gbm90Cj4gPiBzdXJlIGlmIHRoaXMgaXMgYSBn
b29kIGlkZWEsIGJ1dCB3aGF0IGlmIHdlIGhhZDoKPiA+Cj4gPiBzdGF0aWMgY29uc3Qgc3RydWN0
IHZmaW9fbWRldl9kZXZpY2Vfb3BzIGludGVsX3ZmaW9fdmdwdV9kZXZfb3BzID0gewo+ID7CoCDC
oCDCoCDCoC5pZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPSBNREVWX0lEX1ZGSU8s
Cj4gPsKgIMKgIMKgIMKgLm9wZW7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoD0gaW50ZWxf
dmdwdV9vcGVuLAo+ID7CoCDCoCDCoCDCoC5yZWxlYXNlwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
PSBpbnRlbF92Z3B1X3JlbGVhc2UsCj4gPsKgIMKgIMKgIMKgIMKgLi4uCj4gPgo+ID4gQW5kIHRo
ZSBzZXQgZnVuY3Rpb24gcGFzc2VkICZpbnRlbF92ZmlvX3ZncHVfZGV2X29wcy5pZCAKPiA8aHR0
cDovL2ludGVsX3ZmaW9fdmdwdV9kZXZfb3BzLmlkPiBhbmQgdGhlIG1kZXYKPiA+IGJ1cyBkcml2
ZXJzIHVzZWQgY29udGFpbmVyX29mIHRvIGdldCB0byB0aGVpciBjYWxsYmFja3M/Cj4KPiBvciBq
dXN0IG1ha2UgaXQgZXhwbGljaXQ/IGUuZy4KPgo+IG1kZXZfc2V0X2NsYXNzKG1kZXYsIE1ERVZf
SURfVkZJTywgJmludGVsX3ZmaW9fdmdwdV9kZXZfb3BzKTsKCgpZZXMsIHRoaXMgc2VlbXMgZXZl
biBiZXR0ZXIuCgpXaWxsIGRvIHRoaXMgaW4gVjMuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

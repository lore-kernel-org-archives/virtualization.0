From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 1/7] mdev: class id support
Date: Thu, 17 Oct 2019 16:27:41 +0800
Message-ID: <67b645a6-1b70-094d-6a12-fc6591e07a13__2200.69756485231$1571300905$gmane$org@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-2-jasowang@redhat.com>
	<AM0PR05MB4866481AEE614FDF766C6A25D1920@AM0PR05MB4866.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AM0PR05MB4866481AEE614FDF766C6A25D1920@AM0PR05MB4866.eurprd05.prod.outlook.com>
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
To: Parav Pandit <parav@mellanox.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "tiwei.bie@intel.com" <tiwei.bie@intel.com>
Cc: "christophe.de.dinechin@gmail.com" <christophe.de.dinechin@gmail.com>, "sebott@linux.ibm.com" <sebott@linux.ibm.com>, "airlied@linux.ie" <airlied@linux.ie>, "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "zhi.a.wang@intel.com" <zhi.a.wang@intel.com>, "farman@linux.ibm.com" <farman@linux.ibm.com>, Ido Shamay <idos@mellanox.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>ro
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMTYg5LiL5Y2IMTI6NTcsIFBhcmF2IFBhbmRpdCB3cm90ZToKPj4gK3N0YXRp
YyBzdHJ1Y3QgbWRldl9jbGFzc19pZCBpZF90YWJsZVtdID0gewo+IHN0YXRpYyBjb25zdAo+Cj4+
ICsJeyBNREVWX0lEX1ZGSU8gfSwKPiBJIGd1ZXNzIHlvdSBkb24ndCBuZWVkIGV4dHJhIGJyYWNl
cyBmb3IgZWFjaCBlbnRyeS4KPiBTaW5jZSB0aGlzIGVudW0gcmVwcmVzZW50cyBNREVWIGNsYXNz
IGlkLCBpdCBiZXR0ZXIgdG8gbmFtZSBpdCBhcyBNREVWX0NMQVNTX0lEX1ZGSU8uCj4gKFNpbWls
YXIgdG8gIFBDSV9WRU5ET1JfSUQsIFBDSV9ERVZJQ0VfSUQpLi4KPgoKR2NjIHN0YXJ0IHRvIGNv
bXBsYWluIGxpa2U6Cgp3YXJuaW5nOiBtaXNzaW5nIGJyYWNlcyBhcm91bmQgaW5pdGlhbGl6ZXIg
Wy1XbWlzc2luZy1icmFjZXNdCiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWRldl9jbGFzc19pZCBp
ZF90YWJsZVtdID0gewogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeCiDC
oCBNREVWX0lEX1ZGSU8sIDAsCiDCoCB7wqDCoMKgwqDCoMKgwqDCoMKgwqAgfSB7CiDCoH07CiDC
oH0KClNvIEkgd2lsbCBrZWVwIHRoaXMgcGFydCB1bnRvdWNoZWQuCgpUaGFua3MKCgo+PiArCXsg
MCB9LAo+PiArfTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

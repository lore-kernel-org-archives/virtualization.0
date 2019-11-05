From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V7 3/6] mdev: introduce device specific ops
Date: Tue, 5 Nov 2019 11:17:28 +0800
Message-ID: <47ecfe09-0954-9517-3ac5-68db8522826d__25690.7434247964$1572923980$gmane$org@redhat.com>
References: <20191104123952.17276-1-jasowang@redhat.com>
	<20191104123952.17276-4-jasowang@redhat.com>
	<20191104145008.4b6839f0@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191104145008.4b6839f0@x1.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: stefanha@redhat.com, christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.ke
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTEvNSDkuIrljYg1OjUwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4+ICAgRVhQ
T1JUX1NZTUJPTChtZGV2X3NldF9kcnZkYXRhKTsKPj4gICAKPj4gKwo+IEV4dHJhIHdoaXRlc3Bh
Y2UKPgo+PiAgIC8qIFNwZWNpZnkgdGhlIGNsYXNzIGZvciB0aGUgbWRldiBkZXZpY2UsIHRoaXMg
bXVzdCBiZSBjYWxsZWQgZHVyaW5nCj4+IC0gKiBjcmVhdGUoKSBjYWxsYmFjay4KPj4gLSAqLwo+
PiArICogY3JlYXRlKCkgY2FsbGJhY2sgZXhwbGljaXRseSBvciBpbXBsaWNpdHkgdGhyb3VnaCB0
aGUgaGVscGVycwo+IHMvaW1wbGljaXR5L2ltcGxpY2l0bHkvCj4KPj4gKyAqIHByb3ZpZGVkIGJ5
IGVhY2ggY2xhc3MuICovCj4+ICAgdm9pZCBtZGV2X3NldF9jbGFzcyhzdHJ1Y3QgbWRldl9kZXZp
Y2UgKm1kZXYsIHUxNiBpZCkKPj4gICB7Cj4+ICAgCVdBUk5fT04obWRldi0+Y2xhc3NfaWQpOwo+
PiBAQCAtNTUsNiArNTYsMjYgQEAgdm9pZCBtZGV2X3NldF9jbGFzcyhzdHJ1Y3QgbWRldl9kZXZp
Y2UgKm1kZXYsIHUxNiBpZCkKPj4gICB9Cj4+ICAgRVhQT1JUX1NZTUJPTChtZGV2X3NldF9jbGFz
cyk7Cj4+ICAgCj4+ICsvKiBTcGVjaWZ5IHRoZSBtZGV2IGRldmljZSB0byBiZSBhIFZGSU8gbWRl
diBkZXZpY2UsIGFuZCBzZXQgVkZJTwo+PiArICogZGV2aWNlIG9wcyBmb3IgaXQuIFRoaXMgbXVz
dCBiZSBjYWxsZWQgZnJvbSB0aGUgY3JlYXRlKCkgY2FsbGJhY2sKPj4gKyAqIGZvciBWRklPIG1k
ZXYgZGV2aWNlLgo+PiArICovCj4gQ29tbWVudCBzdHlsZS4gIFRoYW5rcywKCgpXaWxsIGZpeCB0
aGVtIGFsbC4KClRoYW5rcwoKCj4KPiBBbGV4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

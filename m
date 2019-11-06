From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V8 4/6] mdev: introduce virtio device and its device ops
Date: Wed, 6 Nov 2019 11:51:33 +0800
Message-ID: <0de9abaf-d740-f4c7-50ff-3bd68a50ab40__29659.7908412636$1573012438$gmane$org@redhat.com>
References: <20191105093240.5135-1-jasowang@redhat.com>
	<20191105093240.5135-5-jasowang@redhat.com>
	<20191105104710.16d0f629@x1.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191105104710.16d0f629@x1.home>
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

Ck9uIDIwMTkvMTEvNiDkuIrljYgxOjQ3LCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6Cj4+ICsjZGVm
aW5lIFZJUlRJT19NREVWX0RFVklDRV9BUElfU1RSSU5HCQkidmlydGlvLW1kZXYiCj4+ICsjZGVm
aW5lIFZJUlRJT19NREVWX0ZfVkVSU0lPTl8xIDB4MQo+IFRoaXMgZW50aXJlIGNvbmNlcHQgb2Yg
VklSVElPX01ERVZfRl9WRVJTSU9OXzEgaXMgZ29uZSBub3csIHJpZ2h0Pwo+IExldCdzIHJlbW92
ZSBpdCBoZXJlIGFuZCBiZWxvdy4gIFRoYW5rcywKPgo+IEFsZXgKPgoKWWVzLCB3aWxsIGZpeC4K
ClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

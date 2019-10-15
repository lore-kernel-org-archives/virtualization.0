From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 5/7] mdev: introduce virtio device and its device ops
Date: Tue, 15 Oct 2019 11:27:32 +0800
Message-ID: <97d93729-9bc2-4cb5-5e4f-678285044c7f__22532.2069761873$1571110088$gmane$org@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
	<20191011081557.28302-6-jasowang@redhat.com>
	<20191014172301.GA5359@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191014172301.GA5359@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: christophe.de.dinechin@gmail.com, kvm@vger.kernel.org, mst@redhat.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, kwankhede@nvidia.com, rob.miller@broadcom.com, linux-s390@vger.kernel.org, sebott@linux.ibm.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, zhenyuw@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org, akrowiak@linux.ibm.com, oberpar@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, maxime.coque
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMTUg5LiK5Y2IMToyMywgU3RlZmFuIEhham5vY3ppIHdyb3RlOgo+IE9uIEZy
aSwgT2N0IDExLCAyMDE5IGF0IDA0OjE1OjU1UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
ICsgKiBAc2V0X3ZxX2NiOgkJCVNldCB0aGUgaW50ZXJydXQgY2FsYmFjayBmdW5jdGlvbiBmb3IK
PiBzL2ludGVycnV0L2ludGVycnVwdC8KPgo+IHMvY2FsYmFjay9jYWxsYmFjay8KCgpGaXhlZC4K
ClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u

From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V5 4/6] mdev: introduce virtio device and its device ops
Date: Tue, 29 Oct 2019 18:42:11 +0800
Message-ID: <14410ac9-cc01-185a-5dcf-7f6c78aefd65__10654.3721792818$1572345841$gmane$org@redhat.com>
References: <20191023130752.18980-1-jasowang@redhat.com>
	<20191023130752.18980-5-jasowang@redhat.com>
	<df1eb77c-d159-da11-bb8f-df2c19089ac6@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <df1eb77c-d159-da11-bb8f-df2c19089ac6@linux.intel.com>
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
To: Zhu Lingshan <lingshan.zhu@linux.intel.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: christophe.de.dinechin@gmail.com, sebott@linux.ibm.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, jani.nikula@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, stefanha@redhat.com, akrowiak@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, oberpar@linux.ibm.com, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMTAvMjkg5LiL5Y2IMzo0MiwgWmh1IExpbmdzaGFuIHdyb3RlOgo+Pgo+PiArwqDC
oMKgIHZvaWQgKCpzZXRfc3RhdHVzKShzdHJ1Y3QgbWRldl9kZXZpY2UgKm1kZXYsIHU4IHN0YXR1
cyk7Cj4KPiBIaSBKYXNvbgo+Cj4gSXMgaXQgcG9zc2libGUgdG8gbWFrZSBzZXRfc3RhdHVzKCkg
cmV0dXJuIGFuIHU4IG9yIGJvb2wsIGJlY2F1c2UgdGhpcwo+IG1heSBmYWlsIGluIHJlYWwgaGFy
ZHdhcmUuIFdpdGhvdXQgYSByZXR1cm5lZCBjb2RlLCBJIGFtIG5vdCBzdXJlwqAKPiB3aGV0aGVy
IGl0IGlzIGEgZ29vZCBpZGVhIHRvIHNldCB0aGUgc3RhdHVzIHwgTkVFRF9SRVNFVCB3aGVuIGZh
aWwuCj4KPiBUaGFua3MsCj4gQlIKPiBaaHUgTGluZ3NoYW4gCgoKSGk6CgoKSXQncyBwb3NzaWJs
ZSBidXQgSSdtIG5vdCBzdXJlIHdoZXRoZXIgYW55IHVzZXIgd2lsbCBjYXJlIGFib3V0IGl0LiBF
LmcKc2VlIHZpcnRpb19hZGRfc3RhdHVzKCk6Cgp2b2lkIHZpcnRpb19hZGRfc3RhdHVzKHN0cnVj
dCB2aXJ0aW9fZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBzdGF0dXMpCnsKwqDCoMKgIG1pZ2h0
X3NsZWVwKCk7CsKgwqDCoCBkZXYtPmNvbmZpZy0+c2V0X3N0YXR1cyhkZXYsIGRldi0+Y29uZmln
LT5nZXRfc3RhdHVzKGRldikgfCBzdGF0dXMpOwp9CkVYUE9SVF9TWU1CT0xfR1BMKHZpcnRpb19h
ZGRfc3RhdHVzKTsKCkFuZCBJIGJlbGlldmUgaG93IGl0IHdvcmsgc2hvdWxkIGJlOgoKdmlydGlv
X2FkZF9zdGF0dXMoeHl6KTsKCnN0YXR1cyA9IHZpcnRpb19nZXRfc3RhdHVzKCk7CgppZiAoIShz
dGF0dXMgJiB4eXopKQoKwqDCoMKgIGVycm9yOwoKVGhhbmtzCgoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

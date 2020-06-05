From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Fri, 5 Jun 2020 16:54:17 +0800
Message-ID: <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvNi8yIOS4i+WNiDM6MDgsIEphc29uIFdhbmcgd3JvdGU6Cj4+Cj4+PiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIHZwX3ZkcGFfaWRfdGFibGVbXSA9IHsKPj4+ICvC
oMKgwqAgeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfUkVESEFUX1FVTVJBTkVULCBQQ0lfQU5Z
X0lEKSB9LAo+Pj4gK8KgwqDCoCB7IDAgfQo+Pj4gK307Cj4+IFRoaXMgbG9va3MgbGlrZSBpdCds
bCBjcmVhdGUgYSBtZXNzIHdpdGggZWl0aGVyIHZpcnRpbyBwY2kKPj4gb3IgdmRwYSBiZWluZyBs
b2FkZWQgYXQgcmFuZG9tLiBNYXliZSBqdXN0IGRvbid0IHNwZWNpZnkKPj4gYW55IElEcyBmb3Ig
bm93LiBEb3duIHRoZSByb2FkIHdlIGNvdWxkIGdldCBhCj4+IGRpc3RpbmN0IHZlbmRvciBJRCBv
ciBhIHJhbmdlIG9mIGRldmljZSBJRHMgZm9yIHRoaXMuCj4KPgo+IFJpZ2h0LCB3aWxsIGRvLgo+
Cj4gVGhhbmtzIAoKClJldGhpbmsgYWJvdXQgdGhpcy4gSWYgd2UgZG9uJ3Qgc3BlY2lmeSBhbnkg
SUQsIHRoZSBiaW5kaW5nIHdvbid0IHdvcmsuCgpIb3cgYWJvdXQgdXNpbmcgYSBkZWRpY2F0ZWQg
c3Vic3lzdGVtIHZlbmRvciBpZCBmb3IgdGhpcz8KClRoYW5rcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

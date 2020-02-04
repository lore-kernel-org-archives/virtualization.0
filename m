From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Tue, 4 Feb 2020 12:19:28 +0800
Message-ID: <d53a864c-d96f-ccac-78ad-0c596bda2718@redhat.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
 <20200116154658.GJ20978@mellanox.com>
 <aea2bff8-82c8-2c0f-19ee-e86db73e199f@redhat.com>
 <20200117141021.GW20978@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200117141021.GW20978@mellanox.com>
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
To: Jason Gunthorpe <jgg@mellanox.com>, Parav Pandit <parav@mellanox.com>
Cc: "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "mhabets@solarflare.com" <mhabets@solarflare.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "lulu@redhat.com" <lulu@redhat.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "hch@infradead.org" <hch@infradead.org>, "eperezma@redhat.com" <eperezma@redhat.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "kuba@kernel.org" <kuba@kernel.org>, Shahaf Shuler <shahafs@mellanox.com>, Jiri Pirko <jiri@mellanox.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "zhihong.wang@intel.com" <zhihong.wang@intel.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, linux-kernel@vger.kernel.
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvMS8xNyDkuIvljYgxMDoxMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4+IE5l
dGxpbmsgYmFzZWQgbGlmZWN5Y2xlIG1hbmFnZW1lbnQgY291bGQgYmUgaW1wbGVtZW50ZWQgZm9y
IHZEUEEKPj4+PiBzaW11bGF0b3IgYXMgd2VsbC4KPj4+IFRoaXMgaXMganVzdCBiZWdnaW5nIGZv
ciBhIG5ldGxpbmsgYmFzZWQgYXBwcm9hY2guCj4+Pgo+Pj4gQ2VydGFpbmx5IG5ldGxpbmsgZHJp
dmVuIHJlbW92YWwgc2hvdWxkIGJlIGFuIGFncmVlYWJsZSBzdGFuZGFyZCBmb3IKPj4+IGFsbCBk
ZXZpY2VzLCBJIHRoaW5rLgo+PiBXZWxsLCBJIHRoaW5rIFBhcmF2IGhhZCBzb21lIHByb3Bvc2Fs
cyBkdXJpbmcgdGhlIGRpc2N1c3Npb24gb2YgbWRldgo+PiBhcHByb2FjaC4gQnV0IEknbSBub3Qg
c3VyZSBpZiBoZSBoYWQgYW55IFJGQyBjb2RlcyBmb3IgbWUgdG8gaW50ZWdyYXRlIGl0Cj4+IGlu
dG8gdmRwYXNpbS4KPj4KPj4gT3IgZG8geW91IHdhbnQgbWUgdG8gcHJvcG9zZSB0aGUgbmV0bGlu
ayBBUEk/IElmIHllcywgd291bGQgeW91IHByZWZlciB0byBhCj4+IG5ldyB2aXJ0aW8gZGVkaWNh
dGVkIG9uZSBvciBiZSBhIHN1YnNldCBvZiBkZXZsaW5rPwo+IFdlbGwsIGxldHMgc2VlIHdoYXQg
ZmVlZCBiYWNrIFBhcmF2IGhhcwo+Cj4gSmFzb24KCgpIaSBQYXJhdjoKCkRvIHlvdSBoYXZlIGFu
eSB1cGRhdGUgb24gdGhpcz8gSWYgaXQgc3RpbGwgcmVxdWlyZSBzb21ldGltZSwgSSB3aWxsIApw
b3N0IFYyIHRoYXQgc3RpY2tzIHRvIHN5c2ZzIGJhc2VkIEFQSS4KClRoYW5rcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u

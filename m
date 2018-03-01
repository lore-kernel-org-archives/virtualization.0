From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small
	buffer
Date: Thu, 1 Mar 2018 17:24:35 +0800
Message-ID: <5c20a958-55c6-5a5f-c0e9-dc6f7c0e4db5__40586.4643435509$1519896202$gmane$org@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
	<1519874345-10235-3-git-send-email-jasowang@redhat.com>
	<20180301090206.04e13a71@redhat.com>
	<dbbfd899-fb7e-c039-5c9a-0f3b6ce34b78@redhat.com>
	<20180301101553.55c4c6bd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180301101553.55c4c6bd@redhat.com>
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
To: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDPmnIgwMeaXpSAxNzoxNSwgSmVzcGVyIERhbmdhYXJkIEJyb3VlciB3cm90
ZToKPiBPbiBUaHUsIDEgTWFyIDIwMTggMTY6NDk6MjQgKzA4MDAKPiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPgo+Pj4gMi4gVGhpcyBjYW4gZWFzaWx5IGNhdXNlIG91
dC1vZi1vcmRlciBwYWNrZXRzLgo+PiBJIG1heSBtaXNzIHNvbWV0aGluZywgYnV0IGl0IGxvb2tz
IHRvIG1lIHBhY2tldHMgd2VyZSBzdGlsbCBkZWxpdmVyZWQKPj4gaW4gb3JkZXI/IE9yIHlvdSBt
ZWFuIHRoZSBwYWNrZXRzIHRoYXQgd2FzIGRyb3BwZWQgYnkgY3B1bWFwPwo+IE5vLiBQYWNrZXRz
IGNhbiBub3cgdHJhdmVsIHR3byBjb2RlIHBhdGhzIHRvIHRoZSBlZ3Jlc3MgZGV2aWNlLiAoMSkg
WERQCj4gbmF0aXZlIHZpYSBuZHBfeGRwX3htaXQgdmlhIGRpcmVjdCBkZWxpdmVyeSBpbnRvIGEg
bG9ja2ZyZWUvZGVkaWNhdGVkCj4gVFggcXVldWUsICgyKSB2aWEgbm9ybWFsIG5ldHdvcmsgc3Rh
Y2sgd2hpY2ggY2FuIGludm9sdmUgYmVpbmcgcXVldWUgaW4KPiBhIHFkaXNjLiAgRG8geW91IHNl
ZSB0aGUgcG9zc2liaWxpdHkgb2YgdGhlIHJlb3JkZXIgbm93Pwo+CgpJIHNlZSwgdGhhbmtzLiBC
dXQgY29uc2lkZXIgdGhpcyBjb3VsZCBvbmx5IGhhcHBlbiBmb3IgZmlyc3QgZmV3IApwYWNrZXRz
LCBub3Qgc3VyZSBpdCB3YXMgd29ydGggdG8gd29ycnkgYWJvdXQgaXQuCgpUaGFua3MKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u

From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 1/3] vsock/virtio: use RCU to avoid use-after-free on
	the_virtio_vsock
Date: Fri, 5 Jul 2019 08:18:37 +0800
Message-ID: <23c014de-90b5-1de2-a118-63ec242cbf62__47065.3837242693$1562285951$gmane$org@redhat.com>
References: <20190628123659.139576-1-sgarzare@redhat.com>
	<20190628123659.139576-2-sgarzare@redhat.com>
	<05311244-ed23-d061-a620-7b83d83c11f5@redhat.com>
	<20190703104135.wg34dobv64k7u4jo@steredhat>
	<07e5bc00-ebde-4dac-d38c-f008fa230b5f@redhat.com>
	<20190704092044.23gd5o2rhqarisgg@steredhat.homenet.telecomitalia.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190704092044.23gd5o2rhqarisgg@steredhat.homenet.telecomitalia.it>
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
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvNy80IOS4i+WNiDU6MjAsIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj4+PiBU
aGlzIGlzIHN0aWxsIHN1c3BpY2lvdXMsIGNhbiB3ZSBhY2Nlc3MgdGhlX3ZpcnRpb192c29jayB0
aHJvdWdoIHZkZXYtPnByaXY/Cj4+Pj4gSWYgeWVzLCB3ZSBtYXkgc3RpbGwgZ2V0IHVzZS1hZnRl
ci1mcmVlIHNpbmNlIGl0IHdhcyBub3QgcHJvdGVjdGVkIGJ5IFJDVS4KPj4+IFdlIHdpbGwgZnJl
ZSB0aGUgb2JqZWN0IG9ubHkgYWZ0ZXIgY2FsbGluZyB0aGUgZGVsX3ZxcygpLCBzbyB3ZSBhcmUg
c3VyZQo+Pj4gdGhhdCB0aGUgdnFfY2FsbGJhY2tzIGVuZGVkIGFuZCB3aWxsIG5vIGxvbmdlciBi
ZSBpbnZva2VkLgo+Pj4gU28sIElJVUMgaXQgc2hvdWxkbid0IGhhcHBlbi4KPj4gWWVzLCBidXQg
YW55IGRlcmVmZXJlbmNlIHRoYXQgaXMgbm90IGRvbmUgaW4gdnFfY2FsbGJhY2tzIHdpbGwgYmUg
dmVyeQo+PiBkYW5nZXJvdXMgaW4gdGhlIGZ1dHVyZS4KPiBSaWdodC4KPgo+IERvIHlvdSB0aGlu
ayBtYWtlIHNlbnNlIHRvIGNvbnRpbnVlIHdpdGggdGhpcyBzZXJpZXMgaW4gb3JkZXIgdG8gZml4
IHRoZQo+IGhvdC11bnBsdWcgaXNzdWUsIHRoZW4gSSdsbCB3b3JrIHRvIHJlZmFjdG9yIHRoZSBk
cml2ZXIgY29kZSB0byB1c2UgdGhlIHJlZmNudAo+IChhcyB5b3Ugc3VnZ2VzdGVkIGluIHBhdGNo
IDIpIGFuZCBzaW5nbGV0b24gZm9yIHRoZV92aXJ0aW9fdnNvY2s/Cj4KPiBUaGFua3MsCj4gU3Rl
ZmFubwoKClllcy4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

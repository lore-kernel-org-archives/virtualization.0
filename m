From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH V2 0/5] vhost: accelerate metadata access through
	vmap()
Date: Thu, 14 Mar 2019 21:49:03 +0800
Message-ID: <74015196-2e18-4fe0-50ac-0c9d497315c7__41912.1824017324$1552571367$gmane$org@redhat.com>
References: <20190311.111413.1140896328197448401.davem@davemloft.net>
	<6b6dcc4a-2f08-ba67-0423-35787f3b966c@redhat.com>
	<20190311235140-mutt-send-email-mst@kernel.org>
	<76c353ed-d6de-99a9-76f9-f258074c1462@redhat.com>
	<20190312075033-mutt-send-email-mst@kernel.org>
	<1552405610.3083.17.camel@HansenPartnership.com>
	<20190312200450.GA25147@redhat.com>
	<1552424017.14432.11.camel@HansenPartnership.com>
	<20190313160529.GB15134@infradead.org>
	<1552495028.3022.37.camel@HansenPartnership.com>
	<20190314064004-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190314064004-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-parisc@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMTkvMy8xNCDkuIvljYg2OjQyLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+Pj4+
IFdoaWNoIG1lYW5zIGFmdGVyIHdlIGZpeCB2aG9zdCB0byBhZGQgdGhlIGZsdXNoX2RjYWNoZV9w
YWdlIGFmdGVyCj4+Pj4+IGt1bm1hcCwgUGFyaXNjIHdpbGwgZ2V0IGEgZG91YmxlIGhpdCAoYnV0
IGl0IGFsc28gbWVhbnMgUGFyaXNjCj4+Pj4+IHdhcyB0aGUgb25seSBvbmUgb2YgdGhvc2UgYXJj
aHMgbmVlZGVkIGV4cGxpY2l0IGNhY2hlIGZsdXNoZXMsCj4+Pj4+IHdoZXJlIHZob3N0IHdvcmtl
ZCBjb3JyZWN0bHkgc28gZmFyLi4gc28gaXQga2luZHMgb2YgcHJvb2ZzIHlvdXIKPj4+Pj4gcG9p
bnQgb2YgZ2l2aW5nIHVwIGJlaW5nIHRoZSBzYWZlIGNob2ljZSkuCj4+Pj4gV2hhdCBkb3VibGUg
aGl0PyAgSWYgdGhlcmUncyBubyBjYWNoZSB0byBmbHVzaCB0aGVuIGNhY2hlIGZsdXNoIGlzCj4+
Pj4gYSBuby1vcC4gIEl0J3MgYWxzbyBhIGhpZ2hseSBwaXBsaW5lYWJsZSBuby1vcCBiZWNhdXNl
IHRoZSBDUFUgaGFzCj4+Pj4gdGhlIEwxIGNhY2hlIHdpdGhpbiBlYXN5IHJlYWNoLiAgVGhlIG9u
bHkgZXZlbnQgd2hlbiBmbHVzaCB0YWtlcyBhCj4+Pj4gbGFyZ2UgYW1vdW50IHRpbWUgaXMgaWYg
d2UgYWN0dWFsbHkgaGF2ZSBkaXJ0eSBkYXRhIHRvIHdyaXRlIGJhY2sKPj4+PiB0byBtYWluIG1l
bW9yeS4KPj4+IEkndmUgaGVhcmQgcGVvcGxlIGNvbXBsYWluaW5nIHRoYXQgb24gc29tZSBtaWNy
b2FyY2hpdGVjdHVyZXMgZXZlbgo+Pj4gbm8tb3AgY2FjaGUgZmx1c2hlcyBhcmUgcmVsYXRpdmVs
eSBleHBlbnNpdmUuICBEb24ndCBhc2sgbWUgd2h5LAo+Pj4gYnV0IGlmIHdlIGNhbiBlYXNpbHkg
YXZvaWQgZG91YmxlIGZsdXNoZXMgd2Ugc2hvdWxkIGRvIHRoYXQuCj4+IEl0J3Mgc3RpbGwgbm90
IGVudGlyZWx5IGZyZWUgZm9yIHVzLiAgT3VyIGludGVybmFsIGNhY2hlIGxpbmUgaXMgYXJvdW5k
Cj4+IDMyIGJ5dGVzIChzb21lIGhhdmUgMTYgYW5kIHNvbWUgaGF2ZSA2NCkgYnV0IHRoYXQgbWVh
bnMgd2UgbmVlZCAxMjgKPj4gZmx1c2hlcyBmb3IgYSBwYWdlIC4uLiB3ZSBkZWZpbml0ZWx5IGNh
bid0IHBpcGVsaW5lIHRoZW0gYWxsLiAgU28gSQo+PiBhZ3JlZSBkdXBsaWNhdGUgZmx1c2ggZWxp
bWluYXRpb24gd291bGQgYmUgYSBzbWFsbCBpbXByb3ZlbWVudC4KPj4KPj4gSmFtZXMKPiBJIHN1
c3BlY3Qgd2UnbGwga2VlcCB0aGUgY29weVh1c2VyIHBhdGggYXJvdW5kIGZvciAzMiBiaXQgYW55
d2F5IC0KPiByaWdodCBKYXNvbj8KCgpZZXMgc2luY2Ugd2UgZG9uJ3Qgd2FudCB0byBzbG93IGRv
d24gMzJiaXQuCgpUaGFua3MKCgo+IFNvIHdlIGNhbiBhbHNvIGtlZXAgdXNpbmcgdGhhdCBvbiBw
YXJpc2MuLi4KPgo+IC0tIApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

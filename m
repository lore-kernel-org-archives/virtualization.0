From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/13] compiler.h: Split {READ, WRITE}_ONCE definitions out
	into rwonce.h
Date: Mon, 11 Nov 2019 10:32:46 +0100
Message-ID: <CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
References: <20191108170120.22331-1-will@kernel.org>
	<20191108170120.22331-2-will@kernel.org>
	<CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
	<93f80017-d65e-7c3a-29b0-d9a568d08f58@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <93f80017-d65e-7c3a-29b0-d9a568d08f58@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, virtualization@lists.linux-foundation.org, Josh Triplett <josh@joshtriplett.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SeongJae Park <sj38.park@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>, Joe Perches <joe@perches.com>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, Yunjae Lee <lyj7694@gmail.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBOb3YgMTEsIDIwMTkgYXQgOToxMCBBTSBDaHJpc3RpYW4gQm9ybnRyYWVnZXIKPGJv
cm50cmFlZ2VyQGRlLmlibS5jb20+IHdyb3RlOgo+IE9uIDA4LjExLjE5IDIwOjU3LCBBcm5kIEJl
cmdtYW5uIHdyb3RlOgo+ID4gT24gRnJpLCBOb3YgOCwgMjAxOSBhdCA2OjAxIFBNIFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4+Cj4gPj4gSW4gcHJlcGFyYXRpb24gZm9y
IGFsbG93aW5nIGFyY2hpdGVjdHVyZXMgdG8gZGVmaW5lIHRoZWlyIG93bgo+ID4+IGltcGxlbWVu
dGF0aW9uIG9mIHRoZSAnUkVBRF9PTkNFKCknIG1hY3JvLCBtb3ZlIHRoZSBnZW5lcmljCj4gPj4g
J3tSRUFELFdSSVRFfV9PTkNFKCknIGRlZmluaXRpb25zIG91dCBvZiB0aGUgdW53aWVsZHkgJ2xp
bnV4L2NvbXBpbGVyLmgnCj4gPj4gYW5kIGludG8gYSBuZXcgJ3J3b25jZS5oJyBoZWFkZXIgdW5k
ZXIgJ2FzbS1nZW5lcmljJy4KPiA+Cj4gPiBBZGRpbmcgQ2hyaXN0aWFuIEJvcm50csOkZ2VyIHRv
IENjLCBoZSBvcmlnaW5hbGx5IGFkZGVkIHRoZQo+ID4gUkVBRF9PTkNFKCkvV1JJVEVfT05DRSgp
Cj4gPiBjb2RlLgo+ID4KPiA+IEkgd29uZGVyIGlmIGl0IHdvdWxkIGJlIGFwcHJvcHJpYXRlIG5v
dyB0byByZXZlcnQgYmFjayB0byBhIG11Y2ggc2ltcGxlciB2ZXJzaW9uCj4gPiBvZiB0aGVzZSBo
ZWxwZXJzIGZvciBhbnkgbW9kZXJuIGNvbXBpbGVyLiBBcyBJIHVuZGVyc3RhbmQsIG9ubHkgZ2Nj
LTQuNiBhbmQKPiA+IGdjYzQuNyBhY3R1YWxseSBuZWVkIHRoZSBzb25nLWFuZC1kYW5jZSB2ZXJz
aW9uIHdpdGggdGhlIHVuaW9uIGFuZCBzd2l0Y2gvY2FzZSwKPiA+IHdoaWxlIGZvciBvdGhlcnMs
IHdlIGNhbiBtaWdodCBiZSBhYmxlIGJhY2sgdG8gYSBtYWNybyBkb2luZyBhIHZvbGF0aWxlIGFj
Y2Vzcy4KPgo+IEFzIGZhciBhcyBJIGtub3cgdGhpcyBwYXJ0aWN1bGFyIGlzc3VlIHdpdGggIHZv
bGF0aWxlIGFjY2VzcyBvbiBhZ2dyZWdhdGUgdHlwZXMKPiB3YXMgZml4ZWQgaW4gZ2NjIDQuOC4g
T24gdGhlIG90aGVyIGhhbmQgd2Uga25vdyB0aGF0IHRoZSBjdXJyZW50IGNvbnN0cnVjdCB3aWxs
Cj4gd29yayBvbiBhbGwgY29tcGlsZXJzLiBOb3Qgc28gc3VyZSBhYm91dCB0aGUgb3JpZ25hbCBB
Q0NFU1NfT05DRSBpbXBsZW1lbnRhdGlvbi4KCkkndmUgc2VlbiBwcm9ibGVtcyB3aXRoIGNsYW5n
IG9uIHRoZSBjdXJyZW50IHZlcnNpb24sIGxlYWRpbmcgdG8gdW5uZWNlc3NhcnkKdGVtcG9yYXJp
ZXMgYmVpbmcgc3BpbGxlZCB0byB0aGUgc3RhY2sgaW4gc29tZSBjYXNlcywgc28gSSB0aGluayBp
dCB3b3VsZCBzdGlsbApoZWxwIHRvIHNpbXBsaWZ5IGl0LgoKV2UgcHJvYmFibHkgZG9uJ3Qgd2Fu
dCB0aGUgZXhhY3QgQUNDRVNTX09OQ0UoKSBpbXBsZW1lbnRhdGlvbiBiYWNrCnRoYXQgZXhpc3Rl
ZCBiZWZvcmUsIGJ1dCByYXRoZXIgc29tZXRoaW5nIHRoYXQgaW1wbGVtZW50cyB0aGUgc3RyaWN0
ZXIKUkVBRF9PTkNFKCkgYW5kIFdSSVRFX09OQ0UoKS4gSSdkIHByb2JhYmx5IGFsc28gd2FudCB0
byBhdm9pZCB0aGUKX19idWlsdGluX21lbWNweSgpIGV4Y2VwdGlvbiBmb3Igb2RkLXNpemVkIGFj
Y2Vzc2VzIGFuZCBpbnN0ZWFkIGhhdmUKYSBzZXBhcmF0ZSB3YXkgdG8gZG8gdGhvc2UuCgogICAg
ICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==

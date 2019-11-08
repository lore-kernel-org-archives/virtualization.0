From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/13] compiler.h: Split {READ, WRITE}_ONCE definitions out
	into rwonce.h
Date: Fri, 8 Nov 2019 20:57:14 +0100
Message-ID: <CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg__26844.4957489677$1573243369$gmane$org@mail.gmail.com>
References: <20191108170120.22331-1-will@kernel.org>
	<20191108170120.22331-2-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191108170120.22331-2-will@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Josh Triplett <josh@joshtriplett.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SeongJae Park <sj38.park@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>, Joe Perches <joe@perches.com>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, Yunjae Lee <lyj7694@gmail.com>, virtualization@lists.linux-foundation.org, Boqun Feng <boqun.feng@gmail.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

T24gRnJpLCBOb3YgOCwgMjAxOSBhdCA2OjAxIFBNIFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5v
cmc+IHdyb3RlOgo+Cj4gSW4gcHJlcGFyYXRpb24gZm9yIGFsbG93aW5nIGFyY2hpdGVjdHVyZXMg
dG8gZGVmaW5lIHRoZWlyIG93bgo+IGltcGxlbWVudGF0aW9uIG9mIHRoZSAnUkVBRF9PTkNFKCkn
IG1hY3JvLCBtb3ZlIHRoZSBnZW5lcmljCj4gJ3tSRUFELFdSSVRFfV9PTkNFKCknIGRlZmluaXRp
b25zIG91dCBvZiB0aGUgdW53aWVsZHkgJ2xpbnV4L2NvbXBpbGVyLmgnCj4gYW5kIGludG8gYSBu
ZXcgJ3J3b25jZS5oJyBoZWFkZXIgdW5kZXIgJ2FzbS1nZW5lcmljJy4KCkFkZGluZyBDaHJpc3Rp
YW4gQm9ybnRyw6RnZXIgdG8gQ2MsIGhlIG9yaWdpbmFsbHkgYWRkZWQgdGhlClJFQURfT05DRSgp
L1dSSVRFX09OQ0UoKQpjb2RlLgoKSSB3b25kZXIgaWYgaXQgd291bGQgYmUgYXBwcm9wcmlhdGUg
bm93IHRvIHJldmVydCBiYWNrIHRvIGEgbXVjaCBzaW1wbGVyIHZlcnNpb24Kb2YgdGhlc2UgaGVs
cGVycyBmb3IgYW55IG1vZGVybiBjb21waWxlci4gQXMgSSB1bmRlcnN0YW5kLCBvbmx5IGdjYy00
LjYgYW5kCmdjYzQuNyBhY3R1YWxseSBuZWVkIHRoZSBzb25nLWFuZC1kYW5jZSB2ZXJzaW9uIHdp
dGggdGhlIHVuaW9uIGFuZCBzd2l0Y2gvY2FzZSwKd2hpbGUgZm9yIG90aGVycywgd2UgY2FuIG1p
Z2h0IGJlIGFibGUgYmFjayB0byBhIG1hY3JvIGRvaW5nIGEgdm9sYXRpbGUgYWNjZXNzLgoKICAg
ICBBcm5kCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==

From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 01/13] compiler.h: Split {READ, WRITE}_ONCE definitions out
	into rwonce.h
Date: Mon, 11 Nov 2019 09:10:00 +0100
Message-ID: <93f80017-d65e-7c3a-29b0-d9a568d08f58__160.348745860972$1573461127$gmane$org@de.ibm.com>
References: <20191108170120.22331-1-will@kernel.org>
	<20191108170120.22331-2-will@kernel.org>
	<CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Josh Triplett <josh@joshtriplett.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SeongJae Park <sj38.park@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, alpha <linux-alpha@vger.kernel.org>, Joe Perches <joe@perches.com>, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, Yunjae Lee <lyj7694@gmail.com>, virtualization@lists.linux-foundation.org, Boqun Feng <boqun.feng@gmail.com>, Richard Henderson <rth@twiddle.net>
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAwOC4xMS4xOSAyMDo1NywgQXJuZCBCZXJnbWFubiB3cm90ZToKPiBPbiBGcmksIE5vdiA4
LCAyMDE5IGF0IDY6MDEgUE0gV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4gd3JvdGU6Cj4+
Cj4+IEluIHByZXBhcmF0aW9uIGZvciBhbGxvd2luZyBhcmNoaXRlY3R1cmVzIHRvIGRlZmluZSB0
aGVpciBvd24KPj4gaW1wbGVtZW50YXRpb24gb2YgdGhlICdSRUFEX09OQ0UoKScgbWFjcm8sIG1v
dmUgdGhlIGdlbmVyaWMKPj4gJ3tSRUFELFdSSVRFfV9PTkNFKCknIGRlZmluaXRpb25zIG91dCBv
ZiB0aGUgdW53aWVsZHkgJ2xpbnV4L2NvbXBpbGVyLmgnCj4+IGFuZCBpbnRvIGEgbmV3ICdyd29u
Y2UuaCcgaGVhZGVyIHVuZGVyICdhc20tZ2VuZXJpYycuCj4gCj4gQWRkaW5nIENocmlzdGlhbiBC
b3JudHLDpGdlciB0byBDYywgaGUgb3JpZ2luYWxseSBhZGRlZCB0aGUKPiBSRUFEX09OQ0UoKS9X
UklURV9PTkNFKCkKPiBjb2RlLgo+IAo+IEkgd29uZGVyIGlmIGl0IHdvdWxkIGJlIGFwcHJvcHJp
YXRlIG5vdyB0byByZXZlcnQgYmFjayB0byBhIG11Y2ggc2ltcGxlciB2ZXJzaW9uCj4gb2YgdGhl
c2UgaGVscGVycyBmb3IgYW55IG1vZGVybiBjb21waWxlci4gQXMgSSB1bmRlcnN0YW5kLCBvbmx5
IGdjYy00LjYgYW5kCj4gZ2NjNC43IGFjdHVhbGx5IG5lZWQgdGhlIHNvbmctYW5kLWRhbmNlIHZl
cnNpb24gd2l0aCB0aGUgdW5pb24gYW5kIHN3aXRjaC9jYXNlLAo+IHdoaWxlIGZvciBvdGhlcnMs
IHdlIGNhbiBtaWdodCBiZSBhYmxlIGJhY2sgdG8gYSBtYWNybyBkb2luZyBhIHZvbGF0aWxlIGFj
Y2Vzcy4KCkFzIGZhciBhcyBJIGtub3cgdGhpcyBwYXJ0aWN1bGFyIGlzc3VlIHdpdGggIHZvbGF0
aWxlIGFjY2VzcyBvbiBhZ2dyZWdhdGUgdHlwZXMKd2FzIGZpeGVkIGluIGdjYyA0LjguIE9uIHRo
ZSBvdGhlciBoYW5kIHdlIGtub3cgdGhhdCB0aGUgY3VycmVudCBjb25zdHJ1Y3Qgd2lsbAp3b3Jr
IG9uIGFsbCBjb21waWxlcnMuIE5vdCBzbyBzdXJlIGFib3V0IHRoZSBvcmlnbmFsIEFDQ0VTU19P
TkNFIGltcGxlbWVudGF0aW9uLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

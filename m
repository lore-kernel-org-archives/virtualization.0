From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Tue, 22 Jan 2013 15:54:37 +0100
Message-ID: <CAJK669a6E2iTWqhqVnpm7zwRcHk12Cg-eAuLvNwXyAWrRjR_6A@mail.gmail.com>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<CAJK669ZtShu89xMmryLM7dX0Cy7AoOdyPf7cSdV4v+81E-XF5g@mail.gmail.com>
	<874nibw9cp.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <874nibw9cp.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gTW9uLCBKYW4gMjEsIDIwMTMgYXQgMzozNiBBTSwgUnVzdHkgUnVzc2VsbCA8cnVzdHlAcnVz
dGNvcnAuY29tLmF1PiB3cm90ZToKPiBTanVyIEJyw6ZuZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRA
c3Rlcmljc3Nvbi5jb20+IHdyaXRlczoKPj4gT24gVGh1LCBKYW4gMTcsIDIwMTMgYXQgMTI6MjMg
UE0sIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4gaW4gb3Rn
aGVyIHdvcmRzLCB3ZSBtaWdodCBuZWVkIHRvIHNwbGl0IGEgc2luZ2xlIGRlc2MgdG8gbXVsdGlw
bGUKPj4+IGlvdiBlbnRyaWVzLgo+Pgo+PiBTcGxpdHRpbmcgZGVzY3JpcHRvcnMgZG9lc24ndCB3
b3JrIGZvciBtZS4gQXMgZGVzY3JpYmVkIGVhcmxpZXIsIEkKPj4gcmVjZWl2ZSBvbmUgSVAtZnJh
bWUgZm9yIGVhY2ggZGVzY3JpcHRvci4gU28gSSBuZWVkIHRvIGtlZXAKPj4gdGhlIG9yaWdpbmFs
IGJvdW5kYXJpZXMuCj4KPiBZZXMsIGJ1dCB0aGUgX2tlcm4gaGVscGVycyBkb24ndCBkbyByYW5n
ZSBjaGVja2luZyBvciBvZmZzZXR0aW5nIGF0IHRoZQo+IG1vbWVudCwgc28gdGhleSdsbCBiZSBw
cmVzZXJ2ZWQuCj4KPiBJZiB5b3Ugd2FudCB0byBkbyByYW5nZSBjaGVja2luZywgSSBjYW4gYWRk
IHRoYXQuLi4KCkkgZG9uJ3QgdGhpbmsgSSBuZWVkIHRoYXQuIEluaXRpYWxseSBJIGNhbiBqdXN0
IGNoZWNrIGlmIHRoZSByZWNlaXZlZCBhZGRyZXNzCmlzIHJlYWRhYmxlLgoKUmVnYXJkcywKU2p1
cgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=

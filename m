From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] virtio_host: host-side implementation of virtio rings.
Date: Mon, 21 Jan 2013 13:06:22 +1030
Message-ID: <874nibw9cp.fsf@rustcorp.com.au>
References: <1358418584-26345-1-git-send-email-rusty@rustcorp.com.au>
	<20130117112314.GA15504@redhat.com>
	<CAJK669ZtShu89xMmryLM7dX0Cy7AoOdyPf7cSdV4v+81E-XF5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJK669ZtShu89xMmryLM7dX0Cy7AoOdyPf7cSdV4v+81E-XF5g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

U2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPiB3cml0ZXM6
Cj4gT24gVGh1LCBKYW4gMTcsIDIwMTMgYXQgMTI6MjMgUE0sIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+PiBpbiBvdGdoZXIgd29yZHMsIHdlIG1pZ2h0IG5lZWQg
dG8gc3BsaXQgYSBzaW5nbGUgZGVzYyB0byBtdWx0aXBsZQo+PiBpb3YgZW50cmllcy4KPgo+IFNw
bGl0dGluZyBkZXNjcmlwdG9ycyBkb2Vzbid0IHdvcmsgZm9yIG1lLiBBcyBkZXNjcmliZWQgZWFy
bGllciwgSQo+IHJlY2VpdmUgb25lIElQLWZyYW1lIGZvciBlYWNoIGRlc2NyaXB0b3IuIFNvIEkg
bmVlZCB0byBrZWVwCj4gdGhlIG9yaWdpbmFsIGJvdW5kYXJpZXMuCgpZZXMsIGJ1dCB0aGUgX2tl
cm4gaGVscGVycyBkb24ndCBkbyByYW5nZSBjaGVja2luZyBvciBvZmZzZXR0aW5nIGF0IHRoZQpt
b21lbnQsIHNvIHRoZXknbGwgYmUgcHJlc2VydmVkLgoKSWYgeW91IHdhbnQgdG8gZG8gcmFuZ2Ug
Y2hlY2tpbmcsIEkgY2FuIGFkZCB0aGF0Li4uCgpDaGVlcnMsClJ1c3R5LgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

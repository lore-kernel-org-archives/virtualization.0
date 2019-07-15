From: Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Mon, 15 Jul 2019 15:53:45 +0100
Message-ID: <c49f8079-fc3e-8d2e-7e5a-327a7b1bec09@citrix.com>
References: <20190715130056.10627-1-andrew.cooper3@citrix.com>
	<a04918d1-975e-5869-1ecd-c9df4ae5b1c1@suse.com>
	<CALCETrX0T=vzyN8gqoBmA72xwzS45d5bDTfcZQJayht9n9ijPA@mail.gmail.com>
	<f51ce980-599b-cae3-e3fa-4a67443ea128@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <f51ce980-599b-cae3-e3fa-4a67443ea128@suse.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>
Cc: FengTang <feng.tang@intel.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, "Rafael J.Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Pavel Machek <pavel@ucw.cz>, Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMTUvMDcvMjAxOSAxNTo1MiwgSnVlcmdlbiBHcm9zcyB3cm90ZToKPiBPbiAxNS4wNy4xOSAx
NjoyNiwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+PiBPbiBNb24sIEp1bCAxNSwgMjAxOSBhdCA2
OjIzIEFNIEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gT24g
MTUuMDcuMTkgMTU6MDAsIEFuZHJldyBDb29wZXIgd3JvdGU6Cj4+Pj4gVGhlcmUgaXMgYSBsb3Qg
b2YgaW5mcmFzdHJ1Y3R1cmUgZm9yIGZ1bmN0aW9uYWxpdHkgd2hpY2ggaXMgdXNlZAo+Pj4+IGV4
Y2x1c2l2ZWx5IGluIF9fe3NhdmUscmVzdG9yZX1fcHJvY2Vzc29yX3N0YXRlKCkgb24gdGhlCj4+
Pj4gc3VzcGVuZC9yZXN1bWUKPj4+PiBwYXRoLgo+Pj4+Cj4+Pj4gY3I4IGlzIGFuIGFsaWFzIG9m
IEFQSUNfVEFTS1BSSSwgYW5kIEFQSUNfVEFTS1BSSSBpcyBzYXZlZC9yZXN0b3JlZAo+Pj4+IGlu
ZGVwZW5kZW50bHkgYnkgbGFwaWNfe3N1c3BlbmQscmVzdW1lfSgpLgo+Pj4KPj4+IEFyZW4ndCB0
aG9zZSBjYWxsZWQgb25seSB3aXRoIENPTkZJR19QTSBzZXQ/Cj4+Pgo+Pgo+Pgo+PiBVbmxlc3Mg
SSdtIG1pc3Npbmcgc29tZXRoaW5nLCB3ZSBvbmx5IGJ1aWxkIGFueSBvZiB0aGUgcmVzdG9yZSBj
b2RlCj4+IChpbmNsdWRpbmcgdGhlIHdyaXRlX2NyOCgpIGNhbGwpIGlmIENPTkZJR19QTV9TTEVF
UCBpcyBzZXQsIGFuZCB0aGF0Cj4+IHNlbGVjdHMgQ09ORklHX1BNLCBzbyB3ZSBzaG91bGQgYmUg
ZmluZSwgSSB0aGluay4KPj4KPgo+IE9rYXksIGluIHRoYXQgY2FzZSBJJ2Qgc3VnZ2VzdCB0byBy
ZW1vdmUgImNyOCIgZnJvbSBzdHJ1Y3Qgc2F2ZWRfY29udGV4dAo+IGFzIGl0IHdvbid0IGJlIHVz
ZWQgYW55IGxvbmdlci4KClRvIGJlIGhvbmVzdCwgc2F2aW5nIGFuZCByZXN0b3Jpbmcgb2YgY3I4
IHdpdGhvdXQgdGhlIHJlc3Qgb2YgdGhlIExvY2FsCkFQSUMgc3RhdGUgaXMgY29uY2VwdHVhbGx5
IGJyb2tlbiB0byBiZWdpbiB3aXRoLgoKSWYgdGhlcmUgYXJlIGFueSBidWdzIHJldmVhbGVkIGJ5
IHRoaXMsIHRoZW4gdGhlIGNvcnJlY3QgZml4ZXMgYXJlCmVsc2V3aGVyZS4KCllvdSdyZSByaWdo
dCBhYm91dCB0aGUgc2F2ZWRfY29udGV4dC7CoCBJJ2xsIHN1Ym1pdCBhIHYyIHdpdGggYW4gZXZl
bgpsYXJnZXIgbmVnYXRpdmUgZGlmZnN0YXQuCgp+QW5kcmV3Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

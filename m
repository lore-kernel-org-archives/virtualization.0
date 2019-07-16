From: Nadav Amit via Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Date: Tue, 16 Jul 2019 00:54:26 +0000
Message-ID: <31F573CC-4381-4C24-B8D8-6AB05D7FAA96@vmware.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
	<602B4D96-E2A9-45BE-8247-4E3481ED5402@vmware.com>
	<4a7592c8-0ee8-f394-c445-4032daf74493@citrix.com>
Reply-To: Nadav Amit <namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4a7592c8-0ee8-f394-c445-4032daf74493@citrix.com>
Content-Language: en-US
Content-ID: <3ED4C1A52CE9F047A786ED36B570FEA6@namprd05.prod.outlook.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Feng Tang <feng.tang@intel.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Stephane Eranian <eranian@google.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

PiBPbiBKdWwgMTUsIDIwMTksIGF0IDQ6MzAgUE0sIEFuZHJldyBDb29wZXIgPGFuZHJldy5jb29w
ZXIzQGNpdHJpeC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTUvMDcvMjAxOSAxOToxNywgTmFkYXYg
QW1pdCB3cm90ZToNCj4+PiBPbiBKdWwgMTUsIDIwMTksIGF0IDg6MTYgQU0sIEFuZHJldyBDb29w
ZXIgPGFuZHJldy5jb29wZXIzQGNpdHJpeC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFRoZXJlIGlz
IGEgbG90IG9mIGluZnJhc3RydWN0dXJlIGZvciBmdW5jdGlvbmFsaXR5IHdoaWNoIGlzIHVzZWQN
Cj4+PiBleGNsdXNpdmVseSBpbiBfX3tzYXZlLHJlc3RvcmV9X3Byb2Nlc3Nvcl9zdGF0ZSgpIG9u
IHRoZSBzdXNwZW5kL3Jlc3VtZQ0KPj4+IHBhdGguDQo+Pj4gDQo+Pj4gY3I4IGlzIGFuIGFsaWFz
IG9mIEFQSUNfVEFTS1BSSSwgYW5kIEFQSUNfVEFTS1BSSSBpcyBzYXZlZC9yZXN0b3JlZCBieQ0K
Pj4+IGxhcGljX3tzdXNwZW5kLHJlc3VtZX0oKS4gIFNhdmluZyBhbmQgcmVzdG9yaW5nIGNyOCBp
bmRlcGVuZGVudGx5IG9mIHRoZQ0KPj4+IHJlc3Qgb2YgdGhlIExvY2FsIEFQSUMgc3RhdGUgaXNu
J3QgYSBjbGV2ZXIgdGhpbmcgdG8gYmUgZG9pbmcuDQo+Pj4gDQo+Pj4gRGVsZXRlIHRoZSBzdXNw
ZW5kL3Jlc3VtZSBjcjggaGFuZGxpbmcsIHdoaWNoIHNocmlua3MgdGhlIHNpemUgb2Ygc3RydWN0
DQo+Pj4gc2F2ZWRfY29udGV4dCwgYW5kIGFsbG93cyBmb3IgdGhlIHJlbW92YWwgb2YgYm90aCBQ
Vk9QUy4NCj4+IEkgdGhpbmsgcmVtb3ZpbmcgdGhlIGludGVyZmFjZSBmb3IgQ1I4IHdyaXRlcyBp
cyBhbHNvIGdvb2QgdG8gYXZvaWQNCj4+IHBvdGVudGlhbCBjb3JyZWN0bmVzcyBpc3N1ZXMsIGFz
IHRoZSBTRE0gc2F5cyAoMTAuOC42LjEgIkludGVyYWN0aW9uIG9mIFRhc2sNCj4+IFByaW9yaXRp
ZXMgYmV0d2VlbiBDUjggYW5kIEFQSUPigJ0pOg0KPj4gDQo+PiAiT3BlcmF0aW5nIHNvZnR3YXJl
IHNob3VsZCBpbXBsZW1lbnQgZWl0aGVyIGRpcmVjdCBBUElDIFRQUiB1cGRhdGVzIG9yIENSOA0K
Pj4gc3R5bGUgVFBSIHVwZGF0ZXMgYnV0IG5vdCBtaXggdGhlbS4gU29mdHdhcmUgY2FuIHVzZSBh
IHNlcmlhbGl6aW5nDQo+PiBpbnN0cnVjdGlvbiAoZm9yIGV4YW1wbGUsIENQVUlEKSB0byBzZXJp
YWxpemUgdXBkYXRlcyBiZXR3ZWVuIE1PViBDUjggYW5kDQo+PiBzdG9yZXMgdG8gdGhlIEFQSUMu
4oCdDQo+PiANCj4+IEFuZCBuYXRpdmVfd3JpdGVfY3I4KCkgZGlkIG5vdCBldmVuIGlzc3VlIGEg
c2VyaWFsaXppbmcgaW5zdHJ1Y3Rpb24uDQo+IA0KPiBHaXZlbiBpdHMgbG9jYXRpb24sIHRoZSBv
bmUgd3JpdGVfY3I4KCkgaXMgYm91bmRlZCBieSB0d28gc2VyaWFsaXNpbmcNCj4gb3BlcmF0aW9u
cywgc28gaXMgc2FmZSBpbiBwcmFjdGljZS4NCg0KVGhhdOKAmXMgd2hhdCB0aGUg4oCccG90ZW50
aWFs4oCdIGluICJwb3RlbnRpYWwgY29ycmVjdG5lc3MgaXNzdWVz4oCdIG1lYW5zIDopDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==

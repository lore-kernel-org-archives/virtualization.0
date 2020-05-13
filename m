From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] ifcvf: move IRQ request/free to status change handlers
Date: Wed, 13 May 2020 13:57:19 +0800
Message-ID: <f7485579-834f-1770-1622-e6df1b2f3e81@redhat.com>
References: <1589270444-3669-1-git-send-email-lingshan.zhu@intel.com>
 <8aca85c3-3bf6-a1ec-7009-cd9a635647d7@redhat.com>
 <5bbe0c21-8638-45e4-04e8-02ad0df44b38@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5bbe0c21-8638-45e4-04e8-02ad0df44b38@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: lulu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Ck9uIDIwMjAvNS8xMyDkuIvljYgxMjo0MiwgWmh1LCBMaW5nc2hhbiB3cm90ZToKPgo+Cj4gT24g
NS8xMy8yMDIwIDEyOjEyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiBPbiAyMDIwLzUvMTIg
5LiL5Y2INDowMCwgWmh1IExpbmdzaGFuIHdyb3RlOgo+Pj4gVGhpcyBjb21taXQgbW92ZSBJUlEg
cmVxdWVzdCBhbmQgZnJlZSBvcGVyYXRpb25zIGZyb20gcHJvYmUoKQo+Pj4gdG8gVklSVElPIHN0
YXR1cyBjaGFuZ2UgaGFuZGxlciB0byBjb21wbHkgd2l0aCBWSVJUSU8gc3BlYy4KPj4+Cj4+PiBW
SVJUSU8gc3BlYyAxLjEsIHNlY3Rpb24gMi4xLjIgRGV2aWNlIFJlcXVpcmVtZW50czogRGV2aWNl
IFN0YXR1cyBGaWVsZAo+Pj4gVGhlIGRldmljZSBNVVNUIE5PVCBjb25zdW1lIGJ1ZmZlcnMgb3Ig
c2VuZCBhbnkgdXNlZCBidWZmZXIKPj4+IG5vdGlmaWNhdGlvbnMgdG8gdGhlIGRyaXZlciBiZWZv
cmUgRFJJVkVSX09LLgo+Pgo+Pgo+PiBUaGlzIGNvbW1lbnQgbmVlZHMgdG8gYmUgY2hlY2tlZCBh
cyBJIHNhaWQgcHJldmlvdXNseS4gSXQncyBvbmx5IAo+PiBuZWVkZWQgaWYgd2UncmUgc3VyZSBp
ZmN2ZiBjYW4gZ2VuZXJhdGUgaW50ZXJydXB0IGJlZm9yZSBEUklWRVJfT0suCj4+Cj4+Cj4+Pgo+
Pj4gU2lnbmVkLW9mZi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+
Pj4gLS0tCj4+PiBjaGFuZ2VzIGZyb20gVjE6Cj4+PiByZW1vdmUgaWZjdmZfc3RvcF9kYXRhcGF0
aCgpIGluIHN0YXR1cyA9PSAwIGhhbmRsZXIsIHdlIGRvbid0IG5lZWQgCj4+PiB0byBkbyB0aGlz
Cj4+PiB0d2ljZTsgaGFuZGxlIHN0YXR1cyA9PSAwIGFmdGVyIERSSVZFUl9PSyAtPiAhRFJJVkVS
X09LIGhhbmRsZXIgCj4+PiAoSmFzb24gV2FuZykKPj4KPj4KPj4gUGF0Y2ggbG9va3MgZ29vZCB0
byBtZSwgYnV0IHdpdGggdGhpcyBwYXRjaCBwaW5nIGNhbm5vdCB3b3JrIG9uIG15IAo+PiBtYWNo
aW5lLiAoSXQgd29ya3Mgd2l0aG91dCB0aGlzIHBhdGNoKS4KPj4KPj4gVGhhbmtzCj4gVGhpcyBp
cyBzdHJhbmdlLCBpdCB3b3JrcyBvbiBteSBtYWNoaW5lcywgbGV0J3MgaGF2ZSBhIGNoZWNrIG9m
ZmxpbmUuCj4KPiBUaGFua3MsCj4gQlIKPiBaaHUgTGluZ3NoYW4KCgpOb3RlIHRoYXQgSSB0ZXN0
ZWQgdGhlIHBhdGNoIHdpdGggdmhvc3QtdnBkYS4KClRoYW5rcy4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

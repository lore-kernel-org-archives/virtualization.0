From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC/PATCH 15/15] guest: virtio device support, and kvm hypercalls
Date: Fri, 21 Mar 2008 09:15:47 +0100
Message-ID: <200803210915.48029.borntraeger__20573.7842516557$1206087977$gmane$org@de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
	<1206030328.6690.66.camel@cotte.boeblingen.de.ibm.com>
	<200803211124.49829.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803211124.49829.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

QW0gRnJlaXRhZywgMjEuIE3DpHJ6IDIwMDggc2NocmllYiBSdXN0eSBSdXNzZWxsOgo+IEknZCBy
ZWNvbW1lbmQgYSBoeXBlcmNhbGwgYWZ0ZXIgc2V0X3N0YXR1cywgYXMgd2VsbCBhcyByZXNldC4g
IFRoZQo+IHJlYXNvbiBsZ3Vlc3QgZG9lc24ndCBkbyB0aGlzIGlzIHRoYXQgd2UgZG9uJ3QgZG8g
ZmVhdHVyZSBuZWdvdGlhdGlvbgo+IChhc3N1bWluZyBndWVzdCBrZXJuZWwgbWF0Y2hlcyBob3N0
IGtlcm5lbCkuICBJbiBnZW5lcmFsLCB0aGUgaG9zdAo+IG5lZWRzIHRvIGtub3cgd2hlbiB0aGUg
VklSVElPX0NPTkZJR19TX0RSSVZFUl9PSyBpcyBzZXQgc28gaXQgY2FuIHNlZQo+IHdoYXQgZmVh
dHVyZXMgdGhlIGd1ZXN0IGRyaXZlciBhY2NlcHRlZC4KClJpZ2h0LiBXaWxsIGhhdmUgYSBsb29r
Lgo+IAo+IE92ZXJsb2FkaW5nIHRoZSBub3RpZnkgaHlwZXJjYWxsIGlzIGtpbmQgb2YgYSBoYWNr
IHRvbywgYnV0IGl0IHdvcmtzIHNvCj4gbm8gcmVhbCBuZWVkIHRvIGNoYW5nZSB0aGF0Lgo+IAo+
ID4gKyAqIFRoZSByb290IGRldmljZSBmb3IgdGhlIGt2bSB2aXJ0aW8gZGV2aWNlcy4KPiA+ICsg
KiBUaGlzIG1ha2VzIHRoZW0gYXBwZWFyIGFzIC9zeXMvZGV2aWNlcy9rdm0vMCwxLDIgCm5vdCAv
c3lzL2RldmljZXMvMCwxLDIuCj4gPiArICovIAo+ID4gK3N0YXRpYyBzdHJ1Y3QgZGV2aWNlIGt2
bV9yb290ID0gewo+ID4gKwkucGFyZW50ID0gTlVMTCwKPiA+ICsJLmJ1c19pZCA9ICJrdm1fczM5
MCIsCj4gPiArfTsKPiAKPiBZb3UgbWVhbiAvc3lzL2RldmljZXMva3ZtX3MzOTAvMCwxLDI/CgpZ
ZXMsIHRoYW5rcy4KPiAKPiA+ICtzdGF0aWMgaW50IF9faW5pdCBrdm1fZGV2aWNlc19pbml0KHZv
aWQpCj4gPiArewo+ID4gKwlpZiAoIU1BQ0hJTkVfSVNfS1ZNKQo+ID4gKwkJcmV0dXJuIC1FTk9E
RVY7Cj4gPiArCj4gPiArCWlmIChkZXZpY2VfcmVnaXN0ZXIoJmt2bV9yb290KSAhPSAwKQo+ID4g
KwkJcGFuaWMoIkNvdWxkIG5vdCByZWdpc3RlciBrdm0gcm9vdCIpOwo+ID4gKwo+ID4gKwlpZiAo
YWRkX3NoYXJlZF9tZW1vcnkoKG1heF9wZm4pIDw8IFBBR0VfU0hJRlQsIFBBR0VfU0laRSkpIHsK
PiA+ICsJCWRldmljZV91bnJlZ2lzdGVyKCZrdm1fcm9vdCk7Cj4gPiArCQlyZXR1cm4gLUVOT01F
TTsKPiA+ICsJfQo+IAo+IEhtbSwgcGFuaWMgb24gZGV2aWNlX3JlZ2lzdGVyIGZhaWwsIGJ1dCAt
RU5PTUVNIG9uIGFkZF9zaGFyZWRfbWVtb3J5IGZhaWw/Cj4gTXkgdGhlb3J5IHdhcyB0aGF0IHNp
bmNlIHRoaXMgaXMgYm9vdCB0aW1lLCBwYW5pYygpIGlzIHRoZSByaWdodCB0aGluZy4KCkdvb2Qg
c3BvdCwgYnV0IEkgYWdyZWUgd2l0aCBDYXJzdGVuLiBEcml2ZXJzIHNob3VsZCBub3QgcGFuaWMu
IEkgaGF2ZSBtb2R1bGUgCmxvYWQvdW5sb2FkIGNhcGFiaWxpdHkgb24gbXkgbG9uZyB0ZXJtIHRv
ZG8gbGlzdCwgYnV0IEkgY2FuIGNoYW5nZSB0aGUgCnBhbmljIG5vdy4KCkNocmlzdGlhbgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=

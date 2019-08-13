From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v6 16/92] kvm: introspection: handle events and event
	replies
Date: Tue, 13 Aug 2019 18:25:36 +0300
Message-ID: <28058.7806644448$1565709923@news.gmane.org>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-17-alazar@bitdefender.com>
	<08325b3b-3af9-382b-7c0f-8410e8fcb545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <08325b3b-3af9-382b-7c0f-8410e8fcb545@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, Radim =?iso-8859-2?b?S3LobeH4?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel =?iso-8859-1?q?Laur=E9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Mihai =?UTF-8?b?RG9uyJt1?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gVHVlLCAxMyBBdWcgMjAxOSAxMDo1NToyMSArMDIwMCwgUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSD
ciB3cm90ZToKPiA+IAo+ID4gKwkJCSByZXBseS0+cGFkZGluZzIpOwo+ID4gKwo+ID4gKwlpdmNw
dS0+cmVwbHlfd2FpdGluZyA9IGZhbHNlOwo+ID4gKwlyZXR1cm4gZXhwZWN0ZWQtPmVycm9yOwo+
ID4gK30KPiA+ICsKPiA+ICAvKgo+IAo+IElzIHRoaXMgbWlzc2luZyBhIHdha2V1cD8KPiAKPiA+
ICAKPiA+ICtzdGF0aWMgYm9vbCBuZWVkX3RvX3dhaXQoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQo+
ID4gK3sKPiA+ICsJc3RydWN0IGt2bWlfdmNwdSAqaXZjcHUgPSBJVkNQVSh2Y3B1KTsKPiA+ICsK
PiA+ICsJcmV0dXJuIGl2Y3B1LT5yZXBseV93YWl0aW5nOwo+ID4gK30KPiA+ICsKPiAKPiBEbyB5
b3UgYWN0dWFsbHkgbmVlZCB0aGlzIGZ1bmN0aW9uPyAgSXQgc2VlbXMgdG8gbWUgdGhhdCBldmVy
eXdoZXJlIHlvdQo+IGNhbGwgaXQgeW91IGFscmVhZHkgaGF2ZSBhbiBpdmNwdSwgc28geW91IGNh
biBqdXN0IGFjY2VzcyB0aGUgZmllbGQuCj4gCj4gQWxzbywgInJlcGx5X3dhaXRpbmciIG1lYW5z
ICJ0aGVyZSBpcyBhIHJlcGx5IHRoYXQgaXMgd2FpdGluZyIuICBXaGF0Cj4geW91IG1lYW4gaXMg
IndhaXRpbmdfZm9yX3JlcGx5Ii4KCkluIGFuIG9sZGVyIHZlcnNpb24sIGhhbmRsZV9ldmVudF9y
ZXBseSgpIHdhcyBleGVjdXRlZCBmcm9tIHRoZSByZWNlaXZpbmcKdGhyZWFkIChoYXZpbmcgYW5v
dGhlciBuYW1lKSBhbmQgaXQgY29udGFpbmVkIGEgd2FrZXVwIGZ1bmN0aW9uLiBOb3csCmluZGVl
ZCwgJ3dhaXRpbmdfZm9yX3JlcGx5JyBpcyB0aGUgcmlnaHQgbmFtZS4KIAo+IFRoZSBvdmVyYWxs
IHN0cnVjdHVyZSBvZiB0aGUgam9icyBjb2RlIGlzIGNvbmZ1c2luZy4gIFRoZSBzYW1lIGZ1bmN0
aW9uCj4ga3ZtX3J1bl9qb2JzX2FuZF93YWl0IGlzIGFuIGluZmluaXRlIGxvb3AgYmVmb3JlIGFu
ZCBnZXRzIGEgImJyZWFrIgo+IGxhdGVyLiAgSXQgaXMgYWxzbyBub3QgY2xlYXIgd2h5IGt2bWlf
am9iX3dhaXQgaXMgY2FsbGVkIHRocm91Z2ggYSBqb2IuCj4gIENhbiB5b3UgaGF2ZSBpbnN0ZWFk
IGp1c3Qga3ZtX3J1bl9qb2JzIGluIEtWTV9SRVFfSU5UUk9TUEVDVElPTiwgYW5kCj4gc29tZXRo
aW5nIGxpa2UgdGhpcyBpbnN0ZWFkIHdoZW4gc2VuZGluZyBhbiBldmVudDoKPiAKPiBpbnQga3Zt
aV93YWl0X2Zvcl9yZXBseShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4gewo+IAlzdHJ1Y3Qga3Zt
aV92Y3B1ICppdmNwdSA9IElWQ1BVKHZjcHUpOwo+IAo+IAl3aGlsZSAoaXZjcHUtPndhaXRpbmdf
Zm9yX3JlcGx5KSB7Cj4gCQlrdm1pX3J1bl9qb2JzKHZjcHUpOwo+IAo+IAkJZXJyID0gc3dhaXRf
ZXZlbnRfa2lsbGFibGUoKndxLAo+IAkJCQkhaXZjcHUtPndhaXRpbmdfZm9yX3JlcGx5IHx8Cj4g
CQkJCSFsaXN0X2VtcHR5KCZpdmNwdS0+am9iX2xpc3QpKTsKPiAKPiAJCWlmIChlcnIpCj4gCQkJ
cmV0dXJuIC1FSU5UUjsKPiAJfQo+IAo+IAlyZXR1cm4gMDsKPiB9Cj4gCj4gPwo+IAo+IFBhb2xv
CgpNdWNoIGJldHRlciA6KSBUaGFuayB5b3UuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 70/92] kvm: x86: filter out access rights only when
	tracked by the introspection tool
Date: Tue, 13 Aug 2019 11:08:39 +0200
Message-ID: <8cba6816-8d3a-2498-b3b0-2ce76a98ce12@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-71-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-71-alazar@bitdefender.com>
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
To: =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>, kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTg6MDAsIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiBJdCBzaG91bGQgY29t
cGxldGUgdGhlIGNvbW1pdCBmZDM0YTk1MTgxNzMgKCJrdm06IHg4NjogY29uc3VsdCB0aGUgcGFn
ZSB0cmFja2luZyBmcm9tIGt2bV9tbXVfZ2V0X3BhZ2UoKSBhbmQgX19kaXJlY3RfbWFwKCkiKQo+
IAo+IFNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNv
bT4KPiAtLS0KPiAgYXJjaC94ODYva3ZtL21tdS5jIHwgMyArKysKPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11LmMgYi9h
cmNoL3g4Ni9rdm0vbW11LmMKPiBpbmRleCA2NWI2YWNiYTgyZGEuLmZkNjRjZjExMTVkYSAxMDA2
NDQKPiAtLS0gYS9hcmNoL3g4Ni9rdm0vbW11LmMKPiArKysgYi9hcmNoL3g4Ni9rdm0vbW11LmMK
PiBAQCAtMjY2MCw2ICsyNjYwLDkgQEAgc3RhdGljIHZvaWQgY2xlYXJfc3Bfd3JpdGVfZmxvb2Rp
bmdfY291bnQodTY0ICpzcHRlKQo+ICBzdGF0aWMgdW5zaWduZWQgaW50IGt2bV9tbXVfcGFnZV90
cmFja19hY2Moc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCBnZm5fdCBnZm4sCj4gIAkJCQkJICAgdW5z
aWduZWQgaW50IGFjYykKPiAgewo+ICsJaWYgKCFrdm1pX3RyYWNrZWRfZ2ZuKHZjcHUsIGdmbikp
Cj4gKwkJcmV0dXJuIGFjYzsKPiArCj4gIAlpZiAoa3ZtX3BhZ2VfdHJhY2tfaXNfYWN0aXZlKHZj
cHUsIGdmbiwgS1ZNX1BBR0VfVFJBQ0tfUFJFUkVBRCkpCj4gIAkJYWNjICY9IH5BQ0NfVVNFUl9N
QVNLOwo+ICAJaWYgKGt2bV9wYWdlX3RyYWNrX2lzX2FjdGl2ZSh2Y3B1LCBnZm4sIEtWTV9QQUdF
X1RSQUNLX1BSRVdSSVRFKSB8fAo+IAoKSWYgdGhpcyBwYXRjaCBpcyBhbHdheXMgbmVlZGVkLCB0
aGVuIHRoZSBmdW5jdGlvbiBzaG91bGQgYmUgbmFtZWQKc29tZXRoaW5nIGxpa2Uga3ZtX21tdV9h
cHBseV9pbnRyb3NwZWN0aW9uX2FjY2VzcyBhbmQga3ZtaV90cmFja2VkX2dmbgpzaG91bGQgYmUg
dGVzdGVkIGZyb20gdGhlIG1vbWVudCBpdCBpcyBpbnRyb2R1Y2VkLgoKQnV0IHRoZSBjb21taXQg
bWVzc2FnZSBzYXlzIG5vdGhpbmcgYWJvdXQgX3doeV8gaXQgaXMgbmVlZGVkLCBzbyBJCmNhbm5v
dCBndWVzcy4gIEkgd291bGQgdmVyeSBtdWNoIGF2b2lkIGl0IGhvd2V2ZXIuICBJcyBpdCBqdXN0
IGFuCm9wdGltaXphdGlvbj8KClBhb2xvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

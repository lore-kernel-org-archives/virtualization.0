From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v6 13/92] kvm: introspection: make the vCPU wait even
	when its jobs list is empty
Date: Tue, 13 Aug 2019 17:19:51 +0300
Message-ID: <18491.1777077772$1565705976@news.gmane.org>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-14-alazar@bitdefender.com>
	<c82b509a-86a7-6c2c-943e-f78a02e6efb1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c82b509a-86a7-6c2c-943e-f78a02e6efb1@redhat.com>
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

T24gVHVlLCAxMyBBdWcgMjAxOSAxMDo0Mzo1MiArMDIwMCwgUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSD
ciB3cm90ZToKPiA+ICt2b2lkIGt2bWlfaGFuZGxlX3JlcXVlc3RzKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkKPiA+ICt7Cj4gPiArCXN0cnVjdCBrdm1pICppa3ZtOwo+ID4gKwo+ID4gKwlpa3ZtID0g
a3ZtaV9nZXQodmNwdS0+a3ZtKTsKPiA+ICsJaWYgKCFpa3ZtKQo+ID4gKwkJcmV0dXJuOwo+ID4g
Kwo+ID4gKwlmb3IgKDs7KSB7Cj4gPiArCQlpbnQgZXJyID0ga3ZtaV9ydW5fam9ic19hbmRfd2Fp
dCh2Y3B1KTsKPiA+ICsKPiA+ICsJCWlmIChlcnIpCj4gPiArCQkJYnJlYWs7Cj4gPiArCX0KPiA+
ICsKPiA+ICsJa3ZtaV9wdXQodmNwdS0+a3ZtKTsKPiA+ICt9Cj4gPiArCj4gCj4gVXNpbmcga3Zt
aV9ydW5fam9ic19hbmRfd2FpdCBmcm9tIHR3byBwbGFjZXMgKGhlcmUgYW5kIGt2bWlfc2VuZF9l
dmVudCkKPiBpcyB2ZXJ5IGNvbmZ1c2luZy4gIERvZXMga3ZtaV9oYW5kbGVfcmVxdWVzdHMgbmVl
ZCB0byBkbyB0aGlzLCBvciBjYW4gaXQKPiBqdXN0IHVzZSBrdm1pX3J1bl9qb2JzPwoKSSB0aGlu
ayBJJ3ZlIGFkZGVkIHRoaXMgd2FpdCB0byBibG9jayB2Q1BVcyBkdXJpbmcgc2luZ2xlLXN0ZXAu
CkEgJ3dhaXRfdW50aWxfc2luZ2xlX3N0ZXBfZmluaXNoZWQnIGpvYiB3aWxsIGRvLCBJIGd1ZXNz
LCBzbyB3ZSBjb3VsZAp1c2Uga3ZtaV9ydW5fam9icygpIGhlcmUuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 13/92] kvm: introspection: make the vCPU wait even
	when its jobs list is empty
Date: Tue, 13 Aug 2019 10:43:52 +0200
Message-ID: <c82b509a-86a7-6c2c-943e-f78a02e6efb1@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-14-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-14-alazar@bitdefender.com>
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

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiArdm9pZCBrdm1pX2hh
bmRsZV9yZXF1ZXN0cyhzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpCj4gK3sKPiArCXN0cnVjdCBrdm1p
ICppa3ZtOwo+ICsKPiArCWlrdm0gPSBrdm1pX2dldCh2Y3B1LT5rdm0pOwo+ICsJaWYgKCFpa3Zt
KQo+ICsJCXJldHVybjsKPiArCj4gKwlmb3IgKDs7KSB7Cj4gKwkJaW50IGVyciA9IGt2bWlfcnVu
X2pvYnNfYW5kX3dhaXQodmNwdSk7Cj4gKwo+ICsJCWlmIChlcnIpCj4gKwkJCWJyZWFrOwo+ICsJ
fQo+ICsKPiArCWt2bWlfcHV0KHZjcHUtPmt2bSk7Cj4gK30KPiArCgpVc2luZyBrdm1pX3J1bl9q
b2JzX2FuZF93YWl0IGZyb20gdHdvIHBsYWNlcyAoaGVyZSBhbmQga3ZtaV9zZW5kX2V2ZW50KQpp
cyB2ZXJ5IGNvbmZ1c2luZy4gIERvZXMga3ZtaV9oYW5kbGVfcmVxdWVzdHMgbmVlZCB0byBkbyB0
aGlzLCBvciBjYW4gaXQKanVzdCB1c2Uga3ZtaV9ydW5fam9icz8KClBhb2xvCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==

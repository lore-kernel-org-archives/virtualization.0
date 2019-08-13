From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 02/92] kvm: introspection: add basic ioctls
	(hook/unhook)
Date: Tue, 13 Aug 2019 10:44:28 +0200
Message-ID: <58808ef0-57b1-47ac-a115-e1dd64a15b0a@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-3-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-3-alazar@bitdefender.com>
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
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C Zhang <yu.c.zhang@intel.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?Q?Samuel_Laur=c3=a9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Mircea_C=c3=aerjaliu?= <mcirjaliu@bitdefender.com>, =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiArc3RhdGljIGludCBr
dm1pX3JlY3Yodm9pZCAqYXJnKQo+ICt7Cj4gKwlzdHJ1Y3Qga3ZtaSAqaWt2bSA9IGFyZzsKPiAr
Cj4gKwlrdm1pX2luZm8oaWt2bSwgIkhvb2tpbmcgVk1cbiIpOwo+ICsKPiArCXdoaWxlIChrdm1p
X21zZ19wcm9jZXNzKGlrdm0pKQo+ICsJCTsKPiArCj4gKwlrdm1pX2luZm8oaWt2bSwgIlVuaG9v
a2luZyBWTVxuIik7Cj4gKwo+ICsJa3ZtaV9lbmRfaW50cm9zcGVjdGlvbihpa3ZtKTsKPiArCj4g
KwlyZXR1cm4gMDsKPiArfQo+ICsKClJlbmFtZSB0aGlzIHRvIGt2bWlfcmVjdl90aHJlYWQgaW5z
dGVhZCwgcGxlYXNlLgoKPiArCj4gKwkvKgo+ICsJICogTWFrZSBzdXJlIGFsbCB0aGUgS1ZNL0tW
TUkgc3RydWN0dXJlcyBhcmUgbGlua2VkIGFuZCBubyBwb2ludGVyCj4gKwkgKiBpcyByZWFkIGFz
IE5VTEwgYWZ0ZXIgdGhlIHJlZmVyZW5jZSBjb3VudCBoYXMgYmVlbiBzZXQuCj4gKwkgKi8KPiAr
CXNtcF9tYl9fYmVmb3JlX2F0b21pYygpOwoKVGhpcyBpcyBhbiBzbXBfd21iKCksIG5vdCBhbiBz
bXBfbWJfX2JlZm9yZV9hdG9taWMoKS4gIEFkZCBhIGNvbW1lbnQKdGhhdCBpdCBwYWlycyB3aXRo
IHRoZSByZWZjb3VudF9pbmNfbm90X3plcm8gaW4ga3ZtaV9nZXQuCgo+ICsJcmVmY291bnRfc2V0
KCZrdm0tPmt2bWlfcmVmLCAxKTsKPiArCgoKPiBAQCAtNTcsOCArMTgzLDI3IEBAIHZvaWQga3Zt
aV9kZXN0cm95X3ZtKHN0cnVjdCBrdm0gKmt2bSkKPiAgCWlmICghaWt2bSkKPiAgCQlyZXR1cm47
Cj4gIAo+ICsJLyogdHJpZ2dlciBzb2NrZXQgc2h1dGRvd24gLSBrdm1pX3JlY3YoKSB3aWxsIHN0
YXJ0IHNodXRkb3duIHByb2Nlc3MgKi8KPiArCWt2bWlfc29ja19zaHV0ZG93bihpa3ZtKTsKPiAr
Cj4gIAlrdm1pX3B1dChrdm0pOwo+ICAKPiAgCS8qIHdhaXQgZm9yIGludHJvc3BlY3Rpb24gcmVz
b3VyY2VzIHRvIGJlIHJlbGVhc2VkICovCj4gIAl3YWl0X2Zvcl9jb21wbGV0aW9uX2tpbGxhYmxl
KCZrdm0tPmt2bWlfY29tcGxldGVkKTsKPiAgfQo+ICsKClRoaXMgYWRkaXRpb24gbWVhbnMgdGhh
dCBrdm1pX2Rlc3Ryb3lfdm0gc2hvdWxkIGhhdmUgY2FsbGVkCmt2bWlfZW5kX2ludHJvc3BlY3Rp
b24gaW5zdGVhZC4gIEluIHBhdGNoIDEsIGt2bWlfZW5kX2ludHJvc3BlY3Rpb24Kc2hvdWxkIGhh
dmUgYmVlbiBqdXN0IGt2bWlfcHV0LCBub3cgdGhpcyBwYXRjaCBjYW4gYWRkIGt2bWlfc29ja19z
aHV0ZG93bi4KClBhb2xvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

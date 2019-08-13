From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 16/92] kvm: introspection: handle events and event
	replies
Date: Tue, 13 Aug 2019 10:55:21 +0200
Message-ID: <08325b3b-3af9-382b-7c0f-8410e8fcb545@redhat.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
	<20190809160047.8319-17-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-17-alazar@bitdefender.com>
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

T24gMDkvMDgvMTkgMTc6NTksIEFkYWxiZXJ0IExhesSDciB3cm90ZToKPiAKPiArCQkJIHJlcGx5
LT5wYWRkaW5nMik7Cj4gKwo+ICsJaXZjcHUtPnJlcGx5X3dhaXRpbmcgPSBmYWxzZTsKPiArCXJl
dHVybiBleHBlY3RlZC0+ZXJyb3I7Cj4gK30KPiArCj4gIC8qCgpJcyB0aGlzIG1pc3NpbmcgYSB3
YWtldXA/Cgo+ICAKPiArc3RhdGljIGJvb2wgbmVlZF90b193YWl0KHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSkKPiArewo+ICsJc3RydWN0IGt2bWlfdmNwdSAqaXZjcHUgPSBJVkNQVSh2Y3B1KTsKPiAr
Cj4gKwlyZXR1cm4gaXZjcHUtPnJlcGx5X3dhaXRpbmc7Cj4gK30KPiArCgpEbyB5b3UgYWN0dWFs
bHkgbmVlZCB0aGlzIGZ1bmN0aW9uPyAgSXQgc2VlbXMgdG8gbWUgdGhhdCBldmVyeXdoZXJlIHlv
dQpjYWxsIGl0IHlvdSBhbHJlYWR5IGhhdmUgYW4gaXZjcHUsIHNvIHlvdSBjYW4ganVzdCBhY2Nl
c3MgdGhlIGZpZWxkLgoKQWxzbywgInJlcGx5X3dhaXRpbmciIG1lYW5zICJ0aGVyZSBpcyBhIHJl
cGx5IHRoYXQgaXMgd2FpdGluZyIuICBXaGF0CnlvdSBtZWFuIGlzICJ3YWl0aW5nX2Zvcl9yZXBs
eSIuCgpUaGUgb3ZlcmFsbCBzdHJ1Y3R1cmUgb2YgdGhlIGpvYnMgY29kZSBpcyBjb25mdXNpbmcu
ICBUaGUgc2FtZSBmdW5jdGlvbgprdm1fcnVuX2pvYnNfYW5kX3dhaXQgaXMgYW4gaW5maW5pdGUg
bG9vcCBiZWZvcmUgYW5kIGdldHMgYSAiYnJlYWsiCmxhdGVyLiAgSXQgaXMgYWxzbyBub3QgY2xl
YXIgd2h5IGt2bWlfam9iX3dhaXQgaXMgY2FsbGVkIHRocm91Z2ggYSBqb2IuCiBDYW4geW91IGhh
dmUgaW5zdGVhZCBqdXN0IGt2bV9ydW5fam9icyBpbiBLVk1fUkVRX0lOVFJPU1BFQ1RJT04sIGFu
ZApzb21ldGhpbmcgbGlrZSB0aGlzIGluc3RlYWQgd2hlbiBzZW5kaW5nIGFuIGV2ZW50OgoKaW50
IGt2bWlfd2FpdF9mb3JfcmVwbHkoc3RydWN0IGt2bV92Y3B1ICp2Y3B1KQp7CglzdHJ1Y3Qga3Zt
aV92Y3B1ICppdmNwdSA9IElWQ1BVKHZjcHUpOwoKCXdoaWxlIChpdmNwdS0+d2FpdGluZ19mb3Jf
cmVwbHkpIHsKCQlrdm1pX3J1bl9qb2JzKHZjcHUpOwoKCQllcnIgPSBzd2FpdF9ldmVudF9raWxs
YWJsZSgqd3EsCgkJCQkhaXZjcHUtPndhaXRpbmdfZm9yX3JlcGx5IHx8CgkJCQkhbGlzdF9lbXB0
eSgmaXZjcHUtPmpvYl9saXN0KSk7CgoJCWlmIChlcnIpCgkJCXJldHVybiAtRUlOVFI7Cgl9CgoJ
cmV0dXJuIDA7Cn0KCj8KClBhb2xvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 07/92] kvm: introspection: honor the reply option when
	handling the KVMI_GET_VERSION command
Date: Fri,  9 Aug 2019 18:59:22 +0300
Message-ID: <20190809160047.8319-8-alazar@bitdefender.com>
References: <20190809160047.8319-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809160047.8319-1-alazar@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: Tamas K Lengyel <tamas@tklengyel.com>, Weijiang Yang <weijiang.yang@intel.com>, Yu C <yu.c.zhang@intel.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?q?Samuel=20Laur=C3=A9n?= <samuel.lauren@iki.fi>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>, linux-mm@kvack.org, Patrick Colp <patrick.colp@oracle.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang@mail.linuxfoundation.org, =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

T2J2aW91c2x5LCB0aGUgS1ZNSV9HRVRfVkVSU0lPTiBjb21tYW5kIG11c3Qgbm90IGJlIHVzZWQg
d2hlbiB0aGUgY29tbWFuZApyZXBseSBpcyBkaXNhYmxlZCBieSBhIHByZXZpb3VzIEtWTUlfQ09O
VFJPTF9DTURfUkVTUE9OU0UgY29tbWFuZC4KClRoaXMgY29tbWl0IGNoYW5nZXMgdGhlIGNvZGUg
cGF0aCBpbiBvcmRlciB0byBjaGVjayB0aGUgcmVwbHkgb3B0aW9uCihlbmFibGVkL2Rpc2FibGVk
KSBiZWZvcmUgdHJ5aW5nIHRvIHJlcGx5IHRvIHRoaXMgY29tbWFuZC4gSWYgdGhlIGNvbW1hbmQK
cmVwbHkgaXMgZGlzYWJsZWQgaXQgd2lsbCByZXR1cm4gYW4gZXJyb3IgdG8gdGhlIGNhbGxlci4g
SW4gdGhlIGVuZCwgdGhlCnJlY2VpdmluZyB3b3JrZXIgd2lsbCBmaW5pc2ggYW5kIHRoZSBpbnRy
b3NwZWN0aW9uIHNvY2tldCB3aWxsIGJlIGNsb3NlZC4KClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0
IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiB2aXJ0L2t2bS9rdm1pX21zZy5j
IHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvdmlydC9rdm0va3ZtaV9tc2cuYyBiL3ZpcnQva3ZtL2t2bWlfbXNnLmMKaW5k
ZXggZWE1YzdlMjM2NjlhLi4yMjM3YTZlZDI1ZjYgMTAwNjQ0Ci0tLSBhL3ZpcnQva3ZtL2t2bWlf
bXNnLmMKKysrIGIvdmlydC9rdm0va3ZtaV9tc2cuYwpAQCAtMTY5LDcgKzE2OSw3IEBAIHN0YXRp
YyBpbnQgaGFuZGxlX2dldF92ZXJzaW9uKHN0cnVjdCBrdm1pICppa3ZtLAogCW1lbXNldCgmcnBs
LCAwLCBzaXplb2YocnBsKSk7CiAJcnBsLnZlcnNpb24gPSBLVk1JX1ZFUlNJT047CiAKLQlyZXR1
cm4ga3ZtaV9tc2dfdm1fcmVwbHkoaWt2bSwgbXNnLCAwLCAmcnBsLCBzaXplb2YocnBsKSk7CisJ
cmV0dXJuIGt2bWlfbXNnX3ZtX21heWJlX3JlcGx5KGlrdm0sIG1zZywgMCwgJnJwbCwgc2l6ZW9m
KHJwbCkpOwogfQogCiBzdGF0aWMgYm9vbCBpc19jb21tYW5kX2FsbG93ZWQoc3RydWN0IGt2bWkg
Kmlrdm0sIGludCBpZCkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

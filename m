From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 88/92] kvm: x86: emulate fst/fstp m64fp
Date: Fri,  9 Aug 2019 19:00:43 +0300
Message-ID: <20190809160047.8319-89-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKVGhpcyBhZGRzIHN1
cHBvcnQgZm9yIGZzdCBtNjRmcCBhbmQgZnN0cCBtNjRmcC4KClNpZ25lZC1vZmYtYnk6IE1paGFp
IERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQg
TGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2t2bS9lbXVsYXRl
LmMgfCAyMyArKysrKysrKysrKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vZW11bGF0
ZS5jIGIvYXJjaC94ODYva3ZtL2VtdWxhdGUuYwppbmRleCAxNDg5NWMwNDNlZGMuLjcyNjFiOTRj
NmMwMCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL2VtdWxhdGUuYworKysgYi9hcmNoL3g4Ni9r
dm0vZW11bGF0ZS5jCkBAIC0xMTc4LDYgKzExNzgsMjYgQEAgc3RhdGljIGludCBlbV9mbnN0c3co
c3RydWN0IHg4Nl9lbXVsYXRlX2N0eHQgKmN0eHQpCiAJcmV0dXJuIFg4NkVNVUxfQ09OVElOVUU7
CiB9CiAKK3N0YXRpYyBpbnQgZW1fZnN0cChzdHJ1Y3QgeDg2X2VtdWxhdGVfY3R4dCAqY3R4dCkK
K3sKKwlpZiAoY3R4dC0+b3BzLT5nZXRfY3IoY3R4dCwgMCkgJiAoWDg2X0NSMF9UUyB8IFg4Nl9D
UjBfRU0pKQorCQlyZXR1cm4gZW11bGF0ZV9ubShjdHh0KTsKKworCWFzbSB2b2xhdGlsZSgiZnN0
cGwgJTAiIDogIj1tIihjdHh0LT5kc3QudmFsKSk7CisKKwlyZXR1cm4gWDg2RU1VTF9DT05USU5V
RTsKK30KKworc3RhdGljIGludCBlbV9mc3Qoc3RydWN0IHg4Nl9lbXVsYXRlX2N0eHQgKmN0eHQp
Cit7CisJaWYgKGN0eHQtPm9wcy0+Z2V0X2NyKGN0eHQsIDApICYgKFg4Nl9DUjBfVFMgfCBYODZf
Q1IwX0VNKSkKKwkJcmV0dXJuIGVtdWxhdGVfbm0oY3R4dCk7CisKKwlhc20gdm9sYXRpbGUoImZz
dGwgJTAiIDogIj1tIihjdHh0LT5kc3QudmFsKSk7CisKKwlyZXR1cm4gWDg2RU1VTF9DT05USU5V
RTsKK30KKwogc3RhdGljIGludCBlbV94b3JwcyhzdHJ1Y3QgeDg2X2VtdWxhdGVfY3R4dCAqY3R4
dCkKIHsKIAljb25zdCBzc2UxMjhfdCAqc3JjID0gJmN0eHQtPnNyYy52ZWNfdmFsOwpAQCAtNDY3
OCw3ICs0Njk4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBlc2NhcGUgZXNjYXBlX2RiID0geyB7
CiB9IH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXNjYXBlIGVzY2FwZV9kZCA9IHsgewotCU4s
IE4sIE4sIE4sIE4sIE4sIE4sIEkoRHN0TWVtMTYgfCBNb3YsIGVtX2Zuc3RzdyksCisJTiwgTiwg
SShEc3RNZW02NCB8IE1vdiwgZW1fZnN0KSwgSShEc3RNZW02NCB8IE1vdiwgZW1fZnN0cCksCisJ
TiwgTiwgTiwgSShEc3RNZW0xNiB8IE1vdiwgZW1fZm5zdHN3KSwKIH0sIHsKIAkvKiAweEMwIC0g
MHhDNyAqLwogCU4sIE4sIE4sIE4sIE4sIE4sIE4sIE4sCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

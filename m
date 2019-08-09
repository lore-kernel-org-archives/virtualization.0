From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 84/92] kvm: x86: enable the half part of movss, movsd,
	movups
Date: Fri,  9 Aug 2019 19:00:39 +0300
Message-ID: <20190809160047.8319-85-alazar@bitdefender.com>
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

RnJvbTogTWloYWkgRG9uyJt1IDxtZG9udHVAYml0ZGVmZW5kZXIuY29tPgoKQSBwcmV2aW91cyBw
YXRjaCBhZGRlZCBlbXVsYXRpb24gc3VwcG9ydCBmb3IgdGhlc2UgaW5zdHJ1Y3Rpb25zIHdpdGgg
YQpyZWdpc3RlciBzb3VyY2UgYW5kIG1lbW9yeSBkZXN0aW5hdGlvbi4gVGhpcyBwYXRjaCBhZGRz
IHRoZSB2YXJpYW50cwp3aXRoIGEgbWVtb3J5IHNvdXJjZSBhbmQgYSByZWdpc3RlciBkZXN0aW5h
dGlvbi4KClNpZ25lZC1vZmYtYnk6IE1paGFpIERvbsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNv
bT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29t
PgotLS0KIGFyY2gveDg2L2t2bS9lbXVsYXRlLmMgfCA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vZW11bGF0ZS5jIGIvYXJj
aC94ODYva3ZtL2VtdWxhdGUuYwppbmRleCBiNDJhNzE2NTM2MjIuLmEyZTVlNjNiZDk0YSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYva3ZtL2VtdWxhdGUuYworKysgYi9hcmNoL3g4Ni9rdm0vZW11bGF0
ZS5jCkBAIC0xMTg0LDYgKzExODQsMTAgQEAgc3RhdGljIHU4IHNpbWRfcHJlZml4X3RvX2J5dGVz
KGNvbnN0IHN0cnVjdCB4ODZfZW11bGF0ZV9jdHh0ICpjdHh0LAogCXU4IGJ5dGVzID0gMTY7CiAK
IAlzd2l0Y2ggKGN0eHQtPmIpIHsKKwljYXNlIDB4MTA6CisJCS8qIG1vdnNzIG0zMiwgeG1tICov
CisJCS8qIG1vdnNkIG02NCwgeG1tICovCisJCS8qIG1vdnVwcyBtMTI4LCB4bW0gKi8KIAljYXNl
IDB4MTE6CiAJCS8qIG1vdnNzIHhtbSwgbTMyICovCiAJCS8qIG1vdnNkIHhtbSwgbTY0ICovCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==

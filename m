From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 75/92] kvm: x86: disable gpa_available optimization in
	emulator_read_write_onepage()
Date: Fri,  9 Aug 2019 19:00:30 +0300
Message-ID: <20190809160047.8319-76-alazar@bitdefender.com>
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

SWYgdGhlIEVQVCB2aW9sYXRpb24gd2FzIGNhdXNlZCBieSBhbiBleGVjdXRlIHJlc3RyaWN0aW9u
IGltcG9zZWQgYnkgdGhlCmludHJvc3BlY3Rpb24gdG9vbCwgZ3BhX2F2YWlsYWJsZSB3aWxsIHBv
aW50IHRvIHRoZSBpbnN0cnVjdGlvbiBwb2ludGVyLApub3QgdGhlIHRvIHRoZSByZWFkL3dyaXRl
IGxvY2F0aW9uIHRoYXQgaGFzIHRvIGJlIHVzZWQgdG8gZW11bGF0ZSB0aGUKY3VycmVudCBpbnN0
cnVjdGlvbi4KClRoaXMgb3B0aW1pemF0aW9uIHNob3VsZCBiZSBkaXNhYmxlZCBvbmx5IHdoZW4g
dGhlIFZNIGlzIGludHJvc3BlY3RlZCwKbm90IGp1c3QgYmVjYXVzZSB0aGUgaW50cm9zcGVjdGlv
biBzdWJzeXN0ZW0gaXMgcHJlc2VudC4KClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8
YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9rdm0veDg2LmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rdm0veDg2LmMgYi9hcmNoL3g4Ni9rdm0veDg2LmMKaW5kZXggOTY1YzRmMDEw
OGViLi4zOTc1MzMxMjMwYjkgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2t2bS94ODYuYworKysgYi9h
cmNoL3g4Ni9rdm0veDg2LmMKQEAgLTU1MzIsNyArNTUzMiw3IEBAIHN0YXRpYyBpbnQgZW11bGF0
b3JfcmVhZF93cml0ZV9vbmVwYWdlKHVuc2lnbmVkIGxvbmcgYWRkciwgdm9pZCAqdmFsLAogCSAq
IG9wZXJhdGlvbiB1c2luZyByZXAgd2lsbCBvbmx5IGhhdmUgdGhlIGluaXRpYWwgR1BBIGZyb20g
dGhlIE5QRgogCSAqIG9jY3VycmVkLgogCSAqLwotCWlmICh2Y3B1LT5hcmNoLmdwYV9hdmFpbGFi
bGUgJiYKKwlpZiAodmNwdS0+YXJjaC5ncGFfYXZhaWxhYmxlICYmICFrdm1pX2lzX3ByZXNlbnQo
KSAmJgogCSAgICBlbXVsYXRvcl9jYW5fdXNlX2dwYShjdHh0KSAmJgogCSAgICAoYWRkciAmIH5Q
QUdFX01BU0spID09ICh2Y3B1LT5hcmNoLmdwYV92YWwgJiB+UEFHRV9NQVNLKSkgewogCQlncGEg
PSB2Y3B1LT5hcmNoLmdwYV92YWw7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

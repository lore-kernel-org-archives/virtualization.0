From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 69/92] kvm: x86: keep the page protected if tracked by
	the introspection tool
Date: Fri,  9 Aug 2019 19:00:24 +0300
Message-ID: <20190809160047.8319-70-alazar@bitdefender.com>
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

VGhpcyBwYXRjaCBtaWdodCBiZSBvYnNvbGV0ZSB0aGFua3MgdG8gc2luZ2xlLXN0ZXBwaW5nLgoK
U2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgot
LS0KIGFyY2gveDg2L2t2bS94ODYuYyB8IDkgKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS94
ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYwppbmRleCAyYzA2ZGU3M2E3ODQuLjA2ZjQ0Y2U4ZWQw
NyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jCisrKyBiL2FyY2gveDg2L2t2bS94ODYu
YwpAQCAtNjMxMSw3ICs2MzExLDggQEAgc3RhdGljIGJvb2wgcmVleGVjdXRlX2luc3RydWN0aW9u
KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ3ZhX3QgY3IyLAogCQlpbmRpcmVjdF9zaGFkb3dfcGFn
ZXMgPSB2Y3B1LT5rdm0tPmFyY2guaW5kaXJlY3Rfc2hhZG93X3BhZ2VzOwogCQlzcGluX3VubG9j
aygmdmNwdS0+a3ZtLT5tbXVfbG9jayk7CiAKLQkJaWYgKGluZGlyZWN0X3NoYWRvd19wYWdlcykK
KwkJaWYgKGluZGlyZWN0X3NoYWRvd19wYWdlcworCQkgICAgJiYgIWt2bWlfdHJhY2tlZF9nZm4o
dmNwdSwgZ3BhX3RvX2dmbihncGEpKSkKIAkJCWt2bV9tbXVfdW5wcm90ZWN0X3BhZ2UodmNwdS0+
a3ZtLCBncGFfdG9fZ2ZuKGdwYSkpOwogCiAJCXJldHVybiB0cnVlOwpAQCAtNjMyMiw3ICs2MzIz
LDggQEAgc3RhdGljIGJvb2wgcmVleGVjdXRlX2luc3RydWN0aW9uKHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwgZ3ZhX3QgY3IyLAogCSAqIGFuZCBpdCBmYWlsZWQgdHJ5IHRvIHVuc2hhZG93IHBhZ2Ug
YW5kIHJlLWVudGVyIHRoZQogCSAqIGd1ZXN0IHRvIGxldCBDUFUgZXhlY3V0ZSB0aGUgaW5zdHJ1
Y3Rpb24uCiAJICovCi0Ja3ZtX21tdV91bnByb3RlY3RfcGFnZSh2Y3B1LT5rdm0sIGdwYV90b19n
Zm4oZ3BhKSk7CisJaWYgKCFrdm1pX3RyYWNrZWRfZ2ZuKHZjcHUsIGdwYV90b19nZm4oZ3BhKSkp
CisJCWt2bV9tbXVfdW5wcm90ZWN0X3BhZ2UodmNwdS0+a3ZtLCBncGFfdG9fZ2ZuKGdwYSkpOwog
CiAJLyoKIAkgKiBJZiB0aGUgYWNjZXNzIGZhdWx0cyBvbiBpdHMgcGFnZSB0YWJsZSwgaXQgY2Fu
IG5vdApAQCAtNjM3NCw2ICs2Mzc2LDkgQEAgc3RhdGljIGJvb2wgcmV0cnlfaW5zdHJ1Y3Rpb24o
c3RydWN0IHg4Nl9lbXVsYXRlX2N0eHQgKmN0eHQsCiAJaWYgKCF2Y3B1LT5hcmNoLm1tdS0+ZGly
ZWN0X21hcCkKIAkJZ3BhID0ga3ZtX21tdV9ndmFfdG9fZ3BhX3dyaXRlKHZjcHUsIGNyMiwgTlVM
TCk7CiAKKwlpZiAoa3ZtaV90cmFja2VkX2dmbih2Y3B1LCBncGFfdG9fZ2ZuKGdwYSkpKQorCQly
ZXR1cm4gZmFsc2U7CisKIAlrdm1fbW11X3VucHJvdGVjdF9wYWdlKHZjcHUtPmt2bSwgZ3BhX3Rv
X2dmbihncGEpKTsKIAogCXJldHVybiB0cnVlOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

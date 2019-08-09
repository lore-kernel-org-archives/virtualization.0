From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 70/92] kvm: x86: filter out access rights only when
	tracked by the introspection tool
Date: Fri,  9 Aug 2019 19:00:25 +0300
Message-ID: <20190809160047.8319-71-alazar@bitdefender.com>
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

SXQgc2hvdWxkIGNvbXBsZXRlIHRoZSBjb21taXQgZmQzNGE5NTE4MTczICgia3ZtOiB4ODY6IGNv
bnN1bHQgdGhlIHBhZ2UgdHJhY2tpbmcgZnJvbSBrdm1fbW11X2dldF9wYWdlKCkgYW5kIF9fZGly
ZWN0X21hcCgpIikKClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRl
ZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9rdm0vbW11LmMgfCAzICsrKwogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9tbXUuYyBiL2Fy
Y2gveDg2L2t2bS9tbXUuYwppbmRleCA2NWI2YWNiYTgyZGEuLmZkNjRjZjExMTVkYSAxMDA2NDQK
LS0tIGEvYXJjaC94ODYva3ZtL21tdS5jCisrKyBiL2FyY2gveDg2L2t2bS9tbXUuYwpAQCAtMjY2
MCw2ICsyNjYwLDkgQEAgc3RhdGljIHZvaWQgY2xlYXJfc3Bfd3JpdGVfZmxvb2RpbmdfY291bnQo
dTY0ICpzcHRlKQogc3RhdGljIHVuc2lnbmVkIGludCBrdm1fbW11X3BhZ2VfdHJhY2tfYWNjKHN0
cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuLAogCQkJCQkgICB1bnNpZ25lZCBpbnQgYWNj
KQogeworCWlmICgha3ZtaV90cmFja2VkX2dmbih2Y3B1LCBnZm4pKQorCQlyZXR1cm4gYWNjOwor
CiAJaWYgKGt2bV9wYWdlX3RyYWNrX2lzX2FjdGl2ZSh2Y3B1LCBnZm4sIEtWTV9QQUdFX1RSQUNL
X1BSRVJFQUQpKQogCQlhY2MgJj0gfkFDQ19VU0VSX01BU0s7CiAJaWYgKGt2bV9wYWdlX3RyYWNr
X2lzX2FjdGl2ZSh2Y3B1LCBnZm4sIEtWTV9QQUdFX1RSQUNLX1BSRVdSSVRFKSB8fApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=

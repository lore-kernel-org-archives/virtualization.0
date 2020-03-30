From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v8 36/81] KVM: x86: intercept the write access on sidt and
 other emulated instructions
Date: Mon, 30 Mar 2020 13:12:23 +0300
Message-ID: <20200330101308.21702-37-alazar@bitdefender.com>
References: <20200330101308.21702-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200330101308.21702-1-alazar@bitdefender.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: kvm@vger.kernel.org
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

VGhpcyBpcyBuZWVkZWQgZm9yIHRoZSBpbnRyb3NwZWN0aW9uIHN1YnN5c3RlbSB0byB0cmFjayB0
aGUgY2hhbmdlcyB0bwpkZXNjcmlwdG9yIHRhYmxlIHJlZ2lzdGVycy4KClNpZ25lZC1vZmYtYnk6
IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRlZmVuZGVyLmNvbT4KLS0tCiBhcmNoL3g4Ni9r
dm0veDg2LmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2t2bS94ODYuYyBiL2FyY2gveDg2L2t2bS94ODYuYwppbmRleCBkMzVj
ZGRhMTE1Y2MuLjJhYWEwZGQ4YjAyYSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL3g4Ni5jCisr
KyBiL2FyY2gveDg2L2t2bS94ODYuYwpAQCAtNTUzOSwxMSArNTUzOSwxNCBAQCBzdGF0aWMgaW50
IGt2bV93cml0ZV9ndWVzdF92aXJ0X2hlbHBlcihndmFfdCBhZGRyLCB2b2lkICp2YWwsIHVuc2ln
bmVkIGludCBieXRlcwogCiAJCWlmIChncGEgPT0gVU5NQVBQRURfR1ZBKQogCQkJcmV0dXJuIFg4
NkVNVUxfUFJPUEFHQVRFX0ZBVUxUOworCQlpZiAoIWt2bV9wYWdlX3RyYWNrX3ByZXdyaXRlKHZj
cHUsIGdwYSwgYWRkciwgZGF0YSwgdG93cml0ZSkpCisJCQlyZXR1cm4gWDg2RU1VTF9SRVRSWV9J
TlNUUjsKIAkJcmV0ID0ga3ZtX3ZjcHVfd3JpdGVfZ3Vlc3QodmNwdSwgZ3BhLCBkYXRhLCB0b3dy
aXRlKTsKIAkJaWYgKHJldCA8IDApIHsKIAkJCXIgPSBYODZFTVVMX0lPX05FRURFRDsKIAkJCWdv
dG8gb3V0OwogCQl9CisJCWt2bV9wYWdlX3RyYWNrX3dyaXRlKHZjcHUsIGdwYSwgYWRkciwgZGF0
YSwgdG93cml0ZSk7CiAKIAkJYnl0ZXMgLT0gdG93cml0ZTsKIAkJZGF0YSArPSB0b3dyaXRlOwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=

From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v8 03/81] KVM: add new error codes for VM introspection
Date: Mon, 30 Mar 2020 13:11:50 +0300
Message-ID: <20200330101308.21702-4-alazar@bitdefender.com>
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

VGhlc2UgbmV3IGVycm9yIGNvZGVzIGNhbiBnaXZlIHRoZSBpbnRyb3NwZWN0aW9uIHRvb2wgbW9y
ZSBpbmZvcm1hdGlvbgphYm91dCB3aHkgYSBpbnRyb3NwZWN0aW9uIGNvbW1hbmQgZmFpbGVkLCBo
ZWxwaW5nIGl0IHRvIGhhbmRsZSBzb21lCmVycm9yIGNhc2VzLgoKU2lnbmVkLW9mZi1ieTogQWRh
bGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGluY2x1ZGUvdWFwaS9s
aW51eC9rdm1fcGFyYS5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9wYXJhLmggYi9pbmNsdWRlL3Vh
cGkvbGludXgva3ZtX3BhcmEuaAppbmRleCA4Yjg2NjA5ODQ5YjkuLjNjZTM4ODI0OTY4MiAxMDA2
NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2t2bV9wYXJhLmgKKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L2t2bV9wYXJhLmgKQEAgLTE3LDYgKzE3LDEwIEBACiAjZGVmaW5lIEtWTV9FMkJJRwkJ
RTJCSUcKICNkZWZpbmUgS1ZNX0VQRVJNCQlFUEVSTQogI2RlZmluZSBLVk1fRU9QTk9UU1VQUAkJ
OTUKKyNkZWZpbmUgS1ZNX0VBR0FJTgkJMTEKKyNkZWZpbmUgS1ZNX0VOT0VOVAkJRU5PRU5UCisj
ZGVmaW5lIEtWTV9FTk9NRU0JCUVOT01FTQorI2RlZmluZSBLVk1fRUJVU1kJCUVCVVNZCiAKICNk
ZWZpbmUgS1ZNX0hDX1ZBUElDX1BPTExfSVJRCQkxCiAjZGVmaW5lIEtWTV9IQ19NTVVfT1AJCQky
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==

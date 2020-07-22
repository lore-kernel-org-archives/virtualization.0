From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 04/34] KVM: x86: mmu: reindent to avoid lines longer
 than 80 chars
Date: Wed, 22 Jul 2020 19:00:51 +0300
Message-ID: <20200722160121.9601-5-alazar@bitdefender.com>
References: <20200722160121.9601-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200722160121.9601-1-alazar@bitdefender.com>
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

U2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgot
LS0KIGFyY2gveDg2L2t2bS9tbXUvbW11LmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11
L21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS9tbXUuYwppbmRleCA5Nzc2NmYzNDkxMGQuLmYzYmE0
ZDA0NTJjOSAxMDA2NDQKLS0tIGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYworKysgYi9hcmNoL3g4
Ni9rdm0vbW11L21tdS5jCkBAIC0yNTczLDYgKzI1NzMsNyBAQCBzdGF0aWMgc3RydWN0IGt2bV9t
bXVfcGFnZSAqa3ZtX21tdV9nZXRfcGFnZShzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsCiAJYm9vbCBm
bHVzaCA9IGZhbHNlOwogCWludCBjb2xsaXNpb25zID0gMDsKIAlMSVNUX0hFQUQoaW52YWxpZF9s
aXN0KTsKKwl1bnNpZ25lZCBpbnQgcGdfaGFzaDsKIAogCXJvbGUgPSB2Y3B1LT5hcmNoLm1tdS0+
bW11X3JvbGUuYmFzZTsKIAlyb2xlLmxldmVsID0gbGV2ZWw7CkBAIC0yNjIzLDggKzI2MjQsOSBA
QCBzdGF0aWMgc3RydWN0IGt2bV9tbXVfcGFnZSAqa3ZtX21tdV9nZXRfcGFnZShzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsCiAKIAlzcC0+Z2ZuID0gZ2ZuOwogCXNwLT5yb2xlID0gcm9sZTsKKwlwZ19o
YXNoID0ga3ZtX3BhZ2VfdGFibGVfaGFzaGZuKGdmbik7CiAJaGxpc3RfYWRkX2hlYWQoJnNwLT5o
YXNoX2xpbmssCi0JCSZ2Y3B1LT5rdm0tPmFyY2gubW11X3BhZ2VfaGFzaFtrdm1fcGFnZV90YWJs
ZV9oYXNoZm4oZ2ZuKV0pOworCQkmdmNwdS0+a3ZtLT5hcmNoLm1tdV9wYWdlX2hhc2hbcGdfaGFz
aF0pOwogCWlmICghZGlyZWN0KSB7CiAJCS8qCiAJCSAqIHdlIHNob3VsZCBkbyB3cml0ZSBwcm90
ZWN0aW9uIGJlZm9yZSBzeW5jaW5nIHBhZ2VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

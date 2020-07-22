From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 30/34] KVM: vmx: make use of EPTP_INDEX in
 vmx_set_ept_view()
Date: Wed, 22 Jul 2020 19:01:17 +0300
Message-ID: <20200722160121.9601-31-alazar@bitdefender.com>
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogyJh0ZWZhbiDImGljbGVydSA8c3NpY2xlcnVAYml0ZGVmZW5kZXIuY29tPgoKU2lnbmVk
LW9mZi1ieTogyJh0ZWZhbiDImGljbGVydSA8c3NpY2xlcnVAYml0ZGVmZW5kZXIuY29tPgpTaWdu
ZWQtb2ZmLWJ5OiBBZGFsYmVydCBMYXrEg3IgPGFsYXphckBiaXRkZWZlbmRlci5jb20+Ci0tLQog
YXJjaC94ODYva3ZtL3ZteC92bXguYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMgYi9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jCmluZGV4IDAzNWY2YzQzYTJhNC4uNzM2YjZjYzZjYThmIDEwMDY0NAot
LS0gYS9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jCisrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMK
QEAgLTQ0MDgsNiArNDQwOCwxMyBAQCBzdGF0aWMgaW50IHZteF9zZXRfZXB0X3ZpZXcoc3RydWN0
IGt2bV92Y3B1ICp2Y3B1LCB1MTYgdmlldykKIAkJa3ZtX21tdV91bmxvYWQodmNwdSk7CiAJCXIg
PSBrdm1fbW11X3JlbG9hZCh2Y3B1KTsKIAkJV0FSTl9PTl9PTkNFKHIpOworCisJCS8qIFdoZW4g
I1ZFIGhhcHBlbnMsIGN1cnJlbnQgRVBUIGluZGV4IHdpbGwgYmUgc2F2ZWQKKwkJICogYnkgdGhl
IGxvZ2ljYWwgcHJvY2Vzc29yIGludG8gVkUgaW5mb3JtYXRpb24gYXJlYSwKKwkJICogc2VlIGNo
YXB0ZXIgMjQuNi4xOCBhbmQgMjUuNS42LjIgZnJvbSBJbnRlbCBTRE0uCisJCSAqLworCQlpZiAo
a3ZtX3ZlX3N1cHBvcnRlZCkKKwkJCXZtY3Nfd3JpdGUxNihFUFRQX0lOREVYLCB2aWV3KTsKIAl9
CiAKIAlyZXR1cm4gMDsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

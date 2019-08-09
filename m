From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v6 86/92] kvm: x86: emulate xorpd xmm2/m128, xmm1
Date: Fri,  9 Aug 2019 19:00:41 +0300
Message-ID: <20190809160047.8319-87-alazar@bitdefender.com>
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
cHBvcnQgZm9yIHhvcnBkIHhtbTIvbTEyOCwgeG1tMS4KClNpZ25lZC1vZmYtYnk6IE1paGFpIERv
bsibdSA8bWRvbnR1QGJpdGRlZmVuZGVyLmNvbT4KU2lnbmVkLW9mZi1ieTogQWRhbGJlcnQgTGF6
xINyIDxhbGF6YXJAYml0ZGVmZW5kZXIuY29tPgotLS0KIGFyY2gveDg2L2t2bS9lbXVsYXRlLmMg
fCAxOSArKysrKysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9lbXVsYXRlLmMgYi9h
cmNoL3g4Ni9rdm0vZW11bGF0ZS5jCmluZGV4IDI4N2QzNzUxNjc1ZC4uMjhhYWM1NTJiMzRiIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rdm0vZW11bGF0ZS5jCisrKyBiL2FyY2gveDg2L2t2bS9lbXVs
YXRlLmMKQEAgLTExNzgsNiArMTE3OCwyMiBAQCBzdGF0aWMgaW50IGVtX2Zuc3RzdyhzdHJ1Y3Qg
eDg2X2VtdWxhdGVfY3R4dCAqY3R4dCkKIAlyZXR1cm4gWDg2RU1VTF9DT05USU5VRTsKIH0KIAor
c3RhdGljIGludCBlbV94b3JwZChzdHJ1Y3QgeDg2X2VtdWxhdGVfY3R4dCAqY3R4dCkKK3sKKwlj
b25zdCBzc2UxMjhfdCAqc3JjID0gJmN0eHQtPnNyYy52ZWNfdmFsOworCXNzZTEyOF90ICpkc3Qg
PSAmY3R4dC0+ZHN0LnZlY192YWw7CisJc3NlMTI4X3QgeG1tMDsKKworCWFzbSB2b2xhdGlsZSgi
bW92ZHF1ICUleG1tMCwgJTBcbiIKKwkJICAgICAibW92ZHF1ICUxLCAlJXhtbTBcbiIKKwkJICAg
ICAieG9ycGQgJTIsICUleG1tMFxuIgorCQkgICAgICJtb3ZkcXUgJSV4bW0wLCAlMVxuIgorCQkg
ICAgICJtb3ZkcXUgJTAsICUleG1tMCIKKwkJICAgICA6ICIrbSIoeG1tMCksICIrbSIoKmRzdCkg
OiAibSIoKnNyYykpOworCisJcmV0dXJuIFg4NkVNVUxfQ09OVElOVUU7Cit9CisKIHN0YXRpYyB1
OCBzaW1kX3ByZWZpeF90b19ieXRlcyhjb25zdCBzdHJ1Y3QgeDg2X2VtdWxhdGVfY3R4dCAqY3R4
dCwKIAkJCSAgICAgICBpbnQgc2ltZF9wcmVmaXgpCiB7CkBAIC00ODMxLDcgKzQ4NDcsOCBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG9wY29kZSB0d29ieXRlX3RhYmxlWzI1Nl0gPSB7CiAJLyogMHg0
MCAtIDB4NEYgKi8KIAlYMTYoRChEc3RSZWcgfCBTcmNNZW0gfCBNb2RSTSkpLAogCS8qIDB4NTAg
LSAweDVGICovCi0JTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwg
TiwKKwlOLCBOLCBOLCBOLCBOLCBOLCBOLCBJKFNyY01lbSB8IERzdFJlZyB8IE1vZFJNIHwgVW5h
bGlnbmVkIHwgU3NlLCBlbV94b3JwZCksCisJTiwgTiwgTiwgTiwgTiwgTiwgTiwgTiwKIAkvKiAw
eDYwIC0gMHg2RiAqLwogCU4sIE4sIE4sIE4sCiAJTiwgTiwgTiwgTiwKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

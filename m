From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [PATCH v8 02/81] export kill_pid_info()
Date: Mon, 30 Mar 2020 13:11:49 +0300
Message-ID: <20200330101308.21702-3-alazar@bitdefender.com>
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
Cc: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>, Paolo Bonzini <pbonzini@redhat.com>, Mathieu Tarral <mathieu.tarral@protonmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogTWF0aGlldSBUYXJyYWwgPG1hdGhpZXUudGFycmFsQHByb3Rvbm1haWwuY29tPgoKVGhp
cyBmdW5jdGlvbiBpcyB1c2VkIGJ5IEtWTUkgKEtWTSBpbnRyb3NwZWN0aW9uIHN1Yi1zeXN0ZW0p
IHRvCnVuZ3JhY2VmdWxseSBzaHV0ZG93biB0aGUgZ3Vlc3Qgd2hlbiBhbiBpbnRyb3NwZWN0aW9u
IHRvb2wgcmVxdWVzdHMgaXQuCgpBIHNlY3VyaXR5IGFwcGxpY2F0aW9uIHdpbGwgdXNlIGl0IGFz
IGEgbGFzdCByZXNvcnQgaW4gc3RvcHBpbmcgdGhlCnNwcmVhZCBvZiBhIG1hbHdhcmUgZnJvbSBh
IGd1ZXN0CgpTaWduZWQtb2ZmLWJ5OiBNYXRoaWV1IFRhcnJhbCA8bWF0aGlldS50YXJyYWxAcHJv
dG9ubWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEFkYWxiZXJ0IExhesSDciA8YWxhemFyQGJpdGRl
ZmVuZGVyLmNvbT4KLS0tCiBrZXJuZWwvc2lnbmFsLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2tlcm5lbC9zaWduYWwuYyBiL2tlcm5lbC9zaWdu
YWwuYwppbmRleCA5YWQ4ZGVhOTNkYmIuLmFlNjJkMTE1NWJhOCAxMDA2NDQKLS0tIGEva2VybmVs
L3NpZ25hbC5jCisrKyBiL2tlcm5lbC9zaWduYWwuYwpAQCAtMTQ1MSw2ICsxNDUxLDcgQEAgaW50
IGtpbGxfcGlkX2luZm8oaW50IHNpZywgc3RydWN0IGtlcm5lbF9zaWdpbmZvICppbmZvLCBzdHJ1
Y3QgcGlkICpwaWQpCiAJCSAqLwogCX0KIH0KK0VYUE9SVF9TWU1CT0woa2lsbF9waWRfaW5mbyk7
CiAKIHN0YXRpYyBpbnQga2lsbF9wcm9jX2luZm8oaW50IHNpZywgc3RydWN0IGtlcm5lbF9zaWdp
bmZvICppbmZvLCBwaWRfdCBwaWQpCiB7Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

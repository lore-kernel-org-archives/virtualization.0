From: =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur@brendeland.net>
Subject: [PATCHv8 0/3]virtio_console: Add rproc_serial driver
Date: Tue, 30 Oct 2012 09:51:50 +0100
Message-ID: <1351587113-2566-1-git-send-email-sjur@brendeland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Amit Shah <amit.shah@redhat.com>, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgoK
VGhpcyBwYXRjaC1zZXQgaW50cm9kdWNlcyBhIG5ldyB2aXJ0aW8gdHlwZSAicnByb2Nfc2VyaWFs
IiBmb3IgY29tbXVuaWNhdGluZwp3aXRoIHJlbW90ZSBwcm9jZXNzb3JzIG92ZXIgc2hhcmVkIG1l
bW9yeS4gVGhlIGRyaXZlciBkZXBlbmRzIG9uIHRoZQp0aGUgcmVtb3RlcHJvYyBmcmFtZXdvcmsu
IEFzIHByZXBhcmF0aW9uIGZvciBpbnRyb2R1Y2luZyAicnByb2Nfc2VyaWFsIgpJJ3ZlIGRvbmUg
YSByZWZhY3RvcmluZyBvZiB0aGUgdHJhbnNtaXQgYnVmZmVyIGhhbmRsaW5nLgoKQ2hhbmdlcyBz
aW5jZSB2NzoKLSBSZWJhc2VkIHRvIHZpcnRpby1uZXh0IGJyYW5jaC4KLSBSZW1vdmVkIGV4dHJh
IGFkZGVkIGxpbmVzLgotIFJlbW92ZWQgc3VwZXJmbHVvdXMgY2hlY2tzIGJlZm9yZSBjYWxsaW5n
IHJlY2xhaW1fZG1hX2J1ZnMoKS4KLSBSdXN0eSByYWlzZWQgc29tZSBxdWVzdGlvbiByZWdhcmRp
bmcgZ2FyYmFnZSBjb2xsZWN0aW9uIG9mIHRoZQogIG91dC12cSwgc28gSSBtb3ZlZCB0aGlzIGlu
dG8gYSBzZXBhcmF0ZSBwYXRjaC4KClRoYW5rcywKU2p1cgoKClNqdXIgQnLDpm5kZWxhbmQgKDMp
OgogIHZpcnRpb19jb25zb2xlOiBNZXJnZSBzdHJ1Y3QgYnVmZmVyX3Rva2VuIGludG8gc3RydWN0
IHBvcnRfYnVmZmVyCiAgdmlydGlvX2NvbnNvbGU6IEFkZCBzdXBwb3J0IGZvciByZW1vdGVwcm9j
IHNlcmlhbAogIHZpcnRpb19jb25zb2xlOiBSZW1vdmUgYnVmZmVycyBmcm9tIG91dF92cSBhdCBw
b3J0IHJlbW92YWwKCiBkcml2ZXJzL2NoYXIvdmlydGlvX2NvbnNvbGUuYyAgIHwgIDMyNSArKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIGluY2x1ZGUvdWFwaS9saW51eC92
aXJ0aW9faWRzLmggfCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgMjMwIGluc2VydGlvbnMoKyks
IDk2IGRlbGV0aW9ucygtKQoKLS0gCjEuNy45LjUKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

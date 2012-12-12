From: =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
Subject: [PATCHv9 0/2] virtio_console: Add rproc_serial driver
Date: Wed, 12 Dec 2012 13:38:19 +0100
Message-ID: <1355315901-3085-1-git-send-email-sjur.brandeland@stericsson.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, Amit Shah <amit.shah@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, masami.hiramatsu.pt@hitachi.com, =?UTF-8?q?Sjur=20Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

VGhpcyBwYXRjaC1zZXQgaW50cm9kdWNlcyBhIG5ldyB2aXJ0aW8gdHlwZSAicnByb2Nfc2VyaWFs
IiBmb3IgY29tbXVuaWNhdGluZwp3aXRoIHJlbW90ZSBwcm9jZXNzb3JzIG92ZXIgc2hhcmVkIG1l
bW9yeS4gVGhlIGRyaXZlciBkZXBlbmRzIG9uIHRoZQp0aGUgcmVtb3RlcHJvYyBmcmFtZXdvcmsu
IEFzIHByZXBhcmF0aW9uIGZvciBpbnRyb2R1Y2luZyAicnByb2Nfc2VyaWFsIgpJJ3ZlIGRvbmUg
YSByZWZhY3RvcmluZyBvZiB0aGUgdHJhbnNtaXQgYnVmZmVyIGhhbmRsaW5nLgoKTk9URTogVGhl
c2UgdHdvIHBhdGNoZXMgYXJlIGlkZW50aWNhbCB0byBmaXJzdCB0d28gcGF0Y2hlcyBvZiB0aGUg
VjggcGF0Y2gtc2V0LApidXQgYXJlIHJlYmFzZWQgdG8gdmlydGlvLW5leHQuCgpSZWdhcmRzLApT
anVyCgpTanVyIEJyw6ZuZGVsYW5kICgyKToKICB2aXJ0aW9fY29uc29sZTogTWVyZ2Ugc3RydWN0
IGJ1ZmZlcl90b2tlbiBpbnRvIHN0cnVjdCBwb3J0X2J1ZmZlcgogIHZpcnRpb19jb25zb2xlOiBB
ZGQgc3VwcG9ydCBmb3IgcmVtb3RlcHJvYyBzZXJpYWwKCiBkcml2ZXJzL2NoYXIvdmlydGlvX2Nv
bnNvbGUuYyAgIHwgIDMxNyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0K
IGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9faWRzLmggfCAgICAxICsKIDIgZmlsZXMgY2hhbmdl
ZCwgMjIxIGluc2VydGlvbnMoKyksIDk3IGRlbGV0aW9ucygtKQoKLS0gCjEuNy41LjQKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==

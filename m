From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv8 0/3]virtio_console: Add rproc_serial driver
Date: Mon, 05 Nov 2012 09:11:45 +1030
Message-ID: <877gq1yora.fsf@rustcorp.com.au>
References: <1351587113-2566-1-git-send-email-sjur@brendeland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1351587113-2566-1-git-send-email-sjur@brendeland.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur@brendeland.net>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Amit Shah <amit.shah@redhat.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

U2p1ciBCcsOmbmRlbGFuZCA8c2p1ckBicmVuZGVsYW5kLm5ldD4gd3JpdGVzOgoKPiBGcm9tOiBT
anVyIEJyw6ZuZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBUaGlz
IHBhdGNoLXNldCBpbnRyb2R1Y2VzIGEgbmV3IHZpcnRpbyB0eXBlICJycHJvY19zZXJpYWwiIGZv
ciBjb21tdW5pY2F0aW5nCj4gd2l0aCByZW1vdGUgcHJvY2Vzc29ycyBvdmVyIHNoYXJlZCBtZW1v
cnkuIFRoZSBkcml2ZXIgZGVwZW5kcyBvbiB0aGUKPiB0aGUgcmVtb3RlcHJvYyBmcmFtZXdvcmsu
IEFzIHByZXBhcmF0aW9uIGZvciBpbnRyb2R1Y2luZyAicnByb2Nfc2VyaWFsIgo+IEkndmUgZG9u
ZSBhIHJlZmFjdG9yaW5nIG9mIHRoZSB0cmFuc21pdCBidWZmZXIgaGFuZGxpbmcuCj4KPiBDaGFu
Z2VzIHNpbmNlIHY3Ogo+IC0gUmViYXNlZCB0byB2aXJ0aW8tbmV4dCBicmFuY2guCj4gLSBSZW1v
dmVkIGV4dHJhIGFkZGVkIGxpbmVzLgo+IC0gUmVtb3ZlZCBzdXBlcmZsdW91cyBjaGVja3MgYmVm
b3JlIGNhbGxpbmcgcmVjbGFpbV9kbWFfYnVmcygpLgo+IC0gUnVzdHkgcmFpc2VkIHNvbWUgcXVl
c3Rpb24gcmVnYXJkaW5nIGdhcmJhZ2UgY29sbGVjdGlvbiBvZiB0aGUKPiAgIG91dC12cSwgc28g
SSBtb3ZlZCB0aGlzIGludG8gYSBzZXBhcmF0ZSBwYXRjaC4KCk9LLCBJJ20gbm90IHN1cmUgdGhh
dCBXQVJOX09OIHdvbid0IGZpcmUsIGJ1dCB0aGF0J3Mgbm90IGFsbCB0aGF0Cmhhcm1mdWwuCgpB
cHBsaWVkLApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: Don't access uninitialized data.
Date: Tue, 22 Jan 2013 09:50:44 +1030
Message-ID: <87y5fmw2b7.fsf@rustcorp.com.au>
References: <1358425292-4449-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358425292-4449-1-git-send-email-sjur.brandeland@stericsson.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKPiBGcm9tOiBTanVyIEJyw6Zu
ZGVsYW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBEb24ndCBhY2Nlc3Mg
dW5pbml0aWFsaXplZCB3b3JrLXF1ZXVlIHdoZW4gcmVtb3ZpbmcgZGV2aWNlLgo+IFRoZSB3b3Jr
IHF1ZXVlIGlzIGluaXRpYWxpemVkIG9ubHkgaWYgdGhlIGRldmljZSBtdWx0aS1xdWV1ZS4KPiBT
byBkb24ndCBjYWxsIGNhbmNlbF93b3JrIHVubGVzcyB0aGlzIGlzIGEgbXVsdGktcXVldWUgZGV2
aWNlLgo+Cj4gVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIHBhbmljOgoKVGhhbmtzLCBhcHBsaWVk
LgoKQ2hlZXJzLApSdXN0eS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

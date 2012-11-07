From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH resend] virtio_console: Free buffers from out-queue upon
	close
Date: Thu, 08 Nov 2012 10:28:53 +1030
Message-ID: <87sj8l2cea.fsf__40485.9827169732$1352332909$gmane$org@rustcorp.com.au>
References: <1350287856-5284-1-git-send-email-sjur.brandeland@stericsson.com>
	<1350287856-5284-5-git-send-email-sjur.brandeland@stericsson.com>
	<878vayhsca.fsf@rustcorp.com.au>
	<20121101073951.GA17012@amit.redhat.com>
	<87r4oc52ov.fsf@rustcorp.com.au>
	<20121102102047.GE10483@amit.redhat.com>
	<81C3A93C17462B4BBD7E272753C1057923BE98E5C6@EXDCVYMBSTM005.EQ1STM.local>
	<1352298171-21869-1-git-send-email-sjur.brandeland@stericsson.com>
	<1352295822-22906-1-git-send-email-sjur.brandeland@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1352295822-22906-1-git-send-email-sjur.brandeland@stericsson.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, sjur@brendeland.net, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Sjur =?utf-8?Q?Br=C3=A6ndeland?= <sjur.brandeland@stericsson.com>
List-Id: virtualization@lists.linuxfoundation.org

c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tIHdyaXRlczoKCj4gRnJvbTogU2p1ciBCcsOm
bmRlbGFuZCA8c2p1ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+Cj4gRnJlZSBwZW5kaW5n
IG91dHB1dCBidWZmZXJzIGZyb20gdGhlIHZpcnRpbyBvdXQtcXVldWUgd2hlbgo+IGhvc3QgaGFz
IGFja25vd2xlZGdlZCBwb3J0X2Nsb3NlLiBBbHNvIHJlbW92ZWQgV0FSTl9PTigpCj4gaW4gcmVt
b3ZlX3BvcnRfZGF0YSgpLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2p1ciBCcsOmbmRlbGFuZCA8c2p1
ci5icmFuZGVsYW5kQHN0ZXJpY3Nzb24uY29tPgo+IC0tLQo+Cj4gUmVzZW5kaW5nLCB0aGlzIHRp
bWUgaW5jbHVkaW5nIGEgcHJvcGVyICJTdWJqZWN0Ii4uLgo+IC0tCj4KPiBIaSBBbWl0LAo+Cj4g
Tm90ZTogVGhpcyBwYXRjaCBpcyBjb21waWxlIHRlc3RlZCBvbmx5LiBJIGhhdmUgZG9uZSB0aGUg
cmVtb3ZhbAo+IG9mIGJ1ZmZlcnMgZnJvbSBvdXQtcXVldWUgaW4gaGFuZGxlX2NvbnRyb2xfbWVz
c2FnZSgpCj4gd2hlbiBob3N0IGhhcyBhY2tlZCB0aGUgY2xvc2UgcmVxdWVzdC4gVGhpcyBzZWVt
cyBsZXNzCj4gcmFjeSB0aGFuIGRvaW5nIGl0IGluIHRoZSByZWxlYXNlIGZ1bmN0aW9uLgoKVGhp
cyBjb25mdXNlcyBtZS4uLiB3aHkgYXJlIHdlIGRvaW5nIHRoaXMgaW4gY2FzZQpWSVJUSU9fQ09O
U09MRV9QT1JUX09QRU46PwoKV2UgY2FuJ3QgcHVsbCB1bmNvbnN1bWVkIGJ1ZmZlcnMgb3V0IG9m
IHRoZSByaW5nIHdoZW4gdGhlIG90aGVyIHNpZGUgbWF5CnN0aWxsIGFjY2VzcyBpdCwgYW5kIHRo
aXMgc2VlbXMgdG8gYmUgZG9pbmcgdGhhdC4KClRoYW5rcywKUnVzdHkuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

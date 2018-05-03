From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC V3 PATCH 1/8] vhost: move get_rx_bufs to vhost.c
Date: Thu, 3 May 2018 15:19:12 +0800
Message-ID: <19846c31-45b2-6809-6e7b-6b738cd7d2ca__14703.1331355267$1525331862$gmane$org@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
	<1524461700-5469-2-git-send-email-jasowang@redhat.com>
	<20180502080518.h52wme46fnqpyfpf@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180502080518.h52wme46fnqpyfpf@debian>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDXmnIgwMuaXpSAxNjowNSwgVGl3ZWkgQmllIHdyb3RlOgo+IE9uIE1vbiwg
QXByIDIzLCAyMDE4IGF0IDAxOjM0OjUzUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE1v
dmUgZ2V0X3J4X2J1ZnMoKSB0byB2aG9zdC5jIGFuZCByZW5hbWUgaXQgdG8KPj4gdmhvc3RfZ2V0
X3J4X2J1ZnMoKS4gVGhpcyBoZWxwcyB0byBoaWRlIHZyaW5nIGludGVybmFsIGxheW91dCBmcm9t
Cj4gQSBzbWFsbCB0eXBvLiBCYXNlZCBvbiB0aGUgY29kZSBjaGFuZ2UgaW4gdGhpcyBwYXRjaCwg
aXQKPiBzZWVtcyB0aGF0IHRoaXMgZnVuY3Rpb24gaXMgcmVuYW1lZCB0byB2aG9zdF9nZXRfYnVm
cygpLgo+Cj4gVGhhbmtzCj4KClJpZ2h0LCBsZXQgbWUgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNp
b24uCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==

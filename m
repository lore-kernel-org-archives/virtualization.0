From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: Use virtio device index to generate port
	name
Date: Tue, 12 Feb 2013 16:26:03 +1030
Message-ID: <87halif53g.fsf@rustcorp.com.au>
References: <1358425397-4584-1-git-send-email-sjur.brandeland@stericsson.com>
	<20130211155541.GC8319@amit.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130211155541.GC8319@amit.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, sjur.brandeland@stericsson.com
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

QW1pdCBTaGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4gd3JpdGVzOgoKPiBPbiAoVGh1KSAxNyBK
YW4gMjAxMyBbMTM6MjM6MTddLCBzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20gd3JvdGU6
Cj4+IEZyb206IFNqdXIgQnLDpm5kZWxhbmQgPHNqdXIuYnJhbmRlbGFuZEBzdGVyaWNzc29uLmNv
bT4KPj4gCj4+IFVzZSB2aXJ0aW8gZGV2aWNlIGluZGV4IGZvciBjcmVhdGluZyB1bmlxdWUgZGV2
aWNlIHBvcnQgbmFtZXMuCj4+IEN1cnJlbnQgaW5kZXggYWxsb2NhdGlvbiBpbiB2aXJ0aW8gaXMg
YmFzZWQgb24gYSBtb25vdG9uaWNhbGx5Cj4+IGluY3JlYXNpbmcgdmFyaWFibGUgImluZGV4Ii4g
QSBiZXR0ZXIgaGFuZGxpbmcgb2YgdGhpcyBpcyB0bwo+PiB1c2UgZGV2aWNlIGluZGV4IHdoaWNo
IGlzIGFsbG9jYXRlZCBieSBpZGEuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBTanVyIEJyw6ZuZGVs
YW5kIDxzanVyLmJyYW5kZWxhbmRAc3Rlcmljc3Nvbi5jb20+Cj4KPiBBY2tlZC1ieTogQW1pdCBT
aGFoIDxhbWl0LnNoYWhAcmVkaGF0LmNvbT4KPgo+IFJ1c3R5LCBwbGVhc2UgcGljayB0aGlzIG9u
ZSB1cC4KCkluIG15IHZpcnRpby1uZXh0IHF1ZXVlIG5vdy4uLgoKVGhhbmtzLApSdXN0eS4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u

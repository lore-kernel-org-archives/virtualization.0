From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC V3 PATCH 0/8] Packed ring for vhost
Date: Tue, 24 Apr 2018 09:04:01 +0800
Message-ID: <803cf7fa-6c74-0506-d609-8f0b79b2c254@redhat.com>
References: <1524461700-5469-1-git-send-email-jasowang@redhat.com>
	<20180423193120.GD30033@char.us.oracle.com>
	<20180423224715-mutt-send-email-mst@kernel.org>
	<20180423201151.GD5215@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180423201151.GD5215@char.us.oracle.com>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE45bm0MDTmnIgyNOaXpSAwNDoxMSwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3Rl
Ogo+IE9uIE1vbiwgQXByIDIzLCAyMDE4IGF0IDEwOjU5OjQzUE0gKzAzMDAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPj4gT24gTW9uLCBBcHIgMjMsIDIwMTggYXQgMDM6MzE6MjBQTSAtMDQw
MCwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrIHdyb3RlOgo+Pj4gT24gTW9uLCBBcHIgMjMsIDIwMTgg
YXQgMDE6MzQ6NTJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+PiBIaSBhbGw6Cj4+Pj4K
Pj4+PiBUaGlzIFJGQyBpbXBsZW1lbnQgcGFja2VkIHJpbmcgbGF5b3V0LiBUaGUgY29kZSB3ZXJl
IHRlc3RlZCB3aXRoCj4+Pj4gVGl3ZWkncyBSRkMgVjIgYSB0aHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMTgvNC8xLzQ4LiBTb21lIGZpeHVwcyBhbmQKPj4+PiB0d2Vha3Mgd2VyZSBuZWVkZWQgb24g
dG9wIG9mIFRpd2VpJ3MgY29kZSB0byBtYWtlIGl0IHJ1bi4gVENQIHN0cmVhbQo+Pj4+IGFuZCBw
a3RnZW4gZG9lcyBub3Qgc2hvdyBvYnZpb3VzIGRpZmZlcmVuY2UgY29tcGFyZWQgd2l0aCBzcGxp
dCByaW5nLgo+Pj4gSSBoYXZlIHRvIGFzayB0aGVuIC0gd2hhdCBpcyB0aGUgYmVuZWZpdCBvZiB0
aGlzPwo+PiBZb3UgY2FuIHVzZSB0aGlzIHdpdGggZHBkayB3aXRoaW4gZ3Vlc3QuCj4+IFRoZSBE
UERLIHZlcnNpb24gZGlkIHNlZSBhIHBlcmZvcm1hbmNlIGltcHJvdmVtZW50IHNvIGhvcGVmdWxs
eSB3aXRoCj4gSXMgdGhlcmUgYSBsaW5rIHRvIHRoaXMgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQg
ZG9jdW1lbnQ/Cj4KCllvdSBwcm9iYWJseSB3YW50IHRvIHRoaXM6CgpodHRwczovL3d3dy5tYWls
LWFyY2hpdmUuY29tL2RldkBkcGRrLm9yZy9tc2c5NzczNS5odG1sCgpUaGFua3MKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u

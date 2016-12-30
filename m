From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next V2 3/3] tun: rx batching
Date: Fri, 30 Dec 2016 13:14:33 +0800
Message-ID: <d7d1378d-2051-d962-8001-d63085c3e1bc__15894.840428564$1483074893$gmane$org@redhat.com>
References: <1482912571-3157-1-git-send-email-jasowang@redhat.com>
	<1482912571-3157-4-git-send-email-jasowang@redhat.com>
	<20161229.113506.1833529555874695164.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161229.113506.1833529555874695164.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAyMDE25bm0MTLmnIgzMOaXpSAwMDozNSwgRGF2aWQgTWlsbGVyIHdyb3RlOgo+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gRGF0ZTogV2VkLCAyOCBEZWMgMjAx
NiAxNjowOTozMSArMDgwMAo+Cj4+ICsJc3Bpbl9sb2NrKCZxdWV1ZS0+bG9jayk7Cj4+ICsJcWxl
biA9IHNrYl9xdWV1ZV9sZW4ocXVldWUpOwo+PiArCWlmIChxbGVuID4gcnhfYmF0Y2hlZCkKPj4g
KwkJZ290byBkcm9wOwo+PiArCV9fc2tiX3F1ZXVlX3RhaWwocXVldWUsIHNrYik7Cj4+ICsJaWYg
KCFtb3JlIHx8IHFsZW4gKyAxID4gcnhfYmF0Y2hlZCkgewo+PiArCQlfX3NrYl9xdWV1ZV9oZWFk
X2luaXQoJnByb2Nlc3NfcXVldWUpOwo+PiArCQlza2JfcXVldWVfc3BsaWNlX3RhaWxfaW5pdChx
dWV1ZSwgJnByb2Nlc3NfcXVldWUpOwo+PiArCQlyY3YgPSB0cnVlOwo+PiArCX0KPj4gKwlzcGlu
X3VubG9jaygmcXVldWUtPmxvY2spOwo+IFNpbmNlIHlvdSBhbHdheXMgY2xlYXIgdGhlICdxdWV1
ZScgd2hlbiB5b3UgaW5zZXJ0IHRoZSBza2IgdGhhdCBoaXRzCj4gdGhlIGxpbWl0LCBJIGRvbid0
IHNlZSBob3cgdGhlICJnb3RvIGRyb3AiIHBhdGggY2FuIGJlIHBvc3NpYmx5IHRha2VuLgoKVHJ1
ZSwgd2lsbCBmaXggdGhpcy4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=

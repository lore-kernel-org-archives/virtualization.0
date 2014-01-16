From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v4 1/6] net: allow > 0 order atomic page alloc
	in skb_page_frag_refill
Date: Thu, 16 Jan 2014 15:30:20 -0800 (PST)
Message-ID: <20140116.153020.587523865163482894.davem__24013.6842163794$1389915034$gmane$org@davemloft.net>
References: <1389901950-3854-1-git-send-email-mwdalton@google.com>
	<20140116.152800.901405996505782677.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140116.152800.901405996505782677.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mwdalton@google.com
Cc: mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com, bhutchings@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

RnJvbTogRGF2aWQgTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KRGF0ZTogVGh1LCAxNiBK
YW4gMjAxNCAxNToyODowMCAtMDgwMCAoUFNUKQ0KDQo+IEFsbCA2IHBhdGNoZXMgYXBwbGllZC4N
Cg0KQWN0dWFsbHksIEkgcmV2ZXJ0ZWQsIHBsZWFzZSByZXN1Ym1pdCB0aGlzIHNlcmllcyB3aXRo
IHRoZSBmb2xsb3dpbmcNCmJ1aWxkIHdhcm5pbmcgY29ycmVjdGVkOg0KDQpuZXQvY29yZS9uZXQt
c3lzZnMuYzogSW4gZnVuY3Rpb24goXJ4X3F1ZXVlX2FkZF9rb2JqZWN0ojoNCm5ldC9jb3JlL25l
dC1zeXNmcy5jOjc2NzoyMTogd2FybmluZzogaWdub3JpbmcgcmV0dXJuIHZhbHVlIG9mIKFzeXNm
c19jcmVhdGVfZ3JvdXCiLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3YXJuX3VudXNlZF9yZXN1
bHQgWy1XdW51c2VkLXJlc3VsdF0NCg0KVGhhbmtzLg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

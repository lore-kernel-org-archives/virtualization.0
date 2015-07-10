From: Gioh Kim <gioh.kim@lge.com>
Subject: Re: [RFCv3 0/5] enable migration of driver pages
Date: Fri, 10 Jul 2015 09:02:12 +0900
Message-ID: <559F0B84.6020908__3098.77888435057$1436486553$gmane$org@lge.com>
References: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>
	<20150707153701.bfcde75108d1fb8aaedc8134@linux-foundation.org>
	<559C68B3.3010105@lge.com>
	<20150707170746.1b91ba0d07382cbc9ba3db92@linux-foundation.org>
	<559C6CA6.1050809@lge.com>
	<CAPM=9txmUJ58=CAxDhf12Y3Y8wz7CGBy-Bd4pQ8YAAKDsCxU8w@mail.gmail.com>
	<559DB86D.40000@lge.com>
	<20150709130848.GD21858@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150709130848.GD21858@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>, Andrew Morton <akpm@linux-foundation.org>, jlayton@poochiereds.net, bfields@fieldses.org, vbabka@suse.cz, iamjoonsoo.kim@lge.com, Al Viro <viro@zeniv.linux.org.uk>, "Michael S. Tsirkin" <mst@redhat.com>, koct9i@gmail.com, minchan@kernel.org, aquini@redhat.com, linux-fsdevel@vger.kernel.org, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, open@kvack.org, "list@kvack.org: ABI/API" <linux-api@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, gunho.lee@lge.com, Gioh Kim <gurugio@hanmail.net>
List-Id: virtualization@lists.linuxfoundation.org

CgoyMDE1LTA3LTA5IOyYpO2bhCAxMDowOOyXkCBEYW5pZWwgVmV0dGVyIOydtCjqsIApIOyTtCDq
uIA6Cj4gQWxzbyB0aGVyZSdzIGEgYml0IGEgbGFjayBvZiBncHUgZHJpdmVycyBmcm9tIHRoZSBh
cm0gd29ybGQgaW4gdXBzdHJlYW0sCj4gd2hpY2ggaXMgcHJvYmFieWwgd2h5IHRoaXMgcGF0Y2gg
c2VyaWVzIGRvZXNuJ3QgY29tZSB3aXRoIGEgdXNlci4gTWlnaHQgYmUKPiBiZXR0ZXIgdG8gZmly
c3QgdXBzdHJlYW0gdGhlIGRyaXZlciBiZWZvcmUgdGFsa2luZyBhYm91dCBhZGRpdGlvbmFsCj4g
aW5mcmFzdHJ1Y3R1cmUgdGhhdCBpdCBuZWVkcy4KPiAtRGFuaWVsCgpJJ20gbm90IGZyb20gQVJN
IGJ1dCBJIGp1c3QgZ290IHRoZSBpZGVhIG9mIGRyaXZlciBwYWdlIG1pZ3JhdGlvbgpkdXJpbmcg
SSB3b3JrZWQgd2l0aCBBUk0gZ3B1IGRyaXZlci4KSSdtIHN1cmUgdGhpcyBwYXRjaCBpcyBnb29k
IGZvciB6cmFtIGFuZCBiYWxsb29uCmFuZCBob3BlIGl0IGNhbiBiZSBhcHBsaWVkIHRvIGRyaXZl
cnMgY29uc3VtaW5nIG1hbnkgcGFnZXMgYW5kIGdlbmVyYXRpbmcgZnJhZ21lbnRhdGlvbiwKc3Vj
aCBhcyBHUFUgb3IgZ2Z4IGRyaXZlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

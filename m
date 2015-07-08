From: Gioh Kim <gioh.kim@lge.com>
Subject: Re: [RFCv3 0/5] enable migration of driver pages
Date: Thu, 09 Jul 2015 08:55:25 +0900
Message-ID: <559DB86D.40000__14641.834193799$1436399745$gmane$org@lge.com>
References: <1436243785-24105-1-git-send-email-gioh.kim@lge.com>	<20150707153701.bfcde75108d1fb8aaedc8134@linux-foundation.org>	<559C68B3.3010105@lge.com>	<20150707170746.1b91ba0d07382cbc9ba3db92@linux-foundation.org>	<559C6CA6.1050809@lge.com>
	<CAPM=9txmUJ58=CAxDhf12Y3Y8wz7CGBy-Bd4pQ8YAAKDsCxU8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAPM=9txmUJ58=CAxDhf12Y3Y8wz7CGBy-Bd4pQ8YAAKDsCxU8w@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: jlayton@poochiereds.net, aquini@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, ABI/API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, bfields@fieldses.org, minchan@kernel.org, Gioh Kim <gurugio@hanmail.net>, Linux Memory Management List <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>, gunho.lee@lge.com, linux-fsdevel@vger.kernel.org, iamjoonsoo.kim@lge.com, koct9i@gmail.com, Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz
List-Id: virtualization@lists.linuxfoundation.org

CgoyMDE1LTA3LTA5IOyYpOyghCA3OjQ37JeQIERhdmUgQWlybGllIOydtCjqsIApIOyTtCDquIA6
Cj4+Pgo+Pj4KPj4+IENhbiB0aGUgdmFyaW91cyBpbi1rZXJuZWwgR1BVIGRyaXZlcnMgYmVuZWZp
dCBmcm9tIHRoaXM/ICBJZiBzbywgd2lyaW5nCj4+PiB1cCBvbmUgb3IgbW9yZSBvZiB0aG9zZSB3
b3VsZCBiZSBoZWxwZnVsPwo+Pgo+Pgo+PiBJJ20gc3VyZSB0aGF0IG90aGVyIGluLWtlcm5lbCBH
UFUgZHJpdmVycyBjYW4gaGF2ZSBiZW5lZml0Lgo+PiBJdCBtdXN0IGJlIGhlbHBmdWwuCj4+Cj4+
IElmIEkgd2FzIGZhbWlsaWFyIHdpdGggb3RoZXIgaW4ta2VybmVsIEdQVSBkcml2ZXJzIGNvZGUs
IEkgdHJpZWQgdG8gcGF0Y2gKPj4gdGhlbS4KPj4gSXQncyB0b28gYmFkLgo+Cj4gSSdsbCBicmlu
ZyBkcmktZGV2ZWwgaW50byB0aGUgbG9vcCBoZXJlLgo+Cj4gQVJNIEdQVSBkZXZlbG9wZXJzIHBs
ZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHN0dWZmLCBMYXVyZW50LCBSb2IsCj4gRXJpYyBJIHN1
cHBvc2UuCgpJIHNlbnQgYSBwYXRjaCwgaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTUvMy8yNC8x
MTgyLCBhbmQgbXkgb3BpbmlvbiBhYm91dCBjb21wYWN0aW9uCnRvIEFSTSBHUFUgZGV2ZWxvcGVy
cyB2aWEgS29yZWEgQVJNIGJyYW5jaC4KSSBnb3QgYSByZXBseSB0aGF0IHRoZXkgaGFkIG5vIHRp
bWUgdG8gcmV2aWV3IGl0LgoKSSBob3BlIHRoZXkncmUgaW50ZXJlc3RlZCB0byB0aGlzIHBhdGNo
LgoKCj4KPiBEYW5pZWwgVmV0dGVyIHlvdSBtaWdodCBoYXZlIHNvbWUgb3BpbmlvbnMgYXMgd2Vs
bC4KPgo+IERhdmUuCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

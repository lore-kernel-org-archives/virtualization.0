From: Alexander Graf <graf-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Date: Mon, 6 Jul 2020 15:14:34 +0200
Message-ID: <76c0a77f-38d3-56ca-7204-f56c37981f45@amazon.com>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703224411.GC25072@amd>
 <CAG48ez0oWQd42a-H-Dzw1Wq7HgB5PpFRGCZeYxP8ohxaoZHmvQ@mail.gmail.com>
 <20200704114820.GA16083@amd>
 <57ab4fb3-3f82-d34f-ad74-2214b45a4dd9@amazon.com>
 <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAG48ez1tAAD+x6n07uCisXpqVpDUPX7xBWiKFkS3u2azHqd41A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "Catangiu, Adrian Costin" <acatan-vV1OtcyAfmbQT0dZR+AlfA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mhocko-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org" <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, "wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <wad-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bonzini-mXXj517/zsQ@public.gmane.org" <bonzini-mXXj517/zsQ@public.gmane.org>Ma
List-Id: virtualization@lists.linuxfoundation.org

CgpPbiAwNi4wNy4yMCAxNDo1MiwgSmFubiBIb3JuIHdyb3RlOgo+IENBVVRJT046IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuCj4gCj4gCj4gCj4gT24gTW9uLCBK
dWwgNiwgMjAyMCBhdCAyOjI3IFBNIEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+IHdy
b3RlOgo+PiBVbmxlc3Mgd2UgY3JlYXRlIGEgdnN5c2NhbGwgdGhhdCByZXR1cm5zIGJvdGggdGhl
IFBJRCBhcyB3ZWxsIGFzIHRoZQo+PiBlcG9jaCBhbmQgdGh1cyBoYW5kbGVzIGZvcmsgKmFuZCog
c3VzcGVuZC4gSSBuZWVkIHRvIHRoaW5rIGFib3V0IHRoaXMgYQo+PiBiaXQgbW9yZSA6KS4KPiAK
PiBZb3UgY2FuJ3QgcmVsaWFibHkgZGV0ZWN0IGZvcmtpbmcgYnkgY2hlY2tpbmcgdGhlIFBJRCBp
ZiBpdCBpcwo+IHBvc3NpYmxlIGZvciBtdWx0aXBsZSBmb3JrcyB0byBiZSBjaGFpbmVkIGJlZm9y
ZSB0aGUgcmV1c2UgY2hlY2sgcnVuczoKPiAKPiAgIC0gcGlkIDEwMDAgcmVtZW1iZXJzIGl0cyBQ
SUQKPiAgIC0gcGlkIDEwMDAgZm9ya3MsIGNyZWF0aW5nIGNoaWxkIHBpZCAxMDAxCj4gICAtIHBp
ZCAxMDAwIGV4aXRzIGFuZCBpcyB3YWl0ZWQgb24gYnkgaW5pdAo+ICAgLSB0aGUgcGlkIGFsbG9j
YXRvciB3cmFwcyBhcm91bmQKPiAgIC0gcGlkIDEwMDEgZm9ya3MsIGNyZWF0aW5nIGNoaWxkIHBp
ZCAxMDAwCj4gICAtIGNoaWxkIHdpdGggcGlkIDEwMDAgdHJpZXMgdG8gY2hlY2sgZm9yIGZvcmtp
bmcsIGRldGVybWluZXMgdGhhdCBpdHMKPiBQSUQgaXMgMTAwMCwgYW5kIGNvbmNsdWRlcyB0aGF0
IGl0IGlzIHN0aWxsIHRoZSBvcmlnaW5hbCBwcm9jZXNzCj4gCgpGYWlyIHBvaW50LiBIb3dldmVy
LCB5b3UgY291bGQgYnVtcCBhbiBlcG9jaCB2YWx1ZSBvbiBmb3JrLCBubz8gSSBkb24ndCAKdGhp
bmsgd2UgbWFwIGFueXRoaW5nIGluIHRoZSB2ZHNvIHBlci1wcm9jZXNzIHRvZGF5IHRob3VnaCAu
Li4KCgpBbGV4CgoKCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVz
ZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hs
YWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0
ZW5idXJnIHVudGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3
IDg3OQoKCg==

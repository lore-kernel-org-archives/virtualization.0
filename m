From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Date: Wed, 8 Jan 2020 09:48:46 +0100
Message-ID: <00a43e5c-0708-d49a-9cc4-eb2ce8b4cf99__42850.7254969858$1578473439$gmane$org@c-s.fr>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
 <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
 <CAMuHMdV=-m-eN4rOa=XQhk2oBDZZwgXXMU6RMVQRVsc6ALyeoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMuHMdV=-m-eN4rOa=XQhk2oBDZZwgXXMU6RMVQRVsc6ALyeoA@mail.gmail.com>
Content-Language: fr
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Krzysztof Kozlowski <krzk@kernel.org>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, Matt Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jo
List-Id: virtualization@lists.linuxfoundation.org

SGkgR2VlcnQsCgpMZSAwOC8wMS8yMDIwIMOgIDA5OjQzLCBHZWVydCBVeXR0ZXJob2V2ZW4gYSDD
qWNyaXTCoDoKPiBIaSBDaHJpc3RvcGhlLAo+IAo+IE9uIFdlZCwgSmFuIDgsIDIwMjAgYXQgOToz
NSBBTSBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGMtcy5mcj4gd3JvdGU6Cj4+
IExlIDA4LzAxLzIwMjAgw6AgMDk6MTgsIEtyenlzenRvZiBLb3psb3dza2kgYSDDqWNyaXQgOgo+
Pj4gT24gV2VkLCA4IEphbiAyMDIwIGF0IDA5OjEzLCBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0
QGxpbnV4LW02OGsub3JnPiB3cm90ZToKPj4+PiBPbiBXZWQsIEphbiA4LCAyMDIwIGF0IDk6MDcg
QU0gR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4gd3JvdGU6Cj4+Pj4+
IE9uIFR1ZSwgSmFuIDcsIDIwMjAgYXQgNTo1MyBQTSBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Pj4+Pj4gVGhlIGlvcmVhZDgvMTYvMzIoKSBhbmQgb3RoZXJz
IGhhdmUgaW5jb25zaXN0ZW50IGludGVyZmFjZSBhbW9uZyB0aGUKPj4+Pj4+IGFyY2hpdGVjdHVy
ZXM6IHNvbWUgdGFraW5nIGFkZHJlc3MgYXMgY29uc3QsIHNvbWUgbm90Lgo+Pj4+Pj4KPj4+Pj4+
IEl0IHNlZW1zIHRoZXJlIGlzIG5vdGhpbmcgcmVhbGx5IHN0b3BwaW5nIGFsbCBvZiB0aGVtIHRv
IHRha2UKPj4+Pj4+IHBvaW50ZXIgdG8gY29uc3QuCj4+Pj4+Cj4+Pj4+IFNob3VsZG4ndCBhbGwg
b2YgdGhlbSB0YWtlIGNvbnN0IHZvbGF0aWxlIF9faW9tZW0gcG9pbnRlcnM/Cj4+Pj4+IEl0IHNl
ZW1zIHRoZSAidm9sYXRpbGUiIGlzIG1pc3NpbmcgZnJvbSBhbGwgYnV0IHRoZSBpbXBsZW1lbnRh
dGlvbnMgaW4KPj4+Pj4gaW5jbHVkZS9hc20tZ2VuZXJpYy9pby5oLgo+Pj4+Cj4+Pj4gQXMgbXkg
InZvbGF0aWxlIiBjb21tZW50IGFwcGxpZXMgdG8gaW93cml0ZSooKSwgdG9vLCBwcm9iYWJseSB0
aGF0IHNob3VsZCBiZQo+Pj4+IGRvbmUgaW4gYSBzZXBhcmF0ZSBwYXRjaC4KPj4+Pgo+Pj4+IEhl
bmNlIHdpdGggcGF0Y2hlcyAxLTUgc3F1YXNoZWQsIGFuZCBmb3IgcGF0Y2hlcyAxMS0xMzoKPj4+
PiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5i
ZT4KPj4+Cj4+PiBJJ2xsIGFkZCB0byB0aGlzIG9uZSBhbHNvIGNoYW5nZXMgdG8gaW9yZWFkWF9y
ZXAoKSBhbmQgYWRkIGFub3RoZXIKPj4+IHBhdGNoIGZvciB2b2xhdGlsZSBmb3IgcmVhZHMgYW5k
IHdyaXRlcy4gSSBndWVzcyB5b3VyIHJldmlldyB3aWxsIGJlCj4+PiBhcHByZWNpYXRlZCBvbmNl
IG1vcmUgYmVjYXVzZSBvZiBpb3JlYWRYX3JlcCgpCj4+Cj4+IHZvbGF0aWxlIHNob3VsZCByZWFs
bHkgb25seSBiZSB1c2VkIHdoZXJlIGRlZW1lZCBuZWNlc3Nhcnk6Cj4+Cj4+IGh0dHBzOi8vd3d3
Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvdm9sYXRpbGUtY29uc2lkZXJlZC1o
YXJtZnVsLmh0bWwKPj4KPj4gSXQgaXMgc2FpZDogIiAuLi4gIGFjY2Vzc29yIGZ1bmN0aW9ucyBt
aWdodCB1c2Ugdm9sYXRpbGUgb24KPj4gYXJjaGl0ZWN0dXJlcyB3aGVyZSBkaXJlY3QgSS9PIG1l
bW9yeSBhY2Nlc3MgZG9lcyB3b3JrLiBFc3NlbnRpYWxseSwKPj4gZWFjaCBhY2Nlc3NvciBjYWxs
IGJlY29tZXMgYSBsaXR0bGUgY3JpdGljYWwgc2VjdGlvbiBvbiBpdHMgb3duIGFuZAo+PiBlbnN1
cmVzIHRoYXQgdGhlIGFjY2VzcyBoYXBwZW5zIGFzIGV4cGVjdGVkIGJ5IHRoZSBwcm9ncmFtbWVy
LiIKPiAKPiBUaGF0IGlzIGV4YWN0bHkgdGhlIHVzZSBjYXNlIGhlcmU6IGFsbCBhYm92ZSBhcmUg
YWNjZXNzb3IgZnVuY3Rpb25zLgo+IAo+IFdoeSB3b3VsZCBpb3JlYWRYKCkgbm90IG5lZWQgdm9s
YXRpbGUsIHdoaWxlIHJlYWRZKCkgZG9lcz8KPiAKCk15IHBvaW50IHdhczogaXQgbWlnaHQgYmUg
bmVjZXNzYXJ5IGZvciBzb21lIGFyY2hlcyBhbmQgbm90IGZvciBvdGhlcnMuCgpBbmQgYXMgcG9p
bnRlZCBieSBBcm5kLCB0aGUgdm9sYXRpbGUgaXMgcmVhbGx5IG9ubHkgbmVjZXNzYXJ5IGZvciB0
aGUgCmRlcmVmZXJlbmNlIGl0c2VsZiwgc2hvdWxkIHRoZSBhcmNoIHVzZSBkZXJlZmVyZW5jaW5n
LgoKU28gSSBndWVzcyB0aGUgYmVzdCB3b3VsZCBiZSB0byBnbyBpbiB0aGUgb3RoZXIgZGlyZWN0
aW9uOiByZW1vdmUgCnZvbGF0aWxlIGtleXdvcmQgd2hlcmV2ZXIgcG9zc2libGUgaW5zdGVhZCBv
ZiBhZGRpbmcgaXQgd2hlcmUgaXQgaXMgbm90IApuZWVkZWQuCgpDaHJpc3RvcGhlCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==

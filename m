From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Thu, 8 Sep 2016 13:49:56 -0700
Message-ID: <CAGXu5jLxe2w+w8h_C9FC6zG6xODVcuwiSnVzHxNDJZy_bOqviA@mail.gmail.com>
References: <20160904143900.14850-1-namhyung@kernel.org>
	<20160904143900.14850-2-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160904143900.14850-2-namhyung@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, Anton Vorontsov <anton@enomsg.org>, KVM <kvm@vger.kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Minchan Kim <minchan@kernel.org>, Tony Luck <tony.luck@intel.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

T24gU3VuLCBTZXAgNCwgMjAxNiBhdCA3OjM4IEFNLCBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtl
cm5lbC5vcmc+IHdyb3RlOgo+IFRoZSB2aXJ0aW8gcHN0b3JlIGRyaXZlciBwcm92aWRlcyBpbnRl
cmZhY2UgdG8gdGhlIHBzdG9yZSBzdWJzeXN0ZW0gc28KPiB0aGF0IHRoZSBndWVzdCBrZXJuZWwn
cyBsb2cvZHVtcCBtZXNzYWdlIGNhbiBiZSBzYXZlZCBvbiB0aGUgaG9zdAo+IG1hY2hpbmUuICBV
c2VycyBjYW4gYWNjZXNzIHRoZSBsb2cgZmlsZSBkaXJlY3RseSBvbiB0aGUgaG9zdCwgb3Igb24g
dGhlCj4gZ3Vlc3QgYXQgdGhlIG5leHQgYm9vdCB1c2luZyBwc3RvcmUgZmlsZXN5c3RlbS4gIEl0
IGN1cnJlbnRseSBkZWFscyB3aXRoCj4ga2VybmVsIGxvZyAocHJpbnRrKSBidWZmZXIgb25seSwg
YnV0IHdlIGNhbiBleHRlbmQgaXQgdG8gaGF2ZSBvdGhlcgo+IGluZm9ybWF0aW9uIChsaWtlIGZ0
cmFjZSBkdW1wKSBsYXRlci4KPgo+IEl0IHN1cHBvcnRzIGxlZ2FjeSBQQ0kgZGV2aWNlIHVzaW5n
IGEgMTZLIGJ1ZmZlciBieSBkZWZhdWx0IGFuZCBpdCdzCj4gY29uZmlndXJhYmxlLiAgSXQgdXNl
cyB0d28gdmlydHF1ZXVlcyAtIG9uZSBmb3IgKHN5bmMpIHJlYWQgYW5kIGFub3RoZXIKPiBmb3Ig
KGFzeW5jKSB3cml0ZS4gIFNpbmNlIGl0IGNhbm5vdCB3YWl0IGZvciB3cml0ZSBmaW5pc2hlZCwg
aXQgc3VwcG9ydHMKPiB1cCB0byAxMjggY29uY3VycmVudCBJTy4KPgo+IENjOiBQYW9sbyBCb256
aW5pIDxwYm9uemluaUByZWRoYXQuY29tPgo+IENjOiBSYWRpbSBLcsSNbcOhxZkgPHJrcmNtYXJA
cmVkaGF0LmNvbT4KPiBDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPgo+
IENjOiBBbnRob255IExpZ3VvcmkgPGFsaWd1b3JpQGFtYXpvbi5jb20+Cj4gQ2M6IEFudG9uIFZv
cm9udHNvdiA8YW50b25AZW5vbXNnLm9yZz4KPiBDYzogQ29saW4gQ3Jvc3MgPGNjcm9zc0BhbmRy
b2lkLmNvbT4KPiBDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+Cj4gQ2M6IFRv
bnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4KPiBDYzogU3RldmVuIFJvc3RlZHQgPHJvc3Rl
ZHRAZ29vZG1pcy5vcmc+Cj4gQ2M6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPgo+IENj
OiBNaW5jaGFuIEtpbSA8bWluY2hhbkBrZXJuZWwub3JnPgo+IENjOiBXaWxsIERlYWNvbiA8d2ls
bC5kZWFjb25AYXJtLmNvbT4KPiBDYzogdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZwo+
IENjOiBrdm1Admdlci5rZXJuZWwub3JnCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZwo+IENj
OiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IFNpZ25lZC1vZmYt
Ynk6IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4KCldoaWxlIEkgY2FuJ3Qgc3Bl
YWsgdG8gdGhlIHZpcnRpbyBwYXJ0cywgdGhlIGludGVyZmFjZSBpbnRvIHBzdG9yZQpsb29rcyBm
aW5lIHRvIG1lLiA6KQoKUmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0u
b3JnPgoKLUtlZXMKCi0tIApLZWVzIENvb2sKTmV4dXMgU2VjdXJpdHkKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u

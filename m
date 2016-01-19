From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: virtio pull for 4.5 (was Re: [PULL] virtio: barrier rework+fixes)
Date: Mon, 18 Jan 2016 17:01:26 -0800
Message-ID: <CA+55aFyh_1Lpp4U2wsFJQu_4PmSBD=36YeAhQN94L4GUhQrb2Q__25039.4500945278$1453165310$gmane$org@mail.gmail.com>
References: <20160113182855-mutt-send-email-mst@redhat.com>
	<20160118152028-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160118152028-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?Q2M6IGRhdmVAc3Rnb2xhYnMubmV0LCBkYXZlbUBkYXZlbWxvZnQubmV0LCBkYXZpZC52cmFiZWxAY2l0?= =?UTF-8?B?cml4LmNvbSwgZGJ1ZXNvQHN1c2UuZGUsIGhlaWtvLmNhcnN0ZW5zQGRlLmlibS5jb20sIGphbWVzLmhv?= =?UTF-8?B?Z2FuQGltZ3RlYy5jb20sIGpvZUBwZXJjaGVzLmNvbSwganVsaWFuLmNhbGFieUBnbWFpbC5jb20sIGxp?= =?UTF-8?B?bnV4LWFyY2hAdmdlci5rZXJuZWwub3JnLCBsaW51eEBhcm0ubGludXgub3JnLnVrLCBtaW5jaGFuQGtl?= =?UTF-8?B?cm5lbC5vcmcsIG1pbmdvQGtlcm5lbC5vcmcsIHBhdWxtY2tAbGludXgudm5ldC5pYm0uY29tLCBwZXRl?= =?UTF-8?B?cnpAaW5mcmFkZWFkLm9yZywgcmljaGFyZEBub2QuYXQsIHJtaytrZXJuZWxAYXJtLmxpbnV4Lm9yZy51?= =?UTF-8?B?aywgc2Nod2lkZWZza3lAZGUuaWJtLmNvbSwgc3RhYmxlQHZnZXIua2VybmVsLm9yZywgc3RlZmFuaGFA?= =?UTF-8?B?cmVkaGF0LmNvbSwgdGdseEBsaW51dHJvbml4LmRlLA==?= <tony.luck@intel.com>, Rafael Aquini <aquini@redhat.com>, KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Linux
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 18, 2016 at 5:21 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Hi Linus,
> Just making sure nothing's wrong with this pull request.
> If there's an issue, pls let me know!

It was just pulled because I wasn't 100% sure I wanted the extra
indirection. Oh well, pulled now.

One question:

 - the arch/sh/ part of the pacth looks dubious. Why does it do that

     #define smp_store_mb(var, value) __smp_store_mb(var, value)

   despite the commit log saying it's done by asm-generic?

I haven't pushed out yet, my allmodconfig sanity-check build is still going..

                      Linus

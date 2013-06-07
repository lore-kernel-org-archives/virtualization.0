From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: support config layout in BAR1
Date: Fri, 07 Jun 2013 11:43:01 +0930
Message-ID: <87fvwur7ma.fsf@rustcorp.com.au>
References: <20130605163500.GA3393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130605163500.GA3393@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Stephen Hemminger <shemminger@vyatta.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> Some setups don't support enabling BAR0 (IO BAR). Reasons range from CPU
> limitations (e.g. on some powerpc setups) to architecture limmitations
> (e.g. a setup with >15 PCI bridges, with one virtio device behind each,
> on x86).
>
> PCI Express spec made IO optional, so future guests will disable IO for
> a device in more and more configurations.
>
> This patch makes it possible for host to mirror the config in BAR1, such
> that these setups can work properly.
>
> Guests with old drivers can't be fixed, they will continue to work as
> well (or as bad) as they did previously.  For this reason, changing
> revision id appears unnecessary - it would break setups that previously
> worked, partially.
>
> Future work on re-organizing layout won't conflict with this patch - it
> can use a different BAR or put config at an offset, or update revision.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Since QEMU won't support this, I think we'll have to wait for the PCI
capabilities, ie. the virtio spec 1.0.

Cheers,
Rusty.

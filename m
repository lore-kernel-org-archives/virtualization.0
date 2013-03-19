From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-spec: add field for scsi command size
Date: Tue, 19 Mar 2013 11:51:35 +1030
Message-ID: <87ip4oqj4w.fsf@rustcorp.com.au>
References: <20130314111020.GA18050@redhat.com>
	<20130318214702.GA21045@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130318214702.GA21045@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Thu, Mar 14, 2013 at 01:10:20PM +0200, Michael S. Tsirkin wrote:
>> Add field for guest to specify command size for virtio-blk.
>> 
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> There's one concern here: are we going to add a
> feature flag for flexible layout? If yes this feature
> could thinkably just reuse it.
>
> It allows a nice optimization in virtio net that is very easy
> with latest qemu.
>
> Rusty, what is our plan wrt this?  Are you fine with a per-device
> feature bit?  Or do we need a transport feature bit (there's the small
> issue that we almost run out of them for virtio-pci, do we use the last
> one?).

I'd really like to tie it to the virtio PCI config work, but I need
cycles to complete that....

> As an aside, the new virtio pci config proposal seems to be stuck too,
> are you looking into it or want me to?

That would be good.  If I re-spin the kernel side, will you be able to
look at the QEMU parts?

I can weave this in between my vhost/vringh work and other commitments,
I hope.

Thanks,
Rusty.

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv3] virtio-spec: 64 bit features, used/avail event, fixes
Date: Wed, 3 Aug 2011 19:05:18 +0300
Message-ID: <20110803160518.GA16563__40801.3717191809$1312387549$gmane$org@redhat.com>
References: <20110601102548.GA11013@redhat.com>
	<87ei3dxas0.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ei3dxas0.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, kvm@vger.kernel.org, steved@us.ibm.com, Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, Tom Lendacky <tahm@linux.vnet.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 02, 2011 at 11:19:35AM +0930, Rusty Russell wrote:
> On Wed, 1 Jun 2011 13:25:48 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > Add an option to modify the notificatin
> > hand-off in virtio to be basically like Xen:
> > each side published an index, the other side only triggers
> > an event when it crosses that index value
> > (Xen event indexes start at 1, ours start at 0 for
> > backward-compatiblity, but that's minor).
> > 
> > Since we've run out of bits in the 32 bit field,
> > I added another 32 bit and bit 31 enables that.
> 
> OK.  I've applied this, and published it as the 0.9 draft.
> 
> Thanks!
> Rusty.

There's something that is bothering me: each such change
increases the size of the config.
Now, on PCI it's in io space which is much constrained.
It might not seem like 32 or 64 bytes is a lot, but in practice
there's a problem with a bridged setup: bridges
sometimes need resources pre-allocated for all devices
that might land behind them.

E.g. with 32 bridges, and 32 devices behind each one,
the available 64K space gets us only 64 bytes per device.

Thankfully even with this change, we are still below that
limit. But for example, this seems to push the size of the config for
virtio net from 32 to 34 bytes. The PCI BAR is a power of two, so it
will be exactly 64 bytes then.

io seems to work much better than memory on kvm, so
we will need to stick to that for datapath.
But maybe it's time to start putting non-datapath in memory?

Thanks,

-- 
MST

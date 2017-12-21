From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Wed, 20 Dec 2017 20:52:04 -0800
Message-ID: <20171220205204.4853f1d1@cakuba.netronome.com>
References: <20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
	<20171219095548.61d70d10@xeon-e3>
	<20171219.132117.666798483874609477.davem@davemloft.net>
	<20171219104159.30d9caaf@xeon-e3>
	<CADGSJ22mDyC0Sw2EPW96ZWvMPLnzif+Y9MMouhM-6T03ZaKA0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ22mDyC0Sw2EPW96ZWvMPLnzif+Y9MMouhM-6T03ZaKA0Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: mst@redhat.com, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Dec 2017 18:16:30 -0800, Siwei Liu wrote:
> > The plan is to remove the delay and do the naming in the kernel.
> > This was suggested by Lennart since udev is only doing naming policy
> > because kernel names were not repeatable.
> >
> > This makes the VF show up as "ethN_vf" on Hyper-V which is user friendly.
> >
> > Patch is pending.  
> 
> While it's good to show VF with specific naming to indicate
> enslavement, I wonder wouldn't it be better to hide this netdev at all
> from the user space? IMHO this extra device is useless when being
> enslaved and we may delegate controls (e.g. ethtool) over to the
> para-virtual device instead? That way it's possible to eliminate the
> possibility of additional udev setup or modification?
> 
> I'm not sure if this  is consistent with Windows guest or not, but I
> don't find it _Linux_ user friendly that ethtool doesn't work on the
> composite interface any more, and I have to end up with finding out
> the correct enslaved VF I must operate on.

Hiding "low level" netdevs comes up from time to time, and is more
widely applicable than just to VF bonds.  We should find a generic
solution to that problem.

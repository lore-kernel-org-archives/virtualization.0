From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: use __GFP_NOWARN for try_fill_recv in virtnet_poll
Date: Tue, 15 Feb 2011 21:39:03 +1030
Message-ID: <201102152139.03451.rusty__48136.5086431198$1297837710$gmane$org@rustcorp.com.au>
References: <20110215093527.GB8341@tiehlicka.suse.cz>
	<201102152041.29179.rusty@rustcorp.com.au>
	<20110215102549.GD8341@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110215102549.GD8341@tiehlicka.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@suse.cz>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 15 Feb 2011 08:55:50 pm Michal Hocko wrote:
> On Tue 15-02-11 20:41:29, Rusty Russell wrote:
> > On Tue, 15 Feb 2011 08:05:27 pm Michal Hocko wrote:
> > > Hi,
> > > we have started seeing a lot of allocator messages complaining about
> > > failed allocations from virtnet_poll in soft IRQ. Could you consider the
> > > following patch, please?
> > 
> > Do we really want to silence this?  Isn't warning about it kind of the
> > point?  Your network is probably sucking if this happens...
> 
> What can user do about it? Is the low level memory allocator message
> very much usefull for him?  Maybe we can add a printk_once in the fail
> path with some more useful and virtio specific message.

That's an argument against ever printing any message.

What we need to know is why does this happen with virtio_net and not other
cards?  If it happens to them too, and they silently fall back, all good.

I want to make sure we're not papering over a real problem...

Thanks,
Rusty.

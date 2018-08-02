From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [net-next, v6, 6/7] net-sysfs: Add interface for Rx queue(s) map
	per Tx queue
Date: Fri, 3 Aug 2018 00:08:05 +0300
Message-ID: <20180803000725-mutt-send-email-mst__1057.36932387135$1533243969$gmane$org@kernel.org>
References: <153033282719.8297.790755582693609184.stgit@anamhost.jf.intel.com>
	<20180704072048.GA29107@outlook.office365.com>
	<4b7f5d42-1b81-f095-f313-f43e41cf8601@intel.com>
	<20180802001157.GA29171@outlook.office365.com>
	<c3fbd7f6-054b-a9a3-ea21-4169b26a0a41@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c3fbd7f6-054b-a9a3-ea21-4169b26a0a41@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: alexander.h.duyck@intel.com, willemdebruijn.kernel@gmail.com, Andrei Vagin <avagin@virtuozzo.com>, tom@herbertland.com, netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, edumazet@google.com, rostedt@goodmis.org, hannes@stressinduktion.org, sridhar.samudrala@intel.com, tom@quantonium.net, davem@davemloft.net, gaowanlong@cn.fujitsu.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 02, 2018 at 02:04:12PM -0700, Nambiar, Amritha wrote:
> On 8/1/2018 5:11 PM, Andrei Vagin wrote:
> > On Tue, Jul 10, 2018 at 07:28:49PM -0700, Nambiar, Amritha wrote:
> >> With this patch series, I introduced static_key for XPS maps
> >> (xps_needed), so static_key_slow_inc() is used to switch branches. The
> >> definition of static_key_slow_inc() has cpus_read_lock in place. In the
> >> virtio_net driver, XPS queues are initialized after setting the
> >> queue:cpu affinity in virtnet_set_affinity() which is already protected
> >> within cpus_read_lock. Hence, the warning here trying to acquire
> >> cpus_read_lock when it is already held.
> >>
> >> A quick fix for this would be to just extract netif_set_xps_queue() out
> >> of the lock by simply wrapping it with another put/get_online_cpus
> >> (unlock right before and hold lock right after).
> > 
> > virtnet_set_affinity() is called from virtnet_cpu_online(), which is
> > called under cpus_read_lock too.
> > 
> > It looks like now we can't call netif_set_xps_queue() from cpu hotplug
> > callbacks.
> > 
> > I can suggest a very straightforward fix for this problem. The patch is
> > attached.
> > 
> 
> Thanks for looking into this. I was thinking of fixing this in the
> virtio_net driver by moving the XPS initialization (and have a new
> get_affinity utility) in the ndo_open (so it is together with other tx
> preparation) instead of probe. Your patch solves this in general for
> setting up cpu hotplug callbacks which is under cpus_read_lock.


I like this too. Could you repost in a standard way
(inline, with your signoff etc) so we can ack this for
net-next?

> >> But this may not a
> >> clean solution. It'd help if I can get suggestions on what would be a
> >> clean option to fix this without extensively changing the code in
> >> virtio_net. Is it mandatory to protect the affinitization with
> >> read_lock? I don't see similar lock in other drivers while setting the
> >> affinity. I understand this warning should go away, but isn't it safe to
> >> have multiple readers.
> >>
> >>> On Fri, Jun 29, 2018 at 09:27:07PM -0700, Amritha Nambiar wrote:

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Fri, 20 Apr 2018 18:43:54 +0300
Message-ID: <20180420183505-mutt-send-email-mst__2903.28774503923$1524238924$gmane$org@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180420082802.6ca37e4c@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 20, 2018 at 08:28:02AM -0700, Stephen Hemminger wrote:
> On Thu, 19 Apr 2018 18:42:04 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > failover infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Do what you want to other devices but leave netvsc alone.
> Adding these failover ops does not reduce the code size,

drivers/net/hyperv/Kconfig      |   1 +
drivers/net/hyperv/hyperv_net.h |   2 +
drivers/net/hyperv/netvsc_drv.c | 208 ++++++++++------------------------------
3 files changed, 55 insertions(+), 156 deletions(-)

100 lines gone.


> and really is
> no benefit.  The netvsc device driver needs to be backported to several
> other distributions and doing this makes that harder.
> 
> I will NAK patches to change to common code for netvsc

Wow.

> especially the
> three device model.

AFAIK these patches do not change netvsc to a three device model.

> MS worked hard with distro vendors to support transparent
> mode, ans we really can't have a new model;

That's why Sridhar worked hard to preserve a 2 device model for netvsc.

> or do backport.
>
> Plus, DPDK is now dependent on existing model.

DPDK does the kernel bypass thing, doesn't it? Why does the kernel care?

-- 
MST

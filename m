From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Fri, 11 May 2018 21:09:33 +0300
Message-ID: <20180511210815-mutt-send-email-mst__32449.7332833291$1526062075$gmane$org@kernel.org>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
	<1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
	<460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <460f3d8f-b2ec-2118-e296-03f4f9655c5a@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 07, 2018 at 03:39:19PM -0700, Randy Dunlap wrote:
> Hi,
> 
> On 05/07/2018 03:10 PM, Sridhar Samudrala wrote:
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > ---
> >  MAINTAINERS                |    7 +
> >  include/linux/netdevice.h  |   16 +
> >  include/net/net_failover.h |   52 +++
> >  net/Kconfig                |   10 +
> >  net/core/Makefile          |    1 +
> >  net/core/net_failover.c    | 1044 ++++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 1130 insertions(+)
> >  create mode 100644 include/net/net_failover.h
> >  create mode 100644 net/core/net_failover.c
> 
> 
> > diff --git a/net/Kconfig b/net/Kconfig
> > index b62089fb1332..0540856676de 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -429,6 +429,16 @@ config MAY_USE_DEVLINK
> >  config PAGE_POOL
> >         bool
> >  
> > +config NET_FAILOVER
> > +	tristate "Failover interface"
> > +	default m
> 
> Need some justification for default m (as opposed to n).

Or one can just leave the default line out.

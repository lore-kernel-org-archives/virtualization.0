From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v6] failover: allow name change on IFF_UP slave
	interfaces
Date: Fri, 5 Apr 2019 18:01:43 -0400
Message-ID: <20190405175429-mutt-send-email-mst__41817.5248474412$1554501765$gmane$org@kernel.org>
References: <1554267167-17561-1-git-send-email-si-wei.liu@oracle.com>
	<20190405144701.25a6b55b@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190405144701.25a6b55b@shemminger-XPS-13-9360>
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
Cc: jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, Si-Wei Liu <si-wei.liu@oracle.com>, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 05, 2019 at 02:47:01PM -0700, Stephen Hemminger wrote:
> On Wed,  3 Apr 2019 00:52:47 -0400
> Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> 
> >  
> > +	if (unlikely(dev->flags & IFF_UP)) {
> > +		struct netdev_notifier_change_info change_info = {
> > +			.info.dev = dev,
> > +		};
> > +
> > +		call_netdevice_notifiers_info(NETDEV_CHANGE,
> > +					      &change_info.info);
> > +	}
> 
> This notifier is not really necessary, there already is a CHANGENAME
> that gets sent.
> NETDEV_CHANGE is used in other cases to mean that the state (flags)
> have changed.

The point is some existing scripts might not expect name
change to happen without a status change afterwards (since it was
impossible for so long). So this reports a change
to make sure scripts do not miss it.

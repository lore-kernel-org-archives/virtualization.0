From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Fri, 11 May 2018 20:15:58 +0300
Message-ID: <20180511201450-mutt-send-email-mst@kernel.org>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
	<1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
	<20180507165306.541bd1f2@xeon-e3>
	<e8454b29-d66b-9e20-a887-cb312a63847e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e8454b29-d66b-9e20-a887-cb312a63847e@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 07, 2018 at 05:24:27PM -0700, Samudrala, Sridhar wrote:
> =

> =

> On 5/7/2018 4:53 PM, Stephen Hemminger wrote:
> > On Mon,  7 May 2018 15:10:44 -0700
> > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> > =

> > > +static struct net_device *net_failover_get_bymac(u8 *mac,
> > > +						 struct net_failover_ops **ops)
> > > +{
> > > +	struct net_device *failover_dev;
> > > +	struct net_failover *failover;
> > > +
> > > +	spin_lock(&net_failover_lock);
> > > +	list_for_each_entry(failover, &net_failover_list, list) {
> > > +		failover_dev =3D rtnl_dereference(failover->failover_dev);
> > > +		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
> > > +			*ops =3D rtnl_dereference(failover->ops);
> > > +			spin_unlock(&net_failover_lock);
> > > +			return failover_dev;
> > > +		}
> > > +	}
> > > +	spin_unlock(&net_failover_lock);
> > > +	return NULL;
> > > +}
> > This is broken if non-ethernet devices such as Infiniband are present.
> =

> There is check to make sure that a slave and failover devices are of the =
same type in
> net_failover_slave_register()
> =

> 	failover_dev =3D net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
> =A0=A0=A0=A0=A0=A0=A0 if (!failover_dev)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto done;
> =

> =A0=A0=A0=A0=A0=A0=A0 if (failover_dev->type !=3D slave_dev->type)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto done;
> =

> Do you think this is not good enough? I had an explicit check for ARPHRD_=
ETHER in
> earlier patchsets, but removed it based on Jiri's comment.

Right but how is ether_addr_equal supposed to work if types are
identical but not ethernet?

This can also benefit from a comment referring to the check in
net_failover_slave_register.

-- =

MST

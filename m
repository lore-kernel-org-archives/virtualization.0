From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
Date: Wed, 2 May 2018 23:30:02 +0300
Message-ID: <20180502232907-mutt-send-email-mst__6466.68663616783$1525292888$gmane$org@kernel.org>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
	<20180428090601.GL5632@nanopsycho.orion>
	<20180502161542.GI19250@nanopsycho>
	<052e2c60-dc4c-d6a0-0159-fc1821cb4365@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <052e2c60-dc4c-d6a0-0159-fc1821cb4365@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 02, 2018 at 10:51:12AM -0700, Samudrala, Sridhar wrote:
> =

> =

> On 5/2/2018 9:15 AM, Jiri Pirko wrote:
> > Sat, Apr 28, 2018 at 11:06:01AM CEST, jiri@resnulli.us wrote:
> > > Fri, Apr 27, 2018 at 07:06:58PM CEST, sridhar.samudrala@intel.com wro=
te:
> > [...]
> > =

> > =

> > > > +
> > > > +	err =3D netdev_rx_handler_register(slave_dev, net_failover_handle=
_frame,
> > > > +					 failover_dev);
> > > > +	if (err) {
> > > > +		netdev_err(slave_dev, "can not register failover rx handler (err=
 =3D %d)\n",
> > > > +			   err);
> > > > +		goto err_handler_register;
> > > > +	}
> > > > +
> > > > +	err =3D netdev_upper_dev_link(slave_dev, failover_dev, NULL);
> > > Please use netdev_master_upper_dev_link().
> > Don't forget to fillup struct netdev_lag_upper_info - NETDEV_LAG_TX_TYP=
E_ACTIVEBACKUP
> > =

> > =

> > Also, please call netdev_lower_state_changed() when the active slave
> > device changes from primary->backup of backup->primary and whenever link
> > state of a slave changes
> > =

> Sure. will look into it.=A0 Do you think this will help with the issue
> you saw with having to change mac on standy twice to get the init scripts
> working? We are now going to block changing the mac on both standby and
> failover.
> =

> Also, i was wondering if we should set dev->flags to IFF_MASTER on failov=
er
> and IFF_SLAVE on primary and standby.

We do need a way to find things out, that's for sure.
How does userspace know it's a failover
config and find the failover device right now?

> netvsc does this.
> Does this help with the init scripts and network manager to skip slave
> devices for dhcp requests?

Try it?

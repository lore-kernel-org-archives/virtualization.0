From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next] failover: allow name change on IFF_UP slave
	interfaces
Date: Wed, 6 Mar 2019 02:23:31 -0500
Message-ID: <20190306021801-mutt-send-email-mst__24737.6132336043$1551857030$gmane$org@kernel.org>
References: <20190304213032-mutt-send-email-mst@kernel.org>
	<e3b34115-39ca-ac5f-7d53-8bf9e69c910d@oracle.com>
	<20190305112427.1a23822e@shemminger-XPS-13-9360>
	<9448ae8f-c4e0-58a4-ff46-2f2951113d1e@oracle.com>
	<20190305190325-mutt-send-email-mst@kernel.org>
	<8737e985-f418-7002-c8b5-0023d1c4a453@oracle.com>
	<20190305193439-mutt-send-email-mst@kernel.org>
	<fde572b3-e342-b37f-0e3d-e16599f1ee81@oracle.com>
	<20190306013255-mutt-send-email-mst@kernel.org>
	<98243a73-a42a-6465-cf3c-a049c53b4d0c@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <98243a73-a42a-6465-cf3c-a049c53b4d0c@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 05, 2019 at 11:15:06PM -0800, si-wei liu wrote:
> 
> 
> On 3/5/2019 10:43 PM, Michael S. Tsirkin wrote:
> > On Tue, Mar 05, 2019 at 04:51:00PM -0800, si-wei liu wrote:
> > > 
> > > On 3/5/2019 4:36 PM, Michael S. Tsirkin wrote:
> > > > On Tue, Mar 05, 2019 at 04:20:50PM -0800, si-wei liu wrote:
> > > > > On 3/5/2019 4:06 PM, Michael S. Tsirkin wrote:
> > > > > > On Tue, Mar 05, 2019 at 11:35:50AM -0800, si-wei liu wrote:
> > > > > > > On 3/5/2019 11:24 AM, Stephen Hemminger wrote:
> > > > > > > > On Tue, 5 Mar 2019 11:19:32 -0800
> > > > > > > > si-wei liu <si-wei.liu@oracle.com> wrote:
> > > > > > > > 
> > > > > > > > > > I have a vague idea: would it work to *not* set
> > > > > > > > > > IFF_UP on slave devices at all?
> > > > > > > > > Hmm, I ever thought about this option, and it appears this solution is
> > > > > > > > > more invasive than required to convert existing scripts, despite the
> > > > > > > > > controversy of introducing internal netdev state to differentiate user
> > > > > > > > > visible state. Either we disallow slave to be brought up by user, or to
> > > > > > > > > not set IFF_UP flag but instead use the internal one, could end up with
> > > > > > > > > substantial behavioral change that breaks scripts. Consider any admin
> > > > > > > > > script that does `ip link set dev ... up' successfully just assumes the
> > > > > > > > > link is up and subsequent operation can be done as usual.
> > > > > > How would it work when carrier is off?
> > > > > > 
> > > > > > > While it *may*
> > > > > > > > > work for dracut (yet to be verified), I'm a bit concerned that there are
> > > > > > > > > more scripts to be converted than those that don't follow volatile
> > > > > > > > > failover slave names. It's technically doable, but may not worth the
> > > > > > > > > effort (in terms of porting existing scripts/apps).
> > > > > > > > > 
> > > > > > > > > Thanks
> > > > > > > > > -Siwei
> > > > > > > > Won't work for most devices.  Many devices turn off PHY and link layer
> > > > > > > > if not IFF_UP
> > > > > > > True, that's what I said about introducing internal state for those driver
> > > > > > > and other kernel component. Very invasive change indeed.
> > > > > > > 
> > > > > > > -Siwei
> > > > > > Well I did say it's vague.
> > > > > > How about hiding IFF_UP from dev_get_flags (and probably
> > > > > > __dev_change_flags)?
> > > > > > 
> > > > > Any different? This has small footprint for the kernel change for sure,
> > > > > while the discrepancy is still there. Anyone who writes code for IFF_UP will
> > > > > not notice IFF_FAILOVER_SLAVE.
> > > > > 
> > > > > Not to mention more userspace "fixup" work has to be done due to this
> > > > > change.
> > > > > 
> > > > > -Siwei
> > > > > 
> > > > > 
> > > > Point is it's ok since most userspace should just ignore slaves
> > > > - hopefully it will just ignore it since it already
> > > > ignores interfaces that are down.
> > > Admin script thought the interface could be bright up and do further
> > > operations without checking the UP flag.
> > These scripts then would be broken  on any box with multiple interfaces
> > since not all of these would have carrier.
> Consider a script executing `ifconfig ... up' and once succeeds runs tcpdump
> or some other command relying on UP interface. It's quite common that those
> scripts don't check the UP flag but instead just rely on the well-known fact
> that the command exits with 0 meaning the interface should be UP. This
> change might well break scripts of that kind.

I am sorry I don't get it. Could you give an example
of a script that works now but would be broken?


> > 
> > 
> > > It doesn't look to be a reliable
> > > way of prohibit userspace from operating against slaves.
> > > 
> > > -Siwei
> > > 
> > > 
> > This does not mean we shouldn't make an effort to disable broken
> > configurations.
> > 
> > I am not arguing against your patch. Not at all. I see better
> > hiding of slaves as a separate enhancement.
> I understand, but my point is we should try to minimize unnecessary side
> impact to the current usage for whatever "hiding" effort we can make. It's
> hard to find a tradeoff sometimes.

Yes if some userspace made an assumption and it worked, we should keep
it working I think. I don't necessarily agree we should worry too much
about theoretical issues. In half a year since the feature got merged
it's unlikely there are millions of slightly different scripts using it.

> > 
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > 
> Thank you.
> 
> -Siwei

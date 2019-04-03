From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net v5] failover: allow name change on IFF_UP slave
	interfaces
Date: Tue, 2 Apr 2019 20:14:51 -0700
Message-ID: <20190402201451.1f6201b8__1374.1612712451$1554261305$gmane$org@shemminger-XPS-13-9360>
References: <1554159893-29704-1-git-send-email-si-wei.liu@oracle.com>
	<20190402145359.55814e11@shemminger-XPS-13-9360>
	<d62006dc-d602-7389-cc27-2c1873163ad2@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d62006dc-d602-7389-cc27-2c1873163ad2@oracle.com>
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
Cc: jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2 Apr 2019 15:23:29 -0700
si-wei liu <si-wei.liu@oracle.com> wrote:

> On 4/2/2019 2:53 PM, Stephen Hemminger wrote:
> > On Mon,  1 Apr 2019 19:04:53 -0400
> > Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >  
> >> +	if (dev->flags & IFF_UP &&
> >> +	    likely(!(dev->priv_flags & IFF_FAILOVER_SLAVE)))  
> > Why is property limited to failover slave, it would make sense for netvsc
> > as well. Why not make it a flag like live address change?  
> Well, netvsc today is still taking the delayed approach meaning that it 
> is incompatible yet with this live name change flag if need be. ;-)
> 
> I thought Sridhar did not like to introduce an additional 
> IFF_SLAVE_RENAME_OK flag given that failover slave is the only consumer 
> for the time being. Even though I can get it back, patch is needed for 
> netvsc to remove the VF takeover delay IMHO.
> 
> Sridhar, what do you think we revive the IFF_SLAVE_RENAME_OK flag which 
> allows netvsc to be used later on? Or maybe, IFF_LIVE_RENAME_OK for a 
> better name?
> 
> -Siwei

I would name it IFF_LIVE_NAME_CHANGE to match IFF_LIVE_ADDR_CHANGE
there is no reason its use should be restricted to SLAVE devices.

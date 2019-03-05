From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH net-next] failover: allow name change on IFF_UP
	slave interfaces
Date: Tue, 5 Mar 2019 11:24:27 -0800
Message-ID: <20190305112427.1a23822e__32669.283756853$1551814705$gmane$org@shemminger-XPS-13-9360>
References: <1551747059-11831-1-git-send-email-si-wei.liu@oracle.com>
	<20190304213032-mutt-send-email-mst@kernel.org>
	<e3b34115-39ca-ac5f-7d53-8bf9e69c910d@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <e3b34115-39ca-ac5f-7d53-8bf9e69c910d@oracle.com>
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
Cc: Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 5 Mar 2019 11:19:32 -0800
si-wei liu <si-wei.liu@oracle.com> wrote:

> > I have a vague idea: would it work to *not* set
> > IFF_UP on slave devices at all?  
> Hmm, I ever thought about this option, and it appears this solution is 
> more invasive than required to convert existing scripts, despite the 
> controversy of introducing internal netdev state to differentiate user 
> visible state. Either we disallow slave to be brought up by user, or to 
> not set IFF_UP flag but instead use the internal one, could end up with 
> substantial behavioral change that breaks scripts. Consider any admin 
> script that does `ip link set dev ... up' successfully just assumes the 
> link is up and subsequent operation can be done as usual. While it *may* 
> work for dracut (yet to be verified), I'm a bit concerned that there are 
> more scripts to be converted than those that don't follow volatile 
> failover slave names. It's technically doable, but may not worth the 
> effort (in terms of porting existing scripts/apps).
> 
> Thanks
> -Siwei

Won't work for most devices.  Many devices turn off PHY and link layer
if not IFF_UP

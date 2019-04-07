From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net v6] failover: allow name change on IFF_UP slave
	interfaces
Date: Sat, 6 Apr 2019 19:45:02 -0700
Message-ID: <7d1c3488-2d55-213f-b744-c71b665aa387@intel.com>
References: <1554267167-17561-1-git-send-email-si-wei.liu@oracle.com>
	<20190405172835-mutt-send-email-mst@kernel.org>
	<20190405144750.441e396f@shemminger-XPS-13-9360>
	<ab2443f2-11e0-4773-319a-27004520d178@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ab2443f2-11e0-4773-319a-27004520d178@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: si-wei liu <si-wei.liu@oracle.com>, Stephen Hemminger <stephen@networkplumber.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org


On 4/6/2019 12:21 AM, si-wei liu wrote:

>>>
>>> Stephen are you happy with this approach?
>> I think it is the best solution for what you want to do.
> 
> Since you're asking specifically, I tried what you suggested below.
> 
>> Did you test with some things like Free Range Routing,
> 
> Although there might be spurious warning (which is a check for sanity 
> more than an error) while slave interface is up, slave rename had been 
> handled quite well there, no matter which state slave is at.
> 
> https://github.com/FRRouting/frr/blob/master/zebra/if_netlink.c#L97
> 
> The FRR users are supposed to operate on failover master interface 
> anyway. No one is expected to configure those passive interfaces for 
> routing.
> 
>> VPP
> Nothing particular was seen for this one. The netlink usage there 
> doesn't seem related to my change:
> https://github.com/FDio/vpp/blob/master/src/vnet/devices/netlink.c
> 
>> or other userspace
>> control planes that consume netlink?
> dhcpcd (https://github.com/kobolabs/dhcpcd/blob/kobo/if-linux.c#L761) 
> was tested OK.
> 
> In addition, the patch seems to play quite well with systemd-udev and 
> dracut/initramfs-tools. No breakage, no weird error message was seen.
> 
> What else do you suggest we should try/test with?

Thanks Siwei for all the tests you are trying out. Did you notice that 
any of these tests required the NETDEV_CHANGE notifier that you added?

-Sridhar

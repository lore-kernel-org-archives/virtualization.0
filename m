From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Tue, 1 May 2018 09:33:27 +0200
Message-ID: <20180501073327.GQ23854__14719.4101628431$1525159899$gmane$org@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-4-git-send-email-sridhar.samudrala@intel.com>
	<20180428082433.GK5632@nanopsycho.orion>
	<62f3b81b-70f6-6991-8e23-2bf650ecea2d@intel.com>
	<20180430071208.GG23854@nanopsycho.orion>
	<c965d7f2-9ba6-fc82-ce1c-4d70c3aceb6d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c965d7f2-9ba6-fc82-ce1c-4d70c3aceb6d@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Mon, Apr 30, 2018 at 09:26:34PM CEST, sridhar.samudrala@intel.com wrote:
>On 4/30/2018 12:12 AM, Jiri Pirko wrote:
>> Mon, Apr 30, 2018 at 05:00:33AM CEST, sridhar.samudrala@intel.com wrote:
>> > On 4/28/2018 1:24 AM, Jiri Pirko wrote:
>> > > Fri, Apr 27, 2018 at 07:06:59PM CEST, sridhar.samudrala@intel.com wrote:
>> > > > This patch enables virtio_net to switch over to a VF datapath when a VF
>> > > > netdev is present with the same MAC address. It allows live migration
>> > > > of a VM with a direct attached VF without the need to setup a bond/team
>> > > > between a VF and virtio net device in the guest.
>> > > > 
>> > > > The hypervisor needs to enable only one datapath at any time so that
>> > > > packets don't get looped back to the VM over the other datapath. When a VF
>> > > Why? Both datapaths could be enabled at a time. Why the loop on
>> > > hypervisor side would be a problem. This in not an issue for
>> > > bonding/team as well.
>> > Somehow the hypervisor needs to make sure that the broadcasts/multicasts from the VM
>> > sent over the VF datapath don't get looped back to the VM via the virtio-net datapth.
>> Why? Please see below.
>> 
>> 
>> > This can happen if both datapaths are enabled at the same time.
>> > 
>> > I would think this is an issue even with bonding/team as well when virtio-net and
>> > VF are backed by the same PF.
>> > 
>> > 
>> I believe that the scenario is the same as on an ordinary nic/swich
>> network:
>> 
>> ...................
>> 
>>    host
>>         bond0
>>        /     \
>>      eth0   eth1
>>       |       |
>> ...................
>>       |       |
>>       p1      p2
>> 
>>    switch
>> 
>> ...................
>> 
>> It is perfectly valid to p1 and p2 be up and "bridged" together. Bond
>> has to cope with loop-backed frames. "Failover driver" should too,
>> it's the same scenario.
>
>OK. So looks like we should be able to handle this by returning RX_HANDLER_EXACT
>for frames received on standby device when primary is present.

Yep.

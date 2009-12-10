From: Alexander Graf <agraf@suse.de>
Subject: Re: Guest bridge setup variations
Date: Thu, 10 Dec 2009 20:14:28 +0100
Message-ID: <784CAF36-3F28-4FFD-82A2-0A4E54EDB831@suse.de>
References: <200912081707.42660.arnd@arndb.de>
	<0199E0D51A61344794750DC57738F58E6D7083F314@GVW1118EXC.americas.hpqcorp.net>
	<200912101518.36128.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200912101518.36128.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Fischer, Anna" <anna.fischer@hp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


On 10.12.2009, at 15:18, Arnd Bergmann wrote:

> On Thursday 10 December 2009, Fischer, Anna wrote:
>>> 
>>> 3. Doing the bridging in the NIC using macvlan in passthrough
>>> mode. This lowers the CPU utilization further compared to 2,
>>> at the expense of limiting throughput by the performance of
>>> the PCIe interconnect to the adapter. Whether or not this
>>> is a win is workload dependent. Access controls now happen
>>> in the NIC. Currently, this is not supported yet, due to lack of
>>> device drivers, but it will be an important scenario in the future
>>> according to some people.
>> 
>> Can you differentiate this option from typical PCI pass-through mode?
>> It is not clear to me where macvlan sits in a setup where the NIC does
>> bridging.
> 
> In this setup (hypothetical so far, the code doesn't exist yet), we use
> the configuration logic of macvlan, but not the forwarding. This also
> doesn't do PCI pass-through but instead gives all the logical interfaces
> to the host, using only the bridging and traffic separation capabilities
> of the NIC, but not the PCI-separation.
> 
> Intel calls this mode VMDq, as opposed to SR-IOV, which implies
> the assignment of the adapter to a guest.
> 
> It was confusing of me to call it passthrough above, sorry for that.
> 
>> Typically, in a PCI pass-through configuration, all configuration goes
>> through the physical function device driver (and all data goes directly
>> to the NIC). Are you suggesting to use macvlan as a common
>> configuration layer that then configures the underlying NIC?
>> I could see some benefit in such a model, though I am not certain I
>> understand you correctly.
> 
> This is something I also have been thinking about, but it is not what
> I was referring to above. I think it would be good to keep the three
> cases (macvlan, VMDq, SR-IOV) as similar as possible from the user
> perspective, so using macvlan as an infrastructure for all of them
> sounds reasonable to me.

Oh, so you'd basically do -net vt-d,if=eth0 and the rest would automatically work? That's a pretty slick idea!

Alex

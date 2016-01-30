From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: bonding (IEEE 802.3ad) not working with qemu/virtio
Date: Sat, 30 Jan 2016 12:34:11 +0100
Message-ID: <20160130113411.GA2181__24998.2736459517$1454179727$gmane$org@nanopsycho.orion>
References: <56ABDA3D.8040100@cumulusnetworks.com> <28285.1454103900@famine>
	<56ABDE2A.7010301@cumulusnetworks.com>
	<20160129.225924.1343743091073159760.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160129.225924.1343743091073159760.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: mst@redhat.com, nikolay@cumulusnetworks.com, gospo@cumulusnetworks.com, virtualization@lists.linux-foundation.org, bjornar.ness@gmail.com, vfalico@gmail.com, netdev@vger.kernel.org, jay.vosburgh@canonical.com
List-Id: virtualization@lists.linuxfoundation.org

Sat, Jan 30, 2016 at 07:59:24AM CET, davem@davemloft.net wrote:
>From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>Date: Fri, 29 Jan 2016 22:48:26 +0100
>
>> On 01/29/2016 10:45 PM, Jay Vosburgh wrote:
>>> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>>> =

>>>> On 01/25/2016 05:24 PM, Bj=F8rnar Ness wrote:
>>>>> As subject says, 802.3ad bonding is not working with virtio network m=
odel.
>>>>>
>>>>> The only errors I see is:
>>>>>
>>>>> No 802.3ad response from the link partner for any adapters in the bon=
d.
>>>>>
>>>>> Dumping the network traffic shows that no LACP packets are sent from =
the
>>>>> host running with virtio driver, changing to for example e1000 solves
>>>>> this problem
>>>>> with no configuration changes.
>>>>>
>>>>> Is this a known problem?
>>>>>
>>>> [Including bonding maintainers for comments]
>>>>
>>>> Hi,
>>>> Here's a workaround patch for virtio_net devices that "cheats" the
>>>> duplex test (which is the actual problem). I've tested this locally
>>>> and it works for me.
>>>> I'd let the others comment on the implementation, there're other signs
>>>> that can be used to distinguish a virtio_net device so I'm open to sug=
gestions.
>>>> Also feedback if this is at all acceptable would be appreciated.
>>> =

>>> 	Should virtio instead provide an arbitrary speed and full duplex
>>> to ethtool, as veth does?
>>> =

>>> 	Creating a magic whitelist of devices deep inside the 802.3ad
>>> implementation seems less desirable.
>>> =

>> TBH, I absolutely agree. In fact here's what we've been doing:
>> add set_settings which allows the user to set any speed/duplex
>> and get_settings of course to retrieve that. This is also useful
>> for testing other stuff that requires speed and duplex, not only
>> for the bonding case.
>
>I also agree.  Having a whitelist is just rediculous.
>
>There should be a default speed/duplex setting for such devices as well.
>We can pick one that will be use universally for these kinds of devices.

Exposing made up speed for veth and virtio_net sounds odd to me. User
see 10000Mb/s but it makes no sense at all. It is just confusing.

I believe this is bonding bug and should be fixed in there. Team works
fine with virtio_net device and lacp runner.

From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Mon, 22 Jan 2018 16:02:04 -0800
Message-ID: <20180122160204.130451f2__37751.6720597216$1516665640$gmane$org@xeon-e3>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
	<CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
	<20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7edf772b-627c-6121-3332-479caed524da@intel.com>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 22 Jan 2018 15:27:40 -0800
"Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:

> On 1/22/2018 1:31 PM, Michael S. Tsirkin wrote:
> > On Wed, Jan 17, 2018 at 01:49:58PM -0800, Alexander Duyck wrote:  
> >> On Wed, Jan 17, 2018 at 11:57 AM, Michael S. Tsirkin <mst@redhat.com> wrote:  
> >>> On Wed, Jan 17, 2018 at 11:25:41AM -0800, Samudrala, Sridhar wrote:  
> >>>>
> >>>> On 1/17/2018 11:02 AM, Michael S. Tsirkin wrote:  
> >>>>> On Wed, Jan 17, 2018 at 10:15:52AM -0800, Alexander Duyck wrote:  
> >>>>>> On Thu, Jan 11, 2018 at 9:58 PM, Sridhar Samudrala
> >>>>>> <sridhar.samudrala@intel.com> wrote:  
> >>>>>>> This feature bit can be used by hypervisor to indicate virtio_net device to
> >>>>>>> act as a backup for another device with the same MAC address.
> >>>>>>>
> >>>>>>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >>>>>>> ---
> >>>>>>>    drivers/net/virtio_net.c        | 2 +-
> >>>>>>>    include/uapi/linux/virtio_net.h | 3 +++
> >>>>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>>> index 12dfc5fee58e..f149a160a8c5 100644
> >>>>>>> --- a/drivers/net/virtio_net.c
> >>>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>>> @@ -2829,7 +2829,7 @@ static struct virtio_device_id id_table[] = {
> >>>>>>>           VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
> >>>>>>>           VIRTIO_NET_F_CTRL_MAC_ADDR, \
> >>>>>>>           VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
> >>>>>>> -       VIRTIO_NET_F_SPEED_DUPLEX
> >>>>>>> +       VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_BACKUP
> >>>>>>>
> >>>>>>>    static unsigned int features[] = {
> >>>>>>>           VIRTNET_FEATURES,
> >>>>>>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> >>>>>>> index 5de6ed37695b..c7c35fd1a5ed 100644
> >>>>>>> --- a/include/uapi/linux/virtio_net.h
> >>>>>>> +++ b/include/uapi/linux/virtio_net.h
> >>>>>>> @@ -57,6 +57,9 @@
> >>>>>>>                                            * Steering */
> >>>>>>>    #define VIRTIO_NET_F_CTRL_MAC_ADDR 23  /* Set MAC address */
> >>>>>>>
> >>>>>>> +#define VIRTIO_NET_F_BACKUP      62    /* Act as backup for another device
> >>>>>>> +                                        * with the same MAC.
> >>>>>>> +                                        */
> >>>>>>>    #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
> >>>>>>>
> >>>>>>>    #ifndef VIRTIO_NET_NO_LEGACY  
> >>>>>> I'm not a huge fan of the name "backup" since that implies that the
> >>>>>> Virtio interface is only used if the VF is not present, and there are
> >>>>>> multiple instances such as dealing with east/west or
> >>>>>> broadcast/multicast traffic where it may be desirable to use the
> >>>>>> para-virtual interface rather then deal with PCI overhead/bottleneck
> >>>>>> to send the packet.  
> >>>>> Right now hypervisors mostly expect that yes, only one at a time is
> >>>>> used.  E.g. if you try to do multicast sending packets on both VF and
> >>>>> virtio then you will end up with two copies of each packet.  
> >>>> I think we want to use only 1 interface to  send out any packet. In case of
> >>>> broadcast/multicasts it would be an optimization to send them via virtio and
> >>>> this patch series adds that optimization.  
> >>> Right that's what I think we should rather avoid for now.
> >>>
> >>> It's *not* an optimization if there's a single VM on this host,
> >>> or if a specific multicast group does not have any VMs on same
> >>> host.  
> >> Agreed. In my mind this is something that is controlled by the
> >> pass-thru interface once it is enslaved.  
> > It would be pretty tricky to control through the PT
> > interface since a PT interface pretends to be a physical
> > device, which has no concept of VMs.
> >  
> >>> I'd rather we just sent everything out on the PT if that's
> >>> there. The reason we have virtio in the picture is just so
> >>> we can migrate without downtime.  
> >> I wasn't saying we do that in all cases. That would be something that
> >> would have to be decided by the pass-thru interface. Ideally the
> >> virtio would provide just enough information to get itself into the
> >> bond and I see this being the mechanism for it to do so. From there
> >> the complexity mostly lies in the pass-thru interface to configure the
> >> correct transmit modes if for example you have multiple pass-thru
> >> interfaces or a more complex traffic setup due to things like
> >> SwitchDev.
> >>
> >> In my mind we go the bonding route and there are few use cases for all
> >> of this. First is the backup case that is being addressed here. That
> >> becomes your basic "copy netvsc" approach for this which would be
> >> default. It is how we would handle basic pass-thru back-up paths. If
> >> the host decides to send multicast/broadcast traffic from the host up
> >> through it that is a host side decision. I am okay with our default
> >> transmit behavior from the guest being to send everything through the
> >> pass-thru interface. All the virtio would be doing is advertising that
> >> it is a side channel for some sort of bond with another interface. By
> >> calling it a side channel it implies that it isn't the direct channel
> >> for the interface, but it is an alternative communications channel for
> >> things like backup, and other future uses.
> >>
> >> There end up being a few different "phase 2" concepts I have floating
> >> around which I want to avoid limiting. Solving the east/west problem
> >> is an example. In my mind that just becomes a bonding Tx mode that is
> >> controlled via the pass-thru interface. The VF could black-list the
> >> local addresses so that they instead fall into the virtio interface.
> >> In addition I seem to recall watching a presentation from Mellanox
> >> where they were talking about a VF per NUMA node in a system which
> >> would imply multiple VFs with the same MAC address. I'm not sure how
> >> the current patch handles that. Obviously that would require a more
> >> complex load balancing setup. The bonding solution ends up being a way
> >> to resolve that so that they could just have it take care of picking
> >> the right Tx queue based on the NUMA affinity and fall back to the
> >> virtio/netvsc when those fail.  
> > The way I see it, we'd need to pass a bunch of extra information
> > host to guest, and we'd have to use a PV interface for it.
> > When we do this, we'll need to have another
> > feature bit, and we can call it SIDE_CHANNEL or whatever.
> >
> >  
> >>>> In the receive path,  the broadcasts should only go the PF and reach the VM
> >>>> via vitio so that the VM doesn't see duplicate broadcasts.
> >>>>
> >>>>  
> >>>>> To me the east/west scenario looks like you want something
> >>>>> more similar to a bridge on top of the virtio/PT pair.
> >>>>>
> >>>>> So I suspect that use-case will need a separate configuration bit,
> >>>>> and possibly that's when you will want something more powerful
> >>>>> such as a full bridge.  
> >>>> east-west optimization of unicasts would be a harder problem to solve as
> >>>> somehow the hypervisor needs to indicate the VM about the local dest. macs  
> >>> Using a bridge with a dedicated device for east/west would let
> >>> bridge use standard learning techniques for that perhaps?  
> >> I'm not sure about having the guest have to learn.  
> > It's certainly a way to do this, but certainly not the only one.
> >  
> >> In my mind the VF
> >> should know who is local and who isn't.  
> > Right. But note that these things change.
> >  
> >> In the case of SwitchDev it
> >> should be possible for the port representors and the switch to provide
> >> data on which interfaces are bonded on the host side and which aren't.
> >> With that data it would be pretty easy to just put together a list of
> >> addresses that would prefer to go the para-virtual route instead of
> >> being transmitted through physical hardware.
> >>
> >> In addition a bridge implies much more overhead since normally a
> >> bridge can receive a packet in on one interface and transmit it on
> >> another. We don't really need that. This is more of a VEPA type setup
> >> and doesn't need to be anything all that complex. You could probably
> >> even handle the Tx queue selection via a simple eBPF program and map
> >> since the input for whatever is used to select Tx should be pretty
> >> simple, destination MAC, source NUMA node, etc, and the data-set
> >> shouldn't be too large.  
> > That sounds interesting. A separate device might make this kind of setup
> > a bit easier.  Sridhar, did you look into creating a separate device for
> > the virtual bond device at all?  It does not have to be in a separate
> > module, that kind of refactoring can come later, but once we commit to
> > using the same single device as virtio, we can't change that.  
> 
> No. I haven't looked into creating a separate device. If we are going to 
> create a new
> device, i guess it has to be of a new device type with its own driver.
> 
> As we are using virtio_net to control and manage the VF data path, it is 
> not clear to me
> what is the advantage of creating a new device rather than extending 
> virtio_net to manage
> the VF datapath via transparent bond mechanism.
> 
> Thanks
> Sridhar
> 
> 

The requirement with Azure accelerated network was that a stock distribution image from the
store must be able to run unmodified and get accelerated networking.
Not sure if other environments need to work the same, but it would be nice.

That meant no additional setup scripts (aka no bonding) and also it must
work transparently with hot-plug. Also there are diverse set of environments:
openstack, cloudinit, network manager and systemd. The solution had to not depend
on any one of them, but also not break any of them.

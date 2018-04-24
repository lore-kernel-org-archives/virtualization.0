From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Tue, 24 Apr 2018 04:42:22 +0300
Message-ID: <20180424043042-mutt-send-email-mst__34304.6559523374$1524534045$gmane$org@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
	<20180420160058.GB2150@nanopsycho.orion>
	<20180423100406.71b95f74@xeon-e3>
	<20180423202204-mutt-send-email-mst@kernel.org>
	<20180423104440.2fe6cfd2@xeon-e3>
	<20180423205019-mutt-send-email-mst@kernel.org>
	<CADGSJ20ge75T+ddxtUBT4d9m1i3=HLOAHJEoS7Cg0bqnXrutwA@mail.gmail.com>
	<20180423182503.353180c9@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180423182503.353180c9@xeon-e3>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 23, 2018 at 06:25:03PM -0700, Stephen Hemminger wrote:
> On Mon, 23 Apr 2018 12:44:39 -0700
> Siwei Liu <loseweigh@gmail.com> wrote:
> 
> > On Mon, Apr 23, 2018 at 10:56 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Mon, Apr 23, 2018 at 10:44:40AM -0700, Stephen Hemminger wrote:  
> > >> On Mon, 23 Apr 2018 20:24:56 +0300
> > >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >>  
> > >> > On Mon, Apr 23, 2018 at 10:04:06AM -0700, Stephen Hemminger wrote:  
> > >> > > > >
> > >> > > > >I will NAK patches to change to common code for netvsc especially the
> > >> > > > >three device model.  MS worked hard with distro vendors to support transparent
> > >> > > > >mode, ans we really can't have a new model; or do backport.
> > >> > > > >
> > >> > > > >Plus, DPDK is now dependent on existing model.  
> > >> > > >
> > >> > > > Sorry, but nobody here cares about dpdk or other similar oddities.  
> > >> > >
> > >> > > The network device model is a userspace API, and DPDK is a userspace application.  
> > >> >
> > >> > It is userspace but are you sure dpdk is actually poking at netdevs?
> > >> > AFAIK it's normally banging device registers directly.
> > >> >  
> > >> > > You can't go breaking userspace even if you don't like the application.  
> > >> >
> > >> > Could you please explain how is the proposed patchset breaking
> > >> > userspace? Ignoring DPDK for now, I don't think it changes the userspace
> > >> > API at all.
> > >> >  
> > >>
> > >> The DPDK has a device driver vdev_netvsc which scans the Linux network devices
> > >> to look for Linux netvsc device and the paired VF device and setup the
> > >> DPDK environment.  This setup creates a DPDK failsafe (bondingish) instance
> > >> and sets up TAP support over the Linux netvsc device as well as the Mellanox
> > >> VF device.
> > >>
> > >> So it depends on existing 2 device model. You can't go to a 3 device model
> > >> or start hiding devices from userspace.  
> > >
> > > Okay so how does the existing patch break that? IIUC does not go to
> > > a 3 device model since netvsc calls failover_register directly.
> > >  
> > >> Also, I am working on associating netvsc and VF device based on serial number
> > >> rather than MAC address. The serial number is how Windows works now, and it makes
> > >> sense for Linux and Windows to use the same mechanism if possible.  
> > >
> > > Maybe we should support same for virtio ...
> > > Which serial do you mean? From vpd?
> > >
> > > I guess you will want to keep supporting MAC for old hypervisors?
> 
> The serial number has always been in the hypervisor since original support of SR-IOV
> in WS2008.  So no backward compatibility special cases would be needed.

Is that a serial from real hardware or a hypervisor thing?


-- 
MST

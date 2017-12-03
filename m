From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-net: help live migrate SR-IOV devices
Date: Sun, 3 Dec 2017 07:05:12 +0200
Message-ID: <20171203065759-mutt-send-email-mst@kernel.org>
References: <20171128112722.00003716@intel.com>
	<0fb552d4-1bfc-e130-4fc1-87b83873916d@redhat.com>
	<CAEHy93LneRXNWo64uyN2dfyDX6t18WN+YwVF2RXXLRnr0=Jhww@mail.gmail.com>
	<20171130155612-mutt-send-email-mst@kernel.org>
	<780cf854-83e1-b2a4-0f07-74372a972ca6@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <780cf854-83e1-b2a4-0f07-74372a972ca6@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Shannon Nelson <shannon.nelson@oracle.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Hannes Frederic Sowa <hannes@redhat.com>, achiad shochat <achiad.mellanox@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Achiad <achiad@mellanox.com>, Peter Waskiewicz Jr <peter.waskiewicz.jr@intel.com>, "Singhai,
	Anjali" <anjali.singhai@intel.com>, Andy Gospodarek <gospo@broadcom.com>, Or Gerlitz <gerlitz.or@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Dec 01, 2017 at 12:08:59PM -0800, Shannon Nelson wrote:
> On 11/30/2017 6:11 AM, Michael S. Tsirkin wrote:
> > On Thu, Nov 30, 2017 at 10:08:45AM +0200, achiad shochat wrote:
> > > Re. problem #2:
> > > Indeed the best way to address it seems to be to enslave the VF driver
> > > netdev under a persistent anchor netdev.
> > > And it's indeed desired to allow (but not enforce) PV netdev and VF
> > > netdev to work in conjunction.
> > > And it's indeed desired that this enslavement logic work out-of-the box.
> > > But in case of PV+VF some configurable policies must be in place (and
> > > they'd better be generic rather than differ per PV technology).
> > > For example - based on which characteristics should the PV+VF coupling
> > > be done? netvsc uses MAC address, but that might not always be the
> > > desire.
> > 
> > It's a policy but not guest userspace policy.
> > 
> > The hypervisor certainly knows.
> > 
> > Are you concerned that someone might want to create two devices with the
> > same MAC for an unrelated reason?  If so, hypervisor could easily set a
> > flag in the virtio device to say "this is a backup, use MAC to find
> > another device".
> 
> This is something I was going to suggest: a flag or other configuration on
> the virtio device to help control how this new feature is used.  I can
> imagine this might be useful to control from either the hypervisor side or
> the VM side.
> 
> The hypervisor might want to (1) disable it (force it off), (2) enable it
> for VM choice, or (3) force it on for the VM.  In case (2), the VM might be
> able to chose whether it wants to make use of the feature, or stick with the
> bonding solution.
> 
> Either way, the kernel is making a feature available, and the user (VM or
> hypervisor) is able to control it by selecting the feature based on the
> policy desired.
> 
> sln

I'm not sure what's the feature that is available here.

I saw this as a flag that says "this device shares backend with another
network device which can be found using MAC, and that backend should be
preferred".  kernel then forces configuration which uses that other
backend - as long as it exists.

However, please Cc virtio-dev mailing list if we are doing this since
this is a spec extension.

-- 
MST

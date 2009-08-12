From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 0/2] vhost: a kernel-level virtio server
Date: Wed, 12 Aug 2009 17:02:24 +0300
Message-ID: <20090812140224.GA29345__35105.4973937154$1250086080$gmane$org@redhat.com>
References: <20090811212743.GA26309@redhat.com>
	<200908121452.01802.arnd@arndb.de>
	<20090812130612.GC29200@redhat.com>
	<200908121540.44928.arnd@arndb.de> <4A82C8F1.4030703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A82C8F1.4030703@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, Patrick Mullaney <pmullaney@novell.com>, mingo@elte.hu, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 12, 2009 at 09:51:45AM -0400, Gregory Haskins wrote:
> Arnd Bergmann wrote:
> > On Wednesday 12 August 2009, Michael S. Tsirkin wrote:
> >>> If I understand it correctly, you can at least connect a veth pair
> >>> to a bridge, right? Something like
> >>>
> >>>            veth0 - veth1 - vhost - guest 1 
> >>> eth0 - br0-|
> >>>            veth2 - veth3 - vhost - guest 2
> >>>            
> >> Heh, you don't need a bridge in this picture:
> >>
> >> guest 1 - vhost - veth0 - veth1 - vhost guest 2
> > 
> > Sure, but the setup I described is the one that I would expect
> > to see in practice because it gives you external connectivity.
> > 
> > Measuring two guests communicating over a veth pair is
> > interesting for finding the bottlenecks, but of little
> > practical relevance.
> > 
> > 	Arnd <><
> 
> Yeah, this would be the config I would be interested in.

Hmm, this wouldn't be the config to use for the benchmark though: there
are just too many variables.  If you want both guest to guest and guest
to host, create 2 nics in the guest.

Here's one way to do this:

	-net nic,model=virtio,vlan=0 -net user,vlan=0
	-net nic,vlan=1,model=virtio,vhost=veth0
	-redir tcp:8022::22

	-net nic,model=virtio,vlan=0 -net user,vlan=0
	 -net nic,vlan=1,model=virtio,vhost=veth1
	-redir tcp:8023::22

In guests, for simplicity, configure eth1 and eth0
to use separate subnets.

Long term, I hope macvlan will be extended to support
guest to guest.

> Regards,
> -Greg
> 

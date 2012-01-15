From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost-net: add module alias (v2.1)
Date: Sun, 15 Jan 2012 14:42:36 +0200
Message-ID: <20120115124236.GA31012__3094.48785051263$1326634699$gmane$org@redhat.com>
References: <20120111091653.188b24ab@nehalam.linuxnetplumber.net>
	<CAEH94LiF_F51_avA9UWMneo1N1wY0NzJmfohpxdrkAv2WkWT5Q@mail.gmail.com>
	<20120111213038.39213819@nehalam.linuxnetplumber.net>
	<20120112.200701.1473475851890804136.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120112.200701.1473475851890804136.davem@davemloft.net>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, kay.sievers@vrfy.org, virtualization@lists.linux-foundation.org, shemminger@vyatta.com, device@lanana.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 08:07:01PM -0800, David Miller wrote:
> From: Stephen Hemminger <shemminger@vyatta.com>
> Date: Wed, 11 Jan 2012 21:30:38 -0800
> 
> > Subject: vhost-net: add module alias (v2.1)
> > 
> > By adding some module aliases, programs (or users) won't have to explicitly
> > call modprobe. Vhost-net will always be available if built into the kernel.
> > It does require assigning a permanent minor number for depmod to work.
> > 
> > Also:
> >   - use C99 style initialization.
> >   - add missing entry in documentation for loop-control
> > 
> > Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> ACKs, NACKs?  What is happening here?

I would like an Ack from Alan Cox who switched vhost-net
to a dynamic minor in the first place, in commit
79907d89c397b8bc2e05b347ec94e928ea919d33.

-- 
MST

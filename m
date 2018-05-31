From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v12 2/5] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Thu, 31 May 2018 20:34:03 +0300
Message-ID: <20180531203301-mutt-send-email-mst__27766.8771720075$1527787945$gmane$org@kernel.org>
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
	<1527180917-39737-3-git-send-email-sridhar.samudrala@intel.com>
	<20180530220635.206ee6d7@shemminger-XPS-13-9360>
	<274f0b84-07f1-5cd5-e256-ce4b71358c14@intel.com>
	<20180531085812.0b13afef@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180531085812.0b13afef@shemminger-XPS-13-9360>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 31, 2018 at 08:58:12AM -0400, Stephen Hemminger wrote:
> On Wed, 30 May 2018 20:03:11 -0700
> "Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:
> 
> > On 5/30/2018 7:06 PM, Stephen Hemminger wrote:
> > > On Thu, 24 May 2018 09:55:14 -0700
> > > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> > >  
> > >> Use the registration/notification framework supported by the generic
> > >> failover infrastructure.
> > >>
> > >> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>  
> > > Why was this merged? It was never signed off by any of the netvsc maintainers,
> > > and there were still issues unresolved.
> > >
> > > There are also namespaces issues I am fixing and this breaks them.
> > > Will start my patch set with a revert for this. Sorry  
> > 
> > I would appreciate if you can make the fixes on top of this patch series. I tried hard
> > to make sure that netvsc functionality and behavior doesn't change.
> > 
> > It is possible that there could be some bugs introduced, but they can be fixed.
> > Looks like Wei already found a bug and submitted a fix for that.
> > 
> 
> Ok, but several of these may clash with what you want for virtio.
> Like:
> 	- VF should be moved to namespace of virt device
> 	- VF should be associated based on message from host with serial # not
> 	  registration notifier and MAC address.
> 	- control operations should use master device reference rather than
> 	  searching based on MAC.
> 
> As you can see these are structural changes.

We might want to do these for virtio as well, at least as
an option.

-- 
MST

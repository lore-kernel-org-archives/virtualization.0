From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next v6 4/4] netvsc: refactor notifier/event
	handling code to use the bypass framework
Date: Wed, 11 Apr 2018 04:21:20 +0300
Message-ID: <20180411041901-mutt-send-email-mst__15989.8298363716$1523409583$gmane$org@kernel.org>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
	<20180410142608.50f15b45@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180410142608.50f15b45@xeon-e3>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 10, 2018 at 02:26:08PM -0700, Stephen Hemminger wrote:
> On Tue, 10 Apr 2018 11:59:50 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> 
> > Use the registration/notification framework supported by the generic
> > bypass infrastructure.
> > 
> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > ---
> 
> Thanks for doing this.  Your current version has couple show stopper
> issues.
> 
> First, the slave device is instantly taking over the slave.
> This doesn't allow udev/systemd to do its device rename of the slave
> device. Netvsc uses a delayed work to workaround this.
> 
> Secondly, the select queue needs to call queue selection in VF.
> The bonding/teaming logic doesn't work well for UDP flows.
> Commit b3bf5666a510 ("hv_netvsc: defer queue selection to VF")
> fixed this performance problem.
> 
> Lastly, more indirection is bad in current climate.

Well right now netvsc does an indirect call to the PT device,
does it not? If you really want max performance when PT
is in use you need to do the reverse and have PT forward to netvsc.

> I am not completely adverse to this but it needs to be fast, simple
> and completely transparent.

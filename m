From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH net-next v6 4/4] netvsc: refactor notifier/event
	handling code to use the bypass framework
Date: Tue, 10 Apr 2018 16:59:36 -0700
Message-ID: <20180410165936.0faf9080@xeon-e3>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
	<20180410142608.50f15b45@xeon-e3>
	<20180411022807-mutt-send-email-mst@kernel.org>
	<CADGSJ22rVsC0TDTd6OKVnwbx0ExoQ8xWXBMumKB-OFH4sX=yaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ22rVsC0TDTd6OKVnwbx0ExoQ8xWXBMumKB-OFH4sX=yaQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Apr 2018 16:44:47 -0700
Siwei Liu <loseweigh@gmail.com> wrote:

> On Tue, Apr 10, 2018 at 4:28 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Apr 10, 2018 at 02:26:08PM -0700, Stephen Hemminger wrote:  
> >> On Tue, 10 Apr 2018 11:59:50 -0700
> >> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
> >>  
> >> > Use the registration/notification framework supported by the generic
> >> > bypass infrastructure.
> >> >
> >> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> >> > ---  
> >>
> >> Thanks for doing this.  Your current version has couple show stopper
> >> issues.
> >>
> >> First, the slave device is instantly taking over the slave.
> >> This doesn't allow udev/systemd to do its device rename of the slave
> >> device. Netvsc uses a delayed work to workaround this.  
> >
> > Interesting. Does this mean udev must act within a specific time window
> > then?  
> 
> Sighs, lots of hacks. Why propgating this from driver to a common
> module. We really need a clean solution.
> 

I had a patch to wait for udev to do the rename and go from there
but davem rejected it.

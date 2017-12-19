From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Tue, 19 Dec 2017 11:46:27 -0800
Message-ID: <20171219114627.76dac732__37551.9957430244$1513712721$gmane$org@xeon-e3>
References: <20171219174259-mutt-send-email-mst@kernel.org>
	<ca709329-a47a-2e76-b1fc-38fc665d7c0b@intel.com>
	<20171219095548.61d70d10@xeon-e3>
	<20171219.132117.666798483874609477.davem@davemloft.net>
	<20171219104159.30d9caaf@xeon-e3>
	<344f0afc-b4aa-9f1a-15b8-166ba97d270b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <344f0afc-b4aa-9f1a-15b8-166ba97d270b@intel.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 19 Dec 2017 11:42:33 -0800
"Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:

> On 12/19/2017 10:41 AM, Stephen Hemminger wrote:
> > On Tue, 19 Dec 2017 13:21:17 -0500 (EST)
> > David Miller <davem@davemloft.net> wrote:
> >  
> >> From: Stephen Hemminger <stephen@networkplumber.org>
> >> Date: Tue, 19 Dec 2017 09:55:48 -0800
> >>  
> >>> could be 10ms, just enough to let udev do its renaming  
> >> Please, move to some kind of notification or event based handling of
> >> this problem.
> >>
> >> No delay is safe, what if userspace gets swapped out or whatever
> >> else might make userspace stall unexpectedly?
> >>  
> > The plan is to remove the delay and do the naming in the kernel.
> > This was suggested by Lennart since udev is only doing naming policy
> > because kernel names were not repeatable.
> >
> > This makes the VF show up as "ethN_vf" on Hyper-V which is user friendly.
> >
> > Patch is pending.  
> Do we really need to delay the setup until the name is changed?
> Can't we call dev_set_mtu() and dev_open() until dev_change_name() is done?
> 
> Thanks
> Sridhar

You can call dev_set_mtu, but when dev_open is done the device name
can not be changed by userspace.

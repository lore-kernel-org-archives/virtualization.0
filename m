From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v11 2/5] netvsc: refactor notifier/event
	handling code to use the failover framework
Date: Tue, 22 May 2018 22:54:35 +0300
Message-ID: <20180522204216-mutt-send-email-mst__22292.1869754375$1527018785$gmane$org@kernel.org>
References: <20180522161007-mutt-send-email-mst@kernel.org>
	<20180522131422.GG2149@nanopsycho>
	<20180522161509-mutt-send-email-mst@kernel.org>
	<20180522132626.GH2149@nanopsycho>
	<20180522163502-mutt-send-email-mst@kernel.org>
	<20180522151343.GJ2149@nanopsycho>
	<20180522181804-mutt-send-email-mst@kernel.org>
	<20180522154501.GL2149@nanopsycho>
	<20180522194633-mutt-send-email-mst@kernel.org>
	<20180522173844.GP2149@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180522173844.GP2149@nanopsycho>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 22, 2018 at 07:38:44PM +0200, Jiri Pirko wrote:
> >> >> In private
> >> >> flag. I don't see no reason to break this pattern here.
> >> >
> >> >Other masters are setup from userspace, this one is set up automatically
> >> >by kernel. So the bar is higher, we need an interface that existing
> >> >userspace knows about.  We can't just say "oh if userspace set this up
> >> >it should know to skip lowerdevs".
> >> >
> >> >Otherwise multiple interfaces with same mac tend to confuse userspace.
> >> 
> >> No difference, really.
> >> Regardless who does the setup, and independent userspace deamon should
> >> react accordingly.
> >
> >If the deamon does the setup itself, it's reasonable to require that it
> >learns about new flags each time we add a new driver.  If it doesn't,
> >then I think it's less reasonable.
> 
> No need. The "IFLA_MASTER" attr is always there to be looked at. That is
> enough.

Oh so if it has an master, skip it? Sorry, I misunderstood what you were
saying earlier.

Thanks, this makes sense to me.

-- 
MST

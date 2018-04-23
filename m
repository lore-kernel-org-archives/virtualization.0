From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 net-next 4/4] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Mon, 23 Apr 2018 20:24:56 +0300
Message-ID: <20180423202204-mutt-send-email-mst__4198.96972966871$1524504183$gmane$org@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-5-git-send-email-sridhar.samudrala@intel.com>
	<20180420082802.6ca37e4c@xeon-e3>
	<20180420160058.GB2150@nanopsycho.orion>
	<20180423100406.71b95f74@xeon-e3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180423100406.71b95f74@xeon-e3>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, Jiri Pirko <jiri@resnulli.us>, kubakici@wp.pl, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 23, 2018 at 10:04:06AM -0700, Stephen Hemminger wrote:
> > >
> > >I will NAK patches to change to common code for netvsc especially the
> > >three device model.  MS worked hard with distro vendors to support transparent
> > >mode, ans we really can't have a new model; or do backport.
> > >
> > >Plus, DPDK is now dependent on existing model.  
> > 
> > Sorry, but nobody here cares about dpdk or other similar oddities.
> 
> The network device model is a userspace API, and DPDK is a userspace application.

It is userspace but are you sure dpdk is actually poking at netdevs?
AFAIK it's normally banging device registers directly.

> You can't go breaking userspace even if you don't like the application.

Could you please explain how is the proposed patchset breaking
userspace? Ignoring DPDK for now, I don't think it changes the userspace
API at all.

-- 
MST

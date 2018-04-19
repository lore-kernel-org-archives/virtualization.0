From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next v6 2/4] net: Introduce generic bypass module
Date: Thu, 19 Apr 2018 07:08:58 +0300
Message-ID: <20180419070752-mutt-send-email-mst__1721.65464978224$1524110839$gmane$org@kernel.org>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-3-git-send-email-sridhar.samudrala@intel.com>
	<20180411155127.GQ2028@nanopsycho>
	<6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
	<20180418092515.GB1989@nanopsycho>
	<dd0d53f0-f5da-cb7d-f8f6-d0c8245eb3cf@intel.com>
	<20180418191315.GA1922@nanopsycho>
	<20180418222309-mutt-send-email-mst@kernel.org>
	<20180418203206.GC1922@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180418203206.GC1922@nanopsycho>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, kubakici@wp.pl, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, netdev@vger.kernel.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 18, 2018 at 10:32:06PM +0200, Jiri Pirko wrote:
> >> >> > With regards to alternate names for 'active', you suggested 'stolen', but i
> >> >> > am not too happy with it.
> >> >> > netvsc uses vf_netdev, are you OK with this? Or another option is 'passthru'
> >> >> No. The netdev could be any netdevice. It does not have to be a "VF".
> >> >> I think "stolen" is quite appropriate since it describes the modus
> >> >> operandi. The bypass master steals some netdevice according to some
> >> >> match.
> >> >> 
> >> >> But I don't insist on "stolen". Just sounds right.
> >> >
> >> >We are adding VIRTIO_NET_F_BACKUP as a new feature bit to enable this feature, So i think
> >> >'backup' name is consistent.
> >> 
> >> It perhaps makes sense from the view of virtio device. However, as I
> >> described couple of times, for master/slave device the name "backup" is
> >> highly misleading.
> >
> >virtio is the backup. You are supposed to use another
> >(typically passthrough) device, if that fails use virtio.
> >It does seem appropriate to me. If you like, we can
> >change that to "standby".  Active I don't like either. "main"?
> 
> Sounds much better, yes.

Excuse me, which of the versions are better in your eyes?


> 
> >
> >In fact would failover be better than bypass?
> 
> Also, much better.
> 

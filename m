From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Tue, 23 Jan 2018 11:21:33 -0800
Message-ID: <20180123112133.688379d7__35786.2743702301$1516735212$gmane$org@cakuba.netronome.com>
References: <20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
	<20180123020332-mutt-send-email-mst@kernel.org>
	<20180122161623.22b6e151@cakuba.netronome.com>
	<20180123023810-mutt-send-email-mst@kernel.org>
	<20180122171301.3463156b@cakuba.netronome.com>
	<20180123031348-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180123031348-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, achiad shochat <achiad.mellanox@gmail.com>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Achiad Shochat <achiad@mellanox.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 23 Jan 2018 03:23:57 +0200, Michael S. Tsirkin wrote:
> > > > b. next-gen silicon may be able to disguise as virtio device, and the
> > > >    loop check in virtio driver will prevent the legitimate bond it such
> > > >    case.  AFAIU that's one of the goals of next-gen virtio spec as well.    
> > > 
> > > In fact we have a virtio feature bit for the fallback.
> > > So this part does not depend on how software in guest works
> > > and does not need software solutions.  
> > 
> > You mean in the new spec?  Nice.  Still I think people will try to
> > implement the old one too given sufficiently capable HW.  
> 
> Existing HW won't have the BACKUP feature so the new functionality
> won't be activated. So no problem I think.

I meant code that compares of netdev_ops, e.g.:

+	/* Skip our own events */
+	if (event_dev->netdev_ops == &virtnet_netdev)
+		return NOTIFY_DONE;

Would be an obstacle to bonding virtio_nets.  But that's just one of
the thoughts, perhaps of disputable value.  Anyway, separate netdev and
netdev_ops will solve this, and I think we agree that's preferable :)

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Mon, 25 Feb 2019 21:05:24 -0500
Message-ID: <20190225210428-mutt-send-email-mst__46168.0453432322$1551147180$gmane$org@kernel.org>
References: <20180410142608.50f15b45@xeon-e3>
	<20180411075334.GK2028@nanopsycho>
	<CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
	<20190221203808-mutt-send-email-mst@kernel.org>
	<581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
	<91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
	<d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
	<20190222100753-mutt-send-email-mst@kernel.org>
	<e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
	<20190225173912.26b93422@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190225173912.26b93422@shemminger-XPS-13-9360>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 25, 2019 at 05:39:12PM -0800, Stephen Hemminger wrote:
> > >>> Moreover, you were suggesting hiding the lower slave devices anyway. There was some discussion
> > >>> about moving them to a hidden network namespace so that they are not visible from the default namespace.
> > >>> I looked into this sometime back, but did not find the right kernel api to create a network namespace within
> > >>> kernel. If so, we could use this mechanism to simulate a 1-netdev model.  
> > >> Yes, that's one possible implementation (IMHO the key is to make 1-netdev
> > >> model as much transparent to a real NIC as possible, while a hidden netns is
> > >> just the vehicle). However, I recall there was resistance around this
> > >> discussion that even the concept of hiding itself is a taboo for Linux
> > >> netdev. I would like to summon potential alternatives before concluding
> > >> 1-netdev is the only solution too soon.
> > >>
> > >> Thanks,
> > >> -Siwei  
> > > Your scripts would not work at all then, right?  
> > At this point we don't claim images with such usage as SR-IOV live 
> > migrate-able. We would flag it as live migrate-able until this ethtool 
> > config issue is fully addressed and a transparent live migration 
> > solution emerges in upstream eventually.
> 
> The hyper-v netvsc with 1-dev model uses a timeout to allow  udev to do its rename.
> I proposed a patch to key state change off of the udev rename, but that patch was
> rejected.

Of course that would mean nothing works without udev - was
that the objection? Could you help me find that discussion pls?

-- 
MST

From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Wed, 27 Feb 2019 16:52:05 -0800
Message-ID: <20190227165205.307ed83c__41780.6848113955$1551316156$gmane$org@cakuba.netronome.com>
References: <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
	<d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
	<20190222100753-mutt-send-email-mst@kernel.org>
	<e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
	<20190225210529-mutt-send-email-mst@kernel.org>
	<d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
	<20190227173710-mutt-send-email-mst@kernel.org>
	<c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
	<20190227184601-mutt-send-email-mst@kernel.org>
	<a617ce13-4114-469d-ef33-a1c91150eeca@oracle.com>
	<20190227193923-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190227193923-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 27 Feb 2019 19:41:32 -0500, Michael S. Tsirkin wrote:
> > As this scheme adds much complexity to the kernel naming convention
> > (currently it's just ethX names) that no userspace can understand.  
> 
> Anything that pokes at slaves needs to be specially designed anyway.
> Naming seems like a minor issue.

Can the users who care about the naming put net_failover into
"user space will do the bond enslavement" mode, and do the bond
creation/management themselves from user space (in systemd/ 
Network Manager) based on the failover flag?

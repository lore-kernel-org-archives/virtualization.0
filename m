From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next] virtio_net: add gro capability
Date: Sun, 2 Aug 2015 11:48:35 +0300
Message-ID: <20150802114823-mutt-send-email-mst__15347.5416395397$1438505332$gmane$org@redhat.com>
References: <1438359917.2748.18.camel@edumazet-glaptop2.roam.corp.google.com>
	<20150731.165732.2136164140565390142.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150731.165732.2136164140565390142.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, rick.jones2@hp.com, eric.dumazet@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 31, 2015 at 04:57:32PM -0700, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Fri, 31 Jul 2015 18:25:17 +0200
> 
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > Straightforward patch to add GRO processing to virtio_net.
> > 
>  ...
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Tested-by: Rick Jones <rick.jones2@hp.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Michael, please review :-)

Will do shortly :)

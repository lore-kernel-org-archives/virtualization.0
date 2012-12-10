From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv6] virtio-spec: virtio network device multiqueue support
Date: Mon, 10 Dec 2012 12:36:07 +0200
Message-ID: <20121210103606.GA26168__23193.5739437633$1355135604$gmane$org@redhat.com>
References: <20121207141856.GA17901@redhat.com>
	<87ip8aeqi7.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ip8aeqi7.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: bhutchings@solarflare.com, netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 10, 2012 at 10:18:32AM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > Add multiqueue support to virtio network device.
> > Add a new feature flag VIRTIO_NET_F_MQ for this feature, a new
> > configuration field max_virtqueue_pairs to detect supported number of
> > virtqueues as well as a new command VIRTIO_NET_CTRL_MQ to program
> > packet steering for unidirectional protocols.
> 
> One trivial change: alter "8000h" to "0x8000" for consistency in the
> text.
> 
> Could I have a Signed-off-by so I can apply it please?
> 
> Thanks,
> Rusty.

Right away.

-- 
MST

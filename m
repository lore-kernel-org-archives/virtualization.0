From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next V2 0/8] Packed virtqueue support for vhost
Date: Sun, 22 Jul 2018 19:56:43 +0300
Message-ID: <20180722194843-mutt-send-email-mst__37651.5693068088$1532278489$gmane$org@kernel.org>
References: <1531711691-6769-1-git-send-email-jasowang@redhat.com>
	<20180716113720-mutt-send-email-mst@kernel.org>
	<33f4643f-f226-0389-1f4f-607c289db94e@redhat.com>
	<20180716154102-mutt-send-email-mst@kernel.org>
	<5ba5c927-a0b4-f399-7a88-b90763765142@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5ba5c927-a0b4-f399-7a88-b90763765142@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com, wexu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2018 at 08:45:16AM +0800, Jason Wang wrote:
> > I'm not sure I understand this approach. Packed ring is just an optimization.
> > What value is there in merging it if it does not help speed?
> 
> If you want to support migration from dpdk or vDPA backend.

Migration from dpdk is a mess: if you add new features you
fix migration from new one but break migration from old one.
So I'm not too worried until dpdk guys implement one of
the migration versioning proposals that have been floating
around for years.

I think vDPAs are using split ring right now. They will likely
switch to packed ring in the future, but it will probably
take some time before they do.

> And we still
> have the chance to see the performance with virito-net pmd in the future. If
> this does not make sense for you, I will leave this series until we can get
> results from virtio-net pmd (or find a way that packed virtqueue
> outperform).

This makes sense to me. If there's a gain that is only
observed with the pmd driver, I think that's still fine,
but we do need to see it.

> And I will start to post other optimizations on vhost.
> 
> Thanks

Thanks a lot!

-- 
MST

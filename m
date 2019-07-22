From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
	throughput
Date: Mon, 22 Jul 2019 11:14:34 +0200
Message-ID: <20190722091434.tzf7lxw3tvrs5w5v__31136.4468697988$1563786896$gmane$org@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
	<20190722090835.GF24934@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190722090835.GF24934@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 22, 2019 at 10:08:35AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 17, 2019 at 01:30:25PM +0200, Stefano Garzarella wrote:
> > This series tries to increase the throughput of virtio-vsock with slight
> > changes.
> > While I was testing the v2 of this series I discovered an huge use of memory,
> > so I added patch 1 to mitigate this issue. I put it in this series in order
> > to better track the performance trends.
> > 
> > v4:
> > - rebased all patches on current master (conflicts is Patch 4)
> > - Patch 1: added Stefan's R-b
> > - Patch 3: removed lock when buf_alloc is written [David];
> >            moved this patch after "vsock/virtio: reduce credit update messages"
> >            to make it clearer
> > - Patch 4: vhost_exceeds_weight() is recently introduced, so I've solved some
> >            conflicts
> 
> Stefano: Do you want to continue experimenting before we merge this
> patch series?  The code looks functionally correct and the performance
> increases, so I'm happy for it to be merged.

I think we can merge this series.

I'll continue to do other experiments (e.g. removing TX workers, allocating
pages, etc.) but I think these changes are prerequisites for the other patches,
so we can merge them.

Thank you very much for the reviews!
Stefano

From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Date: Wed, 11 Sep 2019 17:25:04 +0100
Message-ID: <20190911162503.em2ytox2iq5wdp3z__14071.0601162695$1568219124$gmane$org@willie-the-truck>
References: <20190911120908.28410-1-mst@redhat.com>
	<20190911095147-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190911095147-mutt-send-email-mst@kernel.org>
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
Cc: security@kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 11, 2019 at 09:52:25AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 11, 2019 at 08:10:00AM -0400, Michael S. Tsirkin wrote:
> > iovec addresses coming from vhost are assumed to be
> > pre-validated, but in fact can be speculated to a value
> > out of range.
> > 
> > Userspace address are later validated with array_index_nospec so we can
> > be sure kernel info does not leak through these addresses, but vhost
> > must also not leak userspace info outside the allowed memory table to
> > guests.
> > 
> > Following the defence in depth principle, make sure
> > the address is not validated out of node range.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Tested-by: Jason Wang <jasowang@redhat.com>
> > ---
> 
> Cc: security@kernel.org
> 
> Pls advise on whether you'd like me to merge this directly,
> Cc stable, or handle it in some other way.

I think you're fine taking it directly, with a cc stable and a Fixes: tag.

Cheers,

Will

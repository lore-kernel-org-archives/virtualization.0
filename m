From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-spec: clarify ro/rw bits and updating rule of
	virtio-net status field
Date: Wed, 21 Mar 2012 00:48:05 +0200
Message-ID: <20120320224805.GA4997@redhat.com>
References: <20120320062020.12815.61342.stgit@jason-ThinkPad-T400>
	<87ty1jpm6p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ty1jpm6p.fsf@rustcorp.com.au>
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
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 20, 2012 at 09:35:18PM +1030, Rusty Russell wrote:
> On Tue, 20 Mar 2012 14:20:21 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > This patch clarifies VIRTIO_NET_S_LINK_UP as a read-only bit and
> > VIRTIO_NET_S_ANNOUNCE as a read-writable bit. Also introduce the write 1 to
> > clear semantics for all read-writable bits of config status field. This could
> > help to reduce the config status field updating race between host and guest and
> > also simplify the implementation.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> This approach assumes an active config field, which neither lguest nor
> S/390 have.
> 
> Thanks,
> Rusty.

What does 'active' mean in this context?

> -- 
>   How could I marry someone with more hair than me?  http://baldalex.org

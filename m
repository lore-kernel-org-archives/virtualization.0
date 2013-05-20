From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2 V4] virtio-spec: dynamic network offloads configuration
Date: Mon, 20 May 2013 16:48:40 +0300
Message-ID: <20130520134840.GB12441@redhat.com>
References: <1365062118-907-1-git-send-email-dmitry@daynix.com>
	<1365062118-907-3-git-send-email-dmitry@daynix.com>
	<519A2897.9020207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <519A2897.9020207@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Yan Vugenfirer <yan@daynix.com>, Ronen Hod <rhod@redhat.com>, Dmitry Fleytman <dfleytma@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 20, 2013 at 03:43:51PM +0200, Paolo Bonzini wrote:
> Il 04/04/2013 09:55, Dmitry Fleytman ha scritto:
> > From: Dmitry Fleytman <dfleytma@redhat.com>
> > 
> > Virtio-net driver currently negotiates network offloads
> > on startup via features mechanism and have no ability to
> > disable and re-enable offloads later.
> > This patch introduced a new control command that allows
> > to configure device network offloads state dynamically.
> > The patch also introduces a new feature flag
> > VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
> > 
> > Signed-off-by: Dmitry Fleytman <dfleytma@redhat.com>
> > ---
> >  virtio-spec.lyx | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> > 
> > diff --git a/virtio-spec.lyx b/virtio-spec.lyx
> > index 3d2f485..e9dbac4 100644
> > --- a/virtio-spec.lyx
> > +++ b/virtio-spec.lyx
> > @@ -60,6 +60,7 @@
> >  \author -1930653948 "Amos Kong" 
> >  \author -608949062 "Rusty Russell,,," 
> >  \author -385801441 "Cornelia Huck" cornelia.huck@de.ibm.com
> > +\author 460276516 "Dmitry Fleytman" dfleytma@redhat.com
> >  \author 1112500848 "Rusty Russell" rusty@rustcorp.com.au
> >  \author 1531152142 "Paolo Bonzini,,," 
> >  \author 1717892615 "Alexey Zaytsev,,," 
> > @@ -4261,6 +4262,20 @@ VIRTIO_NET_F_GUEST_CSUM
> >  \end_inset
> >  
> >  (1) Guest handles packets with partial checksum
> > +\change_inserted 460276516 1363712169
> > +
> > +\end_layout
> > +
> > +\begin_layout Description
> > +
> > +\change_inserted 460276516 1363712334
> > +VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
> > +\begin_inset space ~
> > +\end_inset
> > +
> > +(2) Control channel offloads reconfiguration support.
> > +\change_unchanged
> 
> Rusty,
> 
> you might have missed this patch because your address was misspelled.

It's commit 721861222802d0ebc48564d727a3684f7b21cadd in
https://github.com/rustyrussell/virtio-spec

> Is there a story behind skipping virtio-net feature bits 2..4?
> 
> Paolo

Bits 3-4 now :)
I'm curious too.

-- 
MST

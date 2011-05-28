From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: 2.6.40 event idx patches
Date: Sat, 28 May 2011 22:34:26 +0300
Message-ID: <20110528193139.GA6650@redhat.com>
References: <20110524092345.GA17087@redhat.com>
	<87y61vilig.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87y61vilig.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 25, 2011 at 11:34:07AM +0930, Rusty Russell wrote:
> On Tue, 24 May 2011 12:23:45 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > Just checking: were you going to send the following to Linus for 2.6.40?
> > virtio:event_index_interface.patch
> > virtio:ring_inline_function_to_check_for_events.patch
> > virtio:ring_support_event_idx_feature.patch
> > misc:vhost_support_event_index.patch
> > virtio:test_support_event_index.patch
> > virtio:add_api_for_delayed_callbacks.patch
> > virtio:net_delay_tx_callbacks.patch
> > 
> > I certainly hope so as these modify both host and guest which makes
> > testing them out of tree hard for people.
> > Once stuff lands on Linus' tree we can patch
> > qemu and get more people to try out the patches.
> > 
> > Also, Linus said it's going to be a short window so ...
> 
> Yes.  They've been in linux-next since the weekend (ie. today will be the
> third linux-next build), and my plan was to push them Friday.
> 
> Nothing goes into linux-next which is not for Linus until after Linus
> closes the merge window.
> 
> I also want to find a few cycles to adapt lguest; it's *always* good to
> have a second implementation.
> 
> Cheers,
> Rusty.

Couldn't find any pull requests at lkml, and I read the window will
likely close May 29.  Did you end up not sending it, or did I miss it?

-- 
MST

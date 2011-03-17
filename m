From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio: Decrement avail idx on buffer detach
Date: Thu, 17 Mar 2011 17:56:59 +0530
Message-ID: <20110317122659.GB18382@amit-x200.redhat.com>
References: <a2fe5813ccecf1e762670702cba8ccb2a4cb8cfc.1300282928.git.amit.shah@redhat.com>
	<87aagugxab.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87aagugxab.fsf@rustcorp.com.au>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 17 Mar 2011 [15:26:28], Rusty Russell wrote:
> On Wed, 16 Mar 2011 19:12:10 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > When detaching a buffer from a vq, the avail.idx value should be
> > decremented as well.
> > 
> > This was noticed by hot-unplugging a virtio console port and then
> > plugging in a new one on the same number (re-using the vqs which were
> > just 'disowned').  qemu reported
> > 
> >    'Guest moved used index from 0 to 256'
> > 
> > when any IO was attempted on the new port.
> 
> Yech... detach_unused_buf cannot be used on a live virtqueue; it assumes
> we will reset the vq (usually by resetting the entire device).
> 
> You've partially violated that assumption by reusing the vq after
> calling detach_unused_buf.  So I'm not entirely sure this is the only
> bug lurking; safer would be to re-initialize the vq somehow when you
> plug back in...

Right; and then that will need host changes too (re-init the vqs on
the host side), which then gets us into compat problems...

		Amit

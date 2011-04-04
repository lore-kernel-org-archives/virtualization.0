From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: Decrement avail idx on buffer detach
Date: Mon, 04 Apr 2011 16:04:40 +0930
Message-ID: <87bp0mbk3j.fsf@rustcorp.com.au>
References: <a2fe5813ccecf1e762670702cba8ccb2a4cb8cfc.1300282928.git.amit.shah@redhat.com>
	<87aagugxab.fsf@rustcorp.com.au>
	<20110317122659.GB18382@amit-x200.redhat.com>
	<20110328142706.GA2949@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110328142706.GA2949@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 28 Mar 2011 19:57:06 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> On (Thu) 17 Mar 2011 [17:56:59], Amit Shah wrote:
> > On (Thu) 17 Mar 2011 [15:26:28], Rusty Russell wrote:
> > > On Wed, 16 Mar 2011 19:12:10 +0530, Amit Shah <amit.shah@redhat.com> wrote:
> > > > When detaching a buffer from a vq, the avail.idx value should be
> > > > decremented as well.
> > > > 
> > > > This was noticed by hot-unplugging a virtio console port and then
> > > > plugging in a new one on the same number (re-using the vqs which were
> > > > just 'disowned').  qemu reported
> > > > 
> > > >    'Guest moved used index from 0 to 256'
> > > > 
> > > > when any IO was attempted on the new port.
> > > 
> > > Yech... detach_unused_buf cannot be used on a live virtqueue; it assumes
> > > we will reset the vq (usually by resetting the entire device).
> > > 
> > > You've partially violated that assumption by reusing the vq after
> > > calling detach_unused_buf.  So I'm not entirely sure this is the only
> > > bug lurking; safer would be to re-initialize the vq somehow when you
> > > plug back in...
> > 
> > Right; and then that will need host changes too (re-init the vqs on
> > the host side), which then gets us into compat problems...
> 
> Rusty, any thoughts on this?
> 
> 		Amit
> 

Yes... I've applied your patch for the moment, and will send to Linus
with cc' stable.

Thanks,
Rusty.

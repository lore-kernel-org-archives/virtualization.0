From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost questions.
Date: Sun, 17 Mar 2013 13:09:07 +0200
Message-ID: <20130317110907.GB31111@redhat.com>
References: <874ngfvlo0.fsf@rustcorp.com.au>
	<20130313155916.GC14892@redhat.com>
	<87wqtatrj5.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87wqtatrj5.fsf@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 14, 2013 at 05:08:22PM +1030, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Wed, Mar 13, 2013 at 05:19:51PM +1030, Rusty Russell wrote:
> >> OK, I've been trying to read the vhost and vhost net code, and I'm
> >> struggling with basic questions.
> >> 
> >> 1) Why do we allow userspace to change an already-set-up vhost device?
> >>    Why not have:
> >>         open()
> >>         ioctl(VHOST_GET_FEATURES)
> >>         ioctl(VHOST_SET_VRING) x n (sets num, addresses, kick/call/err fds)
> >>         ioctl(VHOST_NET_SETUP)
> >>         ...
> >>         close()
> >> 
> >>    You're not allowed to call things twice: to reset, you close and
> >>    reopen.  That would save a lot of code which I'm not sure is correct
> >>    anyway.
> >
> > This won't work for the usecases we have in qemu.
> > The way things are setup currently, qemu typically does not have
> > the rights to open any char devices, instead it is passed an fd.

By the way at least for the guest callback eventfd, we currently use the
ability to switch it on the fly for when guest wants to mask the interrupt.
At some level, this could be considered an argument that initialization
order is a policy best let for userspace.

-- 
MST

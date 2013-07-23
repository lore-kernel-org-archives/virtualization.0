From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 08/10] virtio: console: add locks around buffer removal
	in port unplug path
Date: Tue, 23 Jul 2013 13:54:47 +0530
Message-ID: <20130723082447.GA17739@amit-x200.redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
	<2b1b00dbdbc7575e8370c3b3ecad7b4b4c0f2833.1374177234.git.amit.shah@redhat.com>
	<87d2qbb0jd.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87d2qbb0jd.fsf@rustcorp.com.au>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 22 Jul 2013 [15:26:22], Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
> > The removal functions act on the vqs, and the vq operations need to be
> > locked.
> >
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> How can userspace access the port now?  By the time we are cleaning up
> buffers, there should be no possibility of such accesses.

close(), can happen when the port is being unplugged.  We're just
making sure here that port_fops_release() and unplug_port() don't try
to free up the same data at the same time.

> The number of bugfixes here is deeply disturbing.

Yes, the first three fix a bug - close() after unplug.  However, the
others are inadequate locking fixes which I noticed while fixing that
bug.

Port unplug isn't a frequently-used or tested path, so these were
lying unnoticed so far.

>  I wonder if it's be
> easier to rewrite it all with a lock per port, and one global to protect
> ports_driver_data.

Hm, with this series, I don't see anything that might need extra
locking.  Though I'll take a look at this afresh in a while -- and see
if we could simplify something.

Given that this was necessary only for unplug operations, (and they
aren't a 'regular operation', so we could drop the stable@ for the
series?), are you OK with this series for now?

		Amit

From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: console: Barrier needed before dropping early_put_chars?
Date: Wed, 24 Feb 2010 11:37:08 +1030
Message-ID: <201002241137.08243.rusty@rustcorp.com.au>
References: <20100223171022.GB32564@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100223171022.GB32564@amit-x200.redhat.com>
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
Cc: borntraeger@de.ibm.com, hch@lst.de, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 24 Feb 2010 03:40:22 am Amit Shah wrote:
> Hey Rusty, Christian,
> 
> Christoph Hellwig asked why we don't need a barrier before this code in
> virtcons_probe():
> 
> > +     /* Start using the new console output. */
> > +     early_put_chars = NULL;
> >       return 0;
> 
> Since only s390 uses early_put_chars so far, you'd know why it's not
> needed / why we're safe.

He's right, it's sloppy.

In practice the compiler checks for NULL and reuses the pointer, and we
have no problem if this is used a couple of times after the real console is
live.

The Right Way to do this is a lock in put_chars() and around this assignment.
But do we really want to bother?

Cheers,
Rusty.
-- 
Away travelling 25Feb-26Mar (6 .de + 1 .pl + 17 .lt + 2 .sg)

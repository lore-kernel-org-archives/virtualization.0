From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: virtio: console: Barrier needed before dropping early_put_chars?
Date: Tue, 23 Feb 2010 23:07:32 +0100
Message-ID: <201002232307.32622.borntraeger@de.ibm.com>
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
Cc: hch@lst.de, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 23 Februar 2010 18:10:22 schrieb Amit Shah:
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

lguest is also using early_put_chars. See arch/x86/lguest/boot.c
Anyway I had to look into linux-next to see this code. I guess that is the
version you are talking about. (I remember seeing these patches several month
ago).

So what would a barrier do? Protect against gcc moving the early_put_chars=NULL
before the virtqueue is fully initialized and ready?
In practice this should not be necessary since the last thing probe might do
is add_port which is doing send_control_msg which contains cpu_relax (which
is a barrier). So gcc should not be able to move the early_put_chars = NULL
before the add_port loop.

Anyway, an explicit barrier might be a cleaner and more future proof way of
doing it.

From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 1 Oct 2009 17:28:01 +0530
Message-ID: <20091001114244.GB12334__48982.6537589126$1254398400$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200909291531.23389.borntraeger@de.ibm.com>
	<20090930171321.GA17200@amit-x200.redhat.com>
	<200910011228.30563.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910011228.30563.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) Oct 01 2009 [12:28:30], Christian Borntraeger wrote:
> Am Mittwoch 30 September 2009 19:13:21 schrieben Sie:
> > On (Tue) Sep 29 2009 [15:31:23], Christian Borntraeger wrote:
> > > Am Dienstag 29 September 2009 15:09:50 schrieb Amit Shah:
> > > > Great, thanks. However I was thinking of moving this init to the
> > > > probe() routine instead of in the init_conosle routine just because
> > > > multiple consoles can be added and we don't want to init this each
> > > > time.. just once in probe is fine.
> > >
> > > If you have new patch CC me and I can give it a spin.
> > 
> > Hey Christian,
> > 
> > I have a new patch that changes a few things:
> > - moves the put_char fix to probe instead of doing it in
> >   init_port_console(), which gets called on each console port found.
> > - uses port->id instead of a static hvc_vtermno to pass on a value to
> >   hvc_alloc(). Motivation explained within comments in the code.
> > - A few other changes that introduce and make use of port->vcon instead
> >   of accessing the static virtconsole directly -- aimed at easing future
> >   fix to have multiple virtio-console devices.
> > 
> > It would be great if you could test this.
> 
> With the latest git kernel + your patch I sometmes get a completely frozen 
> console. In the dump there is 
> 
>     <3>virtio_console virtio0: output:id 68 is not a head!
> 
> Seems that I can reproduce it with large amounts of output (find / for example)
> Without your patch everything is fine.

I spawned two ports; one doing 'find /' and the other transferring a
800M file from the host to the guest, both running at the same time.
This is on top of the latest Linus tree + my patches. It works fine.

Can you give me any additional info that can help me nail this down?

		Amit

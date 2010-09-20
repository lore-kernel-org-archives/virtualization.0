From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/2] virtio: console: Fix poll blocking even though there
	is data to read
Date: Mon, 20 Sep 2010 10:38:33 +0530
Message-ID: <20100920050833.GA30110@amit-laptop.redhat.com>
References: <6c7c2590a114d65ec52689be7cda7ada5ee876d5.1284628364.git.amit.shah@redhat.com>
	<201009201219.34378.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201009201219.34378.rusty@rustcorp.com.au>
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
Cc: Hans de Goede <hdegoede@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Sep 20 2010 [12:19:33], Rusty Russell wrote:
> On Thu, 16 Sep 2010 06:43:08 pm Amit Shah wrote:
> > From: Hans de Goede <hdegoede@redhat.com>
> > 
> > I found this while working on a Linux agent for spice, the symptom I was
> > seeing was select blocking on the spice vdagent virtio serial port even
> > though there were messages queued up there.
> > 
> > virtio_console's port_fops_poll checks port->inbuf != NULL to determine
> > if read won't block. However if an application reads enough bytes from
> > inbuf through port_fops_read, to empty the current port->inbuf,
> > port->inbuf will be NULL even though there may be buffers left in the
> > virtqueue.
> > 
> > This causes poll() to block even though there is data to be read,
> > this patch fixes this by using will_read_block(port) instead of the
> > port->inbuf != NULL check.
> > 
> > Signed-off-By: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> Thanks.  I assume this one should go into stable too?

Yes, thanks.

		Amit

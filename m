From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 22 Sep 2009 12:14:04 +0930
Message-ID: <200909221214.04340.rusty__40451.4689500958$1253587520$gmane$org@rustcorp.com.au>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<1252678386-17404-2-git-send-email-amit.shah@redhat.com>
	<20090911170010.34c80f2d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090911170010.34c80f2d@linux.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Cox <alan@linux.intel.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 12 Sep 2009 01:30:10 am Alan Cox wrote:
> > The interface presented to guest userspace is of a simple char
> > device, so it can be used like this:
> > 
> >     fd = open("/dev/vcon2", O_RDWR);
> >     ret = read(fd, buf, 100);
> >     ret = write(fd, string, strlen(string));
> > 
> > Each port is to be assigned a unique function, for example, the
> > first 4 ports may be reserved for libvirt usage, the next 4 for
> > generic streaming data and so on. This port-function mapping
> > isn't finalised yet.
> 
> Unless I am missing something this looks completely bonkers
> 
> Every time we have a table of numbers for functionality it ends in
> tears. We have to keep tables up to date and managed, we have to
> administer the magical number to name space.

The number comes from the ABI; we need some identifier for the different
ports.  Amit started using names, and I said "just use numbers"; they have
to be documented and agreed by all clients anyway.

ie. the host says "here's a port id 7", which might be the cut & paste
port or whatever.

Cheers,
Rusty.

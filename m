From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 10/10] virtio: console: Add support for nonblocking
	write()s
Date: Tue, 6 Apr 2010 09:24:35 +0530
Message-ID: <20100406035435.GD4135@amit-x200.redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-10-git-send-email-amit.shah@redhat.com>
	<1270475654-399-11-git-send-email-amit.shah@redhat.com>
	<201004061242.58840.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004061242.58840.rusty@rustcorp.com.au>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Apr 06 2010 [12:42:58], Rusty Russell wrote:
> On Mon, 5 Apr 2010 11:24:14 pm Amit Shah wrote:
> > If the host port is not open, a write() should either just return if the
> > file is opened in non-blocking mode, or block till the host port is
> > opened.
> > 
> > Also, don't spin till host consumes data for nonblocking ports. For
> > non-blocking ports, we can do away with the spinning and reclaim the
> > buffers consumed by the host on the next write call or on the condition
> > that'll make poll return.
> 
> I'm only reading the patch so I might have missed it, but what's the
> locking going on here?
> 
> Can we race thinking we're full or not full incorrectly?

Yes, we can. I forgot to mention that in the changelog, I'm working on
adding (and testing) the locking.

Basically I wanted to send out the series in this stage for a review --
only the locking remains to be done as of now.

> But the basic approach of this series seems good!

Thanks!

		Amit

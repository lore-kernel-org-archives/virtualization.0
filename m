From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] vhost cleanups and separate module
Date: Mon, 6 May 2013 12:19:11 +0300
Message-ID: <20130506091911.GB10601@redhat.com>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
	<87sj20prhj.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87sj20prhj.fsf@rustcorp.com.au>
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
Cc: target-devel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 06, 2013 at 03:41:36PM +0930, Rusty Russell wrote:
> Asias He <asias@redhat.com> writes:
> > Asias He (3):
> >   vhost: Remove vhost_enable_zcopy in vhost.h
> >   vhost: Move VHOST_NET_FEATURES to net.c
> >   vhost: Make vhost a separate module
> 
> I like these cleanups, MST pleasee apply.

Absolutely. Except it's 3.11 material and I can only
usefully create a -next branch once -rc1 is out.

> I have some other cleanups which are on hold for the moment pending
> MST's vhost_net simplification.  MST, how's that going?

Not too well. The array of status bytes which was designed to complete
packets in order turns out to be a very efficient datastructure:

It gives us a way to signal completions that is completely lockless for
multiple completers, and using the producer/consumer model saves extra
scans for the common case.

Overall I can save some memory and clean up some code but can't get rid
of the producer/consumer idices (currently named upend/done indices)
which is what you asked me to do.
Your cleanups basically don't work with zcopy because they
ignore the upend/done indices?
Would you like to post them, noting they only work with zcopy off, and
we'll look for a way to apply them, together?

> Thanks,
> Rusty.

From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio: put last seen used index into ring itself
Date: Mon, 10 May 2010 00:06:52 +0300
Message-ID: <20100509210652.GB21338__22611.0715572306$1273439586$gmane$org@redhat.com>
References: <20100505205814.GA7090@redhat.com>
	<201005061201.35223.rusty@rustcorp.com.au>
	<20100506061945.GA8363@redhat.com>
	<201005071303.29129.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201005071303.29129.rusty@rustcorp.com.au>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 07, 2010 at 01:03:28PM +0930, Rusty Russell wrote:
> On Thu, 6 May 2010 03:49:46 pm Michael S. Tsirkin wrote:
> > Now, I also added an mb() in guest between read and write so
> > that last used index write can not get ahead of used index read.
> > It does feel good to have it there, but I can not say why
> > it's helpful. Works fine without it, but then these
> > subtle races might be hard to trigger. What do you think?
> 
> I couldn't see that in the patch?  I don't think it's necessary
> though, since the write of depends last_used depends on the read of
> used (and no platform we care about would reorder such a thing).

Well, there's no data dependency, is there?

> I'm reasonably happy, but we should write some convenient test for
> missing interrupts.
> 
> I'm thinking of a sender which does a loop: blasts 1MB of UDP packets,
> then prints the time and sleep(1).  The receiver would print the time
> every 1MB of received data.  The two times should almost exactly correspond.
> 
> Assuming that the network doesn't overflow and lose stuff, this should
> identify any missing wakeup/interrupts (depending on direction used).
> 
> Cheers,
> Rusty.

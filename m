From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 15:31:23 +0200
Message-ID: <200909291531.23389.borntraeger__6749.2228969515$1254231151$gmane$org@de.ibm.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200909291456.56723.borntraeger@de.ibm.com>
	<20090929130950.GA23395@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090929130950.GA23395@amit-x200.redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 29 September 2009 15:09:50 schrieb Amit Shah:
> Great, thanks. However I was thinking of moving this init to the probe()
> routine instead of in the init_conosle routine just because multiple
> consoles can be added and we don't want to init this each time.. just
> once in probe is fine.

If you have new patch CC me and I can give it a spin.


> > I am a bit reluctant to Ack the whole change, since my preference would
> > have been to not merge virtio serial/console and instead keeping both
> > separate. We have already managed to clutter all other virtio drivers
> > with tons of configuration stuff and feature bits - and every driver uses
> > a different model for configuration and commands (feature bits, config
> > space, config_change indication, extra config virtqueue, commands
> > embedded into the data....). Using a different device ID for a different
> > use seem like a better way to me.
> 
> Well, Anthony described your objection as a comment in passing and that
> you weren't strongly against merging the two drivers when I brought up
> your argument sometime back.
> 
> Also, it was difficult to make progress and just keep fighting about
> these issues. So even though I didn't like merging the stuff, I had to.

Sure, you were caught between two stools... I have to admit that I dropped of 
this discussion and did not follow up - I simply considered my wedding and 
honeymoon more important ;-)

I still belive that I am right and Anthony is wrong about this  8-), but if 
merging is the way to go - so be it. 

From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 18:39:50 +0530
Message-ID: <20090929130950.GA23395__9480.95942517302$1254229903$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200909291403.08547.borntraeger@de.ibm.com>
	<20090929122006.GB3766@amit-x200.redhat.com>
	<200909291456.56723.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909291456.56723.borntraeger@de.ibm.com>
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
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Sep 29 2009 [14:56:56], Christian Borntraeger wrote:
> Am Dienstag 29 September 2009 14:20:06 schrieb Amit Shah:
> > Christian tested the patch on s390 and found that the output was
> > very slow. He tracked it down to put_chars never getting init'ed
> > to the final value.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> Thanks. This fix is 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com> 

Great, thanks. However I was thinking of moving this init to the probe()
routine instead of in the init_conosle routine just because multiple
consoles can be added and we don't want to init this each time.. just
once in probe is fine.

> I am a bit reluctant to Ack the whole change, since my preference would have
> been to not merge virtio serial/console and instead keeping both separate.
> We have already managed to clutter all other virtio drivers with tons of 
> configuration stuff and feature bits - and every driver uses a different model
> for configuration and commands (feature bits, config space, config_change 
> indication, extra config virtqueue, commands embedded into the data....).
> Using a different device ID for a different use seem like a better way to me.

Well, Anthony described your objection as a comment in passing and that
you weren't strongly against merging the two drivers when I brought up
your argument sometime back.

Also, it was difficult to make progress and just keep fighting about
these issues. So even though I didn't like merging the stuff, I had to.

Rusty too in a recent mail mentioned he sees both the drivers as one
because the functionlities are similar.

> On the other hand, this patch allows more than one console (I have not tested
> this feature) and with this fix applied I dont see any obvious problems.

Note though that to use the multiple consoles, you'll have to modify
your userspace to handle the new messages that get passed between the
host and the guest (one can argue I've done the guest part; you only
have the host part to be done :-))

> For the console part I can give a 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com> (console)

Thanks again. I'll put this in the next spin.

> Ignoring my preference for having a separate driver and devids, I have no 
> opinion about the generic communication stuff - no ack or nack.

		Amit

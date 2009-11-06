From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Fri, 06 Nov 2009 07:00:32 -0600
Message-ID: <4AF41DF0.7050002__35612.3463287533$1257512643$gmane$org@us.ibm.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<1257266319-24300-2-git-send-email-amit.shah@redhat.com>
	<200911061740.03734.rusty@rustcorp.com.au>
	<200911060900.49923.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911060900.49923.borntraeger@de.ibm.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Christian Borntraeger wrote:
> I know that Anthony disagrees, but _If we start over_, I still think we should 
> use that chance and leave the old virtio console untouched and add a new driver 
> for the host guest communication. IMHO it turned out that there is only a tiny 
> bit of commonality. (most code pathes check for use_multiport and  then do two 
> completely different things).
> I like simplicity. According to David A. Wheeler's SLOCCount, the old console 
> has 141 lines of code and the I truly believe that a separate guest-host comm 
> vehicle would also be a lot simpler if it must not take care of the old 
> virtio_console interface.
>   

It's the wrong metrics for evaluating a device ABI.  We should consider 
device ABIs based on whether they make sense--not about how many lines 
of code it takes to implement the Linux driver.

Fundamentally speaking, right now, virtio-console is a single stream 
that acts as an interactive terminal.  What we're looking to add here is 
to support multiple terminals that can be enumerated in a rationale way.

I see no reason why that should be two separate devices.

> On the other hand we all should agree on one driver vs. two drivers before we go 
> on. Everything else would be unfair to Amit, who had the unpleasant task to 
> implement conflicting review comments....
>   

I agree and there are multiple maintainers on the qemu side who feel the 
same way I do.  I'm really strongly opposed to making this separate devices.

If you think it's easier, you can do a check in the virtio_probe 
function that checks for the feature bits and calls a completely 
separate virtio initialization routine so it ends up being two separate 
files in Linux.  But that's a Linux implementation detail.

> Christian
>   


-- 
Regards,

Anthony Liguori

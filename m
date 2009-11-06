From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Fri, 6 Nov 2009 15:12:40 +0100
Message-ID: <200911061512.40413.borntraeger__38111.2105482773$1257516852$gmane$org@de.ibm.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<200911060900.49923.borntraeger@de.ibm.com>
	<4AF41DF0.7050002@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4AF41DF0.7050002@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Amit Shah <amit.shah@redhat.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag 06 November 2009 14:00:32 schrieb Anthony Liguori:
> > I like simplicity. According to David A. Wheeler's SLOCCount, the old
> > console has 141 lines of code and the I truly believe that a separate
> > guest-host comm vehicle would also be a lot simpler if it must not take
> > care of the old virtio_console interface.
> 
> It's the wrong metrics for evaluating a device ABI.  We should consider
> device ABIs based on whether they make sense--not about how many lines
> of code it takes to implement the Linux driver.

Well, code size is often related to complexity of the interface and affects 
maintainability. But if that does not convince you, what about intended use and 
semantics?

> Fundamentally speaking, right now, virtio-console is a single stream
> that acts as an interactive terminal.  What we're looking to add here is
> to support multiple terminals that can be enumerated in a rationale way.

Right, that is a point where I disagree. The original purpose and intent of the 
multiple port thing was to have a generic guest/host comm channels and *NOT* to 
have multiple console devices. Having multiple console devices is just a fall-
out of the current implementation.

Following your argument about single-streaming, we could also merge virtio-rng, 
no? 
If a common interface for stream workload is desired I would have preferred a 
write/read virtqueue_op besides or on top of add_buf/getbuf. I think that would 
have been the right level of abstraction.

>I agree and there are multiple maintainers on the qemu side who feel the
>same way I do.  I'm really strongly opposed to making this separate devices.

As a maintainer you sometimes have to make a controversial decision. If you made 
this final decision (and Rusty agrees) I am fine, even if I disagree.

(If it turns out to be a wrong decision you have been warned.  ;-) )

Christian

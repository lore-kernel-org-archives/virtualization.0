From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: packed ring layout proposal v2
Date: Thu, 9 Feb 2017 19:43:09 +0200
Message-ID: <20170209181955-mutt-send-email-mst__16330.2919165746$1486662194$gmane$org@kernel.org>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
	<39240395-0266-c2ac-0b99-de74ba10b510@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <39240395-0266-c2ac-0b99-de74ba10b510@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 08, 2017 at 02:37:57PM +0100, Christian Borntraeger wrote:
> On 02/08/2017 04:20 AM, Michael S. Tsirkin wrote:
> [...]
> > * Prototype
> > 
> > A partial prototype can be found under
> > tools/virtio/ringtest/ring.c
> > 
> > Test run:
> > [mst@tuck ringtest]$ time ./ring 
> > real    0m0.399s
> > user    0m0.791s
> > sys     0m0.000s
> > [mst@tuck ringtest]$ time ./virtio_ring_0_9
> > real    0m0.503s
> > user    0m0.999s
> > sys     0m0.000s
> 
> I see similar improvements on s390, so I think this would be a very nice 
> improvement.
> 
> [...] 
> > Note: should this proposal be accepted and approved, one or more
> >       claims disclosed to the TC admin and listed on the Virtio TC
> >       IPR page https://www.oasis-open.org/committees/virtio/ipr.php
> >       might become Essential Claims.
> > 
> 
> I have trouble parsing that legal stuff. Do I read that right, that
> these claims can be implemented as part of a virtio implementation without
> any worries (e.g. non open source HW implementation or non open source
> hypervisor)?

By that legal stuff do you mean the IPR or the Note?

Not representing Red Hat here, and definitely not legal advice, below is
just my personal understanding of the IPR requirements.

Virtio TC operates under the Non-Assertion Mode of the OASIS IPR Policy:
https://www.oasis-open.org/policies-guidelines/ipr#Non-Assertion-Mode

As far as I can tell, the hardware and software question is covered
by that policy, since it states:

	Covered Product - includes only those specific portions of a
	product (hardware, software or combinations thereof)

Also as far as I can tell IPR does not mention source at all, so I think
virtio IPR would apply to open and closed source software equally.

The Note is included to satisfy the disclosure requirements.

Does this answer the question?

-- 
MST

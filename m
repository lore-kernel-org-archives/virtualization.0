From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: packed ring layout proposal v2
Date: Wed, 8 Feb 2017 14:37:57 +0100
Message-ID: <39240395-0266-c2ac-0b99-de74ba10b510@de.ibm.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/08/2017 04:20 AM, Michael S. Tsirkin wrote:
[...]
> * Prototype
> 
> A partial prototype can be found under
> tools/virtio/ringtest/ring.c
> 
> Test run:
> [mst@tuck ringtest]$ time ./ring 
> real    0m0.399s
> user    0m0.791s
> sys     0m0.000s
> [mst@tuck ringtest]$ time ./virtio_ring_0_9
> real    0m0.503s
> user    0m0.999s
> sys     0m0.000s

I see similar improvements on s390, so I think this would be a very nice 
improvement.

[...] 
> Note: should this proposal be accepted and approved, one or more
>       claims disclosed to the TC admin and listed on the Virtio TC
>       IPR page https://www.oasis-open.org/committees/virtio/ipr.php
>       might become Essential Claims.
> 

I have trouble parsing that legal stuff. Do I read that right, that
these claims can be implemented as part of a virtio implementation without
any worries (e.g. non open source HW implementation or non open source
hypervisor)?

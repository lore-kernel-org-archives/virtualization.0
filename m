From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Proposal for virtio standardization.
Date: Wed, 10 Oct 2012 14:16:51 +1030
Message-ID: <87r4p76las.fsf__39622.2445102923$1349863380$gmane$org@rustcorp.com.au>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <20121009160201.5303a7ca@BR9GNB5Z>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121009160201.5303a7ca@BR9GNB5Z>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Avishay Traeger <AVISHAY@il.ibm.com>, kvm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> On Thu, 27 Sep 2012 09:59:33 +0930
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>> 3) Various clarifications, formalizations and cleanups to the spec text,
>>    and possibly elimination of old deprecated features.
>> 
>> 4) The only significant change to the spec is that we use PCI
>>    capabilities, so we can have infinite feature bits.
>>    (see
>> http://lists.linuxfoundation.org/pipermail/virtualization/2011-December/019198.html)
>
> "Infinite" only applies to virtio-pci, no?

Yes, you already have "infinite" feature bits for ccw, as does every bus
we did since PCI.

> Sounds like a good idea. I'll be happy to review the spec with an eye
> to virtio-ccw.

Thanks!
Rusty.

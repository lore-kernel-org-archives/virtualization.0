From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Using PCI config space to indicate config location
Date: Wed, 17 Oct 2012 00:22:25 +1030
Message-ID: <87d30iplra.fsf__10701.0733722293$1350395629$gmane$org@rustcorp.com.au>
References: <874nmajcmj.fsf@codemonkey.ws> <87y5jhpuu2.fsf@rustcorp.com.au>
	<20121010083033.GA4799@redhat.com> <87bog9957l.fsf@rustcorp.com.au>
	<20121011102333.GA5552@redhat.com> <87391k7icv.fsf@rustcorp.com.au>
	<20121012093330.GA32014@redhat.com>
	<871uh4587d.fsf@rustcorp.com.au>
	<20121012100231.GA32517@redhat.com>
	<87k3uqpngi.fsf@rustcorp.com.au>
	<20121016133045.GA12766@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121016133045.GA12766@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, Oct 16, 2012 at 11:45:41PM +1030, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> I was assuming the implementation would keep two complete copies of the
>> config space: writes go to the scratch version, which gets copied to the
>> master version upon latch write.
>
> Yes but config space has some host modifiable registers too.
> So host needs to be careful to avoid overwriting these.
>
> If accesses have side effects that of course breaks too ...

Yes.

>
>> But I do wonder if we should just skip this for now, since we don't
>> have any immediate need.
>> 
>> Cheers,
>> Rusty.
>
> MAC setting from guest needs this right now, no?

Ah, I missed that in my table:

    Driver          Config       Device changes    Driver writes... after init?
    net             Y            Y                 N                N
    block           Y            Y                 Y                Y
    console         Y            Y                 N                N
    rng             N            N                 N                N
    balloon         Y            Y                 Y                Y
    scsi            Y            N                 Y                N
    9p              Y            N                 N                N

First line should be:

    net             Y            Y                 Y                N

So we could add a new cvq command (eg. #define VIRTIO_NET_CTRL_MAC_SET
1) and a VIRTIO_NET_F_CVQ_MAC_SET feature.  Or go ahead with the
latching scheme (which doesn't really help other busses).

Cheers,
Rusty.

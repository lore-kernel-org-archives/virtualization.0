From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 05 Jun 2013 16:49:22 +0930
Message-ID: <87hahdrpmt.fsf@rustcorp.com.au>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<87ppwammp5.fsf@rustcorp.com.au> <87mwreq76y.fsf@codemonkey.ws>
	<87wqqhktjx.fsf@rustcorp.com.au> <87fvx460ba.fsf@codemonkey.ws>
	<20130530140132.GC21440@redhat.com>
	<874ndgujiw.fsf@rustcorp.com.au> <20130603101136.GB8649@redhat.com>
	<87fvwytpa1.fsf@rustcorp.com.au>
	<20130604064216.GD19433@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130604064216.GD19433@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
>> By my count, net still has 7 feature bits left, so I don't think the
>> feature bits are likely to be a limitation in the next 6 months?
>
> Yes but you wanted a generic transport feature bit
> for flexible SG layout.
> Are you happy with VIRTIO_NET_F_ANY_HEADER_SG then?

If we need it within 6 months, I'd rather do that: this feature would
then be assumed for 1.0, and reserved.  We may do that for other
features, too (the committee will have to review).

>> MMIO is a bigger problem.  Linux guests are happy with it: does it break
>> the Windows drivers?
>> 
>> Thanks,
>> Rusty.
>
> You mean make BAR0 an MMIO BAR?
> Yes, it would break current windows guests.
> Further, as long as we use same address to notify all queues,
> we would also need to decode the instruction on x86 and that's
> measureably slower than PIO.
> We could go back to discussing hypercall use for notifications,
> but that has its own set of issues...

We might have something ready to deploy in 3 months, but realistically,
I'd rather have it ready and tested outside the main git tree(s) and
push it once the standard is committed.

Cheers,
Rusty.

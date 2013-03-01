From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 02/16] virtio_ring: virtqueue_add_sgs, to add multiple sgs.
Date: Fri, 01 Mar 2013 11:31:40 +1030
Message-ID: <877glsc4qz.fsf__31091.9092422866$1362348963$gmane$org@rustcorp.com.au>
References: <1361260594-601-1-git-send-email-rusty@rustcorp.com.au>
	<1361260594-601-3-git-send-email-rusty@rustcorp.com.au>
	<20130224221255.GA5300@redhat.com>
	<512C5E0E.5040305@redhat.com> <87obf6dxlm.fsf@rustcorp.com.au>
	<20130227074920.GA11775@redhat.com>
	<87fw0idmu2.fsf@rustcorp.com.au> <512F223B.4080801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <512F223B.4080801@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il 27/02/2013 12:21, Rusty Russell ha scritto:
>>>> >> Baseline (before add_sgs):
>>>> >>         2.840000-3.040000(2.927292)user
>>>> >> 
>>>> >> After add_sgs:
>>>> >>         2.970000-3.150000(3.053750)user
>>>> >> 
>>>> >> After simplifying add_buf a little:
>>>> >>         2.950000-3.210000(3.081458)user
>>>> >> 
>>>> >> After inlining virtqueue_add/vring_add_indirect:
>>>> >>         2.920000-3.150000(3.026875)user
>>>> >> 
>>>> >> After passing in iteration functions (chained vs unchained):
>>>> >>         2.760000-2.970000(2.883542)user
>> Oops.  This result (and the next) is bogus.  I was playing with -O3, and
>> accidentally left that in :(
>
> Did you check what actually happened that improved speed so much?

No, it was a random aside, I didn't dig into it.  Perhaps we should
revisit using -O3 on the entire kernel, or perhaps grab gcc 3.8 and see
how that performs.

But I'm implementing specialized virtqueue_add_outbuf() and
virtqueue_add_inbuf() which seem to get more improvement anyway (except
occasionally I get hangs in my tests, which I'm debugging now...)

Cheers,
Rusty.

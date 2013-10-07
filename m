From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Kmemleak: false-positive in vring_add_indirect ?
Date: Mon, 07 Oct 2013 19:52:44 +1030
Message-ID: <87siwdwi3f.fsf@rustcorp.com.au>
References: <20131002202047.GA7419@cpaasch-mac>
	<87d2nlykgd.fsf@rustcorp.com.au>
	<CALMXkpYyFwKtbyp2_yRfxt0_0HddfF+GJDw7y2CGArg9H+cFtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CALMXkpYyFwKtbyp2_yRfxt0_0HddfF+GJDw7y2CGArg9H+cFtQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Paasch <christoph.paasch@gmail.com>
Cc: Christoph Paasch <christoph.paasch@uclouvain.be>, "Michael S. Tsirkin" <mst@redhat.com>, stable@kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christoph Paasch <christoph.paasch@gmail.com> writes:
> On Fri, Oct 4, 2013 at 1:59 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Thanks!  Does this work?
>>
>> virtio_ring: plug kmemleak false positive.
>
> Yes, it does work.
>
> Tested-by: Christoph Paasch <christoph.paasch@uclouvain.be>
>
> This patch should be sent to stable.

I disagree.  Removing an annoying warning is not a fix.

Cheers,
Rusty.

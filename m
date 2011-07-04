From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_balloon: Notify guest only after deflating the
	balloon
Date: Mon, 04 Jul 2011 17:07:12 +0930
Message-ID: <87boxasdhz.fsf__956.131579778408$1309765124$gmane$org@rustcorp.com.au>
References: <1309576016-22800-1-git-send-email-levinsasha928@gmail.com>
	<20110703082748.GD13183@redhat.com> <1309686419.2250.8.camel@sasha>
	<20110703103051.GA15537@redhat.com>
	<1309690349.2250.21.camel@sasha>
	<20110703121137.GA15826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110703121137.GA15826@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Sasha Levin <levinsasha928@gmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, dave@linux.vnet.ibm.com, Pekka Enberg <penberg@kernel.org>, Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 3 Jul 2011 15:11:37 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Sun, Jul 03, 2011 at 01:52:29PM +0300, Sasha Levin wrote:
> > This just leads me to believe that we should either not notify the host,
> > or not wait_for_completion() when telling the host.
> 
> Interesting. The spec says
> 
> (a) The driver constructs an array of addresses of memory pages it has
> previously given to the balloon, as described above. This descriptor
> is added to the deflateq.
> (b) If the VIRTIO_BALLOON_F_MUST_TELL_HOST feature is set,
> the guest may not use these requested pages until that descriptor in
> the deflateq has been used by the device.
> (c) Otherwise, the guest may begin to re-use pages previously given to
> the balloon before the device has acknowledged their withdrawl.
>  21 In this case, deflation advice is merely a courtesy
> 
> This does not discuss the following issue: what happens
> if the device never uses the descriptor in the deflateq
> and VIRTIO_BALLOON_F_MUST_TELL_HOST is not set?
> 
> Rusty, any comments?

The device still *has* a queue.  It should process it!

The feature should be called VIRTIO_BALLOON_F_ASK_HOST_BEFORE_REUSE.

If we didn't want the information at *all*, we would have made the queue
not exist in that case...

Thanks,
Rusty.

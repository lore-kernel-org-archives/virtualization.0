From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: question on virtio
Date: Thu, 6 May 2010 11:02:41 +0930
Message-ID: <201005061102.42306.rusty__11454.6550707475$1273109604$gmane$org@rustcorp.com.au>
References: <20100505110947.GA27872@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100505110947.GA27872@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 5 May 2010 08:39:47 pm Michael S. Tsirkin wrote:
> Hi!
> I see this in virtio_ring.c:
> 
>         /* Put entry in available array (but don't update avail->idx *
> 	   until they do sync). */
> 
> Why is it done this way?
> It seems that updating the index straight away would be simpler, while
> this might allow the host to specilatively look up the buffer and handle
> it, without waiting for the kick.

I agree.  From my TODO:
        what if we actually expose in ->add_buf?

I don't *think* anyone adds buffers without being ready for them to be used,
so changing this should be safe.

Want to give it a try and report back?

Thanks!
Rusty.

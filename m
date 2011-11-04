From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3 of 5] virtio: support unlocked queue kick
Date: Fri, 04 Nov 2011 21:06:09 +1030
Message-ID: <87k47grx7q.fsf@rustcorp.com.au>
References: <patchbomb.1320306168@localhost6.localdomain6>
	<c0db93dbb414ab6dbcde.1320306171@localhost6.localdomain6>
	<20111103075211.GD6993@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111103075211.GD6993@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Christoph Hellwig <hch@infradead.org>, virtualization <virtualization@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 3 Nov 2011 03:52:11 -0400, Christoph Hellwig <hch@infradead.org> wrote:
> On Thu, Nov 03, 2011 at 06:12:51PM +1030, Rusty Russell wrote:
> > Based on patch by Christoph for virtio_blk speedup:
> 
> Please credit it to Stefan - he also sent a pointer to his original
> version in reply to the previous thread.
> 
> Also shouldn't virtqueue_kick have kerneldoc comments?

Yep, and I've credited it properly.

> I also notices that you documented the functions bother here and in
> the first patch in the headers.  At least historically the kerneldoc
> tools didn't parse comments at declarations, but only at the function
> defintions.  Did you check these actually get picked up?

Gah, I'd forgotten that the kernel tendency is to put the interface
documentation next to the implementation.

Personally, I think extracting it is insane, but I've moved them.

Thanks,
Rusty.

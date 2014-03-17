From: tytso@mit.edu
Subject: Re: [PATCH] virtio-blk: make the queue depth the max supportable by
	the hypervisor
Date: Mon, 17 Mar 2014 01:40:53 -0400
Message-ID: <20140317054053.GF14162@thunk.org>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
	<1394854471-25700-1-git-send-email-tytso@mit.edu>
	<87siqhu048.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87siqhu048.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Frank Swiderski <fes@google.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Linux Kernel Developers List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 17, 2014 at 11:12:15AM +1030, Rusty Russell wrote:
> 
> Note that with indirect descriptors (which is supported by Almost
> Everyone), we can actually use the full index, so this value is a bit
> pessimistic.  But it's OK as a starting point.

So is this something that can go upstream with perhaps a slight
adjustment in the commit description?  Do you think we need to be able
to dynamically adjust the queue depth after the module has been loaded
or the kernel has been booted?  If so, anyone a hint about the best
way to do that would be much appreciated.

Thanks,

					- Ted

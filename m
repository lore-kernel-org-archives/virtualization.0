From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH RESEND 5/5] vhost-blk: Add vhost-blk support
Date: Fri, 20 Jul 2012 15:56:19 -0500
Message-ID: <87obnaup70.fsf__22123.1482843452$1342818118$gmane$org@codemonkey.ws>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
	<1342169711-12386-6-git-send-email-asias@redhat.com>
	<87mx2vrjdl.fsf@codemonkey.ws> <20120719130957.GD9303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120719130957.GD9303@redhat.com>
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
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jul 19, 2012 at 08:05:42AM -0500, Anthony Liguori wrote:
>> Of course, the million dollar question is why would using AIO in the
>> kernel be faster than using AIO in userspace?
>
> Actually for me a more important question is how does it compare
> with virtio-blk dataplane?

I'm not even asking for a benchmark comparision.  It's the same API
being called from a kernel thread vs. a userspace thread.  Why would
there be a 60% performance difference between the two?  That doesn't
make any sense.

There's got to be a better justification for putting this in the kernel
than just that we can.

I completely understand why Christoph's suggestion of submitting BIOs
directly would be faster.  There's no way to do that in userspace.

Regards,

Anthony Liguori

>
> -- 
> MST

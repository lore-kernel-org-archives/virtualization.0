From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Mon, 9 Nov 2009 17:38:39 +0530
Message-ID: <20091109120839.GA11256__29785.2186290131$1257768643$gmane$org@amit-x200.redhat.com>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<1257266319-24300-2-git-send-email-amit.shah@redhat.com>
	<200911061740.03734.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911061740.03734.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hey Rusty,

On (Fri) Nov 06 2009 [17:40:02], Rusty Russell wrote:
> On Wed, 4 Nov 2009 03:08:39 am Amit Shah wrote:
> > Expose multiple char devices ("ports") for simple communication
> > between the host userspace and guest.
> 
> OK, I've taken the chance to audit this patch.  I started adding patches
> until I got overwhelmed.   It's a complete mess and needs a total rewrite :(
> 
> This shows the problem with feeding me a complete driver rewrite in one
> big hit.  You've combined lots of changes and techniques in here at once:

I'm really sorry for dumping this all at once.

I've separated out the patches for easier reviewing, the result passes
my tests but I'm going to give them some more time to run.

> Less important nitpicks:

...

> 3) Don't use list_for_each_safe() to get the head entry of a list.  Your
>    use is buggy anyway: buf will never be NULL afterwards.

As long as 'head' isn't the only node in the list we should loop. And
list_foreach_safe() does that. So it's OK right?

> In summary: this is the one we're going to throw away.
> 
> Now I'm going to start again, one patch at a time, and see how that works.

I'm sorry for having created more work for you; I'll send out my patches
to you in a couple of days.

Thanks!
		Amit

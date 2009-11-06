From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v10 1/1] virtio_console: Add support for multiple ports
	for generic guest and host communication
Date: Fri, 6 Nov 2009 17:40:02 +1030
Message-ID: <200911061740.03734.rusty__23450.2898333178$1257491486$gmane$org@rustcorp.com.au>
References: <1257266319-24300-1-git-send-email-amit.shah@redhat.com>
	<1257266319-24300-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257266319-24300-2-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 4 Nov 2009 03:08:39 am Amit Shah wrote:
> Expose multiple char devices ("ports") for simple communication
> between the host userspace and guest.

OK, I've taken the chance to audit this patch.  I started adding patches
until I got overwhelmed.   It's a complete mess and needs a total rewrite :(

This shows the problem with feeding me a complete driver rewrite in one
big hit.  You've combined lots of changes and techniques in here at once:

1) Moved work out of interrupt handlers and into work_struct.
2) Encapsulated the buffer information in a structure.
3) Added an optional header to the buffer(s).
4) Added control messages.
5) Encapsulated the per-port information into a structure.
6) Allocated a static buffer pool of over 4MB (!)
7) Added an ad-hoc throttling mechanism.
8) Added debugfs support.

Less important nitpicks:
1) Don't call a struct list_head 'next', it confused the crap out of me.
   Call it list or some other non-name.
2) Don't call control messages "internal".  Use ONE good name, ie. control.
3) Don't use list_for_each_safe() to get the head entry of a list.  Your
   use is buggy anyway: buf will never be NULL afterwards.

In summary: this is the one we're going to throw away.

Now I'm going to start again, one patch at a time, and see how that works.

Sorry,
Rusty.

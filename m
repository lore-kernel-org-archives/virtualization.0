From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: INDIRECT and NEXT
Date: Thu, 22 Oct 2009 11:37:45 +0200
Message-ID: <20091022093745.GA27765@redhat.com>
References: <20091004143734.GB17578@redhat.com>
	<200910191304.20748.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200910191304.20748.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 19, 2009 at 01:04:20PM +1030, Rusty Russell wrote:
> On Mon, 5 Oct 2009 01:07:34 am Michael S. Tsirkin wrote:
> > Hi!
> > I note that chaining INDIRECT descriptors with NEXT
> > currently is broken in lguest, because current
> > ring index gets overwritten.
> 
> I agree this should be fixed, but not quite sure what you're referring to.
> 
> I could force indirect and reproduce it, but I figure asking you for details
> would be more efficient :)
> 
> Thanks!
> Rusty.

I refer to this code in lguest:

	/*
	 * If this is an indirect entry, then this buffer contains a descriptor
	 * table which we handle as if it's any normal descriptor chain.
	 */
	if (desc[i].flags & VRING_DESC_F_INDIRECT) {
		if (desc[i].len % sizeof(struct vring_desc))
			errx(1, "Invalid size for indirect buffer table");

		max = desc[i].len / sizeof(struct vring_desc);
		desc = check_pointer(desc[i].addr, desc[i].len);
		i = 0;
	}

	do {
		/* Grab the first descriptor, and check it's OK. */
		iov[*out_num + *in_num].iov_len = desc[i].len;
		iov[*out_num + *in_num].iov_base
			= check_pointer(desc[i].addr, desc[i].len);
		/* If this is an input descriptor, increment that count. */
		if (desc[i].flags & VRING_DESC_F_WRITE)
			(*in_num)++;
		else {
			/*
			 * If it's an output descriptor, they're all supposed
			 * to come before any input descriptors.
			 */
			if (*in_num)
				errx(1, "Descriptor has out after in");
			(*out_num)++;
		}

		/* If we've got too many, that implies a descriptor loop. */
		if (*out_num + *in_num > max)
			errx(1, "Looped descriptor");
	} while ((i = next_desc(desc, i, max)) != max);

Imagine an indirect entry where NEXT bit is also set.
This would be useful for when we can't fit a descriptor
in a single indirect entry. This won't work now because
we set 'i = 0' above. A solution would be to move handling
indirect entry out to a separate function.

-- 
MST

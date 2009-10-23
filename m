From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: INDIRECT and NEXT
Date: Fri, 23 Oct 2009 14:01:23 +1030
Message-ID: <200910231401.24419.rusty@rustcorp.com.au>
References: <20091004143734.GB17578@redhat.com>
	<200910191304.20748.rusty@rustcorp.com.au>
	<20091022093745.GA27765@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091022093745.GA27765@redhat.com>
Content-Disposition: inline
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
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Oct 2009 08:07:45 pm Michael S. Tsirkin wrote:
> Imagine an indirect entry where NEXT bit is also set.

Hmm, so it's not obvious whether the kvm userspace code handles it
correctly either.

Want to hack something up to use NEXT + INDIRECT, then we can actually test
it?  If it doesn't work, this will have to be a new feature bit.

Also, we have a limitation that you can't have more descriptors than the ring
size, even with indirect, due to overzealous checks...

Thanks,
Rusty.

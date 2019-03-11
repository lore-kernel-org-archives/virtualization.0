From: Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Mon, 11 Mar 2019 15:45:27 +0100
Message-ID: <20190311144527.GM11553__9584.72826039127$1552315539$gmane$org@quack2.suse.cz>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190306092837-mutt-send-email-mst@kernel.org>
	<15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
	<20190307101708-mutt-send-email-mst@kernel.org>
	<20190307190910.GE3835@redhat.com>
	<20190307193838.GQ23850@redhat.com>
	<20190307201722.GG3835@redhat.com>
	<20190307212717.GS23850@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190307212717.GS23850@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu 07-03-19 16:27:17, Andrea Arcangeli wrote:
> > driver that GUP page for hours/days/weeks/months ... obviously the
> > race window is big enough here. It affects many fs (ext4, xfs, ...)
> > in different ways. I think ext4 is the most obvious because of the
> > kernel log trace it leaves behind.
> > 
> > Bottom line is for set_page_dirty to be safe you need the following:
> >     lock_page()
> >     page_mkwrite()
> >     set_pte_with_write()
> >     unlock_page()
> 
> I also wondered why ext4 writepage doesn't recreate the bh if they got
> dropped by the VM and page->private is 0. I mean, page->index and
> page->mapping are still there, that's enough info for writepage itself
> to take a slow path and calls page_mkwrite to find where to write the
> page on disk.

There are two problems:

1) What to do with errors that page_mkwrite() can generate (ENOMEM, ENOSPC,
EIO). On page fault you just propagate them to userspace, on set_page_dirty()
you have no chance so you just silently loose data.

2) We need various locks to protect page_mkwrite(), possibly do some IO.
set_page_dirty() is rather uncertain context to acquire locks or do IO...

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

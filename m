From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Fri, 8 Mar 2019 14:11:08 -0500
Message-ID: <20190308191108.GA26923__41402.4598941737$1552072285$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190306092837-mutt-send-email-mst@kernel.org>
	<15105894-4ec1-1ed0-1976-7b68ed9eeeda@redhat.com>
	<20190307101708-mutt-send-email-mst@kernel.org>
	<20190307190910.GE3835@redhat.com>
	<20190307193838.GQ23850@redhat.com>
	<20190307201722.GG3835@redhat.com>
	<20190307212717.GS23850@redhat.com>
	<671c4a98-4699-836e-79fc-0ce650c7f701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <671c4a98-4699-836e-79fc-0ce650c7f701@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 08, 2019 at 05:13:26PM +0800, Jason Wang wrote:
> Actually not wrapping around,=A0 the pages for used ring was marked as =

> dirty after a round of virtqueue processing when we're sure vhost wrote =

> something there.

Thanks for the clarification. So we need to convert it to
set_page_dirty and move it to the mmu notifier invalidate but in those
cases where gup_fast was called with write=3D1 (1 out of 3).

If using ->invalidate_range the page pin also must be removed
immediately after get_user_pages returns (not ok to hold the pin in
vmap until ->invalidate_range is called) to avoid false positive gup
pin checks in things like KSM, or the pin must be released in
invalidate_range_start (which is called before the pin checks).

Here's why:

		/*
		 * Check that no O_DIRECT or similar I/O is in progress on the
		 * page
		 */
		if (page_mapcount(page) + 1 + swapped !=3D page_count(page)) {
			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
			goto out_unlock;
		}
		[..]
		set_pte_at_notify(mm, pvmw.address, pvmw.pte, entry);
			  ^^^^^^^ too late release the pin here, the
				  above already failed

->invalidate_range cannot be used with mutex anyway so you need to go
back with invalidate_range_start/end anyway, just the pin must be
released in _start at the latest in such case.

My prefer is generally to call gup_fast() followed by immediate
put_page() because I always want to drop FOLL_GET from gup_fast as a
whole to avoid 2 useless atomic ops per gup_fast.

I'll write more about vmap in answer to the other email.

Thanks,
Andrea

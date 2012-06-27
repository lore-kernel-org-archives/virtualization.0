From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] Add a page cache-backed balloon device driver.
Date: Wed, 27 Jun 2012 15:10:46 +0530
Message-ID: <20120627094046.GE19023@amit.redhat.com>
References: <1340742778-11282-1-git-send-email-fes@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1340742778-11282-1-git-send-email-fes@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Frank Swiderski <fes@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, riel@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, mikew@google.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) 26 Jun 2012 [13:32:58], Frank Swiderski wrote:
> This implementation of a virtio balloon driver uses the page cache to
> "store" pages that have been released to the host.  The communication
> (outside of target counts) is one way--the guest notifies the host when
> it adds a page to the page cache, allowing the host to madvise(2) with
> MADV_DONTNEED.  Reclaim in the guest is therefore automatic and implicit
> (via the regular page reclaim).  This means that inflating the balloon
> is similar to the existing balloon mechanism, but the deflate is
> different--it re-uses existing Linux kernel functionality to
> automatically reclaim.

This is a good idea for a guest co-operative balloon driver.  I don't
think it'll replace the original driver.  The traditional balloon
model is essentially driven by the host to increase guest density on
the host.  This driver can't work in that case.  However, using both
the types of drivers will be helpful, as unused pages on the guest
will be able to be used by the host.

Balbir Singh had done some work earlier on a guest co-operative
balloon driver, but AFAIR it was with modification of the existing
virtio-balloon driver.

I don't think a separate driver is necessary for the functionality,
though.  Perhaps just a new config space item which mentions how many
pages are present in the page cache, so that host do some accounting
as well.

		Amit

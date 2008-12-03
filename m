From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/2] virtio: block: set max_segment_size and
	max_sectors to infinite.
Date: Wed, 3 Dec 2008 10:43:21 -0800
Message-ID: <20081203184321.GC19628@sequoia.sous-sol.org>
References: <200811141215.33950.rusty@rustcorp.com.au>
	<20081114093023.GQ26778@kernel.dk>
	<200811171722.43792.rusty@rustcorp.com.au>
	<200811171724.15682.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200811171724.15682.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> Setting max_segment_size allows more than 64k per sg element, unless
> the host specified a limit.  Setting max_sectors indicates that our
> max_hw_segments is the only limit.

We had been using a simple hardocded constant to increase max sectors to
improve throughput.  This (along with 2/2) are tested and showing nice numbers.

Acked-by: Chris Wright <chrisw@sous-sol.org>

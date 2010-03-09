From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/2] virtio: console: Trivial fixes based on review
	comments
Date: Tue, 9 Mar 2010 09:25:56 +0530
Message-ID: <20100309035556.GA18898@amit-x200.redhat.com>
References: <1268038020-12539-1-git-send-email-amit.shah@redhat.com>
	<20100308212319.GA13886@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100308212319.GA13886@redhat.com>
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
Cc: virtualization@linux-foundation.org, quintela@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Mar 08 2010 [23:23:20], Michael S. Tsirkin wrote:
> On Mon, Mar 08, 2010 at 02:16:58PM +0530, Amit Shah wrote:
> > Hello,
> > 
> > Here are a couple of small fixes for the virtio_console code, it's mostly
> > stylistic fixes.
> > 
> > Michael, can you push these to Linus? Thanks.
> 
> We are in fixes only mode now. Does the first patch fix a bug,
> or is it cosmetic only?

No, it's not a bug fix. The value written to 'len' is write-only, we
never read from it.

		Amit

From: Marcelo Tosatti <marcelo@kvack.org>
Subject: Re: [kvm-devel] [PATCH] kvm guest balloon driver
Date: Wed, 9 Jan 2008 09:14:32 -0200
Message-ID: <20080109111432.GB24900__13432.905675336$1199877631$gmane$org@dmt>
References: <20080108153356.GA21726@dmt> <478399D5.9030707@codemonkey.ws>
	<20080109100621.GL6958@v2.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080109100621.GL6958@v2.random>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrea Arcangeli <andrea@qumranet.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 09, 2008 at 11:06:21AM +0100, Andrea Arcangeli wrote:
> On Tue, Jan 08, 2008 at 09:42:13AM -0600, Anthony Liguori wrote:
> > Instead of allocating a node for each page, you could use page->private 
> 
> page->lru is probably better for this so splice still works
> etc... (the struct page isn't visible to the guest VM so it's free to
> use)

Yeap, that works.

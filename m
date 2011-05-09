From: Christoph Hellwig <hch@infradead.org>
Subject: Re: various vmbus review comments
Date: Mon, 9 May 2011 10:33:52 -0400
Message-ID: <20110509143352.GB29635@infradead.org>
References: <20110503204641.GA11132@kroah.com>
	<6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
	<20110504163228.GA19754@kroah.com>
	<6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 06, 2011 at 01:10:38PM +0000, KY Srinivasan wrote:
> I audited the block and the net drivers. As part of their exit routine,
> they invoke vmbus_child_driver_unregister() after properly cleaning
> up all the devices they are managing. Do you still see an issue with
> regards to module reference counting.

Which is not the correct thing to do as explained in my last round
of reviews.  Take a look at the PCI code - the functional driver only
does a foo_untegister_driver (which maps almost directly to
driver_unregister), which then causes the device core to unbind the
devices.  The function driver must never call device_unregister
directly as the device continues to exist even if no driver is bound to
it.
